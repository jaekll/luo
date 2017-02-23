<?php
namespace app\admin\controller;

use \org\LeftNav;
use \app\admin\model\MenuModel;

/**
 * @description
 * 本系统的菜单等价用户权限
 * Class Menu
 * @package app\admin\controller
 */
class Menu extends Base  {

    //菜单列表
    public function index(){
        $menu = new MenuModel();
        $admin_rule = $menu->getAll();
        $arr = $this->leftNav($admin_rule);
        $this->assign('admin_rule',$arr);
        return $this->fetch();
    }

    public function add_menu(){
        if(request()->isAjax()){
            $param = input('post.');
            $menu = new MenuModel();
            $flag = $menu->add($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }
        return $this->fetch();
    }

    public function edit_menu()
    {
        $menu = new MenuModel();
        if(request()->isPost()){
            $param = input('post.');
            $flag = $menu->edit($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }
        $id = input('param.id');
        $this->assign('menu',$menu->getOne($id));
        return $this->fetch('edit');
    }

    public function del_menu()
    {
        $id = input('param.id');
        $menu = new MenuModel();
        $flag = $menu->del($id);
        return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
    }

    public function sort_menu()
    {
        $data = input('post.');
        $menuModel = new MenuModel();
        $result = $this->order($menuModel,$data);
        return json($result);
    }

    private  function leftNav($cate , $lefthtml = '— — ' , $pid=0 , $lvl=0, $leftpin=0 ){
        $arr=array();
        foreach ($cate as $v){
            if($v['pid']==$pid){
                $v['lvl']=$lvl + 1;
                $v['leftpin']=$leftpin + 0;//左边距
                $v['lefthtml']=str_repeat($lefthtml,$lvl);
                $arr[]=$v;
                $arr= array_merge($arr,$this->leftNav($cate,$lefthtml,$v['id'],$lvl+1 , $leftpin+20));
            }
        }
        return $arr;
    }
}