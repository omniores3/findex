<?php
namespace app\index\behavior;
use app\admin\model\tg\User;
class UserPre
{
    //用户注册行为前置方法
    public static function run($tid,$bot)
    {
        $user = User::where('tid', $tid)->find();
        $mode = null;
        $buttonjson = null;
        if($user){
            $isd = false;
            switch($user->status){
                case -1:
                    try{
                        $result = getTips("actionblack",$user->lang);
                        $mode = $result->mode;
                        $buttonjson = $result->buttons;
                        $text = $result->text;
                    }catch(\Exception $e){
                        $text = $e->getMessage();
                    }
                    $isd = true;
                    break;
                case 0:
                    try{
                        $result = getTips("actiondisable",$user->lang);
                        $mode = $result->mode;
                        $buttonjson = $result->buttons;
                        $text = $result->text;
                    }catch(\Exception $e){
                        $text = $e->getMessage();
                    }
                    $isd = true;
                    break;
            }
            if($isd) {
                $buttonObj = getButtons($mode, $buttonjson);
                $bot->sendMessage($tid, $text, "MarkDown", true, null, $buttonObj);
                exit();
            }
        }
    }
}