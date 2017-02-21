<?php
namespace app\console;


use think\console\Command;
use think\console\Input;
use think\console\input\Option;
use think\console\Output;

class Clear extends Command{

    protected function configure()
    {
        //指令配置
        $this->setName('clear')
            ->addOption('path','d',Option::VALUE_OPTIONAL, 'path to clear', null)
            ->setDescription("Clear Runtime Dirs");
    }

    protected function execute(Input $input, Output $output)
    {
        $path  = $input->getOption('path') ?: RUNTIME_PATH;
        $files = scandir($path);
        if ($files) {
            foreach ($files as $file) {
                if ('.' != $file && '..' != $file && is_dir($path . $file)) {
                    array_map('unlink', glob($path . $file . '/*.*'));
                } elseif (is_file($path . $file)) {
                    unlink($path . $file);
                }
            }
        }
        $output->writeln("Clear Successed");
    }
}

