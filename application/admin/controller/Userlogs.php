<?php

namespace app\admin\controller;
use app\admin\model\Admin;
use app\admin\model\tg\User;
use app\common\controller\Backend;
use app\common\library\Manticore;
use app\common\library\Meilisearch;

class Userlogs extends Backend
{
    protected $client = null;

    public function _initialize()
    {
        parent::_initialize();
        // 初始化 Manticoresearch 客户端
        $ManClient = new Meilisearch();
        $this->client = $ManClient->getClient();

    }

    /**
     * 查看
     */
    public function index()
    {
        // 设置过滤方法
        $this->request->filter(['strip_tags', 'trim']);
        if ($this->request->isAjax()) {
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $options = [
                'limit' => 20, // 每页返回的文档数量
                'offset' => 0,   // 从哪个文档开始返回
            ];
            // 构建 Manticoresearch 查询
            //$index = 'user_logs'; // 替换为你的 Manticoresearch 索引名称
            //if (!empty($where)) {
            //    if (isset($where['user_id'])) {
                    //$options['filter'] = "user = 1";
            //    }
            //}
            $index = $this->client->index("user_logs")->search('', $options);
            //dump($index->getHits());exit();
            $list = $index->getHits(); // 获取数据源
            $i = 0;
            foreach ($list as $item) {
                //dump($item['user']);
                $UserData = User::where(['id'=> $item['user']])->find();
                //dump($UserData);
                if($UserData) {
                    $list[$i]["user"] = $UserData->tid . "-" . $UserData->tusername . "-" . $UserData->tnick;
                }else{
                    $list[$i]["user"] = "Not Found UserInfo";
                }
                $admin = Admin::where('id', $item['admin'])->find();
                if($admin) {
                    $list[$i]["admin"] = $admin->nickname;
                }else{
                    $list[$i]["admin"] = "Not Found AdminInfo";
                }
                $i++;
            }
            $total = $index->count();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 导出
     */
    public function export()
    {
        $search = $this->request->get('search');
        // 构建 Manticoresearch 查询
        $index = 'user_logs'; // 替换为你的 Manticoresearch 索引名称
        $query = $this->client->index($index)->search(''); // 初始查询
        // 添加搜索条件
        if ($search) {
            $query->match('user_id', $search); // 假设 user_id 是一个可搜索的字段
        }

        // 执行查询
        $result = $query->execute();

        $list = [];
        foreach ($result['hits']['hits'] as $hit) {
            $list[] = $hit['_source']; // 获取数据源
        }
        // 实例化 Spreadsheet
        $spreadsheet = new Spreadsheet();

        // 获取当前活动的工作表
        $sheet = $spreadsheet->getActiveSheet();

        // 设置表头
        $sheet->setCellValue('A1', 'ID');
        $sheet->setCellValue('B1', 'User ID');
        $sheet->setCellValue('C1', 'Admin ID');
        $sheet->setCellValue('D1', 'Action Type');
        $sheet->setCellValue('E1', 'Action Detail');
        $sheet->setCellValue('F1', 'Before Status');
        $sheet->setCellValue('G1', 'After Status');
        $sheet->setCellValue('H1', 'Balance Change');
        $sheet->setCellValue('I1', 'Frozen Balance Change');
        $sheet->setCellValue('J1', 'Transaction ID');
        $sheet->setCellValue('K1', 'IP Address');
        $sheet->setCellValue('L1', 'User Agent');
        $sheet->setCellValue('M1', 'Create Time');

        // 写入数据
        $row = 2;
        foreach ($list as $item) {
            $sheet->setCellValue('A' . $row, $item['id']);
            $sheet->setCellValue('B' . $row, $item['user_id']);
            $sheet->setCellValue('C' . $row, $item['admin_id']);
            $sheet->setCellValue('D' . $row, $item['action_type']);
            $sheet->setCellValue('E' . $row, $item['action_detail']);
            $sheet->setCellValue('F' . $row, $item['before_status']);
            $sheet->setCellValue('G' . $row, $item['after_status']);
            $sheet->setCellValue('H' . $row, $item['balance_change']);
            $sheet->setCellValue('I' . $row, $item['frozen_balance_change']);
            $sheet->setCellValue('J' . $row, $item['transaction_id']);
            $sheet->setCellValue('K' . $row, $item['ip_address']);
            $sheet->setCellValue('L' . $row, $item['user_agent']);
            $sheet->setCellValue('M' . $row, $item['create_time']);
            $row++;
        }

        // 创建 Excel writer
        $writer = new Xlsx($spreadsheet);

        // 设置 header
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="user_logs.xlsx"');
        header('Cache-Control: max-age=0');

        // 输出到浏览器
        $writer->save('php://output');
        exit;
    }


    /**
     * 构建搜索参数
     */
    /*protected function buildparams($relation = TRUE)
    {
        $search = $this->request->get("search", '');
        $where = [];
        if ($search) {
            $where['user_id'] = $search; // Manticoresearch 中直接传递搜索词
        }
        list($where, $sort, $order, $offset, $limit) = parent::buildparams($relation);
        return [$where, $sort, $order, $offset, $limit];
    }*/
}