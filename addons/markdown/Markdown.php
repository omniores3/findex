<?php

namespace addons\markdown;

use app\common\library\Menu;
use think\Addons;

/**
 * 插件
 */
class Markdown extends Addons
{

    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {

        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {

        return true;
    }

    /**
     * 插件启用方法
     * @return bool
     */
    public function enable()
    {

        return true;
    }

    /**
     * 插件禁用方法
     * @return bool
     */
    public function disable()
    {

        return true;
    }

    /**
     * @param $params
     */
    public function configInit(&$params)
    {
        $config = $this->getConfig();
        $params['markdown'] = ['classname' => $config['classname'] ?? '.editor', 'format' => $config['format'] ?? 'markdown'];
    }

}
