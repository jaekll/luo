<?php

return [
    //模板参数替换
    'view_replace_str' => array(
        '__CSS__' => '/static/admin/css',
        '__JS__'  => '/static/admin/js',
        '__IMG__' => '/static/admin/images',
    ),

    // +----------------------------------------------------------------------
    // | 数据库设置
    // +----------------------------------------------------------------------
    'data_backup_path'     => '../data/',   //数据库备份路径必须以 / 结尾；
    'data_backup_part_size' => '20971520',  //该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M
    'data_backup_compress' => '1',          //压缩备份文件需要PHP环境支持gzopen,gzwrite函数        0:不压缩 1:启用压缩
    'data_backup_compress_level' => '9',    //压缩级别   1:普通   4:一般   9:最高


    // +----------------------------------------------------------------------
    // | 极验验证,请到官网申请ID和KEY，http://www.geetest.com/
    // +----------------------------------------------------------------------
    'verify_type' => '1',   //验证码类型：0极验验证， 1数字验证码
    'gee_id'  => 'ca1219b1ba907a733eaadfc3f6595fad',
    'gee_key' => '9977de876b194d227b2209df142c92a0',
    'auth_key' => 'JUD6FCtZsqrmVXc2apev4TRn3O8gAhxbSlH9wfPN', //默认数据加密KEY
    'pages'    => '10',//分页数
    'salt'     => 'wZPb~yxvA!ir38&Z',//加密串

    //管理员头像存放路径
    'admin_face_path'=>'/uploads/face/'
];
