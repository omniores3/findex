<?php

namespace app\admin\controller\famysql;

use app\common\controller\Backend;
use think\Db;
use think\Config;

/**
 * 字段管理
 */
class Field extends Backend
{
    protected $dbName = '';

    protected $noNeedRight = ['selectfields', 'getType', 'getSuffix'];

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
        $this->view->assign("suffixList", $this->getSuffixList());
    }

    /**
     * 字段首页
     */
    public function fields()
    {
        $name = $this->request->get('name');
        $is_admin = (int) $this->request->get('is_admin');
        $offset = $this->request->get("offset");
        $limit = $this->request->get("limit");
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }

        $ints = ["int", "tinyint", "smallint", "mediumint", "bigint", "float", "double", "decimal"];

        if ($this->request->isAjax()) {
            $tableFields = Db::table("information_schema.COLUMNS")->field("*")->where(['TABLE_SCHEMA' => $this->dbName, 'TABLE_NAME' => $name])->select();

            $list = [];
            foreach ($tableFields as $key => $tableField) {
                $list[$key]['id'] = $tableField['ORDINAL_POSITION'];
                $list[$key]['name'] = $tableField['COLUMN_NAME'];
                $list[$key]['type'] = $tableField['DATA_TYPE'];
                $list[$key]['length'] = $tableField['COLUMN_TYPE'];
                $list[$key]['default'] = $tableField['COLUMN_DEFAULT'];
                $list[$key]['primary_key'] = $tableField['COLUMN_KEY'] == 'PRI' ? 1 : 0;
                $list[$key]['index'] = $tableField['COLUMN_KEY'] == 'MUL' ? 1 : 0;
                $list[$key]['is_null'] = $tableField['IS_NULLABLE'] == 'YES' ? '否' : '是';
                $list[$key]['unsigned'] = strpos($tableField['COLUMN_TYPE'], 'unsigned') !== false ? '是' : (in_array($tableField['DATA_TYPE'], $ints) ? '否' : '-');
                $list[$key]['auto_increment'] = strpos($tableField['EXTRA'], 'auto_increment') !== false ? 1 : 0;
                $list[$key]['comment'] = $tableField['COLUMN_COMMENT'];
                $list[$key]['is_admin'] = $is_admin;
            }
            $result = array("total" => count($list), "rows" => array_slice($list, $offset, $limit));
            return json($result);
        }
        $this->view->assign("name", $name);
        $this->view->assign("is_admin", $is_admin);
        return $this->view->fetch();
    }

    /**
     * 快速建表
     */
    public function create()
    {
        $name = $this->request->get('name');
        $is_admin = (int) $this->request->get('is_admin');
        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = "ALTER TABLE `{$name}`";
                $column_name = explode(',', $params['column_name']);
                foreach ($column_name as $column) {
                    $sql .= $this->getCommonFields($column);
                }
                $sql = rtrim($sql, ',');

                Db::startTrans();
                try {
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
        $this->view->assign("name", $name);
        $this->view->assign("is_admin", $is_admin);
        return $this->view->fetch();
    }

    /**
     * 添加字段
     */
    public function field_add()
    {
        if ($this->request->isPost()) {
            $name = $this->request->param('name');
            $params = $this->request->post("row/a");
            $column_name = $params['suffix'] == '无' ? $params['name'] : $params['name'] . $params['suffix'];
            if ($params) {
                $result = false;
                $sql = "ALTER TABLE `{$name}` ADD COLUMN `{$column_name}` ";
                Db::startTrans();
                try {
                    if (in_array($params['type'], ['enum', 'set'])) {
                        $length_arr = json_decode($params['length'], true);
                        $default_arr = [];
                        foreach ($length_arr as $value) {
                            $default_arr[] = $value['vo'];
                        }
                        $params['length'] = $default_arr;
                    }
                    $sql .= $this->getFieldSql($column_name, $params);

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
                    $this->error(__('No rows were updated'));
                }
            }
        }


        return $this->view->fetch();
    }

    /**
     * 修改字段
     */
    public function field_edit()
    {
        $table = $this->request->param("table");
        if ($table == NULL) {
            $this->error(__('Parameter %s can not be empty', 'table'));
        }
        $field = $this->request->param("field");
        if ($field == NULL) {
            $this->error(__('Parameter %s can not be empty', 'field'));
        }

        $properties = Db::query("SHOW FULL COLUMNS FROM `{$table}` WHERE Field =  '{$field}'");

        $type_arr = explode(" ", $properties[0]["Type"]);
        $type = strstr($type_arr[0], "(", true) !== false ? strstr($type_arr[0], "(", true) : $type_arr[0];
        $length = preg_match('/\((.*?)\)/', $type_arr[0], $matches) ? $matches[1] : 0;

        $row['name'] = $properties[0]["Field"];
        $row['type'] = $type;
        $row['collate'] = $properties[0]["Collation"];
        if (in_array($type, ["enum", "set"])) {
            $length_arr = explode(",", $length);
            $length_res = [];
            foreach ($length_arr as $key => $value) {
                preg_match("/\'(.*?)\'/", $value, $matches);
                $length_res[$key]['vo'] = $matches[1];
            }
            $length = json_encode($length_res);
        }
        $row['length'] = $length;
        $row['default'] = $properties[0]["Default"];
        $row['is_null'] = $properties[0]["Null"];
        $row['unsigned'] = in_array("unsigned", $type_arr) ? 1 : 0;
        $row['zerofill'] = in_array("zerofill", $type_arr) ? 1 : 0;
        $row['comment'] = $properties[0]["Comment"];

        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                $result = false;
                $sql = "ALTER TABLE `{$table}` MODIFY COLUMN `{$field}` ";
                Db::startTrans();
                try {
                    if ($params['name'] !== $row['name']) {
                        $sql = "ALTER TABLE `{$table}` CHANGE `{$row['name']}` `{$params['name']}`";
                    }

                    if (in_array($params['type'], ['enum', 'set'])) {
                        $length_arr = json_decode($params['length'], true);
                        $default_arr = [];
                        foreach ($length_arr as $value) {
                            $default_arr[] = $value['vo'];
                        }
                        $params['length'] = $default_arr;
                    }
                    $sql .= $this->getFieldSql($params['name'], $params);

                    // halt($sql);

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
                    $this->error(__('No rows were updated'));
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $ints = ["int", "tinyint", "smallint", "mediumint", "bigint", "float", "double", "decimal"];

        $no_length = ['date', 'datetime', 'time', 'year', "mediumtext", "longtext", "text"];

        $this->view->assign("row", $row);
        $this->view->assign("is_int", in_array($row['type'], $ints));
        $this->view->assign("is_enum", in_array($row['type'], ['enum', 'set']));
        $this->view->assign("is_length", in_array($row['type'], $no_length));
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function field_del()
    {
        $table = $this->request->param("table");
        if ($table == NULL) {
            $this->error(__('Parameter %s can not be empty', 'table'));
        }
        $field = $this->request->param("field");
        if ($field == NULL) {
            $this->error(__('Parameter %s can not be empty', 'field'));
        }

        $result = false;
        Db::startTrans();
        try {
            $sql = "ALTER TABLE `{$table}` DROP COLUMN `{$field}`;";
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
     * 字段排序
     */
    public function field_drag()
    {
        $name = $this->request->get('name');

        if ($name == NULL) {
            $this->error(__('Parameter %s can not be empty', 'name'));
        }

        $fields = Db::getTableFields($name);

        //排序的数组
        $ids = $this->request->post("ids");
        //拖动的记录ID
        $changeid = (int) $this->request->post("changeid");

        $ids = explode(',', $ids);

        $position = array_search($changeid, $ids);
        switch ($position) {
            case 0:
                if ($ids[array_search($changeid, $ids) + 1] > 1) {
                    $changeField = $fields[$changeid - 1];
                    $afterField = $fields[$ids[1] - 2];
                    $properties = $this->getProperties($name, $changeField);
                    $sql = "ALTER TABLE `{$name}` MODIFY COLUMN  `{$changeField}` {$properties} AFTER `{$afterField}`";
                } else {
                    $afterField = $fields[$changeid - 1];
                    $properties = $this->getProperties($name, $afterField);
                    $sql = "ALTER TABLE `{$name}` MODIFY COLUMN  `{$afterField}` {$properties} FIRST";
                }

                break;
            default:
                $changeField = $fields[$changeid - 1];
                $afterField = $fields[($ids[array_search($changeid, $ids) - 1] - 1)];
                $properties = $this->getProperties($name, $changeField);
                $sql = "ALTER TABLE `{$name}` MODIFY COLUMN  `{$changeField}` {$properties} AFTER `{$afterField}`";

        }
        $result = false;
        Db::startTrans();
        try {
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
            $this->error(__('No rows were updated'));
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
     * 字段选择
     * @internal
     */
    public function selectfields()
    {
        //当前页
        $page = $this->request->request("pageNumber");
        //分页大小
        $pagesize = $this->request->request("pageSize");

        $q_word = (array) $this->request->request("q_word/a");

        $word = $q_word[0];

        $custom = (array) $this->request->request("custom/a");
        if ($custom && is_array($custom)) {
            $table = $custom['table'];
        }

        $fields = $this->getFields($table, ['id']);

        $commonFields = $this->getCommonFields();

        $fieldLists = [];
        foreach ($commonFields as $commonField) {
            if (!in_array($commonField['column_name'], $fields)) {
                $fieldLists[] = $commonField;
            }
        }
        if (!empty($word)) {
            $res_arr = [];
            foreach ($fieldLists as $fieldList) {
                $res_arr[] = $fieldList['column_name'] . '-' . $fieldList['comment'];
            }
            $res_arr = array_filter($res_arr, function ($v) use ($word) {
                return stripos($v, $word) !== false;
            });
            $res_arrs = array_values($res_arr);

            $fieldLists_arr = [];
            foreach ($res_arrs as $res) {
                $fieldLists_arr[] = [
                    'column_name' => explode('-', $res)[0],
                    'comment' => explode('-', $res)[1]
                ];
            }
            $fieldLists = $fieldLists_arr;
        }

        $result = array("total" => count($fieldLists), "list" => array_slice($fieldLists, ($page - 1) * $pagesize, $pagesize));

        return json($result);

    }

    /**
     * 字段类型
     * @internal
     */
    public function getType()
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
            $suffix = [];
            $type = [];
            if ($custom && is_array($custom)) {
                $suffix = $custom['suffix'];
                $suffixList = $this->getSuffixList($suffix);
                $type = !is_array($suffixList['type']) ? [$suffixList['type']] : $suffixList['type'];
            }

            $typeList = $this->getTypeList($type);
            $lists = [];
            foreach ($typeList as $v) {
                $lists[] = ['type' => $v];
            }
            if (!empty($word)) {
                $res_arr = [];
                foreach ($lists as $list) {
                    $res_arr[] = $list['type'];
                }
                $res_arr = array_filter($res_arr, function ($v) use ($word) {
                    return stripos($v, $word) !== false;
                });
                $res_arrs = array_values($res_arr);

                $lists_arr = [];
                foreach ($res_arrs as $res) {
                    $lists_arr[] = [
                        'type' => $res,
                    ];
                }
                $lists = $lists_arr;
            }
        } else {
            $lists[] = ['type' => $keyValue];
        }

        $result = array("total" => count($lists), "rows" => array_slice($lists, ($page - 1) * $pagesize, $pagesize));
        return json($result);
    }

    /**
     * 字段后缀
     * @internal
     */
    public function getSuffix()
    {
        $name = $this->request->request("name");
        $suffix = $this->getSuffixList($name);
        return json($suffix);
    }

    /**
     * 读取后缀规则
     * @return array
     */
    protected function getSuffixList($suffix = '')
    {
        $suffixList = [];
        $suffixList['time'] = ["type" => ["bigint", "datetime"], "length" => 16, "default" => NULL, "comment" => '时间', "remark" => '识别为日期时间型数据，自动创建选择时间的组件'];
        $suffixList['image'] = ["type" => ["varchar"], "length" => 255, "default" => '', "comment" => '缩略图', "remark" => '识别为图片文件，自动生成可上传图片的组件，单图'];
        $suffixList['images'] = ["type" => ["varchar"], "length" => 1500, "default" => '', "comment" => '组图', "remark" => '识别为图片文件，自动生成可上传图片的组件，多图'];
        $suffixList['file'] = ["type" => ["varchar"], "length" => 100, "default" => '', "is_null" => 1, "comment" => '附件', "remark" => '识别为普通文件，自动生成可上传文件的组件，单文件'];
        $suffixList['files'] = ["type" => ["varchar"], "length" => 1000, "default" => '', "is_null" => 1, "comment" => '附件', "remark" => '识别为普通文件，自动生成可上传文件的组件，多文件'];
        $suffixList['avatar'] = ["type" => ["varchar"], "length" => 255, "default" => '', "is_null" => 1, "comment" => '头像', "remark" => '识别为头像，自动生成可上传图片的组件，单图'];
        $suffixList['avatars'] = ["type" => ["varchar"], "length" => 1500, "default" => '', "is_null" => 1, "comment" => '头像', "remark" => '识别为头像，自动生成可上传图片的组件，多图'];

        $suffixList['seconds'] = ["type" => ["int"], "length" => 10, "default" => NULL, "is_null" => 1, "comment" => '时长/分钟'];

        $suffixList['price'] = ["type" => ["decimal"], "length" => '10,2', "default" => '0.00', "is_null" => 1, 'unsigned' => 1, "comment" => '价格'];

        $suffixList['content'] = ["type" => ["text", "mediumtext", "longtext"], "is_null" => 1, "comment" => '内容', "remark" => '识别为内容，自动生成富文本编辑器(需安装富文本插件)'];

        $suffixList['_id'] = ["type" => ["int"], "length" => 10, "default" => 0, "is_null" => 1, "unsigned" => 1, "zerofill" => 0, "comment" => 'ID', "remark" => '识别为关联字段，自动生成可自动完成的文本框，单选'];
        $suffixList['_ids'] = ["type" => ["varchar"], "length" => 100, "default" => '', "comment" => 'ID集合', "remark" => '识别为关联字段，自动生成可自动完成的文本框，多选'];

        $suffixList['list'] = ["type" => ["enum", "set"], "is_null" => 1, "remark" => ['识别为列表字段，自动生成单选下拉列表', '识别为列表字段，自动生成多选下拉列表']];
        $suffixList['data'] = ["type" => ["enum", "set"], "is_null" => 1, "remark" => ['识别为选项字段，自动生成单选框', '识别为选项字段，自动生成复选框']];

        if (version_compare(config('fastadmin.version'), '1.3.0', '<')) {
            $suffixList['json'] = ["type" => ["varchar"], "length" => 255, "default" => '', "is_null" => 1, "comment" => '管理员ID', "remark" => '识别为键值组件，自动生成键值录入组件，仅支持1.2.0+'];
            $suffixList['switch'] = ["type" => ["tinyint"], "length" => 1, "default" => 0, "is_null" => 1, "comment" => '开关', "remark" => '识别为开关字段，自动生成开关组件，默认值1为开，0为关，仅支持FastAdmin 1.2.0+'];
        } else {
            $suffixList['range'] = ["type" => ["varchar"], "length" => 100, "default" => '', "is_null" => 1, "comment" => '区间', "remark" => '识别为时间区间组件，自动生成时间区间组件，仅支持FastAdmin 1.3.0+'];
            $suffixList['tag'] = ["type" => ["varchar"], "length" => 255, "default" => '', "is_null" => 1, "comment" => '标签', "remark" => '识别为Tagsinput，自动生成标签输入组件，仅支持FastAdmin 1.3.0+'];
            $suffixList['tags'] = ["type" => ["varchar"], "length" => 255, "default" => '', "is_null" => 1, "comment" => '标签组', "remark" => '识别为Tagsinput，自动生成标签输入组件，仅支持FastAdmin 1.3.0+'];
        }
        return empty($suffix) ? array_keys($suffixList) : $suffixList[$suffix];
    }

    /**
     * 读取类型规则
     * @return array
     */
    protected function getTypeList($types = [])
    {
        $typeList = [];
        $sql = "SELECT DISTINCT DATA_TYPE FROM information_schema.COLUMNS";
        $result = Db::query($sql);
        foreach ($result as $key => $value) {
            $typeList[$value['DATA_TYPE']] = $value['DATA_TYPE'];
            if (!empty($types) && !in_array($value['DATA_TYPE'], $types)) {
                unset($typeList[$value['DATA_TYPE']]);
            }
        }

        return $typeList;
    }

    protected function getCommonFields($fields = '')
    {
        $fieldList = include ADDON_PATH . 'famysql' . DS . 'data' . DS . 'fields.php';

        $fields = $fields == '' ? [] : explode(',', $fields);
        if (!empty($fields)) {
            $sql = "";
            foreach ($fieldList as $field => $fieldInfo) {
                if (in_array($field, $fields)) {
                    $sql .= " ADD COLUMN `{$field}`" . $this->getFieldSql($field, $fieldInfo);
                    $sql .= ",";
                }
            }
            return $sql;
        } else {
            $fields = array_keys($fieldList);
            $result = [];
            foreach ($fields as $key => $field) {
                $result[$key] = [
                    "column_name" => $field,
                    "comment" => isset($fieldList[$field]['comment']) ? $fieldList[$field]['comment'] : ucwords($field)
                ];
            }
            return $result;
        }
    }

    /**
     * 获取表字段属性
     */
    protected function getProperties($table, $field)
    {
        $all = Db::query("SHOW FULL COLUMNS FROM `{$table}` WHERE Field =  '{$field}'");

        $str = '';
        $str .= "{$all[0]['Type']}";

        if ($all[0]['Collation'] != NULL) {
            $charset = substr($all[0]['Collation'], 0, strpos($all[0]['Collation'], '_'));
            $str .= " CHARACTER SET {$charset} COLLATE {$all[0]['Collation']}";
        }

        if ($all[0]['Null'] == 'NO')
            $str .= '  NOT NULL';

        if ($all[0]['Default'] === '')
            $str .= " DEFAULT ''";
        if ($all[0]['Default'] != NULL && $all[0]['Default'] != '')
            $str .= " DEFAULT '{$all[0]['Default']}'";

        if ($all[0]['Extra'] == 'auto_increment')
            $str .= ' AUTO_INCREMENT';
        $str .= " Comment '{$all[0]['Comment']}'";

        return $str;
    }

    protected function getFieldSql($field, $fieldInfo)
    {
        $sql = "";
        if (isset($fieldInfo['type'])) {
            $sql .= " {$fieldInfo['type']}";
        }
        if (!in_array($fieldInfo['type'], ["enum", "set"]) && isset($fieldInfo['length'])) {
            $sql .= "(" . $fieldInfo['length'] . ")";
        } elseif (in_array($fieldInfo['type'], ["enum", "set"])) {
            $length = "";
            foreach ($fieldInfo['length'] as $value) {
                $length .= "'{$value}',";
            }
            $length = rtrim($length, ",");
            $sql .= "(" . $length . ")";
        }
        if (isset($fieldInfo['unsigned']) && $fieldInfo['unsigned'] == 1) {
            $sql .= " UNSIGNED";
        }
        if (isset($fieldInfo['zerofill']) && $fieldInfo['zerofill'] == 1) {
            $sql .= " ZEROFILL";
        }
        if (isset($fieldInfo['is_null']) && $fieldInfo['is_null'] == 0) {
            $sql .= " NOT NULL";
        }
        if (isset($fieldInfo['default'])) {
            if (in_array($fieldInfo['type'], ["int", "tinyint", "smallint", "mediumint", "bigint"])) {
                if ($fieldInfo['default'] == "") {
                    $sql .= "";
                } elseif ($fieldInfo['default'] == 0) {
                    $sql .= " DEFAULT 0";
                } else {
                    $sql .= empty($fieldInfo['default']) ? "" : " DEFAULT {$fieldInfo['default']}";
                }
            } elseif (in_array($fieldInfo['type'], ["float", "double", "decimal"])) {
                if ($fieldInfo['default'] == "") {
                    $sql .= "";
                } elseif ($fieldInfo['default'] == 0) {
                    $sql .= " DEFAULT '0.00'";
                } else {
                    $sql .= empty($fieldInfo['default']) ? "" : " DEFAULT '{$fieldInfo['default']}'";
                }
            } elseif (in_array($fieldInfo['type'], ["text", "longtext", "mediumtext"])) {
                $sql .= empty($fieldInfo['default']) ? "" : " DEFAULT '{$fieldInfo['default']}'";
            } elseif (in_array($fieldInfo['type'], ["enum", "set"])) {
                $sql .= (empty($fieldInfo['default']) && $fieldInfo['default'] !== '0') ? "" : " DEFAULT '{$fieldInfo['default']}'";
            } else {
                if ($fieldInfo['default'] === '0') {
                    $sql .= " DEFAULT '0'";
                } elseif (empty($fieldInfo['default'])) {
                } else {
                    $sql .= " DEFAULT '{$fieldInfo['default']}'";
                }
            }

        }
        $comment = isset($fieldInfo['comment']) ? $fieldInfo['comment'] : ucwords($field);
        $sql .= " COMMENT '{$comment}'";

        return $sql;
    }

    protected function getFields($table, $excludeFields = [])
    {
        $fields = Db::getFields($table);
        $result = [];
        foreach ($fields as $field => $fieldInfo) {
            if (!in_array($field, $excludeFields)) {
                $result[] = $field;
            }
        }
        return $result;
    }
}
