/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.5.40 : Database - smokeroom
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`smokeroom` /*!40100 DEFAULT CHARACTER SET utf8 */;


/*Table structure for table `activity` */

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `at_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动id相当于主键',
  `at_uid` int(11) DEFAULT NULL COMMENT '用户id',
  `at_title` varchar(50) DEFAULT NULL COMMENT '活动标题15字以内',
  `at_status` int(11) DEFAULT NULL COMMENT '报名最多人数限制',
  `at_max_count` int(11) DEFAULT NULL COMMENT '报名最多人数限制',
  `at_creation` datetime DEFAULT NULL COMMENT '发布时间',
  `at_content` varchar(900) DEFAULT NULL COMMENT '活动内容300字以内',
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `activity` */

/*Table structure for table `activity_join_in` */

DROP TABLE IF EXISTS `activity_join_in`;

CREATE TABLE `activity_join_in` (
  `ji_at_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动id',
  `ji_uid` int(11) DEFAULT NULL COMMENT '用户id',
  `ji_creation` datetime DEFAULT NULL COMMENT '加入时间',
  PRIMARY KEY (`ji_at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `activity_join_in` */

/*Table structure for table `facility` */

DROP TABLE IF EXISTS `facility`;

CREATE TABLE `facility` (
  `fy_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '设备主键id',
  `fy_lat` varchar(20) DEFAULT NULL COMMENT '设备所在维度（国策局计量为单位的）',
  `fy_lng` varchar(20) DEFAULT NULL COMMENT '设备所在经度（国策局计量为单位的）',
  `fy_type` int(4) DEFAULT NULL COMMENT '1 吸烟亭  2吸烟柱  3售烟处',
  `fy_name` varchar(50) DEFAULT NULL COMMENT '设备位置名称',
  `fy_detail` varchar(100) DEFAULT NULL COMMENT '设备位置详细',
  `fy_res_link` varchar(255) DEFAULT NULL COMMENT 'type=1时表示VR链接。\r\ntype=2时表示封面链接。\r\ntype=3时表示封面链接。',
  `fy_creation` datetime DEFAULT NULL COMMENT '设备记录创建时间',
  `fy_createdby` int(11) DEFAULT NULL COMMENT '创建者id',
  `fy_lastupdated` datetime DEFAULT NULL COMMENT '最后更新时间',
  `fy_lastupdatedby` int(11) DEFAULT NULL COMMENT '最后更新人',
  `fy_isdel` int(11) DEFAULT NULL COMMENT '1启动 0 删除',
  PRIMARY KEY (`fy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `facility` */

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `fb_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '反馈信息id',
  `fb_uid` int(11) DEFAULT NULL COMMENT '用户id。有可能为空',
  `fb_res` varchar(255) DEFAULT NULL COMMENT '报告所包含的图片链接',
  `fb_content` varchar(255) DEFAULT NULL COMMENT '内容80字以内',
  `fb_status` int(11) DEFAULT NULL COMMENT '反馈信息状态0 未处理1 已处理',
  `fb_rly_content` varchar(50) DEFAULT NULL COMMENT '管理员处理信息的回复',
  `fb_creation` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`fb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `feedback` */

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id，主键',
  `msg_content` varchar(255) DEFAULT NULL COMMENT '消息内容。',
  `msg_creation` datetime DEFAULT NULL COMMENT '发布时间',
  `msg_status` int(10) DEFAULT NULL COMMENT '消息状态1 启动   0 删除',
  `msg_expire` bigint(20) DEFAULT NULL COMMENT '过期时间时间戳。',
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `message` */

/*Table structure for table `report` */

DROP TABLE IF EXISTS `report`;

CREATE TABLE `report` (
  `rp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '报告id。主键',
  `rp_vedio` varchar(255) DEFAULT NULL COMMENT '报告所包含的视频链接',
  `rp_audio` varchar(255) DEFAULT NULL COMMENT '报告所包含的图片链接',
  `rp_worker_id` int(11) DEFAULT NULL COMMENT '巡更工作人员id',
  `rp_creation` datetime DEFAULT NULL COMMENT '创建时间',
  `rp_content` varchar(600) DEFAULT NULL COMMENT '报告文字内容 200字以内',
  PRIMARY KEY (`rp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `report` */

/*Table structure for table `sign_in_record` */

DROP TABLE IF EXISTS `sign_in_record`;

CREATE TABLE `sign_in_record` (
  `sin_tsk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联任务id',
  `sin_fac_id` int(11) DEFAULT NULL COMMENT '路线所在的位置id\r\n关联的是facility表的主键。',
  `sin_worker_id` int(11) DEFAULT NULL COMMENT '巡更工作人员id',
  `sin_creation` datetime DEFAULT NULL COMMENT '打开时间。用于排序。后面要在地图上显示',
  PRIMARY KEY (`sin_tsk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sign_in_record` */

/*Table structure for table `task` */

DROP TABLE IF EXISTS `task`;

CREATE TABLE `task` (
  `tsk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务主键id',
  `tsk_name` varchar(40) DEFAULT NULL COMMENT '任务名称',
  `tsk_leader_id` int(11) DEFAULT NULL COMMENT '任务领队工作人员id',
  `tsk_type` int(11) DEFAULT NULL COMMENT '时间类型\r\n1固定日期巡更。2019-01-02\r\n2固定周期。[1,2,3,4,5]表示星期1~星期5',
  `tsk_time` varchar(255) DEFAULT NULL COMMENT '只做展示用',
  `tsk_creation` datetime DEFAULT NULL COMMENT '创建时间',
  `tsk_createdby` int(11) DEFAULT NULL COMMENT '创建者id',
  `tsk_lastupdated` datetime DEFAULT NULL COMMENT '最后更新时间',
  `tsk_lastupdatedby` int(11) DEFAULT NULL COMMENT '最后更新人',
  `tsk_isdel` int(11) DEFAULT NULL COMMENT '1启动 0 删除',
  PRIMARY KEY (`tsk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task` */

/*Table structure for table `task_procgress` */

DROP TABLE IF EXISTS `task_procgress`;

CREATE TABLE `task_procgress` (
  `tp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `tp_task_id` int(10) unsigned DEFAULT NULL COMMENT '任务id。作为冗余字段。方便查询',
  `tp_wk_id` int(10) unsigned DEFAULT NULL COMMENT '工作人员id。作为冗余字段。方便查询',
  `tp_status` int(10) unsigned DEFAULT NULL COMMENT '巡更状态。0未完成   1完成',
  `tp_start_time` datetime DEFAULT NULL COMMENT '开始巡更时间',
  `tp_finish_time` datetime DEFAULT NULL COMMENT '完成巡更时间。',
  PRIMARY KEY (`tp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task_procgress` */

/*Table structure for table `task_route_detail` */

DROP TABLE IF EXISTS `task_route_detail`;

CREATE TABLE `task_route_detail` (
  `rdt_tsk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理任务id',
  `rdt_fac_id` int(11) DEFAULT NULL COMMENT '路线所在的位置id\r\n关联的是facility表的主键',
  `rdt_tsk_seq` int(11) DEFAULT NULL COMMENT '巡更路线的顺序。用户排序。可以动态调整。',
  PRIMARY KEY (`rdt_tsk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task_route_detail` */

/*Table structure for table `task_worker_detail` */

DROP TABLE IF EXISTS `task_worker_detail`;

CREATE TABLE `task_worker_detail` (
  `wdt_tsk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关联任务id',
  `wdt_worker_id` int(11) DEFAULT NULL COMMENT '巡更人员id',
  PRIMARY KEY (`wdt_tsk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `task_worker_detail` */

/*Table structure for table `trace` */

DROP TABLE IF EXISTS `trace`;

CREATE TABLE `trace` (
  `te_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `te_fy_id` int(11) DEFAULT NULL COMMENT '设备id',
  `te_u_id` int(11) DEFAULT NULL COMMENT '用户id',
  `te_fy_creationtime` datetime DEFAULT NULL COMMENT '更新时间。该字段用于排序',
  `te_last_second` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`te_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `trace` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `ur_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户主键id',
  `ur_openid` varchar(40) DEFAULT NULL COMMENT '用户的openid',
  `ur_wechat_id` varchar(40) DEFAULT NULL COMMENT '用户微信号',
  `ur_phone` varchar(11) DEFAULT NULL COMMENT '用户的手机号',
  `ur_nickname` varchar(50) DEFAULT NULL COMMENT '微信昵称',
  `ur_unionid` varchar(50) DEFAULT NULL COMMENT '用户的unionid',
  `ur_scores` int(11) DEFAULT NULL COMMENT '环保积分',
  `ur_creation` datetime DEFAULT NULL COMMENT '纪录创建时间',
  `ur_lastupdated` datetime DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`ur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

/*Table structure for table `worker` */

DROP TABLE IF EXISTS `worker`;

CREATE TABLE `worker` (
  `wk_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '工作人员id。主键',
  `wk_num` int(10) unsigned DEFAULT NULL COMMENT '工作人员工号',
  `wk_type` varchar(10) DEFAULT NULL COMMENT '角色：\r\nadmin 管理员\r\nworker 员工',
  `wk_phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  `wk_password` varchar(32) NOT NULL COMMENT 'md5加密后的密码',
  `wk_openid` varchar(40) DEFAULT NULL COMMENT '工作人员的openid',
  `wk_name` varchar(40) DEFAULT NULL COMMENT '巡更人员名称',
  `wk_creation` datetime DEFAULT NULL COMMENT '创建时间',
  `wk_isdel` int(11) DEFAULT '1' COMMENT '1启用 0 禁用',
  PRIMARY KEY (`wk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `worker` */

insert  into `worker`(`wk_id`,`wk_num`,`wk_type`,`wk_phone`,`wk_password`,`wk_openid`,`wk_name`,`wk_creation`,`wk_isdel`) values (2,951207,'admin','13798884582','940420',NULL,'刘金江','2019-11-06 11:41:45',1),(3,963852,'worker','13745612345','852741',NULL,'李仁垚',NULL,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
