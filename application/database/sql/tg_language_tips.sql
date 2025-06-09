CREATE TABLE `fa_tips` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tips` varchar(255) NOT NULL COMMENT '语言包说明',
  `keyword` varchar(50) NOT NULL COMMENT '语言包关键词',
  `text` text NOT NULL COMMENT '语言包文本内容',
  `lang` varchar(10) NOT NULL DEFAULT 'zh-cn' COMMENT '语言包语言',
  `mode` tinyint(1) NOT NULL DEFAULT '0' COMMENT '模式:0=按钮模式,1=弹窗模式,2=强制回复模式',
  `buttons` text COMMENT '按钮JSON数据',
  `createtime` int(11) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(11) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_keyword` (`keyword`),
  KEY `idx_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Telegram语言包提示表';