<?php

namespace app\admin\model;
use think\Model;
use think\Db;

class RoleModel extends Model
{
    protected  $name = 'auth_group';

    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = true;

    public function users(){
        return $this->belongsToMany('User','auth_group_access','uid','group_id');
    }
    /**
     * [getRolePageByWhere 根据条件分页获取角色列表信息]
     * @param $map array
     * @param $page int
     * @param $limits int
     * @return  array
     */
    public function getRolePageByWhere($map, $page, $limits)
    {
        return $this->where($map)->page($page, $limits)->order('id desc')->select();
    }



    /**
     * [getRoleCountByWhere 根据条件获取所有的角色数量]
     * @param $where array
     * @return int
     */
    public function getCountByWhere($where)
    {
        return $this->where($where)->count();
    }

    /**
     * [getRoles 获取所有角色信息的某些字段]
     * @param $field string
     * @return int
     */
    public function getRoles($field = '*')
    {

        return $this->field($field)->select();

    }

    /**
     * [insertRole 插入角色信息]
     * @param $param array
     * @return array
     */
    public function insertRole($param)
    {
        try{
            $result =  $this->validate('RoleValidate')->save($param);
            if(false === $result){
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '添加角色成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [updateRole 编辑角色信息]
     * @param $param array
     * @return array msg
     */
    public function updateRole($param)
    {
        try{
            $result =  $this->validate('RoleValidate')->save($param, ['id' => $param['id']]);
            if(false === $result){
                return ['code' => 0, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '编辑角色成功'];
            }
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [getOneRole 根据角色id获取角色信息]
     * @param $id int
     * @return array roleData
     */
    public function getOneRole($id)
    {
        $role = $this->where('id', $id)->find();
        return $role;
    }



    /**
     * [delRole 删除角色]
     * @param $id int
     * @return array msg
     */
    public function delRole($id)
    {
        try{
            $this->where('id', $id)->delete();
            return ['code' => 1, 'data' => '', 'msg' => '删除角色成功'];
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [getRole 获取所有角色信息 超级管理员除外]
     *
     */
    public function getRole()
    {
        return $this->where('id','<>',1)->select();
    }


    /**
     * [getRole 获取角色的权限节点]
     * @param $id int
     * @return mixed
     */
    public function getRuleById($id)
    {
        $res = $this->field('rules')->where('id', $id)->find();
        return $res['rules'];
    }


    /**
     * [editAccess 分配权限]
     * @param $param array
     * @return  array
     */
    public function editAccess($param)
    {
        try{
            $this->save($param, ['id' => $param['id']]);
            return ['code' => 1, 'data' => '', 'msg' => '分配权限成功'];

        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }



    /**
     * [getRoleInfo 获取角色信息]
     * @param $id int
     * @return array userInfo
     */
    public function getRoleInfo($id){

        $result = Db::name('auth_group')->where('id', $id)->find();
        if(empty($result['rules'])){
            $where = '';
        }else{
            $where = 'id in('.$result['rules'].')';
        }
        $res = Db::name('auth_rule')->field('name')->where($where)->select();

        foreach($res as $key=>$vo){
            if('#' != $vo['name']){
                $result['name'][] = $vo['name'];
            }
        }
        return $result;
    }
}