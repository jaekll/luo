<?php
namespace app\admin\controller;


use think\Request;
use \app\admin\model\MsgBlock as MsgBlockModel;
use think\response\Json;

class MsgBlock extends Base{

    public function index(){
        $input = Request::instance();
        $msgBlock = new MsgBlockModel();
        $map=[];
        if($input->isAjax()){

            $page = $input->get('page') ? $input->get('page') : 1;
            $limits = 20;
            $total = $msgBlock->getTotalCount($map);
            $result = $msgBlock->getBlockByWhere($map,$page,$limits);
            //$this->assign('page',$page);
            $this->assign('totalPage',$total);
            return Json::create($result);
        }
        $total = $msgBlock->getTotalCount($map);
        $this->assign('totalPage',$total);
        return $this->fetch();
    }

    public function add(){

    }

}
