<?php

namespace app\admin\model;

use think\Model;

class TgUser extends Model
{
    // 表名
    protected $name = 'tg_user';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
    protected $deleteTime = 'delete_time';
    
    // 追加属性
    protected $append = [
        'status_text'
    ];
    
    // 状态列表
    public static $statusList = [
        -1 => 'Blactst',
        0 => '禁用',
        1 => '正常',
        2 => 'Investors'
    ];
    
    // 获取状态文本
    public function getStatusTextAttr($value, $data)
    {
        return self::$statusList[$data['status']] ?? '';
    }
    
    // 关联上级用户
    public function parent()
    {
        return $this->belongsTo('TgUser', 'parent_id');
    }
}