<?php

namespace addons\crontab\controller;

use addons\crontab\model\Crontab;
use Cron\CronExpression;
use fast\Http;
use think\Controller;
use think\Db;
use think\Exception;
use think\Log;

/**
 * 定时任务接口
 *
 * 以Crontab方式每分钟定时执行,且只可以Cli方式运行
 * @internal
 */
class Autotask extends Controller
{

    /**
     * 初始化方法,最前且始终执行
     */
    public function _initialize()
    {
        // 只可以以cli方式执行
        if (!$this->request->isCli()) {
            $this->error('Autotask script only work at client!');
        }

        parent::_initialize();

        // 清除错误
        error_reporting(0);

        // 设置永不超时
        set_time_limit(0);
    }

    /**
     * 执行定时任务
     */
    public function index()
    {
        $withPcntl = false;
        $pool = null;

        $config = get_addon_config('crontab');
        $mode = $config['mode'] ?? 'pcntl';
        if ($mode == 'pcntl' && function_exists('pcntl_fork')) {
            $withPcntl = true;
            $pool = new \Jenner\SimpleFork\Pool();
        }

        $time = time();
        $logDir = LOG_PATH . 'crontab' . DS;
        if (!is_dir($logDir)) {
            mkdir($logDir, 0755);
        }
        //筛选未过期且未完成的任务
        $crontabList = Crontab::where('status', '=', 'normal')->order('weigh DESC,id DESC')->select();
        $execTime = time();
        foreach ($crontabList as $crontab) {
            $update = [];
            $execute = false;
            if ($time < $crontab['begintime']) {
                //任务未开始
                continue;
            }
            if ($crontab['maximums'] && $crontab['executes'] > $crontab['maximums']) {
                //任务已超过最大执行次数
                $update['status'] = 'completed';
            } else {
                if ($crontab['endtime'] > 0 && $time > $crontab['endtime']) {
                    //任务已过期
                    $update['status'] = 'expired';
                } else {
                    //重复执行
                    //如果未到执行时间则继续循环
                    $cron = CronExpression::factory($crontab['schedule']);
                    if (!$cron->isDue() || ($crontab['executetime'] && date("YmdHi", $execTime) === date("YmdHi", $crontab['executetime']))) {
                        continue;
                    }
                    $execute = true;
                }
            }

            // 如果允许执行
            if ($execute) {
                $update['executetime'] = $time;
                $update['executes'] = $crontab['executes'] + 1;
                $update['status'] = ($crontab['maximums'] > 0 && $update['executes'] >= $crontab['maximums']) ? 'completed' : 'normal';
            }

            // 如果需要更新状态
            if (!$update) {
                continue;
            }
            // 更新状态
            $crontab->save($update);
            Db::connect()->close();
            // 将执行放在后面是为了避免超时导致多次执行
            if (!$execute) {
                continue;
            }

            $runnable = new \addons\crontab\library\CommandRunnable($crontab);
            if ($withPcntl) {
                $process = new \Jenner\SimpleFork\Process($runnable);
                $name = $crontab['title'];
                $pool->execute($process);
            } else {
                $runnable->run();
            }

        }
        if ($withPcntl && $pool) {
            $pool->wait();
        }
        return "Execute completed!\n";
    }


}
