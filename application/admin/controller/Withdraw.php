<?php

namespace app\admin\controller;

use app\admin\model\tg\User;
use app\common\controller\Backend;
use think\Db;

/**
 * 提现列管理
 *
 * @icon fa fa-circle-o
 */
class Withdraw extends Backend
{

    /**
     * Withdraw模型对象
     * @var \app\admin\model\Withdraw
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Withdraw;
        $this->view->assign("statusList", $this->model->getStatusList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

    public function detail($id = null){
        if(!$id){
            $this->error(__('Request Error'));
        }
        $row = $this->model->find($id);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $payment = new \app\admin\model\Receivpayments();
        $paymentInfo = $payment->where(["id"=>$row->paymentid])->find();
        $userInfo = User::where(["id"=>$paymentInfo->user_id])->find();
        //dump($userInfo);
        $this->view->assign("data", $row);
        $this->view->assign("user", $userInfo);
        $this->view->assign("pay", $paymentInfo);
        return $this->view->fetch();
    }

    //设置订单黑名单
    public function setblack(){
        if($this->request->isPost()){
            $id = $this->request->post("id");
            $with = $this->model->where("id",$id)->find();
            if(!$with){
                $this->error(__("Not found with"));
            }
            if($with->status == -2 || $with->status == 1 || $with->status == 2){
                $this->error(__('Status error'));
            }
            Db::startTrans();
            try {
                $arr = ["status" => -2];
                $this->model->where("id",$id)->update($arr);
                Db::commit();
                $this->success();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
        }else{
            $this->error(__('Request Error'));
        }
    }

    //驳回
    public function setturn(){
        if($this->request->isPost()){
            $id = $this->request->post("id");
            $remark = $this->request->post("remark");
            $with = $this->model->where("id",$id)->find();
            if(!$with){
                $this->error(__("Not found with"));
            }
            if($with->status == -2 || $with->status == -1 || $with->status == 1 || $with->status == 2){
                $this->error(__('Status error'));
            }
            Db::startTrans();
            try {
                $arr = ["status" => -1,"message" => $remark];
                $this->model->where("id",$id)->update($arr);
                Db::commit();
                $this->success();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
        }else{
            $this->error(__('Request Error'));
        }
    }

    //驳回
    public function auditsuccess(){
        if($this->request->isPost()){
            $id = $this->request->post("id");
            $with = $this->model->where("id",$id)->find();
            if(!$with){
                $this->error(__("Not found with"));
            }
            if($with->status == -2 || $with->status == -1 || $with->status == 1 || $with->status == 2){
                $this->error(__('Status error'));
            }
            Db::startTrans();
            try {
                $arr = ["status" => 1];
                $this->model->where("id",$id)->update($arr);
                Db::commit();
                $this->success();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
        }else{
            $this->error(__('Request Error'));
        }
    }

    //驳回
    public function payment(){
        if($this->request->isPost()){
            $id = $this->request->post("id");
            $remark = $this->request->post("remark");
            $with = $this->model->where("id",$id)->find();
            if(!$with){
                $this->error(__("Not found with"));
            }
            if($with->status == -2 || $with->status == -1 || $with->status == 0 || $with->status == 2){
                $this->error(__('Status error'));
            }
            Db::startTrans();
            try {
                $arr = ["status" => 2,"block" => $remark,'paytime'=>time()];
                $this->model->where("id",$id)->update($arr);
                Db::commit();
                $this->success();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
        }else{
            $this->error(__('Request Error'));
        }
    }
}
