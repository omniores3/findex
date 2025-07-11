CREATE TABLE `manticore_user_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `admin_id` bigint(20) DEFAULT NULL COMMENT '操作管理员ID',
  `action_type` varchar(50) NOT NULL COMMENT '操作类型',
  `action_detail` text COMMENT '操作详情',
  `before_status` varchar(50) DEFAULT NULL COMMENT '操作前状态',
  `after_status` varchar(50) DEFAULT NULL COMMENT '操作后状态',
  `balance_change` decimal(15,2) DEFAULT NULL COMMENT '余额变动',
  `frozen_balance_change` decimal(15,2) DEFAULT NULL COMMENT '冻结余额变动',
  `transaction_id` varchar(100) DEFAULT NULL COMMENT '交易ID',
  `ip_address` varchar(50) DEFAULT NULL COMMENT '操作IP',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_admin_id` (`admin_id`),
  KEY `idx_action_type` (`action_type`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=Manticore COMMENT='用户操作日志表';