<?php
namespace app\admin\controller;

use app\admin\model\MenuModel;
use app\admin\model\NodeModel;
use app\admin\model\RoleModel;
use \think\Request;
use \think\Db;

class Role extends Base {

    public function index(){

        $key = input('key');
        $map = [];
        if($key&&$key!=="")
        {
            $map['title'] = ['like',"%" . $key . "%"];
        }
        $user = new RoleModel();
        $page = input('get.page') ? input('get.page'):1;
        $limits = 10;// 获取总条数

        if(input('get.page'))
        {
            $lists = $user->getRolePageByWhere($map, $page, $limits);
            return json($lists);
        }

        $count = $user->getCountByWhere($map);  //总数据
        $total_page = intval(ceil($count / $limits));

        $this->assign('page', $page); //当前页
        $this->assign('total_page', $total_page); //总页数
        $this->assign('val', $key);

        return $this->fetch();
    }

    public function add_role()
    {
        if(request()->isAjax()){
            $param = input('post.');
            $role = new RoleModel();
            $flag = $role->insertRole($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }

        return $this->fetch('add');
    }

    public function edit_role()
    {
        $request = Request::instance();
        $roleModel = new RoleModel();
        if($request->isAjax()){
            $role = $request->post();
            $result = $roleModel->updateRole($role);
            return json($result);
        }
        $id = $request->param('id');
        $role = $roleModel->getOneRole($id);
        $this->assign(['role'=>$role]);
        return $this->fetch('edit');
    }

    public function role_status()
    {
        $id = input('param.id');
        $status = Db::name('auth_group')->where('id',$id)->value('status');//判断当前状态情况
        if($status==1)
        {
            $flag = Db::name('auth_group')->where('id',$id)->setField(['status'=>0]);
            return json(['code' => 1, 'data' => $flag['data'], 'msg' => '已禁止']);
        }
        else
        {
            $flag = Db::name('auth_group')->where('id',$id)->setField(['status'=>1]);
            return json(['code' => 0, 'data' => $flag['data'], 'msg' => '已开启']);
        }
    }

    public function permission()
    {
        $param = input('param.');
        $node = new MenuModel();
        //获取现在的权限
        if('get' == $param['type']){
            $nodeStr = $node->getNodeInfo($param['id']);
            return json(['code' => 1, 'data' => $nodeStr, 'msg' => 'success']);
        }
        //分配新权限
        if('push' == $param['type']){

            $doparam = [
                'id' => $param['id'],
                'rules' => $param['rule']
            ];
            $user = new RoleModel();
            $flag = $user->editAccess($doparam);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }
    }
}