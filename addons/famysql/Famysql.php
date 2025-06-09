<?php
namespace addons\famysql;

use app\common\library\Menu;
use app\admin\model\AuthRule;
use think\Addons;

/**
 * Famysql插件
 */
class Famysql extends Addons
{

    /**
     * 插件安装方法
     * @return bool
     */
    public function install()
    {
        $menu = [];
        $config_file = ADDON_PATH . "famysql" . DS . 'data' . DS . "menu.php";
        if (is_file($config_file)) {
            $menu = include $config_file;
        }
        if ($menu) {
            Menu::create($menu);
        }
        return true;
    }

    /**
     * 插件卸载方法
     * @return bool
     */
    public function uninstall()
    {
        AuthRule::destroy($this->getIds());
        return true;
    }

    /**
     * 插件启用方法
     */
    public function enable()
    {
        AuthRule::where('id', 'in', $this->getIds())->update(['status' => 'normal']);
        return true;
    }

    /**
     * 插件禁用方法
     */
    public function disable()
    {
        AuthRule::where('id', 'in', $this->getIds())->update(['status' => 'hidden']);
        return true;
    }

    /**
     * 插件升级方法
     */
    public function upgrade()
    {
        AuthRule::destroy($this->getIds());
        $menu = [];
        $config_file = ADDON_PATH . "famysql" . DS . 'data' . DS . "menu.php";
        if (is_file($config_file)) {
            $menu = include $config_file;
        }
        if ($menu) {
            Menu::create($menu);
            AuthRule::where('id', 'in', $this->getIds())->update(['status' => 'hidden']);
        }
        return true;
    }

    private function getIds()
    {
        $ids = AuthRule::where('name', 'like', "famysql%")->column('id');
        return $ids;
    }
}
