<?php
namespace app\api\controller\v1;

use app\api\model\User as UserModel;

class User
{
    // 获取用户信息
    public function read($id = 0)
    {
        $user = UserModel::get($id);
        if ($user) {
            return json($user->hidden(['password','created','creator','status','group_id']));
        } else {
            return json(['error' => '用户不存在'], 404);
        }
    }

}