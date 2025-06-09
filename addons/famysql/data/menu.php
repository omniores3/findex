<?php

$menu = [
    [
        "name" => "famysql/table",
        "title" => "数据库管理",
        "icon" => "fa fa-database",
        "remark" => "可在线进行数据库表优化或修复,查看表结构和数据等",
        "ismenu" => 1,
        "sublist" => [
            [
                "name" => "famysql/table/index",
                "title" => "查看"
            ],
            [
                "name" => "famysql/table/table_add",
                "title" => "添加"
            ],
            [
                "name" => "famysql/table/table_batch_add",
                "title" => "快速建表"
            ],
            [
                "name" => "famysql/table/table_edit",
                "title" => "编辑"
            ],
            [
                "name" => "famysql/table/table_del",
                "title" => "删除"
            ],
            [
                "name" => "famysql/table/truncate",
                "title" => "截/断表"
            ],
            [
                "name" => "famysql/table/optimize",
                "title" => "优化表"
            ],
            [
                "name" => "famysql/table/repair",
                "title" => "修复表"
            ],
            [
                "name" => "famysql/table/copy",
                "title" => "复制表"
            ],
            [
                "name" => "famysql/table/backuplist",
                "title" => "备份列表"
            ],
            [
                "name" => "famysql/table/download",
                "title" => "备份下载"
            ],
            [
                "name" => "famysql/table/restore",
                "title" => "恢复"
            ],
            [
                "name" => "famysql/table/backup",
                "title" => "备份"
            ],
            [
                "name" => "famysql/table/upload",
                "title" => "上传文件"
            ],
            [
                "name" => "famysql/index",
                "title" => "索引管理",
                "icon" => "fa fa-list",
                "ismenu" => 0,
                "sublist" => [
                    [
                        "name" => "famysql/index/indexs",
                        "title" => "索引首页"
                    ],
                    [
                        "name" => "famysql/index/index_add",
                        "title" => "添加"
                    ],
                    [
                        "name" => "famysql/index/index_edit",
                        "title" => "编辑"
                    ],
                    [
                        "name" => "famysql/index/index_del",
                        "title" => "删除"
                    ]
                ]
            ],
            [
                "name" => "famysql/field",
                "title" => "字段管理",
                "icon" => "fa fa-list",
                "ismenu" => 0,
                "sublist" => [
                    [
                        "name" => "famysql/field/fields",
                        "title" => "字段首页"
                    ],
                    [
                        "name" => "famysql/field/create",
                        "title" => "快速建表"
                    ],
                    [
                        "name" => "famysql/field/field_add",
                        "title" => "添加字段"
                    ],
                    [
                        "name" => "famysql/field/field_edit",
                        "title" => "修改字段"
                    ],
                    [
                        "name" => "famysql/field/field_del",
                        "title" => "删除"
                    ],
                    [
                        "name" => "famysql/field/field_drag",
                        "title" => "字段排序"
                    ]
                ]
            ]
        ]
    ]
];
return $menu;
