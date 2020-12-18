# Host: localhost  (Version: 5.5.47)
# Date: 2020-12-18 17:10:48
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "s_admin"
#

DROP TABLE IF EXISTS `s_admin`;
CREATE TABLE `s_admin` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_admin"
#

INSERT INTO `s_admin` VALUES (1,'admin','admin',1);

#
# Structure for table "s_clazz"
#

DROP TABLE IF EXISTS `s_clazz`;
CREATE TABLE `s_clazz` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `info` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_clazz"
#

INSERT INTO `s_clazz` VALUES (1,'软件一班','这是软件工程专业。'),(4,'数学一班','大学数学专业'),(5,'计算机科学与技术一班','计算机专业'),(9,'物联网工程','123');

#
# Structure for table "s_student"
#

DROP TABLE IF EXISTS `s_student`;
CREATE TABLE `s_student` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `clazz_id` int(5) NOT NULL,
  `sex` varchar(5) NOT NULL DEFAULT '男',
  `mobile` varchar(12) DEFAULT NULL,
  `age` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`,`sn`) USING BTREE,
  KEY `student_clazz_id_foreign` (`clazz_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `student_clazz_id_foreign` FOREIGN KEY (`clazz_id`) REFERENCES `s_clazz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_student"
#

INSERT INTO `s_student` VALUES (1,'S11528202944239','张三','123456',1,'男','13918654525',30),(4,'S51528379586807','何沛洋','111111',5,'男','13356565656',12),(9,'S41528633634989','许先城','1',1,'男','13333332133',18),(11,'S51608100081223','张壬丰','123456',5,'男','15013962014',18),(12,'S91608101472505','洪泽彬','admin',9,'女','13428563965',30),(13,'S41608103218012','陈泽伟','admin',4,'女','19924685110',100);

#
# Structure for table "s_teacher"
#

DROP TABLE IF EXISTS `s_teacher`;
CREATE TABLE `s_teacher` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `sn` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `clazz_id` int(5) NOT NULL,
  `sex` varchar(5) NOT NULL DEFAULT '男',
  `tposition` varchar(12) DEFAULT NULL,
  `salary` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`,`sn`) USING BTREE,
  KEY `student_clazz_id_foreign` (`clazz_id`) USING BTREE,
  KEY `id` (`id`) USING BTREE,
  CONSTRAINT `s_teacher_ibfk_1` FOREIGN KEY (`clazz_id`) REFERENCES `s_clazz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_teacher"
#

INSERT INTO `s_teacher` VALUES (9,'T11528608730648','张三老师','111',4,'男','教授','2000'),(10,'T11528609224588','李四老师','111',4,'男','院长','1000'),(11,'T51528617262403','李老师','123456',5,'男','讲师','1000'),(12,'T91588750367766','廖老师','123',9,'男','校长','2000');

#
# Structure for table "s_course"
#

DROP TABLE IF EXISTS `s_course`;
CREATE TABLE `s_course` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `teacher_id` int(5) NOT NULL,
  `course_date` varchar(32) DEFAULT NULL,
  `selected_num` int(5) NOT NULL DEFAULT '0',
  `max_num` int(5) NOT NULL DEFAULT '50',
  `cgrade` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `course_teacher_foreign` (`teacher_id`) USING BTREE,
  CONSTRAINT `course_teacher_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `s_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_course"
#

INSERT INTO `s_course` VALUES (1,'大学英语',9,'周三上午8点',-1,50,3),(2,'大学数学',10,'周三上午10点',2,50,3),(3,'计算机基础',11,'周三上午',4,50,4),(14,'网络工程',11,'周五早上',2,56,5),(15,'SSM整合',12,'上午10点',0,50,6),(16,'英雄联盟',11,'2020年10月1日',1,30,3);

#
# Structure for table "s_selected_course"
#

DROP TABLE IF EXISTS `s_selected_course`;
CREATE TABLE `s_selected_course` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `student_id` int(5) NOT NULL,
  `course_id` int(5) NOT NULL,
  `teacher_id` int(5) NOT NULL,
  `score_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `selected_course_student_fk` (`student_id`) USING BTREE,
  KEY `selected_course_course_fk` (`course_id`) USING BTREE,
  KEY `teacher_id` (`teacher_id`) USING BTREE,
  CONSTRAINT `selected_course_course_fk` FOREIGN KEY (`course_id`) REFERENCES `s_course` (`id`),
  CONSTRAINT `selected_course_student_fk` FOREIGN KEY (`student_id`) REFERENCES `s_student` (`id`),
  CONSTRAINT `s_selected_course_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `s_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

#
# Data for table "s_selected_course"
#

INSERT INTO `s_selected_course` VALUES (4,1,2,10,NULL),(6,1,14,11,100),(9,4,3,11,100),(10,9,14,11,102),(11,1,3,11,20),(12,4,2,10,100),(13,9,1,9,12),(16,11,3,11,NULL),(17,11,16,11,NULL);
