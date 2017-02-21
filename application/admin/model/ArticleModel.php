<?php
namespace app\admin\model;


use think\Model;

class ArticleModel extends Model{

    protected $table = 'article';
    public function getArticlePageByWhere($where,$page,$limits)
    {
        return $this->field('article.*,name')
            ->join('article_cate', 'article.cate_id = article_cate.id')
            ->where($where)
            ->page($page, $limits)
            ->order('id desc')
            ->select();
    }

    public function insertArticle($param)
    {
        try{
            $result = $this->allowField(true)->save($param);
            if(false === $result){
                return ['code' => -1, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '文章添加成功'];
            }
        }catch( \PDOException $e){
            return ['code' => -2, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    public function updateArticle($param)
    {
        try{
            $result = $this->allowField(true)->save($param, ['id' => $param['id']]);
            if(false === $result){
                return ['code' => 0, 'data' => '', 'msg' => $this->getError()];
            }else{
                return ['code' => 1, 'data' => '', 'msg' => '文章编辑成功'];
            }
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

    public function getOneArticle($id)
    {
        return $this->where('id', $id)->find();
    }

    public function delArticle($id)
    {
        try{
            $this->where('id', $id)->delete();
            return ['code' => 1, 'data' => '', 'msg' => '文章删除成功'];
        }catch( \PDOException $e){
            return ['code' => 0, 'data' => '', 'msg' => $e->getMessage()];
        }
    }

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