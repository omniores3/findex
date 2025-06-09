<?php

// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// [ 应用入口文件 ]
// 定义应用目录
define('APP_PATH', __DIR__ . '/../application/');
// 判断是否安装
if (!is_file(APP_PATH . 'admin/command/Install/install.lock')) {
    header("location:./install.php");
    exit;
}
//kn1Bagif-rUz_4DH9hqMbIVADPpBfU41-67msE30Iqg

//We generated a new secure master key for you (you can safely use this token):

//>> --master-key DjXdjd87qoX62PY35ryur_NS4R1hl-SlHlfHELNnw_U <<
// 加载框架引导文件
require __DIR__ . '/../thinkphp/start.php';
