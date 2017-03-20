<?php

namespace app\admin\model;

use think\Model;

class MsgTask extends Model
{
    protected $table='wnl_msg_task';
    public function getTotalCount($map){
        return $this->where($map)->count();
    }
    public function getTaskByWhere($map,$page,$limits){
        return $this->where($map)->page($limits,$page)->order('id desc')->select();
    }
}
