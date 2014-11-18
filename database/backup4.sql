-- MySQL dump 10.13  Distrib 5.5.40, for Win32 (x86)
--
-- Host: localhost    Database: lab_db
-- ------------------------------------------------------
-- Server version	5.5.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add book',8,'add_book'),(23,'Can change book',8,'change_book'),(24,'Can delete book',8,'delete_book'),(25,'Can add user',9,'add_user'),(26,'Can change user',9,'change_user'),(27,'Can delete user',9,'delete_user'),(28,'Can add borrow_item',10,'add_borrow_item'),(29,'Can change borrow_item',10,'change_borrow_item'),(30,'Can delete borrow_item',10,'delete_borrow_item'),(31,'Can add event',11,'add_event'),(32,'Can change event',11,'change_event'),(33,'Can delete event',11,'delete_event'),(34,'Can add news',12,'add_news'),(35,'Can change news',12,'change_news'),(36,'Can delete news',12,'delete_news');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$C3O3xWfFVLYL$4QaIMkrM0SYWDObG9Vebk9q1waeHovcDBNWrxIbP3x8=','2014-11-18 01:45:01',1,'admin','','','shylonezeng@gmail.com',1,1,'2014-11-03 12:09:16'),(2,'pbkdf2_sha256$10000$zkZ4Jy5GuGet$0ZIAzHziUINTfttUdFxsqb0CjNx19MzUY+ZAxTt0gyg=','2014-11-18 01:44:35',0,'zengxx','','','',0,1,'2014-11-17 13:27:42');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_book`
--

DROP TABLE IF EXISTS `core_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `author` varchar(50) NOT NULL,
  `publisher` varchar(50) NOT NULL,
  `pub_time` date NOT NULL,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_book`
--

LOCK TABLES `core_book` WRITE;
/*!40000 ALTER TABLE `core_book` DISABLE KEYS */;
INSERT INTO `core_book` VALUES (1,'begin linux programming','Jeans A.I','press','2014-11-03','normal'),(2,'重视大脑的学习指南:Head First Python(中文版) ','巴里（Barry.P.） (作者), 林琪 (译者), 郭静 (译者), 等 (译者)','中国电力出版社','2012-03-01','borrowed'),(3,'Python核心编程(第2版)','丘恩 (Wesley J.Chun) (作者), 宋吉广 (译者','人民邮电出版社; 第1','2008-07-01','borrowed'),(4,'Distributed Systems: Concepts and Design (5th Edition) ','by George Coulouris (Author)','Addison-Wesley; 5 edition','2011-07-07','recommend'),(5,'Distributed Systems: Concepts and Design (5th Edition) ','by George Coulouris (Author)','Addison-Wesley; 5 edition','2011-07-07','recommend');
/*!40000 ALTER TABLE `core_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_borrow_item`
--

DROP TABLE IF EXISTS `core_borrow_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_borrow_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_time` datetime NOT NULL,
  `return_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_borrow_item_6340c63c` (`user_id`),
  KEY `core_borrow_item_36c249d7` (`book_id`),
  CONSTRAINT `book_id_refs_id_25fc33a8` FOREIGN KEY (`book_id`) REFERENCES `core_book` (`id`),
  CONSTRAINT `user_id_refs_id_5191432a` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_borrow_item`
--

