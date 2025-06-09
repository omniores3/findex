CREATE TABLE `tg_ad_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `ad_id` int(11) NOT NULL COMMENT '广告ID',
  `amount` decimal(10,2) NOT NULL COMMENT '订单金额',
  `payment_status` tinyint(1) DEFAULT '0' COMMENT '支付状态 0-未支付 1-已支付',
  `payment_time` int(11) DEFAULT NULL COMMENT '支付时间',
  `payment_method` varchar(20) DEFAULT NULL COMMENT '支付方式',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_ad_id` (`ad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='广告订单表';