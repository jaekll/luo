<?php
use think\Db;

/**
 * 将字符解析成数组
 * @param $str
 * @return array
 */
function parseParams($str)
{
    $arrParams = [];
    parse_str(html_entity_decode(urldecode($str)), $arrParams);
    return $arrParams;
}


/**
 * 子孙树 用于菜单整理
 * @param $param
 * @param int $pid
 * @return array
 */
function subTree($param, $pid = 0)
{
    static $res = [];
    foreach($param as $key=>$vo){

        if( $pid == $vo['pid'] ){
            $res[] = $vo;
            subTree($param, $vo['id']);
        }
    }

    return $res;
}


/**
 * 记录日志
 * @param  [type] $uid         [用户id]
 * @param  [type] $username    [用户名]
 * @param  [type] $description [描述]
 * @param  [type] $status      [状态]
 * @return mixed
 */
function log_db($uid,$username,$description,$status)
{

    $data['admin_id'] = $uid;
    $data['admin_name'] = $username;
    $data['description'] = $description;
    $data['status'] = $status;
    $data['ip'] = request()->ip();
    $data['add_time'] = time();
    $log = Db::name('Log')->insert($data);
    return true;
}


/**
 * 无限极菜单树方法
 * @param $param
 * @return array
 */
function prepareMenu($param)
{
    $parent = []; //父类
    $child = [];  //子类

    foreach($param as $key=>$vo){

        if($vo['pid'] == 0){
            $vo['href'] = '#';
            $parent[] = $vo;
        }else{
            $vo['href'] = url($vo['name']); //跳转地址
            $child[] = $vo;
        }
    }

    foreach($parent as $key=>$vo){
        foreach($child as $k=>$v){

            if($v['pid'] == $vo['id']){
                $parent[$key]['child'][] = $v;
            }
        }
    }
    unset($child);
    return $parent;
}

function MenuTree($param){
    $return = [];
    $parent = [];


    foreach($param  as $vo){
        if($vo['status'] == 1){
            if($vo['name'] == '#'){
                $return[$vo['id']]= [
                    'id'=>$vo['id'],
                    'name'=>$vo['name'],
                    'title'=>$vo['title'],
                    'pid'=>$vo['pid'],
                    'css'=>$vo['css'],
                    'href'=>'#',
                    'child'=>''
                ];
            }else{
                $return[$vo['id']]= [
                    'id'=>$vo['id'],
                    'name'=>$vo['name'],
                    'title'=>$vo['title'],
                    'css'=>$vo['css'],
                    'pid'=>$vo['pid'],
                    'href'=>url($vo['name']),
                    'child'=>''
                ];
            }
        }
    }

    foreach($return as $k=>$v){
        if($v['pid'] > 0){
            $return[$v['pid']]['child'][$v['id']] = &$return[$k];
        }else{
            $parent[] = &$return[$k];
        }
    }

    return $parent;
}


/**
 * 格式化字节大小
 * @param  number $size      字节数
 * @param  string $delimiter 数字和单位分隔符
 * @return string            格式化后的带单位的大小
 */
function format_bytes($size, $delimiter = '') {
    $units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    for ($i = 0; $size >= 1024 && $i < 5; $i++) {
        $size /= 1024;
    }
    return $size . $delimiter . $units[$i];
}

 // 分析枚举类型配置值 格式 a:名称1,b:名称2
function parse_config_attr($string) {
    $array = preg_split('/[,;\r\n]+/', trim($string, ",;\r\n"));
    if(strpos($string,':')){
        $value  =   array();
        foreach ($array as $val) {
            list($k, $v) = explode(':', $val);
            $value[$k]   = $v;
        }
    }else{
        $value  =   $array;
    }
    return $value;
}
