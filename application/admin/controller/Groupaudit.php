<?php

namespace app\admin\controller;

use app\admin\model\MeilisearchCommon;
use app\admin\model\tg\User;
use app\common\controller\Backend;
use app\common\library\Meilisearch;

class Groupaudit extends Backend
{
    public function _initialize()
    {
        parent::_initialize();
        // 初始化 Manticoresearch 客户端
        $ManClient = new Meilisearch();
        $this->client = $ManClient->getClient();
    }
    public function index(){
        // 设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $options = [
                'limit' => $limit, // 每页返回的文档数量
                'offset' => $offset,   // 从哪个文档开始返回
            ];
            // 构建 Manticoresearch 查询
            //$index = 'user_logs'; // 替换为你的 Manticoresearch 索引名称
            //if (!empty($where)) {
            //    if (isset($where['user_id'])) {
            $options['filter'] = "status = 1";
            //    }
            //}
            $index = $this->client->index("groups")->search('', $options);
            //dump($index->getHits());exit();
            $list = $index->getHits(); // 获取数据源
            $i = 0;
            foreach ($list as $item) {
                if($item['user'] == 0){
                    $list[$i]["user"] = __('collection');
                }else {
                    $UserData = User::where(['id' => $item['user']])->find();
                    if ($UserData) {
                        $list[$i]["user"] = $UserData->tid . "-" . $UserData->tusername . "-" . $UserData->tnick;
                    } else {
                        $list[$i]["user"] = "Not Found UserInfo";
                    }
                }
                $i++;
            }
            $total = $index->getRaw()["estimatedTotalHits"];

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }


    public function setstatus(){
        if($this->request->isPost()){
            $data = $this->request->post();
            $Meili = new MeilisearchCommon("groups");
            $result = $Meili->updateGroup($data["id"],["status"=>$data["status"]]);
            //dump($result);exit();
            $this->success("success");
        }else{
            $this->error("error");
        }
    }
}