<?php

return [
    [
        'name' => 'is_admin',
        'title' => '是否允许管理系统级数据表',
        'type' => 'radio',
        'content' => [
            1 => '是',
            0 => '否',
        ],
        'value' => '0',
        'rule' => '',
        'msg' => '',
        'tip' => '如果允许，请注意操作安全，操作错误有可能造成系统崩溃',
        'ok' => '',
        'extend' => '',
    ],
    [
        'name' => '__tips__',
        'title' => '温馨提示',
        'type' => '',
        'content' => [],
        'value' => '为了确保系统运行稳定性，默认关闭系统级数据表管理',
        'rule' => '',
        'msg' => '',
        'tip' => '',
        'ok' => '',
        'extend' => '',
    ],
];
