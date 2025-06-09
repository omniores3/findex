<?php

namespace app\admin\controller\famysql;

use app\common\controller\Backend;
use addons\famysql\library\Backup;
use think\Db;
use think\Config;
use think\Exception;
use think\exception\PDOException;
use ZipArchive;


/**
 * 数据库管理
 *
 * @icon fa fa-database
 * @remark 可在线进行数据库表优化或修复,查看表结构和数据等
 */
class Table extends Backend
{
    protected $dbName = '';

    protected $prefix = '';

    protected $noNeedRight = ['selectnames', 'getCollation', 'get_table_list', 'check'];

    /**
     * 读取字符集
     * @return array
     */
    protected $charsetList = ['utf8mb4', 'utf8', 'latin1', 'utf16'];

    /**
     * 读取排序规则
     * @return array
     */
    protected $collationList = [
        'utf8mb4' => ['utf8mb4_general_ci', 'utf8mb4_unicode_ci'],
        'utf8' => ['utf8_general_ci', 'utf8_unicode_ci'],
        'latin1' => ['latin1_general_ci'],
        'utf16' => ['utf16_general_ci', 'utf16_unicode_ci'],
    ];

    public function _initialize()
    {
        parent::_initialize();
        if (!config("app_debug")) {
            $this->error("数据库管理插件只允许在开发环境下使用");
        }
        if (!$this->auth->isSuperAdmin()) {
            $this->error(__('Access is allowed only to the super management group'));
        }
        $this->dbName = Config::get("database.database");
        $this->prefix = Config::get('database.prefix');
        $this->view->assign("charsetList", $this->charsetList);
        $this->view->assign("groups", $this->getGroups(true));
        $this->view->assign("groupsList", $this->getGroups());
    }

