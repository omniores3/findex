CREATE TABLE `fa_buttons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '按钮名称',
  `hint` varchar(255) NOT NULL COMMENT '提示信息',
  `keyword` varchar(50) NOT NULL COMMENT '关键词',
  `content` text COMMENT '回复内容',
  `file` varchar(255) DEFAULT NULL COMMENT '上传文件路径',
  `display_mode` varchar(15) DEFAULT 'HTML' COMMENT '展示模式 HTML-HTML MarkDown=MarkDown MarkDownV2-MarkDownV2',
  `show_url` tinyint(1) DEFAULT '0' COMMENT '是否展示URL 0-否 1-是',
  `button_mode` tinyint(15) DEFAULT '0' COMMENT '按钮模式 0-普通 1-内联',
  `button_data` text COMMENT '按钮JSON数据',
  `lang` varchar(10) DEFAULT 'zh-cn' COMMENT '语言',
  `createtime` int(10) DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) DEFAULT NULL COMMENT '更新时间',
  `deletetime` int(10) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Telegram按钮表';