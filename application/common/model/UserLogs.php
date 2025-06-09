<?php

namespace app\common\model;

class UserLogs
{
    public function getModeList(){
        return "";
    }


    public static function getUserLogsData(){
        $logData = [
            "id" => uniqid(),
            "user" => null,
            "admin" => null,
            "action_type" => "",      //操作类型
            "action_detail" => "",    //操作说明
            "before_status" => "",    //操作前状态
            "after_status" => "",     //操作后状态
            "balance_before_change" => null, //操作前余额
            "balance_after_change" => null,  //操作后余额
            "balance_change" => null, //操作得余额
            "frozen_before_balance_change" => null,   //操作前冻结余额
            "frozen_after_balance_change" => null,    //操作后冻结余额
            "frozen_change" => null,  //操作的冻结余额
            "transaction" => '',   //订单ID
            "create_time" => time(),
        ];
        return $logData;
    }
}