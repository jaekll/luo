<?php
namespace app\admin\validate;

use think\Validate;

class RoleValidate extends Validate {

    protected $rule = [
        ['title', 'require', '角色名不能为空'],
        ['title', 'unique:auth_group', '角色已经存在']
    ];
}