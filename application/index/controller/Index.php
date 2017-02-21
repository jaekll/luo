<?php
namespace app\index\controller;

use think\response\Json;

class Index
{
    public function index()
    {
        $str ='皇上您这是有喜了';
        $str_arr = $this->str_arr($str);
        return Json::create($str_arr);

    }

    private function str_arr($str){
        $len = mb_strlen($str,'utf-8');
        $str_Arr=[];
        for($i = 0;$i< $len;$i++){
            array_push($str_Arr,mb_substr($str,$i,1));
        }

        return $str_Arr;
    }
}
