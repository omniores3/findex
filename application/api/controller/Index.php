<?php

namespace app\api\controller;

use app\admin\model\Recharge;
use app\common\controller\Api;
use fast\RabbitMQ;
use PhpAmqpLib\Exception\AMQPTimeoutException;
use TelegramBot\Api\Client;
use think\Cache;
use think\Queue;
use think\queue\Job;

/**
 * 首页接口
 */
class Index extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    /**
     * 首页
     *
     */
    public function index()
    {
        $this->success('请求成功');
    }


    //推送消息队列
    public function push_queue(){
        CreateRabbitMQQueue(["group_username"=>"@tttttt"]);
    }

    //获取队列
    public function get_queue(){
        $rabbit = new RabbitMQ("RecordMessage");
        try {
            $result = $rabbit->getMessage();
            if($result["code"] == 200){
                $result["data"]["body"] = json_decode($result["data"]["body"], true);
                $this->success("success",$result["data"]);
            }
            $this->error("error",$result["data"]);
        }catch(AMQPTimeoutException $e){
            $this->error($e->getMessage());
        }

    }

    //删除队列
    public function del_queue($delivery_tag){
        $rabbit = new RabbitMQ("RecordMessage");
        $result = $rabbit->ackMessage($delivery_tag);
        $this->success("success",$result);
    }

    //支付请求回调
    public function notify(){
        if($this->request->isPost()){
            $data = $this->request->post();
            $recharge = new Recharge();
            $rechargeData = $recharge->where(["orderid"=>$data["OutOrderId"]])->find();
            if(!$rechargeData){
                $this->error();
            }
            if($rechargeData->status != "0"){
                $this->error();
            }
            $config = config("site");
            $id = $data["Id"];
            $signstring = "Id=".$id.$config["tokenpay_key"];
            $sign = md5($signstring);
            $res = file_get_contents($config["tokenpay_url"]."/Query?Id={$id}&Signature=".$sign);
            $resData = json_decode($res,true);
            //dump($resData);exit();
            if($resData["success"] == "true"){
                $arr = [
                    "pass_through_info" => $resData["data"]["fromAddress"],
                    "block" => $resData["data"]["blockTransactionId"],
                    "status" => "1",
                    "paytime" => time(),
                ];
                $recharge->where(["orderid" => $resData["data"]["outOrderId"]])->update($arr);

                $userInfo = \app\admin\model\tg\User::find($rechargeData->user_id);
                if(!$userInfo){
                    $this->error();
                }
                if($config["deposit_methods"] == "1"){
                    $amount = $resData["data"]["payAmount"];
                }else{
                    $amount = $resData["data"]["actualAmount"];
                }
                \app\admin\model\tg\User::where(["id"=>$rechargeData->user_id])->setInc("balance",$amount);

                $bot = new Client($config["bottoken"]);
                $bot->sendMessage($userInfo->tid,__("recharge_success",[$amount],$userInfo->lang));
                echo "OK";
            }
        }else{
            $this->error(__("Request error"));
        }
    }

}
