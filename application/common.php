<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

//+--------------------------------
//+无限极分类算法
//+--------------------------------
function getMenuTree($list){

    $return = [];//索引目录
    $parent='';//根目录,

    //数组预处理,这里的$v['id']一定要唯一,不然可能会出现被覆盖的情况
    foreach ($list as $v){
        $return[$v['id']] = [
            'id' => $v['id'],
            'name' => $v['name'],
            'pid' => $v['pid'],
            'child' => '',
        ];
    }


    //将每个目录与父目录进行拼接,并找到根目录
    foreach ($return as $k=>$v) {
        if ($v['pid'] > 0)
    //找到父路径,这里没有判断 $return[$v['pid']]['child']是否存在,
    //TP5下或者在不存在的情况下可能会报错,自己加一下
            $return[$v['pid']]['child'][$v['id']] = &$return[$k];
        else
    //找到根目录
            $parent = &$return[$k];
    }

    //打印根目录
    //var_export($parent);
    return $parent;
}

//字符串转数组
function strToArr($str){
    $len = mb_strlen($str,'utf-8');
    $str_Arr=[];
    for($i = 0;$i< $len;$i++){
        array_push($str_Arr,mb_substr($str,$i,1));
    }

    return $str_Arr;
}
