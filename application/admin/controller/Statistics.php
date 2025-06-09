<?php

namespace app\admin\controller;

use app\common\controller\Backend;

class Statistics extends Backend
{

    protected $noNeedRight = []; // 需要验证权限的方法
    /**
     * 显示资源列表
     *
     * @return \think\Response
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            // 处理AJAX请求，返回统计数据
            $data = [
                'user_count' => 1000,
                'order_count' => 500,
                'revenue' => 250000
            ];
            return json(['data' => $data]);
        }

        return $this->view->fetch();
    }

    /**
     * 显示创建资源表单页.
     *
     * @return \think\Response
     */
    public function create()
    {
        //
    }


}
