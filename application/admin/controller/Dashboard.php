<?php

namespace app\admin\controller;

use app\admin\controller\tg\User as TgUser;
use app\admin\model\Admin;
use app\admin\model\tg\User as ModelTgUser;
use app\admin\model\User;
use app\common\controller\Backend;
use app\common\library\Meilisearch;
use app\common\model\Attachment;
use fast\Date;
use think\Db;

/**
 * 控制台
 *
 * @icon   fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    /**
     * 查看
     */
    public function index()
    {
        try {
            \think\Db::execute("SET @@sql_mode='';");
        } catch (\Exception $e) {

        }
        $column = [];
        $starttime = Date::unixtime('day', -6);
        $endtime = Date::unixtime('day', 0, 'end');
        $joinlist = Db("tg_user")->where('create_time', 'between time', [$starttime, $endtime])
            ->field('create_time, status, COUNT(*) AS nums, DATE_FORMAT(FROM_UNIXTIME(create_time), "%Y-%m-%d") AS join_date')
            ->group('join_date')
            ->select();
        for ($time = $starttime; $time <= $endtime;) {
            $column[] = date("Y-m-d", $time);
            $time += 86400;
        }
        $userlist = array_fill_keys($column, 0);
        foreach ($joinlist as $k => $v) {
            $userlist[$v['join_date']] = $v['nums'];
        }

        $dbTableList = Db::query("SHOW TABLE STATUS");
        $addonList = get_addon_list();
        $totalworkingaddon = 0;
        $totaladdon = count($addonList);
        foreach ($addonList as $index => $item) {
            if ($item['state']) {
                $totalworkingaddon += 1;
            }
        }
        $this->view->assign([

            'totaluser'         => ModelTgUser::count(),
            'totaladdon'        => $totaladdon,
            'totaladmin'        => Admin::count(),
            'totalcategory'     => \app\common\model\Category::count(),
            'todayusersignup'   => ModelTgUser::whereTime('create_time', 'today')->count(),
            'todayuserlogin'    => ModelTgUser::whereTime('update_time', 'today')->count(),
            'sevendau'          => ModelTgUser::whereTime('create_time|update_time', '-7 days')->count(),
            'thirtydau'         => ModelTgUser::whereTime('create_time|update_time', '-30 days')->count(),
            'threednu'          => ModelTgUser::whereTime('create_time', '-3 days')->count(),
            'sevendnu'          => ModelTgUser::whereTime('create_time', '-7 days')->count(),
            'dbtablenums'       => count($dbTableList),
            'dbsize'            => array_sum(array_map(function ($item) {
                return $item['Data_length'] + $item['Index_length'];
            }, $dbTableList)),
            'totalworkingaddon' => $totalworkingaddon,
            'attachmentnums'    => Attachment::count(),
            'attachmentsize'    => Attachment::sum('filesize'),
            'picturenums'       => Attachment::where('mimetype', 'like', 'image/%')->count(),
            'picturesize'       => Attachment::where('mimetype', 'like', 'image/%')->sum('filesize'),
        ]);


        $recharge = new \app\admin\model\Recharge();
        $rechargeCount = $recharge->count();  //总充值订单数量
        $rechargePaySuccessCount = $recharge->where(['status'=> "1"])->count(); //总支付成功订单数量
        $rechargeOrderAmountCount = $recharge->sum('amount');   //总下单金额
        $rechargeOrderPaySuccessAmountCount = $recharge->where(['status'=> "1"])->sum('amount');   //总下单支付成功金额
        $rechargePayAmountCount = $recharge->sum('money');   //总下单金额
        $rechargePaySuccessAmountCount = $recharge->where(['status'=> "1"])->sum('money');   //总下单支付成功金额

        $rechargeCountDay = $recharge->whereTime('createtime', 'today')->count();  //总充值订单数量
        $rechargePaySuccessCountDay = $recharge->where(['status'=> "1"])->whereTime('createtime', 'today')->count(); //总支付成功订单数量
        $rechargeOrderAmountCountDay = $recharge->whereTime('createtime', 'today')->sum('amount');   //总下单金额
        $rechargeOrderPaySuccessAmountCountDay = $recharge->where(['status'=> "1"])->whereTime('createtime', 'today')->sum('amount');   //总下单支付成功金额
        $rechargePayAmountCountDay = $recharge->whereTime('createtime', 'today')->sum('money');   //总下单金额
        $rechargePaySuccessAmountCountDay = $recharge->where(['status'=> "1"])->whereTime('createtime', 'today')->sum('money');   //总下单支付成功金额

        $rech = [
            "rechargeCount" => $rechargeCount,
            "rechargePaySuccessCount" => $rechargePaySuccessCount,
            "rechargeOrderAmountCount" => number_format($rechargeOrderAmountCount,4),
            "rechargeOrderPaySuccessAmountCount" => number_format($rechargeOrderPaySuccessAmountCount,4),
            "rechargePayAmountCount" => number_format($rechargePayAmountCount,4),
            "rechargePaySuccessAmountCount" => number_format($rechargePaySuccessAmountCount,4),

            "rechargeCountDay" => $rechargeCountDay,
            "rechargePaySuccessCountDay" => $rechargePaySuccessCountDay,
            "rechargeOrderAmountCountDay" => number_format($rechargeOrderAmountCountDay,4),
            "rechargeOrderPaySuccessAmountCountDay" => number_format($rechargeOrderPaySuccessAmountCountDay,4),
            "rechargePayAmountCountDay" => number_format($rechargePayAmountCountDay,4),
            "rechargePaySuccessAmountCountDay" => number_format($rechargePaySuccessAmountCountDay,4),
        ];


        $ManClient = new Meilisearch();
        $client = $ManClient->getClient();
        $options = [
            //'attributesToSearch' => ['id', 'user','group','groupname','groupusername','grouptype'], // 指定搜索字段
            //'matchingStrategy' => 'all' ,// 匹配策略
            //'sort' => ["addtime desc"],
            'limit' => 1, // 每页返回的文档数量
            'offset' => 0,   // 从哪个文档开始返回
        ];
        $index = $client->index("groups")->search("",$options );

        $total = $index->getRaw()["estimatedTotalHits"];


        $advlist = \app\admin\model\Advlist::count();

        $DeliveryAdvList = \app\admin\model\Advlist::where(["status"=>"2"])->count();

        $keycount = \app\admin\model\Keyword::count();

        $keyAdvCount = \app\admin\model\Advkey::where(["status"=>"0"])->count();

        $PendingCount = \app\admin\model\Withdraw::where(["status"=>"0"])->count();

        $PendingAmount = \app\admin\model\Withdraw::where(["status"=>"0"])->sum("amount");

        $this->assign('PendingAmount',$PendingAmount);

        $this->assign('PendingCount',$PendingCount);

        $this->assign('keyAdvCount',$keyAdvCount);
        $this->assign('keycount',$keycount);

        $this->assign("advlist",$advlist);

        $this->assign("DeliveryAdvList",$DeliveryAdvList);

        $this->assign('totalgroups',$total);
        $this->assign('recharge',$rech);

        $this->assignconfig('column', array_keys($userlist));
        $this->assignconfig('userdata', array_values($userlist));

        return $this->view->fetch();
    }

    public function getserverinfo(){
        $data = [
            'cpu' => $this->getCpuInfo(),
            'memory' => $this->getMemoryInfo(),
            'disk' => $this->getDiskInfo(),
            'network' => $this->getNetworkInfo(),
        ];

        return json($data); // 返回 JSON 数据
    }

    private function getCpuInfo()
    {
        // 获取 CPU 信息 (Linux)
        if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            return '不支持在Windows系统获取CPU信息';
        }
        $cpu_load = sys_getloadavg();
        return [
            'load' => $cpu_load,
            'cores' => shell_exec('nproc'), // 需要安装 nproc 命令
        ];
    }

    private function getMemoryInfo()
    {
        // 获取内存信息 (Linux)
        if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            return '不支持在Windows系统获取内存信息';
        }
        $free = shell_exec('free -m');
        $free = (string)trim($free);
        $free_arr = explode("\n", $free);
        $mem = explode(" ", str_replace("Mem:", "", $free_arr[1]));
        $mem = array_filter($mem);
        $mem = array_merge($mem);

        $memory_usage = round($mem[2] / $mem[1] * 100, 2);

        return [
            'total' => $mem[1],
            'used' => $mem[2],
            'free' => $mem[3],
            'usage' => $memory_usage,
        ];
    }

    private function getDiskInfo()
    {
        // 获取硬盘信息
        $total = disk_total_space("/");
        $free = disk_free_space("/");
        $disk_usage = round(($total - $free) / $total * 100, 2);
        return [
            'total' => $this->formatBytes($total),
            'free' => $this->formatBytes($free),
            'usage' => $disk_usage,
        ];
    }

     private function getNetworkInfo()
    {
        // 获取网络信息 (需要更多实现，例如读取 /proc/net/dev 文件)
         if (strtoupper(substr(PHP_OS, 0, 3)) === 'WIN') {
            return '不支持在Windows系统获取网络信息';
        }
        return '需要更多实现才能获取准确带宽信息';
    }


    private function formatBytes($bytes, $precision = 2) {
        $units = ['B', 'KB', 'MB', 'GB', 'TB'];

        $bytes = max($bytes, 0);
        $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
        $pow = min($pow, count($units) - 1);

        $bytes /= (1 << (10 * $pow));

        return round($bytes, $precision) . ' ' . $units[$pow];
    }


    public function getupdate(){
        try {
            check_update();
        }catch(\think\Exception $e){
            echo $e->getMessage();
        }
    }

}
