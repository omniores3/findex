<?php

namespace app\index\controller;

use app\admin\model\Lang;
use app\admin\model\MeilisearchCommon;
use app\admin\model\Recharge;
use app\admin\model\tg\User;
use app\common\controller\Frontend;
use app\common\library\Meilisearch;
use app\common\model\Manticoresearch;
use app\common\service\FastGptService;
use app\common\service\PayService;
use Cassandra\Uuid;
use fast\Google;
use TelegramBot\Api\Client;
use TelegramBot\Api\HttpException;
use think\Db;
use think\Queue;

class Index extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    //protected $layout = '';

    public function index()
    {
        $res = json_decode(file_get_contents("https://ancient-block-74ee.tomcat366.workers.dev/"),true);
        $ismd5 = true;
        $string = "";
        foreach ($res as $key=>$v){
            if(md5_file(ROOT_PATH.$key) != $v){
                $string = $string . $key." --- ".md5_file(ROOT_PATH.$key).PHP_EOL;
            }
        }
        echo $string;
        return $this->view->fetch();
    }

    public function get(){
        licensess();
    }


}
