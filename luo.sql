/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50547
Source Host           : localhost:3306
Source Database       : luo

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2017-02-21 18:18:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'admin', '218dbb225911693af03a713581a7227f', '0', '', 'http://localhost/static/admin/images/a1.jpg', '10', '127.0.0.1', '1487669313', 'lazar', '0', '1');
INSERT INTO `admin` VALUES ('4', 'test', '000000', '0', '', '/uploads/face/20170221\\8f2176737dda57819346e6eb5824c4ca.jpeg', '0', '', null, 'lazar', '1', '11');
INSERT INTO `admin` VALUES ('3', 'edit', '123123', '0', '', '/uploads/face/20170220\\264bc0a9299b20d042a55575e7fffcc8.jpeg', '0', '', null, '瞎编乱造', '1', '10');
INSERT INTO `admin` VALUES ('5', '数据维护', '111111', '0', '', '/uploads/face/201702\\21\\49d461001e593b524f32130dcaf05eb8.jpeg', '0', '', null, 'zj', '1', '9');

-- ----------------------------
-- Table structure for `article`
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '文章逻辑ID',
  `title` varchar(128) NOT NULL COMMENT '文章标题',
  `cate_id` int(11) NOT NULL DEFAULT '1' COMMENT '文章类别',
  `photo` varchar(64) DEFAULT '' COMMENT '文章图片',
  `remark` varchar(256) DEFAULT '' COMMENT '文章描述',
  `keyword` varchar(32) DEFAULT '' COMMENT '文章关键字',
  `content` text NOT NULL COMMENT '文章内容',
  `views` int(11) NOT NULL DEFAULT '1' COMMENT '浏览量',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '文章类型',
  `is_tui` int(1) DEFAULT '0' COMMENT '是否推荐',
  `from` varchar(16) NOT NULL DEFAULT '' COMMENT '来源',
  `writer` varchar(64) NOT NULL COMMENT '作者',
  `ip` varchar(16) NOT NULL,
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `a_title` (`title`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('46', 'PHP人民币金额数字转中文大写的函数代码', '5', './images/2015-12-28/56813c2c52521.jpg', '在网上看到一个非常有趣的PHP人民币金额数字转中文大写的函数，其实质就是数字转换成中文大写，测试了一下，非常有趣，随便输个数字，就可以将其大写打印出来，新手朋友们试一下吧', '人民币转大写', '<p>在网上看到一个非常有趣的PHP人民币金额数字转中文大写的函数，其实质就是数字转换成中文大写，测试了一下，非常有趣，随便输个数字，就可以将其大写打印出来，新手朋友们试一下吧</p><pre class=\"brush:php;toolbar:false\">/**\r\n*数字金额转换成中文大写金额的函数\r\n*String&nbsp;Int&nbsp;&nbsp;$num&nbsp;&nbsp;要转换的小写数字或小写字符串\r\n*return&nbsp;大写字母\r\n*小数位为两位\r\n**/\r\nfunction&nbsp;get_amount($num){\r\n$c1&nbsp;=&nbsp;&quot;零壹贰叁肆伍陆柒捌玖&quot;;\r\n$c2&nbsp;=&nbsp;&quot;分角元拾佰仟万拾佰仟亿&quot;;\r\n$num&nbsp;=&nbsp;round($num,&nbsp;2);\r\n$num&nbsp;=&nbsp;$num&nbsp;*&nbsp;100;\r\nif&nbsp;(strlen($num)&nbsp;&gt;&nbsp;10)&nbsp;{\r\nreturn&nbsp;&quot;数据太长，没有这么大的钱吧，检查下&quot;;\r\n}&nbsp;\r\n$i&nbsp;=&nbsp;0;\r\n$c&nbsp;=&nbsp;&quot;&quot;;\r\nwhile&nbsp;(1)&nbsp;{\r\nif&nbsp;($i&nbsp;==&nbsp;0)&nbsp;{\r\n$n&nbsp;=&nbsp;substr($num,&nbsp;strlen($num)-1,&nbsp;1);\r\n}&nbsp;else&nbsp;{\r\n$n&nbsp;=&nbsp;$num&nbsp;%&nbsp;10;\r\n}&nbsp;\r\n$p1&nbsp;=&nbsp;substr($c1,&nbsp;3&nbsp;*&nbsp;$n,&nbsp;3);\r\n$p2&nbsp;=&nbsp;substr($c2,&nbsp;3&nbsp;*&nbsp;$i,&nbsp;3);\r\nif&nbsp;($n&nbsp;!=&nbsp;&#39;0&#39;&nbsp;||&nbsp;($n&nbsp;==&nbsp;&#39;0&#39;&nbsp;&amp;&amp;&nbsp;($p2&nbsp;==&nbsp;&#39;亿&#39;&nbsp;||&nbsp;$p2&nbsp;==&nbsp;&#39;万&#39;&nbsp;||&nbsp;$p2&nbsp;==&nbsp;&#39;元&#39;)))&nbsp;{\r\n$c&nbsp;=&nbsp;$p1&nbsp;.&nbsp;$p2&nbsp;.&nbsp;$c;\r\n}&nbsp;else&nbsp;{\r\n$c&nbsp;=&nbsp;$p1&nbsp;.&nbsp;$c;\r\n}&nbsp;\r\n$i&nbsp;=&nbsp;$i&nbsp;+&nbsp;1;\r\n$num&nbsp;=&nbsp;$num&nbsp;/&nbsp;10;\r\n$num&nbsp;=&nbsp;(int)$num;\r\nif&nbsp;($num&nbsp;==&nbsp;0)&nbsp;{\r\nbreak;\r\n}&nbsp;\r\n}\r\n$j&nbsp;=&nbsp;0;\r\n$slen&nbsp;=&nbsp;strlen($c);\r\nwhile&nbsp;($j&nbsp;&lt;&nbsp;$slen)&nbsp;{\r\n$m&nbsp;=&nbsp;substr($c,&nbsp;$j,&nbsp;6);\r\nif&nbsp;($m&nbsp;==&nbsp;&#39;零元&#39;&nbsp;||&nbsp;$m&nbsp;==&nbsp;&#39;零万&#39;&nbsp;||&nbsp;$m&nbsp;==&nbsp;&#39;零亿&#39;&nbsp;||&nbsp;$m&nbsp;==&nbsp;&#39;零零&#39;)&nbsp;{\r\n$left&nbsp;=&nbsp;substr($c,&nbsp;0,&nbsp;$j);\r\n$right&nbsp;=&nbsp;substr($c,&nbsp;$j&nbsp;+&nbsp;3);\r\n$c&nbsp;=&nbsp;$left&nbsp;.&nbsp;$right;\r\n$j&nbsp;=&nbsp;$j-3;\r\n$slen&nbsp;=&nbsp;$slen-3;\r\n}&nbsp;\r\n$j&nbsp;=&nbsp;$j&nbsp;+&nbsp;3;\r\n}&nbsp;\r\nif&nbsp;(substr($c,&nbsp;strlen($c)-3,&nbsp;3)&nbsp;==&nbsp;&#39;零&#39;)&nbsp;{\r\n$c&nbsp;=&nbsp;substr($c,&nbsp;0,&nbsp;strlen($c)-3);\r\n}\r\nif&nbsp;(empty($c))&nbsp;{\r\nreturn&nbsp;&quot;零元整&quot;;\r\n}else{\r\nreturn&nbsp;$c&nbsp;.&nbsp;&quot;整&quot;;\r\n}\r\n}</pre><p>最终实现效果：</p><p><img src=\"/Uploads/ueditor/2015-12-28/1451310141372440.png\" title=\"1451310141372440.png\" alt=\"1449026968974428.png\"/></p>', '173', '1', '1', 'Win 8.1', '轮回', '124.152.7.106', '1449026848', '1452229319', '0');
INSERT INTO `article` VALUES ('47', 'Windows下mysql忘记密码的解决方法', '1', './images/2015-12-28/56813c5c5209d.jpg', 'Windows下mysql忘记密码的解决方法', 'mysql', '<p>方法一：</p><p>1、在DOS窗口下输入</p><pre>net&nbsp;stop&nbsp;mysql5</pre><p>&nbsp;</p><p>或</p><pre>net&nbsp;stop&nbsp;mysql</pre><p>&nbsp;</p><p>2、开一个DOS窗口，这个需要切换到mysql的bin目录。<br/>一般在bin目录里面创建一个批处理1.bat,内容是cmd.exe运行一下即可就切换到当前目录，然后输入</p><pre>mysqld-nt&nbsp;--skip-grant-tables;</pre><p>&nbsp;</p><p>3、再开一个DOS窗口</p><pre>mysql&nbsp;-u&nbsp;root</pre><p>&nbsp;</p><p>4、输入：</p><pre>use&nbsp;mysql&nbsp;\r\nupdate&nbsp;user&nbsp;set&nbsp;password=password(&quot;new_pass&quot;)&nbsp;where&nbsp;user=&quot;root&quot;;&nbsp;\r\nflush&nbsp;privileges;&nbsp;\r\nexit</pre><p>&nbsp;</p><p>5、使用任务管理器，找到mysqld-nt的进程，结束进程&nbsp;<br/>或下面的步骤<br/>1，停止MYSQL服务，CMD打开DOS窗口，输入 net stop mysql&nbsp;<br/>2，在CMD命令行窗口，进入MYSQL安装目录 比如E:Program FilesMySQLMySQL Server 5.0bin&nbsp;<br/>示范命令:&nbsp;<br/>输入 e:回车,&nbsp;<br/>输入cd &quot;E:Program FilesMySQLMySQL Server 5.0bin&quot;&nbsp;<br/>注意双引号也要输入,这样就可以进入Mysql安装目录了.&nbsp;<br/>3，进入mysql安全模式，即当mysql起来后，不用输入密码就能进入数据库。&nbsp;<br/>命令为：</p><pre>mysqld-nt&nbsp;--skip-grant-tables</pre><p>&nbsp;</p><p>4，重新打开一个CMD命令行窗口，输入</p><p>mysql -uroot -p，使用空密码的方式登录MySQL（不用输入密码，直接按回车）</p><p>5，输入以下命令开始修改root用户的密码（注意：命令中mysql.user中间有个“点”）</p><p>mysql.user：数据库名.表名<br/>mysql&gt; update mysql.user set password=PASSWORD(&#39;新密码&#39;) where User=&#39;root&#39;;&nbsp;<br/>6，刷新权限表&nbsp;<br/>mysql&gt; flush privileges;&nbsp;<br/>7，退出&nbsp;<br/>mysql&gt; quit</p><p><br/>这样MYSQL超级管理员账号 ROOT已经重新设置好了，接下来 在任务管理器里结束掉 mysql-nt.exe 这个进程，重新启动MYSQL即可！</p><p>（也可以直接重新启动服务器）&nbsp;<br/>MYSQL重新启动后，就可以用新设置的ROOT密码登陆MYSQL了！</p><p>方法二：</p><p>首先在 MySQL的安装目录下 新建一个pwdhf.txt, 输入文本：</p><pre>SET&nbsp;PASSWORD&nbsp;FOR&nbsp;&#39;root&#39;@&#39;localhost&#39;&nbsp;=&nbsp;PASSWORD(&#39;*****&#39;);</pre><p>&nbsp;</p><p>红色部份为 需要设置的新密码&nbsp;<br/>用windows服务管理工具或任务管理器来停止MySQL服务 (任务管理器K掉 mysqld-nt 进程)&nbsp;<br/>Dos命令提示符到 MySQL安装目录下的bin目录 如我的是</p><p>D:Program FilesMySQLMySQL Server 5.1bin&nbsp;<br/>然后运行：</p><pre>mysqld-nt&nbsp;--init-file=../pwdhf.txt</pre><p>&nbsp;</p><p>执行完毕， 停止MySQL数据库服务 (任务管理器K掉 mysqld-nt 进程)，然后再重新以正常模式启动MYSQL 即可</p><hr style=\"color: rgb(51, 51, 51); font-family: Arial; font-size: 14px; line-height: 26px; white-space: normal; background-color: rgb(255, 255, 255);\"/><p>mysql5.1或以上</p><p>1、 首先检查mysql服务是否启动，若已启动则先将其停止服务，可在开始菜单的运行，使用命令：</p><pre>net&nbsp;stop&nbsp;mysql</pre><p>&nbsp;</p><p>2、打开第一个cmd窗口，切换到mysql的bin目录，运行命令：</p><pre>mysqld&nbsp;--defaults-file=&quot;C:Program&nbsp;FilesMySQLMySQL&nbsp;Server&nbsp;5.1my.ini&quot;&nbsp;--console&nbsp;--skip-grant-tables</pre><p>&nbsp;</p><p>注释：</p><p>该命令通过跳过权限安全检查，开启mysql服务，这样连接mysql时，可以不用输入用户密码。&nbsp;<br/>&nbsp;</p><p>&nbsp;</p><p>3、打开第二个cmd窗口，连接mysql：</p><p>输入命令：</p><pre>mysql&nbsp;-uroot&nbsp;-p</pre><p>出现：</p><p>Enter password:</p><p>在这里直接回车，不用输入密码。</p><p>然后就就会出现登录成功的信息，</p><p>&nbsp;</p><p>&nbsp;</p><p>4、使用命令：</p><pre>show&nbsp;databases;</pre><p>&nbsp;</p><p>&nbsp;</p><p>5、使用命令切换到mysql数据库：</p><pre>use&nbsp;mysql;</pre><p>&nbsp;</p><p>6、使用命令更改root密码为123456：</p><pre>UPDATE&nbsp;user&nbsp;SET&nbsp;Password=PASSWORD(&#39;123456&#39;)&nbsp;where&nbsp;USER=&#39;root&#39;;</pre><p>&nbsp;</p><p>&nbsp;</p><p>7、刷新权限：</p><pre>FLUSH&nbsp;PRIVILEGES;</pre><p>&nbsp;</p><p>8、然后退出，重新登录：</p><p>quit</p><p>重新登录：</p><pre>mysql&nbsp;-uroot&nbsp;-p</pre><p>&nbsp;</p><p>9、出现输入密码提示，输入新的密码即可登录：</p><p>Enter password: ***********</p><p>显示登录信息： 成功&nbsp; 就一切ok了</p><p>&nbsp;</p><p>10、重新启动mysql服务</p><pre>net&nbsp;start&nbsp;mysql</pre><p><br/></p>', '124', '0', '0', 'Win 8.1', '轮回', '0.0.0.0', '1450339377', '1450339377', '0');
INSERT INTO `article` VALUES ('48', '禁止网页复制的代码', '1', './images/2015-12-28/56813b343c8b2.jpg', '禁止网页复制的代码', '网页复制', '<p>今天做一网站项目时，客户要求让用户不能复制网站内容，网上搜索了一下，总结成以下二几行代码。其实吧，要是懂的人，这些都是浮云来的，客户就是要让一般人不能复制他的内容资料。</p><pre class=\"brush:html;toolbar:false\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px; padding: 9.5px; list-style: none; border: 1px solid rgb(204, 204, 204); overflow: auto; font-family: Menlo, Monaco, Consolas, &#39;Courier New&#39;, monospace; font-size: 13px; line-height: 1.42857; color: rgb(51, 51, 51); word-break: break-all; word-wrap: break-word; border-radius: 4px; background-color: rgb(245, 245, 245);\">&lt;script&nbsp;type=text/javascript&gt;\r\n&lt;!--\r\ndocument.oncontextmenu=new&nbsp;Function(&#39;event.returnValue=false;&#39;);\r\ndocument.onselectstart=new&nbsp;Function(&#39;event.returnValue=false;&#39;);\r\n--&gt;\r\n&lt;/script&gt;\r\n&lt;!DOCTYPE&nbsp;html&nbsp;PUBLIC&nbsp;&quot;-//W3C\r\n//DTD&nbsp;XHTML&nbsp;1.0&nbsp;Transitional//EN&quot;&nbsp;&quot;http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd&quot;&gt;\r\n&lt;html&nbsp;xmlns=&quot;http://www.w3.org/1999/xhtml&quot;&gt;\r\n&lt;head&gt;\r\n&lt;meta&nbsp;http-equiv=&quot;Content-Type&quot;&nbsp;content=&quot;text/html;&nbsp;charset=gb2312&quot;&nbsp;/&gt;\r\n&lt;\r\ntitle\r\n&gt;禁止网页复制的代码&lt;/title&gt;\r\n&lt;/head&gt;\r\n&lt;body&nbsp;style=&quot;text-align:center&quot;&gt;\r\n&lt;p&gt;&nbsp;&lt;/p&gt;\r\n&lt;p&gt;&nbsp;&lt;/p&gt;\r\n&lt;p&gt;网页禁止右键、禁止查看源代码、禁止复制的代码，试试你的右键、ctrl+c和ctrl+c吧~\r\n&nbsp;&nbsp;&lt;SCRIPT&nbsp;language=javascript&nbsp;type=text/javascript&gt;\r\n&lt;!--\r\ndocument.oncontextmenu=new&nbsp;Function(&#39;event.returnValue=false;&#39;);\r\ndocument.onselectstart=new&nbsp;Function(&#39;event.returnValue=false;&#39;);\r\n--&gt;\r\n&nbsp;&nbsp;&lt;/SCRIPT&gt;\r\n&lt;/p&gt;\r\n&lt;/body&gt;\r\n&lt;/html&gt;</pre><p><br/></p>', '206', '1', '1', 'Win 8.1', '轮回', '0.0.0.0', '1450340150', '1450340150', '1');

-- ----------------------------
-- Table structure for `article_cate`
-- ----------------------------
DROP TABLE IF EXISTS `article_cate`;
CREATE TABLE `article_cate` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '分类名称',
  `orderby` varchar(10) DEFAULT '100' COMMENT '排序',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_cate
-- ----------------------------
INSERT INTO `article_cate` VALUES ('1', '学习笔记', '1', '1477140627', '1480582693', '1');
INSERT INTO `article_cate` VALUES ('2', '生活随笔', '2', '1477140627', '1477140627', '1');
INSERT INTO `article_cate` VALUES ('3', '热点分享', '3', '1477140627', '1477140627', '1');
INSERT INTO `article_cate` VALUES ('4', '.NET', '4', '1477140627', '1477140627', '0');
INSERT INTO `article_cate` VALUES ('5', 'PHP', '5', '1477140627', '1477140627', '1');
INSERT INTO `article_cate` VALUES ('6', 'Java', '6', '1477140627', '1477140627', '1');
INSERT INTO `article_cate` VALUES ('18', 'Go', '50', '1487649864', '1487649864', '1');
INSERT INTO `article_cate` VALUES ('19', 'javascript', '50', '1487650151', '1487650151', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES ('1', '超级管理员', '1', '', '1446535750', '1446535750');
INSERT INTO `auth_group` VALUES ('9', '系统维护', '1', '', '1487487966', '1487516542');
INSERT INTO `auth_group` VALUES ('10', '文章编辑', '1', '5,6,7', '1487487992', '1487570227');
INSERT INTO `auth_group` VALUES ('11', '测试员', '1', '1,2,3,4,5,6,7', '1487572920', '1487572934');

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
INSERT INTO `auth_group_access` VALUES ('3', '10');
INSERT INTO `auth_group_access` VALUES ('4', '11');
INSERT INTO `auth_group_access` VALUES ('5', '9');

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
INSERT INTO `auth_rule` VALUES ('7', 'admin/article/cate_index', '文章分类', '1', '1', '', '', '5', '20', '1487432954', '1487432954');

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
) ENGINE=MyISAM AUTO_INCREMENT=3698 DEFAULT CHARSET=utf8;

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
INSERT INTO `log` VALUES ('3676', '1', 'admin', '用户【admin】登录成功', '127.0.0.1', '1', '1487560518');
INSERT INTO `log` VALUES ('3677', '1', 'admin', '用户【test】添加成功', '127.0.0.1', '1', '1487574344');
INSERT INTO `log` VALUES ('3678', '1', 'admin', '用户【test】添加成功', '127.0.0.1', '1', '1487574441');
INSERT INTO `log` VALUES ('3679', '1', 'admin', '用户【test】编辑成功', '127.0.0.1', '1', '1487578487');
INSERT INTO `log` VALUES ('3680', '1', 'admin', '用户【test】编辑成功', '127.0.0.1', '1', '1487578580');
INSERT INTO `log` VALUES ('3681', '1', 'admin', '用户【test】编辑成功', '127.0.0.1', '1', '1487579117');
INSERT INTO `log` VALUES ('3682', '1', 'admin', '用户【edit】添加成功', '127.0.0.1', '1', '1487579860');
INSERT INTO `log` VALUES ('3683', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580338');
INSERT INTO `log` VALUES ('3684', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580423');
INSERT INTO `log` VALUES ('3685', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580545');
INSERT INTO `log` VALUES ('3686', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580583');
INSERT INTO `log` VALUES ('3687', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580635');
INSERT INTO `log` VALUES ('3688', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580724');
INSERT INTO `log` VALUES ('3689', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580775');
INSERT INTO `log` VALUES ('3690', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487580831');
INSERT INTO `log` VALUES ('3691', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487581389');
INSERT INTO `log` VALUES ('3692', '1', 'admin', '用户【edit】编辑成功', '127.0.0.1', '1', '1487581623');
INSERT INTO `log` VALUES ('3693', '1', 'admin', '用户【admin】登录成功', '127.0.0.1', '1', '1487645625');
INSERT INTO `log` VALUES ('3694', '1', 'admin', '用户【admin】删除管理员成功(ID=2)', '127.0.0.1', '1', '1487645673');
INSERT INTO `log` VALUES ('3695', '1', 'admin', '用户【test】添加成功', '127.0.0.1', '1', '1487668142');
INSERT INTO `log` VALUES ('3696', '1', 'admin', '用户【admin】登录成功', '127.0.0.1', '1', '1487669313');
INSERT INTO `log` VALUES ('3697', '1', 'admin', '用户【数据维护】添加成功', '127.0.0.1', '1', '1487669382');
