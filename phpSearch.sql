-- MySQL dump 10.13  Distrib 5.7.44, for Linux (x86_64)
--
-- Host: localhost    Database: copy_8br_dpdns_o
-- ------------------------------------------------------
-- Server version	5.7.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `fa_admin`
--

DROP TABLE IF EXISTS `fa_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `google` varchar(30) DEFAULT NULL COMMENT '谷歌验证器',
  `salt` varchar(30) DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `email` varchar(100) DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号码',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT NULL COMMENT '登录IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(59) DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='管理员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_admin`
--

LOCK TABLES `fa_admin` WRITE;
/*!40000 ALTER TABLE `fa_admin` DISABLE KEYS */;
INSERT INTO `fa_admin` VALUES (1,'admin','Admin','a46760f2384b380e158fd9b3a838fbc2','UHF3UCR27WHUENBBTQ','40c14f','/assets/img/avatar.png','admin@admin.com','',0,1748781219,'110.235.31.3',1491635035,1748781219,'a2f7d1de-ff19-4a22-94f5-276c73554e03','normal');
/*!40000 ALTER TABLE `fa_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_admin_log`
--

DROP TABLE IF EXISTS `fa_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_admin_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `username` varchar(30) DEFAULT '' COMMENT '管理员名字',
  `url` varchar(1500) DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) DEFAULT '' COMMENT '日志标题',
  `content` longtext NOT NULL COMMENT '内容',
  `ip` varchar(50) DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) DEFAULT '' COMMENT 'User-Agent',
  `createtime` bigint(16) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `name` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='管理员日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_admin_log`
--

LOCK TABLES `fa_admin_log` WRITE;
/*!40000 ALTER TABLE `fa_admin_log` DISABLE KEYS */;
INSERT INTO `fa_admin_log` VALUES (1,1,'admin','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"276949\",\"captcha\":\"eqb5\",\"keeplogin\":\"1\"}','85.208.72.24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36 Edg/136.0.0.0',1748519609),(2,1,'admin','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"239932\",\"captcha\":\"j522\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748686723),(3,1,'admin','/hDKsVnTZui.php/advlist/setstatus','广告列管理','{\"id\":\"1\",\"status\":\"2\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748686995),(4,1,'admin','/hDKsVnTZui.php/tips/edit/ids/19?dialog=1','语言包说明 / 编辑','{\"dialog\":\"1\",\"row\":{\"tips\":\"没有找到按钮广告\",\"keyword\":\"not_search_adv\",\"text\":\"{&quot;text&quot;:&quot;没有找到广告&quot;,&quot;url&quot;:&quot;https:\\/\\/t.me\\/easSearchs&quot;}\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"},\"ids\":\"19\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748687734),(5,1,'admin','/hDKsVnTZui.php/advlist/setstatus','广告列管理','{\"id\":\"3\",\"status\":\"2\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748688562),(6,1,'admin','/hDKsVnTZui.php/advlist/setstatus','广告列管理','{\"id\":\"2\",\"status\":\"2\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748688570),(7,1,'admin','/hDKsVnTZui.php/buttons/edit/ids/32?dialog=1','按钮管理 / 编辑','{\"dialog\":\"1\",\"row\":{\"name\":\"修改广告哦\",\"hint\":\"修改广告哦\",\"keyword\":\"submit\",\"content\":\"您正在续费【{advtitle}】\\r\\n\\r\\n广告标题 : 【{advtitle}】\\r\\n广告URL : 【{advurl}】\\r\\n广告类型 : 【{advtype}】\\r\\n广告状态 : 【{advstatus}】\\r\\n到期时间 : 【{endtime}】\\r\\n续费后到期时间 : 【{xfendtime}】\\r\\n\\r\\n续费金额 : 【{amount} USDT】\\r\\n\\r\\n提示:广告状态为待投放和投放中不受影响\",\"file\":\"\",\"display_mode\":\"HTML\",\"show_url\":\"1\",\"button_mode\":\"0\",\"button_data\":\"[\\r\\n   [{\\r\\n      &quot;text&quot;: &quot;💰 立即续费&quot;,\\r\\n      &quot;callback_data&quot;: &quot;submit_pay_{id}&quot;\\r\\n    }\\r\\n  ], \\r\\n   \\r\\n    [{\\r\\n      &quot;text&quot;: &quot;🔙返回&quot;,\\r\\n      &quot;callback_data&quot;: &quot;marke&quot;\\r\\n    }\\r\\n  ]\\r\\n]\",\"lang\":\"zh-cn\"},\"ids\":\"32\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748688727),(8,1,'admin','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"963268\",\"captcha\":\"mc3y\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748692910),(9,1,'admin','/hDKsVnTZui.php/tips/add?dialog=1','语言包说明 / 添加','{\"dialog\":\"1\",\"row\":{\"tips\":\"续费时余额不足提示\",\"keyword\":\"renewal_error\",\"text\":\"您当前余额不足，请先充值后再来续费\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748693552),(10,1,'admin','/hDKsVnTZui.php/tips/add?dialog=1','语言包说明 / 添加','{\"dialog\":\"1\",\"row\":{\"tips\":\"续费成功提示\",\"keyword\":\"renewal_success\",\"text\":\"续费成功\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748693601),(11,1,'admin','/hDKsVnTZui.php/buttons/edit/ids/32?dialog=1','按钮管理 / 编辑','{\"dialog\":\"1\",\"row\":{\"name\":\"修改广告哦\",\"hint\":\"修改广告哦\",\"keyword\":\"submit\",\"content\":\"您正在续费【{advtitle}】\\r\\n\\r\\n广告标题 : 【{advtitle}】\\r\\n广告URL : 【{advurl}】\\r\\n广告类型 : 【{advtype}】\\r\\n广告状态 : 【{advstatus}】\\r\\n到期时间 : 【{endtime}】\\r\\n续费后到期时间 : 【{xfendtime}】\\r\\n\\r\\n续费金额 : 【{amount} USDT】\\r\\n\\r\\n提示:广告状态为待投放和投放中不受影响\",\"file\":\"\",\"display_mode\":\"HTML\",\"show_url\":\"1\",\"button_mode\":\"0\",\"button_data\":\"[\\r\\n   [{\\r\\n      &quot;text&quot;: &quot;💰 立即续费&quot;,\\r\\n      &quot;callback_data&quot;: &quot;submit_pay_{id}&quot;\\r\\n    }\\r\\n  ], \\r\\n   \\r\\n    [{\\r\\n      &quot;text&quot;: &quot;🔙返回&quot;,\\r\\n      &quot;callback_data&quot;: &quot;marke&quot;\\r\\n    }\\r\\n  ]\\r\\n]\",\"lang\":\"zh-cn\"},\"ids\":\"32\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748693650),(12,0,'Unknown','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"981423\",\"captcha\":\"maut\"}','18.167.173.242','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748776548),(13,0,'Unknown','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"981423\",\"captcha\":\"xhih\"}','18.167.173.242','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748776561),(14,1,'admin','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"442604\",\"captcha\":\"cwnk\"}','18.167.173.242','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748776584),(15,1,'admin','/hDKsVnTZui.php/index/login','登录','{\"__token__\":\"***\",\"username\":\"admin\",\"password\":\"***\",\"google_code\":\"784642\",\"captcha\":\"kwf5\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781219),(16,1,'admin','/hDKsVnTZui.php/general.config/edit','常规管理 / 系统配置 / 编辑','{\"__token__\":\"***\",\"row\":{\"license_code\":\"CCAEE2C4-CDAE-834D-D78C-D37570CAAF87\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781328),(17,1,'admin','/hDKsVnTZui.php/general.config/edit','常规管理 / 系统配置 / 编辑','{\"__token__\":\"***\",\"row\":{\"kefu_url\":\"http:\\/\\/crmchat.8br.dpdns.org\\/service\\/login\\/index.html\",\"kefu_username\":\"https:\\/\\/t.me\\/easSearchs\",\"customer_time\":\"60\",\"customer_hook\":\"http:\\/\\/crmchat.8br.dpdns.org\\/\",\"business_id\":\"1\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781358),(18,1,'admin','/hDKsVnTZui.php/ajax/upload','','{\"category\":\"\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781627),(19,1,'admin','/hDKsVnTZui.php/buttons/edit/ids/49?dialog=1','按钮管理 / 编辑','{\"dialog\":\"1\",\"row\":{\"name\":\"获取推广文案\",\"hint\":\"获取推广文案\",\"keyword\":\"getpromotion\",\"content\":\"🔍 TG必备搜索神器「超级索引」 \\r\\n\\r\\n发现你感兴趣的，群组，频道、新闻、或机器人！\\r\\n\\r\\n👉 t.me\\/Super?start={id}\",\"file\":\"\\/uploads\\/20250601\\/565debffd67aff9dfb48a22906f40e77.png\",\"display_mode\":\"HTML\",\"show_url\":\"0\",\"button_mode\":\"0\",\"button_data\":\"\",\"lang\":\"zh-cn\"},\"ids\":\"49\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781630),(20,1,'admin','/hDKsVnTZui.php/buttons/edit/ids/6?dialog=1','按钮管理 / 编辑','{\"dialog\":\"1\",\"row\":{\"name\":\"加入索引联盟\",\"hint\":\"加入索引联盟\",\"keyword\":\"addsearchalliance\",\"content\":\"⚠️ 您还没有加入【索引联盟】。现在加入，自动赚钱。\\r\\n\\r\\n🔵 加入要求\\r\\n1. 群组成员数 &gt;= 1,000\\r\\n2. @Super 提升为管理员\\r\\n3. 群组中不允许出现类似机器人\\r\\n4. 启用自动回复搜索和欢迎消息\\r\\n5. 启用加入【索引联盟】\\r\\n\\r\\n🔵 如何赚取收入\\r\\n👉 每次有效搜索 0.030 U（00.15）\\r\\n⚠️ 本系统将实施严格的反作弊机制，清理无效的搜索。\\r\\n⚠️ 如果发现异常刷量，合作将被取消，收入将被清零！！！\\r\\n\\r\\n🔵 加入步骤\\r\\n1. 将 @Super 添加到群组中，并将其提升为管理员。\\r\\n2. 在群组内发送 \\/update 命令。\\r\\n3. 点击【设置】。\\r\\n4. 启用 【🔲 加入索引联盟】。\\r\\n\\r\\n💡 提示：余额 &gt;= 30 U 将在每月5日前自动发放到你的钱包 。\",\"file\":\"\",\"display_mode\":\"MarkDownV2\",\"show_url\":\"1\",\"button_mode\":\"0\",\"button_data\":\"[[{&quot;text&quot;:&quot;➕ 添加到群组&quot;,&quot;url&quot;:&quot;https:\\/\\/t.me\\/easSearchs&quot;},{&quot;text&quot;:&quot;💰 收益排行榜&quot;,&quot;callback_data&quot;:&quot;income&quot;}],[{&quot;text&quot;:&quot;❤️ 合伙人计划&quot;,&quot;callback_data&quot;:&quot;partner&quot;}],[{&quot;text&quot;:&quot;🔙 返回&quot;,&quot;callback_data&quot;:&quot;my&quot;}]]\",\"lang\":\"zh-cn\"},\"ids\":\"6\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781719),(21,1,'admin','/hDKsVnTZui.php/tips/add?dialog=1','语言包说明 / 添加','{\"dialog\":\"1\",\"row\":{\"tips\":\"链接客服系统失败\",\"keyword\":\"connect_kefu_system_error\",\"text\":\"链接客服系统失败，已为您退出客服系统\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748781903),(22,1,'admin','/hDKsVnTZui.php/tips/add?dialog=1','语言包说明 / 添加','{\"dialog\":\"1\",\"row\":{\"tips\":\"AI客服出错了\",\"keyword\":\"ai_kefu_error\",\"text\":\"FastGTP配置错误，请在后台更新配置\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"}}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748782236),(23,1,'admin','/hDKsVnTZui.php/tips/edit/ids/58?dialog=1','语言包说明 / 编辑','{\"dialog\":\"1\",\"row\":{\"tips\":\"AI客服出错了\",\"keyword\":\"ai_kefu_error\",\"text\":\"FastGTP配置错误，请在后台更新配置，已为您退出客服系统\",\"lang\":\"zh-cn\",\"mode\":\"0\",\"buttons\":\"\"},\"ids\":\"58\"}','110.235.31.3','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0',1748782305);
/*!40000 ALTER TABLE `fa_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_advkey`
--

DROP TABLE IF EXISTS `fa_advkey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_advkey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关键词',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `group_id` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联群组id',
  `amount` float(11,4) DEFAULT '0.0000' COMMENT '出价',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '语言',
  `status` enum('-4','-3','-2','-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-3=黑名单,-2=禁止,-1=余额不足,0=待投放,1=投放中',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='关键词广告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_advkey`
--

LOCK TABLES `fa_advkey` WRITE;
/*!40000 ALTER TABLE `fa_advkey` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_advkey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_advlist`
--

DROP TABLE IF EXISTS `fa_advlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_advlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `advtype` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告类型',
  `title` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告标题',
  `url` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '广告链接',
  `image` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '广告图片',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告语言',
  `status` enum('-2','-1','0','1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=黑名单,1=禁止投放,0=审核中,1=审核成功,2=投放中',
  `advorder` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的订单号',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  `endtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='广告列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_advlist`
--

LOCK TABLES `fa_advlist` WRITE;
/*!40000 ALTER TABLE `fa_advlist` DISABLE KEYS */;
INSERT INTO `fa_advlist` VALUES (1,1,'searchtop','购买系统联系TG:@easSearchs','https://t.me/easSearchs',NULL,'zh-cn','2','6838668862a77','1748526728','1748526831','1751118728'),(2,1,'welcomeadv','购买系统请联系@easSearchs','https://t.me/easSearchs',NULL,'zh-cn','2','68386940915e0','1748527424','1748688499','1751119424'),(3,1,'searchbutton','购买系统请联系@easSearchs','https://t.me/easSearchs',NULL,'zh-cn','2','6838695c96d58','1748527452','1748688553','1771855452');
/*!40000 ALTER TABLE `fa_advlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_advorder`
--

DROP TABLE IF EXISTS `fa_advorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_advorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '购买者用户',
  `advorderid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告订单号',
  `advtype` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告类型',
  `amount` float(11,4) NOT NULL COMMENT '付款金额',
  `buytime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '购买时间',
  `other` text COLLATE utf8mb4_unicode_ci COMMENT '其他信息',
  `paytype` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '付款方式',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '添加时间',
  `paytime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='广告订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_advorder`
--

LOCK TABLES `fa_advorder` WRITE;
/*!40000 ALTER TABLE `fa_advorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_advorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_advtype`
--

DROP TABLE IF EXISTS `fa_advtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_advtype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告类型',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '价格',
  `weigh` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='广告类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_advtype`
--

LOCK TABLES `fa_advtype` WRITE;
/*!40000 ALTER TABLE `fa_advtype` DISABLE KEYS */;
INSERT INTO `fa_advtype` VALUES (1,'🔍','searchtop',50.0000,1,'1746946841','1747478057'),(2,'🔘','searchbutton',0.0000,1,'1746946850','1747308102'),(3,'👏','welcomeadv',0.0000,1,'1746946867','1747489840'),(4,'🕥','grouptime',0.0000,1,'1746946889','1747308122'),(5,'⏳','grouptop',0.0000,1,'1746946898','1747308131'),(7,'🏅','ranking',0.0000,4,'1747490957','1747490957');
/*!40000 ALTER TABLE `fa_advtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_area`
--

DROP TABLE IF EXISTS `fa_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_area` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` int(10) DEFAULT NULL COMMENT '父id',
  `shortname` varchar(100) DEFAULT NULL COMMENT '简称',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `mergename` varchar(255) DEFAULT NULL COMMENT '全称',
  `level` tinyint(4) DEFAULT NULL COMMENT '层级:1=省,2=市,3=区/县',
  `pinyin` varchar(100) DEFAULT NULL COMMENT '拼音',
  `code` varchar(100) DEFAULT NULL COMMENT '长途区号',
  `zip` varchar(100) DEFAULT NULL COMMENT '邮编',
  `first` varchar(50) DEFAULT NULL COMMENT '首字母',
  `lng` varchar(100) DEFAULT NULL COMMENT '经度',
  `lat` varchar(100) DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='地区表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_area`
--

LOCK TABLES `fa_area` WRITE;
/*!40000 ALTER TABLE `fa_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_attachment`
--

DROP TABLE IF EXISTS `fa_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_attachment` (
  `id` int(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category` varchar(50) DEFAULT '' COMMENT '类别',
  `admin_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `url` varchar(255) DEFAULT '' COMMENT '物理路径',
  `imagewidth` int(10) unsigned DEFAULT '0' COMMENT '宽度',
  `imageheight` int(10) unsigned DEFAULT '0' COMMENT '高度',
  `imagetype` varchar(30) DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '图片帧数',
  `filename` varchar(100) DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `mimetype` varchar(100) DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) DEFAULT '' COMMENT '透传数据',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建日期',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `uploadtime` bigint(16) DEFAULT NULL COMMENT '上传时间',
  `storage` varchar(100) NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='附件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_attachment`
--

LOCK TABLES `fa_attachment` WRITE;
/*!40000 ALTER TABLE `fa_attachment` DISABLE KEYS */;
INSERT INTO `fa_attachment` VALUES (1,'',1,0,'/assets/img/qrcode.png',150,150,'png',0,'qrcode.png',21859,'image/png','',1491635035,1491635035,1491635035,'local','17163603d0263e4838b9387ff2cd4877e8b018f6'),(2,'',1,0,'/uploads/20250518/ced6a36693ce41b4fee49d63cb427ba1.png',1887,96,'png',0,'cherry-export.png',6345,'image/png','',1747550126,1747550126,1747550126,'local','ee49e10b963e3d5b0a2fdf4974f250ba0c1a48d9'),(3,'',1,0,'/uploads/20250518/67a980bc84d9b3515122937b839f812e.mp4',0,0,'mp4',0,'1722008021447.mp4',1049621,'video/mp4','',1747550657,1747550657,1747550657,'local','5585ddc1887705b068db5692d2de53ecdb7c7b6e'),(4,'',1,0,'/uploads/20250518/a5ca912d8f92c222fb0df39452dac1ab.png',763,277,'png',0,'屏幕截图 2025-05-14 012630.png',121082,'image/png','',1747550843,1747550843,1747550843,'local','45666334186c836809a0209f5fdc0b9cc67b6ab4'),(5,'',1,0,'/uploads/20250601/565debffd67aff9dfb48a22906f40e77.png',226,52,'png',0,'logo.png',3652,'image/png','',1748781627,1748781627,1748781627,'local','6db300ad6c4fb3c5582c9d01d2e1a8c8fc01b1f9');
/*!40000 ALTER TABLE `fa_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_group`
--

DROP TABLE IF EXISTS `fa_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父组别',
  `name` varchar(100) DEFAULT '' COMMENT '组名',
  `rules` text NOT NULL COMMENT '规则ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_group`
--

LOCK TABLES `fa_auth_group` WRITE;
/*!40000 ALTER TABLE `fa_auth_group` DISABLE KEYS */;
INSERT INTO `fa_auth_group` VALUES (1,0,'Admin group','*',1491635035,1491635035,'normal'),(2,1,'Second group','13,14,16,15,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,1,9,10,11,7,6,8,2,4,5',1491635035,1491635035,'normal'),(3,2,'Third group','1,4,9,10,11,13,14,15,16,17,40,41,42,43,44,45,46,47,48,49,50,55,56,57,58,59,60,61,62,63,64,65,5',1491635035,1491635035,'normal'),(4,1,'Second group 2','1,4,13,14,15,16,17,55,56,57,58,59,60,61,62,63,64,65',1491635035,1491635035,'normal'),(5,2,'Third group 2','1,2,6,7,8,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34',1491635035,1491635035,'normal');
/*!40000 ALTER TABLE `fa_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_group_access`
--

DROP TABLE IF EXISTS `fa_auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '会员ID',
  `group_id` int(10) unsigned NOT NULL COMMENT '级别ID',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限分组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_group_access`
--

LOCK TABLES `fa_auth_group_access` WRITE;
/*!40000 ALTER TABLE `fa_auth_group_access` DISABLE KEYS */;
INSERT INTO `fa_auth_group_access` VALUES (1,1);
/*!40000 ALTER TABLE `fa_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_auth_rule`
--

DROP TABLE IF EXISTS `fa_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_auth_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `name` varchar(100) DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) DEFAULT '' COMMENT '图标',
  `url` varchar(255) DEFAULT '' COMMENT '规则URL',
  `condition` varchar(255) DEFAULT '' COMMENT '条件',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否为菜单',
  `menutype` enum('addtabs','blank','dialog','ajax') DEFAULT NULL COMMENT '菜单类型',
  `extend` varchar(255) DEFAULT '' COMMENT '扩展属性',
  `py` varchar(30) DEFAULT '' COMMENT '拼音首字母',
  `pinyin` varchar(100) DEFAULT '' COMMENT '拼音',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  KEY `weigh` (`weigh`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='节点表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_auth_rule`
--

LOCK TABLES `fa_auth_rule` WRITE;
/*!40000 ALTER TABLE `fa_auth_rule` DISABLE KEYS */;
INSERT INTO `fa_auth_rule` VALUES (1,'file',0,'dashboard','Dashboard','fa fa-dashboard','','','Dashboard tips',1,NULL,'','kzt','kongzhitai',1491635035,1491635035,143,'normal'),(2,'file',0,'general','General','fa fa-cogs','','','',1,NULL,'','cggl','changguiguanli',1491635035,1491635035,137,'normal'),(3,'file',0,'category','Category','fa fa-leaf','','','Category tips',0,NULL,'','flgl','fenleiguanli',1491635035,1491635035,119,'normal'),(4,'file',0,'addon','Addon','fa fa-rocket','','','Addon tips',0,NULL,'','cjgl','chajianguanli',1491635035,1747066759,0,'normal'),(5,'file',0,'auth','Auth','fa fa-group','','','',1,NULL,'','qxgl','quanxianguanli',1491635035,1491635035,99,'normal'),(6,'file',2,'general/config','Config','fa fa-cog','','','Config tips',1,NULL,'','xtpz','xitongpeizhi',1491635035,1491635035,60,'normal'),(7,'file',2,'general/attachment','Attachment','fa fa-file-image-o','','','Attachment tips',1,NULL,'','fjgl','fujianguanli',1491635035,1491635035,53,'normal'),(8,'file',2,'general/profile','Profile','fa fa-user','','','',1,NULL,'','grzl','gerenziliao',1491635035,1491635035,34,'normal'),(9,'file',5,'auth/admin','Admin','fa fa-user','','','Admin tips',1,NULL,'','glygl','guanliyuanguanli',1491635035,1491635035,118,'normal'),(10,'file',5,'auth/adminlog','Admin log','fa fa-list-alt','','','Admin log tips',1,NULL,'','glyrz','guanliyuanrizhi',1491635035,1491635035,113,'normal'),(11,'file',5,'auth/group','Group','fa fa-group','','','Group tips',1,NULL,'','jsz','juesezu',1491635035,1491635035,109,'normal'),(12,'file',5,'auth/rule','Rule','fa fa-bars','','','Rule tips',1,NULL,'','cdgz','caidanguize',1491635035,1491635035,104,'normal'),(13,'file',1,'dashboard/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,136,'normal'),(14,'file',1,'dashboard/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,135,'normal'),(15,'file',1,'dashboard/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,133,'normal'),(16,'file',1,'dashboard/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,134,'normal'),(17,'file',1,'dashboard/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,132,'normal'),(18,'file',6,'general/config/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,52,'normal'),(19,'file',6,'general/config/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,51,'normal'),(20,'file',6,'general/config/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,50,'normal'),(21,'file',6,'general/config/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,49,'normal'),(22,'file',6,'general/config/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,48,'normal'),(23,'file',7,'general/attachment/index','View','fa fa-circle-o','','','Attachment tips',0,NULL,'','','',1491635035,1491635035,59,'normal'),(24,'file',7,'general/attachment/select','Select attachment','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,58,'normal'),(25,'file',7,'general/attachment/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,57,'normal'),(26,'file',7,'general/attachment/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,56,'normal'),(27,'file',7,'general/attachment/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,55,'normal'),(28,'file',7,'general/attachment/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,54,'normal'),(29,'file',8,'general/profile/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,33,'normal'),(30,'file',8,'general/profile/update','Update profile','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,32,'normal'),(31,'file',8,'general/profile/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,31,'normal'),(32,'file',8,'general/profile/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,30,'normal'),(33,'file',8,'general/profile/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,29,'normal'),(34,'file',8,'general/profile/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,28,'normal'),(35,'file',3,'category/index','View','fa fa-circle-o','','','Category tips',0,NULL,'','','',1491635035,1491635035,142,'normal'),(36,'file',3,'category/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,141,'normal'),(37,'file',3,'category/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,140,'normal'),(38,'file',3,'category/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,139,'normal'),(39,'file',3,'category/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,138,'normal'),(40,'file',9,'auth/admin/index','View','fa fa-circle-o','','','Admin tips',0,NULL,'','','',1491635035,1491635035,117,'normal'),(41,'file',9,'auth/admin/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,116,'normal'),(42,'file',9,'auth/admin/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,115,'normal'),(43,'file',9,'auth/admin/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,114,'normal'),(44,'file',10,'auth/adminlog/index','View','fa fa-circle-o','','','Admin log tips',0,NULL,'','','',1491635035,1491635035,112,'normal'),(45,'file',10,'auth/adminlog/detail','Detail','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,111,'normal'),(46,'file',10,'auth/adminlog/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,110,'normal'),(47,'file',11,'auth/group/index','View','fa fa-circle-o','','','Group tips',0,NULL,'','','',1491635035,1491635035,108,'normal'),(48,'file',11,'auth/group/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,107,'normal'),(49,'file',11,'auth/group/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,106,'normal'),(50,'file',11,'auth/group/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,105,'normal'),(51,'file',12,'auth/rule/index','View','fa fa-circle-o','','','Rule tips',0,NULL,'','','',1491635035,1491635035,103,'normal'),(52,'file',12,'auth/rule/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,102,'normal'),(53,'file',12,'auth/rule/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,101,'normal'),(54,'file',12,'auth/rule/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,100,'normal'),(55,'file',4,'addon/index','View','fa fa-circle-o','','','Addon tips',0,NULL,'','','',1491635035,1491635035,0,'normal'),(56,'file',4,'addon/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(57,'file',4,'addon/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(58,'file',4,'addon/del','Delete','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(59,'file',4,'addon/downloaded','Local addon','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(60,'file',4,'addon/state','Update state','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(63,'file',4,'addon/config','Setting','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(64,'file',4,'addon/refresh','Refresh','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(65,'file',4,'addon/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(66,'file',0,'user','User','fa fa-user-circle','','','',1,NULL,'','hygl','huiyuanguanli',1491635035,1491635035,0,'normal'),(67,'file',66,'tg/user','usermang','fa fa-user','','','',1,'addtabs','','u','usermang',1491635035,1746713612,0,'normal'),(68,'file',67,'user/user/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(69,'file',67,'user/user/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(70,'file',67,'user/user/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(71,'file',67,'user/user/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(72,'file',67,'user/user/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(73,'file',66,'user/group','User group','fa fa-users','','','',0,NULL,'','hyfz','huiyuanfenzu',1491635035,1746605038,0,'normal'),(74,'file',73,'user/group/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(75,'file',73,'user/group/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(76,'file',73,'user/group/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(77,'file',73,'user/group/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(78,'file',73,'user/group/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(79,'file',66,'user/rule','User rule','fa fa-circle-o','','','',0,NULL,'','hygz','huiyuanguize',1491635035,1746605043,0,'normal'),(80,'file',79,'user/rule/index','View','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(81,'file',79,'user/rule/del','Del','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(82,'file',79,'user/rule/add','Add','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(83,'file',79,'user/rule/edit','Edit','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(84,'file',79,'user/rule/multi','Multi','fa fa-circle-o','','','',0,NULL,'','','',1491635035,1491635035,0,'normal'),(92,'file',0,'buttons','buttons','fa fa-circle-o','','','',1,'addtabs','','b','buttons',1746685668,1746713629,0,'normal'),(93,'file',92,'buttons/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746685668,1746685668,0,'normal'),(94,'file',92,'buttons/recyclebin','回收站','fa fa-circle-o','','','',0,NULL,'','hsz','huishouzhan',1746685668,1746685668,0,'normal'),(95,'file',92,'buttons/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746685668,1746685668,0,'normal'),(96,'file',92,'buttons/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746685668,1746685668,0,'normal'),(97,'file',92,'buttons/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746685668,1746685668,0,'normal'),(98,'file',92,'buttons/destroy','真实删除','fa fa-circle-o','','','',0,NULL,'','zssc','zhenshishanchu',1746685668,1746685668,0,'normal'),(99,'file',92,'buttons/restore','还原','fa fa-circle-o','','','',0,NULL,'','hy','huanyuan',1746685668,1746685668,0,'normal'),(100,'file',92,'buttons/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746685668,1746685668,0,'normal'),(103,'file',0,'tips','tips','fa fa-circle-o','','','',1,'addtabs','','t','tips',1746778139,1746872115,0,'normal'),(104,'file',103,'tips/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746778139,1746778139,0,'normal'),(105,'file',103,'tips/recyclebin','回收站','fa fa-circle-o','','','',0,NULL,'','hsz','huishouzhan',1746778139,1746778139,0,'normal'),(106,'file',103,'tips/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746778139,1746778139,0,'normal'),(107,'file',103,'tips/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746778139,1746778139,0,'normal'),(108,'file',103,'tips/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746778139,1746778139,0,'normal'),(109,'file',103,'tips/destroy','真实删除','fa fa-circle-o','','','',0,NULL,'','zssc','zhenshishanchu',1746778139,1746778139,0,'normal'),(110,'file',103,'tips/restore','还原','fa fa-circle-o','','','',0,NULL,'','hy','huanyuan',1746778139,1746778139,0,'normal'),(111,'file',103,'tips/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746778139,1746778139,0,'normal'),(112,'file',66,'userlogs/index','userlogs','fa fa-circle-o','','','',1,'addtabs','','u','userlogs',1746855243,1746855243,0,'normal'),(113,'file',0,'famysql/table','famysql','fa fa-database','','','可在线进行数据库表优化或修复,查看表结构和数据等',1,'addtabs','','f','famysql',1746860696,1746872080,0,'normal'),(114,'file',113,'famysql/table/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746860696,1746860696,0,'normal'),(115,'file',113,'famysql/table/table_add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746860696,1746860696,0,'normal'),(116,'file',113,'famysql/table/table_batch_add','快速建表','fa fa-circle-o','','','',0,NULL,'','ksjb','kuaisujianbiao',1746860696,1746860696,0,'normal'),(117,'file',113,'famysql/table/table_edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746860696,1746860696,0,'normal'),(118,'file',113,'famysql/table/table_del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746860696,1746860696,0,'normal'),(119,'file',113,'famysql/table/truncate','截/断表','fa fa-circle-o','','','',0,NULL,'','jdb','jieduanbiao',1746860696,1746860696,0,'normal'),(120,'file',113,'famysql/table/optimize','优化表','fa fa-circle-o','','','',0,NULL,'','yhb','youhuabiao',1746860696,1746860696,0,'normal'),(121,'file',113,'famysql/table/repair','修复表','fa fa-circle-o','','','',0,NULL,'','xfb','xiufubiao',1746860696,1746860696,0,'normal'),(122,'file',113,'famysql/table/copy','复制表','fa fa-circle-o','','','',0,NULL,'','fzb','fuzhibiao',1746860696,1746860696,0,'normal'),(123,'file',113,'famysql/table/backuplist','备份列表','fa fa-circle-o','','','',0,NULL,'','bflb','beifenliebiao',1746860696,1746860696,0,'normal'),(124,'file',113,'famysql/table/download','备份下载','fa fa-circle-o','','','',0,NULL,'','bfxz','beifenxiazai',1746860696,1746860696,0,'normal'),(125,'file',113,'famysql/table/restore','恢复','fa fa-circle-o','','','',0,NULL,'','hf','huifu',1746860696,1746860696,0,'normal'),(126,'file',113,'famysql/table/backup','备份','fa fa-circle-o','','','',0,NULL,'','bf','beifen',1746860696,1746860696,0,'normal'),(127,'file',113,'famysql/table/upload','上传文件','fa fa-circle-o','','','',0,NULL,'','scwj','shangchuanwenjian',1746860696,1746860696,0,'normal'),(128,'file',113,'famysql/index','索引管理','fa fa-list','','','',0,NULL,'','sygl','suoyinguanli',1746860696,1746860696,0,'normal'),(129,'file',128,'famysql/index/indexs','索引首页','fa fa-circle-o','','','',0,NULL,'','sysy','suoyinshouye',1746860696,1746860696,0,'normal'),(130,'file',128,'famysql/index/index_add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746860696,1746860696,0,'normal'),(131,'file',128,'famysql/index/index_edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746860696,1746860696,0,'normal'),(132,'file',128,'famysql/index/index_del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746860696,1746860696,0,'normal'),(133,'file',113,'famysql/field','字段管理','fa fa-list','','','',0,NULL,'','zdgl','ziduanguanli',1746860696,1746860696,0,'normal'),(134,'file',133,'famysql/field/fields','字段首页','fa fa-circle-o','','','',0,NULL,'','zdsy','ziduanshouye',1746860696,1746860696,0,'normal'),(135,'file',133,'famysql/field/create','快速建表','fa fa-circle-o','','','',0,NULL,'','ksjb','kuaisujianbiao',1746860696,1746860696,0,'normal'),(136,'file',133,'famysql/field/field_add','添加字段','fa fa-circle-o','','','',0,NULL,'','tjzd','tianjiaziduan',1746860696,1746860696,0,'normal'),(137,'file',133,'famysql/field/field_edit','修改字段','fa fa-circle-o','','','',0,NULL,'','xgzd','xiugaiziduan',1746860696,1746860696,0,'normal'),(138,'file',133,'famysql/field/field_del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746860696,1746860696,0,'normal'),(139,'file',133,'famysql/field/field_drag','字段排序','fa fa-circle-o','','','',0,NULL,'','zdpx','ziduanpaixu',1746860696,1746860696,0,'normal'),(140,'file',2,'general/logs','logs','fa fa-pied-piper-alt','','','',1,'addtabs','','l','logs',1746860727,1746871983,0,'normal'),(141,'file',140,'general/logs/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746860727,1746860727,0,'normal'),(142,'file',140,'general/logs/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746860727,1746860727,0,'normal'),(143,'file',140,'general/logs/detail','详情','fa fa-circle-o','','','',0,NULL,'','xq','xiangqing',1746860727,1746860727,0,'normal'),(144,'file',2,'general/crontab','crontab','fa fa-tasks','','','按照设定的时间进行任务的执行,目前支持三种任务:请求URL、执行SQL、执行Shell。',1,'addtabs','','c','crontab',1746860756,1746872049,0,'normal'),(145,'file',144,'general/crontab/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746860756,1746860756,0,'normal'),(146,'file',144,'general/crontab/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746860756,1746860756,0,'normal'),(147,'file',144,'general/crontab/edit','编辑 ','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746860756,1746860756,0,'normal'),(148,'file',144,'general/crontab/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746860756,1746860756,0,'normal'),(149,'file',144,'general/crontab/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746860756,1746860756,0,'normal'),(150,'file',162,'lable','lable','fa fa-circle-o','','','',1,'addtabs','','l','lable',1746867224,1746872152,0,'normal'),(151,'file',150,'lable/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746867224,1746867224,0,'normal'),(152,'file',150,'lable/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746867224,1746867224,0,'normal'),(153,'file',150,'lable/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746867224,1746867224,0,'normal'),(154,'file',150,'lable/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746867224,1746867224,0,'normal'),(155,'file',150,'lable/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746867224,1746867224,0,'normal'),(156,'file',162,'groupcate','groupcate','fa fa-circle-o','','','',1,'addtabs','','g','groupcate',1746867389,1746872175,0,'normal'),(157,'file',156,'groupcate/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746867389,1746867389,0,'normal'),(158,'file',156,'groupcate/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746867389,1746867389,0,'normal'),(159,'file',156,'groupcate/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746867389,1746867389,0,'normal'),(160,'file',156,'groupcate/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746867389,1746867389,0,'normal'),(161,'file',156,'groupcate/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746867389,1746867389,0,'normal'),(162,'file',0,'groupsman','groupsman','fa fa-circle-o','','','',1,'addtabs','','g','groupsman',1746867423,1746867525,0,'normal'),(163,'file',162,'groups','groups','fa fa-circle-o','','','',1,'addtabs','','g','groups',1746867490,1746867490,0,'normal'),(164,'file',0,'advman','advman','fa fa-circle-o','','','',1,'addtabs','','a','advman',1746872261,1746872261,0,'normal'),(165,'file',267,'groupaudit','待审群组','fa fa-circle-o','','','',1,'addtabs','','dsqz','daishenqunzu',1746873536,1747628576,0,'normal'),(167,'file',66,'lang','语言管理','fa fa-circle-o','','','',1,'addtabs','','yygl','yuyanguanli',1746878057,1746878101,0,'normal'),(168,'file',167,'lang/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746878057,1746878057,0,'normal'),(169,'file',167,'lang/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746878057,1746878057,0,'normal'),(170,'file',167,'lang/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746878057,1746878057,0,'normal'),(171,'file',167,'lang/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746878057,1746878057,0,'normal'),(172,'file',167,'lang/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746878057,1746878057,0,'normal'),(173,'file',66,'receivpayments','提现地址列管理','fa fa-circle-o','','','',1,'addtabs','','txdzlgl','tixiandizhilieguanli',1746945780,1746945811,0,'normal'),(174,'file',173,'receivpayments/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746945780,1746945780,0,'normal'),(175,'file',173,'receivpayments/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746945780,1746945780,0,'normal'),(176,'file',173,'receivpayments/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746945780,1746945780,0,'normal'),(177,'file',173,'receivpayments/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746945780,1746945780,0,'normal'),(178,'file',173,'receivpayments/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746945780,1746945780,0,'normal'),(179,'file',0,'orderman','orderman','fa fa-circle-o','','','',1,'addtabs','','o','orderman',1746946516,1746946516,0,'normal'),(180,'file',164,'advtype','广告类型','fa fa-circle-o','','','',1,'addtabs','','gglx','guanggaoleixing',1746946786,1746946805,0,'normal'),(181,'file',180,'advtype/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746946786,1746946786,0,'normal'),(182,'file',180,'advtype/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746946786,1746946786,0,'normal'),(183,'file',180,'advtype/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746946786,1746946786,0,'normal'),(184,'file',180,'advtype/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746946786,1746946786,0,'normal'),(185,'file',180,'advtype/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746946786,1746946786,0,'normal'),(186,'file',179,'recharge','充值列管理','fa fa-circle-o','','','',1,'addtabs','','czlgl','chongzhilieguanli',1746947814,1746947843,0,'normal'),(187,'file',186,'recharge/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1746947814,1746947814,0,'normal'),(188,'file',186,'recharge/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1746947814,1746947814,0,'normal'),(189,'file',186,'recharge/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1746947814,1746947814,0,'normal'),(190,'file',186,'recharge/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1746947814,1746947814,0,'normal'),(191,'file',186,'recharge/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1746947814,1746947814,0,'normal'),(192,'file',179,'withdraw','提现列管理','fa fa-circle-o','','','',1,'addtabs','','txlgl','tixianlieguanli',1747024102,1747024128,0,'normal'),(193,'file',192,'withdraw/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747024102,1747024102,0,'normal'),(194,'file',192,'withdraw/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747024102,1747024102,0,'normal'),(195,'file',192,'withdraw/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747024102,1747024102,0,'normal'),(196,'file',192,'withdraw/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747024102,1747024102,0,'normal'),(197,'file',192,'withdraw/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747024102,1747024102,0,'normal'),(198,'file',179,'advorder','广告订单','fa fa-circle-o','','','',1,'addtabs','','ggdd','guanggaodingdan',1747024466,1747024482,0,'normal'),(199,'file',198,'advorder/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747024466,1747024466,0,'normal'),(200,'file',198,'advorder/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747024466,1747024466,0,'normal'),(201,'file',198,'advorder/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747024466,1747024466,0,'normal'),(202,'file',198,'advorder/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747024466,1747024466,0,'normal'),(203,'file',198,'advorder/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747024466,1747024466,0,'normal'),(204,'file',164,'advlist','广告列管理','fa fa-circle-o','','','',1,'addtabs','','gglgl','guanggaolieguanli',1747024798,1747024813,0,'normal'),(205,'file',204,'advlist/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747024798,1747024798,0,'normal'),(206,'file',204,'advlist/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747024798,1747024798,0,'normal'),(207,'file',204,'advlist/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747024798,1747024798,0,'normal'),(208,'file',204,'advlist/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747024798,1747024798,0,'normal'),(209,'file',204,'advlist/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747024798,1747024798,0,'normal'),(210,'file',164,'brand','品牌词列管理','fa fa-circle-o','','','',1,'addtabs','','ppclgl','pinpaicilieguanli',1747025151,1747025171,0,'normal'),(211,'file',210,'brand/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747025151,1747025151,0,'normal'),(212,'file',210,'brand/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747025151,1747025151,0,'normal'),(213,'file',210,'brand/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747025151,1747025151,0,'normal'),(214,'file',210,'brand/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747025151,1747025151,0,'normal'),(215,'file',210,'brand/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747025151,1747025151,0,'normal'),(216,'file',162,'keyword','关键词列管理','fa fa-circle-o','','','',1,'addtabs','','gjclgl','guanjiancilieguanli',1747066284,1747066313,0,'normal'),(217,'file',216,'keyword/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747066284,1747066284,0,'normal'),(218,'file',216,'keyword/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747066284,1747066284,0,'normal'),(219,'file',216,'keyword/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747066284,1747066284,0,'normal'),(220,'file',216,'keyword/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747066284,1747066284,0,'normal'),(221,'file',216,'keyword/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747066284,1747066284,0,'normal'),(222,'file',164,'advkey','关键词广告','fa fa-circle-o','','','',1,'addtabs','','gjcgg','guanjianciguanggao',1747066669,1747066689,0,'normal'),(223,'file',222,'advkey/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747066669,1747066669,0,'normal'),(224,'file',222,'advkey/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747066669,1747066669,0,'normal'),(225,'file',222,'advkey/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747066669,1747066669,0,'normal'),(226,'file',222,'advkey/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747066669,1747066669,0,'normal'),(227,'file',222,'advkey/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747066669,1747066669,0,'normal'),(228,'file',162,'report','举报类型列管理','fa fa-circle-o','','','',1,'addtabs','','jblxlgl','jubaoleixinglieguanli',1747120100,1747120158,0,'normal'),(229,'file',228,'report/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747120100,1747120100,0,'normal'),(230,'file',228,'report/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747120100,1747120100,0,'normal'),(231,'file',228,'report/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747120100,1747120100,0,'normal'),(232,'file',228,'report/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747120100,1747120100,0,'normal'),(233,'file',228,'report/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747120100,1747120100,0,'normal'),(234,'file',162,'reports','举报列管理','fa fa-circle-o','','','',1,'addtabs','','jblgl','jubaolieguanli',1747120503,1747121299,0,'normal'),(235,'file',234,'reports/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747120503,1747120503,0,'normal'),(236,'file',234,'reports/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747120503,1747120503,0,'normal'),(237,'file',234,'reports/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747120503,1747120503,0,'normal'),(238,'file',234,'reports/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747120503,1747120503,0,'normal'),(239,'file',234,'reports/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747120503,1747120503,0,'normal'),(240,'file',264,'goodsc','商品分类','fa fa-circle-o','','','',1,'addtabs','','spfl','shangpinfenlei',1747120634,1747121351,0,'normal'),(241,'file',240,'goodsc/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747120634,1747120634,0,'normal'),(242,'file',240,'goodsc/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747120634,1747120634,0,'normal'),(243,'file',240,'goodsc/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747120634,1747120634,0,'normal'),(244,'file',240,'goodsc/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747120634,1747120634,0,'normal'),(245,'file',240,'goodsc/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747120634,1747120634,0,'normal'),(246,'file',264,'goods','商品列管理','fa fa-circle-o','','','',1,'addtabs','','splgl','shangpinlieguanli',1747120917,1747121373,0,'normal'),(247,'file',246,'goods/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747120917,1747120917,0,'normal'),(248,'file',246,'goods/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747120917,1747120917,0,'normal'),(249,'file',246,'goods/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747120917,1747120917,0,'normal'),(250,'file',246,'goods/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747120917,1747120917,0,'normal'),(251,'file',246,'goods/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747120917,1747120917,0,'normal'),(252,'file',264,'greports','商品举报列管理','fa fa-circle-o','','','',1,'addtabs','','spjblgl','shangpinjubaolieguanli',1747121158,1747121384,0,'normal'),(253,'file',252,'greports/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747121158,1747121158,0,'normal'),(254,'file',252,'greports/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747121158,1747121158,0,'normal'),(255,'file',252,'greports/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747121158,1747121158,0,'normal'),(256,'file',252,'greports/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747121158,1747121158,0,'normal'),(257,'file',252,'greports/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747121158,1747121158,0,'normal'),(258,'file',264,'greport','商品举报类型','fa fa-circle-o','','','',1,'addtabs','','spjblx','shangpinjubaoleixing',1747121264,1747121359,0,'normal'),(259,'file',258,'greport/index','查看','fa fa-circle-o','','','',0,NULL,'','zk','zhakan',1747121264,1747121264,0,'normal'),(260,'file',258,'greport/add','添加','fa fa-circle-o','','','',0,NULL,'','tj','tianjia',1747121264,1747121264,0,'normal'),(261,'file',258,'greport/edit','编辑','fa fa-circle-o','','','',0,NULL,'','bj','bianji',1747121264,1747121264,0,'normal'),(262,'file',258,'greport/del','删除','fa fa-circle-o','','','',0,NULL,'','sc','shanchu',1747121264,1747121264,0,'normal'),(263,'file',258,'greport/multi','批量更新','fa fa-circle-o','','','',0,NULL,'','plgx','pilianggengxin',1747121264,1747121264,0,'normal'),(264,'file',0,'goodsmang','goodsmang','fa fa-circle-o','','','',0,'addtabs','','spgl','shangpinguanli',1747121317,1747121424,0,'normal'),(265,'file',162,'searchlogs','searchlogs','fa fa-circle-o','','','',1,'addtabs','','s','searchlogs',1747295742,1747295742,0,'normal'),(266,'file',162,'assesslog','assesslog','fa fa-circle-o','','','',1,'addtabs','','a','assesslog',1747295888,1747295888,0,'normal'),(267,'file',0,'audit','audit','fa fa-circle-o','','','',1,'addtabs','','a','audit',1747628516,1747628516,0,'normal'),(268,'file',0,'statistics','statistics','fa fa-circle-o','','','',0,'addtabs','','lwygkzt','lingwaiyigekongzhitai',1747650506,1747650578,0,'normal');
/*!40000 ALTER TABLE `fa_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_brand`
--

DROP TABLE IF EXISTS `fa_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `advorder` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的订单号',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属语言',
  `brandtitle` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌词',
  `brandicon` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '品牌图标',
  `status` enum('-2','-1','0','1','2') COLLATE utf8mb4_unicode_ci DEFAULT '0' COMMENT '状态:-2=黑名单,-1=禁止投放,0=审核中,1=审核成功待投放,1=投放中',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '添加时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  `endtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '到期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='品牌词列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_brand`
--

LOCK TABLES `fa_brand` WRITE;
/*!40000 ALTER TABLE `fa_brand` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_buttons`
--

DROP TABLE IF EXISTS `fa_buttons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Telegram按钮表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_buttons`
--

LOCK TABLES `fa_buttons` WRITE;
/*!40000 ALTER TABLE `fa_buttons` DISABLE KEYS */;
INSERT INTO `fa_buttons` VALUES (1,'开始按钮','这是开始按钮','start','Super 是一个帮助用户在 Telegram 上搜索的工具。\r\n\r\n👉🏻 [点击安装 【🇨🇳简体语言】](tg://setlanguage?lang=zhcncc)\r\n\r\n> 继续使用此机器人，即表示您同意服务条款。','','MarkDownV2',1,0,'[\r\n  [\r\n    {\r\n      \"text\": \"🏁语言(Languages)：简体中文\",\r\n      \"callback_data\": \"lang\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"📢频道\",\r\n      \"callback_data\": \"getchannelall\"\r\n    },\r\n    {\r\n      \"text\": \"👥群组\",\r\n      \"callback_data\": \"getgroupall\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🤖Bot\",\r\n      \"callback_data\": \"botlist\"\r\n    },\r\n    {\r\n      \"text\": \"🏷标签\",\r\n      \"callback_data\": \"lablelist\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"👤我的\",\r\n      \"callback_data\": \"my\"\r\n    },\r\n    {\r\n      \"text\": \"❓帮助\",\r\n      \"callback_data\": \"help\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🙋‍♂️ 在线客服\",\r\n      \"callback_data\": \"customer\"\r\n    },\r\n    {\r\n      \"text\": \"👤 AI客服\",\r\n      \"callback_data\": \"aicustomer\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🔥热搜词\",\r\n      \"callback_data\": \"hotsearchkey\"\r\n    },{\"text\":\"💹 营销中心\",\"callback_data\":\"marke\"}\r\n  ],\r\n\r\n  [\r\n    {\r\n      \"text\": \"🔥超级索引(邀请奖励)\",\r\n      \"callback_data\": \"invite\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"✖关闭\",\r\n      \"callback_data\": \"clone\"\r\n    }\r\n  ]\r\n]','zh-cn',1746685747,1747649366,NULL),(2,'语言列表','语言列表','lang','请点击下面语言\r\n\r\n设置语言\r\n\r\n您当前的语言:{lang}','','MarkDownV2',1,0,'[\r\n    {\r\n      \"text\": \"返回\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]','zh-cn',1747199323,1747200260,NULL),(3,'Start Buttons','This is start Buttons','start','Super 是一个帮助用户在 Telegram 上搜索的工具。\r\n\r\n👉🏻 [点击安装 【🇨🇳简体语言】](tg://setlanguage?lang=zhcncc)\r\n\r\n> 继续使用此机器人，即表示您同意服务条款。','','MarkDownV2',0,0,'[\r\n  [\r\n    {\r\n      \"text\": \"🏁 Languages：en\",\r\n      \"callback_data\": \"lang\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"📢频道\",\r\n      \"callback_data\": \"getchannelall\"\r\n    },\r\n    {\r\n      \"text\": \"👥群组\",\r\n      \"callback_data\": \"getgroupall\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🤖Bot\",\r\n      \"callback_data\": \"botlist\"\r\n    },\r\n    {\r\n      \"text\": \"🏷标签\",\r\n      \"callback_data\": \"lablelist\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"👤我的\",\r\n      \"callback_data\": \"my\"\r\n    },\r\n    {\r\n      \"text\": \"❓帮助\",\r\n      \"callback_data\": \"help\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🔥超级索引(邀请奖励)\",\r\n      \"callback_data\": \"invite\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"✖关闭\",\r\n      \"callback_data\": \"clone\"\r\n    }\r\n  ]\r\n]','en',1747202638,1747202682,NULL),(4,'Language list','Language list','lang','请点击下面语言\r\n\r\n设置语言\r\n\r\n您当前的语言:{lang}','','MarkDownV2',0,0,'[\r\n    {\r\n      \"text\": \"return\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]','en',1747202736,1747202800,NULL),(5,'我的','我的','my',' 欢迎   {userlink}\r\n💰 余额:  {balance}  USDT\r\n🏦 冻结余额:  {frozen_balance}  USDT\r\n🎉 押金:  {deposit}  USDT\r\n 状态:  {status}\r\n👩‍🦳 UID:   `{userid}`\r\n🔗 推广链接 : `https://t.me/demokelongBot?start={userid}`','','MarkDownV2',1,0,'[[{\"text\":\"🏁语言：{lang}\",\"callback_data\":\"lang\"}],[{\"text\":\"💰 加入【搜索联盟】，自动赚钱\",\"callback_data\":\"addsearchalliance\"}],[{\"text\":\"❤️ 点赞({count})\",\"callback_data\":\"like\"},{\"text\":\"🤝 频道联盟\",\"callback_data\":\"ChannelAlliance\"}],[{\"text\":\"🎁 官方群聊\",\"url\":\"https:\\/\\/core.telegram.org\"},{\"text\":\"💹 营销中心\",\"callback_data\":\"marke\"}],[{\"text\":\"🔗 添加链接\",\"callback_data\":\"mylink\"},{\"text\":\"🔗 我的链接\",\"callback_data\":\"mylink\"}],[{\"text\":\"💰 邀请赚钱\",\"callback_data\":\"invite\"},{\"text\":\"🔙 获取视频\",\"callback_data\":\"getvideo\"}],[{\"text\":\"🔙 返回\",\"callback_data\":\"start\"}]]','zh-cn',1747203083,1747731767,NULL),(6,'加入索引联盟','加入索引联盟','addsearchalliance','⚠️ 您还没有加入【索引联盟】。现在加入，自动赚钱。\r\n\r\n🔵 加入要求\r\n1. 群组成员数 >= 1,000\r\n2. @Super 提升为管理员\r\n3. 群组中不允许出现类似机器人\r\n4. 启用自动回复搜索和欢迎消息\r\n5. 启用加入【索引联盟】\r\n\r\n🔵 如何赚取收入\r\n👉 每次有效搜索 0.030 U（00.15）\r\n⚠️ 本系统将实施严格的反作弊机制，清理无效的搜索。\r\n⚠️ 如果发现异常刷量，合作将被取消，收入将被清零！！！\r\n\r\n🔵 加入步骤\r\n1. 将 @Super 添加到群组中，并将其提升为管理员。\r\n2. 在群组内发送 /update 命令。\r\n3. 点击【设置】。\r\n4. 启用 【🔲 加入索引联盟】。\r\n\r\n💡 提示：余额 >= 30 U 将在每月5日前自动发放到你的钱包 。','','MarkDownV2',1,0,'[[{\"text\":\"➕ 添加到群组\",\"url\":\"https://t.me/easSearchs\"},{\"text\":\"💰 收益排行榜\",\"callback_data\":\"income\"}],[{\"text\":\"❤️ 合伙人计划\",\"callback_data\":\"partner\"}],[{\"text\":\"🔙 返回\",\"callback_data\":\"my\"}]]','zh-cn',1747207245,1748781719,NULL),(7,'合伙人计划','合伙人计划','partner','⚠️ 您还没有加入【phpSearch】。现在加入，自动赚钱。\r\n\r\n🔵 加入要求\r\n1. 为phpSearch创建搜索群组\r\n2. 为phpSearch创建专门频道\r\n3. 需要支付最少 {amount} USDT\r\n4. 需要拉取广告商\r\n\r\n🔵 如何赚取收入\r\n👉 每天机器人会自动发送收益报表\r\n👉 每天机器人会自动发送用户列表数据\r\n👉 每天机器人会自动发送用户增加数据\r\n👉 每天机器人会自动发送用户支出数据\r\n👉 每天收益到账余额自行提现\r\n👉 每天将拿出收益的百分20分给合伙人\r\n\r\n🔵 收益计算\r\n\r\n收益总金额 * 0.2 * 您支付金额 / 总金额 = 收益金额 舍弃小数点\r\n','','MarkDownV2',1,0,'[[{\"text\":\"➕ 支付并加入计划\",\"callback_data\":\"addpartner\"}],[{\"text\":\"🔙 返回\",\"callback_data\":\"addsearchalliance\"}]]','zh-cn',1747207945,1747546393,NULL),(8,'频道联盟','频道联盟','ChannelAlliance','👏 欢迎加入超级频道联盟\r\n\r\n🔵 如何加入频道联盟\r\n1. 添加 @Super 到频道\r\n2. 给予管理员/置顶权限\r\n3. 详情请点击频道联盟介绍\r\n\r\n💡 没有管理的频道，加入联盟后查看吧！','','MarkDownV2',1,0,'[[{\"text\":\"🔙 返回\",\"callback_data\":\"my\"}]]','zh-cn',1747220013,1747220143,NULL),(9,'营销中心','营销中心','marke',' 该机器人已加入 {groupcount}群组，可触达 {groupmember} 用户。\r\n\r\n{grouplist}','','HTML',1,0,'  [[\r\n    {\r\n      \"text\": \"🏦 充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },\r\n    {\r\n      \"text\": \"🕛 记录\",\r\n      \"callback_data\": \"userlogs\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🙋‍♂️ 在线客服\",\r\n      \"callback_data\": \"customer\"\r\n    },{\r\n      \"text\": \"👤 AI客服\",\r\n      \"callback_data\": \"aicustomer\"\r\n    },{\r\n      \"text\": \"👩 普通客服\",\r\n      \"url\": \"{kefu_username}\"\r\n    }\r\n    ],\r\n    [{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"my\"\r\n    },{\r\n      \"text\": \"✖ 关闭\",\r\n      \"callback_data\": \"clone\"\r\n    }\r\n  ]]\r\n','zh-cn',1747220273,1747728089,NULL),(10,'充值中心','充值中心','recharge','点击下方按钮进行充值','','MarkDownV2',1,0,'[\r\n	[{\r\n			\"text\": \"🏦 5 U\",\r\n			\"callback_data\": \"confirmpay_5\"\r\n		},\r\n		{\r\n			\"text\": \"🏦 10 U\",\r\n			\"callback_data\": \"confirmpay_10\"\r\n		}\r\n	],\r\n	[{\r\n			\"text\": \"🏦 20 U\",\r\n			\"callback_data\": \"confirmpay_20\"\r\n		},\r\n		{\r\n			\"text\": \"🏦 50 U\",\r\n			\"callback_data\": \"confirmpay_50\"\r\n		}\r\n	],\r\n	[{\r\n			\"text\": \"🏦 100 U\",\r\n			\"callback_data\": \"confirmpay_100\"\r\n		},\r\n		{\r\n			\"text\": \"🏦 200 U\",\r\n			\"callback_data\": \"confirmpay_200\"\r\n		}\r\n	],\r\n	[{\r\n			\"text\": \"🏦 500 U\",\r\n			\"callback_data\": \"confirmpay_500\"\r\n		},\r\n		{\r\n			\"text\": \"🏦 1000 U\",\r\n			\"callback_data\": \"confirmpay_1000\"\r\n		}\r\n	],\r\n        [{\r\n			\"text\": \"🏦 自定义金额\",\r\n			\"callback_data\": \"customamount\"\r\n		}\r\n		\r\n	],\r\n	[{\r\n		\"text\": \"🔙 返回\",\r\n		\"callback_data\": \"marke\"\r\n	}]\r\n]','zh-cn',1747222827,1747223055,NULL),(11,'确认充值金额','确认充值金额','confirmpay','订单号 : `{orderid}`\r\n\r\n充值金额 : {amount} USDT\r\n\r\n请点击下方去付款','','MarkDownV2',1,0,'[\r\n	[{\r\n			\"text\": \"🚵‍♂️ 去付款\",\r\n			\"callback_data\": \"pay_{orderid}_{amount}\"\r\n		}\r\n	],\r\n	[{\r\n		\"text\": \"🔙 返回\",\r\n		\"callback_data\": \"recharge\"\r\n	},{\r\n		\"text\": \"✖ 关闭\",\r\n		\"callback_data\": \"clone\"\r\n	}]\r\n]','zh-cn',1747223242,1747224092,NULL),(12,'支付','支付','pay','订单号 : <code>{orderid}</code>\r\n三方订单号 : <code>{ordersn}</code>\r\n下单金额 : <code>{balance}</code> USDT\r\n支付金额 : <code>{paybalance}</code> USDT\r\n支付地址 : <code>{address}</code>\r\n支付网络 : {currency}\r\n到期时间 : {endtime}','','HTML',1,0,'[\r\n	\r\n	[{\r\n		\"text\": \"✖ 关闭订单并返回\",\r\n		\"callback_data\": \"recharge_{orderid}\"\r\n	}]\r\n]','zh-cn',1747224287,1747226003,NULL),(13,'帮助','帮助','help','欢迎使用 @demokelongBot 本机器人是一个搜索机器人哦\r\n\r\n/start - 开始\r\n/update - 更新链接\r\n/lang - 改变你的语言\r\n/buyad - 购买广告\r\n/hotkey - 热门关键词','','MarkDownV2',1,0,'[\r\n	[{\r\n			\"text\": \"🫂 加入官方交流群\",\r\n			\"url\": \"https://t.me/bot68i\"\r\n		}\r\n	],\r\n	[{\r\n		\"text\": \"➕ 添加到群组\",\r\n		\"url\": \"https://t.me/bot68i\"\r\n	},{\r\n		\"text\": \"🎟 关注频道\",\r\n		\"url\": \"https://t.me/bot68i\"\r\n	},{\r\n		\"text\": \"✍ 隐私条款\",\r\n		\"url\": \"https://t.me/bot68i\"\r\n	}],[\r\n    {\r\n      \"text\": \"🙋‍♂️ 在线客服\",\r\n      \"callback_data\": \"customer\"\r\n    },\r\n    {\r\n      \"text\": \"👤 AI客服\",\r\n      \"callback_data\": \"aicustomer\"\r\n    }\r\n  ], [{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"start\"\r\n    },{\r\n      \"text\": \"✖ 关闭\",\r\n      \"callback_data\": \"clone\"\r\n    }\r\n  ]\r\n]','zh-cn',1747226692,1747227313,NULL),(14,'喜欢的内容','喜欢的内容','like ','[广告] {searchtop}\r\n\r\n{likelist}','','HTML',1,0,'[\r\n	[{\r\n		\"text\": \"👥 群组\",\r\n		\"callback_data\": \"like_supergroup\"\r\n	},{\r\n		\"text\": \"📢 频道\",\r\n		\"callback_data\": \"like_channel\"\r\n	},{\r\n		\"text\": \"🤖 机器人\",\r\n		\"callback_data\": \"like_bot\"\r\n	}], [{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"my\"\r\n    },{\r\n      \"text\": \"✖ 关闭\",\r\n      \"callback_data\": \"clone\"\r\n    }\r\n  ]\r\n]','zh-cn',1747235802,1747497009,NULL),(15,'邀请赚钱','邀请赚钱','invite','🔥 超级索引（邀请奖励）\r\n\r\n邀请好友使用“超级索引”您就能长期从好友的搜索中赚取收益。\r\n\r\n邀请方式 1\r\n<pre> 把“超级索引”以管理员身份添加到（群组|频道）点击分享“超级索引”，机器人会定时向此群组|频道推送拉新文案。新用户点击文案下方链接进入“超级索引”您会获得 0.18 💲奖励。</pre>\r\n\r\n邀请方式 2\r\n<pre>使用邀请链接“直推一个新用户”你会获得 0.1  U奖励。</pre>\r\n\r\n裂变奖励 3\r\n<pre>您的一级直推用户，每裂变一个新用户，您会获得 0.02 U二级裂变奖励！</pre>\r\n\r\n索引联盟 4\r\n<pre>添加“超级索引”到群组设置管理员，“开启搜索联盟”，用户每次有效搜索您会获得 0.03 U奖励。</pre>\r\n\r\n搜索收益 🔍 \r\n<pre>您的直推用户每进行一次有效搜索，您会获得 0.0036 U收益，您的二级裂变用户每进行一次有效搜索，您会获得 0.0009 U收益！</pre>\r\n\r\n点击复制您的专属分享链接\r\n🔍 Telegram 必备搜索神器，发现您感兴趣的群组，频道，机器人 👉 <code>https://t.me/Super?start={uid}</code>','','HTML',1,0,'[\r\n  [\r\n    {\r\n      \"text\": \"🔊 获取推广文案\",\r\n      \"callback_data\": \"getpromotion\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🎖 邀请排行榜\",\r\n      \"callback_data\": \"inrank\"\r\n    },\r\n    {\r\n      \"text\": \"🎖 收益排行榜\",\r\n      \"callback_data\": \"income\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"📊 拉新数据\",\r\n      \"callback_data\": \"lachine\"\r\n    },\r\n    {\r\n      \"text\": \"❓ 常见问题\",\r\n      \"callback_data\": \"issue\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"👥 官方交流群\",\r\n      \"url\": \"https://t.me/bot68i\"\r\n    },\r\n    {\r\n      \"text\": \"👤 个人中心\",\r\n      \"callback_data\": \"my\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"my\"\r\n    }\r\n  ]\r\n]','zh-cn',1747237015,1747731622,NULL),(16,'获取频道列表','获取频道列表','getchannelall','[广告] {adv}\r\n\r\n{grouplist}','','HTML',1,0,'{\"notup\":\"💹 购买广告\",\"notuptype\":\"callback_data\",\"notuptypedata\":\"marke\",\"notnext\":\"{advtitle}\",\"notnexttype\":\"url\",\"nnotnextdata\":\"{advurl}\"}','zh-cn',1747309829,1747316131,NULL),(17,'获取群组列表','获取群组列表','getgroupall','[广告] {adv}\r\n\r\n{grouplist}','','HTML',1,0,'{\"notup\":\"💹 购买广告\",\"notuptype\":\"callback_data\",\"notuptypedata\":\"marke\",\"notnext\":\"{advtitle}\",\"notnexttype\":\"url\",\"nnotnextdata\":\"{advurl}\"}','zh-cn',1747318919,1747318954,NULL),(18,'获取频道详细信息','获取频道详细信息','getchannel','链接： {link}\r\n类型：频道\r\n所属语言： Simplified Chinese (简体中文)\r\n标题：{title}\r\n描述：{content}\r\n标签：{lables}\r\n成员数：{count}\r\nKD : {kd}\r\n状态：{status}\r\n收录时间：{addtime}\r\n更新时间：{updatetime}\r\n\r\n💡 在群组|频道中分享“超级索引”可自动赚取拉新收益，并提高15%索引权重！','','HTML',0,0,'[\r\n  [\r\n    {\r\n      \"text\": \"👍 {likenumber}\",\r\n      \"callback_data\": \"getchannel_{id}_like\"\r\n    },{\r\n      \"text\": \"👎 {heitnumber}\",\r\n      \"callback_data\": \"getchannel_{id}_heit\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"👮‍♂ 举报\",\r\n      \"callback_data\": \"report_{id}\"\r\n    },\r\n    {\r\n      \"text\": \"👥 官方交流群\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n  [\r\n    {\r\n      \"text\": \"🔙 返回首页\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]\r\n]','zh-cn',1747324943,1747327364,NULL),(19,'举报类型列表','举报类型列表','report','链接： {link}\r\n类型：频道\r\n所属语言： Simplified Chinese (简体中文)\r\n标题：{title}\r\n描述：{content}\r\n标签：{lables}\r\n成员数：{count}\r\nKD : {kd}\r\n状态：{status}\r\n收录时间：{addtime}\r\n更新时间：{updatetime}\r\n\r\n💡 在群组|频道中分享“超级索引”可自动赚取拉新收益，并提高15%索引权重！','','HTML',1,0,'  [\r\n    {\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"getchannel_{id}\"\r\n    }\r\n  ]\r\n','zh-cn',1747345118,1747346534,NULL),(20,'标签列表','标签列表','lablelist','选择你感兴趣的类别 👇','','HTML',1,0,'  [\r\n    {\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]\r\n','zh-cn',1747349816,1747350277,NULL),(21,'搜索展示的内容','搜索展示的内容','showsearch','[广告]{searchtop_adv}\r\n\r\n{grouplist}\r\n\r\n总共{total} 条记录，当前在第{page}页，今日搜索{searchcount}次','','HTML',1,0,'{\"notup\":\"💹 购买广告\",\"notuptype\":\"callback_data\",\"notuptypedata\":\"marke\",\"notnext\":\"{advtitle}\",\"notnexttype\":\"url\",\"nnotnextdata\":\"{advurl}\"}','zh-cn',1747394767,1747556433,NULL),(22,'欢饮进群','欢饮进群','welcome','[广告]{welcome_adv}\r\n\r\n欢迎{nick} 进群哦','','HTML',1,0,'','zh-cn',1747404199,1747404199,NULL),(23,'关键词广告','关键词广告','hotkey','当前关键词【{keyword}】 正在参与投放中的有 {count} 条\r\n\r\n关键词初始价格 : {amount} USDT\r\n\r\n当前关键词最低出价 : {lowestamount} USDT\r\n\r\n当前关键词最高出价 : {balance} USDT\r\n\r\n说明 : 关键词初始价格不代表为最低出价，关键词价格会根据每天的搜索量来决定最低出价方案，出价方式为 初始价格 + 昨天搜索量 / 昨天总搜索量 * 1000，关键词广告每隔关键词最多展示【{keycount}】个，展示开始为第二天的0点0分(可能稍晚)到第二天的23点59分时最高出价的【{keycount}】条记录，并在第二天的0点统一扣除余额，余额不足的将由剩下的最高出价补上。','','HTML',1,0,'  [\r\n\r\n    {\r\n      \"text\": \"🚚 出价\",\r\n      \"callback_data\": \"buykeyword_{keyword}\"\r\n    },{\r\n      \"text\": \"👀 查看更多关键词\",\r\n      \"callback_data\": \"hotsearchkey\"\r\n    },{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]\r\n','zh-cn',1747414746,1747546024,NULL),(24,'出价关键词','出价关键词','buykeyword','当前出价的关键词【{keyword}】\r\n\r\n当前最高出价 {amount} USDT\r\n\r\n请回复您的出价(必须是数字,必须比最低出价高)','','HTML',1,0,'','zh-cn',1747464028,1747464028,NULL),(25,'设置关键词','设置关键词','setkeyword','您当前设置的关键词【{keyword}】点击下方按钮进行设置\r\n\r\n当前出价 : {amount} USDT\r\n\r\n状态 : {status} \r\n\r\n关联群组 : {group}\r\n\r\n状态说明 : 状态为停止投放，将不会收取您的费用且搜索将不再给你广告排名，状态为等待投放将进入第二天的投放准备(等待投放不代表就会被投放)，\r\n状态为投放中则为今天已经在投放了\r\n\r\n变更关联群组将重新进入审核状态,审核成功自动进入待投放','','HTML',1,0,'  [\r\n    [{\r\n      \"text\": \"[⚙ 设置关联群组]\",\r\n      \"callback_data\": \"setkeywordgroup_{id}\"\r\n    },{\r\n      \"text\": \"[⚙ 设置出价]\",\r\n      \"callback_data\": \"buykeyword_{keyword}\"\r\n    }\r\n  ],[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747466935,1747495151,NULL),(26,'我的链接','我的链接','mylink','您有{count} 个链接,请点击下方按钮进行操作','','HTML',1,0,'  [{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"my\"\r\n    }\r\n  ]\r\n','zh-cn',1747473783,1747474454,NULL),(27,'机器人列表','机器人列表','botlist','[广告]{adv}\r\n\r\n{list}','','HTML',1,0,'  [{\r\n      \"text\": \"🔙 返回\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]\r\n','zh-cn',1747474742,1747475768,NULL),(28,'顶部搜索广告','顶部搜索广告','searchtop','💡 {amount} U/月/轮播。 您有 {advcount} 个可用的广告位。\r\n\r\n{advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🔍 搜索结果顶部广告\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addsearchtop\"\r\n    },{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747476302,1747490465,NULL),(29,'添加新的搜索结果顶部广告','添加新的搜索结果顶部广告','addsearchtop','👩‍💼 你正在购买[{type}]\r\n\r\n金额：{amount} U \r\n\r\n‼️ 点击下面的[去支付]按钮 👇，然后点击[开始]','','HTML',1,0,'  [\r\n    [{\r\n      \"text\": \"🏦 去充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },{\r\n      \"text\": \"💵去支付\",\r\n      \"callback_data\": \"payadv_searchtop\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747478144,1747490470,NULL),(30,'支付广告','支付广告','payadv','支付成功，点击下方设置即可对广告进行设置','','HTML',1,0,'  [\r\n    [{\r\n      \"text\": \"⚙️ 设置广告\",\r\n      \"callback_data\": \"setadv_{id}\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747479207,1747479446,NULL),(31,'设置广告','设置广告','setadv','您正在设置【{advtitle}】\r\n\r\n广告标题 : 【{advtitle}】\r\n广告URL : 【{advurl}】\r\n广告类型 : 【{advtype}】\r\n广告状态 : 【{advstatus}】\r\n添加时间 : 【{addtime}】\r\n到期时间 : 【{endtime}】\r\n\r\n提示:当前广告到期时间仅供参考,已审核成功待投放开始计算时间\r\n审核成功的广告如果需要修改,则需要重新提交审核等待审核,期间时间不返还','','HTML',0,0,'  [\r\n   [{\r\n      \"text\": \"👀 查看广告投放数据\",\r\n      \"callback_data\": \"submit_seedata_{id}\"\r\n    }\r\n  ], \r\n    [{\r\n      \"text\": \"🧐 提交审核\",\r\n      \"callback_data\": \"submit_audit_{id}\"\r\n    },{\r\n      \"text\": \"💸 续费广告\",\r\n      \"callback_data\": \"submit_renewal_{id}\"\r\n    }\r\n  ], \r\n    [{\r\n      \"text\": \"✍ 设置标题\",\r\n      \"callback_data\": \"submit_title_{id}\"\r\n    }\r\n  ,{\r\n      \"text\": \"🔗 设置链接\",\r\n      \"callback_data\": \"submit_url_{id}\"\r\n    }\r\n  ], [{\r\n      \"text\": \"🙊 开始投放\",\r\n      \"callback_data\": \"submit_put_{id}\"\r\n    }\r\n  ,{\r\n      \"text\": \"🙈 暂停投放\",\r\n      \"callback_data\": \"submit_noput_{id}\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747480256,1747484331,NULL),(32,'修改广告哦','修改广告哦','submit','您正在续费【{advtitle}】\r\n\r\n广告标题 : 【{advtitle}】\r\n广告URL : 【{advurl}】\r\n广告类型 : 【{advtype}】\r\n广告状态 : 【{advstatus}】\r\n到期时间 : 【{endtime}】\r\n续费后到期时间 : 【{xfendtime}】\r\n\r\n续费金额 : 【{amount} USDT】\r\n\r\n提示:广告状态为待投放和投放中不受影响','','HTML',1,0,'  [\r\n   [{\r\n      \"text\": \"💰 立即续费\",\r\n      \"callback_data\": \"submit_pay_{id}\"\r\n    }\r\n  ], \r\n   \r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747481523,1748688727,NULL),(33,'搜索按钮广告','搜索按钮广告','searchbutton','💡 {amount} U/月/轮播。 您有 {advcount} 个可用的广告位。\r\n\r\n{advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🔘 搜索结果按钮广告\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addsearchbutton\"\r\n    },{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747488604,1747490405,NULL),(34,'购买搜索底部按钮广告','购买搜索底部按钮广告','addsearchbutton','👩‍💼 你正在购买[{type}]\r\n\r\n金额：{amount} U \r\n\r\n‼️ 点击下面的[去支付]按钮 👇，然后点击[开始]','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🏦 去充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },{\r\n      \"text\": \"💵去支付\",\r\n      \"callback_data\": \"payadv_searchbutton\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747488923,1747490414,NULL),(35,'欢迎进群广告','欢迎进群广告','welcomeadv','💡 {amount} U/月/轮播。 您有 {advcount} 个可用的广告位。\r\n\r\n{advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"👏 欢迎进群广告\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addwelcomeadv\"\r\n    },{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747489541,1747490421,NULL),(36,'添加欢迎进群广告','添加欢迎进群广告','addwelcomeadv','👩‍💼 你正在购买[{type}]\r\n\r\n金额：{amount} U \r\n\r\n‼️ 点击下面的[去支付]按钮 👇，然后点击[开始]','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🏦 去充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },{\r\n      \"text\": \"💵去支付\",\r\n      \"callback_data\": \"payadv_welcomeadv\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747489590,1747490428,NULL),(37,'定时任务广告','定时任务广告','grouptime','💡 {amount} U/月/轮播。 您有 {advcount} 个可用的广告位。\r\n\r\n{advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🕥 群组定时任务广告\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addgrouptime\"\r\n    },{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747490014,1747490435,NULL),(38,'添加定时任务广告','添加定时任务广告','addgrouptime','👩‍💼 你正在购买[{type}]\r\n\r\n金额：{amount} U \r\n\r\n‼️ 点击下面的[去支付]按钮 👇，然后点击[开始]','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🏦 去充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },{\r\n      \"text\": \"💵去支付\",\r\n      \"callback_data\": \"payadv_grouptime\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747490055,1747490445,NULL),(39,'群组置顶广告','群组置顶广告','grouptop','💡 {amount} U/月/轮播。 您有 {advcount} 个可用的广告位。\r\n\r\n{advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"⏳ 定时置顶任务广告\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addgrouptop\"\r\n    },{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747490158,1747490450,NULL),(40,'添加群组置顶广告','添加群组置顶广告','addgrouptop','👩‍💼 你正在购买[{type}]\r\n\r\n金额：{amount} U \r\n\r\n‼️ 点击下面的[去支付]按钮 👇，然后点击[开始]','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"🏦 去充值\",\r\n      \"callback_data\": \"recharge\"\r\n    },{\r\n      \"text\": \"💵去支付\",\r\n      \"callback_data\": \"payadv_grouptop\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747490202,1747490456,NULL),(41,'品牌词','品牌词','brand','‼️ 购买此广告需要管理员审核\r\n\r\n- 通用词不能购买，例如：微信\r\n- TG里公认的品牌词限品牌方购买，例如：新币\r\n- 拥有资质的可以购买，例如：腾讯\r\n- 资质包括：商标、网站、社交媒体（Twitter、Facebook、微信）认证\r\n\r\n {advcountstr}， 点击[💵添加新广告]来购买广告。','','HTML',1,0,'  [\r\n    [{\r\n      \"text\": \"[®️ 品牌专页广告]\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"💵添加新广告\",\r\n      \"callback_data\": \"addband\"\r\n    },{\r\n      \"text\": \"👉已注册品牌\",\r\n      \"callback_data\": \"myband\"\r\n    }],[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747491376,1747491623,NULL),(42,'关键词排名广告','关键词排名广告','ranking','/hotkey - 查看热门词排行\r\n/sokey - 查询关键字最高价格\r\n\r\n👉 你可以点击 [🔥 热门词排行] 来寻找关键词。\r\n\r\n👉 你也可以发送 \"/sokey 关键词\" 来查询排名的价格。','','HTML',0,0,'  [\r\n    [{\r\n      \"text\": \"[🏅 关键词广告]\",\r\n      \"url\": \"https://t.me/buzhiguiqi\"\r\n    }\r\n  ],\r\n    [{\r\n      \"text\": \"🔥 热门词排行\",\r\n      \"callback_data\": \"hotsearchkey\"\r\n    },{\r\n      \"text\": \"👉 我的关键词\",\r\n      \"callback_data\": \"mykey\"\r\n    }],[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',1747491733,1747545519,NULL),(43,'我的关键词','我的关键词','mykey','您有 {count} 个关键词广告','','HTML',1,0,'','zh-cn',1747492283,1747492283,NULL),(44,'设置关联群组','设置关联群组','setkeywordgroup','您当前有 {count} 个群组 ，请选择下列群组列表设置关联群组','','HTML',1,0,'  \r\n[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"setkeyword_{id}\"\r\n    }\r\n  ]\r\n','zh-cn',1747495416,1747496231,NULL),(45,'绑定群组','绑定群组','binding','您已成功绑定群组，点击下方返回关键词设置','','HTML',1,0,' [ \r\n[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"setkeyword_{id}\"\r\n    }\r\n  ]]\r\n','zh-cn',1747496354,1747496383,NULL),(46,'获取小姐姐视频','获取小姐姐视频','getvideo','{getvideo}   不要撸管子哦','','HTML',1,0,' [ \r\n[{\r\n      \"text\": \"🔙再来一发\",\r\n      \"callback_data\": \"getvideo\"\r\n    }\r\n  ],\r\n[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"setkeyword_{id}\"\r\n    }\r\n  ]]\r\n','zh-cn',1747502220,1747502683,NULL),(47,'热搜词列表','热搜词列表','hotsearchkey','请点击下方热门词按钮查看详情','','HTML',1,0,'\r\n[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"start\"\r\n    }\r\n  ]\r\n','zh-cn',1747545157,1747545408,NULL),(48,'获取关键词','获取关键词','gethotkey','123','','HTML',1,0,'','zh-cn',1747545675,1747545675,NULL),(49,'获取推广文案','获取推广文案','getpromotion','🔍 TG必备搜索神器「超级索引」 \r\n\r\n发现你感兴趣的，群组，频道、新闻、或机器人！\r\n\r\n👉 t.me/Super?start={id}','/uploads/20250601/565debffd67aff9dfb48a22906f40e77.png','HTML',0,0,'','zh-cn',1747549803,1748781630,NULL),(50,'常见问题','常见问题','issue','❓ 超级索引常见问题！\r\n\r\n⒈ 受益人怎么形成的？\r\n新用户通过你的邀请链接绑定，则成为你的人下级用户。\r\n\r\n⒉ 直推搜索收益归属？\r\n搜索群进行搜索的收益归群的受益人，私聊机器人搜索收益归上级受益人，采用邀请链接和群推广“超级索引”都可以成为用户的上级。\r\n\r\n⒊ 我的用户变少了？\r\n群解散和把机器人踢出群，会丢失通过这个群绑定的直推和裂变用户，把机器人邀请进群，会恢复绑定，同理你的下级用户将机器人踢出，你的裂变也会减少。\r\n\r\n⒋ 搜索次数与收益不符\r\n系统会自动清理重复和无效搜索，单个用户每日搜索达到上限就不再产生收益，每个用户单日可产生20个有效搜索，具体产生几次有效由系统判定（无效举例：多次搜索不进行其他动作，则会判定为无效）\r\n\r\n⒌ 超级索引收益有哪些\r\n索引联盟收益，拉新邀请奖励，裂变奖励，群组置顶奖励（索引联盟开启群组置顶每次有效搜索 0.03 U）未开启置顶则是 0.015 U\r\n\r\n6. 超级索引拉新奖励介绍\r\n用邀请链接直推一个用户，获得 0.1 U 奖励。使用超级索引自带的分享功能“在此群组|频道分享功能”推广一个新用户获得 0.18 U，裂变一个用户获得 0.02 U\r\n\r\n7. 拉新搜索与裂变搜索收益\r\n直推用户一次有效搜索 0.0036 U，裂变用户的一次有效搜索 0.0009 U\r\n\r\n8. 为什么我的收益变少了？\r\n待入账金额3天内会进行一个系统考验期，在此期间系统会判断用户邀请的是否存在作弊或是假人，未通过考验期的金额将会被扣除，（举例：被邀用户只通过邀请链接使用了机器人，没有进行任何人为动作或搜索，则会被判定无效，收益扣除）\r\n\r\n9. 数据异常，收益被清空？\r\n拉新数据异常，拉新数据和收益减少了，说明某用户未通过考验期，收益被扣除。收益被清空，就是命中作弊，如果没有作弊，请联系管理员申诉。\r\n\r\n⚠️ 本系统严格执行的反作弊机制，邀请虚假用户或大量国外用户，将可能导致您的账户被拉黑。','','HTML',1,0,'[[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"invite\"\r\n    }\r\n  ]\r\n]','zh-cn',1747551048,1747551129,NULL),(51,'邀请排行','邀请排行','inrank','🏆 超级索引今日邀请排行榜 \r\n\r\n{list}\r\n\r\n  参与超级索引拉新活动，自动赚取收益！','','HTML',0,0,'[[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"invite\"\r\n    }\r\n  ]\r\n]','zh-cn',1747551439,1747551449,NULL),(52,'拉新数据','拉新数据','lachine','今日总共拉新 {daycount} 人\r\n\r\n总共拉新 {count} 人','','HTML',1,0,'[[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"invite\"\r\n    }\r\n  ]\r\n]','zh-cn',1747552777,1747552786,NULL),(53,'自定义充值金额','自定义充值金额','customamount','请回复您要充值的金额','','HTML',0,0,'','zh-cn',1747645649,1747645649,NULL),(54,'用户充值记录','用户充值记录','userlogs','您当前成功充值了 {amountcount} USDT,列表中只为您展示最新的5条充值成功的记录\r\n\r\n{amountlist}','','HTML',0,0,'[[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]','zh-cn',1747727691,1747728295,NULL),(55,'获取标签的群组','获取标签的群组','lable','[广告] {adv}\r\n\r\n{grouplist}','','HTML',1,0,'{\"notup\":\"💹 购买广告\",\"notuptype\":\"callback_data\",\"notuptypedata\":\"marke\",\"notnext\":\"{advtitle}\",\"notnexttype\":\"url\",\"nnotnextdata\":\"{advurl}\"}','zh-cn',1747730031,1747730691,NULL),(56,'收益排行榜','收益排行榜','income','💰 超级索引今日收益排行榜\r\n\r\n🥇 L*************呼 - 7.2154 U 💰\r\n🥈 林*玉 - 5.5902 U 💰\r\n🥉 旭* - 4.8992 U 💰\r\n🏅 𝑷***𝑲 - 3.7903 U 💰\r\n🏅 C*****a - 3.3878 U 💰\r\n🏅 h*****🌝 - 2.9812 U 💰\r\n🏅 阿* - 2.6824 U 💰\r\n🏅 o*********) - 2.4964 U 💰\r\n🏅 桃*************） - 1.9922 U 💰\r\n🏅 * - 1.957 U 💰\r\n🏅 刁* - 1.4932 U 💰\r\n🏅 ㅤ* - 1.0056 U 💰\r\n🏅 S*************Z - 0.8912 U 💰\r\n🏅 Y**g - 0.5932 U 💰\r\n🏅 吃* - 0.5824 U 💰\r\n🏅 旧******） - 0.4152 U 💰\r\n🏅 客* - 0.38 U 💰\r\n🏅 Y*****g - 0.3714 U 💰\r\n🏅 晨* - 0.36 U 💰\r\n🏅 M**n - 0.3270 U 💰\r\n\r\n参与分红人数：82 人\r\n发放收益总和：49.7637U','','HTML',0,0,'[[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"marke\"\r\n    }\r\n  ]\r\n]','zh-cn',1747731495,1747731495,NULL),(57,'设置群组','设置群组','setgroup','ID : {id}\r\nGID : {gid}\r\n群名称 : {groupname}\r\n用户名 : {groupusername}\r\n群人数 : {groupcount}\r\n群类型 : {grouptype}\r\n群状态 : {groupstatus}\r\n群标签 : {grouplable}\r\n群分类 : {groupcategory}\r\n群KD : {groupkd}\r\n群简介 : {groupcontent}\r\n添加时间 : {addtime}\r\n更新时间 : {updatetime}','','HTML',1,0,'','zh-cn',1747732966,1747733569,NULL);
/*!40000 ALTER TABLE `fa_buttons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_category`
--

DROP TABLE IF EXISTS `fa_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `type` varchar(30) DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) DEFAULT '',
  `nickname` varchar(50) DEFAULT '',
  `flag` set('hot','index','recommend') DEFAULT '',
  `image` varchar(100) DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) DEFAULT '' COMMENT '自定义名称',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `weigh` (`weigh`,`id`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_category`
--

LOCK TABLES `fa_category` WRITE;
/*!40000 ALTER TABLE `fa_category` DISABLE KEYS */;
INSERT INTO `fa_category` VALUES (1,0,'page','官方新闻','news','recommend','/assets/img/qrcode.png','','','news',1491635035,1491635035,1,'normal'),(2,0,'page','移动应用','mobileapp','hot','/assets/img/qrcode.png','','','mobileapp',1491635035,1491635035,2,'normal'),(3,2,'page','微信公众号','wechatpublic','index','/assets/img/qrcode.png','','','wechatpublic',1491635035,1491635035,3,'normal'),(4,2,'page','Android开发','android','recommend','/assets/img/qrcode.png','','','android',1491635035,1491635035,4,'normal'),(5,0,'page','软件产品','software','recommend','/assets/img/qrcode.png','','','software',1491635035,1491635035,5,'normal'),(6,5,'page','网站建站','website','recommend','/assets/img/qrcode.png','','','website',1491635035,1491635035,6,'normal'),(7,5,'page','企业管理软件','company','index','/assets/img/qrcode.png','','','company',1491635035,1491635035,7,'normal'),(8,6,'page','PC端','website-pc','recommend','/assets/img/qrcode.png','','','website-pc',1491635035,1491635035,8,'normal'),(9,6,'page','移动端','website-mobile','recommend','/assets/img/qrcode.png','','','website-mobile',1491635035,1491635035,9,'normal'),(10,7,'page','CRM系统 ','company-crm','recommend','/assets/img/qrcode.png','','','company-crm',1491635035,1491635035,10,'normal'),(11,7,'page','SASS平台软件','company-sass','recommend','/assets/img/qrcode.png','','','company-sass',1491635035,1491635035,11,'normal'),(12,0,'test','测试1','test1','recommend','/assets/img/qrcode.png','','','test1',1491635035,1491635035,12,'normal'),(13,0,'test','测试2','test2','recommend','/assets/img/qrcode.png','','','test2',1491635035,1491635035,13,'normal');
/*!40000 ALTER TABLE `fa_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_config`
--

DROP TABLE IF EXISTS `fa_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT '' COMMENT '变量名',
  `group` varchar(30) DEFAULT '' COMMENT '分组',
  `title` varchar(100) DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `visible` varchar(255) DEFAULT '' COMMENT '可见条件',
  `value` text COMMENT '变量值',
  `content` text COMMENT '变量字典数据',
  `rule` varchar(100) DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) DEFAULT '' COMMENT '扩展属性',
  `setting` varchar(255) DEFAULT '' COMMENT '配置',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_config`
--

LOCK TABLES `fa_config` WRITE;
/*!40000 ALTER TABLE `fa_config` DISABLE KEYS */;
INSERT INTO `fa_config` VALUES (1,'name','basic','Site name','请填写站点名称','string','','我的网站','','required','',''),(2,'beian','basic','Beian','粤ICP备15000000号-1','string','','','','','',''),(3,'cdnurl','basic','Cdn url','如果全站静态资源使用第三方云储存请配置该值','string','','','','','',''),(4,'version','basic','Version','如果静态资源有变动请重新配置该值','string','','1.0.3','','required','',''),(5,'timezone','basic','Timezone','','string','','Asia/Shanghai','','required','',''),(6,'forbiddenip','basic','Forbidden ip','一行一条记录','text','','','','','',''),(7,'languages','basic','Languages','','array','','{\"backend\":\"zh-cn\",\"frontend\":\"zh-cn\"}','','required','',''),(8,'fixedpage','basic','Fixed page','请输入左侧菜单栏存在的链接','string','','dashboard','','required','',''),(9,'categorytype','dictionary','Category type','','array','','{\"default\":\"默认\",\"page\":\"单页\",\"article\":\"文章\",\"test\":\"测试\"}','','','',NULL),(10,'configgroup','dictionary','Config group','','array','','{\"basic\":\"基础配置\",\"email\":\"邮件配置\",\"dictionary\":\"字典配置\",\"botset\":\"机器人设置\",\"meilisearchset\":\"meilisearch设置\",\"aiset\":\"ai设置\",\"groupset\":\"群组设置\",\"payset\":\"支付设置\",\"kefuset\":\"客服设置\",\"licenseset\":\"授权设置\"}','','','',NULL),(11,'mail_type','email','Mail type','选择邮件发送方式','select','','1','[\"请选择\",\"SMTP\"]','','',''),(12,'mail_smtp_host','email','Mail smtp host','错误的配置发送邮件会导致服务器超时','string','','smtp.qq.com','','','',''),(13,'mail_smtp_port','email','Mail smtp port','(不加密默认25,SSL默认465,TLS默认587)','string','','465','','','',''),(14,'mail_smtp_user','email','Mail smtp user','（填写完整用户名）','string','','','','','',''),(15,'mail_smtp_pass','email','Mail smtp password','（填写您的密码或授权码）','password','','','','','',''),(16,'mail_verify_type','email','Mail vertify type','（SMTP验证方式[推荐SSL]）','select','','2','[\"无\",\"TLS\",\"SSL\"]','','',''),(17,'mail_from','email','Mail from','','string','','','','','',''),(18,'attachmentcategory','dictionary','Attachment category','','array','','{\"category1\":\"分类一\",\"category2\":\"分类二\",\"custom\":\"自定义\"}','','','',NULL),(19,'bottoken','botset','bottoken','Robots_key','string','','7070944231:AAG4By-Y3wL38dIKQfwKMRZE3h3X8B190oA','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(20,'manticorehost','manticoreset','manticorehost','','string','','212.85.25.113','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(21,'manticoreport','manticoreset','manticoreport','','string','','9306','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(22,'isopenai','aiset','isopenai','','switch','','1','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(23,'meiliurl','meilisearchset','meiliurl','','string','','http://127.0.0.1:7700','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(24,'meili_key','meilisearchset','meili_keu','','string','','p1J6moK_39TDt4hzCQlS4iW4fDCQoYxzPC4WySrm_50','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(25,'openai_key','aiset','openai_key','','string','','sk-gTywYrbROyxAUaqo2cD91eEcCb2d4cC0924c570f73De639f','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(26,'cate_mode','aiset','cate_mode','','string','','text-davinci-003','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(27,'audit_mode','aiset','audit_mode','','string','','gpt-4','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(28,'language_ldentification_mode','aiset','language_ldentification_mode','','string','','gpt-4','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(29,'tokenpay_url','payset','tokenpay_url','','string','','https://tokenpay.8br.dpdns.org','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(30,'kefu_url','kefuset','kefu_url','','string','','http://crmchat.8br.dpdns.org/service/login/index.html','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(31,'kefu_username','kefuset','kefu_username','','string','','https://t.me/easSearchs','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(32,'default_lang','botset','default_lang','','selectpage','','zh-cn','','','','{\"table\":\"fa_lang\",\"primarykey\":\"tips\",\"field\":\"title\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(35,'partner','botset','partner','','number','','3000','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(36,'tokenpay_key','payset','tokenpay_key','','string','','666666','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(37,'order_expire','payset','order_expire','','number','','10','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(38,'deposit_methods','payset','deposit_methods','','select','','1','[\"order_amount\",\"payment_amount\"]','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(39,'pay_currency','payset','pay_currency','','text','','USDT_TRC20,TRX','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(40,'license_code','licenseset','license_code','','string','','CCAEE2C4-CDAE-834D-D78C-D37570CAAF87','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(41,'groups_audit','aiset','groups_audit','','select','','ai_artificial','{\"ai_audit\":\"ai_audit\",\"artificial_audit\":\"artificial_audit\",\"ai_artificial\":\"ai_artificial\"}','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(42,'default_kd','groupset','default_kd','','number','','5','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(44,'audit_method','groupset','audit_method','','select','','direct_review','{\"direct_review\":\"direct_review\",\"rueue_review\":\"rueue_review\"}','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(45,'private_delete','botset','private_delete','','text','','edit_message','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(46,'select_icon','botset','select_icon','','string','','✅','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(47,'customer_time','kefuset','customer_time','','number','','60','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(48,'customer_hook','kefuset','customer_hook','','string','','http://crmchat.8br.dpdns.org/','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(49,'fastgpt_url','aiset','fastgpt_url','','string','','https://api.fastgpt.in','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(50,'fastgpt_datasetId','aiset','fastgpt_datasetId','','string','','68245cf44d030c8e71cc8e29','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(51,'fastgpt_key','aiset','fastgpt_key','','string','','fastgpt-j1G1LP93AUNyg6tfouwJuBeggLkT4cxlZ7MzoQLNGpKoXuSQWv35','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(52,'fastgpt_appid','aiset','fastgpt_appid','','string','','68245db852558308d8abc8c0','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(53,'RabbitMQ_host','RabbitMQset','RabbitMQ_host','','string','','212.85.25.113','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(54,'RabbitMQ_port','RabbitMQset','RabbitMQ_port','','number','','5672','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(55,'RabbitMQ_user','RabbitMQset','RabbitMQ_user','','string','','admin','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(56,'RabbitMQ_password','RabbitMQset','RabbitMQ_password','','string','','D77L6mcEyDqtMWqx','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(57,'RabbitMQ_vhost','RabbitMQset','RabbitMQ_vhost','','string','','bthost','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(58,'telegramIcon','botset','telegramIcon','','text','','{\"all\":\"#⃣\",\"shop\":\"🏪\",\"supergroup\":\"👥\",\"channel\":\"📢\",\"photo\":\"🖼️\",\"video\":\"🎬\",\"music\":\"🎵\",\"document\":\"📄\",\"link\":\"🔗\",\"bot\":\"🤖\",\"group\":\"👥\"}','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(59,'prohibited_words','botset','prohibited_words','','text','','测试','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(60,'advkey_count','botset','advkey_count','','number','','5','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(61,'default_keyadv_amount','botset','default_keyadv_amount','','number','','100','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(62,'get_group_info','botset','get_group_info','','string','','http://127.0.0.1:5000/api/entity?username=','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(63,'invitereward','botset','invitereward','','string','','{\"textbox\":0.18,\"dirpush\":0.1,\"onedirpush\":0.02,\"opensearch\":0.03,\"onesearch\":0.0036,\"twosearch\":0.0009}','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(64,'embody','groupset','embody','','select','','bot','{\"client\":\"client\",\"bot\":\"bot\"}','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}'),(65,'business_id','kefuset','business_id','','number','','1','','','','{\"table\":\"\",\"conditions\":\"\",\"key\":\"\",\"value\":\"\"}');
/*!40000 ALTER TABLE `fa_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_crontab`
--

DROP TABLE IF EXISTS `fa_crontab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_crontab` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(10) NOT NULL DEFAULT '' COMMENT '事件类型',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '事件标题',
  `content` text NOT NULL COMMENT '事件内容',
  `schedule` varchar(100) NOT NULL DEFAULT '' COMMENT 'Crontab格式',
  `sleep` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '延迟秒数执行',
  `maximums` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大执行次数 0为不限',
  `executes` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已经执行的次数',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `begintime` bigint(16) DEFAULT NULL COMMENT '开始时间',
  `endtime` bigint(16) DEFAULT NULL COMMENT '结束时间',
  `executetime` bigint(16) DEFAULT NULL COMMENT '最后执行时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` enum('completed','expired','hidden','normal') NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_crontab`
--

LOCK TABLES `fa_crontab` WRITE;
/*!40000 ALTER TABLE `fa_crontab` DISABLE KEYS */;
INSERT INTO `fa_crontab` VALUES (1,'url','请求百度','https://www.baidu.com','* * * * *',0,0,0,1497070825,1501253101,1483200000,1830268800,1501253101,1,'normal'),(2,'sql','查询一条SQL','SELECT 1;','* * * * *',0,0,0,1497071095,1501253101,1483200000,1830268800,1501253101,2,'normal');
/*!40000 ALTER TABLE `fa_crontab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_crontab_log`
--

DROP TABLE IF EXISTS `fa_crontab_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_crontab_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `crontab_id` int(10) DEFAULT NULL COMMENT '任务ID',
  `executetime` bigint(16) DEFAULT NULL COMMENT '执行时间',
  `completetime` bigint(16) DEFAULT NULL COMMENT '结束时间',
  `content` text COMMENT '执行结果',
  `processid` int(10) DEFAULT '0' COMMENT '进程ID',
  `status` enum('success','failure','inprogress') DEFAULT 'failure' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `crontab_id` (`crontab_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务日志表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_crontab_log`
--

LOCK TABLES `fa_crontab_log` WRITE;
/*!40000 ALTER TABLE `fa_crontab_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_crontab_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_ems`
--

DROP TABLE IF EXISTS `fa_ems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_ems` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) DEFAULT '' COMMENT '事件',
  `email` varchar(100) DEFAULT '' COMMENT '邮箱',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='邮箱验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_ems`
--

LOCK TABLES `fa_ems` WRITE;
/*!40000 ALTER TABLE `fa_ems` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_ems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_goods`
--

DROP TABLE IF EXISTS `fa_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '所属用户id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品标题',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品内容',
  `prices` float(11,4) NOT NULL DEFAULT '0.0000' COMMENT '商品价格',
  `files` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件组',
  `kefu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客服信息',
  `status` enum('-2','-1','0','1','2','3') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=黑名单,-1=禁止展示,0=审核中,1=审核成功,2=待展示,3=展示中',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_goods`
--

LOCK TABLES `fa_goods` WRITE;
/*!40000 ALTER TABLE `fa_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_goodsc`
--

DROP TABLE IF EXISTS `fa_goodsc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_goodsc` (
  `id` int(11) NOT NULL,
  `goods_class` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品分类名',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_goodsc`
--

LOCK TABLES `fa_goodsc` WRITE;
/*!40000 ALTER TABLE `fa_goodsc` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_goodsc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_greport`
--

DROP TABLE IF EXISTS `fa_greport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_greport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报类型标题',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品举报类型';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_greport`
--

LOCK TABLES `fa_greport` WRITE;
/*!40000 ALTER TABLE `fa_greport` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_greport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_greports`
--

DROP TABLE IF EXISTS `fa_greports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_greports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `goodsid` int(11) NOT NULL COMMENT '商品id',
  `greportid` int(11) NOT NULL COMMENT '投诉类型',
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '投诉内容',
  `files` text COLLATE utf8mb4_unicode_ci COMMENT '证据文件',
  `status` enum('-2','-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=该商品已经是黑名单,-1=驳回,0=待审核,1=审核成功',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='商品举报列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_greports`
--

LOCK TABLES `fa_greports` WRITE;
/*!40000 ALTER TABLE `fa_greports` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_greports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_groupcate`
--

DROP TABLE IF EXISTS `fa_groupcate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_groupcate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='群组分类';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_groupcate`
--

LOCK TABLES `fa_groupcate` WRITE;
/*!40000 ALTER TABLE `fa_groupcate` DISABLE KEYS */;
INSERT INTO `fa_groupcate` VALUES (1,'👥 社区','zh-cn','1746871670'),(2,'🗣 闲聊','zh-cn','1746871704'),(3,'🏣 同城','zh-cn','1746871765'),(4,'📡 新闻','zh-cn','1746871874'),(5,'👻 其他','zh-cn','1747729172');
/*!40000 ALTER TABLE `fa_groupcate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_keyword`
--

DROP TABLE IF EXISTS `fa_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关键词',
  `searchcount` int(11) NOT NULL DEFAULT '0' COMMENT '被搜索次数',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='关键词列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_keyword`
--

LOCK TABLES `fa_keyword` WRITE;
/*!40000 ALTER TABLE `fa_keyword` DISABLE KEYS */;
INSERT INTO `fa_keyword` VALUES (1,'矩阵',0,'zh-cn','1747417951','1747417951'),(2,'美女',0,'zh-cn','1747466667','1747466667');
/*!40000 ALTER TABLE `fa_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_lable`
--

DROP TABLE IF EXISTS `fa_lable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_lable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标签值',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标签所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='标签';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_lable`
--

LOCK TABLES `fa_lable` WRITE;
/*!40000 ALTER TABLE `fa_lable` DISABLE KEYS */;
INSERT INTO `fa_lable` VALUES (2,'这是',NULL,'1747151701'),(3,'一个',NULL,'1747151701'),(4,'测试',NULL,'1747151701'),(5,'群组',NULL,'1747151701'),(6,'数据',NULL,'1747151701'),(7,'第五',NULL,'1748506821'),(8,'版本',NULL,'1748506821'),(9,'搜索',NULL,'1748506821');
/*!40000 ALTER TABLE `fa_lable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_lang`
--

DROP TABLE IF EXISTS `fa_lang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_lang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言标题',
  `icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `country` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '国家',
  `tips` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言代码',
  `lenght` int(5) NOT NULL DEFAULT '6' COMMENT '搜索允许最大的长度',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='语言管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_lang`
--

LOCK TABLES `fa_lang` WRITE;
/*!40000 ALTER TABLE `fa_lang` DISABLE KEYS */;
INSERT INTO `fa_lang` VALUES (1,'简体中文','🇨🇳','中国','zh-cn',6,'1746878084'),(2,'English','🇭🇲',NULL,'en',6,'1746881570');
/*!40000 ALTER TABLE `fa_lang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_receivpayments`
--

DROP TABLE IF EXISTS `fa_receivpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_receivpayments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `address` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收款地址',
  `network` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '网络',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款图片',
  `status` enum('-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '状态:-1=黑名单,0=禁用,1=启用',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '添加时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='提现地址列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_receivpayments`
--

LOCK TABLES `fa_receivpayments` WRITE;
/*!40000 ALTER TABLE `fa_receivpayments` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_receivpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_recharge`
--

DROP TABLE IF EXISTS `fa_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '平台订单号',
  `ordersn` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '第三方订单号',
  `user_id` int(11) NOT NULL COMMENT '下单者用户id',
  `amount` float(11,4) NOT NULL DEFAULT '0.0000' COMMENT '下单金额',
  `money` float(11,4) DEFAULT NULL COMMENT '需要支付的金额',
  `basecurrency` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付的货币',
  `addressqr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址二维码信息',
  `toaddress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收款地址',
  `rate` float(11,5) DEFAULT '1.00000' COMMENT '汇率',
  `currency` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '加密货币币种',
  `pass_through_info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '自定义字符串',
  `sign` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单签名信息',
  `status` enum('-2','-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=异常,-1=已取消,0=待支付,1=已支付',
  `block` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付成功区块',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `paytime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='充值列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_recharge`
--

LOCK TABLES `fa_recharge` WRITE;
/*!40000 ALTER TABLE `fa_recharge` DISABLE KEYS */;
INSERT INTO `fa_recharge` VALUES (1,'683852d38631c','683852d7-6d9a-d58c-00bf-390d171ce325',1,5.0000,4.9910,'USD','https://tokenpay.8br.dpdns.org/GetQrCode?Id=683852d7-6d9a-d58c-00bf-390d171ce325','THPFdxnzvji6jezBsk3pj99RXPHF9puSui',1.00000,'USDT_TRON','','60890f9e07e8771490bed6983d39af33','-1',NULL,'1748521687',NULL);
/*!40000 ALTER TABLE `fa_recharge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_report`
--

DROP TABLE IF EXISTS `fa_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报类型',
  `title` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报类型标题',
  `lang` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '所属语言',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='举报类型列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_report`
--

LOCK TABLES `fa_report` WRITE;
/*!40000 ALTER TABLE `fa_report` DISABLE KEYS */;
INSERT INTO `fa_report` VALUES (1,'👩','pornography','涉及色情','zh-cn','1747121500','1747345929'),(2,'💀','poison','涉及毒品','zh-cn','1747345985','1747345985'),(3,'😱','violence','涉及暴力','zh-cn','1747346064','1747346064');
/*!40000 ALTER TABLE `fa_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_reports`
--

DROP TABLE IF EXISTS `fa_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(255) NOT NULL COMMENT '举报类型id',
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报说明',
  `files` text COLLATE utf8mb4_unicode_ci COMMENT '上传的证据',
  `user_id` int(11) NOT NULL COMMENT '举报者信息',
  `groups_id` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '举报的群组id',
  `status` enum('-2','-1','0','1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=该群组已是黑名单,-1=驳回,0=审核中,1=审核成功',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '驳回理由',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '创建时间',
  `updatetime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='举报列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_reports`
--

LOCK TABLES `fa_reports` WRITE;
/*!40000 ALTER TABLE `fa_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_sms`
--

DROP TABLE IF EXISTS `fa_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `event` varchar(30) DEFAULT '' COMMENT '事件',
  `mobile` varchar(20) DEFAULT '' COMMENT '手机号',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  `times` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证次数',
  `ip` varchar(30) DEFAULT '' COMMENT 'IP',
  `createtime` bigint(16) unsigned DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='短信验证码表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_sms`
--

LOCK TABLES `fa_sms` WRITE;
/*!40000 ALTER TABLE `fa_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_test`
--

DROP TABLE IF EXISTS `fa_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_test` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) DEFAULT '0' COMMENT '会员ID',
  `admin_id` int(10) DEFAULT '0' COMMENT '管理员ID',
  `category_id` int(10) unsigned DEFAULT '0' COMMENT '分类ID(单选)',
  `category_ids` varchar(100) DEFAULT NULL COMMENT '分类ID(多选)',
  `tags` varchar(255) DEFAULT '' COMMENT '标签',
  `week` enum('monday','tuesday','wednesday') DEFAULT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') DEFAULT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(100) DEFAULT '' COMMENT '标题',
  `content` text COMMENT '内容',
  `image` varchar(100) DEFAULT '' COMMENT '图片',
  `images` varchar(1500) DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) DEFAULT '' COMMENT '附件',
  `keywords` varchar(255) DEFAULT '' COMMENT '关键字',
  `description` varchar(255) DEFAULT '' COMMENT '描述',
  `city` varchar(100) DEFAULT '' COMMENT '省市',
  `array` varchar(255) DEFAULT '' COMMENT '数组:value=值',
  `json` varchar(255) DEFAULT '' COMMENT '配置:key=名称,value=值',
  `multiplejson` varchar(1500) DEFAULT '' COMMENT '二维数组:title=标题,intro=介绍,author=作者,age=年龄',
  `price` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '价格',
  `views` int(10) unsigned DEFAULT '0' COMMENT '点击',
  `workrange` varchar(100) DEFAULT '' COMMENT '时间区间',
  `startdate` date DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year(4) DEFAULT NULL COMMENT '年',
  `times` time DEFAULT NULL COMMENT '时间',
  `refreshtime` bigint(16) DEFAULT NULL COMMENT '刷新时间',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `deletetime` bigint(16) DEFAULT NULL COMMENT '删除时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `switch` tinyint(1) DEFAULT '0' COMMENT '开关',
  `status` enum('normal','hidden') DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='测试表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_test`
--

LOCK TABLES `fa_test` WRITE;
/*!40000 ALTER TABLE `fa_test` DISABLE KEYS */;
INSERT INTO `fa_test` VALUES (1,1,1,12,'12,13','互联网,计算机','monday','hot,index','male','music,reading','我是一篇测试文章','<p>我是测试内容</p>','/assets/img/avatar.png','/assets/img/avatar.png,/assets/img/qrcode.png','/assets/img/avatar.png','关键字','我是一篇测试文章描述，内容过多时将自动隐藏','广西壮族自治区/百色市/平果县','[\"a\",\"b\"]','{\"a\":\"1\",\"b\":\"2\"}','[{\"title\":\"标题一\",\"intro\":\"介绍一\",\"author\":\"小明\",\"age\":\"21\"}]',0.00,0,'2020-10-01 00:00:00 - 2021-10-31 23:59:59','2017-07-10','2017-07-10 18:24:45',2017,'18:24:45',1491635035,1491635035,1491635035,NULL,0,1,'normal','1');
/*!40000 ALTER TABLE `fa_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_tg_user`
--

DROP TABLE IF EXISTS `fa_tg_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_tg_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `tid` varchar(64) NOT NULL DEFAULT '' COMMENT 'TG用户ID',
  `tusername` varchar(64) NOT NULL DEFAULT '' COMMENT 'TG用户名',
  `tnick` varchar(64) NOT NULL DEFAULT '' COMMENT 'TG昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账户余额',
  `frozen_balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '冻结余额',
  `deposit` float(11,4) DEFAULT '0.0000' COMMENT '押金',
  `lang` varchar(10) NOT NULL DEFAULT 'en' COMMENT '用户语言',
  `parent_id` int(11) DEFAULT NULL COMMENT '上级用户ID',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态 -1=黑名单 0=禁用 1=正常 2=投资方',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `delete_time` int(10) NOT NULL DEFAULT '0' COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `tid` (`tid`) USING BTREE,
  KEY `parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='TG用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_tg_user`
--

LOCK TABLES `fa_tg_user` WRITE;
/*!40000 ALTER TABLE `fa_tg_user` DISABLE KEYS */;
INSERT INTO `fa_tg_user` VALUES (1,'6575617620','easSearchs','Cade Steph','',50.00,0.00,0.0000,'zh-cn',NULL,1,1748521614,1748782412,0),(2,'5417942127','cw8999','黑猫大队 专注曝光 灰产交流 ','',0.00,0.00,0.0000,'ru',NULL,1,1748771512,1748776749,0);
/*!40000 ALTER TABLE `fa_tg_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_tips`
--

DROP TABLE IF EXISTS `fa_tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_keyword` (`keyword`) USING BTREE,
  KEY `idx_lang` (`lang`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='Telegram语言包提示表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_tips`
--

LOCK TABLES `fa_tips` WRITE;
/*!40000 ALTER TABLE `fa_tips` DISABLE KEYS */;
INSERT INTO `fa_tips` VALUES (1,'用户操作黑名单提示','actionblack','您已被加入黑名单，请先联系客服说明情况解封 管理员@buzhiguiqi','zh-cn',0,'[\r\n   [\r\n      {\"text\":\"联系客服\",\"url\":\"https://t.me/buzhiguiqi\"}\r\n   ]\r\n]',1746778314,1747052337,NULL),(2,'用户操作禁用提示','actiondisable','您的账号已经被禁用了，请联系管理员进行解封 管理员:@buzhiguiqi','zh-cn',0,'',1746778897,1747052330,NULL),(3,'订单过期说明','orderexpire','订单号:{orderid}\r\n下单金额:{amount}\r\n支付金额:{money}\r\n支付方式:{currency}\r\n\r\n已取消,需要充值请重新下单','zh-cn',0,'',1747052322,1747052322,NULL),(4,'管理员手动添加','admin_add','管理员已手动给您添加了余额\r\n\r\n添加金额:{amount} USDT\r\n\r\n账户余额:{balance} USDT','zh-cn',0,'',1747147583,1747147583,NULL),(5,'管理员手动减少余额','admin_reduce','管理员已手动给您减少了余额\r\n\r\n减少金额:{amount} USDT\r\n\r\n账户余额:{balance} USDT','zh-cn',0,'',1747147896,1747147896,NULL),(6,'管理员手动冻结余额','admin_freeze','管理员已手动给您冻结了余额\r\n\r\n冻结金额:{amount} USDT\r\n\r\n账户余额:{balance} USDT','zh-cn',0,'',1747147953,1747147975,NULL),(7,'管理员手动解冻','admin_unfreeze','管理员已手动给您解冻了余额\r\n\r\n解冻金额:{amount} USDT\r\n\r\n账户余额:{balance} USDT','zh-cn',0,'',1747148026,1747148046,NULL),(8,'管理员手动清空冻结余额','admin_clear_frozen','清空冻结余额操作\r\n\r\n被清空的金额: {amount} USDT','zh-cn',0,'',1747148085,1747148144,NULL),(9,'管理员手动修改状态','admin_chang_status','管理员手动修改了您的状态\r\n\r\n修改前状态:{before_status}\r\n\r\n修改后状态:{after_status}','zh-cn',0,'',1747148221,1747148427,NULL),(10,'进入客服系统','enterkefu','您已进入客服系统 1 小时\r\n您发的消息机器人不会回应你\r\n发送 `/quit` 即可退出客服系统','zh-cn',0,'',1747209841,1747210253,NULL),(11,'退出客服系统','quitkefu','您已退出输入系统,尽情的搜索吧','zh-cn',0,'',1747210477,1747484852,NULL),(12,'AI客服','enteraikefu','您已进入AI客服\r\n发送问题给机器人AI将自动回复您\r\n发送 `/quit` 退出AI客服','zh-cn',0,'',1747213168,1747213168,NULL),(13,'提问回答问题后面的尾巴','answer_tail','\r\n退出客服请发送 `/quit`','zh-cn',0,'',1747217298,1747217298,NULL),(14,'点赞无数据提示','like ','您当前没有点赞的数据哦','zh-cn',0,'',1747236008,1747236008,NULL),(15,'没有找到频道列表','channel_not_found','没有频道列表','zh-cn',0,'',1747312151,1747312327,NULL),(16,'不存在广告','not_found_adv','没有可展示的广告','zh-cn',0,'',1747313920,1747313920,NULL),(17,'下一页','nextpage','🔜 下一页','zh-cn',0,'',1747316512,1747316512,NULL),(18,'上一页','uppage','🔙 上一页','zh-cn',0,'',1747316534,1747316534,NULL),(19,'没有找到按钮广告','not_search_adv','{\"text\":\"没有找到广告\",\"url\":\"https://t.me/easSearchs\"}','zh-cn',0,'',1747316815,1748687734,NULL),(20,'频道页面返回按钮','channel_return','{\"text\":\"🔙 返回\",\"callback_data\":\"start\"}','zh-cn',0,'',1747318622,1747318656,NULL),(21,'群组没找到','supergroup_not_found','没有群组列表','zh-cn',0,'',1747319010,1747319051,NULL),(22,'群组频道机器人用户点赞点过了提示','like_and_hit_message','您已经操作过了哟','zh-cn',0,'',1747328494,1747328494,NULL),(23,'举报返回提示语','proof','请回复要举报的内容以及截图证明文件,没有截图证明文件则不用上传,我们会进行审核。请耐心等待，举报成功机器人会通知回复您','zh-cn',0,'',1747346968,1747346968,NULL),(24,'证据提交成功提示','proof_success','已收到您的举报,感谢您为我们做出的贡献。','zh-cn',0,'',1747348847,1747348847,NULL),(25,'没有找到搜索的内容','not_found_search_key','没有找到您搜索的内容，建议换衣关键词试一试','zh-cn',0,'',1747397748,1747397748,NULL),(26,'更新说明','update','正在为您更新中...','zh-cn',0,'',1747413238,1747413238,NULL),(27,'出价不对提示','buykeyword_balance_error','您出的价格不对或价格不能低于最低出价\r\n\r\n请重新出价。\r\n\r\n输入 `/quit` 退出输入','zh-cn',0,'',1747465646,1747465646,NULL),(28,'出价成功提示','buykeyword_balance_success','当前关键词【{keyword}】\r\n\r\n您的出价为 {amount} USDT\r\n\r\n已成功出价，请发送 `/hotkey {keyword}` 查看出价情况','zh-cn',0,'',1747466081,1747466081,NULL),(29,'没有找到我的链接','not_found_mylink','😢 没有链接','zh-cn',0,'',1747474062,1747474062,NULL),(30,'没有找到机器人数据','not_bots_data','😢 没有机器人数据哦','zh-cn',0,'',1747475252,1747475270,NULL),(31,'没有广告','notadvman','😢 没有广告','zh-cn',0,'',1747476324,1747476324,NULL),(32,'有广告说明','hasadvman','您总共有{count}条广告','zh-cn',0,'',1747476841,1747476841,NULL),(33,'支付广告时余额不足','payadv_balance_error','您的余额不足，无法购买广告','zh-cn',0,'',1747478928,1747478928,NULL),(34,'广告状态禁止投放','advStatus','{\"-1\":\"广告被禁止投放,该广告禁止提交审核\",\"-2\":\"广告正在处于审核中,无需再次提交审核\",\"1\":\"广告处于待投放中,无需提交审核\",\"2\":\"广告处于投放中,无需提交审核\"}','zh-cn',0,'',1747481781,1747481951,NULL),(35,'已成功提交审核','submit_audit_success','提交审核成功,请耐心等待管理员审核,如果需要加急请联系客服','zh-cn',0,'',1747482278,1747482278,NULL),(36,'广告开始投放','submit_start_put_error','{\"-1\":\"广告被禁止投放\",\"-2\":\"广告正在处于审核中,无法投放\",\"0\":\"广告处于待提交状态,无发投放\",\"2\":\"广告处于投放中,无需提交投放\"}','zh-cn',0,'',1747482457,1747482515,NULL),(37,'广告投放成功','submit_start_put_success','广告投放成功','zh-cn',0,'',1747482596,1747482596,NULL),(38,'广告停止投放错误','submit_stop_put_error','{\"-1\":\"此广告被禁止投放,无法修改其状态\",\"-2\":\"广告正在处于审核中,无法设置停止投放\",\"0\":\"广告处于待提交状态,无法设置停止投放\",\"1\":\"广告已处于停止投放状态,无需提交\"}','zh-cn',0,'',1747482700,1747482775,NULL),(39,'广告停止投放成功','submit_stop_put_success','广告停止投放成功','zh-cn',0,'',1747482819,1747482819,NULL),(40,'设置广告的标题','set_adv_title','请发送广告标题\r\n\r\n发送  `/quit` 退出输入','zh-cn',0,'',1747484621,1747484621,NULL),(41,'设置广告的url','set_adv_url','请发送广告的链接 以 https://t.me/ 开头,或者直接发送用户名 @ 开头即可\r\n\r\n发送 `/quit` 表示退出输入','zh-cn',0,'',1747484690,1747484690,NULL),(42,'修改广告状态不允许','edit_adv_erro','您当前的广告状态处于禁止，无法修改广告哦','zh-cn',0,'',1747485376,1747485376,NULL),(43,'设置广告成功','set_adv_info','广告设置成功','zh-cn',0,'',1747485513,1747485513,NULL),(44,'提交的链接有问题','submit_url_error','您提交的链接有问题，请重新提交\r\n发送 `/quit` 退出输入系统','zh-cn',0,'',1747485866,1747485866,NULL),(45,'返回广告','return_adv','  [\r\n    [{\r\n      \"text\": \"🔙返回广告设置\",\r\n      \"callback_data\": \"setadv_{id}\"\r\n    }\r\n  ]\r\n]\r\n','zh-cn',0,'',1747486750,1747486789,NULL),(46,'查看广告数据的提示','see_adv_data_success','查看广告数据已进入队列，稍后会以Excel表格的方式发送给你','zh-cn',0,'',1747487324,1747487324,NULL),(47,'关键词广告不属于你的提示','not_yours_keyword_adv','这个关键词广告不属于你哦，你无法修改哦','zh-cn',0,'',1747494368,1747494405,NULL),(48,'今日数据为空','inrank_today_null','今日数据为空','zh-cn',0,'',1747552509,1747552509,NULL),(49,'返回分类列表','return_class','[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"lablelist\"\r\n    }\r\n  ]','zh-cn',0,'',1747730503,1747730670,NULL),(50,'返回我的链接','return_mylink','[{\r\n      \"text\": \"🔙返回\",\r\n      \"callback_data\": \"mylink\"\r\n    }\r\n  ]\r\n','zh-cn',0,'',1747735364,1747735406,NULL),(51,'修改搜索自定义关键词提示','issearch','请输入搜索词的前缀,比如回复[q]那么用户必须输入[q测试]或者[q 测试]才能搜索[测试]关键词','zh-cn',0,'',1747737362,1747737362,NULL),(52,'欢迎进群的提示','iswelcome','请输入欢迎进群的提示(可以回车换行):','zh-cn',0,'',1747737407,1747737407,NULL),(53,'修改标签','editlable','请输入标签,多个标签以小写的[,]隔开，最多允许5个标签,回复多了将抛弃后面的标签内容,该标签决定了您的群组KD值,影响到排名','zh-cn',0,'',1747737505,1747737780,NULL),(54,'加款','addbalance','该功能只有演示站才会可以\r\n\r\n发送 `/addbalance 100` 代表增加100余额\r\n\r\n回复 success 代表成功','zh-cn',0,'',1748511659,1748511676,NULL),(55,'续费时余额不足提示 ','renewal_error','您当前余额不足，请先充值后再来续费','zh-cn',0,'',1748693552,1748693552,NULL),(56,'续费成功提示','renewal_success','续费成功','zh-cn',0,'',1748693601,1748693601,NULL),(57,'链接客服系统失败','connect_kefu_system_error','链接客服系统失败，已为您退出客服系统','zh-cn',0,'',1748781903,1748781903,NULL),(58,'AI客服出错了','ai_kefu_error','FastGTP配置错误，请在后台更新配置，已为您退出客服系统','zh-cn',0,'',1748782236,1748782305,NULL);
/*!40000 ALTER TABLE `fa_tips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user`
--

DROP TABLE IF EXISTS `fa_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组别ID',
  `username` varchar(32) DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) DEFAULT '' COMMENT '昵称',
  `password` varchar(32) DEFAULT '' COMMENT '密码',
  `salt` varchar(30) DEFAULT '' COMMENT '密码盐',
  `email` varchar(100) DEFAULT '' COMMENT '电子邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号',
  `avatar` varchar(255) DEFAULT '' COMMENT '头像',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '等级',
  `gender` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `bio` varchar(100) DEFAULT '' COMMENT '格言',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '余额',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '积分',
  `successions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '连续登录天数',
  `maxsuccessions` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '最大连续登录天数',
  `prevtime` bigint(16) DEFAULT NULL COMMENT '上次登录时间',
  `logintime` bigint(16) DEFAULT NULL COMMENT '登录时间',
  `loginip` varchar(50) DEFAULT '' COMMENT '登录IP',
  `loginfailure` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '失败次数',
  `loginfailuretime` bigint(16) DEFAULT NULL COMMENT '最后登录失败时间',
  `joinip` varchar(50) DEFAULT '' COMMENT '加入IP',
  `jointime` bigint(16) DEFAULT NULL COMMENT '加入时间',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `token` varchar(50) DEFAULT '' COMMENT 'Token',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  `verification` varchar(255) DEFAULT '' COMMENT '验证',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `username` (`username`) USING BTREE,
  KEY `email` (`email`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user`
--

LOCK TABLES `fa_user` WRITE;
/*!40000 ALTER TABLE `fa_user` DISABLE KEYS */;
INSERT INTO `fa_user` VALUES (1,1,'admin','admin','970895ea8bd948f80fd6f27a6e2cfe21','1705ac','admin@163.com','13000000000','/assets/img/avatar.png',0,0,'2017-04-08','',0.00,0,1,1,1491635035,1491635035,'127.0.0.1',0,1491635035,'127.0.0.1',1491635035,0,1491635035,'','normal','');
/*!40000 ALTER TABLE `fa_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_group`
--

DROP TABLE IF EXISTS `fa_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT '' COMMENT '组名',
  `rules` text COMMENT '权限节点',
  `createtime` bigint(16) DEFAULT NULL COMMENT '添加时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员组表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_group`
--

LOCK TABLES `fa_user_group` WRITE;
/*!40000 ALTER TABLE `fa_user_group` DISABLE KEYS */;
INSERT INTO `fa_user_group` VALUES (1,'默认组','1,2,3,4,5,6,7,8,9,10,11,12',1491635035,1491635035,'normal');
/*!40000 ALTER TABLE `fa_user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_money_log`
--

DROP TABLE IF EXISTS `fa_user_money_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_money_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更余额',
  `before` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更前余额',
  `after` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变更后余额',
  `memo` varchar(255) DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员余额变动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_money_log`
--

LOCK TABLES `fa_user_money_log` WRITE;
/*!40000 ALTER TABLE `fa_user_money_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_money_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_rule`
--

DROP TABLE IF EXISTS `fa_user_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `title` varchar(50) DEFAULT '' COMMENT '标题',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `ismenu` tinyint(1) DEFAULT NULL COMMENT '是否菜单',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) DEFAULT '0' COMMENT '权重',
  `status` enum('normal','hidden') DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员规则表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_rule`
--

LOCK TABLES `fa_user_rule` WRITE;
/*!40000 ALTER TABLE `fa_user_rule` DISABLE KEYS */;
INSERT INTO `fa_user_rule` VALUES (1,0,'index','Frontend','',1,1491635035,1491635035,1,'normal'),(2,0,'api','API Interface','',1,1491635035,1491635035,2,'normal'),(3,1,'user','User Module','',1,1491635035,1491635035,12,'normal'),(4,2,'user','User Module','',1,1491635035,1491635035,11,'normal'),(5,3,'index/user/login','Login','',0,1491635035,1491635035,5,'normal'),(6,3,'index/user/register','Register','',0,1491635035,1491635035,7,'normal'),(7,3,'index/user/index','User Center','',0,1491635035,1491635035,9,'normal'),(8,3,'index/user/profile','Profile','',0,1491635035,1491635035,4,'normal'),(9,4,'api/user/login','Login','',0,1491635035,1491635035,6,'normal'),(10,4,'api/user/register','Register','',0,1491635035,1491635035,8,'normal'),(11,4,'api/user/index','User Center','',0,1491635035,1491635035,10,'normal'),(12,4,'api/user/profile','Profile','',0,1491635035,1491635035,3,'normal');
/*!40000 ALTER TABLE `fa_user_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_score_log`
--

DROP TABLE IF EXISTS `fa_user_score_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_score_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `score` int(10) NOT NULL DEFAULT '0' COMMENT '变更积分',
  `before` int(10) NOT NULL DEFAULT '0' COMMENT '变更前积分',
  `after` int(10) NOT NULL DEFAULT '0' COMMENT '变更后积分',
  `memo` varchar(255) DEFAULT '' COMMENT '备注',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员积分变动表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_score_log`
--

LOCK TABLES `fa_user_score_log` WRITE;
/*!40000 ALTER TABLE `fa_user_score_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_score_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_user_token`
--

DROP TABLE IF EXISTS `fa_user_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_user_token` (
  `token` varchar(50) NOT NULL COMMENT 'Token',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `expiretime` bigint(16) DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='会员Token表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_user_token`
--

LOCK TABLES `fa_user_token` WRITE;
/*!40000 ALTER TABLE `fa_user_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_user_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_version`
--

DROP TABLE IF EXISTS `fa_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `oldversion` varchar(30) DEFAULT '' COMMENT '旧版本号',
  `newversion` varchar(30) DEFAULT '' COMMENT '新版本号',
  `packagesize` varchar(30) DEFAULT '' COMMENT '包大小',
  `content` varchar(500) DEFAULT '' COMMENT '升级内容',
  `downloadurl` varchar(255) DEFAULT '' COMMENT '下载地址',
  `enforce` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '强制更新',
  `createtime` bigint(16) DEFAULT NULL COMMENT '创建时间',
  `updatetime` bigint(16) DEFAULT NULL COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `status` varchar(30) DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='版本表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_version`
--

LOCK TABLES `fa_version` WRITE;
/*!40000 ALTER TABLE `fa_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fa_withdraw`
--

DROP TABLE IF EXISTS `fa_withdraw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fa_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `withorder` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '提现订单号',
  `amount` float(11,4) NOT NULL COMMENT '提现金额',
  `paymentid` int(11) NOT NULL COMMENT '地址ID',
  `status` enum('-2','-1','0','1','2') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '状态:-2=黑名单,-1=驳回,0=待审核,1=审核成功待打款,2=已打款',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '驳回理由',
  `block` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '打款成功区块',
  `createtime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建时间',
  `paytime` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '打款时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='提现列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fa_withdraw`
--

LOCK TABLES `fa_withdraw` WRITE;
/*!40000 ALTER TABLE `fa_withdraw` DISABLE KEYS */;
/*!40000 ALTER TABLE `fa_withdraw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'copy_8br_dpdns_o'
--

--
-- Dumping routines for database 'copy_8br_dpdns_o'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-01 12:54:19