    /**
     * 查看
     */
    public function index()
    {
        $group = $this->request->get("group");
        $offset = $this->request->get("offset");
        $limit = $this->request->get("limit");
        $config = get_addon_config('famysql');
        if ($this->request->isAjax()) {
            $group = $group ?? 'system';
            $tables = $this->getTables($group);

            $list = [];
            if (count($tables) > 0) {
                $tableInfos = [];
                foreach ($tables as $k => $v) {
                    $tableInfos[] = Db::table("information_schema.TABLES")->field("*")->where(['TABLE_SCHEMA' => $this->dbName, 'TABLE_NAME' => $v])->find();
                }

                $i = 1;
                foreach ($tableInfos as $key => $tableInfo) {
                    $list[$key]['id'] = $i++;
                    $list[$key]['group'] = $group;
                    $list[$key]['is_admin'] = ($group == 'system' && !$config['is_admin']) ? 0 : 1;
                    $list[$key]['is_has'] = $this->prefix !== '' ? 1 : 0;
                    $list[$key]['name'] = $tableInfo['TABLE_NAME'];
                    $list[$key]['engine'] = $tableInfo['ENGINE'];
                    $list[$key]['rows'] = Db::table($tableInfo['TABLE_NAME'])->count();
                    $list[$key]['field_nums'] = count(Db::getFields($tableInfo['TABLE_NAME']));
                    $list[$key]['charset'] = substr($tableInfo['TABLE_COLLATION'], 0, strpos($tableInfo['TABLE_COLLATION'], '_'));
                    $list[$key]['collation'] = $tableInfo['TABLE_COLLATION'];
                    $list[$key]['comment'] = $tableInfo['TABLE_COMMENT'];
                    $list[$key]['createtime'] = $tableInfo['CREATE_TIME'];
                    $list[$key]['updatetime'] = $tableInfo['UPDATE_TIME'];
                }
            }

            $result = array("total" => count($list), "rows" => array_slice($list, $offset, $limit));
            return json($result);
        }
        $this->view->assign("group", $group);
        $this->assignconfig("group", $group);
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function table_add()
    {
        $group = $this->request->get("group");
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = [];
                $name = $this->prefix . $params['addon'] . '_' . $params['name'];
                Db::startTrans();
                try {
                    $sql = "SHOW TABLES LIKE '{$name}'";
                    $result = Db::query($sql);
                    if ($result) {
                        $this->error("表 {$name} 已存在于数据库 {$this->dbName} 中");
                    } else {
                        //在此执行创建表的操作
                        $sql = "CREATE TABLE IF NOT EXISTS `{$name}` (
                                    `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
                                    PRIMARY KEY (`id`)
                                ) ENGINE={$params['engine']} DEFAULT CHARSET={$params['charset']} COLLATE={$params['collation']} COMMENT='" . $params['comment'] . "';";

                        $result = Db::execute($sql);
                    }

                    if (Db::getPdo()->inTransaction() == true) {
                        Db::commit();
                    }
                    $this->success();
                } catch (\think\exception\PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (\think\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
        }
        $this->view->assign("group", $group);
        return $this->view->fetch();
    }

    /**
     * 快速建表
     */
    public function table_batch_add()
    {
        $group = $this->request->get("group");
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = [];
                $prefix = $this->prefix . $params['addon'] . '_';
                Db::startTrans();
                try {
                    $templates = $this->template();
                    $names = explode(',', $params['name']);
                    foreach ($templates as $template) {
                        if (in_array($template['table_name'], $names)) {
                            $sql[] = str_replace("__PREFIX__", $prefix, $template['sql']) . ";";
                        }
                    }
                    $result = Db::batchQuery($sql);
                    if (!$result) {
                        $this->error();
                    }
                    if (Db::getPdo()->inTransaction() == true) {
                        Db::commit();
                    }
                    $this->success();
                } catch (\think\exception\PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (\think\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $this->view->assign("group", $group);
        return $this->view->fetch();
    }

    /**
     * 备份列表
     */
    public function backuplist()
    {
        $group = $this->request->get("group");
        $offset = $this->request->get("offset");
        $limit = $this->request->get("limit");
        if ($this->request->isAjax()) {
            $filter = $this->request->request("filter", '', 'trim');
            $filter = (array) json_decode($filter, true);
            $addon = !isset($filter['addon']) ? 'all' : $filter['addon'];
            $type = !isset($filter['type']) ? 'all' : $filter['type'];
            $backupDir = ADDON_PATH . 'famysql' . DS . 'backup' . DS;

            $backuplist = [];
            $files = [];
            foreach (glob($backupDir . "*.*") as $key => $filename) {
                $basename = basename($filename);
                $file_arr = stripos($basename, '-') !== FALSE ? explode('-', $basename) : $basename;
                $_addon = (is_array($file_arr) && $file_arr[0] == 'backup') ? $file_arr[2] : 'all';
                $_type = (is_array($file_arr) && $file_arr[0] == 'backup') ? $file_arr[3] : 'all';
                $time = filemtime($filename);

                if (!in_array($basename, $files)) {
                    $backuplist[$time] =
                        [
                            'file' => $basename,
                            'addon' => $_addon,
                            'addon_name' => $_addon !== 'all' ? get_addon_info($_addon)['title'] : '全部',
                            'type' => $_type,
                            'date' => date("Y-m-d H:i:s", $time),
                            'size' => format_bytes(filesize($filename))
                        ];
                    array_push($files, $basename);
                    if ($addon !== 'all' && $addon !== $_addon) {
                        unset($backuplist[$time]);
                    } elseif ($type !== 'all' && $type !== $_type) {
                        unset($backuplist[$time]);
                    }
                }
            }
            krsort($backuplist);

            $result = array("total" => count($backuplist), "rows" => array_slice($backuplist, $offset, $limit));
            return json($result);
        }
        $this->view->assign("group", $group);
        $this->assignconfig("group", $group);
        return $this->view->fetch();
    }

    /**
     * 备份下载
     */
    public function download()
    {
        $file = $this->request->request('file');
        $backupDir = ADDON_PATH . 'famysql' . DS . 'backup' . DS;
        if (!preg_match("/^backup\-([a-z0-9\-_\.]+)\.zip$/i", $file)) {
            $this->error(__("Invalid parameters"));
        }
        $file = $backupDir . $file;
        if (!is_file($file)) {
            $this->error(__('File not found'));
        } else {
            header('Content-Type:text/html;charset=utf-8');
            header('Content-disposition:attachment; filename=' . basename($file));
            $result = readfile($file);
            header('Content-length:' . filesize($file));
            $this->success(__('Download completed'));
        }
    }

    /**
     * 恢复
     */
    public function restore($ids = '')
    {
        $backupDir = ADDON_PATH . 'famysql' . DS . 'backup' . DS;
        if ($this->request->isPost()) {
            $action = $this->request->request('action');
            $file = $this->request->request('file');
            if (!preg_match("/\.(zip|sql?)$/", $file)) {
                $this->error(__("Invalid parameters"));
            }
            $file = $backupDir . $file;
            $ext = pathinfo($file, PATHINFO_EXTENSION);
            if ($action == 'restore') {
                if (!class_exists('ZipArchive')) {
                    $this->error(__("Zip tips 1"));
                }
                try {
                    if ($ext == 'zip') {
                        $dir = RUNTIME_PATH . 'database' . DS;
                        if (!is_dir($dir)) {
                            @mkdir($dir, 0755);
                        }

                        $zip = new ZipArchive;
                        if ($zip->open($file) !== true) {
                            throw new Exception(__('Can not open zip file'));
                        }
                        if (!$zip->extractTo($dir)) {
                            $zip->close();
                            throw new Exception(__('Can not unzip file'));
                        }
                        $zip->close();
                        $filename = basename($file);
                        $sqlFile = $dir . str_replace('.zip', '.sql', $filename);
                    } else {
                        $sqlFile = $file;
                    }

                    if (!is_file($sqlFile)) {
                        throw new Exception(__('Sql file not found'));
                    }
                    $filesize = filesize($sqlFile);
                    $list = Db::query('SELECT @@global.max_allowed_packet');
                    if (isset($list[0]['@@global.max_allowed_packet']) && $filesize >= $list[0]['@@global.max_allowed_packet']) {
                        Db::execute('SET @@global.max_allowed_packet = ' . ($filesize + 1024));
                        //throw new Exception('备份文件超过配置max_allowed_packet大小，请修改Mysql服务器配置');
                    }
                    $sql = file_get_contents($sqlFile);

                    Db::clear();
                    //必须重连一次
                    Db::connect([], true)->query("select 1");
                    Db::getPdo()->exec($sql);
                } catch (Exception $e) {
                    $this->error($e->getMessage());
                } catch (PDOException $e) {
                    $this->error($e->getMessage());
                }
                $this->success(__('Restore successful'));
            } elseif ($action == 'delete') {
                unlink($file);
                $this->success(__('Delete successful'));
            }
        }
    }

    /**
     * 备份
     */
    public function backup()
    {
        $group = $this->request->get("group");
        $backupDir = ADDON_PATH . 'famysql' . DS . 'backup' . DS;
        if ($this->request->isPost()) {
            $params = $this->request->post('row/a');
            $tableList = [];
            $list = \think\Db::query("SHOW TABLES");
            foreach ($list as $key => $row) {
                if ($params['addon'] == 'all') {
                    $tableList[] = reset($row);
                } else {
                    $tmp = explode('_', reset($row));
                    if ($this->prefix !== '' && $tmp[1] == $params['addon']) {
                        $tableList[] = reset($row);
                    } elseif ($this->prefix == '' && $tmp[0] == $params['addon']) {
                        $tableList[] = reset($row);
                    }
                }
            }
            if (!class_exists('ZipArchive')) {
                $this->error(__("Zip tips 2"));
            }
            $database = config('database');
            try {
                $backup = new Backup($database['hostname'], $database['username'], $database['database'], $database['password'], $database['hostport']);
                $backup->setTable($tableList)->setIgnoreTable($params['ignore_tables'])->backup($params['addon'], $params['type'], $backupDir);
            } catch (Exception $e) {
                $this->error($e->getMessage());
            }
            $this->success(__('Backup successful'));
        }
        $this->view->assign("group", $group);
        return $this->view->fetch();
    }

    /**
     * 上传文件
     */
    public function upload()
    {
        $group = $this->request->get("group");
        //默认普通上传文件
        $file = $this->request->file('file');
        $backupDir = ADDON_PATH . 'famysql' . DS . 'backup' . DS;
        if ($file) {
            try {
                $info = $file->rule('uniqid')->move($backupDir, $file->getInfo()['name']);
                if ($info) {
                    $this->success(__('Uploaded successful'));
                }
            } catch (Exception $e) {
                $this->error($file->getError());
            }
        }
    }

    /**
     * 字段选择
     * @internal
     */
    public function selectnames()
    {
        //当前页
        $page = $this->request->request("pageNumber");
        //分页大小
        $pagesize = $this->request->request("pageSize");

        $q_word = (array) $this->request->request("q_word/a");

        $word = $q_word[0];

        $custom = (array) $this->request->request("custom/a");
        if ($custom && is_array($custom)) {
            $addon = $custom['addon'];
        }

        $tables = $this->template();

        if (!empty($word)) {
            $res_arr = [];
            foreach ($tables as $table) {
                if (!in_array($this->prefix . $addon . '_' . $table['table_name'], $this->getTables($addon))) {
                    $res_arr[] = $table['table_name'] . '-' . $table['comment'];
                }
            }
            $res_arr = array_filter($res_arr, function ($v) use ($word) {
                return stripos($v, $word) !== false;
            });
            $res_arrs = array_values($res_arr);

            $tableLists_arr = [];
            foreach ($res_arrs as $res) {
                $tableLists_arr[] = [
                    'table_name' => explode('-', $res)[0],
                    'comment' => explode('-', $res)[1]
                ];
            }
            $tables = $tableLists_arr;
        } else {
            $res_arr = [];
            foreach ($tables as $table) {
                if (!in_array($this->prefix . $addon . '_' . $table['table_name'], $this->getTables($addon))) {
                    $res_arr[] = $table['table_name'] . '-' . $table['comment'];
                }
            }
            $res_arrs = array_values($res_arr);

            $tableLists_arr = [];
            foreach ($res_arrs as $res) {
                $tableLists_arr[] = [
                    'table_name' => explode('-', $res)[0],
                    'comment' => explode('-', $res)[1]
                ];
            }
            $tables = $tableLists_arr;
        }

        $result = array("total" => count($tables), "list" => array_slice($tables, ($page - 1) * $pagesize, $pagesize));

        return json($result);
    }

    /**
     * 编辑
     */
    public function table_edit()
    {
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }
        $tableInfo = Db::table("information_schema.TABLES")->field("*")->where(['TABLE_SCHEMA' => $this->dbName, 'TABLE_NAME' => $name])->find();
        $row['name'] = $tableInfo['TABLE_NAME'];
        $row['engine'] = $tableInfo['ENGINE'];
        $row['charset'] = substr($tableInfo['TABLE_COLLATION'], 0, strpos($tableInfo['TABLE_COLLATION'], '_'));
        $row['collation'] = $tableInfo['TABLE_COLLATION'];
        $row['comment'] = $tableInfo['TABLE_COMMENT'];

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = [];
                Db::startTrans();
                try {
                    if ($params['comment'] != $row['comment'])
                        $sql[] = "ALTER TABLE  `{$name}` COMMENT='{$params['comment']}'";
                    if ($params['engine'] != $row['engine'])
                        $sql[] = "ALTER TABLE  `{$name}` ENGINE='{$params['engine']}'";
                    if ($params['charset'] != $row['charset'])
                        $sql[] = "ALTER TABLE `{$name}` CONVERT TO CHARACTER SET '{$params['charset']}' COLLATE '{$params['collation']}'";
                    if ($params['collation'] != $row['collation'])
                        $sql[] = "ALTER TABLE `{$name}` CONVERT TO CHARACTER SET '{$params['charset']}' COLLATE '{$params['collation']}'";
                    if ($params['name'] != $row['name'])
                        $sql[] = "ALTER TABLE  `{$name}`  RENAME TO  `{$params['name']}`;";

                    $result = Db::batchQuery($sql);
                    if (Db::getPdo()->inTransaction() == true) {
                        Db::commit();
                    }
                } catch (\think\exception\PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (\think\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $this->view->assign("row", $row);
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function table_del()
    {
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }
        $result = false;
        Db::startTrans();
        try {
            $sql = "DROP TABLE IF EXISTS `{$name}`;";
            $result = Db::execute($sql);
            if (Db::getPdo()->inTransaction() == true) {
                Db::commit();
            }
        } catch (\think\exception\PDOException $e) {
            Db::rollback();
            $this->error($e->getMessage());
        } catch (\think\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result !== false) {
            $group = $this->prefix !== '' ? explode('_', $name)[1] : explode('_', $name)[0];
            $tables = $this->getTables($group);
            $this->success('删除成功', null, count($tables));
        } else {
            $this->error(__('No rows were deleted'));
        }
    }

    /**
     * 添加
     * @internal
     */
    public function add()
    {
        $this->error('禁止访问');
    }

    /**
     * 编辑
     * @param string $ids
     * @internal
     */
    public function edit($ids = null)
    {
        $this->error('禁止访问');
    }

    /**
     * 删除
     * @param string $ids
     * @internal
     */
    public function del($ids = null)
    {
        $this->error('禁止访问');
    }

    /**
     * 批量更新
     * @internal
     * @param string $ids
     * @return void
     */
    public function multi($ids = null)
    {
        $this->error('禁止访问');
    }

    /**
     * 截/断表
     */
    public function truncate()
    {
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', $name));
        }
        $result = false;
        Db::startTrans();
        try {
            $sql = "TRUNCATE TABLE `{$name}`;";
            $result = Db::execute($sql);
            if (Db::getPdo()->inTransaction() == true) {
                Db::commit();
            }
        } catch (\think\exception\PDOException $e) {
            Db::rollback();
            $this->error($e->getMessage());
        } catch (\think\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result !== false) {
            $this->success(__('Truncate table %s done', $name));
        } else {
            $this->error(__('Truncate table %s fail', $name));
        }
    }

    /**
     * 优化表
     */
    public function optimize()
    {
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', $name));
        }
        $result = false;
        Db::startTrans();
        try {
            $sql = "OPTIMIZE TABLE `{$name}`;";
            $result = Db::execute($sql);
            if (Db::getPdo()->inTransaction() == true) {
                Db::commit();
            }
        } catch (\think\exception\PDOException $e) {
            Db::rollback();
            $this->error($e->getMessage());
        } catch (\think\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result !== false) {
            $this->success(__('Optimize table %s done', $name));
        } else {
            $this->error(__('Optimize table %s fail', $name));
        }
    }

    /**
     * 修复表
     */
    public function repair()
    {
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', $name));
        }
        $result = false;
        Db::startTrans();
        try {
            $sql = "REPAIR TABLE `{$name}`;";
            $result = Db::execute($sql);
            if (Db::getPdo()->inTransaction() == true) {
                Db::commit();
            }
        } catch (\think\exception\PDOException $e) {
            Db::rollback();
            $this->error($e->getMessage());
        } catch (\think\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($result !== false) {
            $this->success(__('Repair table %s done', $name));
        } else {
            $this->error(__('Repair table %s fail', $name));
        }
    }

    /**
     * 复制表格/结构/数据
     */
    public function copy()
    {
        $name = $this->request->get('name');
        $type = $this->request->get('type');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', $name));
        }
        if ($this->request->isPost()) {
            $table = $this->request->post("table");
            if ($table) {
                $result = false;
                $sql = [];
                if ($this->prefix !== '' && strpos($table, $this->prefix) !== 0) {
                    $table = $this->prefix . $table;
                }
                Db::startTrans();
                try {
                    $_sql = "SHOW TABLES LIKE '{$table}'";
                    $result = Db::query($_sql);
                    if ($result) {
                        $this->error("表 {$table} 已存在于数据库 {$this->dbName} 中");
                    } else {
                        //在此执行复制表的操作
                        if ($type == 1) {
                            $sql[] = "CREATE TABLE `{$table}` LIKE `{$name}`;";
                        } else {
                            $sql[] = "CREATE TABLE `{$table}` LIKE `{$name}`;";
                            $sql[] = "INSERT INTO `{$table}` SELECT * FROM `{$name}`;";
                        }
                        $result = Db::batchQuery($sql);
                    }

                    if (Db::getPdo()->inTransaction() == true) {
                        Db::commit();
                    }
                    $this->success(__('Copy table %s done', $name));
                } catch (\think\exception\PDOException $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                } catch (\think\Exception $e) {
                    Db::rollback();
                    $this->error($e->getMessage());
                }
                if ($result !== false) {
                    $this->success(__('Copy table %s done', $name));
                } else {
                    $this->error(__('Copy table %s fail', $name));
                }
            }
            $this->error(__('Parameter %s can not be empty', $table));
        }
    }

    /**
     * 字符集
     * @internal
     */
    public function getCollation()
    {
        $custom = (array) $this->request->request("custom/a");
        $keyValue = $this->request->request('keyValue');
        if ($custom && is_array($custom)) {
            $charset = $custom['charset'];
        }

        if (!$keyValue) {
            $list = $this->collationList[$charset];
            foreach ($list as $k => $v) {
                $list[$k] = ['collation' => $v];
            }
        } else {
            $list[] = ['collation' => $keyValue];
        }


        $result = array("total" => count($list), "list" => $list);
        return json($result);
    }

    /**
     * 获取数据表
     * @internal
     */
    public function get_table_list()
    {
        //当前页
        $page = $this->request->request("pageNumber");
        //分页大小
        $pagesize = $this->request->request("pageSize");
        $custom = (array) $this->request->request("custom/a");
        $addon = 'all';
        if ($custom && is_array($custom)) {
            $addon = $custom['addon'];
        }

        $tableList = [];
        $list = \think\Db::query("SHOW TABLES");
        foreach ($list as $key => $row) {
            if ($addon == 'all') {
                $tableList[$key] = ['table_name' => reset($row)];
            } else {
                $tmp = explode('_', reset($row));
                if ($this->prefix !== '' && $tmp[1] == $addon) {
                    $tableList[] = ['table_name' => reset($row)];
                } elseif ($this->prefix == '' && $tmp[0] == $addon) {
                    $tableList[] = ['table_name' => reset($row)];
                }
            }
        }

        array_values($tableList);

        $result = array("total" => count($tableList), "rows" => array_slice($tableList, ($page - 1) * $pagesize, $pagesize));
        return json($result);
    }

    /**
     * 获取数据库表
     */
    protected function getTables($group = 'all')
    {
        $tables = Db::getTables();

        //数据表分组
        $addons = get_addon_list();
        $result = [];
        $result['system'] = [];
        foreach ($tables as $index => $table) {
            foreach ($addons as $key => $value) {
                $tmp = explode('_', $table);
                if ($this->prefix !== '' && $tmp[1] == $key) {
                    if ($value['state'] == 1) {
                        $result[$key][] = $table;
                    }
                    unset($tables[$index]);
                } elseif ($this->prefix == '' && $tmp[0] == $key) {
                    if ($value['state'] == 1) {
                        $result[$key][] = $table;
                    }
                    unset($tables[$index]);
                }
            }
        }
        $result['system'] = array_values($tables);
        return $group === 'all' ? $result : (isset($result[$group]) ? $result[$group] : []);
    }

    /**
     * 获取数据库分组
     */
    protected function getGroups($is_has = false)
    {
        $keyNames = array_keys($this->getTables());
        //数据表分组
        $addons = get_addon_list();
        $groups = [];
        foreach ($addons as $key => $value) {
            if ($value['state'] == 1 && !in_array($value['name'], ['famysql', 'fadeveloper'])) {
                $groups[$key] = $value['title'];
                if ($is_has && !in_array($key, $keyNames)) {
                    unset($groups[$key]);
                }
            }
        }
        return $groups;
    }

    private function template()
    {
        $sqlFile = ADDON_PATH . 'famysql' . DS . 'data' . DS . 'tables.ini';

        $file_handle = fopen($sqlFile, "r");
        $file_content = fread($file_handle, filesize($sqlFile));
        $sqls = explode(';', $file_content);
        array_pop($sqls);

        $result = [];
        foreach ($sqls as $key => $sql) {
            preg_match('/CREATE TABLE IF NOT EXISTS `([^`]+)`/i', $sql, $matches);
            preg_match("/COMMENT='([^`]+)'/i", $sql, $cmatches);
            $result[$key]['table_name'] = $matches ? str_replace("__PREFIX__", '', $matches[1]) : '';
            $result[$key]['comment'] = $cmatches ? $cmatches[1] : '';
            $result[$key]['sql'] = ltrim($sql);
        }

        fclose($file_handle);

        return $result;
    }

    /**
     * 检查插件依赖
     * @internal
     * @return void
     */
    public function check()
    {
        $table_name = $this->request->request('table_name');
        $addonname = $this->request->request('addon_name');
        $addon_name = 'fadeveloper';
        $info = get_addon_info($addon_name);
        $addonArr = [
            'fadeveloper' => 'FastAdmin插件开发工具'
        ];
        if (!$info || !$info['state']) {
            $this->error('请检查对应插件' . (isset($addonArr[$addon_name]) ? "《{$addonArr[$addon_name]}》" : "") . '是否安装且启动', 'addon/index');
        }

        $this->redirect('fadeveloper/command/crud?addon_name=' . $addonname . '&table_name=' . $table_name);
    }
}
