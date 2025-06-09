<?php

namespace app\api\controller;

use app\admin\library\InitMeili;
use app\admin\model\Lable;
use app\common\controller\Api;
use app\common\library\Meilisearch;
use think\Queue;

class Groups extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];


    public function index($page = 1,$pagesize = 20){
        $ManClient = new Meilisearch();
        $client = $ManClient->getClient();
        $options = [
            'limit' => $pagesize, // 每页返回的文档数量
            'offset' => ($page - 1) * $pagesize,   // 从哪个文档开始返回
        ];
        $index = $client->index("groups")->search('', $options);
        $list = $index->getHits(); // 获取数据源
        $data = ["row" => $list, "total" => $index->getRaw()["nbHits"],"page"=>$page,"pageSize"=>$pagesize];
        $this->success("success",$data);
    }

    public function insert(){
        if($this->request->isPost()){
            $row = $this->request->post();
            new InitMeili();
            $config = config("site");
            $status = 0;
            //只有人工审核 status == 1;
            if($config["groups_audit"] == "artificial_audit"){
                $status = 1;
            }
            $groupname = $row["groupname"];
            //结巴分词
            $lable = jieba($groupname);
            $lableString = "";
            foreach ($lable as $item) {
                $lableObj = new Lable();
                $lableInfo = $lableObj->where(["name" => $item])->find();
                if($lableInfo){
                    $lableString = $lableString.$lableInfo->id.",";
                }else{
                    $lableArr = [
                        "name" => $item,
                        "createtime" => time(),
                    ];
                    $id = $lableObj->insertGetId($lableArr);
                    $lableString = $lableString.$id.",";
                }
            }
            $id = uniqid();
            $arr = [
                "id" => $id,//唯一id
                "user" => isset($row["user_id"])?$row["user_id"]:0, //用户id 0 为采集无人认领
                "group" => $row["groupid"],     //允许被搜索
                "groupname" => $groupname,   //允许被搜索
                "groupusername" => $row["groupusername"], //允许被搜索
                "groupcontent" => $row["groupcontent"], //允许被搜索
                //允许被搜索
                "grouptype" => $row["grouptype"],
                "groupcount" => $row["groupcount"],
                "online" => isset($row["online"])?$row["online"]:0,
                "is_search" => "-1", //允许被搜索
                "search_key" => "",
                "is_welcome" => "-1",//允许被搜索
                "welcome_text" => "",
                "is_timer" => '-1', //允许被搜索
                "timer_text" => "",
                "is_top" => "-1", //允许被搜索
                "top_text" => "",
                "delete" => "",
                "status" => $status, //允许被搜索
                "lang" => "", //允许被搜索
                "lables" => trim($lableString,","),//允许被搜索
                "category" => "5", //允许被搜索
                "kd" => $config["default_kd"],
                "addtime" => time(),  //允许被搜索
                "updatetime" => time(),
            ];
            $meiliSearch = new Meilisearch();
            $client = $meiliSearch->getClient();
            $AddOptions = [
                'primaryKey' => 'id', // 设置主键为 userid
            ];
            $client->index("groups")->create("groups",$AddOptions);
            $options['filter'] = "group = '".$row["groupid"]."'";
            $index = $client->index("groups")->search('', $options);
            if($index->count() != 0){
                $this->error(__("shou_error"),$row);
            }
            //消息队列审核
            if($config["audit_method"] == "rueue_review"){
                $result = $client->index("groups")->addDocuments($arr);
                $taskId = $result["taskUid"];
                Queue::push("app\\api\\jobs\\RecordJobs", json_encode($arr,JSON_UNESCAPED_UNICODE));       //消息队列，由消息队列处理群组收录
            }else{
                //直接提交审核
                $taskId = AI_Audit_Lang($arr);
            }
            $data = ["taskId" => $taskId,"url"=>$_SERVER['REQUEST_SCHEME']."://".$_SERVER['HTTP_HOST']."/api/groups/gettask.html?taskid=".$taskId];
            $this->success(__("Post_success"),$data);
        }
    }

    public function gettask($taskid = null){
        if($taskid == null){
            $this->error(__('Taskid is null'));
        }
        $meiliSearch = new Meilisearch();
        $client = $meiliSearch->getClient();
        $res = $client->index("groups")->getTask($taskid);
        if(!$res["error"]){
            $this->success(__('shou_success'));
        }else{
            $this->error($res["error"]);
        }
    }
}