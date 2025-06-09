<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class Tips extends Model
{

    use SoftDelete;

    

    // 表名
    protected $name = 'tips';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'integer';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = 'deletetime';

    // 追加属性
    protected $append = [
        'mode_text'
    ];
    

    
    public function getModeList()
    {
        return ['0' => __('Mode 0'), '1' => __('Mode 1'), '2' => __('Mode 2')];
    }


    public function getModeTextAttr($value, $data)
    {
        $value = $value ?: ($data['mode'] ?? '');
        $list = $this->getModeList();
        return $list[$value] ?? '';
    }




}
