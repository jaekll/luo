<?php
namespace app\admin\model;

use think\Db;
use think\Model;

class MenuModel extends Model {

    protected $name = 'auth_rule';

    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = true;


    /**
     * [getAllMenu 获取全部菜单]
     */
    public function getAll()
    {
        return $this->order('id asc')->select();
    }


    /**
     * [insertMenu 添加菜单]
     * @param $param array
     * @return array;
     */
    public function add($param)
    {
        try{
            $result = $this->save($param);
            if(false === $result){
                log_db(session('uid'),session('username'),'用户【'.session('username').'】添加菜单失败',2);
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                log_db(session('uid'),session('username'),'用户【'.session('username').'】添加菜单成功',1);
                return ['code' => 1, 'data' => '', 'msg' => '添加菜单成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [editMenu 编辑菜单]
     * @param $param array
     * @return array
     */
    public function edit($param)
    {
        try{
            $result =  $this->save($param, ['id' => $param['id']]);
            if(false === $result){
                log_db(session('uid'),session('username'),'用户【'.session('username').'】编辑菜单失败',2);
                return ['code' => 0, 'data' => '', 'msg' => $this->getError()];
            }else{
                log_db(session('uid'),session('username'),'用户【'.session('username').'】编辑菜单成功',1);
                return ['code' => 1, 'data' => '', 'msg' => '编辑菜单成功'];
            }
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [getOneMenu 根据菜单id获取一条信息]
     * @param $id int
     * @return mixed
     */
    public function getOne($id)
    {
        return $this->where('id', $id)->find();
    }



    /**
     * [delMenu 删除菜单]
     * @param $id int
     * @return array
     */
    public function del($id)
    {
        try{
            $this->where('id', $id)->delete();
            log_db(session('uid'),session('username'),'用户【'.session('username').'】删除菜单成功',1);
            return ['code' => 1, 'data' => '', 'msg' => '删除菜单成功'];
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }


    /**
     * @param $id
     * @return string
     */
    public function getNodeInfo($id)
    {
        $result = $this->field('id,title,pid')->select();
        $str = "";
        $role = new RoleModel();
        $rule = $role->getRuleById($id);

        if(!empty($rule)){
            $rule = explode(',', $rule);
        }
        foreach($result as $key=>$vo){
            $str .= '{ "id": "' . $vo['id'] . '", "pId":"' . $vo['pid'] . '", "name":"' . $vo['title'].'"';

            if(!empty($rule) && in_array($vo['id'], $rule)){
                $str .= ' ,"checked":1';
            }

            $str .= '},';
        }

        return "[" . substr($str, 0, -1) . "]";
    }


    /**
     * 获取菜单列表
     * @param string $nodeStr
     * @return array
     */
    public function getMenu($nodeStr = '')
    {
        //超级管理员没有节点数组
        $where = empty($nodeStr) ? 'status = 1' : 'status = 1 and id in('.$nodeStr.')';
        $result = Db::name('auth_rule')->where($where)->order('sort')->select();
        $menu = prepareMenu($result);
//        $menu = MenuTree($result);
        return $menu;
    }


}