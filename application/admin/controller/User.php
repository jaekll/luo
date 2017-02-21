<?php
namespace app\admin\controller;
use app\admin\model\RoleModel;
use app\admin\model\UserModel;
use think\Request;
use think\Db;

/**
 * 后台管理用户操作类
 * Class User
 * @package app\admin\controller
 */
class User extends Base {

    /**
     *用户列表
     */
    public function index()
    {

        $name = input('key');
        $where = [];

        if($name && $name !== ''){
            $where['username'] = ['like','%'.$name.'%'];
            $this->assign('name',$name);
        }
        $page = input('get.page') ? input('get.page' ): 1;
        $limit = 15;
        $userModel = new UserModel();

        if(input('get.page')){

            $userList = $userModel->getUserByWhere($where,$page,$limit);
            foreach ($userList as $key=>$value){
                $userList[$key]['last_login_time'] = date('Y-m-d H:i:s',$value['last_login_time']);
            }
            return json($userList);
        }

        $count = $userModel->getCountByWhere($where);
        $total_page = intval(ceil($count / $limit));
        $this->assign('page',$page);
        $this->assign('total_page',$total_page);
        return $this->fetch();
    }

    /**
     *添加用户
     */
    public function add_user()
    {
        $request = Request::instance();
        if($request->isAjax()){
            $userInfo = $request->post();
            $user = new UserModel();
            $res = $user->add($userInfo);

            if($res['code'] !== 1){
                return json($res);
            }
            $access_data = array(
                'uid'=> $user['id'],
                'group_id'=> $userInfo['group_id'],
            );

            $status = $user->addAccess($access_data);
            if($status['code'] === 0){
                return json($status);
            }
            return json(['code' => $res['code'], 'data' => $res['data'], 'msg' => $res['msg']]);
        }
        $role = new RoleModel();
        $roleList = $role->getRoles('id,title');
        $this->assign('roles',$roleList);
        return $this->fetch('add');

    }

    /**
     *编辑用户
     */
    public function edit_user(){
        $request = Request::instance();
        $user = new UserModel();

        if($request->isAjax()){

            $param = $request->post();

            if(empty($param['password'])){
                unset($param['password']);
            }else{
                $param['password'] = md5(md5($param['password']) . config('auth_key'));
            }
            unset($param['file']);
            $flag = $user->editUser($param);
            if($flag['code'] < 1){
                return json($flag);
            }
            $status = $user->updateAccess($user['id'],$param['group_id']);
            if($status['code'] !== 0){
                return json($status);
            }
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }


        $id = $request->param('id');
        $role = new RoleModel();
        $this->assign([
            'user' => $user->getOne($id),
            'role' => $role->getRole()
        ]);
        return $this->fetch('edit');
    }

    /**
     *禁用用户
     */
    public function del_user(){
        $request = Request::instance();
        $uid = $request->get('id');
        $user = new UserModel();
        $result = $user->delOne($uid);
        return json($result);
    }

    /**
     * @return \think\response\Json
     */
    public function user_state()
    {
        $uid = input('param.id');
        $user = new UserModel();
        $user->status($uid);
    }
}