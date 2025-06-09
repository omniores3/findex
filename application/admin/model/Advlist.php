<?php

namespace app\admin\model;

use think\Model;


class Advlist extends Model
{

    

    

    // 表名
    protected $name = 'advlist';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text',
        'endtime_text'
    ];
    

    
    public function getStatusList()
    {
        return ['-2' => __('Status -2'), '1' => __('Status 1'), '0' => __('Status 0'), '2' => __('Status 2')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ?: ($data['status'] ?? '');
        $list = $this->getStatusList();
        return $list[$value] ?? '';
    }


    public function getEndtimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['endtime'] ?? '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setEndtimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    public function tgUser()
    {
        return $this->hasOne('TgUser', 'id', 'user_id', [], 'LEFT')->setEagerlyType(0);
    }
}
