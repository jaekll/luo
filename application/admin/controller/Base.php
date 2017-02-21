<?php

namespace app\admin\controller;
use app\admin\model\Node;
use app\admin\model\NodeModel;
use app\common\lib\Config;
use think\Controller;
use \com\Auth;
use think\Model;

class Base extends Controller
{
    public function _initialize()
    {

        if(!session('uid')||!session('username')){
            $this->redirect(url('login/login'));
        }

        $auth = new Auth();
        $module     = strtolower(request()->module());
        $controller = strtolower(request()->controller());
        $action     = strtolower(request()->action());
        $url        = $module."/".$controller."/".$action;

        //跳过检测以及主页权限
        if(session('uid')!=1){
            if(!in_array($url, ['admin/index/index','admin/index/main'])){
                if(!$auth->check($url,session('uid'))){
                    $this->error('抱歉，您没有操作权限');
                }
            }
        }

        //输出用户信息及其所拥有的权限数据
        $userInfo = [
            'username' => session('username'),
            'icon' => session('icon'),
            'rolename' => session('rolename'),
        ];
        $node = new NodeModel();
        $userInfo['menu'] = $node->getMenu(session('rule'));
        $this->assign($userInfo);

        //加载数据库配置项，缓存没有则从数据库获取
        $config = cache('db_config_data');
        if(!$config){
            $config = Config::lists();
            cache('db_config_data',$config);
        }
        config($config);

        if(config('web_site_close') == 0 && session('uid') !=1 ){
            $this->error('站点已经关闭，请稍后访问~');
        }

        if(config('admin_allow_ip') && session('uid') !=1 ){

            if(in_array(request()->ip(),explode(',',config('admin_allow_ip')))){
                $this->error('403:禁止访问');
            }
        }

    }

    //后台排序功能
    public function order(Model $model,$param){
        foreach($param as $k=>$v){
            try{
                $model->where(array('id'=>$k))->setField('sort',$v);
            }catch (\PDOException $e){
                return ['code'=>-1,'msg'=>$e->getMessage()];
            }
        }
        return ['code'=>1,'msg'=>'排序成功'];
    }
}