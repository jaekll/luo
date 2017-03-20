<?php

namespace app\admin\model;

use think\Model;

class MsgBlock extends Model{
    protected $table = 'wnl_blockadmin';

    public function getIsOpenAttr($value){
        $isopen = [1=>'开启',0=>'关闭'];
        return $isopen[$value];
    }
    public function getLqRateAttr($value){
        $lqrate = [0=>'请求拉取',1=>'每分钟拉取'];
        return $lqrate[$value];
    }
    public function getBlockByWhere($map,$page,$limits){
        return $this->where($map)->page($page, $limits)->order('id desc')->select();
    }

    public function getTotalCount($map){
        return  $this->where($map)->count();
    }


}