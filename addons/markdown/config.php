<?php

return [
    [
        'name' => 'classname',
        'title' => '渲染文本框元素',
        'type' => 'string',
        'content' => [],
        'value' => '.editor',
        'rule' => 'required',
        'msg' => '',
        'tip' => '用于对指定的元素渲染，一般情况下无需修改',
        'ok' => '',
        'extend' => '',
    ],
    [
        'name' => 'format',
        'title' => '默认保存格式',
        'type' => 'radio',
        'content' => [
            'markdown' => 'Markdown格式',
        ],
        'value' => 'markdown',
        'rule' => 'required',
        'msg' => '',
        'tip' => '渲染编辑器后默认保存的内容格式',
        'ok' => '',
        'extend' => '',
    ],
];
