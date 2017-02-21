<?php
namespace app\blog\controller;

use think\Request;

class Index{

    public function index(Request $request)
    {
        return 'this is a blog app';
    }
}