<?php

namespace app\admin\controller;

use think\Controller;
use \think\Db;
use \think\Queue;
use \com\IpLocation;

class Log extends Base
{
    /**
     * 显示资源列表
     *
     * @return \think\Response
     */
    public function loglist()
    {
        $key = input('key');
        $where = [];
        if($key&&$key!==""){
            $where['admin_id'] =  $key;
        }
        $page = input('get.page') ? input('get.page'):1;
        $limits = 10;// 获取总条数
        $lists = Db::name('log')->where($where)->page($page, $limits)->order('add_time desc')->select();
        $Ip = new IpLocation('UTFWry.dat'); // 实例化类 参数表示IP地址库文件
        foreach($lists as $k=>$v){
            $lists[$k]['add_time']=date('Y-m-d H:i:s',$v['add_time']);
            $lists[$k]['ipaddr'] = $Ip->getlocation($lists[$k]['ip']);
        }

        if(input('get.page')){
            return json($lists);
        }
        $count = Db::name('log')->where($where)->count();//计算总页面
        $allpage = intval(ceil($count / $limits));
        $arr=Db::name("admin")->column("id,username"); //获取用户列表
        $this->assign('Nowpage', $page); //当前页
        $this->assign('allpage', $allpage); //总页数
        $this->assign('count', $count);
        $this->assign("search_user",$arr);
        $this->assign('val', $key);
        return $this->fetch('list');
    }


    /**
     * 删除指定资源
     *
     * @param  int  $id
     * @return \think\Response
     */
    public function delete($id)
    {
        Queue::later(900,'app\admin\jobs\Task@task1','flush','jack');
    }
}
