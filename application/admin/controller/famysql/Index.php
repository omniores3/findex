<?php

namespace app\admin\controller\famysql;

use app\common\controller\Backend;
use think\Db;

/**
 * 索引管理
 */
class Index extends Backend
{
    protected $noNeedRight = ['selectpage'];

    /**
     * 读取索引类型规则
     * @return array
     */
    protected $typeList = ['INDEX' => 'INDEX(普通)', 'UNIQUE' => 'UNIQUE(唯一)', 'FULLTEXT' => 'FULLTEXT(全文)'];

    public function _initialize()
    {
        parent::_initialize();
        if (!config("app_debug")) {
            $this->error("数据库管理插件只允许在开发环境下使用");
        }
        if (!$this->auth->isSuperAdmin()) {
            $this->error(__('Access is allowed only to the super management group'));
        }
        $this->view->assign("indexList", $this->typeList);
    }

    /**
     * 索引首页
     */
    public function indexs()
    {
        $name = $this->request->get('name');
        $is_admin = (int) $this->request->get('is_admin');
        $offset = $this->request->get("offset");
        $limit = $this->request->get("limit");
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }

        if ($this->request->isAjax()) {
            $indexs = Db::query("SHOW INDEX FROM {$name}");

            $lists = [];
            $Key_names = [];
            foreach ($indexs as $index) {
                array_push($Key_names, $index['Key_name']);
                $Key_names = array_unique($Key_names);
            }

            foreach ($Key_names as $key => $Key_name) {
                $lists[$key] = $this->get_indexs($name, $Key_name, $is_admin);
            }

            $result = array("total" => count($lists), "rows" => array_slice($lists, $offset, $limit));
            return json($result);
        }
        $this->view->assign("name", $name);
        $this->view->assign("is_admin", $is_admin);
        return $this->view->fetch();
    }

    /**
     * 添加
     */
    public function index_add()
    {
        $table = $this->request->get('table');
        if ($table == NULL) {
            $this->error(__('Parameter %s can not be empty', 'table'));
        }

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = "CREATE";
                Db::startTrans();
                try {
                    if ($params['non_unique'] !== 'INDEX') {
                        $sql .= " {$params['non_unique']}";
                    }
                    $sql .= " INDEX `{$params['name']}` ON `{$table}`";
                    $column_names = explode(',', $params['column_name']);
                    $sql .= " (";
                    foreach ($column_names as $column_name) {
                        $sql .= "`{$column_name}`,";
                    }
                    $sql = rtrim($sql, ',');
                    $sql .= ")";
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
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $this->view->assign("table", $table);
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function index_edit()
    {
        $table = $this->request->get('table');
        if ($table == NULL) {
            $this->error(__('Parameter %s can not be empty', 'table'));
        }
        $name = $this->request->get('name');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }
        $row = $this->get_indexs($table, $name, 0);

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = "ALTER TABLE `{$table}` DROP INDEX `{$row['name']}`, ADD";
                Db::startTrans();
                try {
                    if ($params['non_unique'] !== 'INDEX') {
                        $sql .= " {$params['non_unique']}";
                    }
                    $sql .= " INDEX `{$params['name']}`";
                    $column_names = explode(',', $params['column_name']);
                    $sql .= "(";
                    foreach ($column_names as $column_name) {
                        $sql .= "`{$column_name}`,";
                    }
                    $sql = rtrim($sql, ',');
                    $sql .= ")";
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
                    $this->success();
                } else {
                    $this->error(__('No rows were inserted'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }

        $this->view->assign("row", $row);
        $this->view->assign("table", $table);
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function index_del()
    {
        $table = $this->request->param("table");
        if ($table == NULL) {
            $this->error(__('Parameter %s can not be empty', 'table'));
        }
        $name = $this->request->param("name");
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }

        $result = false;
        try {
            $sql = "ALTER TABLE `{$table}` DROP INDEX `{$name}`;";
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
            $this->success();
        } else {
            $this->error(__('No rows were deleted'));
        }
    }

    /**
     * 查看
     * @internal
     */
    public function index()
    {
        $this->error('禁止访问');
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
     * 字段列表
     * @internal
     */
    public function selectpage($type = '')
    {
        //当前页
        $page = $this->request->request("pageNumber");
        //分页大小
        $pagesize = $this->request->request("pageSize");

        $q_word = (array) $this->request->request("q_word/a");

        $word = $q_word ? $q_word[0] : '';

        $custom = (array) $this->request->request("custom/a");
        $keyValue = $this->request->request('keyValue');
        if (!$keyValue) {
            if ($custom && is_array($custom)) {
                $table = $custom['table'];
            }

            $fields = Db::getFields($table);
            $lists = [];
            foreach ($fields as $field => $fieldInfo) {
                if (!in_array($field, ['id'])) {
                    $lists[] = $field;
                }
            }

            foreach ($lists as $k => $v) {
                $lists[$k] = ["column_name" => $v];
            }

            if (!empty($word)) {
                $res_arr = [];
                foreach ($lists as $list) {
                    $res_arr[] = $list['column_name'];
                }
                $res_arr = array_filter($res_arr, function ($v) use ($word) {
                    return stripos($v, $word) !== false;
                });
                $res_arrs = array_values($res_arr);

                $lists_arr = [];
                foreach ($res_arrs as $res) {
                    $lists_arr[] = [
                        'column_name' => $res,
                    ];
                }
                $lists = $lists_arr;
            }

        } else {
            $values = explode(',', $keyValue);
            foreach ($values as $key => $value) {
                $lists[$key] = ['column_name' => $value];
            }

        }

        $result = array("total" => count($lists), "list" => array_slice($lists, ($page - 1) * $pagesize, $pagesize));

        return json($result);

    }

    private function get_indexs($tableName, $keyName, $is_admin)
    {
        $indexs = Db::query("SHOW INDEX FROM {$tableName} WHERE Key_name = '{$keyName}'");

        $lists = [];
        foreach ($indexs as $key => $index) {
            if ($index['Key_name'] == 'PRIMARY') {
                $unique = 'PRIMARY';
            } elseif (!$index['Non_unique']) {
                $unique = 'UNIQUE';
            } elseif ($index['Index_type'] == 'FULLTEXT') {
                $unique = 'FULLTEXT';
            } else {
                $unique = 'INDEX';
            }
            $lists[$key]['name'] = $index['Key_name'];
            $lists[$key]['column_name'] = $index['Column_name'];
            $lists[$key]['non_unique'] = $unique;
        }

        $result['column_name'] = '';

        foreach ($lists as $i => $list) {
            $result['name'] = $index['Key_name'];
            if (($i + 1) == count($lists)) {
                $result['column_name'] .= $list['column_name'];
            } else {
                $result['column_name'] .= $list['column_name'] . ',';
            }
            $result['non_unique'] = $unique;
            $result['is_admin'] = $is_admin;
        }

        return $result;
    }
}
