<?php
return [
    "User_id" => "所属用户",
    "groupid" => "群组ID",
    "groupname" => "群组名称",
    "groupusername" => "群组用户名",
    "grouptype" => "群组类型",
    "groupcount" => "群组人数",
    "is_search" => "搜索状态",
    "is_welcome" => '欢迎进群状态',
    "is_timer" => "定时任务状态",
    "is_top" => "消息置顶状态",
    "status" => "群组状态",
    "lang" => "所属语言",
    "lables" => "所属标签",
    "category" => "所属分类",
    "kd" => "KD值(搜索时自然排名)",
    "addtime" => "添加时间",
    "updatetime" => "更新时间",

    "-1" => "<span class=\"btn btn-info btn-xs btn-detail\">关闭</span>",
    "0" => "<span class=\"btn btn-info btn-xs btn-detail\">开启(使用系统)</span>",
    "1" => "<span class=\"btn btn-info btn-xs btn-detail\">开启(使用自定义)</span>",
    "2" => "<span class=\"btn btn-info btn-xs btn-detail\">开启(使用自定义开启广告)</span>",

    "status_lang" => [
        "-2" => "黑名单",
        "-1" => "禁止",
        "0" => "等待AI审核中",
        "1" => "等待人工审核",
        "2" => "正常",
        "3" => "优质",
    ],

    'collection' => '无认领',

    'search_lang' => [
        '-1' => "<span class=\"btn btn-info btn-xs btn-detail\">关闭</span>",
        '0' => "<span class=\"btn btn-info btn-xs btn-detail\">开启</span>",
        '1' => "<span class=\"btn btn-info btn-xs btn-detail\">开启(关键词)</span>",
    ],
    //supergroup=超级群组,privategroup=私有群组，channel=频道,photo=图片,video=视频，user=用户，bot=机器人,document=文档，audio=音频，url=链接
    "group_lang" => [
        "supergroup" => '<span class=\"btn btn-info btn-xs btn-detail\">超级群组</span>',
        'privategroup' => '<span class=\"btn btn-info btn-xs btn-detail\">私有群组</span>',
        'channel' => '<span class=\"btn btn-info btn-xs btn-detail\">频道</span>',
        'photo' => '<span class=\"btn btn-info btn-xs btn-detail\">图片</span>',
        'video' => '<span class=\"btn btn-info btn-xs btn-detail\">视频</span>',
        'user' => '<span class=\"btn btn-info btn-xs btn-detail\">用户</span>',
        'bot' => '<span class=\"btn btn-info btn-xs btn-detail\">机器人</span>',
        'document' => '<span class=\"btn btn-info btn-xs btn-detail\">文档</span>',
        'audio' => '<span class=\"btn btn-info btn-xs btn-detail\">音频</span>',
        'url' => '<span class=\"btn btn-info btn-xs btn-detail\">超级链接</span>',
    ],

    'Confirm_Change_Status' => '您确定要修改该条数据的状态',
    'clone' => '关闭',
    'Status_error' => '状态错误，无法修改',

];