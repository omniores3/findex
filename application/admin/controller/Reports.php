<?php

namespace app\admin\controller;

use app\admin\model\MeilisearchCommon;
use app\admin\model\tg\User;
use app\common\controller\Backend;
use think\Db;
use think\exception\DbException;
use think\response\Json;

/**
 * 举报列管理
 *
 * @icon fa fa-circle-o
 */
class Reports extends Backend
{

    /**
     * Reports模型对象
     * @var \app\admin\model\Reports
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Reports;
        $this->view->assign("statusList", $this->model->getStatusList());
    }



    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

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
            ->with(["report","tgUser"])
            ->where($where)
            ->order($sort, $order)
            ->paginate($limit);
        $result = ['total' => $list->total(), 'rows' => $list->items()];
        return json($result);
    }


    public function setblack(){
        if($this->request->isPost()){
            $id = (int)trim($this->request->post('id'));
            Db::startTrans();
            try {
                $repInfo = $this->model->where('id', $id)->find();
                if(!$repInfo){
                    $this->error(__('This report does not exist'));
                }
                if($repInfo->status == '-2' || $repInfo->status == '1'){
                    $this->error(__('Status_error'));
                }
                $this->model->where('id', $id)->update(["status" => "-2","updatetime"=>time()]);
                Db::commit();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
            $this->success("success");
        }else{
            $this->error(__('Request Error'));
        }
    }


    public function setturn(){
        if($this->request->isPost()){
            $id = (int)trim($this->request->post('id'));
            $remark = (string)trim($this->request->post('remark'));
            Db::startTrans();
            try {
                $repInfo = $this->model->where('id', $id)->find();
                if(!$repInfo){
                    $this->error(__('This report does not exist'));
                }
                if($repInfo->status == '-2' || $repInfo->status == '1' || $repInfo->status == '-1'){
                    $this->error(__('Status_error'));
                }
                $this->model->where('id', $id)->update(["status" => "-1","message"=>$remark,"updatetime"=>time()]);
                Db::commit();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
            $this->success("success");
        }else{
            $this->error(__('Request Error'));
        }
    }


    public function setsuccess(){
        if($this->request->isPost()){
            $id = (int)trim($this->request->post('id'));
            Db::startTrans();
            try {
                $repInfo = $this->model->where('id', $id)->find();
                if(!$repInfo){
                    $this->error(__('This report does not exist'));
                }
                if($repInfo->status == '-2' || $repInfo->status == '1'){
                    $this->error(__('Status_error'));
                }
                $this->model->where('id', $id)->update(["status" => "1","updatetime"=>time()]);
                Db::commit();
            }catch (\Exception $e){
                Db::rollback();
                $this->error($e->getMessage());
            }
            $this->success("success");
        }else{
            $this->error(__('Request Error'));
        }
    }


    public function detail($id){
        if(!$id){
            $this->error(__('Request Error'));
        }
        $row = $this->model->find($id);
        if (!$row) {
            $this->error(__('No Results were found'));
        }
        $report = \app\admin\model\Report::find($row->report_id);
        $userInfo = User::where(["id"=>$row->user_id])->find();
        $Meili = new MeilisearchCommon("groups");
        $groupInfo = $Meili->GeneralQuer('',"id = '".$row->groups_id."'");
        //dump($groupInfo);exit();
        $this->view->assign("data", $row);
        $this->view->assign("user", $userInfo);
        $this->view->assign("report", $report);
        $this->view->assign("group", $groupInfo["data"][0]);
        return $this->view->fetch();
    }
}
