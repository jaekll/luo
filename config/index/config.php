<?php

return [


    'cache' =>  [
        // 使用复合缓存类型
        'type'  =>  'complex',
        // 默认使用的缓存
        'default'   =>  [
            // 驱动方式
            'type'   => 'File',
            // 缓存保存目录
            'path'   => CACHE_PATH,
        ],
        //文件缓存
        'file' => [
            // 驱动方式
            'type'   => 'file',
            // 服务器地址
            'path'  => RUNTIME_PATH . 'file/'
        ],
        // memcached缓存
        'memcached'   =>  [
            // 驱动方式
            'type'   => 'memcached',
            // 服务器地址
            'host' => '127.0.0.1'
        ],
        // redis缓存
        'redis'   =>  [
            // 驱动方式
            'type'   => 'redis',
            // 服务器地址
            'host'       => '127.0.0.1',
        ],
    ],
];