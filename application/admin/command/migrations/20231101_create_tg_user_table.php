<?php

use think\migration\Migrator;
use think\migration\db\Column;

class CreateTgUserTable extends Migrator
{
    public function change()
    {
        $table = $this->table('tg_user', ['comment' => 'TG用户表', 'engine' => 'InnoDB']);
        $table->addColumn('tid', 'string', ['limit' => 64, 'default' => '', 'comment' => 'TG用户ID'])
            ->addColumn('tusername', 'string', ['limit' => 64, 'default' => '', 'comment' => 'TG用户名'])
            ->addColumn('tnick', 'string', ['limit' => 64, 'default' => '', 'comment' => 'TG昵称'])
            ->addColumn('avatar', 'string', ['limit' => 255, 'default' => '', 'comment' => '头像'])
            ->addColumn('balance', 'decimal', ['precision' => 10, 'scale' => 2, 'default' => 0, 'comment' => '账户余额'])
            ->addColumn('frozen_balance', 'decimal', ['precision' => 10, 'scale' => 2, 'default' => 0, 'comment' => '冻结余额'])
            ->addColumn('lang', 'string', ['limit' => 10, 'default' => 'en', 'comment' => '用户语言'])
            ->addColumn('parent_id', 'integer', ['limit' => 11, 'default' => 0, 'comment' => '上级用户ID'])
            ->addColumn('status', 'integer', ['limit' => 2, 'default' => 1, 'comment' => '状态 -1=黑名单 0=禁用 1=正常 2=投资方'])
            ->addColumn('create_time', 'integer', ['limit' => 10, 'default' => 0, 'comment' => '创建时间'])
            ->addColumn('update_time', 'integer', ['limit' => 10, 'default' => 0, 'comment' => '更新时间'])
            ->addColumn('delete_time', 'integer', ['limit' => 10, 'default' => 0, 'comment' => '删除时间'])
            ->addIndex(['tid'], ['unique' => true])
            ->addIndex(['parent_id'])
            ->create();
    }
}