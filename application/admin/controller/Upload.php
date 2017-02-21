<?php
namespace app\admin\controller;


use think\Request;

class Upload extends Base{

    //文件上传
    public function upload(){

    }

    //管理员头像上传
    public function upload_face(){
        $request = Request::instance();
        $file = $request->file('file');
        $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads/face');

        if($info){
            echo config('admin_face_path') . $info->getSaveName();
        }else{
            echo $file->getError();
        }
    }
}
