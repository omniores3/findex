<?php

namespace app\admin\controller\tg;

use app\admin\model\MeilisearchCommon;
use app\admin\model\Receivpayments;
use app\admin\model\Recharge;
use app\common\controller\Backend;
use app\common\library\Manticore;
use app\common\library\Meilisearch;
use app\common\model\UserLogs;
use app\common\service\BotService;
use app\common\service\TipsService;
use TelegramBot\Api\Client;
use TelegramBot\Api\HttpException;
use think\Db;
use think\paginator\driver\Bootstrap;
/**
 * TG用户管理
 *
 * @icon fa fa-circle-o
 */
class User extends Backend
{
    protected $model = null;
    protected $manticore = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\tg\User;
        $this->manticore = new Manticore;
    }

    /**
     * 查看
     *
     * @return string|Json
     * @throws \think\Exception
     * @throws DbException
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if (false === $this->request->isAjax()) {
            return $this->view->fetch();
        }
        //如果发送的来源是 Selectpage，则转发到 Selectpage
        if ($this->request->request('keyField')) {
            return $this->selectpage();
        }
        [$where, $sort, $order, $offset, $limit] = $this->buildparams();
        $list = $this->model
            ->with('parent')
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
        $result = ['total' => $list->total(), 'rows' => $list->items()];
        return json($result);
    }

    // 查看详情
    public function detail()
    {
        $id = $this->request->param('id');
        $row = $this->model->find($id);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $this->view->assign("user", $row);
        return $this->view->fetch();
    }

    // 发送消息
    public function sendmessage()
    {
        $id = $this->request->get('id');
        $user = $this->model->where(["id"=>$id])->find();
        if (!$user) {
            $this->error(__('not_found_user'));
        }
        if($this->request->isPost()){
            $text = $this->request->post('message');
            $config = config("site");
            $bot = new Client($config['bottoken']);
            try{
                $res = $bot->sendMessage($user->tid,$text,"MarkDown");
                if($res->getMessageId()){
                    $this->success("success");
                }else{
                    $this->error("error");
                }
            }catch(HttpException $e){
                $this->error($e->getMessage());
            }
        }else {
            $this->assign([
                'id' => $id,
                'user' => $user
            ]);
            return $this->view->fetch();
        }
    }

    // 余额操作
    public function balance()
    {
        $params = $this->request->post();
        $id = $params['id'];
        $type = $params['type'];
        $amount = $params['amount'];
        $remark = $params['remark'];

        $user = $this->model->find($id);
        if (!$user) {
            $this->error(__('No Results were found'));
        }
        $logData = UserLogs::getUserLogsData();
        $logData["user"] = $id;
        $logData["admin"] = $this->auth->id;
        $string = null;
        // 执行余额操作
        switch ($type) {
            case 'add':
                $logData["action_type"] = "admin_add";
                $logData["action_detail"] = __("admin_add") . $remark;
                $logData["balance_before_change"] = $user->balance;
                $logData["balance_after_change"] = $user->balance + $amount;
                $logData["balance_change"] = $amount;

                $tips = TipsService::getTipsObj("admin_add",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $amount, $string);
                    $string = str_replace("{balance}", $user->balance + $amount, $string);
                }

                $user->balance += $amount;
                break;
            case 'reduce':
                if ($user->balance < $amount) {
                    $this->error(__('Insufficient balance'));
                }
                $logData["action_type"] = "admin_reduce";
                $logData["action_detail"] = __("admin_reduce").$remark;
                $logData["balance_before_change"] = $user->balance;
                $logData["balance_after_change"] = $user->balance - $amount;
                $logData["balance_change"] = $amount;

                $tips = TipsService::getTipsObj("admin_reduce",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $amount, $string);
                    $string = str_replace("{balance}", $user->balance - $amount, $string);
                }

                $user->balance -= $amount;
                break;
            case 'freeze':
                if ($user->balance < $amount) {
                    $this->error(__('Insufficient balance'));
                }
                $logData["action_type"] = "admin_freeze";
                $logData["action_detail"] = __("admin_freeze").$remark;
                $logData["balance_before_change"] = $user->balance;
                $logData["balance_after_change"] = $user->balance - $amount;
                $logData["balance_change"] = $amount;
                $logData["frozen_before_balance_change"] = $user->frozen_balance;   //操作前冻结余额
                $logData["frozen_after_balance_change"] = $user->frozen_balance + $amount;    //操作后冻结余额
                $logData["frozen_change"] = $amount;  //操作的冻结余额

                $tips = TipsService::getTipsObj("admin_freeze",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $amount, $string);
                    $string = str_replace("{balance}", $user->balance - $amount, $string);
                }

                $user->balance -= $amount;
                $user->frozen_balance += $amount;
                break;
            case 'unfreeze':
                if ($user->frozen_balance < $amount) {
                    $this->error(__('Insufficient frozen balance'));
                }
                $logData["action_type"] = "admin_unfreeze";
                $logData["action_detail"] = __("admin_unfreeze").$remark;
                $logData["balance_before_change"] = $user->balance;
                $logData["balance_after_change"] = $user->balance + $amount;
                $logData["balance_change"] = $amount;
                $logData["frozen_before_balance_change"] = $user->frozen_balance;   //操作前冻结余额
                $logData["frozen_after_balance_change"] = $user->frozen_balance - $amount;    //操作后冻结余额
                $logData["frozen_change"] = $amount;  //操作的冻结余额

                $tips = TipsService::getTipsObj("admin_unfreeze",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $amount, $string);
                    $string = str_replace("{balance}", $user->balance + $amount, $string);
                }

                $user->balance += $amount;
                $user->frozen_balance -= $amount;
                break;
            case 'clear_frozen':
                $logData["action_type"] = "admin_clear_frozen";
                $logData["action_detail"] = __("admin_clear_frozen").$remark;
                $logData["frozen_before_balance_change"] = $user->frozen_balance;   //操作前冻结余额
                $logData["frozen_after_balance_change"] = 0;    //操作后冻结余额
                $logData["frozen_change"] = $user->frozen_balance;  //操作的冻结余额  admin_clear_frozen

                $tips = TipsService::getTipsObj("admin_clear_frozen",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $user->frozen_balance, $string);
                }

                $user->frozen_balance = 0;
                break;
            case 'reject_frozen':
                if ($user->frozen_balance < $amount) {
                    $this->error(__('Insufficient frozen balance'));
                }
                $logData["action_type"] = "admin_reject_frozen";
                $logData["action_detail"] = __("admin_reject_frozen").$remark;
                $logData["balance_before_change"] = $user->balance;
                $logData["balance_after_change"] = $user->balance + $amount;
                $logData["balance_change"] = $amount;
                $logData["frozen_before_balance_change"] = $user->frozen_balance;   //操作前冻结余额
                $logData["frozen_after_balance_change"] = $user->frozen_balance - $amount;    //操作后冻结余额
                $logData["frozen_change"] = $amount;  //操作的冻结余额

                $tips = TipsService::getTipsObj("admin_unfreeze",$user->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{amount}", $amount, $string);
                    $string = str_replace("{balance}", $user->balance + $amount, $string);
                }

                $user->frozen_balance -= $amount;
                $user->balance += $amount;
                break;
            default:
                $this->error(__('Wrong operation type'));
        }
        Db::startTrans();
        try {
            // 记录日志到Manticore
            $Meili = new MeilisearchCommon("user_logs");
            $meiliData = $Meili->addIndexData($logData);
            $res = $user->save();
            Db::commit();
            if ($res) {
                if($string) {
                    BotService::sendMessage($user->tid, $string);
                }
                $this->success(__('Operation completed'));
            } else {
                $this->error(__('Operation failed'));
            }
        }catch (\HttpException $e){
            Db::rollback();
            $this->error($e->getMessage());
        }
    }


    public function setstatus(){
        if($this->request->isPost()){
            $row = $this->request->post();
            $userStatus = \app\admin\model\tg\User::where(['id'=>$row['id']])->find();
            $logData = UserLogs::getUserLogsData();
            $logData["user"] = $row["id"];
            $logData["admin"] = $this->auth->id;
            $logData["action_type"] = "admin_chang_status";
            $logData["action_detail"] = __("action_type_message")["admin_chang_status"];
            $logData["before_status"] = $userStatus->status;
            $logData["after_status"] = $row['type'];
            $Meili = new MeilisearchCommon("user_logs");
            $Meili->addIndexData($logData);

            $res = \app\admin\model\tg\User::where(['id' => $row['id']])->update(['status' => $row['type']]);

            if ($res) {
                $string = "";
                $tips = TipsService::getTipsObj("admin_chang_status",$userStatus->lang);
                if(isset($tips->text)) {
                    $string = $string . $tips->text;
                    $string = str_replace("{before_status}", $userStatus->status, $string);
                    $string = str_replace("{after_status}", $row['type'], $string);
                    BotService::sendMessage($userStatus->tid, $string);
                }
                $this->success(__("success"));
            } else {
                $this->error(__('error'));
            }
        }else{
            $this->error(__('Request parameters invalid'));
        }
    }



    //用户推广结构
    public function promotion($id)
    {
        $row = $this->model->get($id);
        if (!$row)
            $this->error("记录未找到");
        $this->view->assign('row', $row);
        $tree = $this->get_tree($id);
        $this->view->assign('tree', $tree);
        return $this->view->fetch();
    }

    /**
     * 获取推广树
     */
    public function get_tree($id, $level = 0)
    {
        $children = $this->model->where('parent_id', $id)->select();
        $tree = [];
        foreach ($children as $child) {
            $child['level'] = $level;
            $tree[] = $child;
            $tree = array_merge($tree, $this->get_tree($child['id'], $level + 1));
        }
        return $tree;
    }


    //用户日志
    public function seelogs($id,$page = 1,$pagesize = 10){
        if(!$id){
            $this->error(__('No Results were found'));
        }
        $Meili = new MeilisearchCommon("user_logs");
        $searchString = "user = {$id}";
        $result = $Meili->GeneralQuer("",$searchString,$page,$pagesize);
        $result["ceil"] = ceil($result["total"] / $result["page_size"]);
        $this->view->assign('data', $result);
        $this->view->assign('id', $id);
        return $this->view->fetch();
        //dump($result);
    }



    //用户充值记录
    public function rechargelogs($id = null){
        if(!$id){
            $this->error(__('No Results were found'));
        }
        // 设置过滤方法
        $this->request->filter(['strip_tags']);

        // 处理查询参数
        $where = [];
        $start_time = $this->request->get('start_time');
        $end_time = $this->request->get('end_time');
        $where["user_id"] = $id;
        if ($start_time && $end_time) {
            $where['createtime'] = ['between', [strtotime($start_time), strtotime($end_time)]];
        } elseif ($start_time) {
            $where['createtime'] = ['>=', strtotime($start_time)];
        } elseif ($end_time) {
            $where['createtime'] = ['<=', strtotime($end_time)];
        }

        $status = $this->request->get('status');
        if ($status !== null && $status !== '') {
            $where['status'] = $status;
        }

        $orderid = $this->request->get('orderid');
        if ($orderid) {
            $where['orderid'] = ['like', '%' . $orderid . '%'];
        }

        $sort = $this->request->get('sort', 'id');
        $order = $this->request->get('order', 'DESC');
        $offset = $this->request->get("offset", 0);
        $limit = $this->request->get("limit", 10);

        $total = Recharge::where($where)->count();
        $list = Recharge::where($where)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();

        // 手动分页
        $page = new Bootstrap($list, $limit, $total, false, [
            'query' => $this->request->get()  // 传递查询参数
        ]);
        $this->view->assign('id', $id);
        $this->view->assign('list', $list);
        $this->view->assign('page', $page->render());  // 分页链接
        $this->view->assign('total', $total);
        return $this->view->fetch();
    }




    //用户支出记录
    public function seexpenses(){
        echo __('seexpenses');
    }




    //用户收益记录
    public function income(){
        echo __('income');
    }





    //用户广告列表
    public function advlist(){
        echo __('advlist');
    }




    //用户群组列表
    public function seegroups(){
        echo __('seegroups');
    }





    //用户提现记录
    public function withlogs(){
        echo __('withlogs');
    }




    //用户搜索记录
    public function searchlog($id,$page = 1,$pagesize = 10){
        if(!$id){
            $this->error(__('No Results were found'));
        }
        $Meili = new MeilisearchCommon("search_logs");
        $searchString = "user = {$id}";
        $result = $Meili->GeneralQuer("",$searchString,$page,$pagesize);
        $result["ceil"] = ceil($result["total"] / $result["page_size"]);
        $this->view->assign('data', $result);
        $this->view->assign('id', $id);
        return $this->view->fetch();
    }

    //用户钱包列表
    public function addresslist($id){
        if(!$id){
            $this->error(__('No Results were found'));
        }
        // 设置过滤方法
        $this->request->filter(['strip_tags']);

        // 处理查询参数
        $where = [];
        $where["user_id"] = $id;

        $status = $this->request->get('status');
        if ($status !== null && $status !== '') {
            $where['status'] = $status;
        }

        $sort = $this->request->get('sort', 'id');
        $order = $this->request->get('order', 'DESC');
        $offset = $this->request->get("offset", 0);
        $limit = $this->request->get("limit", 10);

        $total = Receivpayments::where($where)->count();
        $list = Receivpayments::where($where)
            ->order($sort, $order)
            ->limit($offset, $limit)
            ->select();
        // 手动分页
        $page = new Bootstrap($list, $limit, $total, false, [
            'query' => $this->request->get()  // 传递查询参数
        ]);

        $this->view->assign('list', $list);
        $this->view->assign('page', $page->render());  // 分页链接
        $this->view->assign('total', $total);
        return $this->view->fetch();
    }

}