LOCK TABLES `core_borrow_item` WRITE;
/*!40000 ALTER TABLE `core_borrow_item` DISABLE KEYS */;
INSERT INTO `core_borrow_item` VALUES (1,1,2,'2014-11-07 03:12:52','2014-11-07 09:45:11'),(2,1,1,'2014-11-07 22:29:31','2014-11-07 09:47:05'),(3,1,3,'2014-11-07 22:29:08','2014-11-07 09:16:28'),(4,1,1,'2014-11-07 09:03:14','2014-11-07 09:47:05'),(5,1,2,'2014-11-07 09:14:05','2014-11-07 09:45:11'),(6,1,3,'2014-11-07 09:15:30','2014-11-07 09:16:28'),(7,1,2,'2014-11-07 09:16:45','2014-11-07 09:45:11'),(8,1,1,'2014-11-07 09:44:58','2014-11-07 09:47:05'),(9,1,2,'2014-11-07 09:44:59','2014-11-07 09:45:11'),(10,1,1,'2014-11-07 10:40:03','2014-11-18 04:10:04'),(11,1,2,'2014-11-07 10:40:05','2014-11-18 04:14:33'),(12,1,3,'2014-11-07 10:40:07','2014-11-18 04:10:07'),(13,1,1,'2014-11-18 04:14:41','2014-11-18 15:45:31'),(14,1,2,'2014-11-18 04:14:42','1997-01-01 06:00:00'),(15,1,3,'2014-11-18 04:14:44','1997-01-01 06:00:00');
/*!40000 ALTER TABLE `core_borrow_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_event`
--

DROP TABLE IF EXISTS `core_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `etime` datetime NOT NULL,
  `title` varchar(100) NOT NULL,
  `detail` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_event`
--

LOCK TABLES `core_event` WRITE;
/*!40000 ALTER TABLE `core_event` DISABLE KEYS */;
INSERT INTO `core_event` VALUES (1,'2014-11-03 12:14:52','meeting','In a meeting, two or more people come together to discuss one or more topics, often in a formal setting. Contents.'),(2,'2014-11-03 12:15:29','聚餐','聚餐，准时参与'),(3,'2014-12-20 23:32:01','讲座','主题未定'),(4,'2014-11-21 00:30:34','实验室聚餐','请全体积极参加，时间地点仍行通知'),(5,'2014-11-21 14:40:14','讲座','主题未定');
/*!40000 ALTER TABLE `core_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_news`
--

DROP TABLE IF EXISTS `core_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `detail` varchar(2000) NOT NULL,
  `picture` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_news`
--

LOCK TABLES `core_news` WRITE;
/*!40000 ALTER TABLE `core_news` DISABLE KEYS */;
INSERT INTO `core_news` VALUES (1,' Czech Republic awards Sir Nicholas Winton nation\'s highest order','Sir Nicholas Winton, MBE visited the Czech Republic on Tuesday and received the Order of the White Lion from the hands of president Miloš Zeman.','upload/0-0-IMG_3432.JPG'),(2,' Two injured, three dead in mid-air collision near Maryland airport','A helicopter and a small airplane collided near Frederick Municipal Airport in Frederick, Maryland just after 3:40 local time on Thursday afternoon.','upload/IMG_3426.JPG'),(3,'FCC seeks fiber-optic delay data from AT&T','AT&T joined other wireless carriers and Internet service providers in opposing rules proposed on Monday by President Obama to prevent ISPs from throttling Internet traffic or charging fees to prioritize traffic.\r\n\r\nStephenson was among the most vocal this week in attacking Obama\'s recommendations that called for the FCC to regulate ISPs like telecommunications carriers under Title II provisions of the Telecommunications Act.\r\n\r\nThe FCC\'s letter asks AT&T to provide data related to the carrier\'s plans for fiber optic deployments, including the number of households to which it planned to deploy fiber prior to limiting the deployments to the DirecTV commitments. The FCC quoted Stephenson as saying the DirecTV fiber commitments totaled 2 million households.\r\n\r\nThe letter also asks for AT&T to state whether its investments in fiber are now unprofitable. In addition, it asks for all documents related to the company\'s decision to limit deployment to the DirecTV households.\r\n\r\nThe letter is signed by FCC attorney Jamillia Ferris. She manages the review of the AT&T-DirecTV transaction, which Stephenson said on Friday could be finalized in the second quarter of 2015.\r\n\r\nGiven Ferris\' role, the request for AT&T documents is more pertinent to the purchase of DirecTV than to the FCC\'s consideration of net neutrality rules. Some critics of AT&T have argued that Stephenson\'s comments on fiber-optic delays are bogus and that the 100 cities that Stephenson said are subject to delays might not have been ready for construction.\r\n\r\n\r\n','upload/IMG_19700102_0800471_2.jpg'),(4,'Mobile 4K video getting wired to TVs through USB 3.1, MHL','Starting late next year, it will become a tad easier to stream 4K video from mobile devices to ultra high-definition TVs.\r\n\r\nMobile devices with the upcoming USB Type C connectors will support the latest MHL (mobile high-definition link) 3 mobile video standard, which can transmit 4K video from mobile devices to TVs or displays, the MHL Consortium said Monday.\r\n\r\nThe USB ports in mobile devices today will be replaced by new connectors based on the USB 3.1 protocol, which will provide faster charging and data transfer speeds to support 4K video. The new USB connector is expected in some mobile devices by the end of next year, with widespread adoption expected to begin in 2016.','upload/IMG_20140827_1815161_3.jpg');
/*!40000 ALTER TABLE `core_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-11-03 12:14:28',1,8,'1','begin linux programming',1,''),(2,'2014-11-03 12:15:20',1,11,'1','meeting',1,''),(3,'2014-11-03 12:16:45',1,11,'2','聚餐',1,''),(4,'2014-11-03 12:17:22',1,9,'1','zengxx',1,''),(5,'2014-11-03 12:18:57',1,12,'1',' Czech Republic awards Sir Nicholas Winton nation\'s highest order',1,''),(6,'2014-11-03 12:19:23',1,12,'2',' Two injured, three dead in mid-air collision near Maryland airport',1,''),(7,'2014-11-06 13:36:06',1,8,'2','重视大脑的学习指南:Head First Python(中文版) ',1,''),(8,'2014-11-06 13:37:54',1,8,'3','Python核心编程(第2版)',1,''),(9,'2014-11-07 04:27:30',1,10,'4','Borrow_item object',3,''),(10,'2014-11-07 04:27:36',1,10,'3','Borrow_item object',3,''),(11,'2014-11-07 04:31:36',1,10,'2','Borrow_item object',3,''),(12,'2014-11-07 04:36:36',1,8,'3','Python核心编程(第2版)',2,'Changed status.'),(13,'2014-11-07 04:37:05',1,8,'1','begin linux programming',2,'Changed status.'),(14,'2014-11-07 07:37:42',1,8,'1','begin linux programming',2,'Changed status.'),(15,'2014-11-07 07:43:35',1,8,'1','begin linux programming',2,'Changed status.'),(16,'2014-11-07 07:57:25',1,8,'1','begin linux programming',2,'No fields changed.'),(17,'2014-11-07 08:01:11',1,8,'1','begin linux programming',2,'Changed status.'),(18,'2014-11-07 08:01:29',1,8,'3','Python核心编程(第2版)',2,'Changed status.'),(19,'2014-11-07 08:29:11',1,10,'3','Borrow_item object',2,'Changed borrow_time and return_time.'),(20,'2014-11-07 08:29:33',1,10,'2','Borrow_item object',2,'Changed borrow_time and return_time.'),(21,'2014-11-07 08:30:18',1,10,'1','Borrow_item object',2,'Changed return_time.'),(22,'2014-11-07 09:02:29',1,8,'2','重视大脑的学习指南:Head First Python(中文版) ',2,'Changed status.'),(23,'2014-11-07 09:02:54',1,8,'1','begin linux programming',2,'Changed status.'),(24,'2014-11-17 13:27:42',1,3,'2','zengxx',1,''),(25,'2014-11-17 14:16:41',1,8,'3','Python核心编程(第2版)',2,'Changed status.'),(26,'2014-11-17 14:16:49',1,8,'2','重视大脑的学习指南:Head First Python(中文版) ',2,'Changed status.'),(27,'2014-11-17 14:16:54',1,8,'3','Python核心编程(第2版)',2,'No fields changed.'),(28,'2014-11-17 14:17:07',1,8,'1','begin linux programming',2,'Changed status.'),(29,'2014-11-17 14:21:31',1,12,'3','参与2014中国大数据行业大调查 BDTC门票等你拿',1,''),(30,'2014-11-17 14:22:44',1,12,'4','Wire Lurker肆意横行',1,''),(31,'2014-11-17 14:32:38',1,11,'3','讲座',1,''),(32,'2014-11-17 14:38:47',1,11,'4','实验室聚餐',1,''),(33,'2014-11-17 14:39:42',1,11,'3','讲座',2,'Changed etime.'),(34,'2014-11-17 14:40:30',1,11,'5','讲座',1,''),(35,'2014-11-17 14:45:43',1,12,'3','FCC seeks fiber-optic delay data from AT&T',2,'Changed title, detail and picture.'),(36,'2014-11-17 14:46:35',1,12,'4','Wire Lurker肆意横行Mobile 4K video getting wired to TVs through USB 3.1, MHL',2,'Changed title and detail.'),(37,'2014-11-17 14:46:43',1,12,'4','Mobile 4K video getting wired to TVs through USB 3.1, MHL',2,'Changed title.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'book','core','book'),(9,'user','core','user'),(10,'borrow_item','core','borrow_item'),(11,'event','core','event'),(12,'news','core','news');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2hp4jsmdywhvl34jd85ye3fy0026zzjr','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 07:21:34'),('32jm8i6tzq8ce95mbqa2x6zovbw17ww8','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 08:08:10'),('3gzq5m0orkyiqkgs4jrhtfizkvivuzf0','N2I3MWUwMDMwMDEzN2RlMWQ4NzcwMjVmZjM5OWFmY2I1MDY3NmI5ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MSwiY3VycmVudF91c2VyIjoiYWRtaW4ifQ==','2014-11-20 16:06:12'),('4jdrk809doftouqbnntw0go420f8lkbr','N2JjYTc4Mjk5ZDkwMDhmY2MzMmQ3MTRlZWQwNjljZjdiOThmZGY1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-11-18 04:52:55'),('5bi333npdte4ixahs9qcbkd04kjy1qog','N2I3MWUwMDMwMDEzN2RlMWQ4NzcwMjVmZjM5OWFmY2I1MDY3NmI5ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MSwiY3VycmVudF91c2VyIjoiYWRtaW4ifQ==','2014-11-21 13:32:06'),('7bogbc3hgzatrwnct2gyt0ul52a5hlew','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 08:06:10'),('91fdml1te525h1w3l9b591oc9dqe5kyj','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-17 12:11:29'),('bs1eyelwc50gon2zv5e1zl0fxzd23zgf','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 07:22:01'),('c8ky5g3latp9l9a95leau9mxw9x1bxjz','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 07:21:52'),('ei7ldxtz6o5vg856zt4r3ru7ryym2rni','M2NkYWEzMGM2NDZmMjE5OGIxMzZkZmUxZGY2NmFkMDlmYTk5ZDVlNzp7ImN1cnJlbnRfdXNlciI6bnVsbH0=','2014-11-21 07:20:12'),('lpj92phcma68c0j8emfi31fnbbzclu1o','N2JjYTc4Mjk5ZDkwMDhmY2MzMmQ3MTRlZWQwNjljZjdiOThmZGY1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-11-17 12:13:38'),('m76l6lldaoivo8g606mkiam8v2g86sgy','N2I3MWUwMDMwMDEzN2RlMWQ4NzcwMjVmZjM5OWFmY2I1MDY3NmI5ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MSwiY3VycmVudF91c2VyIjoiYWRtaW4ifQ==','2014-12-02 01:45:02'),('o5y2y7y56xra2mdebe6f2nebsxxb767w','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 07:21:44'),('za6k6axqy4todmzsnsjxm7kqknniw6u8','Mjk0OTdmYmExOWQ1YmNiNGQzZGNiNzQ2OTA5MGU4YWQxYTRlMmVhNzp7fQ==','2014-11-21 07:21:39');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-18 10:25:55
