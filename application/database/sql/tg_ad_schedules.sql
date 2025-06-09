CREATE TABLE `tg_ad_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) NOT NULL COMMENT '广告ID',
  `target_type` enum('group','channel') NOT NULL COMMENT '目标类型',
  `target_id` int(11) NOT NULL COMMENT '目标ID',
  `send_time` varchar(20) NOT NULL COMMENT '发送时间(cron表达式)',
  `last_send_time` int(11) DEFAULT NULL COMMENT '最后发送时间',
  `next_send_time` int(11) DEFAULT NULL COMMENT '下次发送时间',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 1-启用 0-禁用',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_ad_id` (`ad_id`),
  KEY `idx_next_send_time` (`next_send_time`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告计划任务表';