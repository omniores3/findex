<?php

return [
    [
        'name'    => 'mode',
        'title'   => '执行模式',
        'type'    => 'select',
        'content' => [
            'single' => '单进程，阻塞',
            'pcntl'  => '子进程，无阻塞，需支持pcntl，不支持时自动切换为单进程',
        ],
        'value'   => 'pcntl',
        'rule'    => '',
        'msg'     => '',
        'tip'     => '',
        'ok'      => '',
        'extend'  => '',
    ],
];
