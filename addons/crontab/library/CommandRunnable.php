<?php

namespace addons\crontab\library;

use fast\Http;
use think\Config;
use think\Db;

class CommandRunnable implements \Jenner\SimpleFork\Runnable
{
    protected $connect = null;
    protected $crontab = null;

    public function __construct($crontab)
    {
        $this->crontab = $crontab;
    }

    public function run()
    {
        $processId = getmypid();

        //这里需要强制重连数据库,使用已有的连接会报2014错误
        $this->connect = Db::connect([], true);
        $this->connect->execute("SELECT 1");

        $message = '';
        $result = false;
        $this->crontabLog = null;
        $log = [
            'crontab_id'   => $this->crontab['id'],
            'executetime'  => time(),
            'completetime' => null,
            'content'      => '',
            'processid'    => $processId,
            'status'       => 'inprogress',
        ];
        $this->connect->name("crontab_log")->insert($log);
        $this->crontabLogId = $this->connect->getLastInsID();
        try {
            if ($this->crontab['type'] == 'url') {
                if (substr($this->crontab['content'], 0, 1) == "/") {
                    // 本地项目URL
                    $message = shell_exec('php ' . ROOT_PATH . 'public/index.php ' . $this->crontab['content']);
                    $result = (bool)$message;
                } else {
                    $arr = explode(" ", $this->crontab['content']);
                    $url = $arr[0];
                    $params = $arr[1] ?? '';
                    $method = $arr[2] ?? 'POST';
                    try {
                        // 远程异步调用URL
                        $ret = Http::sendRequest($url, $params, $method);
                        $result = $ret['ret'];
                        $message = $ret['msg'];
                    } catch (\Exception $e) {
                        $message = $e->getMessage();
                    }
                }

            } elseif ($this->crontab['type'] == 'sql') {
                $ret = $this->sql($this->crontab['content']);
                $result = $ret['ret'];
                $message = $ret['msg'];
            } elseif ($this->crontab['type'] == 'shell') {
                // 执行Shell
                $message = shell_exec($this->crontab['content']);
                $result = !is_null($message);
            }
        } catch (\Exception $e) {
            $message = $e->getMessage();
        }

        //设定任务完成
        $this->connect->name("crontab_log")->where('id', $this->crontabLogId)->update(['content' => $message, 'completetime' => time(), 'status' => $result ? 'success' : 'failure']);
    }

    /**
     * 执行SQL语句
     */
    protected function sql($sql)
    {

        // 执行SQL
        $sqlquery = str_replace('__PREFIX__', config('database.prefix'), $sql);
        $sqls = preg_split("/;[ \t]{0,}\n/i", $sqlquery);

        $result = false;
        $message = '';
        $this->connect->startTrans();
        try {
            foreach ($sqls as $key => $val) {
                if (trim($val) == '' || substr($val, 0, 2) == '--' || substr($val, 0, 2) == '/*') {
                    continue;
                }
                $message .= "\nSQL:{$val}\n";
                $val = rtrim($val, ';');
                if (preg_match("/^(select|explain)(.*)/i ", $val)) {
                    $count = $this->connect->execute($val);
                    if ($count > 0) {
                        $resultlist = Db::query($val);
                    } else {
                        $resultlist = [];
                    }

                    $message .= "Total:{$count}\n";
                    $j = 1;
                    foreach ($resultlist as $m => $n) {
                        $message .= "\n";
                        $message .= "Row:{$j}\n";
                        foreach ($n as $k => $v) {
                            $message .= "{$k}：{$v}\n";
                        }
                        $j++;
                    }
                } else {
                    $count = $this->connect->getPdo()->exec($val);
                    $message = "Affected rows:{$count}";
                }
            }
            $this->connect->commit();
            $result = true;
        } catch (\PDOException $e) {
            $message = $e->getMessage();
            $this->connect->rollback();
            $result = false;
        }
        return ['ret' => $result, 'msg' => $message];
    }
}
