<?php
namespace app\admin\controller;

use app\admin\model\Role;
use app\admin\model\RoleModel;
use app\admin\model\UserModel;
use org\Verify;
use think\Controller;
use think\Db;
use com\Geetestlib;

class Login extends Controller{

    public function login(){
        cache('app_begin','6666',0);
        cache('keymap','123',6);
        cache('keyvalue','456',6);
        return $this->fetch('/login');
    }

    public function dologin()
    {
        $username = input('param.username');
        $password = input('param.password');
        $code = input('param.code');

        //验证用户输入
        $result = $this->validate(compact('username','password','code'),'AdminValidate');
        if($result !== true){
            return json(['code' => -5, 'url' => '', 'msg' => $result]);
        }

        //验证验证码
        $verify = new Verify();
        if (config('verify_type') == 1) {
            if (!$verify->check($code)) {
                return json(['code' => -4, 'url' => '', 'msg' => '验证码错误']);
            }
        }

        //验证用户名密码
        $user = new UserModel();
        $hasUser = $user->getOneByName($username);
        if(empty($hasUser) || md5(md5($password) . config('auth_key')) != $hasUser['password']){
            return json(['code' => -1, 'url' => '', 'msg' => '账号或密码错误']);
        }

        //验证用户状态
        if($hasUser['status'] !== 0){
            log_db($hasUser['id'],$username,'用户【'.$username.'】登录失败：该账号被禁用',2);
            return json(['code' => -2, 'url' => '', 'msg' => '该账号被禁用']);
        }

        //获取该管理员的角色信息
        $role = new RoleModel();
        $info = $role->getRoleInfo($hasUser['group_id']);

        session('uid', $hasUser['id']);         //用户ID
        session('username', $hasUser['username']);  //用户名
        session('icon', $hasUser['icon']); //用户头像
        session('rolename', $info['title']);    //角色名
        session('rule', $info['rules']);        //角色节点
        session('name', $info['name']);         //角色权限

        //更新管理员状态
        $param = [
            'loginnum' => $hasUser['loginnum'] + 1,
            'last_login_ip' => request()->ip(),
            'last_login_time' => time()
        ];

        Db::name('admin')->where('id', $hasUser['id'])->update($param);
        log_db($hasUser['id'],session('username'),'用户【'.session('username').'】登录成功',1);
        return json(['code' => 1, 'url' => url('index/index'), 'msg' => '登录成功！']);

    }

    public function loginOut()
    {
        if(!empty(session('username'))){
            session(null);
            cache('db_config_data',null);
        }
        $this->redirect('login');
    }

    public function checkCode()
    {
        $code = new Verify(['imageH'=>34,'imageW'=>100,'codeSet'=>'0123456789','length'=>4,'fontSize'=>13,'useNoise'=>false,'useCurve'=>false]);

        $code->entry();
    }

    //极验验证
    public function getVerify(){
//        $GtSdk = new Geetestlib(config('gee_id'), config('gee_key'));
//        $user_id = "web";
//        $status = $GtSdk->pre_process($user_id);
//        session('gtserver',$status);
//        session('user_id',$user_id);
//        echo $GtSdk->get_response_str();

    }
}
