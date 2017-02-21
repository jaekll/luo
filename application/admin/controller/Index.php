<?php
namespace app\admin\controller;

use \think\Controller;

class Index extends Base {
    public function index()
    {
        return $this->fetch('/index');
    }

    public function main(){
        $info = array(
            'web_server' => $_SERVER['SERVER_SOFTWARE'],
            'onload'     => ini_get('upload_max_filesize'),
            'think_v'    => THINK_VERSION,
            'phpversion' => phpversion(),
        );

        $this->assign('info',$info);
        return $this->fetch('main');
    }
}