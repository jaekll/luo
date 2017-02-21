<?php
namespace app\admin\model;


use think\Model;
use think\Db;

class ArticleCateModel extends Model{

    protected $table = "article_cate";
    // 开启自动写入时间戳
    protected $autoWriteTimestamp = true;

    public function articles(){
        return $this->hasMany('ArticleModel','cate_id');
    }

    public function getOne($id)
    {
        return $this->where('id',$id)->find();
    }

    public function getAll()
    {
        return $this->order('id asc')->select();
    }

    public function addCate($param){
        try{
            $result = $this->save($param);
            if(false === $result){
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '分类添加成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    public function updateCate($param)
    {
        try{
            $result = $this->save($param,['id'=>$param['id']]);
            if(false === $result){
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '分类添加成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }
    public function delCate($id)
    {
        try{
            $this->where('id', $id)->delete();
            return ['code' => 1, 'data' => '', 'msg' => '分类删除成功'];
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    public function status($id){
        $status = Db::name('article_cate')->where(array('id'=>$id))->value('status');//判断当前状态情况
        if($status==1)
        {
            $flag = Db::name('article_cate')->where(array('id'=>$id))->setField(['status'=>0]);
            return ['code' => 1, 'data' => $flag['data'], 'msg' => '已禁止'];
        }
        else
        {
            $flag = Db::name('article_cate')->where(array('id'=>$id))->setField(['status'=>1]);
            return ['code' => 0, 'data' => $flag['data'], 'msg' => '已开启'];
        }
    }
}