<?php

namespace app\admin\model;

use think\Model;

class CrontabLog extends Model
{

    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    // 定义字段类型
    protected $type = [
    ];
    // 追加属性
    protected $append = [
    ];

    public function getStatusList()
    {
        return ['success' => __('Success'), 'failure' => __('Failure'), 'inprogress' => __('Inprogress')];
    }

    public function getStatusTextAttr($value, $data)
    {
        $value = $value ?: ($data['status'] ?? '');
        $list = $this->getStatusList();
        return $list[$value] ?? '';
    }

}
