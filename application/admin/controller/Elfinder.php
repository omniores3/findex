<?php
namespace app\admin\controller;

use think\Controller;

class Elfinder extends Controller
{

    public function index()
{
    $this->assign('menulist', [
        // ... existing menu items ...
        [
            'name' => 'elfinder',
            'title' => '文件管理器',
            'icon' => 'fa fa-files-o',
            'url' => url('admin/elfinder/index')
        ]
    ]);
    return $this->fetch();
}

    public function connector()
    {
        $opts = [
            'roots' => [
                [
                    'driver' => 'LocalFileSystem',
                    'path'   => ROOT_PATH ,
                    'URL'    => '/uploads/',
                    'accessControl' => 'access'
                ]
            ]
        ];
        
        $connector = new \elFinderConnector(new \elFinder($opts));
        $connector->run();
    }
}