<?php
namespace app\admin\jobs;

use \think\queue\Job;

class Task{

    public function fire(Job $job, $data){

        //....这里执行具体的任务

        if ($job->attempts() > 3) {
            //通过这个方法可以检查这个任务已经重试了几次了
        }
        //如果任务执行成功后 记得删除任务，不然这个任务会重复执行，直到达到最大重试次数后失败后，执行failed方法
        $job->delete();

        // 也可以重新发布这个任务
        //$job->release($delay); //$delay为延迟时间

    }

    public function task1(Job $job,$data){
        echo "this is a job \n" . 'data:' . $data ."\n".'job name: '.$job->getName() ."\n". ' this queue job in is '.$job->getQueue();

        if($job->attempts() >3){

        }

        $job->delete();
    }

    public function failed($data){

    }

}
