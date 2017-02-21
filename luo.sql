/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50633
Source Host           : 127.0.0.1:33060
Source Database       : luo

Target Server Type    : MYSQL
Target Server Version : 50633
File Encoding         : 65001

Date: 2017-02-20 08:42:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` tinyint(4) NOT NULL,
  `username` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(120) NOT NULL DEFAULT '',
  `created` int(11) NOT NULL COMMENT '添加时间',
  `creator` varchar(30) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `loginnum` int(11) DEFAULT '0',
  `last_login_ip` varchar(15) DEFAULT '',
  `last_login_time` int(11) DEFAULT NULL COMMENT '最后登录时间',
  `real_name` varchar(10) DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '218dbb225911693af03a713581a7227f', '0', '', 'http://localhost/static/admin/images/a1.jpg', '7', '0.0.0.0', '1487516755', 'lazar', '0', '1');

-- ----------------------------
-- Table structure for `auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` text NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES ('1', '超级管理员', '1', '', '1446535750', '1446535750');
INSERT INTO `auth_group` VALUES ('9', '系统维护', '1', '', '1487487966', '1487516542');
INSERT INTO `auth_group` VALUES ('10', '文章编辑', '1', '', '1487487992', '1487516527');

-- ----------------------------
-- Table structure for `auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_access`;
CREATE TABLE `auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_access
-- ----------------------------
INSERT INTO `auth_group_access` VALUES ('1', '1');

-- ----------------------------
-- Table structure for `auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE `auth_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `css` varchar(20) NOT NULL COMMENT '样式',
  `condition` char(100) NOT NULL DEFAULT '',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '父栏目ID',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_rule
-- ----------------------------
INSERT INTO `auth_rule` VALUES ('1', '#', '系统管理', '1', '1', 'fa fa-gear', '', '0', '1', '1446535750', '1477312169');
INSERT INTO `auth_rule` VALUES ('2', 'admin/menu/index', '菜单管理', '1', '1', '', '', '1', '10', '1446535750', '1477312169');
INSERT INTO `auth_rule` VALUES ('3', 'admin/role/index', '角色管理', '1', '1', '', '', '1', '20', '1446535750', '1446535750');
INSERT INTO `auth_rule` VALUES ('4', 'admin/user/index', '用户管理', '1', '1', '', '', '1', '30', '1446535750', '1446535750');
INSERT INTO `auth_rule` VALUES ('5', '#', '文章管理', '1', '1', 'fa fa-paste', '', '0', '2', '1446535750', '1446535750');
INSERT INTO `auth_rule` VALUES ('6', 'admin/article/index', '文章列表', '1', '1', '', '', '5', '10', '1487432683', '1487432683');
INSERT INTO `auth_rule` VALUES ('7', 'admin/article/cate', '文章分类', '1', '1', '', '', '5', '20', '1487432954', '1487432954');

-- ----------------------------
-- Table structure for `config`
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`) USING BTREE,
  KEY `type` (`type`) USING BTREE,
  KEY `group` (`group`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', 'web_site_title', '1', '网站标题', '1', '', '网站标题前台显示标题', '1378898976', '1480575456', '1', '后台管理系统', '0');
INSERT INTO `config` VALUES ('2', 'web_site_description', '2', '网站描述', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', '后台管理系统', '1');
INSERT INTO `config` VALUES ('3', 'web_site_keyword', '2', '网站关键字', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', 'ThinkPHP5', '8');
INSERT INTO `config` VALUES ('4', 'web_site_close', '4', '站点状态', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1480643099', '1', '1', '0');
INSERT INTO `config` VALUES ('9', 'config_type_list', '3', '配置类型列表', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1379235348', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举', '2');
INSERT INTO `config` VALUES ('10', 'web_site_icp', '1', '网站备案号', '1', '', '设置在网站底部显示的备案号，如“ 陇ICP备15002349号-1', '1378900335', '1480643159', '1', '暂时没有', '0');
INSERT INTO `config` VALUES ('20', 'config_group_list', '3', '配置分组', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `config` VALUES ('22', 'auth_config', '3', 'Auth配置', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `config` VALUES ('25', 'list_rows', '0', '后台每页记录数', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '10', '10');
INSERT INTO `config` VALUES ('26', 'user_allow_register', '4', '是否允许用户注册', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '0', '3');
INSERT INTO `config` VALUES ('28', 'data_backup_path', '1', '数据库备份根路径', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './data/', '5');
INSERT INTO `config` VALUES ('29', 'data_backup_part_size', '0', '数据库备份卷大小', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `config` VALUES ('30', 'data_backup_compress', '4', '数据库备份文件是否启用压缩', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `config` VALUES ('31', 'data_backup_compress_level', '4', '数据库备份文件压缩级别', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `config` VALUES ('32', 'develop_mode', '4', '开启开发者模式', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `config` VALUES ('36', 'admin_allow_ip', '2', '禁止后台访问IP', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1480643409', '1', '0.0.0.0,120.25.77.116', '0');
INSERT INTO `config` VALUES ('37', 'app_trace', '4', '是否显示页面Trace', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `config` VALUES ('38', 'app_debug', '4', '应用调试模式', '4', '0:关闭\r\n1:开启', '网站正式部署建议关闭', '1478522232', '1478522395', '1', '1', '0');

-- ----------------------------
-- Table structure for `log`
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `admin_name` varchar(50) DEFAULT NULL COMMENT '用户姓名',
  `description` varchar(300) DEFAULT NULL COMMENT '描述',
  `ip` char(60) DEFAULT NULL COMMENT 'IP地址',
  `status` tinyint(1) DEFAULT NULL COMMENT '1 成功 2 失败',
  `add_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3676 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES ('3663', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1484119900');
INSERT INTO `log` VALUES ('3664', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1484207066');
INSERT INTO `log` VALUES ('3665', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1485218918');
INSERT INTO `log` VALUES ('3666', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1485219293');
INSERT INTO `log` VALUES ('3667', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1485232873');
INSERT INTO `log` VALUES ('3668', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487426326');
INSERT INTO `log` VALUES ('3669', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487426454');
INSERT INTO `log` VALUES ('3670', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487429140');
INSERT INTO `log` VALUES ('3671', '1', 'admin', '用户【admin】添加菜单成功', '0.0.0.0', '1', '1487432683');
INSERT INTO `log` VALUES ('3672', '1', 'admin', '用户【admin】添加菜单成功', '0.0.0.0', '1', '1487432954');
INSERT INTO `log` VALUES ('3673', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487487934');
INSERT INTO `log` VALUES ('3674', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487514176');
INSERT INTO `log` VALUES ('3675', '1', 'admin', '用户【admin】登录成功', '0.0.0.0', '1', '1487516755');
