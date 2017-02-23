<?php
namespace app\admin\model;

use think\Db;
use think\Model;

/**
 * Class UserModel
 * @package app\admin\model
 */
class UserModel extends Model {

    protected $name = 'admin';

    /**
     * 根据条件返回用户的数量
     * @param array $where
     * @return int|string
     */
    public function getCountByWhere($where =[]){
        if(empty($where)){
            $count = $this->count('id');
        }else{
            $count = $this->where($where)->count('id');
        }
        return $count;
    }

    /**
     * 根据条件分页返回用户数据
     * @param $where
     * @param $page
     * @param $limit
     * @return false|\PDOStatement|string|\think\Collection
     */
    public function getUserByWhere($where, $page, $limit){
        $user = $this->field('admin.*,auth_group.title')
            ->join('auth_group','group_id = auth_group.id')
            ->where($where)
            ->page($page,$limit)
            ->order('admin.id desc')
            ->select();
        return $user;
    }


    /**
     * 根据ID获取某个用户信息
     * @param $id
     * @return array|false|\PDOStatement|string|Model
     */
    public function getOne($id){
        return $this->where('id',$id)->find();
    }

    public function getOneByName($name){
        return $this->where('username',$name)->find();
    }


    /**
     * 添加一个用户
     * @param $user
     * @return array
     */
    public function add($user)
    {
        try{
            $result = $this->validate('UserValidate')->allowField(true)->save($user);
            if(false === $result){
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                log_db(session('uid'),session('username'),'用户【'.$user['username'].'】添加成功',1);
                return ['code' => 1, 'data' => '', 'msg' => '添加用户成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }


    /**
     * 编辑用户信息
     *
     * @param $user
     * @return array
     */
    public function editUser($user){
        try{
            $result =  $this->validate('UserValidate')->allowField(true)->save($user, ['id' => $user['id']]);
            if(false === $result){
                return ['code' => 0, 'data' => '', 'msg' => $this->getError()];
            }else{
                log_db(session('uid'),session('username'),'用户【'.$user['username'].'】编辑成功',1);
                return ['code' => 1, 'data' => '', 'msg' => '编辑用户成功'];
            }
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    /**
     * 编辑用户信息
     * @param $param
     * @param $id
     * @return array
     */
    public function updateUser($param,$id){
        try{
            $result =  $this->validate('UserValidate')->allowField(true)->save($param, ['id' => $id]);
            if(false === $result){
                return ['code' => 0, 'data' => '', 'msg' => $this->getError()];
            }else{
                log_db(session('uid'),session('username'),'用户【'.$id.'】编辑成功',1);
                return true;
            }
        }catch( \PDOException $e){
            return false;
        }
    }


    /**
     * 根据用户ID 删除一个用户
     *
     * @param $id
     * @return array
     * @throws \think\Exception
     */
    public function delOne($id){
        try{
            $this->where('id', $id)->delete();
            Db::name('auth_group_access')->where('uid', $id)->delete();
            log_db(session('uid'),session('username'),'用户【'.session('username').'】删除管理员成功(ID='.$id.')',1);
            return ['code' => 1, 'data' => '', 'msg' => '删除用户成功'];

        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    public function addAccess($access_data){
        try{
            Db::name('auth_group_access')->insert($access_data);
            return ['code' => 1];
        }catch (\PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }

    }

    public function updateAccess($uid,$group_id){
        try{
            Db::name('auth_group_access')->where('uid', $uid)->update(['group_id' => $group_id]);
            return ['code' => 1];
        }catch (\PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }

    }


    /**
     * 用户状态更新
     *
     * @param $id
     * @return \think\response\Json
     */
    public function status($id){

        $status = $this->where('id',$id)->value('status');//判断当前状态情况
        if($status==1)
        {
            $flag = $this->where('id',$id)->setField(['status'=>0]);
            return ['code' => 1, 'data' => $flag['data'], 'msg' => '已禁止'];
        }
        else
        {
            $flag = $this->where('id',$id)->setField(['status'=>1]);
            return ['code' => 0, 'data' => $flag['data'], 'msg' => '已开启'];
        }
    }
}
