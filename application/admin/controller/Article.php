<?php
namespace app\admin\controller;

use app\admin\model\ArticleModel;
use app\admin\model\ArticleCateModel;

class Article extends Base{

    public function index()
    {
        $key = input('key');
        $where = [];
        if($key&&$key!==""){
            $where['title'] = ['like',"%" . $key . "%"];
        }
        $page = input('get.page') ? input('get.page'):1;
        $limits = 10;// 获取总条数

        $article = new ArticleModel();
        $lists = $article->getArticlePageByWhere($where, $page, $limits);

        if(input('get.page')){
            return json($lists);
        }

        $count = $article->where($where)->count();//计算总页面
        $allpage = intval(ceil($count / $limits));
        $this->assign('val', $key);
        $this->assign('Nowpage', $page); //当前页
        $this->assign('allpage', $allpage); //总页数
        $this->assign('count', $count);

        return $this->fetch();
    }

    public function add_article()
    {
        if(request()->isAjax()){
            $param = input('post.');
            $article = new ArticleModel();
            $flag = $article->insertArticle($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }

        $cate = new ArticleCateModel();
        $cateList = $cate->getAll();
        $this->assign('cate',$cateList);
        return $this->fetch('add');
    }

    public function edit_article()
    {
        $article = new ArticleModel();

        if(request()->isAjax()){
            $param = input('post.');
            $flag = $article->updateArticle($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }

        $id = input('param.id');
        $cate = new ArticleCateModel();
        $cateList = $cate->getAll();
        $this->assign('cate',$cateList);
        $articleData = $article->getOneArticle($id);
        $this->assign('article',$articleData);
        return $this->fetch('edit');
    }


    public function article_state()
    {
        $id=input('param.id');
        $article = new ArticleModel();
        $result = $article->status($id);
        return json($result);
    }

    public function cate_index(){

        $cate = new ArticleCateModel();
        $list = $cate->paginate(15);
        $this->assign('list',$list);
        return $this->fetch('article/cate/cate');
    }
    public function add_cate()
    {
        if(request()->isAjax()){

            $param = input('post.');
            $cate = new ArticleCateModel();
            $flag = $cate->addCate($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg'],'url'=>url('article/cate_index')]);
        }

        return $this->fetch('article/cate/add');
    }
    public function edit_cate()
    {
        $cate = new ArticleCateModel();

        if(request()->isAjax()){
            $param = input('post.');
            $flag = $cate->updateCate($param);
            return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
        }

        $id = input('param.id');
        $this->assign('cate',$cate->getOne($id));
        return $this->fetch('article/cate/edit');
    }
    public function del_cate()
    {
        $id = input('param.id');
        $cate = new ArticleCateModel();
        $flag = $cate->delCate($id);
        return json(['code' => $flag['code'], 'data' => $flag['data'], 'msg' => $flag['msg']]);
    }

    public function cate_state()
    {
        $id=input('param.id');
        $article_cate = new ArticleCateModel();
        $result = $article_cate->status($id);
        return json($result);
    }

    public function test(){
        $articleCate = ArticleCateModel::get(1);

        dump($articleCate->articles);
    }
}