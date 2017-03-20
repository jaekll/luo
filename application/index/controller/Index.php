<?php
namespace app\index\controller;

use think\response\Json;

class Index
{
    public function index()
    {
//        $str ='皇上您这是有喜了';
//        $str_arr = strToArr($str);
//        return Json::create($str_arr);


        $list[] = ['id' => 1, 'pid' => 0, 'name' => 'A@0'];
//-1用于后面的根目录判断
//你也可以修改为0并修改后面的 if ($v['pid'] >= 0) 为  if ($v['pid'] > 0)
//数据库id应该不会出现等于0的情况吧
        $list[] = ['id' => 2, 'pid' => 1, 'name' => 'A@1'];
        $list[] = ['id' => 3, 'pid' => 1, 'name' => 'A@2'];
        $list[] = ['id' => 4, 'pid' => 3, 'name' => 'A@3'];
        $list[] = ['id' => 5, 'pid' => 4, 'name' => 'A@4'];
        $list[] = ['id' => 6, 'pid' => 1, 'name' => 'A@5'];
        $list[] = ['id' => 7, 'pid' => 6, 'name' => 'A@6'];

        dump(getMenuTree($list));
    }


}
