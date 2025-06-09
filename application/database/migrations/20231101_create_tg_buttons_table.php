<?php

use think\migration\Migrator;
use think\migration\db\Column;

class CreateTgButtonsTable extends Migrator
{
    public function up()
    {
        $table = $this->table('tg_buttons', ['comment' => 'Telegram按钮表']);
        $table->addColumn('name', 'string', ['limit' => 50, 'comment' => '按钮名称'])
            ->addColumn('hint', 'string', ['limit' => 255, 'comment' => '提示信息'])
            ->addColumn('keyword', 'string', ['limit' => 50, 'comment' => '关键词'])
            ->addColumn('content', 'text', ['null' => true, 'comment' => '回复内容'])
            ->addColumn('file', 'string', ['limit' => 255, 'null' => true, 'comment' => '上传文件路径'])
            ->addColumn('display_mode', 'integer', ['limit' => 1, 'default' => 0, 'comment' => '展示模式 0-文本 1-图片 2-文件'])
            ->addColumn('show_url', 'integer', ['limit' => 1, 'default' => 0, 'comment' => '是否展示URL 0-否 1-是'])
            ->addColumn('button_mode', 'integer', ['limit' => 1, 'default' => 0, 'comment' => '按钮模式 0-普通 1-内联'])
            ->addColumn('button_data', 'text', ['null' => true, 'comment' => '按钮JSON数据'])
            ->addColumn('lang', 'string', ['limit' => 10, 'default' => 'zh-cn', 'comment' => '语言'])
            ->addColumn('create_time', 'integer', ['limit' => 10, 'null' => true, 'comment' => '创建时间'])
            ->addColumn('update_time', 'integer', ['limit' => 10, 'null' => true, 'comment' => '更新时间'])
            ->addColumn('delete_time', 'integer', ['limit' => 10, 'null' => true, 'comment' => '删除时间'])
            ->addIndex(['keyword'], ['unique' => true])
            ->create();
    }

    public function down()
    {
        $this->dropTable('tg_buttons');
    }
}