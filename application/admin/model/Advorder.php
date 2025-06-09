<?php

namespace app\admin\model;

use think\Model;


class Advorder extends Model
{

    

    

    // 表名
    protected $name = 'advorder';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = false;
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'buytime_text',
        'paytime_text'
    ];


    public function advtype()
    {
        return $this->hasOne('Advtype', 'type', 'advtype', [], 'LEFT')->setEagerlyType(0);
    }

    public function tgUser()
    {
        return $this->hasOne('TgUser', 'id', 'user_id', [], 'LEFT')->setEagerlyType(0);
    }



    public function getBuytimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['buytime'] ?? '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getPaytimeTextAttr($value, $data)
    {
        $value = $value ?: ($data['paytime'] ?? '');
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setBuytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }

    protected function setPaytimeAttr($value)
    {
        return $value === '' ? null : ($value && !is_numeric($value) ? strtotime($value) : $value);
    }


}
