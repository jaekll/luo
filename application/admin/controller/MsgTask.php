<?php

namespace app\admin\controller;

use think\Controller;
use think\Request;
use think\response\Json;

class MsgTask extends Controller
{
    public function index(){

        $input = Request::instance();
        $msgTask = new \app\admin\model\MsgTask();
        $map=[];
        if($input->isAjax()){

            $page = $input->get('page') ? $input->get('page') : 1;
            $limits = 20;
            $total = $msgTask->getTotalCount($map);
            $result = $msgTask->getTaskByWhere($map,$page,$limits);
            $this->assign('totalPage',$total);
            return Json::create($result);
        }
        $total = $msgTask->getTotalCount($map);
        $this->assign('totalPage',$total);
        return $this->fetch();
    }


}
