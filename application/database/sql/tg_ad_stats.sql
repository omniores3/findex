CREATE TABLE `tg_ad_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ad_id` int(11) NOT NULL COMMENT '广告ID',
  `date` date NOT NULL COMMENT '统计日期',
  `impressions` int(11) DEFAULT '0' COMMENT '展示次数',
  `clicks` int(11) DEFAULT '0' COMMENT '点击次数',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ad_date` (`ad_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告统计表';