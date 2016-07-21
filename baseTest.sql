-- MySQL dump 10.16  Distrib 10.1.12-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: wcmstaging
-- ------------------------------------------------------
-- Server version	10.1.12-MariaDB

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
-- Table structure for table `accesslog`
--

DROP TABLE IF EXISTS `accesslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesslog` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique accesslog ID.',
  `sid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Browser session ID of user that visited page.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of page visited.',
  `path` varchar(255) DEFAULT NULL COMMENT 'Internal path to page visited (relative to Drupal root.)',
  `url` text COMMENT 'Referrer URI.',
  `hostname` varchar(128) DEFAULT NULL COMMENT 'Hostname of user that visited the page.',
  `uid` int(10) unsigned DEFAULT '0' COMMENT 'User users.uid that visited the page.',
  `timer` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Time in milliseconds that the page took to load.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the page was visited.',
  PRIMARY KEY (`aid`),
  KEY `accesslog_timestamp` (`timestamp`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores site access information for statistics.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accesslog`
--

LOCK TABLES `accesslog` WRITE;
/*!40000 ALTER TABLE `accesslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `accesslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES ('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky'),('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky'),('node_promote_action','node','node_promote_action','','Promote content to front page'),('node_publish_action','node','node_publish_action','','Publish content'),('node_save_action','node','node_save_action','','Save content'),('node_unpromote_action','node','node_unpromote_action','','Remove content from front page'),('node_unpublish_action','node','node_unpublish_action','','Unpublish content'),('pathauto_node_update_action','node','pathauto_node_update_action','','Update node alias'),('pathauto_taxonomy_term_update_action','taxonomy_term','pathauto_taxonomy_term_update_action','','Update taxonomy term alias'),('pathauto_user_update_action','user','pathauto_user_update_action','','Update user alias'),('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user'),('user_block_user_action','user','user_block_user_action','','Block current user');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authmap`
--

LOCK TABLES `authmap` WRITE;
/*!40000 ALTER TABLE `authmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `authmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=1262 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,'boxes','homepage_carousel_box','bartik',0,0,'-1',0,0,'','',-2),(2,'boxes','homepage_content_list','bartik',0,0,'-1',0,0,'','',-2),(3,'boxes','homepage_photos','bartik',0,0,'-1',0,0,'','',-2),(4,'boxes','homepage_slideshow_box','bartik',0,0,'-1',0,0,'','',-2),(5,'boxes','dhs_header_tagline','bartik',0,0,'-1',0,0,'','',-2),(6,'boxes','boxes_add__simple','bartik',0,0,'-1',0,0,'','',-2),(7,'boxes','boxes_add__alert_box','bartik',0,0,'-1',0,0,'','',-2),(8,'boxes','boxes_add__carousel_box','bartik',0,0,'-1',0,0,'','',-2),(9,'boxes','boxes_add__content_list_box','bartik',0,0,'-1',0,0,'','',-2),(10,'boxes','boxes_add__slideshow_box','bartik',0,0,'-1',0,0,'','',-2),(11,'boxes','boxes_add__photo_box','bartik',0,0,'-1',0,0,'','',-2),(12,'context_ui','editor','bartik',0,0,'-1',0,0,'','',1),(13,'delta_blocks','logo','bartik',0,0,'-1',0,0,'','',8),(14,'delta_blocks','site-name','bartik',0,0,'-1',0,0,'','',8),(15,'delta_blocks','site-slogan','bartik',0,0,'-1',0,0,'','',8),(16,'delta_blocks','branding','bartik',0,0,'-1',0,0,'','',8),(17,'delta_blocks','page-title','bartik',0,0,'-1',0,0,'','',4),(18,'delta_blocks','breadcrumb','bartik',0,0,'-1',0,0,'','',4),(19,'delta_blocks','tabs','bartik',0,0,'-1',0,0,'','',4),(20,'delta_blocks','messages','bartik',0,0,'-1',0,0,'','',-1),(21,'delta_blocks','action-links','bartik',0,0,'-1',0,0,'','',8),(22,'delta_blocks','feed-icons','bartik',0,0,'-1',0,0,'','',8),(23,'diff','inline','bartik',0,0,'-1',0,0,'','',1),(24,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1),(25,'node','recent','bartik',0,0,'-1',0,0,'','',1),(26,'search','form','bartik',0,0,'-1',0,0,'','',-1),(27,'shortcut','shortcuts','bartik',0,0,'-1',0,0,'','',-1),(28,'system','main','bartik',1,0,'content',0,1,'','',-1),(29,'system','powered-by','bartik',0,10,'-1',0,0,'','',-1),(30,'system','help','bartik',1,5,'help',0,0,'','',-1),(31,'system','navigation','bartik',0,0,'-1',0,0,'','',-1),(32,'system','management','bartik',0,0,'-1',0,0,'','',-1),(33,'system','user-menu','bartik',0,0,'-1',0,0,'','',-1),(34,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1),(35,'user','login','bartik',0,0,'-1',0,0,'','',-1),(36,'user','new','bartik',0,0,'-1',0,0,'','',1),(37,'user','online','bartik',0,0,'-1',0,0,'','',-1),(38,'workbench','block','bartik',1,-99,'content',0,0,'','',-1),(39,'views','photos-photo_homepage','bartik',0,0,'-1',0,0,'','',-1),(40,'views','press_releases-block_1','bartik',0,0,'-1',0,0,'','',-1),(41,'views','workbench_edited-block_1','bartik',0,0,'-1',0,0,'','',-1),(42,'views','workbench_current_user-block_1','bartik',0,0,'-1',0,0,'','',-1),(43,'views','9cf22433e0efbd8b206c8e4c2edb177c','bartik',0,0,'-1',0,0,'','',-1),(44,'boxes','homepage_carousel_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(45,'boxes','homepage_content_list','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(46,'boxes','homepage_photos','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(47,'boxes','homepage_slideshow_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(48,'boxes','dhs_header_tagline','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(49,'boxes','boxes_add__simple','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(50,'boxes','boxes_add__alert_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(51,'boxes','boxes_add__carousel_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(52,'boxes','boxes_add__content_list_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(53,'boxes','boxes_add__slideshow_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(54,'boxes','boxes_add__photo_box','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(55,'context_ui','editor','dhs_wcm_theme',0,0,'-1',0,0,'','',1),(56,'delta_blocks','logo','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(57,'delta_blocks','site-name','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(58,'delta_blocks','site-slogan','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(59,'delta_blocks','branding','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(60,'delta_blocks','page-title','dhs_wcm_theme',0,0,'-1',0,0,'','',4),(61,'delta_blocks','breadcrumb','dhs_wcm_theme',0,0,'-1',0,0,'','',4),(62,'delta_blocks','tabs','dhs_wcm_theme',0,0,'-1',0,0,'','',4),(63,'delta_blocks','messages','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(64,'delta_blocks','action-links','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(65,'delta_blocks','feed-icons','dhs_wcm_theme',0,0,'-1',0,0,'','',8),(66,'diff','inline','dhs_wcm_theme',0,0,'-1',0,0,'','',1),(67,'node','syndicate','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(68,'node','recent','dhs_wcm_theme',0,0,'-1',0,0,'','',1),(69,'search','form','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(70,'shortcut','shortcuts','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(71,'system','main','dhs_wcm_theme',1,0,'content',0,1,'','',-1),(72,'system','powered-by','dhs_wcm_theme',0,10,'-1',0,0,'','',-1),(73,'system','help','dhs_wcm_theme',1,5,'help',0,0,'','',-1),(74,'system','navigation','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(75,'system','management','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(76,'system','user-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(77,'system','main-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(78,'user','login','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(79,'user','new','dhs_wcm_theme',0,0,'-1',0,0,'','',1),(80,'user','online','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(81,'workbench','block','dhs_wcm_theme',1,-99,'content',0,0,'','',-1),(82,'views','photos-photo_homepage','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(83,'views','press_releases-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(84,'views','workbench_edited-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(85,'views','workbench_current_user-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(86,'views','9cf22433e0efbd8b206c8e4c2edb177c','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(87,'boxes','homepage_carousel_box','rubik',0,0,'-1',0,0,'','',-2),(88,'boxes','homepage_content_list','rubik',0,0,'-1',0,0,'','',-2),(89,'boxes','homepage_photos','rubik',0,0,'-1',0,0,'','',-2),(90,'boxes','homepage_slideshow_box','rubik',0,0,'-1',0,0,'','',-2),(91,'boxes','dhs_header_tagline','rubik',0,0,'-1',0,0,'','',-2),(92,'boxes','boxes_add__simple','rubik',0,0,'-1',0,0,'','',-2),(93,'boxes','boxes_add__alert_box','rubik',0,0,'-1',0,0,'','',-2),(94,'boxes','boxes_add__carousel_box','rubik',0,0,'-1',0,0,'','',-2),(95,'boxes','boxes_add__content_list_box','rubik',0,0,'-1',0,0,'','',-2),(96,'boxes','boxes_add__slideshow_box','rubik',0,0,'-1',0,0,'','',-2),(97,'boxes','boxes_add__photo_box','rubik',0,0,'-1',0,0,'','',-2),(98,'context_ui','editor','rubik',0,0,'-1',0,0,'','',1),(99,'delta_blocks','logo','rubik',0,0,'-1',0,0,'','',8),(100,'delta_blocks','site-name','rubik',0,0,'-1',0,0,'','',8),(101,'delta_blocks','site-slogan','rubik',0,0,'-1',0,0,'','',8),(102,'delta_blocks','branding','rubik',0,0,'-1',0,0,'','',8),(103,'delta_blocks','page-title','rubik',0,0,'-1',0,0,'','',4),(104,'delta_blocks','breadcrumb','rubik',0,0,'-1',0,0,'','',4),(105,'delta_blocks','tabs','rubik',0,0,'-1',0,0,'','',4),(106,'delta_blocks','messages','rubik',0,0,'-1',0,0,'','',-1),(107,'delta_blocks','action-links','rubik',0,0,'-1',0,0,'','',8),(108,'delta_blocks','feed-icons','rubik',0,0,'-1',0,0,'','',8),(109,'diff','inline','rubik',0,0,'-1',0,0,'','',1),(110,'node','syndicate','rubik',0,0,'-1',0,0,'','',-1),(111,'node','recent','rubik',1,0,'dashboard_inactive',0,0,'','',1),(112,'search','form','rubik',0,0,'-1',0,0,'','',-1),(113,'shortcut','shortcuts','rubik',0,0,'-1',0,0,'','',-1),(114,'system','main','rubik',1,0,'content',0,1,'','',-1),(115,'system','powered-by','rubik',0,10,'-1',0,0,'','',-1),(116,'system','help','rubik',1,5,'help',0,0,'','',-1),(117,'system','navigation','rubik',0,0,'-1',0,0,'','',-1),(118,'system','management','rubik',0,0,'-1',0,0,'','',-1),(119,'system','user-menu','rubik',0,0,'-1',0,0,'','',-1),(120,'system','main-menu','rubik',0,0,'-1',0,0,'','',-1),(121,'user','login','rubik',0,0,'-1',0,0,'','',-1),(122,'user','new','rubik',1,0,'dashboard_inactive',0,0,'','',1),(123,'user','online','rubik',1,0,'dashboard_inactive',0,0,'','',-1),(124,'workbench','block','rubik',1,-99,'content',0,0,'','',-1),(125,'views','photos-photo_homepage','rubik',0,0,'-1',0,0,'','',-1),(126,'views','press_releases-block_1','rubik',0,0,'-1',0,0,'','',-1),(127,'views','workbench_edited-block_1','rubik',0,0,'-1',0,0,'','',-1),(128,'views','workbench_current_user-block_1','rubik',0,0,'-1',0,0,'','',-1),(129,'views','9cf22433e0efbd8b206c8e4c2edb177c','rubik',0,0,'-1',0,0,'','',-1),(130,'boxes','homepage_carousel_box','seven',0,0,'-1',0,0,'','',-2),(131,'boxes','homepage_content_list','seven',0,0,'-1',0,0,'','',-2),(132,'boxes','homepage_photos','seven',0,0,'-1',0,0,'','',-2),(133,'boxes','homepage_slideshow_box','seven',0,0,'-1',0,0,'','',-2),(134,'boxes','dhs_header_tagline','seven',0,0,'-1',0,0,'','',-2),(135,'boxes','boxes_add__simple','seven',0,0,'-1',0,0,'','',-2),(136,'boxes','boxes_add__alert_box','seven',0,0,'-1',0,0,'','',-2),(137,'boxes','boxes_add__carousel_box','seven',0,0,'-1',0,0,'','',-2),(138,'boxes','boxes_add__content_list_box','seven',0,0,'-1',0,0,'','',-2),(139,'boxes','boxes_add__slideshow_box','seven',0,0,'-1',0,0,'','',-2),(140,'boxes','boxes_add__photo_box','seven',0,0,'-1',0,0,'','',-2),(141,'context_ui','editor','seven',0,0,'-1',0,0,'','',1),(142,'delta_blocks','logo','seven',0,0,'-1',0,0,'','',8),(143,'delta_blocks','site-name','seven',0,0,'-1',0,0,'','',8),(144,'delta_blocks','site-slogan','seven',0,0,'-1',0,0,'','',8),(145,'delta_blocks','branding','seven',0,0,'-1',0,0,'','',8),(146,'delta_blocks','page-title','seven',0,0,'-1',0,0,'','',4),(147,'delta_blocks','breadcrumb','seven',0,0,'-1',0,0,'','',4),(148,'delta_blocks','tabs','seven',0,0,'-1',0,0,'','',4),(149,'delta_blocks','messages','seven',0,0,'-1',0,0,'','',-1),(150,'delta_blocks','action-links','seven',0,0,'-1',0,0,'','',8),(151,'delta_blocks','feed-icons','seven',0,0,'-1',0,0,'','',8),(152,'diff','inline','seven',0,0,'-1',0,0,'','',1),(153,'node','syndicate','seven',0,0,'-1',0,0,'','',-1),(154,'node','recent','seven',1,0,'dashboard_inactive',0,0,'','',1),(155,'search','form','seven',1,0,'dashboard_inactive',0,0,'','',-1),(156,'shortcut','shortcuts','seven',0,0,'-1',0,0,'','',-1),(157,'system','main','seven',1,0,'content',0,1,'','',-1),(158,'system','powered-by','seven',0,10,'-1',0,0,'','',-1),(159,'system','help','seven',1,5,'help',0,0,'','',-1),(160,'system','navigation','seven',0,0,'-1',0,0,'','',-1),(161,'system','management','seven',0,0,'-1',0,0,'','',-1),(162,'system','user-menu','seven',0,0,'-1',0,0,'','',-1),(163,'system','main-menu','seven',0,0,'-1',0,0,'','',-1),(164,'user','login','seven',0,0,'-1',0,0,'','',-1),(165,'user','new','seven',1,0,'dashboard_inactive',0,0,'','',1),(166,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1),(167,'workbench','block','seven',1,-99,'content',0,0,'','',-1),(168,'views','photos-photo_homepage','seven',0,0,'-1',0,0,'','',-1),(169,'views','press_releases-block_1','seven',0,0,'-1',0,0,'','',-1),(170,'views','workbench_edited-block_1','seven',0,0,'-1',0,0,'','',-1),(171,'views','workbench_current_user-block_1','seven',0,0,'-1',0,0,'','',-1),(172,'views','9cf22433e0efbd8b206c8e4c2edb177c','seven',0,0,'-1',0,0,'','',-1),(173,'menu','devel','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(174,'menu','features','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(175,'menu','menu-process-view','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(176,'menu','menu-swa-resources-side-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(177,'menu','menu-sdlc-topics','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(178,'menu','menu-swa-about-side-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(179,'menu','menu-swa-forums-groups-side-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(180,'menu','menu-swa-main-menu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(181,'views','-exp-taxonomy_term-page','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(182,'views','bsi_articles-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(183,'views','resource_taxonomy_views-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(184,'views','resource_taxonomy_views-block_2','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(185,'views','resource_taxonomy_views-block_3','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(186,'views','resource_taxonomy_views-block_4','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(187,'views','resource_taxonomy_views-block_5','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(188,'views','events-block','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(189,'views','events-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(190,'views','bsi_announcements-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(191,'views','swa_announcements-block','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(192,'views','swa_forums-block','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(193,'views','swa_forums-block_1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(194,'views','8bcb1ab8ea4a6383f40249f2b7a64176','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(195,'views','dfbd37967da2fdca43aa241d0cb2b5fc','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(196,'views','751912289a8f1c0f6624e2c2fc19957f','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(197,'views','5366122fdf77e52e6440b93e647ed375','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(198,'views','4bf579a58bcbb33486a0aa98b50751cf','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(199,'views','89edc31699609e524429d894943e5992','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(200,'views','5a61e3fc8c8a668a285cd87d304f95f1','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(201,'views','4302e30776901a401ce27932ef240920','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(202,'views','9f9bbca182fd063d662c2578bfb5800c','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(203,'menu','devel','bartik',0,0,'-1',0,0,'','',-1),(204,'menu','features','bartik',0,0,'-1',0,0,'','',-1),(205,'menu','menu-process-view','bartik',0,0,'-1',0,0,'','',-1),(206,'menu','menu-swa-resources-side-menu','bartik',0,0,'-1',0,0,'','',-1),(207,'menu','menu-sdlc-topics','bartik',0,0,'-1',0,0,'','',-1),(208,'menu','menu-swa-about-side-menu','bartik',0,0,'-1',0,0,'','',-1),(209,'menu','menu-swa-forums-groups-side-menu','bartik',0,0,'-1',0,0,'','',-1),(210,'menu','menu-swa-main-menu','bartik',0,0,'-1',0,0,'','',-1),(211,'views','-exp-taxonomy_term-page','bartik',0,0,'-1',0,0,'','',-1),(212,'views','bsi_articles-block_1','bartik',0,0,'-1',0,0,'','',-1),(213,'views','resource_taxonomy_views-block_1','bartik',0,0,'-1',0,0,'','',-1),(214,'views','resource_taxonomy_views-block_2','bartik',0,0,'-1',0,0,'','',-1),(215,'views','resource_taxonomy_views-block_3','bartik',0,0,'-1',0,0,'','',-1),(216,'views','resource_taxonomy_views-block_4','bartik',0,0,'-1',0,0,'','',-1),(217,'views','resource_taxonomy_views-block_5','bartik',0,0,'-1',0,0,'','',-1),(218,'views','events-block','bartik',0,0,'-1',0,0,'','',-1),(219,'views','events-block_1','bartik',0,0,'-1',0,0,'','',-1),(220,'views','bsi_announcements-block_1','bartik',0,0,'-1',0,0,'','',-1),(221,'views','swa_announcements-block','bartik',0,0,'-1',0,0,'','',-1),(222,'views','swa_forums-block','bartik',0,0,'-1',0,0,'','',-1),(223,'views','swa_forums-block_1','bartik',0,0,'-1',0,0,'','',-1),(224,'views','8bcb1ab8ea4a6383f40249f2b7a64176','bartik',0,0,'-1',0,0,'','',-1),(225,'views','dfbd37967da2fdca43aa241d0cb2b5fc','bartik',0,0,'-1',0,0,'','',-1),(226,'views','751912289a8f1c0f6624e2c2fc19957f','bartik',0,0,'-1',0,0,'','',-1),(227,'views','5366122fdf77e52e6440b93e647ed375','bartik',0,0,'-1',0,0,'','',-1),(228,'views','4bf579a58bcbb33486a0aa98b50751cf','bartik',0,0,'-1',0,0,'','',-1),(229,'views','89edc31699609e524429d894943e5992','bartik',0,0,'-1',0,0,'','',-1),(230,'views','5a61e3fc8c8a668a285cd87d304f95f1','bartik',0,0,'-1',0,0,'','',-1),(231,'views','4302e30776901a401ce27932ef240920','bartik',0,0,'-1',0,0,'','',-1),(232,'views','9f9bbca182fd063d662c2578bfb5800c','bartik',0,0,'-1',0,0,'','',-1),(233,'menu','devel','rubik',0,0,'-1',0,0,'','',-1),(234,'menu','features','rubik',0,0,'-1',0,0,'','',-1),(235,'menu','menu-process-view','rubik',0,0,'-1',0,0,'','',-1),(236,'menu','menu-swa-resources-side-menu','rubik',0,0,'-1',0,0,'','',-1),(237,'menu','menu-sdlc-topics','rubik',0,0,'-1',0,0,'','',-1),(238,'menu','menu-swa-about-side-menu','rubik',0,0,'-1',0,0,'','',-1),(239,'menu','menu-swa-forums-groups-side-menu','rubik',0,0,'-1',0,0,'','',-1),(240,'menu','menu-swa-main-menu','rubik',0,0,'-1',0,0,'','',-1),(241,'views','-exp-taxonomy_term-page','rubik',0,0,'-1',0,0,'','',-1),(242,'views','bsi_articles-block_1','rubik',0,0,'-1',0,0,'','',-1),(243,'views','resource_taxonomy_views-block_1','rubik',0,0,'-1',0,0,'','',-1),(244,'views','resource_taxonomy_views-block_2','rubik',0,0,'-1',0,0,'','',-1),(245,'views','resource_taxonomy_views-block_3','rubik',0,0,'-1',0,0,'','',-1),(246,'views','resource_taxonomy_views-block_4','rubik',0,0,'-1',0,0,'','',-1),(247,'views','resource_taxonomy_views-block_5','rubik',0,0,'-1',0,0,'','',-1),(248,'views','events-block','rubik',0,0,'-1',0,0,'','',-1),(249,'views','events-block_1','rubik',0,0,'-1',0,0,'','',-1),(250,'views','bsi_announcements-block_1','rubik',0,0,'-1',0,0,'','',-1),(251,'views','swa_announcements-block','rubik',0,0,'-1',0,0,'','',-1),(252,'views','swa_forums-block','rubik',0,0,'-1',0,0,'','',-1),(253,'views','swa_forums-block_1','rubik',0,0,'-1',0,0,'','',-1),(254,'views','8bcb1ab8ea4a6383f40249f2b7a64176','rubik',0,0,'-1',0,0,'','',-1),(255,'views','dfbd37967da2fdca43aa241d0cb2b5fc','rubik',0,0,'-1',0,0,'','',-1),(256,'views','751912289a8f1c0f6624e2c2fc19957f','rubik',0,0,'-1',0,0,'','',-1),(257,'views','5366122fdf77e52e6440b93e647ed375','rubik',0,0,'-1',0,0,'','',-1),(258,'views','4bf579a58bcbb33486a0aa98b50751cf','rubik',0,0,'-1',0,0,'','',-1),(259,'views','89edc31699609e524429d894943e5992','rubik',0,0,'-1',0,0,'','',-1),(260,'views','5a61e3fc8c8a668a285cd87d304f95f1','rubik',0,0,'-1',0,0,'','',-1),(261,'views','4302e30776901a401ce27932ef240920','rubik',0,0,'-1',0,0,'','',-1),(262,'views','9f9bbca182fd063d662c2578bfb5800c','rubik',0,0,'-1',0,0,'','',-1),(263,'menu','devel','seven',0,0,'-1',0,0,'','',-1),(264,'menu','features','seven',0,0,'-1',0,0,'','',-1),(265,'menu','menu-process-view','seven',0,0,'-1',0,0,'','',-1),(266,'menu','menu-swa-resources-side-menu','seven',0,0,'-1',0,0,'','',-1),(267,'menu','menu-sdlc-topics','seven',0,0,'-1',0,0,'','',-1),(268,'menu','menu-swa-about-side-menu','seven',0,0,'-1',0,0,'','',-1),(269,'menu','menu-swa-forums-groups-side-menu','seven',0,0,'-1',0,0,'','',-1),(270,'menu','menu-swa-main-menu','seven',0,0,'-1',0,0,'','',-1),(271,'views','-exp-taxonomy_term-page','seven',0,0,'-1',0,0,'','',-1),(272,'views','bsi_articles-block_1','seven',0,0,'-1',0,0,'','',-1),(273,'views','resource_taxonomy_views-block_1','seven',0,0,'-1',0,0,'','',-1),(274,'views','resource_taxonomy_views-block_2','seven',0,0,'-1',0,0,'','',-1),(275,'views','resource_taxonomy_views-block_3','seven',0,0,'-1',0,0,'','',-1),(276,'views','resource_taxonomy_views-block_4','seven',0,0,'-1',0,0,'','',-1),(277,'views','resource_taxonomy_views-block_5','seven',0,0,'-1',0,0,'','',-1),(278,'views','events-block','seven',0,0,'-1',0,0,'','',-1),(279,'views','events-block_1','seven',0,0,'-1',0,0,'','',-1),(280,'views','bsi_announcements-block_1','seven',0,0,'-1',0,0,'','',-1),(281,'views','swa_announcements-block','seven',0,0,'-1',0,0,'','',-1),(282,'views','swa_forums-block','seven',0,0,'-1',0,0,'','',-1),(283,'views','swa_forums-block_1','seven',0,0,'-1',0,0,'','',-1),(284,'views','8bcb1ab8ea4a6383f40249f2b7a64176','seven',0,0,'-1',0,0,'','',-1),(285,'views','dfbd37967da2fdca43aa241d0cb2b5fc','seven',0,0,'-1',0,0,'','',-1),(286,'views','751912289a8f1c0f6624e2c2fc19957f','seven',0,0,'-1',0,0,'','',-1),(287,'views','5366122fdf77e52e6440b93e647ed375','seven',0,0,'-1',0,0,'','',-1),(288,'views','4bf579a58bcbb33486a0aa98b50751cf','seven',0,0,'-1',0,0,'','',-1),(289,'views','89edc31699609e524429d894943e5992','seven',0,0,'-1',0,0,'','',-1),(290,'views','5a61e3fc8c8a668a285cd87d304f95f1','seven',0,0,'-1',0,0,'','',-1),(291,'views','4302e30776901a401ce27932ef240920','seven',0,0,'-1',0,0,'','',-1),(292,'views','9f9bbca182fd063d662c2578bfb5800c','seven',0,0,'-1',0,0,'','',-1),(295,'boxes','boxes_add__alert_box','openomega',0,0,'-1',0,0,'','',-2),(298,'boxes','boxes_add__carousel_box','openomega',0,0,'-1',0,0,'','',-2),(301,'boxes','boxes_add__content_list_box','openomega',0,0,'-1',0,0,'','',-2),(304,'boxes','boxes_add__photo_box','openomega',0,0,'-1',0,0,'','',-2),(307,'boxes','boxes_add__simple','openomega',0,0,'-1',0,0,'','',-2),(310,'boxes','boxes_add__slideshow_box','openomega',0,0,'-1',0,0,'','',-2),(313,'boxes','dhs_header_tagline','openomega',0,0,'-1',0,0,'','',-2),(316,'boxes','homepage_carousel_box','openomega',0,0,'-1',0,0,'','',-2),(319,'boxes','homepage_content_list','openomega',0,0,'-1',0,0,'','',-2),(322,'boxes','homepage_photos','openomega',0,0,'-1',0,0,'','',-2),(325,'boxes','homepage_slideshow_box','openomega',0,0,'-1',0,0,'','',-2),(328,'context_ui','editor','openomega',0,0,'-1',0,0,'','',1),(331,'delta_blocks','action-links','openomega',0,0,'-1',0,0,'','',8),(334,'delta_blocks','branding','openomega',0,0,'-1',0,0,'','',8),(337,'delta_blocks','breadcrumb','openomega',0,0,'-1',0,0,'','',4),(340,'delta_blocks','feed-icons','openomega',0,0,'-1',0,0,'','',8),(343,'delta_blocks','logo','openomega',0,0,'-1',0,0,'','',8),(346,'delta_blocks','messages','openomega',0,0,'-1',0,0,'','',-1),(349,'delta_blocks','page-title','openomega',0,0,'-1',0,0,'','',4),(352,'delta_blocks','site-name','openomega',0,0,'-1',0,0,'','',8),(355,'delta_blocks','site-slogan','openomega',0,0,'-1',0,0,'','',8),(358,'delta_blocks','tabs','openomega',0,0,'-1',0,0,'','',4),(361,'diff','inline','openomega',0,0,'-1',0,0,'','',1),(364,'menu','devel','openomega',0,0,'-1',0,0,'','',-1),(367,'menu','features','openomega',0,0,'-1',0,0,'','',-1),(370,'menu','menu-process-view','openomega',0,0,'-1',0,0,'','',-1),(373,'menu','menu-sdlc-topics','openomega',0,0,'-1',0,0,'','',-1),(376,'menu','menu-swa-about-side-menu','openomega',0,0,'-1',0,0,'','',-1),(379,'menu','menu-swa-forums-groups-side-menu','openomega',0,0,'-1',0,0,'','',-1),(382,'menu','menu-swa-main-menu','openomega',0,0,'-1',0,0,'','',-1),(385,'menu','menu-swa-resources-side-menu','openomega',0,0,'-1',0,0,'','',-1),(388,'node','recent','openomega',0,0,'-1',0,0,'','',1),(391,'node','syndicate','openomega',0,0,'-1',0,0,'','',-1),(394,'search','form','openomega',0,0,'-1',0,0,'','',-1),(397,'shortcut','shortcuts','openomega',0,0,'-1',0,0,'','',-1),(400,'system','help','openomega',1,-16,'header_first',0,0,'','',-1),(403,'system','main','openomega',1,-17,'content',0,1,'','',-1),(406,'system','main-menu','openomega',0,0,'-1',0,0,'','',-1),(409,'system','management','openomega',0,0,'-1',0,0,'','',-1),(412,'system','navigation','openomega',0,0,'-1',0,0,'','',-1),(415,'system','powered-by','openomega',0,10,'-1',0,0,'','',-1),(418,'system','user-menu','openomega',0,0,'-1',0,0,'','',-1),(421,'user','login','openomega',0,0,'-1',0,0,'','',-1),(424,'user','new','openomega',0,0,'-1',0,0,'','',1),(427,'user','online','openomega',0,0,'-1',0,0,'','',-1),(430,'views','-exp-taxonomy_term-page','openomega',0,0,'-1',0,0,'','',-1),(433,'views','4302e30776901a401ce27932ef240920','openomega',0,0,'-1',0,0,'','',-1),(436,'views','4bf579a58bcbb33486a0aa98b50751cf','openomega',0,0,'-1',0,0,'','',-1),(439,'views','5366122fdf77e52e6440b93e647ed375','openomega',0,0,'-1',0,0,'','',-1),(442,'views','5a61e3fc8c8a668a285cd87d304f95f1','openomega',0,0,'-1',0,0,'','',-1),(445,'views','751912289a8f1c0f6624e2c2fc19957f','openomega',0,0,'-1',0,0,'','',-1),(448,'views','89edc31699609e524429d894943e5992','openomega',0,0,'-1',0,0,'','',-1),(451,'views','8bcb1ab8ea4a6383f40249f2b7a64176','openomega',0,0,'-1',0,0,'','',-1),(454,'views','9cf22433e0efbd8b206c8e4c2edb177c','openomega',0,0,'-1',0,0,'','',-1),(457,'views','9f9bbca182fd063d662c2578bfb5800c','openomega',0,0,'-1',0,0,'','',-1),(460,'views','bsi_announcements-block_1','openomega',0,0,'-1',0,0,'','',-1),(463,'views','bsi_articles-block_1','openomega',0,0,'-1',0,0,'','',-1),(466,'views','dfbd37967da2fdca43aa241d0cb2b5fc','openomega',0,0,'-1',0,0,'','',-1),(469,'views','events-block','openomega',0,0,'-1',0,0,'','',-1),(472,'views','events-block_1','openomega',0,0,'-1',0,0,'','',-1),(475,'views','photos-photo_homepage','openomega',0,0,'-1',0,0,'','',-1),(478,'views','press_releases-block_1','openomega',0,0,'-1',0,0,'','',-1),(481,'views','resource_taxonomy_views-block_1','openomega',0,0,'-1',0,0,'','',-1),(484,'views','resource_taxonomy_views-block_2','openomega',0,0,'-1',0,0,'','',-1),(487,'views','resource_taxonomy_views-block_3','openomega',0,0,'-1',0,0,'','',-1),(490,'views','resource_taxonomy_views-block_4','openomega',0,0,'-1',0,0,'','',-1),(493,'views','resource_taxonomy_views-block_5','openomega',0,0,'-1',0,0,'','',-1),(496,'views','swa_announcements-block','openomega',0,0,'-1',0,0,'','',-1),(499,'views','swa_forums-block','openomega',0,0,'-1',0,0,'','',-1),(502,'views','swa_forums-block_1','openomega',0,0,'-1',0,0,'','',-1),(505,'views','workbench_current_user-block_1','openomega',0,0,'-1',0,0,'','',-1),(508,'views','workbench_edited-block_1','openomega',0,0,'-1',0,0,'','',-1),(511,'workbench','block','openomega',0,-18,'-1',0,0,'','',-1),(514,'boxes','boxes_add__alert_box','tao',0,0,'-1',0,0,'','',-2),(517,'boxes','boxes_add__carousel_box','tao',0,0,'-1',0,0,'','',-2),(520,'boxes','boxes_add__content_list_box','tao',0,0,'-1',0,0,'','',-2),(523,'boxes','boxes_add__photo_box','tao',0,0,'-1',0,0,'','',-2),(526,'boxes','boxes_add__simple','tao',0,0,'-1',0,0,'','',-2),(529,'boxes','boxes_add__slideshow_box','tao',0,0,'-1',0,0,'','',-2),(532,'boxes','dhs_header_tagline','tao',0,0,'-1',0,0,'','',-2),(535,'boxes','homepage_carousel_box','tao',0,0,'-1',0,0,'','',-2),(538,'boxes','homepage_content_list','tao',0,0,'-1',0,0,'','',-2),(541,'boxes','homepage_photos','tao',0,0,'-1',0,0,'','',-2),(544,'boxes','homepage_slideshow_box','tao',0,0,'-1',0,0,'','',-2),(547,'context_ui','editor','tao',0,0,'-1',0,0,'','',1),(550,'delta_blocks','action-links','tao',0,0,'-1',0,0,'','',8),(553,'delta_blocks','branding','tao',0,0,'-1',0,0,'','',8),(556,'delta_blocks','breadcrumb','tao',0,0,'-1',0,0,'','',4),(559,'delta_blocks','feed-icons','tao',0,0,'-1',0,0,'','',8),(562,'delta_blocks','logo','tao',0,0,'-1',0,0,'','',8),(565,'delta_blocks','messages','tao',0,0,'-1',0,0,'','',-1),(568,'delta_blocks','page-title','tao',0,0,'-1',0,0,'','',4),(571,'delta_blocks','site-name','tao',0,0,'-1',0,0,'','',8),(574,'delta_blocks','site-slogan','tao',0,0,'-1',0,0,'','',8),(577,'delta_blocks','tabs','tao',0,0,'-1',0,0,'','',4),(580,'diff','inline','tao',0,0,'-1',0,0,'','',1),(583,'menu','devel','tao',0,0,'-1',0,0,'','',-1),(586,'menu','features','tao',0,0,'-1',0,0,'','',-1),(589,'menu','menu-process-view','tao',0,0,'-1',0,0,'','',-1),(592,'menu','menu-sdlc-topics','tao',0,0,'-1',0,0,'','',-1),(595,'menu','menu-swa-about-side-menu','tao',0,0,'-1',0,0,'','',-1),(598,'menu','menu-swa-forums-groups-side-menu','tao',0,0,'-1',0,0,'','',-1),(601,'menu','menu-swa-main-menu','tao',0,0,'-1',0,0,'','',-1),(604,'menu','menu-swa-resources-side-menu','tao',0,0,'-1',0,0,'','',-1),(607,'node','recent','tao',0,0,'-1',0,0,'','',1),(610,'node','syndicate','tao',0,0,'-1',0,0,'','',-1),(613,'search','form','tao',0,0,'-1',0,0,'','',-1),(616,'shortcut','shortcuts','tao',0,0,'-1',0,0,'','',-1),(619,'system','help','tao',1,5,'help',0,0,'','',-1),(622,'system','main','tao',1,0,'content',0,1,'','',-1),(625,'system','main-menu','tao',0,0,'-1',0,0,'','',-1),(628,'system','management','tao',0,0,'-1',0,0,'','',-1),(631,'system','navigation','tao',0,0,'-1',0,0,'','',-1),(634,'system','powered-by','tao',0,10,'-1',0,0,'','',-1),(637,'system','user-menu','tao',0,0,'-1',0,0,'','',-1),(640,'user','login','tao',0,0,'-1',0,0,'','',-1),(643,'user','new','tao',0,0,'-1',0,0,'','',1),(646,'user','online','tao',0,0,'-1',0,0,'','',-1),(649,'views','-exp-taxonomy_term-page','tao',0,0,'-1',0,0,'','',-1),(652,'views','4302e30776901a401ce27932ef240920','tao',0,0,'-1',0,0,'','',-1),(655,'views','4bf579a58bcbb33486a0aa98b50751cf','tao',0,0,'-1',0,0,'','',-1),(658,'views','5366122fdf77e52e6440b93e647ed375','tao',0,0,'-1',0,0,'','',-1),(661,'views','5a61e3fc8c8a668a285cd87d304f95f1','tao',0,0,'-1',0,0,'','',-1),(664,'views','751912289a8f1c0f6624e2c2fc19957f','tao',0,0,'-1',0,0,'','',-1),(667,'views','89edc31699609e524429d894943e5992','tao',0,0,'-1',0,0,'','',-1),(670,'views','8bcb1ab8ea4a6383f40249f2b7a64176','tao',0,0,'-1',0,0,'','',-1),(673,'views','9cf22433e0efbd8b206c8e4c2edb177c','tao',0,0,'-1',0,0,'','',-1),(676,'views','9f9bbca182fd063d662c2578bfb5800c','tao',0,0,'-1',0,0,'','',-1),(679,'views','bsi_announcements-block_1','tao',0,0,'-1',0,0,'','',-1),(682,'views','bsi_articles-block_1','tao',0,0,'-1',0,0,'','',-1),(685,'views','dfbd37967da2fdca43aa241d0cb2b5fc','tao',0,0,'-1',0,0,'','',-1),(688,'views','events-block','tao',0,0,'-1',0,0,'','',-1),(691,'views','events-block_1','tao',0,0,'-1',0,0,'','',-1),(694,'views','photos-photo_homepage','tao',0,0,'-1',0,0,'','',-1),(697,'views','press_releases-block_1','tao',0,0,'-1',0,0,'','',-1),(700,'views','resource_taxonomy_views-block_1','tao',0,0,'-1',0,0,'','',-1),(703,'views','resource_taxonomy_views-block_2','tao',0,0,'-1',0,0,'','',-1),(706,'views','resource_taxonomy_views-block_3','tao',0,0,'-1',0,0,'','',-1),(709,'views','resource_taxonomy_views-block_4','tao',0,0,'-1',0,0,'','',-1),(712,'views','resource_taxonomy_views-block_5','tao',0,0,'-1',0,0,'','',-1),(715,'views','swa_announcements-block','tao',0,0,'-1',0,0,'','',-1),(718,'views','swa_forums-block','tao',0,0,'-1',0,0,'','',-1),(721,'views','swa_forums-block_1','tao',0,0,'-1',0,0,'','',-1),(724,'views','workbench_current_user-block_1','tao',0,0,'-1',0,0,'','',-1),(727,'views','workbench_edited-block_1','tao',0,0,'-1',0,0,'','',-1),(730,'workbench','block','tao',1,-99,'content',0,0,'','',-1),(733,'locale','language','bartik',0,0,'-1',0,0,'','',-1),(736,'locale','language','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(739,'locale','language','openomega',0,0,'-1',0,0,'','',-1),(742,'locale','language','rubik',0,0,'-1',0,0,'','',-1),(745,'locale','language','seven',0,0,'-1',0,0,'','',-1),(748,'locale','language','tao',0,0,'-1',0,0,'','',-1),(750,'boxes','boxes_add__node_reference','dhs_wcm_theme',0,0,'-1',0,0,'','',-2),(753,'boxes','boxes_add__node_reference','bartik',0,0,'-1',0,0,'','',-2),(756,'boxes','boxes_add__node_reference','openomega',0,0,'-1',0,0,'','',-2),(759,'boxes','boxes_add__node_reference','rubik',0,0,'-1',0,0,'','',-2),(762,'boxes','boxes_add__node_reference','seven',0,0,'-1',0,0,'','',-2),(765,'boxes','boxes_add__node_reference','tao',0,0,'-1',0,0,'','',-2),(767,'boost','status','bartik',0,0,'-1',0,0,'','',-1),(770,'boost','status','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(773,'boost','status','openomega',0,0,'-1',0,0,'','',-1),(776,'boost','status','rubik',0,0,'-1',0,0,'','',-1),(779,'boost','status','seven',0,0,'-1',0,0,'','',-1),(782,'boost','status','tao',0,0,'-1',0,0,'','',-1),(784,'menu','menu-sidemenu','bartik',0,0,'-1',0,0,'','',-1),(787,'menu','menu-sidemenu','dhs_wcm_theme',0,0,'-1',0,0,'','',-1),(790,'menu','menu-sidemenu','openomega',1,-15,'sidebar_first',0,0,'','',-1),(793,'menu','menu-sidemenu','rubik',0,0,'-1',0,0,'','',-1),(796,'menu','menu-sidemenu','seven',0,0,'-1',0,0,'','',-1),(799,'menu','menu-sidemenu','tao',0,0,'-1',0,0,'','',-1),(802,'boost','status','nmc_test_page',0,0,'-1',0,0,'','',-1),(805,'boxes','boxes_add__alert_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(808,'boxes','boxes_add__carousel_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(811,'boxes','boxes_add__content_list_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(814,'boxes','boxes_add__node_reference','nmc_test_page',0,0,'-1',0,0,'','',-2),(817,'boxes','boxes_add__photo_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(820,'boxes','boxes_add__simple','nmc_test_page',0,0,'-1',0,0,'','',-2),(823,'boxes','boxes_add__slideshow_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(826,'boxes','dhs_header_tagline','nmc_test_page',0,0,'-1',0,0,'','',-2),(829,'boxes','homepage_carousel_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(832,'boxes','homepage_content_list','nmc_test_page',0,0,'-1',0,0,'','',-2),(835,'boxes','homepage_photos','nmc_test_page',0,0,'-1',0,0,'','',-2),(838,'boxes','homepage_slideshow_box','nmc_test_page',0,0,'-1',0,0,'','',-2),(841,'context_ui','editor','nmc_test_page',0,0,'-1',0,0,'','',1),(844,'delta_blocks','action-links','nmc_test_page',0,0,'-1',0,0,'','',8),(847,'delta_blocks','branding','nmc_test_page',0,0,'-1',0,0,'','',8),(850,'delta_blocks','breadcrumb','nmc_test_page',0,0,'-1',0,0,'','',4),(853,'delta_blocks','feed-icons','nmc_test_page',0,0,'-1',0,0,'','',8),(856,'delta_blocks','logo','nmc_test_page',0,0,'-1',0,0,'','',8),(859,'delta_blocks','messages','nmc_test_page',0,0,'-1',0,0,'','',-1),(862,'delta_blocks','page-title','nmc_test_page',0,0,'-1',0,0,'','',4),(865,'delta_blocks','site-name','nmc_test_page',0,0,'-1',0,0,'','',8),(868,'delta_blocks','site-slogan','nmc_test_page',0,0,'-1',0,0,'','',8),(871,'delta_blocks','tabs','nmc_test_page',0,0,'-1',0,0,'','',4),(874,'diff','inline','nmc_test_page',0,0,'-1',0,0,'','',1),(877,'locale','language','nmc_test_page',0,0,'-1',0,0,'','',-1),(880,'menu','devel','nmc_test_page',0,0,'-1',0,0,'','',-1),(883,'menu','features','nmc_test_page',0,0,'-1',0,0,'','',-1),(886,'menu','menu-process-view','nmc_test_page',0,0,'-1',0,0,'','',-1),(889,'menu','menu-sdlc-topics','nmc_test_page',0,0,'-1',0,0,'','',-1),(892,'menu','menu-sidemenu','nmc_test_page',0,-15,'-1',0,0,'','',-1),(895,'menu','menu-swa-about-side-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(898,'menu','menu-swa-forums-groups-side-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(901,'menu','menu-swa-main-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(904,'menu','menu-swa-resources-side-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(907,'node','recent','nmc_test_page',0,0,'-1',0,0,'','',1),(910,'node','syndicate','nmc_test_page',0,0,'-1',0,0,'','',-1),(913,'search','form','nmc_test_page',0,0,'-1',0,0,'','',-1),(916,'shortcut','shortcuts','nmc_test_page',0,0,'-1',0,0,'','',-1),(919,'system','help','nmc_test_page',0,-16,'-1',0,0,'','',-1),(922,'system','main','nmc_test_page',0,-17,'-1',0,1,'','',-1),(925,'system','main-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(928,'system','management','nmc_test_page',0,0,'-1',0,0,'','',-1),(931,'system','navigation','nmc_test_page',0,0,'-1',0,0,'','',-1),(934,'system','powered-by','nmc_test_page',0,10,'-1',0,0,'','',-1),(937,'system','user-menu','nmc_test_page',0,0,'-1',0,0,'','',-1),(940,'user','login','nmc_test_page',0,0,'-1',0,0,'','',-1),(943,'user','new','nmc_test_page',0,0,'-1',0,0,'','',1),(946,'user','online','nmc_test_page',0,0,'-1',0,0,'','',-1),(949,'views','-exp-taxonomy_term-page','nmc_test_page',0,0,'-1',0,0,'','',-1),(952,'views','4302e30776901a401ce27932ef240920','nmc_test_page',0,0,'-1',0,0,'','',-1),(955,'views','4bf579a58bcbb33486a0aa98b50751cf','nmc_test_page',0,0,'-1',0,0,'','',-1),(958,'views','5366122fdf77e52e6440b93e647ed375','nmc_test_page',0,0,'-1',0,0,'','',-1),(961,'views','5a61e3fc8c8a668a285cd87d304f95f1','nmc_test_page',0,0,'-1',0,0,'','',-1),(964,'views','751912289a8f1c0f6624e2c2fc19957f','nmc_test_page',0,0,'-1',0,0,'','',-1),(967,'views','89edc31699609e524429d894943e5992','nmc_test_page',0,0,'-1',0,0,'','',-1),(970,'views','8bcb1ab8ea4a6383f40249f2b7a64176','nmc_test_page',0,0,'-1',0,0,'','',-1),(973,'views','9cf22433e0efbd8b206c8e4c2edb177c','nmc_test_page',0,0,'-1',0,0,'','',-1),(976,'views','9f9bbca182fd063d662c2578bfb5800c','nmc_test_page',0,0,'-1',0,0,'','',-1),(979,'views','bsi_announcements-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(982,'views','bsi_articles-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(985,'views','dfbd37967da2fdca43aa241d0cb2b5fc','nmc_test_page',0,0,'-1',0,0,'','',-1),(988,'views','events-block','nmc_test_page',0,0,'-1',0,0,'','',-1),(991,'views','events-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(994,'views','photos-photo_homepage','nmc_test_page',0,0,'-1',0,0,'','',-1),(997,'views','press_releases-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(1000,'views','resource_taxonomy_views-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(1003,'views','resource_taxonomy_views-block_2','nmc_test_page',0,0,'-1',0,0,'','',-1),(1006,'views','resource_taxonomy_views-block_3','nmc_test_page',0,0,'-1',0,0,'','',-1),(1009,'views','resource_taxonomy_views-block_4','nmc_test_page',0,0,'-1',0,0,'','',-1),(1012,'views','resource_taxonomy_views-block_5','nmc_test_page',0,0,'-1',0,0,'','',-1),(1015,'views','swa_announcements-block','nmc_test_page',0,0,'-1',0,0,'','',-1),(1018,'views','swa_forums-block','nmc_test_page',0,0,'-1',0,0,'','',-1),(1021,'views','swa_forums-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(1024,'views','workbench_current_user-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(1027,'views','workbench_edited-block_1','nmc_test_page',0,0,'-1',0,0,'','',-1),(1030,'workbench','block','nmc_test_page',0,-18,'-1',0,0,'','',-1),(1033,'boost','status','omega',0,0,'-1',0,0,'','',-1),(1036,'boxes','boxes_add__alert_box','omega',0,0,'-1',0,0,'','',-2),(1039,'boxes','boxes_add__carousel_box','omega',0,0,'-1',0,0,'','',-2),(1042,'boxes','boxes_add__content_list_box','omega',0,0,'-1',0,0,'','',-2),(1045,'boxes','boxes_add__node_reference','omega',0,0,'-1',0,0,'','',-2),(1048,'boxes','boxes_add__photo_box','omega',0,0,'-1',0,0,'','',-2),(1051,'boxes','boxes_add__simple','omega',0,0,'-1',0,0,'','',-2),(1054,'boxes','boxes_add__slideshow_box','omega',0,0,'-1',0,0,'','',-2),(1057,'boxes','dhs_header_tagline','omega',0,0,'-1',0,0,'','',-2),(1060,'boxes','homepage_carousel_box','omega',0,0,'-1',0,0,'','',-2),(1063,'boxes','homepage_content_list','omega',0,0,'-1',0,0,'','',-2),(1066,'boxes','homepage_photos','omega',0,0,'-1',0,0,'','',-2),(1069,'boxes','homepage_slideshow_box','omega',0,0,'-1',0,0,'','',-2),(1072,'context_ui','editor','omega',0,0,'-1',0,0,'','',1),(1075,'delta_blocks','action-links','omega',0,0,'-1',0,0,'','',8),(1078,'delta_blocks','branding','omega',0,0,'-1',0,0,'','',8),(1081,'delta_blocks','breadcrumb','omega',0,0,'-1',0,0,'','',4),(1084,'delta_blocks','feed-icons','omega',0,0,'-1',0,0,'','',8),(1087,'delta_blocks','logo','omega',0,0,'-1',0,0,'','',8),(1090,'delta_blocks','messages','omega',0,0,'-1',0,0,'','',-1),(1093,'delta_blocks','page-title','omega',0,0,'-1',0,0,'','',4),(1096,'delta_blocks','site-name','omega',0,0,'-1',0,0,'','',8),(1099,'delta_blocks','site-slogan','omega',0,0,'-1',0,0,'','',8),(1102,'delta_blocks','tabs','omega',0,0,'-1',0,0,'','',4),(1105,'diff','inline','omega',0,0,'-1',0,0,'','',1),(1108,'locale','language','omega',0,0,'-1',0,0,'','',-1),(1111,'menu','devel','omega',0,0,'-1',0,0,'','',-1),(1114,'menu','features','omega',0,0,'-1',0,0,'','',-1),(1117,'menu','menu-process-view','omega',0,0,'-1',0,0,'','',-1),(1120,'menu','menu-sdlc-topics','omega',0,0,'-1',0,0,'','',-1),(1123,'menu','menu-sidemenu','omega',1,-15,'sidebar_first',0,0,'','',-1),(1126,'menu','menu-swa-about-side-menu','omega',0,0,'-1',0,0,'','',-1),(1129,'menu','menu-swa-forums-groups-side-menu','omega',0,0,'-1',0,0,'','',-1),(1132,'menu','menu-swa-main-menu','omega',0,0,'-1',0,0,'','',-1),(1135,'menu','menu-swa-resources-side-menu','omega',0,0,'-1',0,0,'','',-1),(1138,'node','recent','omega',0,0,'-1',0,0,'','',1),(1141,'node','syndicate','omega',0,0,'-1',0,0,'','',-1),(1144,'search','form','omega',0,0,'-1',0,0,'','',-1),(1147,'shortcut','shortcuts','omega',0,0,'-1',0,0,'','',-1),(1150,'system','help','omega',1,-16,'header_first',0,0,'','',-1),(1153,'system','main','omega',1,-17,'content',0,1,'','',-1),(1156,'system','main-menu','omega',0,0,'-1',0,0,'','',-1),(1159,'system','management','omega',0,0,'-1',0,0,'','',-1),(1162,'system','navigation','omega',0,0,'-1',0,0,'','',-1),(1165,'system','powered-by','omega',0,10,'-1',0,0,'','',-1),(1168,'system','user-menu','omega',0,0,'-1',0,0,'','',-1),(1171,'user','login','omega',0,0,'-1',0,0,'','',-1),(1174,'user','new','omega',0,0,'-1',0,0,'','',1),(1177,'user','online','omega',0,0,'-1',0,0,'','',-1),(1180,'views','-exp-taxonomy_term-page','omega',0,0,'-1',0,0,'','',-1),(1183,'views','4302e30776901a401ce27932ef240920','omega',0,0,'-1',0,0,'','',-1),(1186,'views','4bf579a58bcbb33486a0aa98b50751cf','omega',0,0,'-1',0,0,'','',-1),(1189,'views','5366122fdf77e52e6440b93e647ed375','omega',0,0,'-1',0,0,'','',-1),(1192,'views','5a61e3fc8c8a668a285cd87d304f95f1','omega',0,0,'-1',0,0,'','',-1),(1195,'views','751912289a8f1c0f6624e2c2fc19957f','omega',0,0,'-1',0,0,'','',-1),(1198,'views','89edc31699609e524429d894943e5992','omega',0,0,'-1',0,0,'','',-1),(1201,'views','8bcb1ab8ea4a6383f40249f2b7a64176','omega',0,0,'-1',0,0,'','',-1),(1204,'views','9cf22433e0efbd8b206c8e4c2edb177c','omega',0,0,'-1',0,0,'','',-1),(1207,'views','9f9bbca182fd063d662c2578bfb5800c','omega',0,0,'-1',0,0,'','',-1),(1210,'views','bsi_announcements-block_1','omega',0,0,'-1',0,0,'','',-1),(1213,'views','bsi_articles-block_1','omega',0,0,'-1',0,0,'','',-1),(1216,'views','dfbd37967da2fdca43aa241d0cb2b5fc','omega',0,0,'-1',0,0,'','',-1),(1219,'views','events-block','omega',0,0,'-1',0,0,'','',-1),(1222,'views','events-block_1','omega',0,0,'-1',0,0,'','',-1),(1225,'views','photos-photo_homepage','omega',0,0,'-1',0,0,'','',-1),(1228,'views','press_releases-block_1','omega',0,0,'-1',0,0,'','',-1),(1231,'views','resource_taxonomy_views-block_1','omega',0,0,'-1',0,0,'','',-1),(1234,'views','resource_taxonomy_views-block_2','omega',0,0,'-1',0,0,'','',-1),(1237,'views','resource_taxonomy_views-block_3','omega',0,0,'-1',0,0,'','',-1),(1240,'views','resource_taxonomy_views-block_4','omega',0,0,'-1',0,0,'','',-1),(1243,'views','resource_taxonomy_views-block_5','omega',0,0,'-1',0,0,'','',-1),(1246,'views','swa_announcements-block','omega',0,0,'-1',0,0,'','',-1),(1249,'views','swa_forums-block','omega',0,0,'-1',0,0,'','',-1),(1252,'views','swa_forums-block_1','omega',0,0,'-1',0,0,'','',-1),(1255,'views','workbench_current_user-block_1','omega',0,0,'-1',0,0,'','',-1),(1258,'views','workbench_edited-block_1','omega',0,0,'-1',0,0,'','',-1),(1261,'workbench','block','omega',0,-18,'-1',0,0,'','',-1);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_custom`
--

LOCK TABLES `block_custom` WRITE;
/*!40000 ALTER TABLE `block_custom` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_node_type`
--

LOCK TABLES `block_node_type` WRITE;
/*!40000 ALTER TABLE `block_node_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_role`
--

LOCK TABLES `block_role` WRITE;
/*!40000 ALTER TABLE `block_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `block_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked_ips`
--

LOCK TABLES `blocked_ips` WRITE;
/*!40000 ALTER TABLE `blocked_ips` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocked_ips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `box`
--

DROP TABLE IF EXISTS `box`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `box` (
  `delta` varchar(32) NOT NULL COMMENT 'The block’s block.delta.',
  `plugin_key` varchar(64) NOT NULL COMMENT 'The plugin responsible for this block.',
  `title` varchar(64) NOT NULL COMMENT 'Block title.',
  `description` varchar(255) DEFAULT '' COMMENT 'Block description.',
  `options` longtext COMMENT 'Block content configuration.',
  PRIMARY KEY (`delta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `box`
--

LOCK TABLES `box` WRITE;
/*!40000 ALTER TABLE `box` DISABLE KEYS */;
INSERT INTO `box` VALUES ('dhs_header_tagline','simple','','Strip of text at top of site','a:2:{s:4:\"body\";a:2:{s:5:\"value\";s:264:\"<p><img alt=\"US flag\" src=\"/profiles/dhs_wcm/themes/dhs_wcm_theme/images/icn-us-flag-21px.png\" style=\"width: 21px; height: 13px; \" />&nbsp;&nbsp;&nbsp;Official website of the National Maritime Center United States Coast Guard One Mission...One Team...One Voice</p>\";s:6:\"format\";s:9:\"full_html\";}s:18:\"additional_classes\";s:0:\"\";}'),('homepage_slideshow_box','slideshow_box','Slideshow','Slideshow for homepage','a:2:{s:15:\"entity_boxes_id\";s:1:\"4\";s:18:\"additional_classes\";s:0:\"\";}');
/*!40000 ALTER TABLE `box` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_block`
--

DROP TABLE IF EXISTS `cache_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_block`
--

LOCK TABLES `cache_block` WRITE;
/*!40000 ALTER TABLE `cache_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_bootstrap`
--

DROP TABLE IF EXISTS `cache_bootstrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_bootstrap`
--

LOCK TABLES `cache_bootstrap` WRITE;
/*!40000 ALTER TABLE `cache_bootstrap` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_bootstrap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_comment`
--

DROP TABLE IF EXISTS `cache_entity_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_comment` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store comment entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_comment`
--

LOCK TABLES `cache_entity_comment` WRITE;
/*!40000 ALTER TABLE `cache_entity_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_file`
--

DROP TABLE IF EXISTS `cache_entity_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_file` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store file entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_file`
--

LOCK TABLES `cache_entity_file` WRITE;
/*!40000 ALTER TABLE `cache_entity_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_node`
--

DROP TABLE IF EXISTS `cache_entity_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_node` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store node entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_node`
--

LOCK TABLES `cache_entity_node` WRITE;
/*!40000 ALTER TABLE `cache_entity_node` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_taxonomy_term`
--

DROP TABLE IF EXISTS `cache_entity_taxonomy_term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_taxonomy_term` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store taxonomy_term entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_taxonomy_term`
--

LOCK TABLES `cache_entity_taxonomy_term` WRITE;
/*!40000 ALTER TABLE `cache_entity_taxonomy_term` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_taxonomy_term` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `cache_entity_taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_taxonomy_vocabulary` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store taxonomy_vocabulary entity...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_taxonomy_vocabulary`
--

LOCK TABLES `cache_entity_taxonomy_vocabulary` WRITE;
/*!40000 ALTER TABLE `cache_entity_taxonomy_vocabulary` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_taxonomy_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_entity_user`
--

DROP TABLE IF EXISTS `cache_entity_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_entity_user` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store user entity records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_entity_user`
--

LOCK TABLES `cache_entity_user` WRITE;
/*!40000 ALTER TABLE `cache_entity_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_entity_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_features`
--

DROP TABLE IF EXISTS `cache_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_features` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_features`
--

LOCK TABLES `cache_features` WRITE;
/*!40000 ALTER TABLE `cache_features` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_field`
--

DROP TABLE IF EXISTS `cache_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_field`
--

LOCK TABLES `cache_field` WRITE;
/*!40000 ALTER TABLE `cache_field` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_filter`
--

DROP TABLE IF EXISTS `cache_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_filter`
--

LOCK TABLES `cache_filter` WRITE;
/*!40000 ALTER TABLE `cache_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_form`
--

DROP TABLE IF EXISTS `cache_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_form`
--

LOCK TABLES `cache_form` WRITE;
/*!40000 ALTER TABLE `cache_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_image`
--

DROP TABLE IF EXISTS `cache_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_image`
--

LOCK TABLES `cache_image` WRITE;
/*!40000 ALTER TABLE `cache_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_libraries`
--

DROP TABLE IF EXISTS `cache_libraries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_libraries` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table to store library information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_libraries`
--

LOCK TABLES `cache_libraries` WRITE;
/*!40000 ALTER TABLE `cache_libraries` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_libraries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_menu`
--

DROP TABLE IF EXISTS `cache_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_menu`
--

LOCK TABLES `cache_menu` WRITE;
/*!40000 ALTER TABLE `cache_menu` DISABLE KEYS */;
INSERT INTO `cache_menu` VALUES ('menu_custom','a:5:{s:9:\"main-menu\";a:3:{s:9:\"menu_name\";s:9:\"main-menu\";s:5:\"title\";s:9:\"Main menu\";s:11:\"description\";s:115:\"The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.\";}s:10:\"management\";a:3:{s:9:\"menu_name\";s:10:\"management\";s:5:\"title\";s:10:\"Management\";s:11:\"description\";s:69:\"The <em>Management</em> menu contains links for administrative tasks.\";}s:13:\"menu-sidemenu\";a:3:{s:9:\"menu_name\";s:13:\"menu-sidemenu\";s:5:\"title\";s:8:\"sidemenu\";s:11:\"description\";s:8:\"sidemenu\";}s:10:\"navigation\";a:3:{s:9:\"menu_name\";s:10:\"navigation\";s:5:\"title\";s:10:\"Navigation\";s:11:\"description\";s:150:\"The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.\";}s:9:\"user-menu\";a:3:{s:9:\"menu_name\";s:9:\"user-menu\";s:5:\"title\";s:9:\"User menu\";s:11:\"description\";s:99:\"The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.\";}}',0,1466523598,1);
/*!40000 ALTER TABLE `cache_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_page`
--

DROP TABLE IF EXISTS `cache_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_page`
--

LOCK TABLES `cache_page` WRITE;
/*!40000 ALTER TABLE `cache_page` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_path`
--

DROP TABLE IF EXISTS `cache_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_path`
--

LOCK TABLES `cache_path` WRITE;
/*!40000 ALTER TABLE `cache_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_token`
--

DROP TABLE IF EXISTS `cache_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_token` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for token information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_token`
--

LOCK TABLES `cache_token` WRITE;
/*!40000 ALTER TABLE `cache_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_views`
--

DROP TABLE IF EXISTS `cache_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_views`
--

LOCK TABLES `cache_views` WRITE;
/*!40000 ALTER TABLE `cache_views` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_views` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_views_data`
--

DROP TABLE IF EXISTS `cache_views_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_views_data` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_views_data`
--

LOCK TABLES `cache_views_data` WRITE;
/*!40000 ALTER TABLE `cache_views_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_views_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique category ID.',
  `category` varchar(255) NOT NULL DEFAULT '' COMMENT 'Category name.',
  `recipients` longtext NOT NULL COMMENT 'Comma-separated list of recipient e-mail addresses.',
  `reply` longtext NOT NULL COMMENT 'Text of the auto-reply message.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The category’s weight.',
  `selected` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether or not category is selected by default. (1 = Yes, 0 = No)',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `category` (`category`),
  KEY `list` (`weight`,`category`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Contact form category settings.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (4,'Website feedback','admin@edit-wcms-testint.dhs.gov','',0,1);
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `context`
--

DROP TABLE IF EXISTS `context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `context` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The primary identifier for a context.',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'Description for this context.',
  `tag` varchar(255) NOT NULL DEFAULT '' COMMENT 'Tag for this context.',
  `conditions` text COMMENT 'Serialized storage of all context condition settings.',
  `reactions` text COMMENT 'Serialized storage of all context reaction settings.',
  `condition_mode` int(11) DEFAULT '0' COMMENT 'Condition mode for this context.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage for normal (user-defined) contexts.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `context`
--

LOCK TABLES `context` WRITE;
/*!40000 ALTER TABLE `context` DISABLE KEYS */;
/*!40000 ALTER TABLE `context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctools_css_cache`
--

DROP TABLE IF EXISTS `ctools_css_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctools_css_cache`
--

LOCK TABLES `ctools_css_cache` WRITE;
/*!40000 ALTER TABLE `ctools_css_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ctools_css_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctools_custom_content`
--

DROP TABLE IF EXISTS `ctools_custom_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_custom_content` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'A database primary key to ensure uniqueness',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this content. Used to identify it programmatically.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Administrative title for this content.',
  `admin_description` longtext COMMENT 'Administrative description for this content.',
  `category` varchar(255) DEFAULT NULL COMMENT 'Administrative category for this content.',
  `settings` longtext COMMENT 'Serialized settings for the actual content to be used',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Contains exportable customized content for this site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctools_custom_content`
--

LOCK TABLES `ctools_custom_content` WRITE;
/*!40000 ALTER TABLE `ctools_custom_content` DISABLE KEYS */;
INSERT INTO `ctools_custom_content` VALUES (4,'panel','panel','panel ','panel','a:5:{s:11:\"admin_title\";s:0:\"\";s:5:\"title\";s:5:\"panel\";s:4:\"body\";s:0:\"\";s:6:\"format\";s:9:\"full_html\";s:10:\"substitute\";i:1;}');
/*!40000 ALTER TABLE `ctools_custom_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ctools_object_cache`
--

DROP TABLE IF EXISTS `ctools_object_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.',
  PRIMARY KEY (`sid`,`obj`,`name`),
  KEY `updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ctools_object_cache`
--

LOCK TABLES `ctools_object_cache` WRITE;
/*!40000 ALTER TABLE `ctools_object_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `ctools_object_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_format_locale`
--

DROP TABLE IF EXISTS `date_format_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_locale`
--

LOCK TABLES `date_format_locale` WRITE;
/*!40000 ALTER TABLE `date_format_locale` DISABLE KEYS */;
/*!40000 ALTER TABLE `date_format_locale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_format_type`
--

DROP TABLE IF EXISTS `date_format_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_type`
--

LOCK TABLES `date_format_type` WRITE;
/*!40000 ALTER TABLE `date_format_type` DISABLE KEYS */;
INSERT INTO `date_format_type` VALUES ('long','Long',1),('medium','Medium',1),('short','Short',1);
/*!40000 ALTER TABLE `date_format_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `date_formats`
--

DROP TABLE IF EXISTS `date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_formats`
--

LOCK TABLES `date_formats` WRITE;
/*!40000 ALTER TABLE `date_formats` DISABLE KEYS */;
INSERT INTO `date_formats` VALUES (1,'Y-m-d H:i','short',1),(2,'m/d/Y - H:i','short',1),(3,'d/m/Y - H:i','short',1),(4,'Y/m/d - H:i','short',1),(5,'d.m.Y - H:i','short',1),(6,'m/d/Y - g:ia','short',1),(7,'d/m/Y - g:ia','short',1),(8,'Y/m/d - g:ia','short',1),(9,'M j Y - H:i','short',1),(10,'j M Y - H:i','short',1),(11,'Y M j - H:i','short',1),(12,'M j Y - g:ia','short',1),(13,'j M Y - g:ia','short',1),(14,'Y M j - g:ia','short',1),(15,'D, Y-m-d H:i','medium',1),(16,'D, m/d/Y - H:i','medium',1),(17,'D, d/m/Y - H:i','medium',1),(18,'D, Y/m/d - H:i','medium',1),(19,'F j, Y - H:i','medium',1),(20,'j F, Y - H:i','medium',1),(21,'Y, F j - H:i','medium',1),(22,'D, m/d/Y - g:ia','medium',1),(23,'D, d/m/Y - g:ia','medium',1),(24,'D, Y/m/d - g:ia','medium',1),(25,'F j, Y - g:ia','medium',1),(26,'j F Y - g:ia','medium',1),(27,'Y, F j - g:ia','medium',1),(28,'j. F Y - G:i','medium',1),(29,'l, F j, Y - H:i','long',1),(30,'l, j F, Y - H:i','long',1),(31,'l, Y,  F j - H:i','long',1),(32,'l, F j, Y - g:ia','long',1),(33,'l, j F Y - g:ia','long',1),(34,'l, Y,  F j - g:ia','long',1),(35,'l, j. F Y - G:i','long',1);
/*!40000 ALTER TABLE `date_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defaultcontent`
--

DROP TABLE IF EXISTS `defaultcontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `defaultcontent` (
  `name` varchar(225) NOT NULL COMMENT 'Then machine name of the node',
  `nid` int(10) unsigned DEFAULT NULL COMMENT 'Node id or NULL if there is no current node',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Store state of default content nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defaultcontent`
--

LOCK TABLES `defaultcontent` WRITE;
/*!40000 ALTER TABLE `defaultcontent` DISABLE KEYS */;
INSERT INTO `defaultcontent` VALUES ('medical',77),('photo',74),('slide show',78),('stcw',75);
/*!40000 ALTER TABLE `defaultcontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delta`
--

DROP TABLE IF EXISTS `delta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delta` (
  `machine_name` varchar(32) NOT NULL COMMENT 'The system name of this theme settings template.',
  `name` varchar(128) NOT NULL COMMENT 'The friendly name of this theme settings template.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this theme settings template.',
  `theme` varchar(128) NOT NULL COMMENT 'The theme for which this theme settings template is relevant.',
  `mode` varchar(32) NOT NULL COMMENT 'The mode that this template operrates in.',
  `parent` varchar(32) NOT NULL COMMENT 'The system name of the parent of this theme settings template.',
  `settings` longblob COMMENT 'Serialized data which is a copy of the theme settings array stored in the system table based on these overrides',
  PRIMARY KEY (`machine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores theme-settings templates that allow overriding the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delta`
--

LOCK TABLES `delta` WRITE;
/*!40000 ALTER TABLE `delta` DISABLE KEYS */;
/*!40000 ALTER TABLE `delta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_boxes`
--

DROP TABLE IF EXISTS `entity_boxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_boxes` (
  `entity_boxes_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Identifier for a entity_boxes.',
  `type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The entity_boxes_type.type of this entity_boxes.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language of the entity_boxes.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Machine name for boxes',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT 'The description field from boxes boxes',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the entity_boxes was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the entity_boxes was most recently saved.',
  PRIMARY KEY (`entity_boxes_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='The base table for entity_boxes entities.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_boxes`
--

LOCK TABLES `entity_boxes` WRITE;
/*!40000 ALTER TABLE `entity_boxes` DISABLE KEYS */;
INSERT INTO `entity_boxes` VALUES (4,'slideshow_box','','homepage_slideshow_box','Slideshow for homepage',1464971446,1464972180);
/*!40000 ALTER TABLE `entity_boxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity_boxes_type`
--

DROP TABLE IF EXISTS `entity_boxes_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity_boxes_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique entity_boxes type identifier.',
  `type` varchar(255) NOT NULL COMMENT 'The machine-readable name of this entity_boxes type.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this entity_boxes type.',
  `weight` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The weight of this entity_boxes type in relation to others.',
  `data` longtext COMMENT 'A serialized array of additional data related to this entity_boxes type.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'The exportable status of the entity.',
  `module` varchar(255) DEFAULT NULL COMMENT 'The name of the providing module if the entity has been defined in code.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about defined entity_boxes types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity_boxes_type`
--

LOCK TABLES `entity_boxes_type` WRITE;
/*!40000 ALTER TABLE `entity_boxes_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity_boxes_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config`
--

LOCK TABLES `field_config` WRITE;
/*!40000 ALTER TABLE `field_config` DISABLE KEYS */;
INSERT INTO `field_config` VALUES (1,'body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:0:{}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(2,'field_content_owner','node_reference','node_reference',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"nid\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}}s:7:\"indexes\";a:1:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:8:\"settings\";a:2:{s:19:\"referenceable_types\";a:7:{s:8:\"external\";i:0;s:12:\"landing_page\";i:0;s:5:\"photo\";i:0;s:13:\"press_release\";i:0;s:7:\"profile\";s:7:\"profile\";s:7:\"rotator\";i:0;s:9:\"site_page\";i:0;}s:4:\"view\";a:3:{s:4:\"args\";a:0:{}s:12:\"display_name\";s:0:\"\";s:9:\"view_name\";s:0:\"\";}}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',-1,0,0),(3,'field_link_url','link_field','link',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:0:{}s:8:\"settings\";a:7:{s:10:\"attributes\";a:3:{s:5:\"class\";s:0:\"\";s:3:\"rel\";s:0:\"\";s:6:\"target\";s:7:\"default\";}s:7:\"display\";a:1:{s:10:\"url_cutoff\";i:80;}s:13:\"enable_tokens\";i:1;s:5:\"title\";s:8:\"optional\";s:15:\"title_maxlength\";i:128;s:11:\"title_value\";s:0:\"\";s:3:\"url\";i:0;}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(4,'field_thumbnail_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:13:\"default_image\";i:0;s:10:\"uri_scheme\";s:6:\"public\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(5,'field_featured_items','node_reference','node_reference',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"nid\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}}s:7:\"indexes\";a:1:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:8:\"settings\";a:2:{s:19:\"referenceable_types\";a:6:{s:8:\"external\";s:8:\"external\";s:12:\"landing_page\";s:12:\"landing_page\";s:5:\"photo\";i:0;s:13:\"press_release\";s:13:\"press_release\";s:7:\"rotator\";i:0;s:9:\"site_page\";s:9:\"site_page\";}s:4:\"view\";a:3:{s:4:\"args\";a:0:{}s:12:\"display_name\";s:0:\"\";s:9:\"view_name\";s:0:\"\";}}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',-1,0,0),(6,'field_main_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:13:\"default_image\";i:0;s:10:\"uri_scheme\";s:6:\"public\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(7,'field_files','file','file',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}s:5:\"table\";s:4:\"file\";}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:3:{s:15:\"display_default\";i:0;s:13:\"display_field\";i:0;s:10:\"uri_scheme\";s:6:\"public\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";}s:2:\"id\";s:1:\"7\";}',-1,1,0),(8,'field_keywords','taxonomy_term_reference','taxonomy',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:4:\"tags\";s:6:\"parent\";s:1:\"0\";}}}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',-1,0,0),(9,'field_long_title','text_long','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:0:{}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(10,'field_press_release_date','datetime','date',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:0:{}s:8:\"settings\";a:6:{s:11:\"cache_count\";s:1:\"4\";s:13:\"cache_enabled\";i:0;s:11:\"granularity\";a:6:{s:3:\"day\";s:3:\"day\";s:4:\"hour\";s:4:\"hour\";s:6:\"minute\";s:6:\"minute\";s:5:\"month\";s:5:\"month\";s:6:\"second\";i:0;s:4:\"year\";s:4:\"year\";}s:11:\"timezone_db\";s:3:\"UTC\";s:6:\"todate\";s:0:\"\";s:11:\"tz_handling\";s:4:\"site\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(11,'field_related_content','node_reference','node_reference',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:1:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}}s:8:\"settings\";a:2:{s:19:\"referenceable_types\";a:5:{s:8:\"external\";s:8:\"external\";s:12:\"landing_page\";s:12:\"landing_page\";s:5:\"photo\";i:0;s:13:\"press_release\";s:13:\"press_release\";s:9:\"site_page\";s:9:\"site_page\";}s:4:\"view\";a:3:{s:4:\"args\";a:0:{}s:12:\"display_name\";s:0:\"\";s:9:\"view_name\";s:0:\"\";}}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";}s:2:\"id\";s:2:\"11\";}',-1,1,0),(16,'field_photo_copyright','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(17,'field_photo_date','datetime','date',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:0:{}s:7:\"indexes\";a:0:{}s:8:\"settings\";a:6:{s:11:\"cache_count\";s:1:\"4\";s:13:\"cache_enabled\";i:0;s:11:\"granularity\";a:6:{s:3:\"day\";s:3:\"day\";s:4:\"hour\";i:0;s:6:\"minute\";i:0;s:5:\"month\";s:5:\"month\";s:6:\"second\";i:0;s:4:\"year\";s:4:\"year\";}s:11:\"timezone_db\";s:0:\"\";s:6:\"todate\";s:0:\"\";s:11:\"tz_handling\";s:4:\"none\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(18,'field_photo_location','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(19,'field_photographer_name','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(20,'field_photographer_org','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(21,'field_job_title','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(22,'field_profile_address','text_long','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:0:{}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(23,'field_profile_email','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:2:\"60\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(24,'field_profile_first_name','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:2:\"60\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(25,'field_profile_last_name','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:2:\"60\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(26,'field_profile_organization','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:2:\"60\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(27,'field_profile_phone','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:2:\"20\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(28,'field_profile_photo','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:13:\"default_image\";i:0;s:10:\"uri_scheme\";s:6:\"public\";}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(29,'field_profile_user','user_reference','user_reference',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:3:\"uid\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:7:\"indexes\";a:1:{s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}}s:8:\"settings\";a:3:{s:19:\"referenceable_roles\";a:5:{i:2;s:1:\"2\";i:3;s:1:\"3\";i:4;s:1:\"4\";i:5;s:1:\"5\";i:7;s:1:\"7\";}s:20:\"referenceable_status\";a:2:{i:0;s:1:\"0\";i:1;s:1:\"1\";}s:4:\"view\";a:3:{s:4:\"args\";a:0:{}s:12:\"display_name\";s:0:\"\";s:9:\"view_name\";s:0:\"\";}}s:12:\"translatable\";s:1:\"1\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,1,0),(30,'field_display_title','text','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:0:{}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}s:8:\"settings\";a:1:{s:10:\"max_length\";s:3:\"255\";}s:12:\"translatable\";s:1:\"0\";s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}}',1,0,0),(32,'field_photo','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:7:{s:12:\"translatable\";s:1:\"0\";s:12:\"entity_types\";a:0:{}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";s:3:\"116\";}s:7:\"storage\";a:5:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";s:1:\"1\";s:7:\"details\";a:1:{s:3:\"sql\";a:2:{s:18:\"FIELD_LOAD_CURRENT\";a:1:{s:22:\"field_data_field_photo\";a:5:{s:3:\"fid\";s:15:\"field_photo_fid\";s:3:\"alt\";s:15:\"field_photo_alt\";s:5:\"title\";s:17:\"field_photo_title\";s:5:\"width\";s:17:\"field_photo_width\";s:6:\"height\";s:18:\"field_photo_height\";}}s:19:\"FIELD_LOAD_REVISION\";a:1:{s:26:\"field_revision_field_photo\";a:5:{s:3:\"fid\";s:15:\"field_photo_fid\";s:3:\"alt\";s:15:\"field_photo_alt\";s:5:\"title\";s:17:\"field_photo_title\";s:5:\"width\";s:17:\"field_photo_width\";s:6:\"height\";s:18:\"field_photo_height\";}}}}}s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:2:\"id\";s:2:\"32\";}',1,0,0);
/*!40000 ALTER TABLE `field_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config_instance`
--

LOCK TABLES `field_config_instance` WRITE;
/*!40000 ALTER TABLE `field_config_instance` DISABLE KEYS */;
INSERT INTO `field_config_instance` VALUES (1,1,'body','node','external','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:4:\"Body\";s:8:\"required\";i:1;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"5\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"1\";}}',0),(2,2,'field_content_owner','node','external','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"4\";}}',0),(3,3,'field_link_url','node','external','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"link\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"link_default\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"link\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"link_default\";s:6:\"weight\";s:1:\"2\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"link\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"link_default\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"link\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"link_default\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:3:\"URL\";s:8:\"required\";i:1;s:8:\"settings\";a:9:{s:10:\"attributes\";a:5:{s:5:\"class\";s:0:\"\";s:18:\"configurable_title\";i:0;s:3:\"rel\";s:0:\"\";s:6:\"target\";s:7:\"default\";s:5:\"title\";s:0:\"\";}s:7:\"display\";a:1:{s:10:\"url_cutoff\";s:2:\"80\";}s:13:\"enable_tokens\";i:0;s:5:\"title\";s:8:\"required\";s:15:\"title_maxlength\";s:3:\"128\";s:11:\"title_value\";s:0:\"\";s:3:\"url\";i:0;s:18:\"user_register_form\";b:0;s:12:\"validate_url\";i:1;}s:6:\"widget\";a:5:{s:6:\"active\";i:0;s:6:\"module\";s:4:\"link\";s:8:\"settings\";a:0:{}s:4:\"type\";s:10:\"link_field\";s:6:\"weight\";s:1:\"2\";}}',0),(4,4,'field_thumbnail_image','node','external','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:24:\"dhs_wcm_carousel_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:15:\"Thumbnail Image\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";s:6:\"attach\";s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"1\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"3\";}}',0),(5,1,'body','node','landing_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:4:\"Body\";s:8:\"required\";i:0;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"5\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"1\";}}',0),(6,2,'field_content_owner','node','landing_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"4\";}}',0),(7,5,'field_featured_items','node','landing_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:6:\"teaser\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:6:\"teaser\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"2\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:14:\"Featured Items\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"3\";}}',0),(8,6,'field_main_image','node','landing_page','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:24:\"dhs_wcm_carousel_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:10:\"Main Image\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";i:0;s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"0\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"2\";}}',0),(9,1,'body','node','press_release','a:8:{s:13:\"default_value\";N;s:11:\"description\";s:66:\"The full version of the content associated with the Press Release.\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:3:\"rss\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:4:\"Body\";s:8:\"required\";i:1;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:2:\"10\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"3\";}s:11:\"widget_type\";s:26:\"text_textarea_with_summary\";}',0),(10,2,'field_content_owner','node','press_release','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"8\";}}',0),(11,7,'field_files','node','press_release','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:56:\"Upload files you would like to associate with this page.\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"file_default\";s:6:\"weight\";s:1:\"4\";}s:4:\"full\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:0:{}s:4:\"type\";s:14:\"file_url_plain\";s:6:\"weight\";s:1:\"5\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}}s:5:\"label\";s:5:\"Files\";s:8:\"required\";i:0;s:8:\"settings\";a:5:{s:17:\"description_field\";i:1;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:34:\"doc docx xls xlsx ppt pptx pdf txt\";s:12:\"max_filesize\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:2:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:0:{}s:13:\"source_attach\";a:3:{s:8:\"absolute\";i:0;s:11:\"attach_mode\";s:4:\"move\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";i:1;}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"0\";}}s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:12:\"file_generic\";s:6:\"weight\";s:1:\"7\";}}',0),(12,8,'field_keywords','node','press_release','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:0:{}s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"6\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:0:{}s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"6\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}}s:5:\"label\";s:8:\"Keywords\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:0;s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:2:{s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";s:4:\"size\";i:60;}s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";s:1:\"5\";}}',0),(13,9,'field_long_title','node','press_release','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}}s:5:\"label\";s:10:\"Long Title\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"rows\";s:1:\"2\";}s:4:\"type\";s:13:\"text_textarea\";s:6:\"weight\";s:1:\"1\";}}',0),(14,6,'field_main_image','node','press_release','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:24:\"dhs_wcm_carousel_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"2\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:10:\"Main Image\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";i:0;s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"1\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"4\";}}',0),(15,10,'field_press_release_date','node','press_release','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:5:{s:11:\"format_type\";s:19:\"full_month_day_year\";s:6:\"fromto\";s:4:\"both\";s:13:\"multiple_from\";s:0:\"\";s:15:\"multiple_number\";s:0:\"\";s:11:\"multiple_to\";s:0:\"\";}s:4:\"type\";s:12:\"date_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:5:{s:11:\"format_type\";s:19:\"full_month_day_year\";s:6:\"fromto\";s:4:\"both\";s:13:\"multiple_from\";s:0:\"\";s:15:\"multiple_number\";s:0:\"\";s:11:\"multiple_to\";s:0:\"\";}s:4:\"type\";s:12:\"date_default\";s:6:\"weight\";s:1:\"1\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:5:{s:11:\"format_type\";s:19:\"full_month_day_year\";s:6:\"fromto\";s:4:\"both\";s:13:\"multiple_from\";s:0:\"\";s:15:\"multiple_number\";s:0:\"\";s:11:\"multiple_to\";s:0:\"\";}s:4:\"type\";s:12:\"date_default\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:18:\"Press Release Date\";s:8:\"required\";i:0;s:8:\"settings\";a:5:{s:13:\"default_value\";s:3:\"now\";s:14:\"default_value2\";s:4:\"same\";s:18:\"default_value_code\";s:0:\"\";s:19:\"default_value_code2\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:6:{s:9:\"increment\";s:2:\"15\";s:12:\"input_format\";s:13:\"m/d/Y - H:i:s\";s:19:\"input_format_custom\";s:0:\"\";s:14:\"label_position\";s:5:\"above\";s:10:\"text_parts\";a:0:{}s:10:\"year_range\";s:5:\"-3:+3\";}s:4:\"type\";s:10:\"date_popup\";s:6:\"weight\";s:1:\"2\";}}',0),(16,11,'field_related_content','node','press_release','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:69:\"Enter the titles of nodes you would like to associate with this page.\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:0:{}s:4:\"type\";s:22:\"node_reference_default\";s:6:\"weight\";s:1:\"5\";}s:4:\"full\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:0:{}s:4:\"type\";s:22:\"node_reference_default\";s:6:\"weight\";s:1:\"4\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}}s:5:\"label\";s:15:\"Related Content\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"6\";}}',0),(17,1,'body','node','site_page','a:8:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:4:\"Body\";s:8:\"required\";i:1;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"5\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"2\";}s:11:\"widget_type\";s:26:\"text_textarea_with_summary\";}',0),(18,2,'field_content_owner','node','site_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"7\";}}',0),(19,7,'field_files','node','site_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:56:\"Upload files you would like to associate with this page.\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"file_default\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"file_default\";s:6:\"weight\";s:1:\"3\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}}s:5:\"label\";s:5:\"Files\";s:8:\"required\";i:0;s:8:\"settings\";a:5:{s:17:\"description_field\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:34:\"doc docx xls xlsx ppt pptx pdf txt\";s:12:\"max_filesize\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"file\";s:8:\"settings\";a:2:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:0:{}s:13:\"source_attach\";a:3:{s:8:\"absolute\";i:0;s:11:\"attach_mode\";s:4:\"move\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";i:1;}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"0\";}}s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:12:\"file_generic\";s:6:\"weight\";s:1:\"6\";}}',0),(20,8,'field_keywords','node','site_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"1\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:0:{}s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"5\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:0:{}s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";s:1:\"5\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}}s:5:\"label\";s:8:\"Keywords\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:0;s:6:\"module\";s:8:\"taxonomy\";s:8:\"settings\";a:2:{s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";s:4:\"size\";i:60;}s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";s:1:\"4\";}}',0),(21,9,'field_long_title','node','site_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:15:\"Page Long Title\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"rows\";s:1:\"1\";}s:4:\"type\";s:13:\"text_textarea\";s:6:\"weight\";s:1:\"1\";}}',0),(22,6,'field_main_image','node','site_page','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:24:\"dhs_wcm_carousel_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:10:\"Main Image\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";i:0;s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"1\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"3\";}}',0),(23,11,'field_related_content','node','site_page','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:69:\"Enter the titles of nodes you would like to associate with this page.\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:0:{}s:4:\"type\";s:22:\"node_reference_default\";s:6:\"weight\";s:1:\"4\";}s:4:\"full\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:0:{}s:4:\"type\";s:22:\"node_reference_default\";s:6:\"weight\";s:1:\"4\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}}s:5:\"label\";s:15:\"Related Content\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"5\";}}',0),(28,1,'body','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:4:\"Body\";s:8:\"required\";i:0;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:1:\"5\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"1\";}}',0),(29,2,'field_content_owner','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"4\";}}',0),(30,6,'field_main_image','node','photo','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:21:\"dhs_wcm_photo_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:21:\"dhs_wcm_photo_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"1\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:25:\"dhs_wcm_slideshow_rotator\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:5:\"Image\";s:8:\"required\";i:1;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";i:0;s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"1\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"2\";}}',0),(31,16,'field_photo_copyright','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}}s:5:\"label\";s:9:\"Copyright\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"5\";}}',0),(32,17,'field_photo_date','node','photo','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:6:{s:11:\"format_type\";s:4:\"long\";s:6:\"fromto\";s:4:\"both\";s:13:\"multiple_from\";s:0:\"\";s:15:\"multiple_number\";s:0:\"\";s:11:\"multiple_to\";s:0:\"\";s:19:\"show_remaining_days\";b:0;}s:4:\"type\";s:12:\"date_default\";s:6:\"weight\";s:1:\"5\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:6:{s:11:\"format_type\";s:4:\"long\";s:6:\"fromto\";s:4:\"both\";s:13:\"multiple_from\";s:0:\"\";s:15:\"multiple_number\";s:0:\"\";s:11:\"multiple_to\";s:0:\"\";s:19:\"show_remaining_days\";b:0;}s:4:\"type\";s:12:\"date_default\";s:6:\"weight\";s:1:\"5\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:16:\"Date Photo Taken\";s:8:\"required\";i:0;s:8:\"settings\";a:5:{s:13:\"default_value\";s:3:\"now\";s:14:\"default_value2\";s:4:\"same\";s:18:\"default_value_code\";s:0:\"\";s:19:\"default_value_code2\";s:0:\"\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"date\";s:8:\"settings\";a:6:{s:9:\"increment\";s:2:\"15\";s:12:\"input_format\";s:13:\"m/d/Y - H:i:s\";s:19:\"input_format_custom\";s:0:\"\";s:14:\"label_position\";s:5:\"above\";s:10:\"text_parts\";a:0:{}s:10:\"year_range\";s:5:\"-3:+3\";}s:4:\"type\";s:10:\"date_popup\";s:6:\"weight\";s:1:\"8\";}}',0),(33,18,'field_photo_location','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"6\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"6\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}}s:5:\"label\";s:14:\"Photo Location\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"9\";}}',0),(34,19,'field_photographer_name','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}}s:5:\"label\";s:19:\"Photographer\'s Name\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"6\";}}',0),(35,20,'field_photographer_org','node','photo','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"4\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"inline\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"4\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}}s:5:\"label\";s:27:\"Photographer\'s Organization\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"7\";}}',0),(36,1,'body','node','profile','a:8:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:14:\"editors_choice\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"13\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}s:12:\"search_index\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:13:\"search_result\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:11:\"trim_length\";s:3:\"250\";}s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:6:\"weight\";s:1:\"2\";}}s:5:\"label\";s:9:\"Biography\";s:8:\"required\";i:0;s:8:\"settings\";a:3:{s:15:\"display_summary\";i:1;s:15:\"text_processing\";s:1:\"1\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:2:{s:4:\"rows\";s:2:\"10\";s:12:\"summary_rows\";i:5;}s:4:\"type\";s:26:\"text_textarea_with_summary\";s:6:\"weight\";s:1:\"5\";}s:11:\"widget_type\";s:26:\"text_textarea_with_summary\";}',0),(37,21,'field_job_title','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:8:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}}s:5:\"label\";s:9:\"Job Title\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"4\";}}',0),(38,22,'field_profile_address','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:39:\"Enter the full address of this profile.\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}s:14:\"editors_choice\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"6\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"12\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"12\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"12\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}}s:5:\"label\";s:7:\"Address\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"rows\";s:1:\"4\";}s:4:\"type\";s:13:\"text_textarea\";s:6:\"weight\";s:2:\"10\";}}',0),(39,23,'field_profile_email','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:14:\"editors_choice\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"4\";}s:4:\"full\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"10\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"10\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"10\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}}s:5:\"label\";s:13:\"Email Address\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"9\";}}',0),(40,24,'field_profile_first_name','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}s:14:\"editors_choice\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:4:\"full\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}}s:5:\"label\";s:10:\"First Name\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"1\";}}',0),(41,25,'field_profile_last_name','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:14:\"editors_choice\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"8\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"6\";}}s:5:\"label\";s:9:\"Last Name\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"2\";}}',0),(42,26,'field_profile_organization','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:179:\"If this profile is an organization or company, enter the name of that organization here. This can take the place of First and Last names to serve as the full name of this profile.\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:14:\"editors_choice\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:4:\"full\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"2\";}s:3:\"rss\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"11\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"5\";}}s:5:\"label\";s:12:\"Organization\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"3\";}}',0),(43,27,'field_profile_phone','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:14:\"editors_choice\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"3\";}s:4:\"full\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"3\";}}s:5:\"label\";s:12:\"Phone Number\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"20\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"8\";}}',0),(44,28,'field_profile_photo','node','profile','a:6:{s:11:\"description\";s:0:\"\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:14:\"editors_choice\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:7:\"content\";s:11:\"image_style\";s:24:\"right-sidebar-thumbnails\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:20:\"dhs_wcm_page_content\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:2:{s:10:\"image_link\";s:0:\"\";s:11:\"image_style\";s:22:\"dhs_wcm_list_thumbnail\";}s:4:\"type\";s:5:\"image\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:5:\"Photo\";s:8:\"required\";i:0;s:8:\"settings\";a:9:{s:9:\"alt_field\";i:1;s:13:\"default_image\";i:0;s:14:\"file_directory\";s:15:\"profiles/photos\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:11:\"title_field\";i:1;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:5:\"image\";s:8:\"settings\";a:3:{s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:4:{s:6:\"attach\";i:0;s:4:\"imce\";s:4:\"imce\";s:9:\"reference\";s:9:\"reference\";s:6:\"remote\";i:0;}s:13:\"source_attach\";a:3:{s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"copy\";s:4:\"path\";s:11:\"file_attach\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"1\";}s:16:\"source_reference\";a:1:{s:12:\"autocomplete\";s:1:\"1\";}}s:19:\"preview_image_style\";s:9:\"thumbnail\";s:18:\"progress_indicator\";s:8:\"throbber\";}s:4:\"type\";s:11:\"image_image\";s:6:\"weight\";s:1:\"6\";}}',0),(45,29,'field_profile_user','node','profile','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:93:\"The user account that this profile is attached to. It is not required to have a user account.\";s:7:\"display\";a:9:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:14:\"editors_choice\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:2:\"12\";}s:4:\"full\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"7\";}s:3:\"rss\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}s:12:\"search_index\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}s:13:\"search_result\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"9\";}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:6:\"hidden\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"4\";}}s:5:\"label\";s:15:\"Associated User\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"user_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"user_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"user_reference_autocomplete\";s:6:\"weight\";s:1:\"7\";}}',0),(46,2,'field_content_owner','node','rotator','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";s:1:\"2\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Content Owner\";s:8:\"required\";i:0;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"3\";}}',0),(47,30,'field_display_title','node','rotator','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:0:{}s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";s:1:\"1\";}s:4:\"full\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:9:\"slideshow\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:4:{s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:4:\"type\";s:6:\"hidden\";s:6:\"weight\";i:0;}}s:5:\"label\";s:13:\"Display Title\";s:8:\"required\";i:0;s:8:\"settings\";a:2:{s:15:\"text_processing\";s:1:\"0\";s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:4:\"text\";s:8:\"settings\";a:1:{s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:14:\"text_textfield\";s:6:\"weight\";s:1:\"1\";}}',0),(48,5,'field_featured_items','node','rotator','a:7:{s:13:\"default_value\";N;s:11:\"description\";s:0:\"\";s:7:\"display\";a:5:{s:8:\"carousel\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:8:\"carousel\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"0\";}s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:4:\"full\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"0\";}s:4:\"full\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:6:\"teaser\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"0\";}s:9:\"slideshow\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:9:\"slideshow\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"0\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:1:{s:24:\"node_reference_view_mode\";s:6:\"teaser\";}s:4:\"type\";s:19:\"node_reference_node\";s:6:\"weight\";s:1:\"0\";}}s:5:\"label\";s:14:\"Featured Items\";s:8:\"required\";i:1;s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:5:{s:6:\"active\";i:1;s:6:\"module\";s:14:\"node_reference\";s:8:\"settings\";a:3:{s:18:\"autocomplete_match\";s:8:\"contains\";s:17:\"autocomplete_path\";s:27:\"node_reference/autocomplete\";s:4:\"size\";s:2:\"60\";}s:4:\"type\";s:27:\"node_reference_autocomplete\";s:6:\"weight\";s:1:\"2\";}}',0),(50,1,'body','node','nmc_about','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";s:2:\"31\";s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0),(53,32,'field_photo','node','nmc_about','a:6:{s:5:\"label\";s:5:\"Photo\";s:6:\"widget\";a:5:{s:6:\"weight\";s:2:\"32\";s:4:\"type\";s:11:\"image_image\";s:6:\"module\";s:5:\"image\";s:6:\"active\";i:1;s:8:\"settings\";a:3:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";s:17:\"filefield_sources\";a:4:{s:17:\"filefield_sources\";a:5:{s:6:\"upload\";s:6:\"upload\";s:6:\"remote\";i:0;s:9:\"clipboard\";i:0;s:9:\"reference\";i:0;s:6:\"attach\";i:0;}s:13:\"source_attach\";a:3:{s:4:\"path\";s:11:\"file_attach\";s:8:\"absolute\";s:1:\"0\";s:11:\"attach_mode\";s:4:\"move\";}s:11:\"source_imce\";a:1:{s:9:\"imce_mode\";s:1:\"0\";}s:16:\"source_reference\";a:2:{s:12:\"autocomplete\";s:1:\"0\";s:17:\"search_all_fields\";s:1:\"0\";}}}}s:8:\"settings\";a:9:{s:14:\"file_directory\";s:0:\"\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";i:0;s:11:\"title_field\";i:0;s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:5:\"above\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:0:\"\";s:10:\"image_link\";s:0:\"\";}s:6:\"module\";s:5:\"image\";s:6:\"weight\";i:1;}}s:8:\"required\";i:0;s:11:\"description\";s:0:\"\";}',0);
/*!40000 ALTER TABLE `field_config_instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_body`
--

LOCK TABLES `field_data_body` WRITE;
/*!40000 ALTER TABLE `field_data_body` DISABLE KEYS */;
INSERT INTO `field_data_body` VALUES ('node','site_page',0,51,53,'und',0,'CG-719K Credential Medical Evaluation Report\r\n\r\nThe Merchant Mariner Physical Exam (CG-719K) is required for Officers and Mariners with a qualified rating. The examination and form must be completed within 12 months of application date (36 months if applying for Raise of Grade). The medical provider completing the required examination must be a physician, physician assistant, or nurse practitioner who is licensed in the United States or one of the U.S. territories.\r\n\r\n    Merchant Mariner Physical Examination Form (CG-719K)\r\n    CG-719K Instruction Guide\r\n    Common Errors on the CG-719K Form\r\n\r\nDISCLAIMER:\r\nUSCG practices, with respect to the physical and medical evaluation process, continually evolve to align with current medical standards of care and current safety standards. Although the current NVIC 04-08 details specific medical conditions and the recommended data for evaluation of these conditions, it is not all inclusive or definitive and may be subject to further review.','','full_html'),('node','site_page',0,54,54,'en',0,'Regional Exam Centers (REC)','','full_html'),('node','site_page',0,57,60,'en',0,'Checklists overview','','full_html'),('node','site_page',0,60,63,'en',0,'Drug Testing Content','','full_html'),('node','site_page',0,62,65,'en',0,'About NMC','','full_html'),('node','site_page',0,65,68,'en',0,'Contact NMC','','full_html'),('node','site_page',0,67,70,'en',0,'FEES Content','','full_html'),('node','site_page',0,70,76,'en',0,'TWIC Content','','full_html'),('node','site_page',0,71,77,'en',0,'STCW','','full_html'),('node','photo',0,74,80,'en',0,'<p>background image</p>','','full_html'),('node','photo',0,75,81,'en',0,'<p>Stcw Image</p>','','full_html'),('node','photo',0,77,83,'en',0,'<p>Medical Image</p>','','full_html'),('node','landing_page',0,79,85,'en',0,'<p>The mission of the National Maritime Center (NMC) is to issue credentials to mariners who are fully compliant with current regulations in the most effective and efficient manner possible.</p>','','full_html');
/*!40000 ALTER TABLE `field_data_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_content_owner`
--

DROP TABLE IF EXISTS `field_data_field_content_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_content_owner` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_content_owner_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_content_owner_nid` (`field_content_owner_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (field_content_owner)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_content_owner`
--

LOCK TABLES `field_data_field_content_owner` WRITE;
/*!40000 ALTER TABLE `field_data_field_content_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_content_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_display_title`
--

DROP TABLE IF EXISTS `field_data_field_display_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_display_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_display_title_value` varchar(255) DEFAULT NULL,
  `field_display_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_display_title_format` (`field_display_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 30 (field_display_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_display_title`
--

LOCK TABLES `field_data_field_display_title` WRITE;
/*!40000 ALTER TABLE `field_data_field_display_title` DISABLE KEYS */;
INSERT INTO `field_data_field_display_title` VALUES ('node','rotator',0,78,84,'und',0,'Slide Show',NULL);
/*!40000 ALTER TABLE `field_data_field_display_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_featured_items`
--

DROP TABLE IF EXISTS `field_data_field_featured_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_featured_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_items_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_items_nid` (`field_featured_items_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (field_featured_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_featured_items`
--

LOCK TABLES `field_data_field_featured_items` WRITE;
/*!40000 ALTER TABLE `field_data_field_featured_items` DISABLE KEYS */;
INSERT INTO `field_data_field_featured_items` VALUES ('node','rotator',0,78,84,'und',0,51),('node','rotator',0,78,84,'und',1,71);
/*!40000 ALTER TABLE `field_data_field_featured_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_files`
--

DROP TABLE IF EXISTS `field_data_field_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_files` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_files_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_files_display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_files_description` text COMMENT 'A description of the file.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_files_fid` (`field_files_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (field_files)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_files`
--

LOCK TABLES `field_data_field_files` WRITE;
/*!40000 ALTER TABLE `field_data_field_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_job_title`
--

DROP TABLE IF EXISTS `field_data_field_job_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_job_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_job_title_value` varchar(255) DEFAULT NULL,
  `field_job_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_job_title_format` (`field_job_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 21 (field_job_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_job_title`
--

LOCK TABLES `field_data_field_job_title` WRITE;
/*!40000 ALTER TABLE `field_data_field_job_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_job_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_keywords`
--

DROP TABLE IF EXISTS `field_data_field_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_keywords` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_keywords_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_keywords_tid` (`field_keywords_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 8 (field_keywords)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_keywords`
--

LOCK TABLES `field_data_field_keywords` WRITE;
/*!40000 ALTER TABLE `field_data_field_keywords` DISABLE KEYS */;
INSERT INTO `field_data_field_keywords` VALUES ('node','site_page',0,54,54,'und',0,3),('node','site_page',0,57,60,'und',0,6),('node','site_page',0,60,63,'und',0,9),('node','site_page',0,62,65,'und',0,11),('node','site_page',0,65,68,'und',0,14),('node','site_page',0,67,70,'und',0,16),('node','site_page',0,70,76,'und',0,19),('node','site_page',0,71,77,'und',0,20);
/*!40000 ALTER TABLE `field_data_field_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_link_url`
--

DROP TABLE IF EXISTS `field_data_field_link_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_link_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_url_url` varchar(2048) DEFAULT NULL,
  `field_link_url_title` varchar(255) DEFAULT NULL,
  `field_link_url_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_link_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_link_url`
--

LOCK TABLES `field_data_field_link_url` WRITE;
/*!40000 ALTER TABLE `field_data_field_link_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_link_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_long_title`
--

DROP TABLE IF EXISTS `field_data_field_long_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_long_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_long_title_value` longtext,
  `field_long_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_long_title_format` (`field_long_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 9 (field_long_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_long_title`
--

LOCK TABLES `field_data_field_long_title` WRITE;
/*!40000 ALTER TABLE `field_data_field_long_title` DISABLE KEYS */;
INSERT INTO `field_data_field_long_title` VALUES ('node','site_page',0,51,53,'und',0,'Medical Applications',NULL),('node','site_page',0,54,54,'und',0,'RECs',NULL),('node','site_page',0,57,60,'und',0,'Checklists',NULL),('node','site_page',0,60,63,'und',0,'Drug Testing',NULL),('node','site_page',0,62,65,'und',0,'About ',NULL),('node','site_page',0,65,68,'und',0,'Contact Us',NULL),('node','site_page',0,67,70,'und',0,'FEES',NULL),('node','site_page',0,70,76,'und',0,'TWIC ',NULL),('node','site_page',0,71,77,'und',0,'STCW',NULL);
/*!40000 ALTER TABLE `field_data_field_long_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_main_image`
--

DROP TABLE IF EXISTS `field_data_field_main_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_main_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_main_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_main_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_main_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_main_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_main_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_main_image_fid` (`field_main_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 6 (field_main_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_main_image`
--

LOCK TABLES `field_data_field_main_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_main_image` DISABLE KEYS */;
INSERT INTO `field_data_field_main_image` VALUES ('node','photo',0,74,80,'und',0,93,'','',225,225),('node','photo',0,75,81,'und',0,111,'','',620,212),('node','photo',0,77,83,'und',0,113,'','',620,212);
/*!40000 ALTER TABLE `field_data_field_main_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photo`
--

DROP TABLE IF EXISTS `field_data_field_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_photo_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_photo_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_photo_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_photo_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_fid` (`field_photo_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 32 (field_photo)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photo`
--

LOCK TABLES `field_data_field_photo` WRITE;
/*!40000 ALTER TABLE `field_data_field_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photo_copyright`
--

DROP TABLE IF EXISTS `field_data_field_photo_copyright`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photo_copyright` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_copyright_value` varchar(255) DEFAULT NULL,
  `field_photo_copyright_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_copyright_format` (`field_photo_copyright_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 16 (field_photo_copyright)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photo_copyright`
--

LOCK TABLES `field_data_field_photo_copyright` WRITE;
/*!40000 ALTER TABLE `field_data_field_photo_copyright` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_photo_copyright` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photo_date`
--

DROP TABLE IF EXISTS `field_data_field_photo_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photo_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 17 (field_photo_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photo_date`
--

LOCK TABLES `field_data_field_photo_date` WRITE;
/*!40000 ALTER TABLE `field_data_field_photo_date` DISABLE KEYS */;
INSERT INTO `field_data_field_photo_date` VALUES ('node','photo',0,74,80,'und',0,'2016-06-08 00:00:00'),('node','photo',0,75,81,'und',0,'2016-06-13 00:00:00'),('node','photo',0,77,83,'und',0,'2016-06-13 00:00:00');
/*!40000 ALTER TABLE `field_data_field_photo_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photo_location`
--

DROP TABLE IF EXISTS `field_data_field_photo_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photo_location` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_location_value` varchar(255) DEFAULT NULL,
  `field_photo_location_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_location_format` (`field_photo_location_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 18 (field_photo_location)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photo_location`
--

LOCK TABLES `field_data_field_photo_location` WRITE;
/*!40000 ALTER TABLE `field_data_field_photo_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_photo_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photographer_name`
--

DROP TABLE IF EXISTS `field_data_field_photographer_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photographer_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photographer_name_value` varchar(255) DEFAULT NULL,
  `field_photographer_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photographer_name_format` (`field_photographer_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (field_photographer_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photographer_name`
--

LOCK TABLES `field_data_field_photographer_name` WRITE;
/*!40000 ALTER TABLE `field_data_field_photographer_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_photographer_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_photographer_org`
--

DROP TABLE IF EXISTS `field_data_field_photographer_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_photographer_org` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photographer_org_value` varchar(255) DEFAULT NULL,
  `field_photographer_org_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photographer_org_format` (`field_photographer_org_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (field_photographer_org)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_photographer_org`
--

LOCK TABLES `field_data_field_photographer_org` WRITE;
/*!40000 ALTER TABLE `field_data_field_photographer_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_photographer_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_press_release_date`
--

DROP TABLE IF EXISTS `field_data_field_press_release_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_press_release_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_press_release_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 10 (field_press_release_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_press_release_date`
--

LOCK TABLES `field_data_field_press_release_date` WRITE;
/*!40000 ALTER TABLE `field_data_field_press_release_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_press_release_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_address`
--

DROP TABLE IF EXISTS `field_data_field_profile_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_address_value` longtext,
  `field_profile_address_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_address_format` (`field_profile_address_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_profile_address)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_address`
--

LOCK TABLES `field_data_field_profile_address` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_email`
--

DROP TABLE IF EXISTS `field_data_field_profile_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_email_value` varchar(60) DEFAULT NULL,
  `field_profile_email_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_email_format` (`field_profile_email_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_profile_email)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_email`
--

LOCK TABLES `field_data_field_profile_email` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_first_name`
--

DROP TABLE IF EXISTS `field_data_field_profile_first_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_first_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_first_name_value` varchar(60) DEFAULT NULL,
  `field_profile_first_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_first_name_format` (`field_profile_first_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 24 (field_profile_first_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_first_name`
--

LOCK TABLES `field_data_field_profile_first_name` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_first_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_first_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_last_name`
--

DROP TABLE IF EXISTS `field_data_field_profile_last_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_last_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_last_name_value` varchar(60) DEFAULT NULL,
  `field_profile_last_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_last_name_format` (`field_profile_last_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 25 (field_profile_last_name)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_last_name`
--

LOCK TABLES `field_data_field_profile_last_name` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_last_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_last_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_organization`
--

DROP TABLE IF EXISTS `field_data_field_profile_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_organization` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_organization_value` varchar(60) DEFAULT NULL,
  `field_profile_organization_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_organization_format` (`field_profile_organization_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 26 (field_profile_organization)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_organization`
--

LOCK TABLES `field_data_field_profile_organization` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_phone`
--

DROP TABLE IF EXISTS `field_data_field_profile_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_phone` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_phone_value` varchar(20) DEFAULT NULL,
  `field_profile_phone_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_phone_format` (`field_profile_phone_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 27 (field_profile_phone)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_phone`
--

LOCK TABLES `field_data_field_profile_phone` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_photo`
--

DROP TABLE IF EXISTS `field_data_field_profile_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_photo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_photo_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_profile_photo_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_profile_photo_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_profile_photo_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_profile_photo_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_photo_fid` (`field_profile_photo_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 28 (field_profile_photo)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_photo`
--

LOCK TABLES `field_data_field_profile_photo` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_profile_user`
--

DROP TABLE IF EXISTS `field_data_field_profile_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_profile_user` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_user_uid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_user_uid` (`field_profile_user_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 29 (field_profile_user)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_profile_user`
--

LOCK TABLES `field_data_field_profile_user` WRITE;
/*!40000 ALTER TABLE `field_data_field_profile_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_profile_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_related_content`
--

DROP TABLE IF EXISTS `field_data_field_related_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_related_content` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_related_content_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_related_content_nid` (`field_related_content_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 11 (field_related_content)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_related_content`
--

LOCK TABLES `field_data_field_related_content` WRITE;
/*!40000 ALTER TABLE `field_data_field_related_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_related_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_data_field_thumbnail_image`
--

DROP TABLE IF EXISTS `field_data_field_thumbnail_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_thumbnail_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_thumbnail_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_thumbnail_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_thumbnail_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_thumbnail_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_thumbnail_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_thumbnail_image_fid` (`field_thumbnail_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_thumbnail_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_thumbnail_image`
--

LOCK TABLES `field_data_field_thumbnail_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_thumbnail_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_data_field_thumbnail_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_group`
--

DROP TABLE IF EXISTS `field_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a group',
  `identifier` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unique string identifier for a group.',
  `group_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The name of this group.',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `mode` varchar(128) NOT NULL DEFAULT '',
  `parent_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The parent name for a group',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the group properties that do not warrant a dedicated column.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `group_name` (`group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Table that contains field group entries and settings.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_group`
--

LOCK TABLES `field_group` WRITE;
/*!40000 ALTER TABLE `field_group` DISABLE KEYS */;
INSERT INTO `field_group` VALUES (1,'group_photo_data|node|photo|form','group_photo_data','node','photo','form','','a:5:{s:5:\"label\";s:10:\"Photo Data\";s:6:\"weight\";s:1:\"3\";s:8:\"children\";a:5:{i:0;s:21:\"field_photo_copyright\";i:1;s:16:\"field_photo_date\";i:2;s:20:\"field_photo_location\";i:3;s:23:\"field_photographer_name\";i:4;s:22:\"field_photographer_org\";}s:11:\"format_type\";s:8:\"fieldset\";s:15:\"format_settings\";a:3:{s:5:\"label\";s:10:\"Photo Data\";s:17:\"instance_settings\";a:3:{s:15:\"required_fields\";i:0;s:7:\"classes\";s:38:\" group-photo-data field-group-fieldset\";s:11:\"description\";s:0:\"\";}s:9:\"formatter\";s:11:\"collapsible\";}}');
/*!40000 ALTER TABLE `field_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_body`
--

LOCK TABLES `field_revision_body` WRITE;
/*!40000 ALTER TABLE `field_revision_body` DISABLE KEYS */;
INSERT INTO `field_revision_body` VALUES ('node','site_page',0,51,53,'und',0,'CG-719K Credential Medical Evaluation Report\r\n\r\nThe Merchant Mariner Physical Exam (CG-719K) is required for Officers and Mariners with a qualified rating. The examination and form must be completed within 12 months of application date (36 months if applying for Raise of Grade). The medical provider completing the required examination must be a physician, physician assistant, or nurse practitioner who is licensed in the United States or one of the U.S. territories.\r\n\r\n    Merchant Mariner Physical Examination Form (CG-719K)\r\n    CG-719K Instruction Guide\r\n    Common Errors on the CG-719K Form\r\n\r\nDISCLAIMER:\r\nUSCG practices, with respect to the physical and medical evaluation process, continually evolve to align with current medical standards of care and current safety standards. Although the current NVIC 04-08 details specific medical conditions and the recommended data for evaluation of these conditions, it is not all inclusive or definitive and may be subject to further review.','','full_html'),('node','site_page',0,54,54,'en',0,'Regional Exam Centers (REC)','','full_html'),('node','site_page',0,54,57,'en',0,'Regional Exam Centers (REC)','','full_html'),('node','site_page',0,57,60,'en',0,'Checklists overview','','full_html'),('node','site_page',0,60,63,'en',0,'Drug Testing Content','','full_html'),('node','site_page',0,62,65,'en',0,'About NMC','','full_html'),('node','site_page',0,65,68,'en',0,'Contact NMC','','full_html'),('node','site_page',0,67,70,'en',0,'FEES Content','','full_html'),('node','site_page',0,70,73,'en',0,'TWIC Content','','full_html'),('node','site_page',0,70,76,'en',0,'TWIC Content','','full_html'),('node','site_page',0,71,77,'en',0,'STCW','','full_html'),('node','photo',0,74,80,'en',0,'<p>background image</p>','','full_html'),('node','photo',0,75,81,'en',0,'<p>Stcw Image</p>','','full_html'),('node','photo',0,77,83,'en',0,'<p>Medical Image</p>','','full_html'),('node','landing_page',0,79,85,'en',0,'<p>The mission of the National Maritime Center (NMC) is to issue credentials to mariners who are fully compliant with current regulations in the most effective and efficient manner possible.</p>','','full_html');
/*!40000 ALTER TABLE `field_revision_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_content_owner`
--

DROP TABLE IF EXISTS `field_revision_field_content_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_content_owner` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_content_owner_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_content_owner_nid` (`field_content_owner_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (field_content_owner)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_content_owner`
--

LOCK TABLES `field_revision_field_content_owner` WRITE;
/*!40000 ALTER TABLE `field_revision_field_content_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_content_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_display_title`
--

DROP TABLE IF EXISTS `field_revision_field_display_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_display_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_display_title_value` varchar(255) DEFAULT NULL,
  `field_display_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_display_title_format` (`field_display_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 30 (field_display_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_display_title`
--

LOCK TABLES `field_revision_field_display_title` WRITE;
/*!40000 ALTER TABLE `field_revision_field_display_title` DISABLE KEYS */;
INSERT INTO `field_revision_field_display_title` VALUES ('node','rotator',0,78,84,'und',0,'Slide Show',NULL);
/*!40000 ALTER TABLE `field_revision_field_display_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_featured_items`
--

DROP TABLE IF EXISTS `field_revision_field_featured_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_featured_items` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_featured_items_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_featured_items_nid` (`field_featured_items_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (field_featured_items)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_featured_items`
--

LOCK TABLES `field_revision_field_featured_items` WRITE;
/*!40000 ALTER TABLE `field_revision_field_featured_items` DISABLE KEYS */;
INSERT INTO `field_revision_field_featured_items` VALUES ('node','rotator',0,78,84,'und',0,51),('node','rotator',0,78,84,'und',1,71);
/*!40000 ALTER TABLE `field_revision_field_featured_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_files`
--

DROP TABLE IF EXISTS `field_revision_field_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_files` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_files_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_files_display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_files_description` text COMMENT 'A description of the file.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_files_fid` (`field_files_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (field_files)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_files`
--

LOCK TABLES `field_revision_field_files` WRITE;
/*!40000 ALTER TABLE `field_revision_field_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_job_title`
--

DROP TABLE IF EXISTS `field_revision_field_job_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_job_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_job_title_value` varchar(255) DEFAULT NULL,
  `field_job_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_job_title_format` (`field_job_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 21 (field_job_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_job_title`
--

LOCK TABLES `field_revision_field_job_title` WRITE;
/*!40000 ALTER TABLE `field_revision_field_job_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_job_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_keywords`
--

DROP TABLE IF EXISTS `field_revision_field_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_keywords` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_keywords_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_keywords_tid` (`field_keywords_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 8 (field_keywords)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_keywords`
--

LOCK TABLES `field_revision_field_keywords` WRITE;
/*!40000 ALTER TABLE `field_revision_field_keywords` DISABLE KEYS */;
INSERT INTO `field_revision_field_keywords` VALUES ('node','site_page',0,54,54,'und',0,3),('node','site_page',0,54,57,'und',0,3),('node','site_page',0,57,60,'und',0,6),('node','site_page',0,60,63,'und',0,9),('node','site_page',0,62,65,'und',0,11),('node','site_page',0,65,68,'und',0,14),('node','site_page',0,67,70,'und',0,16),('node','site_page',0,70,76,'und',0,19),('node','site_page',0,71,77,'und',0,20);
/*!40000 ALTER TABLE `field_revision_field_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_link_url`
--

DROP TABLE IF EXISTS `field_revision_field_link_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_link_url` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_url_url` varchar(2048) DEFAULT NULL,
  `field_link_url_title` varchar(255) DEFAULT NULL,
  `field_link_url_attributes` mediumtext,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_link_url)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_link_url`
--

LOCK TABLES `field_revision_field_link_url` WRITE;
/*!40000 ALTER TABLE `field_revision_field_link_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_link_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_long_title`
--

DROP TABLE IF EXISTS `field_revision_field_long_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_long_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_long_title_value` longtext,
  `field_long_title_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_long_title_format` (`field_long_title_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 9 (field_long_title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_long_title`
--

LOCK TABLES `field_revision_field_long_title` WRITE;
/*!40000 ALTER TABLE `field_revision_field_long_title` DISABLE KEYS */;
INSERT INTO `field_revision_field_long_title` VALUES ('node','site_page',0,51,53,'und',0,'Medical Applications',NULL),('node','site_page',0,54,54,'und',0,'RECs',NULL),('node','site_page',0,54,57,'und',0,'RECs',NULL),('node','site_page',0,57,60,'und',0,'Checklists',NULL),('node','site_page',0,60,63,'und',0,'Drug Testing',NULL),('node','site_page',0,62,65,'und',0,'About ',NULL),('node','site_page',0,65,68,'und',0,'Contact Us',NULL),('node','site_page',0,67,70,'und',0,'FEES',NULL),('node','site_page',0,70,73,'und',0,'TWIC ',NULL),('node','site_page',0,70,76,'und',0,'TWIC ',NULL),('node','site_page',0,71,77,'und',0,'STCW',NULL);
/*!40000 ALTER TABLE `field_revision_field_long_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_main_image`
--

DROP TABLE IF EXISTS `field_revision_field_main_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_main_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_main_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_main_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_main_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_main_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_main_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_main_image_fid` (`field_main_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 6 (field_main_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_main_image`
--

LOCK TABLES `field_revision_field_main_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_main_image` DISABLE KEYS */;
INSERT INTO `field_revision_field_main_image` VALUES ('node','photo',0,74,80,'und',0,93,'','',225,225),('node','photo',0,75,81,'und',0,111,'','',620,212),('node','photo',0,77,83,'und',0,113,'','',620,212);
/*!40000 ALTER TABLE `field_revision_field_main_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photo`
--

DROP TABLE IF EXISTS `field_revision_field_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_photo_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_photo_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_photo_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_photo_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_fid` (`field_photo_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 32 (field_photo)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photo`
--

LOCK TABLES `field_revision_field_photo` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photo_copyright`
--

DROP TABLE IF EXISTS `field_revision_field_photo_copyright`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photo_copyright` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_copyright_value` varchar(255) DEFAULT NULL,
  `field_photo_copyright_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_copyright_format` (`field_photo_copyright_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 16 (field_photo...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photo_copyright`
--

LOCK TABLES `field_revision_field_photo_copyright` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photo_copyright` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_photo_copyright` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photo_date`
--

DROP TABLE IF EXISTS `field_revision_field_photo_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photo_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 17 (field_photo_date)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photo_date`
--

LOCK TABLES `field_revision_field_photo_date` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photo_date` DISABLE KEYS */;
INSERT INTO `field_revision_field_photo_date` VALUES ('node','photo',0,74,80,'und',0,'2016-06-08 00:00:00'),('node','photo',0,75,81,'und',0,'2016-06-13 00:00:00'),('node','photo',0,77,83,'und',0,'2016-06-13 00:00:00');
/*!40000 ALTER TABLE `field_revision_field_photo_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photo_location`
--

DROP TABLE IF EXISTS `field_revision_field_photo_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photo_location` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photo_location_value` varchar(255) DEFAULT NULL,
  `field_photo_location_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photo_location_format` (`field_photo_location_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 18 (field_photo_location)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photo_location`
--

LOCK TABLES `field_revision_field_photo_location` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photo_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_photo_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photographer_name`
--

DROP TABLE IF EXISTS `field_revision_field_photographer_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photographer_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photographer_name_value` varchar(255) DEFAULT NULL,
  `field_photographer_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photographer_name_format` (`field_photographer_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (field_photographer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photographer_name`
--

LOCK TABLES `field_revision_field_photographer_name` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photographer_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_photographer_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_photographer_org`
--

DROP TABLE IF EXISTS `field_revision_field_photographer_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_photographer_org` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_photographer_org_value` varchar(255) DEFAULT NULL,
  `field_photographer_org_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_photographer_org_format` (`field_photographer_org_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (field_photographer...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_photographer_org`
--

LOCK TABLES `field_revision_field_photographer_org` WRITE;
/*!40000 ALTER TABLE `field_revision_field_photographer_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_photographer_org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_press_release_date`
--

DROP TABLE IF EXISTS `field_revision_field_press_release_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_press_release_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_press_release_date_value` datetime DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 10 (field_press...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_press_release_date`
--

LOCK TABLES `field_revision_field_press_release_date` WRITE;
/*!40000 ALTER TABLE `field_revision_field_press_release_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_press_release_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_address`
--

DROP TABLE IF EXISTS `field_revision_field_profile_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_address` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_address_value` longtext,
  `field_profile_address_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_address_format` (`field_profile_address_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_profile...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_address`
--

LOCK TABLES `field_revision_field_profile_address` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_email`
--

DROP TABLE IF EXISTS `field_revision_field_profile_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_email_value` varchar(60) DEFAULT NULL,
  `field_profile_email_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_email_format` (`field_profile_email_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_profile_email)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_email`
--

LOCK TABLES `field_revision_field_profile_email` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_first_name`
--

DROP TABLE IF EXISTS `field_revision_field_profile_first_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_first_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_first_name_value` varchar(60) DEFAULT NULL,
  `field_profile_first_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_first_name_format` (`field_profile_first_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 24 (field_profile...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_first_name`
--

LOCK TABLES `field_revision_field_profile_first_name` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_first_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_first_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_last_name`
--

DROP TABLE IF EXISTS `field_revision_field_profile_last_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_last_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_last_name_value` varchar(60) DEFAULT NULL,
  `field_profile_last_name_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_last_name_format` (`field_profile_last_name_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 25 (field_profile_last...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_last_name`
--

LOCK TABLES `field_revision_field_profile_last_name` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_last_name` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_last_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_organization`
--

DROP TABLE IF EXISTS `field_revision_field_profile_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_organization` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_organization_value` varchar(60) DEFAULT NULL,
  `field_profile_organization_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_organization_format` (`field_profile_organization_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 26 (field_profile...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_organization`
--

LOCK TABLES `field_revision_field_profile_organization` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_phone`
--

DROP TABLE IF EXISTS `field_revision_field_profile_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_phone` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_phone_value` varchar(20) DEFAULT NULL,
  `field_profile_phone_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_phone_format` (`field_profile_phone_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 27 (field_profile_phone)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_phone`
--

LOCK TABLES `field_revision_field_profile_phone` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_photo`
--

DROP TABLE IF EXISTS `field_revision_field_profile_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_photo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_photo_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_profile_photo_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_profile_photo_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_profile_photo_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_profile_photo_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_photo_fid` (`field_profile_photo_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 28 (field_profile_photo)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_photo`
--

LOCK TABLES `field_revision_field_profile_photo` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_profile_user`
--

DROP TABLE IF EXISTS `field_revision_field_profile_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_profile_user` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profile_user_uid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_profile_user_uid` (`field_profile_user_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 29 (field_profile_user)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_profile_user`
--

LOCK TABLES `field_revision_field_profile_user` WRITE;
/*!40000 ALTER TABLE `field_revision_field_profile_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_profile_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_related_content`
--

DROP TABLE IF EXISTS `field_revision_field_related_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_related_content` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_related_content_nid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_related_content_nid` (`field_related_content_nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 11 (field_related...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_related_content`
--

LOCK TABLES `field_revision_field_related_content` WRITE;
/*!40000 ALTER TABLE `field_revision_field_related_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_related_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_revision_field_thumbnail_image`
--

DROP TABLE IF EXISTS `field_revision_field_thumbnail_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_thumbnail_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_thumbnail_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_thumbnail_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_thumbnail_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_thumbnail_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_thumbnail_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_thumbnail_image_fid` (`field_thumbnail_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_thumbnail_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_thumbnail_image`
--

LOCK TABLES `field_revision_field_thumbnail_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_thumbnail_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_revision_field_thumbnail_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_managed`
--

LOCK TABLES `file_managed` WRITE;
/*!40000 ALTER TABLE `file_managed` DISABLE KEYS */;
INSERT INTO `file_managed` VALUES (1,0,'dhs-ntas-logo.jpg','public://dhs-ntas-logo_1.jpg','image/jpeg',118940,1,1379957182),(3,0,'wis_flood2008jpg-784224.jpg','public://wis_flood2008jpg-784224_3.jpg','image/jpeg',531464,1,1379957182),(5,0,'wis_flood2008jpg-784224.jpg','public://wis_flood2008jpg-784224_5.jpg','image/jpeg',531464,1,1379957182),(7,0,'fema_uscg_katrina_rescue_8th_anniv.jpg','public://fema_uscg_katrina_rescue_8th_anniv_1.jpg','image/jpeg',174032,1,1379957182),(9,0,'cyber-release-1.jpg','public://cyber-release-1_3.jpg','image/jpeg',121384,1,1379957182),(11,0,'cyber-release-2.jpg','public://cyber-release-2_3.jpg','image/jpeg',106616,1,1379957182),(13,0,'110609washingtondc_lg.jpg','public://110609washingtondc_lg_3.jpg','image/jpeg',224764,1,1379957182),(15,0,'582789_472582102753015_1228686045_n.jpg','public://582789_472582102753015_1228686045_n_8.jpg','image/jpeg',365768,1,1379957182),(17,0,'110609washingtondc_lg.jpg','public://110609washingtondc_lg_5.jpg','image/jpeg',224764,1,1379957182),(19,0,'Natz-739619.JPG','public://Natz-739619_3.JPG','image/jpeg',277568,1,1379957182),(21,0,'2010-07-06-uscg-vertical-insertion-exercise-aboard-uss-freedom-honolulu.JPG','public://2010-07-06-uscg-vertical-insertion-exercise-aboard-uss-freedom-honolulu_3.JPG','image/jpeg',80108,1,1379957182),(23,0,'2010-07-06-uscg-vertical-insertion-exercise-aboard-uss-freedom-honolulu.JPG','public://2010-07-06-uscg-vertical-insertion-exercise-aboard-uss-freedom-honolulu_5.JPG','image/jpeg',80108,1,1379957182),(25,0,'white-house-square.JPG','public://white-house-square_1.JPG','image/jpeg',11840,1,1379957182),(27,0,'usa-gov.jpg','public://usa-gov_1.jpg','image/jpeg',5884,1,1379957182),(29,0,'s1-220.jpg','public://s1-220_1.jpg','image/jpeg',33512,1,1379957182),(31,0,'S4_Rect.jpg','public://S4_Rect_2.jpg','image/jpeg',41160,1,1379957182),(33,0,'110621washingtondc_lg-640.jpg','public://110621washingtondc_lg-640_1.jpg','image/jpeg',127520,1,1379957182),(35,0,'47206-640_0.jpg','public://47206-640_0_1.jpg','image/jpeg',154432,1,1379957182),(37,0,'logo-ready-170.jpg','public://logo-ready-170_1.jpg','image/jpeg',11084,1,1379957182),(39,0,'outreach_000.jpg','public://outreach_000_3.jpg','image/jpeg',149040,1,1379957182),(41,0,'582789_472582102753015_1228686045_n.jpg','public://582789_472582102753015_1228686045_n_10.jpg','image/jpeg',365768,1,1379957182),(43,0,'pci-card-lucian-tirabassi-640.jpg','public://pci-card-lucian-tirabassi-640_3.jpg','image/jpeg',124012,1,1379957182),(45,0,'2011-09-23-uscis-american-by-choice-ceremony_0.JPG','public://2011-09-23-uscis-american-by-choice-ceremony_0_3.JPG','image/jpeg',117264,1,1379957182),(47,0,'cyber-release-2.jpg','public://cyber-release-2_5.jpg','image/jpeg',106616,1,1379957182),(49,0,'motherboard-779293.jpg','public://motherboard-779293_1.jpg','image/jpeg',384840,1,1379957182),(51,0,'outreach_000.jpg','public://outreach_000_5.jpg','image/jpeg',149040,1,1379957182),(53,0,'2011-09-23-uscis-american-by-choice-ceremony_0.JPG','public://2011-09-23-uscis-american-by-choice-ceremony_0_5.JPG','image/jpeg',117264,1,1379957182),(55,0,'bp023-640.jpg','public://bp023-640_3.jpg','image/jpeg',95992,1,1379957182),(57,0,'2011-10-31-uscis-military-naturalization-cermony-phillipines.JPG','public://2011-10-31-uscis-military-naturalization-cermony-phillipines_1.JPG','image/jpeg',146272,1,1379957182),(59,0,'harbor-flag-640.jpg','public://harbor-flag-640_1.jpg','image/jpeg',121192,1,1379957182),(61,0,'bp023-640.jpg','public://bp023-640_5.jpg','image/jpeg',95992,1,1379957182),(63,0,'Picture 029.jpg','public://Picture 029_1.jpg','image/jpeg',403180,1,1379957182),(65,0,'cyber-release-1.jpg','public://cyber-release-1_5.jpg','image/jpeg',121384,1,1379957182),(67,0,'pci-card-lucian-tirabassi-640.jpg','public://pci-card-lucian-tirabassi-640_5.jpg','image/jpeg',124012,1,1379957182),(69,0,'46890.jpg','public://46890_1.jpg','image/jpeg',71448,1,1379957182),(71,0,'Natz-739619.JPG','public://Natz-739619_5.JPG','image/jpeg',277568,1,1379957182),(73,0,'539673_474892132522012_998931845_n.jpg','public://539673_474892132522012_998931845_n_1.jpg','image/jpeg',152028,1,1379957182),(88,27,'applications.jpg','public://applications.jpg','image/jpeg',60901,1,1464971869),(93,27,'dark_background.png','public://dark_background_0.png','image/png',132661,1,1465397938),(111,27,'applications.png','public://applications.png','image/png',485807,1,1465838413),(113,27,'medical.jpg','public://medical.jpg','image/jpeg',73891,1,1465838562),(116,27,'Building_Pictures_012.jpg','public://default_images/Building_Pictures_012.jpg','image/jpeg',95442,1,1465933392);
/*!40000 ALTER TABLE `file_managed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_usage`
--

LOCK TABLES `file_usage` WRITE;
/*!40000 ALTER TABLE `file_usage` DISABLE KEYS */;
INSERT INTO `file_usage` VALUES (88,'file','node',35,1),(93,'file','node',74,2),(111,'file','node',75,2),(113,'file','node',77,2),(116,'image','default_image',32,1);
/*!40000 ALTER TABLE `file_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter`
--

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_autop',0,0,'a:0:{}'),('filtered_html','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('filtered_html','filter','filter_htmlcorrector',-45,1,'a:0:{}'),('filtered_html','filter','filter_html_escape',-10,0,'a:0:{}'),('filtered_html','filter','filter_url',-49,1,'a:1:{s:17:\"filter_url_length\";s:2:\"72\";}'),('filtered_html','wysiwyg_filter','wysiwyg',-48,1,'a:19:{s:14:\"valid_elements\";s:160:\"a[!href|target<_blank|title],\ndiv[align<center?justify?left?right],\np[align<center?justify?left?right],\nbr,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd\";s:14:\"allow_comments\";s:1:\"0\";s:15:\"nofollow_policy\";s:8:\"disabled\";s:16:\"nofollow_domains\";a:0:{}s:11:\"style_color\";a:7:{s:5:\"color\";i:0;s:10:\"background\";i:0;s:16:\"background-color\";i:0;s:16:\"background-image\";i:0;s:17:\"background-repeat\";i:0;s:21:\"background-attachment\";i:0;s:19:\"background-position\";i:0;}s:10:\"style_font\";a:8:{s:4:\"font\";i:0;s:11:\"font-family\";i:0;s:9:\"font-size\";i:0;s:16:\"font-size-adjust\";i:0;s:12:\"font-stretch\";i:0;s:10:\"font-style\";i:0;s:12:\"font-variant\";i:0;s:11:\"font-weight\";i:0;}s:10:\"style_text\";a:9:{s:10:\"text-align\";i:0;s:15:\"text-decoration\";i:0;s:11:\"text-indent\";i:0;s:14:\"text-transform\";i:0;s:14:\"letter-spacing\";i:0;s:12:\"word-spacing\";i:0;s:11:\"white-space\";i:0;s:9:\"direction\";i:0;s:12:\"unicode-bidi\";i:0;}s:9:\"style_box\";a:10:{s:6:\"margin\";i:0;s:10:\"margin-top\";i:0;s:12:\"margin-right\";i:0;s:13:\"margin-bottom\";i:0;s:11:\"margin-left\";i:0;s:7:\"padding\";i:0;s:11:\"padding-top\";i:0;s:13:\"padding-right\";i:0;s:14:\"padding-bottom\";i:0;s:12:\"padding-left\";i:0;}s:14:\"style_border-1\";a:10:{s:6:\"border\";i:0;s:10:\"border-top\";i:0;s:12:\"border-right\";i:0;s:13:\"border-bottom\";i:0;s:11:\"border-left\";i:0;s:12:\"border-width\";i:0;s:16:\"border-top-width\";i:0;s:18:\"border-right-width\";i:0;s:19:\"border-bottom-width\";i:0;s:17:\"border-left-width\";i:0;}s:14:\"style_border-2\";a:10:{s:12:\"border-color\";i:0;s:16:\"border-top-color\";i:0;s:18:\"border-right-color\";i:0;s:19:\"border-bottom-color\";i:0;s:17:\"border-left-color\";i:0;s:12:\"border-style\";i:0;s:16:\"border-top-style\";i:0;s:18:\"border-right-style\";i:0;s:19:\"border-bottom-style\";i:0;s:17:\"border-left-style\";i:0;}s:15:\"style_dimension\";a:7:{s:6:\"height\";i:0;s:11:\"line-height\";i:0;s:10:\"max-height\";i:0;s:9:\"max-width\";i:0;s:10:\"min-height\";i:0;s:9:\"min-width\";i:0;s:5:\"width\";i:0;}s:17:\"style_positioning\";a:8:{s:6:\"bottom\";i:0;s:4:\"clip\";i:0;s:4:\"left\";i:0;s:8:\"overflow\";i:0;s:5:\"right\";i:0;s:3:\"top\";i:0;s:14:\"vertical-align\";i:0;s:7:\"z-index\";i:0;}s:12:\"style_layout\";a:5:{s:5:\"clear\";i:0;s:7:\"display\";i:0;s:5:\"float\";i:0;s:8:\"position\";i:0;s:10:\"visibility\";i:0;}s:10:\"style_list\";a:4:{s:10:\"list-style\";i:0;s:16:\"list-style-image\";i:0;s:19:\"list-style-position\";i:0;s:15:\"list-style-type\";i:0;}s:11:\"style_table\";a:5:{s:15:\"border-collapse\";i:0;s:14:\"border-spacing\";i:0;s:12:\"caption-side\";i:0;s:11:\"empty-cells\";i:0;s:12:\"table-layout\";i:0;}s:10:\"style_user\";a:6:{s:6:\"cursor\";i:0;s:7:\"outline\";i:0;s:13:\"outline-width\";i:0;s:13:\"outline-style\";i:0;s:13:\"outline-color\";i:0;s:4:\"zoom\";i:0;}s:18:\"rule_valid_classes\";a:0:{}s:14:\"rule_valid_ids\";a:0:{}s:15:\"rule_style_urls\";a:0:{}}'),('full_html','filter','filter_autop',1,1,'a:0:{}'),('full_html','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('full_html','filter','filter_htmlcorrector',10,1,'a:0:{}'),('full_html','filter','filter_html_escape',-10,0,'a:0:{}'),('full_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";s:2:\"72\";}'),('full_html','wysiwyg_filter','wysiwyg',0,0,'a:19:{s:14:\"valid_elements\";s:160:\"a[!href|target<_blank|title],\ndiv[align<center?justify?left?right],\np[align<center?justify?left?right],\nbr,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd\";s:14:\"allow_comments\";i:0;s:15:\"nofollow_policy\";s:9:\"whitelist\";s:16:\"nofollow_domains\";a:1:{i:0;s:25:\"edit-wcms-testint.dhs.gov\";}s:11:\"style_color\";a:0:{}s:10:\"style_font\";a:0:{}s:10:\"style_text\";a:0:{}s:9:\"style_box\";a:0:{}s:14:\"style_border-1\";a:0:{}s:14:\"style_border-2\";a:0:{}s:15:\"style_dimension\";a:0:{}s:17:\"style_positioning\";a:0:{}s:12:\"style_layout\";a:0:{}s:10:\"style_list\";a:0:{}s:11:\"style_table\";a:0:{}s:10:\"style_user\";a:0:{}s:18:\"rule_valid_classes\";a:0:{}s:14:\"rule_valid_ids\";a:0:{}s:15:\"rule_style_urls\";a:0:{}}'),('plain_text','filter','filter_autop',2,1,'a:0:{}'),('plain_text','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('plain_text','filter','filter_htmlcorrector',10,0,'a:0:{}'),('plain_text','filter','filter_html_escape',0,1,'a:0:{}'),('plain_text','filter','filter_url',1,1,'a:1:{s:17:\"filter_url_length\";i:72;}'),('plain_text','wysiwyg_filter','wysiwyg',0,0,'a:19:{s:14:\"valid_elements\";s:160:\"a[!href|target<_blank|title],\ndiv[align<center?justify?left?right],\np[align<center?justify?left?right],\nbr,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd\";s:14:\"allow_comments\";i:0;s:15:\"nofollow_policy\";s:9:\"whitelist\";s:16:\"nofollow_domains\";a:1:{i:0;s:25:\"edit-wcms-testint.dhs.gov\";}s:11:\"style_color\";a:0:{}s:10:\"style_font\";a:0:{}s:10:\"style_text\";a:0:{}s:9:\"style_box\";a:0:{}s:14:\"style_border-1\";a:0:{}s:14:\"style_border-2\";a:0:{}s:15:\"style_dimension\";a:0:{}s:17:\"style_positioning\";a:0:{}s:12:\"style_layout\";a:0:{}s:10:\"style_list\";a:0:{}s:11:\"style_table\";a:0:{}s:10:\"style_user\";a:0:{}s:18:\"rule_valid_classes\";a:0:{}s:14:\"rule_valid_ids\";a:0:{}s:15:\"rule_style_urls\";a:0:{}}'),('wysiwyg_html','filter','filter_autop',0,0,'a:0:{}'),('wysiwyg_html','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}'),('wysiwyg_html','filter','filter_htmlcorrector',10,1,'a:0:{}'),('wysiwyg_html','filter','filter_html_escape',-10,0,'a:0:{}'),('wysiwyg_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";s:2:\"72\";}'),('wysiwyg_html','wysiwyg_filter','wysiwyg',0,1,'a:19:{s:14:\"valid_elements\";s:160:\"a[!href|target<_blank|title],\ndiv[align<center?justify?left?right],\np[align<center?justify?left?right],\nbr,span,em,strong,cite,code,blockquote,ul,ol,li,dl,dt,dd\";s:14:\"allow_comments\";s:1:\"0\";s:15:\"nofollow_policy\";s:9:\"blacklist\";s:16:\"nofollow_domains\";a:0:{}s:11:\"style_color\";a:7:{s:5:\"color\";i:0;s:10:\"background\";i:0;s:16:\"background-color\";i:0;s:16:\"background-image\";i:0;s:17:\"background-repeat\";i:0;s:21:\"background-attachment\";i:0;s:19:\"background-position\";i:0;}s:10:\"style_font\";a:8:{s:4:\"font\";i:0;s:11:\"font-family\";i:0;s:9:\"font-size\";i:0;s:16:\"font-size-adjust\";i:0;s:12:\"font-stretch\";i:0;s:10:\"font-style\";i:0;s:12:\"font-variant\";i:0;s:11:\"font-weight\";i:0;}s:10:\"style_text\";a:9:{s:10:\"text-align\";i:0;s:15:\"text-decoration\";i:0;s:11:\"text-indent\";i:0;s:14:\"text-transform\";i:0;s:14:\"letter-spacing\";i:0;s:12:\"word-spacing\";i:0;s:11:\"white-space\";i:0;s:9:\"direction\";i:0;s:12:\"unicode-bidi\";i:0;}s:9:\"style_box\";a:10:{s:6:\"margin\";i:0;s:10:\"margin-top\";i:0;s:12:\"margin-right\";i:0;s:13:\"margin-bottom\";i:0;s:11:\"margin-left\";i:0;s:7:\"padding\";i:0;s:11:\"padding-top\";i:0;s:13:\"padding-right\";i:0;s:14:\"padding-bottom\";i:0;s:12:\"padding-left\";i:0;}s:14:\"style_border-1\";a:10:{s:6:\"border\";i:0;s:10:\"border-top\";i:0;s:12:\"border-right\";i:0;s:13:\"border-bottom\";i:0;s:11:\"border-left\";i:0;s:12:\"border-width\";i:0;s:16:\"border-top-width\";i:0;s:18:\"border-right-width\";i:0;s:19:\"border-bottom-width\";i:0;s:17:\"border-left-width\";i:0;}s:14:\"style_border-2\";a:10:{s:12:\"border-color\";i:0;s:16:\"border-top-color\";i:0;s:18:\"border-right-color\";i:0;s:19:\"border-bottom-color\";i:0;s:17:\"border-left-color\";i:0;s:12:\"border-style\";i:0;s:16:\"border-top-style\";i:0;s:18:\"border-right-style\";i:0;s:19:\"border-bottom-style\";i:0;s:17:\"border-left-style\";i:0;}s:15:\"style_dimension\";a:7:{s:6:\"height\";i:0;s:11:\"line-height\";i:0;s:10:\"max-height\";i:0;s:9:\"max-width\";i:0;s:10:\"min-height\";i:0;s:9:\"min-width\";i:0;s:5:\"width\";i:0;}s:17:\"style_positioning\";a:8:{s:6:\"bottom\";i:0;s:4:\"clip\";i:0;s:4:\"left\";i:0;s:8:\"overflow\";i:0;s:5:\"right\";i:0;s:3:\"top\";i:0;s:14:\"vertical-align\";i:0;s:7:\"z-index\";i:0;}s:12:\"style_layout\";a:5:{s:5:\"clear\";i:0;s:7:\"display\";i:0;s:5:\"float\";i:0;s:8:\"position\";i:0;s:10:\"visibility\";i:0;}s:10:\"style_list\";a:4:{s:10:\"list-style\";i:0;s:16:\"list-style-image\";i:0;s:19:\"list-style-position\";i:0;s:15:\"list-style-type\";i:0;}s:11:\"style_table\";a:5:{s:15:\"border-collapse\";i:0;s:14:\"border-spacing\";i:0;s:12:\"caption-side\";i:0;s:11:\"empty-cells\";i:0;s:12:\"table-layout\";i:0;}s:10:\"style_user\";a:6:{s:6:\"cursor\";i:0;s:7:\"outline\";i:0;s:13:\"outline-width\";i:0;s:13:\"outline-style\";i:0;s:13:\"outline-color\";i:0;s:4:\"zoom\";i:0;}s:18:\"rule_valid_classes\";a:0:{}s:14:\"rule_valid_ids\";a:0:{}s:15:\"rule_style_urls\";a:0:{}}');
/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_format`
--

LOCK TABLES `filter_format` WRITE;
/*!40000 ALTER TABLE `filter_format` DISABLE KEYS */;
INSERT INTO `filter_format` VALUES ('filtered_html','Filtered HTML',1,1,-8),('full_html','Full HTML',1,1,-10),('plain_text','Plain text',1,1,-7),('wysiwyg_html','WYSIWYG HTML',1,1,-9);
/*!40000 ALTER TABLE `filter_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flood`
--

DROP TABLE IF EXISTS `flood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flood`
--

LOCK TABLES `flood` WRITE;
/*!40000 ALTER TABLE `flood` DISABLE KEYS */;
/*!40000 ALTER TABLE `flood` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` VALUES (23,51,1464880662),(27,51,1465914045),(27,54,1466079121),(27,57,1466603061),(27,60,1466079114),(27,62,1466602893),(27,65,1466079113),(27,67,1466079119),(27,70,1465933808),(27,71,1465933804),(27,74,1465582003),(27,75,1465844373),(27,77,1465838586),(27,78,1465844401),(27,79,1466602882);
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_effects`
--

LOCK TABLES `image_effects` WRITE;
/*!40000 ALTER TABLE `image_effects` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_effects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_styles`
--

LOCK TABLES `image_styles` WRITE;
/*!40000 ALTER TABLE `image_styles` DISABLE KEYS */;
/*!40000 ALTER TABLE `image_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code, e.g. ’de’ or ’en-US’.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Language name in English.',
  `native` varchar(64) NOT NULL DEFAULT '' COMMENT 'Native language name.',
  `direction` int(11) NOT NULL DEFAULT '0' COMMENT 'Direction of language (Left-to-Right = 0, Right-to-Left = 1).',
  `enabled` int(11) NOT NULL DEFAULT '0' COMMENT 'Enabled flag (1 = Enabled, 0 = Disabled).',
  `plurals` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of plural indexes in this language.',
  `formula` varchar(255) NOT NULL DEFAULT '' COMMENT 'Plural formula in PHP code to evaluate to get plural indexes.',
  `domain` varchar(128) NOT NULL DEFAULT '' COMMENT 'Domain to use for this language.',
  `prefix` varchar(128) NOT NULL DEFAULT '' COMMENT 'Path prefix to use for this language.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight, used in lists of languages.',
  `javascript` varchar(64) NOT NULL DEFAULT '' COMMENT 'Location of JavaScript translation file.',
  PRIMARY KEY (`language`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of all available languages in the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES ('en','English','English',0,1,0,'','','',0,'');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_source`
--

DROP TABLE IF EXISTS `locales_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_source` (
  `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier of this string.',
  `location` longtext COMMENT 'Drupal path in case of online discovered translations or file path in case of imported strings.',
  `textgroup` varchar(255) NOT NULL DEFAULT 'default' COMMENT 'A module defined group of translations, see hook_locale().',
  `source` blob NOT NULL COMMENT 'The original string in English.',
  `context` varchar(255) NOT NULL DEFAULT '' COMMENT 'The context this string applies to.',
  `version` varchar(20) NOT NULL DEFAULT 'none' COMMENT 'Version of Drupal, where the string was last used (for locales optimization).',
  PRIMARY KEY (`lid`),
  KEY `source_context` (`source`(30),`context`)
) ENGINE=InnoDB AUTO_INCREMENT=341 DEFAULT CHARSET=utf8 COMMENT='List of English source strings.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_source`
--

LOCK TABLES `locales_source` WRITE;
/*!40000 ALTER TABLE `locales_source` DISABLE KEYS */;
INSERT INTO `locales_source` VALUES (2,'misc/drupal.js','default','An AJAX HTTP error occurred.','','none'),(5,'misc/drupal.js','default','HTTP Result Code: !status','','none'),(8,'misc/drupal.js','default','An AJAX HTTP request terminated abnormally.','','none'),(11,'misc/drupal.js','default','Debugging information follows.','','none'),(14,'misc/drupal.js','default','Path: !uri','','none'),(17,'misc/drupal.js','default','StatusText: !statusText','','none'),(20,'misc/drupal.js','default','ResponseText: !responseText','','none'),(23,'misc/drupal.js','default','ReadyState: !readyState','','none'),(26,'misc/drupal.js','default','CustomMessage: !customMessage','','none'),(29,'misc/ajax.js','default','Please wait...','','none'),(32,'misc/ajax.js','default','The response failed verification so will not be processed.','','none'),(35,'misc/ajax.js','default','The callback URL is not local and not trusted: !url','','none'),(38,'sites/all/modules/contrib/boxes/boxes.js','default','Loading...','','none'),(41,'sites/all/modules/contrib/boxes/boxes.js','default','Edit Box','','none'),(44,'sites/all/modules/contrib/boxes/boxes.js','default','Configure Box','','none'),(47,'misc/collapse.js','default','Hide','','none'),(50,'misc/collapse.js','default','Show','','none'),(53,'modules/toolbar/toolbar.js','default','Show shortcuts','','none'),(56,'modules/toolbar/toolbar.js','default','Hide shortcuts','','none'),(59,'misc/tableselect.js','default','Select all rows in this table','','none'),(62,'misc/tableselect.js','default','Deselect all rows in this table','','none'),(64,'modules/contextual/contextual.js','default','Configure','','none'),(66,'modules/dashboard/dashboard.js','default','Customize dashboard','','none'),(69,'modules/dashboard/dashboard.js; modules/locale/locale.datepicker.js','default','Done','','none'),(71,'misc/tabledrag.js','default','Re-order rows by numerical weight instead of dragging.','','none'),(74,'misc/tabledrag.js','default','Show row weights','','none'),(77,'misc/tabledrag.js','default','Hide row weights','','none'),(80,'misc/tabledrag.js','default','Drag to re-order','','none'),(83,'misc/tabledrag.js','default','Changes made in this table will not be saved until the form is submitted.','','none'),(84,'modules/field/modules/text/text.js','default','Hide summary','','none'),(87,'modules/field/modules/text/text.js','default','Edit summary','','none'),(90,'misc/autocomplete.js','default','Autocomplete popup','','none'),(93,'misc/autocomplete.js','default','Searching for matches...','','none'),(96,'modules/file/file.js','default','The selected file %filename cannot be uploaded. Only files with the following extensions are allowed: %extensions.','','none'),(99,'sites/all/modules/contrib/filefield_sources/filefield_sources.js','default','Paste from clipboard not supported in this browser.','','none'),(102,'sites/all/modules/contrib/filefield_sources/filefield_sources.js','default','Error reading file from clipboard.','','none'),(105,'sites/all/modules/contrib/filefield_sources/filefield_sources.js','default','No file in clipboard.','','none'),(108,'sites/all/modules/contrib/pathauto/pathauto.js','default','Automatic alias','','none'),(111,'sites/all/modules/contrib/pathauto/pathauto.js','default','Alias: @alias','','none'),(114,'sites/all/modules/contrib/pathauto/pathauto.js','default','No alias','','none'),(117,'modules/node/node.js','default','New revision','','none'),(120,'modules/node/node.js','default','No revision','','none'),(123,'modules/node/node.js','default','By @name on @date','','none'),(126,'modules/node/node.js','default','By @name','','none'),(129,'modules/node/node.js; modules/node/content_types.js','default','Not published','','none'),(132,'misc/vertical-tabs.js','default','(active tab)','','none'),(134,'misc/machine-name.js','default','Edit','','none'),(135,'modules/block/block.js','default','Not restricted','','none'),(138,'modules/block/block.js','default','Restricted to certain pages','','none'),(141,'modules/block/block.js','default','Not customizable','','none'),(144,'modules/block/block.js','default','The changes to these blocks will not be saved until the <em>Save blocks</em> button is clicked.','','none'),(147,'modules/block/block.js','default','The block cannot be placed in this region.','','none'),(150,'sites/all/modules/contrib/features/features.js','default','Deselect all','','none'),(153,'sites/all/modules/contrib/features/features.js','default','Select all','','none'),(154,'modules/locale/locale.datepicker.js','default','Prev','','none'),(157,'modules/locale/locale.datepicker.js','default','Next','','none'),(160,'modules/locale/locale.datepicker.js','default','Today','','none'),(163,'modules/locale/locale.datepicker.js','default','January','','none'),(166,'modules/locale/locale.datepicker.js','default','February','','none'),(169,'modules/locale/locale.datepicker.js','default','March','','none'),(172,'modules/locale/locale.datepicker.js','default','April','','none'),(175,'modules/locale/locale.datepicker.js','default','May','','none'),(178,'modules/locale/locale.datepicker.js','default','June','','none'),(181,'modules/locale/locale.datepicker.js','default','July','','none'),(184,'modules/locale/locale.datepicker.js','default','August','','none'),(187,'modules/locale/locale.datepicker.js','default','September','','none'),(190,'modules/locale/locale.datepicker.js','default','October','','none'),(193,'modules/locale/locale.datepicker.js','default','November','','none'),(196,'modules/locale/locale.datepicker.js','default','December','','none'),(199,'modules/locale/locale.datepicker.js','default','Jan','','none'),(202,'modules/locale/locale.datepicker.js','default','Feb','','none'),(205,'modules/locale/locale.datepicker.js','default','Mar','','none'),(208,'modules/locale/locale.datepicker.js','default','Apr','','none'),(211,'modules/locale/locale.datepicker.js','default','Jun','','none'),(214,'modules/locale/locale.datepicker.js','default','Jul','','none'),(217,'modules/locale/locale.datepicker.js','default','Aug','','none'),(220,'modules/locale/locale.datepicker.js','default','Sep','','none'),(223,'modules/locale/locale.datepicker.js','default','Oct','','none'),(226,'modules/locale/locale.datepicker.js','default','Nov','','none'),(229,'modules/locale/locale.datepicker.js','default','Dec','','none'),(232,'modules/locale/locale.datepicker.js','default','Sunday','','none'),(235,'modules/locale/locale.datepicker.js','default','Monday','','none'),(238,'modules/locale/locale.datepicker.js','default','Tuesday','','none'),(241,'modules/locale/locale.datepicker.js','default','Wednesday','','none'),(244,'modules/locale/locale.datepicker.js','default','Thursday','','none'),(247,'modules/locale/locale.datepicker.js','default','Friday','','none'),(250,'modules/locale/locale.datepicker.js','default','Saturday','','none'),(253,'modules/locale/locale.datepicker.js','default','Sun','','none'),(256,'modules/locale/locale.datepicker.js','default','Mon','','none'),(259,'modules/locale/locale.datepicker.js','default','Tue','','none'),(262,'modules/locale/locale.datepicker.js','default','Wed','','none'),(265,'modules/locale/locale.datepicker.js','default','Thu','','none'),(268,'modules/locale/locale.datepicker.js','default','Fri','','none'),(271,'modules/locale/locale.datepicker.js','default','Sat','','none'),(274,'modules/locale/locale.datepicker.js','default','Su','','none'),(277,'modules/locale/locale.datepicker.js','default','Mo','','none'),(280,'modules/locale/locale.datepicker.js','default','Tu','','none'),(283,'modules/locale/locale.datepicker.js','default','We','','none'),(286,'modules/locale/locale.datepicker.js','default','Th','','none'),(289,'modules/locale/locale.datepicker.js','default','Fr','','none'),(292,'modules/locale/locale.datepicker.js','default','Sa','','none'),(295,'modules/locale/locale.datepicker.js','default','mm/dd/yy','','none'),(297,'modules/user/user.permissions.js','default','This permission is inherited from the authenticated user role.','','none'),(298,'sites/all/modules/contrib/token/token.js','default','Loading token browser...','','none'),(301,'sites/all/modules/contrib/token/token.js','default','Available tokens','','none'),(304,'sites/all/modules/contrib/token/token.js','default','Insert this token into your form','','none'),(307,'sites/all/modules/contrib/token/token.js','default','First click a text field to insert your tokens into.','','none'),(309,'sites/all/modules/contrib/module_filter/js/module_filter.js','default','No results','','none'),(312,'sites/all/modules/contrib/module_filter/js/module_filter.js','default','clear','','none'),(315,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','All','','none'),(318,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','New','','none'),(321,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','Modules installed within the last week.','','none'),(324,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','No modules added within the last week.','','none'),(327,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','Recent','','none'),(330,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','Modules enabled/disabled within the last week.','','none'),(333,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','No modules were enabled or disabled within the last week.','','none'),(336,'sites/all/modules/contrib/module_filter/js/module_filter_tab.js','default','@enabled of @total','','none'),(337,'modules/node/content_types.js','default','Requires a title','','none'),(340,'modules/node/content_types.js','default','Don\'t display post information','','none');
/*!40000 ALTER TABLE `locales_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales_target`
--

DROP TABLE IF EXISTS `locales_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locales_target` (
  `lid` int(11) NOT NULL DEFAULT '0' COMMENT 'Source string ID. References locales_source.lid.',
  `translation` blob NOT NULL COMMENT 'Translation string value in this language.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code. References languages.language.',
  `plid` int(11) NOT NULL DEFAULT '0' COMMENT 'Parent lid (lid of the previous string in the plural chain) in case of plural strings. References locales_source.lid.',
  `plural` int(11) NOT NULL DEFAULT '0' COMMENT 'Plural index number in case of plural strings.',
  PRIMARY KEY (`language`,`lid`,`plural`),
  KEY `lid` (`lid`),
  KEY `plid` (`plid`),
  KEY `plural` (`plural`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores translated versions of strings.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales_target`
--

LOCK TABLES `locales_target` WRITE;
/*!40000 ALTER TABLE `locales_target` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales_target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_custom`
--

LOCK TABLES `menu_custom` WRITE;
/*!40000 ALTER TABLE `menu_custom` DISABLE KEYS */;
INSERT INTO `menu_custom` VALUES ('main-menu','Main menu','The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),('management','Management','The <em>Management</em> menu contains links for administrative tasks.'),('menu-sidemenu','sidemenu','sidemenu'),('navigation','Navigation','The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),('user-menu','User menu','The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');
/*!40000 ALTER TABLE `menu_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=5365 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_links`
--

LOCK TABLES `menu_links` WRITE;
/*!40000 ALTER TABLE `menu_links` DISABLE KEYS */;
INSERT INTO `menu_links` VALUES ('navigation',1,0,'search','search','Search','a:0:{}','system',1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0),('management',2,0,'admin','admin','Administration','a:0:{}','system',0,0,1,0,9,1,0,2,0,0,0,0,0,0,0,0,0),('user-menu',3,0,'user','user','User account','a:1:{s:5:\"alter\";b:1;}','system',0,0,0,0,-10,1,0,3,0,0,0,0,0,0,0,0,0),('navigation',4,0,'filter/tips','filter/tips','Compose tips','a:0:{}','system',1,0,1,0,0,1,0,4,0,0,0,0,0,0,0,0,0),('navigation',5,1,'search/node','search/node','Content','a:0:{}','system',-1,0,0,0,-10,2,0,1,5,0,0,0,0,0,0,0,0),('navigation',6,1,'search/user','search/user','Users','a:0:{}','system',-1,0,0,0,0,2,0,1,6,0,0,0,0,0,0,0,0),('navigation',7,0,'node/%','node/%','','a:0:{}','system',0,0,1,0,0,1,0,7,0,0,0,0,0,0,0,0,0),('navigation',8,0,'node/add','node/add','Add content','a:0:{}','system',0,0,1,0,0,1,0,8,0,0,0,0,0,0,0,0,0),('management',9,2,'admin/appearance','admin/appearance','Appearance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}','system',0,0,0,0,-6,2,0,2,9,0,0,0,0,0,0,0,0),('management',10,2,'admin/config','admin/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}','system',0,0,1,0,0,2,0,2,10,0,0,0,0,0,0,0,0),('management',11,2,'admin/content','admin/content','Content','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Find and manage content.\";}}','system',0,0,0,0,-10,2,0,2,11,0,0,0,0,0,0,0,0),('user-menu',12,3,'user/register','user/register','Create new account','a:0:{}','system',-1,0,0,0,0,2,0,3,12,0,0,0,0,0,0,0,0),('management',13,2,'admin/dashboard','admin/dashboard','Dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}','system',0,0,0,0,-15,2,0,2,13,0,0,0,0,0,0,0,0),('management',14,2,'admin/index','admin/index','Index','a:0:{}','system',-1,0,0,0,-18,2,0,2,14,0,0,0,0,0,0,0,0),('user-menu',15,3,'user/login','user/login','Log in','a:0:{}','system',-1,0,0,0,0,2,0,3,15,0,0,0,0,0,0,0,0),('user-menu',16,0,'user/logout','user/logout','Log out','a:0:{}','system',0,0,0,0,10,1,0,16,0,0,0,0,0,0,0,0,0),('management',17,2,'admin/modules','admin/modules','Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}','system',0,0,0,0,-2,2,0,2,17,0,0,0,0,0,0,0,0),('navigation',18,0,'user/%','user/%','My account','a:0:{}','system',0,0,1,0,0,1,0,18,0,0,0,0,0,0,0,0,0),('management',19,2,'admin/people','admin/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}','system',0,0,0,0,-4,2,0,2,19,0,0,0,0,0,0,0,0),('management',20,2,'admin/reports','admin/reports','Reports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}','system',0,0,1,0,5,2,0,2,20,0,0,0,0,0,0,0,0),('user-menu',21,3,'user/password','user/password','Request new password','a:0:{}','system',-1,0,0,0,0,2,0,3,21,0,0,0,0,0,0,0,0),('management',22,2,'admin/structure','admin/structure','Structure','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}','system',0,0,1,0,-8,2,0,2,22,0,0,0,0,0,0,0,0),('management',23,2,'admin/tasks','admin/tasks','Tasks','a:0:{}','system',-1,0,0,0,-20,2,0,2,23,0,0,0,0,0,0,0,0),('management',24,19,'admin/people/create','admin/people/create','Add user','a:0:{}','system',-1,0,0,0,0,3,0,2,19,24,0,0,0,0,0,0,0),('management',25,22,'admin/structure/block','admin/structure/block','Blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}','system',0,0,1,0,0,3,0,2,22,25,0,0,0,0,0,0,0),('navigation',26,18,'user/%/cancel','user/%/cancel','Cancel account','a:0:{}','system',0,0,1,0,0,2,0,18,26,0,0,0,0,0,0,0,0),('management',27,13,'admin/dashboard/configure','admin/dashboard/configure','Configure available dashboard blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}','system',-1,0,0,0,0,3,0,2,13,27,0,0,0,0,0,0,0),('navigation',28,5,'search/node/%','search/node/%','Content','a:0:{}','system',-1,0,0,0,0,3,0,1,5,28,0,0,0,0,0,0,0),('management',29,11,'admin/content/node','admin/content/node','Content','a:0:{}','system',-1,0,0,0,-10,3,0,2,11,29,0,0,0,0,0,0,0),('management',30,10,'admin/config/content','admin/config/content','Content authoring','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}','system',0,0,1,0,-15,3,0,2,10,30,0,0,0,0,0,0,0),('management',31,22,'admin/structure/types','admin/structure/types','Content types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}','system',0,0,1,0,0,3,0,2,22,31,0,0,0,0,0,0,0),('management',33,13,'admin/dashboard/customize','admin/dashboard/customize','Customize dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}','system',-1,0,0,0,0,3,0,2,13,33,0,0,0,0,0,0,0),('management',34,10,'admin/config/date','admin/config/date','Date API','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Settings for modules the use the Date API.\";}}','system',0,0,1,0,-10,3,0,2,10,34,0,0,0,0,0,0,0),('navigation',35,7,'node/%/delete','node/%/delete','Delete','a:0:{}','system',-1,0,0,0,1,2,0,7,35,0,0,0,0,0,0,0,0),('management',36,10,'admin/config/development','admin/config/development','Development','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}','system',0,0,1,0,-10,3,0,2,10,36,0,0,0,0,0,0,0),('navigation',37,18,'user/%/edit','user/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,18,37,0,0,0,0,0,0,0,0),('navigation',38,7,'node/%/edit','node/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,7,38,0,0,0,0,0,0,0,0),('management',39,22,'admin/structure/features','admin/structure/features','Features','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"Manage features.\";}}','system',0,0,0,0,0,3,0,2,22,39,0,0,0,0,0,0,0),('management',40,17,'admin/modules/list','admin/modules/list','List','a:0:{}','system',-1,0,0,0,0,3,0,2,17,40,0,0,0,0,0,0,0),('management',41,19,'admin/people/people','admin/people/people','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}','system',-1,0,0,0,-10,3,0,2,19,41,0,0,0,0,0,0,0),('management',42,9,'admin/appearance/list','admin/appearance/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}','system',-1,0,0,0,-1,3,0,2,9,42,0,0,0,0,0,0,0),('management',43,10,'admin/config/media','admin/config/media','Media','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}','system',0,0,1,0,-10,3,0,2,10,43,0,0,0,0,0,0,0),('management',44,22,'admin/structure/menu','admin/structure/menu','Menus','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}','system',0,0,1,0,0,3,0,2,22,44,0,0,0,0,0,0,0),('management',45,10,'admin/config/people','admin/config/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}','system',0,0,1,0,-20,3,0,2,10,45,0,0,0,0,0,0,0),('management',46,19,'admin/people/permissions','admin/people/permissions','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,0,3,0,2,19,46,0,0,0,0,0,0,0),('management',47,10,'admin/config/regional','admin/config/regional','Regional and language','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}','system',0,0,1,0,-5,3,0,2,10,47,0,0,0,0,0,0,0),('navigation',48,7,'node/%/revisions','node/%/revisions','Revisions','a:0:{}','system',-1,0,1,0,2,2,0,7,48,0,0,0,0,0,0,0,0),('management',49,10,'admin/config/search','admin/config/search','Search and metadata','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}','system',0,0,1,0,-10,3,0,2,10,49,0,0,0,0,0,0,0),('management',50,9,'admin/appearance/settings','admin/appearance/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}','system',-1,0,0,0,20,3,0,2,9,50,0,0,0,0,0,0,0),('management',51,20,'admin/reports/status','admin/reports/status','Status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}','system',0,0,0,0,-60,3,0,2,20,51,0,0,0,0,0,0,0),('management',52,10,'admin/config/system','admin/config/system','System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}','system',0,0,1,0,-20,3,0,2,10,52,0,0,0,0,0,0,0),('management',53,17,'admin/modules/uninstall','admin/modules/uninstall','Uninstall','a:0:{}','system',-1,0,0,0,20,3,0,2,17,53,0,0,0,0,0,0,0),('management',54,10,'admin/config/user-interface','admin/config/user-interface','User interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}','system',0,0,1,0,-15,3,0,2,10,54,0,0,0,0,0,0,0),('navigation',55,6,'search/user/%','search/user/%','Users','a:0:{}','system',-1,0,0,0,0,3,0,1,6,55,0,0,0,0,0,0,0),('navigation',56,7,'node/%/view','node/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,7,56,0,0,0,0,0,0,0,0),('navigation',57,18,'user/%/view','user/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,18,57,0,0,0,0,0,0,0,0),('management',58,10,'admin/config/services','admin/config/services','Web services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}','system',0,0,1,0,0,3,0,2,10,58,0,0,0,0,0,0,0),('management',59,10,'admin/config/workflow','admin/config/workflow','Workflow','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}','system',0,0,0,0,5,3,0,2,10,59,0,0,0,0,0,0,0),('management',60,45,'admin/config/people/accounts','admin/config/people/accounts','Account settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}','system',0,0,0,0,-10,4,0,2,10,45,60,0,0,0,0,0,0),('management',61,52,'admin/config/system/actions','admin/config/system/actions','Actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',0,0,1,0,0,4,0,2,10,52,61,0,0,0,0,0,0),('management',63,25,'admin/structure/block/add','admin/structure/block/add','Add block','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,63,0,0,0,0,0,0),('management',64,31,'admin/structure/types/add','admin/structure/types/add','Add content type','a:0:{}','system',-1,0,0,0,0,4,0,2,22,31,64,0,0,0,0,0,0),('management',65,44,'admin/structure/menu/add','admin/structure/menu/add','Add menu','a:0:{}','system',-1,0,0,0,0,4,0,2,22,44,65,0,0,0,0,0,0),('management',66,50,'admin/appearance/settings/alpha','admin/appearance/settings/alpha','Alpha','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,66,0,0,0,0,0,0),('management',67,50,'admin/appearance/settings/starterkit_alpha_xhtml','admin/appearance/settings/starterkit_alpha_xhtml','Alpha XHTML Starterkit','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,67,0,0,0,0,0,0),('management',68,50,'admin/appearance/settings/bartik','admin/appearance/settings/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,68,0,0,0,0,0,0),('management',69,54,'admin/config/user-interface/boxes','admin/config/user-interface/boxes','Boxes','a:0:{}','system',0,0,0,0,0,4,0,2,10,54,69,0,0,0,0,0,0),('management',70,49,'admin/config/search/clean-urls','admin/config/search/clean-urls','Clean URLs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}','system',0,0,0,0,5,4,0,2,10,49,70,0,0,0,0,0,0),('management',71,39,'admin/structure/features/create','admin/structure/features/create','Create feature','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:21:\"Create a new feature.\";}}','system',-1,0,0,0,10,4,0,2,22,39,71,0,0,0,0,0,0),('management',72,52,'admin/config/system/cron','admin/config/system/cron','Cron','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}','system',0,0,0,0,20,4,0,2,10,52,72,0,0,0,0,0,0),('management',73,50,'admin/appearance/settings/dhs_wcm_theme','admin/appearance/settings/dhs_wcm_theme','DHS WCM Theme','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,73,0,0,0,0,0,0),('management',74,34,'admin/config/date/date_popup','admin/config/date/date_popup','Date Popup','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"Configure the Date Popup settings.\";}}','system',0,0,0,0,0,4,0,2,10,34,74,0,0,0,0,0,0),('management',75,47,'admin/config/regional/date-time','admin/config/regional/date-time','Date and time','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',0,0,0,0,-15,4,0,2,10,47,75,0,0,0,0,0,0),('management',76,43,'admin/config/media/file-system','admin/config/media/file-system','File system','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}','system',0,0,0,0,-10,4,0,2,10,43,76,0,0,0,0,0,0),('management',77,50,'admin/appearance/settings/garland','admin/appearance/settings/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,77,0,0,0,0,0,0),('management',78,50,'admin/appearance/settings/global','admin/appearance/settings/global','Global settings','a:0:{}','system',-1,0,0,0,-1,4,0,2,9,50,78,0,0,0,0,0,0),('management',79,45,'admin/config/people/ip-blocking','admin/config/people/ip-blocking','IP address blocking','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}','system',0,0,1,0,10,4,0,2,10,45,79,0,0,0,0,0,0),('management',80,43,'admin/config/media/image-toolkit','admin/config/media/image-toolkit','Image toolkit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}','system',0,0,0,0,20,4,0,2,10,43,80,0,0,0,0,0,0),('management',83,40,'admin/modules/list/confirm','admin/modules/list/confirm','List','a:0:{}','system',-1,0,0,0,0,4,0,2,17,40,83,0,0,0,0,0,0),('management',84,31,'admin/structure/types/list','admin/structure/types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,31,84,0,0,0,0,0,0),('management',85,44,'admin/structure/menu/list','admin/structure/menu/list','List menus','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,44,85,0,0,0,0,0,0),('management',86,36,'admin/config/development/logging','admin/config/development/logging','Logging and errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}','system',0,0,0,0,-15,4,0,2,10,36,86,0,0,0,0,0,0),('management',87,36,'admin/config/development/maintenance','admin/config/development/maintenance','Maintenance mode','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}','system',0,0,0,0,-10,4,0,2,10,36,87,0,0,0,0,0,0),('management',88,39,'admin/structure/features/manage','admin/structure/features/manage','Manage','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Enable and disable features.\";}}','system',-1,0,0,0,0,4,0,2,22,39,88,0,0,0,0,0,0),('management',89,50,'admin/appearance/settings/omega','admin/appearance/settings/omega','Omega','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,89,0,0,0,0,0,0),('management',90,50,'admin/appearance/settings/starterkit_omega_html5','admin/appearance/settings/starterkit_omega_html5','Omega HTML5 Starterkit','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,90,0,0,0,0,0,0),('management',91,50,'admin/appearance/settings/starterkit_omega_xhtml','admin/appearance/settings/starterkit_omega_xhtml','Omega XHTML Starter Kit','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,91,0,0,0,0,0,0),('management',92,50,'admin/appearance/settings/openomega','admin/appearance/settings/openomega','OpenOmega','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,92,0,0,0,0,0,0),('management',93,36,'admin/config/development/performance','admin/config/development/performance','Performance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}','system',0,0,0,0,-20,4,0,2,10,36,93,0,0,0,0,0,0),('management',94,46,'admin/people/permissions/list','admin/people/permissions/list','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,-8,4,0,2,19,46,94,0,0,0,0,0,0),('management',95,58,'admin/config/services/rss-publishing','admin/config/services/rss-publishing','RSS publishing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}','system',0,0,0,0,0,4,0,2,10,58,95,0,0,0,0,0,0),('management',96,47,'admin/config/regional/settings','admin/config/regional/settings','Regional settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}','system',0,0,0,0,-20,4,0,2,10,47,96,0,0,0,0,0,0),('management',97,46,'admin/people/permissions/roles','admin/people/permissions/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}','system',-1,0,1,0,-5,4,0,2,19,46,97,0,0,0,0,0,0),('management',98,50,'admin/appearance/settings/rubik','admin/appearance/settings/rubik','Rubik','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,98,0,0,0,0,0,0),('management',99,49,'admin/config/search/settings','admin/config/search/settings','Search settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Configure relevance settings for search and other indexing options.\";}}','system',0,0,0,0,-10,4,0,2,10,49,99,0,0,0,0,0,0),('management',101,44,'admin/structure/menu/settings','admin/structure/menu/settings','Settings','a:0:{}','system',-1,0,0,0,5,4,0,2,22,44,101,0,0,0,0,0,0),('management',102,50,'admin/appearance/settings/seven','admin/appearance/settings/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,102,0,0,0,0,0,0),('management',103,52,'admin/config/system/site-information','admin/config/system/site-information','Site information','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}','system',0,0,0,0,-20,4,0,2,10,52,103,0,0,0,0,0,0),('management',104,50,'admin/appearance/settings/stark','admin/appearance/settings/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,104,0,0,0,0,0,0),('management',105,50,'admin/appearance/settings/tao','admin/appearance/settings/tao','Tao','a:0:{}','system',-1,0,0,0,0,4,0,2,9,50,105,0,0,0,0,0,0),('management',106,30,'admin/config/content/formats','admin/config/content/formats','Text formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}','system',0,0,1,0,0,4,0,2,10,30,106,0,0,0,0,0,0),('management',107,53,'admin/modules/uninstall/confirm','admin/modules/uninstall/confirm','Uninstall','a:0:{}','system',-1,0,0,0,0,4,0,2,17,53,107,0,0,0,0,0,0),('navigation',108,37,'user/%/edit/account','user/%/edit/account','Account','a:0:{}','system',-1,0,0,0,0,3,0,18,37,108,0,0,0,0,0,0,0),('management',109,106,'admin/config/content/formats/%','admin/config/content/formats/%','','a:0:{}','system',0,0,1,0,0,5,0,2,10,30,106,109,0,0,0,0,0),('management',110,25,'admin/structure/block/box-add/simple','admin/structure/block/box-add/simple','Add box','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,110,0,0,0,0,0,0),('management',111,106,'admin/config/content/formats/add','admin/config/content/formats/add','Add text format','a:0:{}','system',-1,0,0,0,1,5,0,2,10,30,106,111,0,0,0,0,0),('management',112,25,'admin/structure/block/list/alpha','admin/structure/block/list/alpha','Alpha','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,112,0,0,0,0,0,0),('management',113,25,'admin/structure/block/list/starterkit_alpha_xhtml','admin/structure/block/list/starterkit_alpha_xhtml','Alpha XHTML Starterkit','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,113,0,0,0,0,0,0),('management',114,25,'admin/structure/block/list/bartik','admin/structure/block/list/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,114,0,0,0,0,0,0),('management',115,99,'admin/config/search/settings/reindex','admin/config/search/settings/reindex','Clear index','a:0:{}','system',-1,0,0,0,0,5,0,2,10,49,99,115,0,0,0,0,0),('management',116,61,'admin/config/system/actions/configure','admin/config/system/actions/configure','Configure an advanced action','a:0:{}','system',-1,0,0,0,0,5,0,2,10,52,61,116,0,0,0,0,0),('management',117,44,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Customize menu','a:0:{}','system',0,0,1,0,0,4,0,2,22,44,117,0,0,0,0,0,0),('management',118,25,'admin/structure/block/list/dhs_wcm_theme','admin/structure/block/list/dhs_wcm_theme','DHS WCM Theme','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,118,0,0,0,0,0,0),('management',119,31,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit content type','a:0:{}','system',0,0,1,0,0,4,0,2,22,31,119,0,0,0,0,0,0),('management',120,75,'admin/config/regional/date-time/formats','admin/config/regional/date-time/formats','Formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}','system',-1,0,1,0,-9,5,0,2,10,47,75,120,0,0,0,0,0),('management',121,25,'admin/structure/block/list/garland','admin/structure/block/list/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,121,0,0,0,0,0,0),('management',122,106,'admin/config/content/formats/list','admin/config/content/formats/list','List','a:0:{}','system',-1,0,0,0,0,5,0,2,10,30,106,122,0,0,0,0,0),('management',123,61,'admin/config/system/actions/manage','admin/config/system/actions/manage','Manage actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',-1,0,0,0,-2,5,0,2,10,52,61,123,0,0,0,0,0),('management',124,25,'admin/structure/block/list/omega','admin/structure/block/list/omega','Omega','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,124,0,0,0,0,0,0),('management',125,25,'admin/structure/block/list/starterkit_omega_html5','admin/structure/block/list/starterkit_omega_html5','Omega HTML5 Starterkit','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,125,0,0,0,0,0,0),('management',126,25,'admin/structure/block/list/starterkit_omega_xhtml','admin/structure/block/list/starterkit_omega_xhtml','Omega XHTML Starter Kit','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,126,0,0,0,0,0,0),('management',127,25,'admin/structure/block/list/openomega','admin/structure/block/list/openomega','OpenOmega','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,25,127,0,0,0,0,0,0),('management',128,25,'admin/structure/block/list/rubik','admin/structure/block/list/rubik','Rubik','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,128,0,0,0,0,0,0),('management',129,60,'admin/config/people/accounts/settings','admin/config/people/accounts/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,2,10,45,60,129,0,0,0,0,0),('management',130,25,'admin/structure/block/list/seven','admin/structure/block/list/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,130,0,0,0,0,0,0),('management',131,25,'admin/structure/block/list/stark','admin/structure/block/list/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,131,0,0,0,0,0,0),('management',132,25,'admin/structure/block/list/tao','admin/structure/block/list/tao','Tao','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,132,0,0,0,0,0,0),('management',133,75,'admin/config/regional/date-time/types','admin/config/regional/date-time/types','Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',-1,0,1,0,-10,5,0,2,10,47,75,133,0,0,0,0,0),('management',134,39,'admin/structure/features/%/view','admin/structure/features/%/view','View','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Display components of a feature.\";}}','system',-1,0,0,0,-10,4,0,2,22,39,134,0,0,0,0,0,0),('navigation',135,48,'node/%/revisions/%/delete','node/%/revisions/%/delete','Delete earlier revision','a:0:{}','system',0,0,0,0,0,3,0,7,48,135,0,0,0,0,0,0,0),('management',136,39,'admin/structure/features/%/recreate','admin/structure/features/%/recreate','Recreate','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Recreate an existing feature.\";}}','system',-1,0,0,0,11,4,0,2,22,39,136,0,0,0,0,0,0),('navigation',137,48,'node/%/revisions/%/revert','node/%/revisions/%/revert','Revert to earlier revision','a:0:{}','system',0,0,0,0,0,3,0,7,48,137,0,0,0,0,0,0,0),('navigation',138,48,'node/%/revisions/%/view','node/%/revisions/%/view','Revisions','a:0:{}','system',0,0,0,0,0,3,0,7,48,138,0,0,0,0,0,0,0),('management',139,112,'admin/structure/block/list/alpha/add','admin/structure/block/list/alpha/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,112,139,0,0,0,0,0),('management',141,121,'admin/structure/block/list/garland/add','admin/structure/block/list/garland/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,121,141,0,0,0,0,0),('management',142,124,'admin/structure/block/list/omega/add','admin/structure/block/list/omega/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,124,142,0,0,0,0,0),('management',144,128,'admin/structure/block/list/rubik/add','admin/structure/block/list/rubik/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,128,144,0,0,0,0,0),('management',146,131,'admin/structure/block/list/stark/add','admin/structure/block/list/stark/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,131,146,0,0,0,0,0),('management',147,113,'admin/structure/block/list/starterkit_alpha_xhtml/add','admin/structure/block/list/starterkit_alpha_xhtml/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,113,147,0,0,0,0,0),('management',148,125,'admin/structure/block/list/starterkit_omega_html5/add','admin/structure/block/list/starterkit_omega_html5/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,125,148,0,0,0,0,0),('management',149,126,'admin/structure/block/list/starterkit_omega_xhtml/add','admin/structure/block/list/starterkit_omega_xhtml/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,126,149,0,0,0,0,0),('management',151,133,'admin/config/regional/date-time/types/add','admin/config/regional/date-time/types/add','Add date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}','system',-1,0,0,0,-10,6,0,2,10,47,75,133,151,0,0,0,0),('management',152,120,'admin/config/regional/date-time/formats/add','admin/config/regional/date-time/formats/add','Add format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}','system',-1,0,0,0,-10,6,0,2,10,47,75,120,152,0,0,0,0),('management',153,117,'admin/structure/menu/manage/%/add','admin/structure/menu/manage/%/add','Add link','a:0:{}','system',-1,0,0,0,0,5,0,2,22,44,117,153,0,0,0,0,0),('management',154,25,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','a:0:{}','system',0,0,0,0,0,4,0,2,22,25,154,0,0,0,0,0,0),('navigation',155,26,'user/%/cancel/confirm/%/%','user/%/cancel/confirm/%/%','Confirm account cancellation','a:0:{}','system',0,0,0,0,0,3,0,18,26,155,0,0,0,0,0,0,0),('management',156,119,'admin/structure/types/manage/%/delete','admin/structure/types/manage/%/delete','Delete','a:0:{}','system',0,0,0,0,0,5,0,2,22,31,119,156,0,0,0,0,0),('management',157,79,'admin/config/people/ip-blocking/delete/%','admin/config/people/ip-blocking/delete/%','Delete IP address','a:0:{}','system',0,0,0,0,0,5,0,2,10,45,79,157,0,0,0,0,0),('management',158,61,'admin/config/system/actions/delete/%','admin/config/system/actions/delete/%','Delete action','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}','system',0,0,0,0,0,5,0,2,10,52,61,158,0,0,0,0,0),('management',159,117,'admin/structure/menu/manage/%/delete','admin/structure/menu/manage/%/delete','Delete menu','a:0:{}','system',0,0,0,0,0,5,0,2,22,44,117,159,0,0,0,0,0),('management',160,44,'admin/structure/menu/item/%/delete','admin/structure/menu/item/%/delete','Delete menu link','a:0:{}','system',0,0,0,0,0,4,0,2,22,44,160,0,0,0,0,0,0),('management',161,97,'admin/people/permissions/roles/delete/%','admin/people/permissions/roles/delete/%','Delete role','a:0:{}','system',0,0,0,0,0,5,0,2,19,46,97,161,0,0,0,0,0),('management',162,109,'admin/config/content/formats/%/disable','admin/config/content/formats/%/disable','Disable text format','a:0:{}','system',0,0,0,0,0,6,0,2,10,30,106,109,162,0,0,0,0),('management',163,119,'admin/structure/types/manage/%/edit','admin/structure/types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,2,22,31,119,163,0,0,0,0,0),('management',164,117,'admin/structure/menu/manage/%/edit','admin/structure/menu/manage/%/edit','Edit menu','a:0:{}','system',-1,0,0,0,0,5,0,2,22,44,117,164,0,0,0,0,0),('management',165,44,'admin/structure/menu/item/%/edit','admin/structure/menu/item/%/edit','Edit menu link','a:0:{}','system',0,0,0,0,0,4,0,2,22,44,165,0,0,0,0,0,0),('management',166,97,'admin/people/permissions/roles/edit/%','admin/people/permissions/roles/edit/%','Edit role','a:0:{}','system',0,0,0,0,0,5,0,2,19,46,97,166,0,0,0,0,0),('management',167,117,'admin/structure/menu/manage/%/list','admin/structure/menu/manage/%/list','List links','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,44,117,167,0,0,0,0,0),('management',168,44,'admin/structure/menu/item/%/reset','admin/structure/menu/item/%/reset','Reset menu link','a:0:{}','system',0,0,0,0,0,4,0,2,22,44,168,0,0,0,0,0,0),('management',171,154,'admin/structure/block/manage/%/%/configure','admin/structure/block/manage/%/%/configure','Configure block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,154,171,0,0,0,0,0),('management',172,154,'admin/structure/block/manage/%/%/delete','admin/structure/block/manage/%/%/delete','Delete block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,154,172,0,0,0,0,0),('management',173,120,'admin/config/regional/date-time/formats/%/delete','admin/config/regional/date-time/formats/%/delete','Delete date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}','system',0,0,0,0,0,6,0,2,10,47,75,120,173,0,0,0,0),('management',174,133,'admin/config/regional/date-time/types/%/delete','admin/config/regional/date-time/types/%/delete','Delete date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}','system',0,0,0,0,0,6,0,2,10,47,75,133,174,0,0,0,0),('management',175,120,'admin/config/regional/date-time/formats/%/edit','admin/config/regional/date-time/formats/%/edit','Edit date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}','system',0,0,0,0,0,6,0,2,10,47,75,120,175,0,0,0,0),('management',176,44,'admin/structure/menu/manage/main-menu','admin/structure/menu/manage/%','Main menu','a:0:{}','menu',0,0,0,0,0,4,0,2,22,44,176,0,0,0,0,0,0),('management',177,44,'admin/structure/menu/manage/management','admin/structure/menu/manage/%','Management','a:0:{}','menu',0,0,0,0,0,4,0,2,22,44,177,0,0,0,0,0,0),('management',178,44,'admin/structure/menu/manage/navigation','admin/structure/menu/manage/%','Navigation','a:0:{}','menu',0,0,0,0,0,4,0,2,22,44,178,0,0,0,0,0,0),('management',179,44,'admin/structure/menu/manage/user-menu','admin/structure/menu/manage/%','User menu','a:0:{}','menu',0,0,0,0,0,4,0,2,22,44,179,0,0,0,0,0,0),('navigation',180,0,'node-name/%','node-name/%','','a:0:{}','system',0,0,0,0,0,1,0,180,0,0,0,0,0,0,0,0,0),('management',181,2,'admin/help','admin/help','Help','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Reference for usage, configuration, and modules.\";}}','system',0,0,0,0,9,2,0,2,181,0,0,0,0,0,0,0,0),('navigation',182,0,'taxonomy/term/%','taxonomy/term/%','Taxonomy term','a:0:{}','system',0,0,0,0,0,1,0,182,0,0,0,0,0,0,0,0,0),('management',183,20,'admin/reports/fields','admin/reports/fields','Field list','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}','system',0,0,0,0,0,3,0,2,20,183,0,0,0,0,0,0,0),('navigation',184,18,'user/%/shortcuts','user/%/shortcuts','Shortcuts','a:0:{}','system',-1,0,0,0,0,2,0,18,184,0,0,0,0,0,0,0,0),('management',185,22,'admin/structure/taxonomy','admin/structure/taxonomy','Taxonomy','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Manage tagging, categorization, and classification of your content.\";}}','system',0,0,1,0,0,3,0,2,22,185,0,0,0,0,0,0,0),('management',186,181,'admin/help/block','admin/help/block','block','a:0:{}','system',-1,0,0,0,0,3,0,2,181,186,0,0,0,0,0,0,0),('management',187,181,'admin/help/context','admin/help/context','context','a:0:{}','system',-1,0,0,0,0,3,0,2,181,187,0,0,0,0,0,0,0),('management',189,181,'admin/help/contextual','admin/help/contextual','contextual','a:0:{}','system',-1,0,0,0,0,3,0,2,181,189,0,0,0,0,0,0,0),('management',190,181,'admin/help/dashboard','admin/help/dashboard','dashboard','a:0:{}','system',-1,0,0,0,0,3,0,2,181,190,0,0,0,0,0,0,0),('management',191,181,'admin/help/date','admin/help/date','date','a:0:{}','system',-1,0,0,0,0,3,0,2,181,191,0,0,0,0,0,0,0),('management',192,181,'admin/help/delta_blocks','admin/help/delta_blocks','delta_blocks','a:0:{}','system',-1,0,0,0,0,3,0,2,181,192,0,0,0,0,0,0,0),('management',193,181,'admin/help/features','admin/help/features','features','a:0:{}','system',-1,0,0,0,0,3,0,2,181,193,0,0,0,0,0,0,0),('management',194,181,'admin/help/field','admin/help/field','field','a:0:{}','system',-1,0,0,0,0,3,0,2,181,194,0,0,0,0,0,0,0),('management',195,181,'admin/help/field_sql_storage','admin/help/field_sql_storage','field_sql_storage','a:0:{}','system',-1,0,0,0,0,3,0,2,181,195,0,0,0,0,0,0,0),('management',196,181,'admin/help/field_ui','admin/help/field_ui','field_ui','a:0:{}','system',-1,0,0,0,0,3,0,2,181,196,0,0,0,0,0,0,0),('management',197,181,'admin/help/file','admin/help/file','file','a:0:{}','system',-1,0,0,0,0,3,0,2,181,197,0,0,0,0,0,0,0),('management',198,181,'admin/help/filter','admin/help/filter','filter','a:0:{}','system',-1,0,0,0,0,3,0,2,181,198,0,0,0,0,0,0,0),('management',199,181,'admin/help/help','admin/help/help','help','a:0:{}','system',-1,0,0,0,0,3,0,2,181,199,0,0,0,0,0,0,0),('management',200,181,'admin/help/image','admin/help/image','image','a:0:{}','system',-1,0,0,0,0,3,0,2,181,200,0,0,0,0,0,0,0),('management',201,181,'admin/help/list','admin/help/list','list','a:0:{}','system',-1,0,0,0,0,3,0,2,181,201,0,0,0,0,0,0,0),('management',202,181,'admin/help/menu','admin/help/menu','menu','a:0:{}','system',-1,0,0,0,0,3,0,2,181,202,0,0,0,0,0,0,0),('management',203,181,'admin/help/node','admin/help/node','node','a:0:{}','system',-1,0,0,0,0,3,0,2,181,203,0,0,0,0,0,0,0),('management',204,181,'admin/help/number','admin/help/number','number','a:0:{}','system',-1,0,0,0,0,3,0,2,181,204,0,0,0,0,0,0,0),('management',205,181,'admin/help/options','admin/help/options','options','a:0:{}','system',-1,0,0,0,0,3,0,2,181,205,0,0,0,0,0,0,0),('management',206,181,'admin/help/path','admin/help/path','path','a:0:{}','system',-1,0,0,0,0,3,0,2,181,206,0,0,0,0,0,0,0),('management',207,181,'admin/help/search','admin/help/search','search','a:0:{}','system',-1,0,0,0,0,3,0,2,181,207,0,0,0,0,0,0,0),('management',208,181,'admin/help/shortcut','admin/help/shortcut','shortcut','a:0:{}','system',-1,0,0,0,0,3,0,2,181,208,0,0,0,0,0,0,0),('management',209,181,'admin/help/syslog','admin/help/syslog','syslog','a:0:{}','system',-1,0,0,0,0,3,0,2,181,209,0,0,0,0,0,0,0),('management',210,181,'admin/help/system','admin/help/system','system','a:0:{}','system',-1,0,0,0,0,3,0,2,181,210,0,0,0,0,0,0,0),('management',211,181,'admin/help/taxonomy','admin/help/taxonomy','taxonomy','a:0:{}','system',-1,0,0,0,0,3,0,2,181,211,0,0,0,0,0,0,0),('management',212,181,'admin/help/text','admin/help/text','text','a:0:{}','system',-1,0,0,0,0,3,0,2,181,212,0,0,0,0,0,0,0),('management',213,181,'admin/help/user','admin/help/user','user','a:0:{}','system',-1,0,0,0,0,3,0,2,181,213,0,0,0,0,0,0,0),('navigation',214,182,'taxonomy/term/%/edit','taxonomy/term/%/edit','Edit','a:0:{}','system',-1,0,0,0,10,2,0,182,214,0,0,0,0,0,0,0,0),('navigation',215,182,'taxonomy/term/%/view','taxonomy/term/%/view','View','a:0:{}','system',-1,0,0,0,0,2,0,182,215,0,0,0,0,0,0,0,0),('management',216,185,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','','a:0:{}','system',0,0,0,0,0,4,0,2,22,185,216,0,0,0,0,0,0),('management',217,185,'admin/structure/taxonomy/add','admin/structure/taxonomy/add','Add vocabulary','a:0:{}','system',-1,0,0,0,0,4,0,2,22,185,217,0,0,0,0,0,0),('management',218,54,'admin/config/user-interface/delta-blocks','admin/config/user-interface/delta-blocks','Delta blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Settings for the Delta blocks module.\";}}','system',0,0,0,0,0,4,0,2,10,54,218,0,0,0,0,0,0),('management',219,43,'admin/config/media/image-styles','admin/config/media/image-styles','Image styles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}','system',0,0,1,0,0,4,0,2,10,43,219,0,0,0,0,0,0),('management',220,185,'admin/structure/taxonomy/list','admin/structure/taxonomy/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,185,220,0,0,0,0,0,0),('management',221,54,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Shortcuts','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Add and modify shortcut sets.\";}}','system',0,0,1,0,0,4,0,2,10,54,221,0,0,0,0,0,0),('management',222,49,'admin/config/search/path','admin/config/search/path','URL aliases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Change your site\'s URL paths by aliasing them.\";}}','system',0,0,1,0,-5,4,0,2,10,49,222,0,0,0,0,0,0),('management',223,222,'admin/config/search/path/add','admin/config/search/path/add','Add alias','a:0:{}','system',-1,0,0,0,0,5,0,2,10,49,222,223,0,0,0,0,0),('management',224,221,'admin/config/user-interface/shortcut/add-set','admin/config/user-interface/shortcut/add-set','Add shortcut set','a:0:{}','system',-1,0,0,0,0,5,0,2,10,54,221,224,0,0,0,0,0),('management',225,219,'admin/config/media/image-styles/add','admin/config/media/image-styles/add','Add style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}','system',-1,0,0,0,2,5,0,2,10,43,219,225,0,0,0,0,0),('management',226,216,'admin/structure/taxonomy/%/add','admin/structure/taxonomy/%/add','Add term','a:0:{}','system',-1,0,0,0,0,5,0,2,22,185,216,226,0,0,0,0,0),('management',227,216,'admin/structure/taxonomy/%/edit','admin/structure/taxonomy/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,185,216,227,0,0,0,0,0),('management',228,221,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit shortcuts','a:0:{}','system',0,0,1,0,0,5,0,2,10,54,221,228,0,0,0,0,0),('management',229,222,'admin/config/search/path/list','admin/config/search/path/list','List','a:0:{}','system',-1,0,0,0,-10,5,0,2,10,49,222,229,0,0,0,0,0),('management',230,216,'admin/structure/taxonomy/%/list','admin/structure/taxonomy/%/list','List','a:0:{}','system',-1,0,0,0,-20,5,0,2,22,185,216,230,0,0,0,0,0),('management',231,219,'admin/config/media/image-styles/list','admin/config/media/image-styles/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}','system',-1,0,0,0,1,5,0,2,10,43,219,231,0,0,0,0,0),('management',232,228,'admin/config/user-interface/shortcut/%/add-link','admin/config/user-interface/shortcut/%/add-link','Add shortcut','a:0:{}','system',-1,0,0,0,0,6,0,2,10,54,221,228,232,0,0,0,0),('management',233,222,'admin/config/search/path/delete/%','admin/config/search/path/delete/%','Delete alias','a:0:{}','system',0,0,0,0,0,5,0,2,10,49,222,233,0,0,0,0,0),('management',234,228,'admin/config/user-interface/shortcut/%/delete','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','a:0:{}','system',0,0,0,0,0,6,0,2,10,54,221,228,234,0,0,0,0),('management',235,222,'admin/config/search/path/edit/%','admin/config/search/path/edit/%','Edit alias','a:0:{}','system',0,0,0,0,0,5,0,2,10,49,222,235,0,0,0,0,0),('management',236,228,'admin/config/user-interface/shortcut/%/edit','admin/config/user-interface/shortcut/%/edit','Edit set name','a:0:{}','system',-1,0,0,0,10,6,0,2,10,54,221,228,236,0,0,0,0),('management',237,221,'admin/config/user-interface/shortcut/link/%','admin/config/user-interface/shortcut/link/%','Edit shortcut','a:0:{}','system',0,0,1,0,0,5,0,2,10,54,221,237,0,0,0,0,0),('management',238,219,'admin/config/media/image-styles/edit/%','admin/config/media/image-styles/edit/%','Edit style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}','system',0,0,1,0,0,5,0,2,10,43,219,238,0,0,0,0,0),('management',239,228,'admin/config/user-interface/shortcut/%/links','admin/config/user-interface/shortcut/%/links','List links','a:0:{}','system',-1,0,0,0,0,6,0,2,10,54,221,228,239,0,0,0,0),('management',240,219,'admin/config/media/image-styles/delete/%','admin/config/media/image-styles/delete/%','Delete style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}','system',0,0,0,0,0,5,0,2,10,43,219,240,0,0,0,0,0),('management',241,219,'admin/config/media/image-styles/revert/%','admin/config/media/image-styles/revert/%','Revert style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}','system',0,0,0,0,0,5,0,2,10,43,219,241,0,0,0,0,0),('management',242,237,'admin/config/user-interface/shortcut/link/%/delete','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','a:0:{}','system',0,0,0,0,0,6,0,2,10,54,221,237,242,0,0,0,0),('management',243,238,'admin/config/media/image-styles/edit/%/add/%','admin/config/media/image-styles/edit/%/add/%','Add image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}','system',0,0,0,0,0,6,0,2,10,43,219,238,243,0,0,0,0),('management',244,238,'admin/config/media/image-styles/edit/%/effects/%','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}','system',0,0,1,0,0,6,0,2,10,43,219,238,244,0,0,0,0),('management',245,244,'admin/config/media/image-styles/edit/%/effects/%/delete','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}','system',0,0,0,0,0,7,0,2,10,43,219,238,244,245,0,0,0),('shortcut-set-1',246,0,'node/add','node/add','Add content','a:0:{}','menu',0,0,0,0,-20,1,0,246,0,0,0,0,0,0,0,0,0),('shortcut-set-1',247,0,'admin/content','admin/content','Find content','a:0:{}','menu',0,0,0,0,-19,1,0,247,0,0,0,0,0,0,0,0,0),('management',248,2,'admin/workbench','admin/workbench','My Workbench','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"My Workbench area\";}}','system',0,0,0,0,-20,2,0,2,248,0,0,0,0,0,0,0,0),('management',249,22,'admin/structure/entity_boxes_types','admin/structure/entity_boxes_types','Box Entity Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:99:\"Manage entity_boxes entity types, including adding\n		and removing fields and the display of fields.\";}}','system',0,0,1,0,0,3,0,2,22,249,0,0,0,0,0,0,0),('management',250,248,'admin/workbench/create','admin/workbench/create','Create content','a:0:{}','system',-1,0,1,0,-15,3,0,2,248,250,0,0,0,0,0,0,0),('navigation',251,8,'node/add/external','node/add/external','External','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Use this to link to content on external sites.\";}}','system',0,0,0,0,0,2,0,8,251,0,0,0,0,0,0,0,0),('navigation',252,18,'user/%/imce','user/%/imce','File browser','a:0:{}','system',-1,0,0,0,10,2,0,18,252,0,0,0,0,0,0,0,0),('navigation',253,8,'node/add/landing-page','node/add/landing-page','Landing Page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"A page referencing other content on the site\";}}','system',0,0,0,0,0,2,0,8,253,0,0,0,0,0,0,0,0),('navigation',254,7,'node/%/moderation','node/%/moderation','Moderate','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Show the content moderation history.\";}}','system',-1,0,0,0,0,2,0,7,254,0,0,0,0,0,0,0,0),('management',255,248,'admin/workbench/content','admin/workbench/content','My content','a:0:{}','system',-1,0,0,0,-20,3,0,2,248,255,0,0,0,0,0,0,0),('navigation',256,8,'node/add/photo','node/add/photo','Photo','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"An image and its meta data.\";}}','system',0,0,0,0,0,2,0,8,256,0,0,0,0,0,0,0,0),('navigation',257,8,'node/add/press-release','node/add/press-release','Press Release','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:91:\"A traditional \"press release\" of text-only content about a new development or announcement.\";}}','system',0,0,0,0,0,2,0,8,257,0,0,0,0,0,0,0,0),('navigation',258,8,'node/add/profile','node/add/profile','Profile','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:90:\"Create a profile for a person, which may be an author, a staff member, or even a business.\";}}','system',0,0,0,0,0,2,0,8,258,0,0,0,0,0,0,0,0),('navigation',259,8,'node/add/rotator','node/add/rotator','Rotator','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Carousel of highlighted content\";}}','system',0,0,0,0,0,2,0,8,259,0,0,0,0,0,0,0,0),('navigation',260,8,'node/add/site-page','node/add/site-page','Site Page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"A simple page of static HTML content, to be used for infrequently updated information.\";}}','system',0,0,0,0,0,2,0,8,260,0,0,0,0,0,0,0,0),('navigation',261,7,'node/%/draft','node/%/draft','View draft','a:0:{}','system',-1,0,0,0,-9,2,0,7,261,0,0,0,0,0,0,0,0),('management',262,22,'admin/structure/views','admin/structure/views','Views','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"Manage customized lists of content.\";}}','system',0,0,1,0,0,3,0,2,22,262,0,0,0,0,0,0,0),('management',263,20,'admin/reports/views-plugins','admin/reports/views-plugins','Views plugins','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Overview of plugins used in all views.\";}}','system',0,0,0,0,0,3,0,2,20,263,0,0,0,0,0,0,0),('management',264,10,'admin/config/workbench','admin/config/workbench','Workbench','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:9:\"Workbench\";}}','system',0,0,1,0,0,3,0,2,10,264,0,0,0,0,0,0,0),('management',265,181,'admin/help/diff','admin/help/diff','diff','a:0:{}','system',-1,0,0,0,0,3,0,2,181,265,0,0,0,0,0,0,0),('management',266,181,'admin/help/pathauto','admin/help/pathauto','pathauto','a:0:{}','system',-1,0,0,0,0,3,0,2,181,266,0,0,0,0,0,0,0),('management',267,181,'admin/help/strongarm','admin/help/strongarm','strongarm','a:0:{}','system',-1,0,0,0,0,3,0,2,181,267,0,0,0,0,0,0,0),('navigation',268,7,'node/%/current-revision','node/%/current-revision','','a:0:{}','system',0,0,0,0,0,2,0,7,268,0,0,0,0,0,0,0,0),('management',269,181,'admin/help/token','admin/help/token','token','a:0:{}','system',-1,0,0,0,0,3,0,2,181,269,0,0,0,0,0,0,0),('management',270,181,'admin/help/toolbar','admin/help/toolbar','toolbar','a:0:{}','system',-1,0,0,0,0,3,0,2,181,270,0,0,0,0,0,0,0),('management',271,181,'admin/help/workbench_moderation','admin/help/workbench_moderation','workbench_moderation','a:0:{}','system',-1,0,0,0,0,3,0,2,181,271,0,0,0,0,0,0,0),('management',272,181,'admin/help/wysiwyg','admin/help/wysiwyg','wysiwyg','a:0:{}','system',-1,0,0,0,0,3,0,2,181,272,0,0,0,0,0,0,0),('management',273,248,'admin/workbench/drafts','admin/workbench/drafts','My drafts','a:0:{}','system',-1,0,0,0,98,3,0,2,248,273,0,0,0,0,0,0,0),('management',275,248,'admin/workbench/needs-review','admin/workbench/needs-review','Needs review','a:0:{}','system',-1,0,0,0,99,3,0,2,248,275,0,0,0,0,0,0,0),('management',276,249,'admin/structure/entity_boxes_types/add','admin/structure/entity_boxes_types/add','','a:0:{}','system',-1,0,0,0,0,4,0,2,22,249,276,0,0,0,0,0,0),('management',277,249,'admin/structure/entity_boxes_types/import','admin/structure/entity_boxes_types/import','','a:0:{}','system',-1,0,0,0,0,4,0,2,22,249,277,0,0,0,0,0,0),('management',278,2,'admin/nodeconnect/edit/%','admin/nodeconnect/edit/%','','a:0:{}','system',0,0,0,0,0,2,0,2,278,0,0,0,0,0,0,0,0),('management',279,2,'admin/nodeconnect/return/%','admin/nodeconnect/return/%','','a:0:{}','system',0,0,0,0,0,2,0,2,279,0,0,0,0,0,0,0,0),('management',280,262,'admin/structure/views/add','admin/structure/views/add','Add new view','a:0:{}','system',-1,0,0,0,0,4,0,2,22,262,280,0,0,0,0,0,0),('management',281,262,'admin/structure/views/add-template','admin/structure/views/add-template','Add view from template','a:0:{}','system',-1,0,0,0,0,4,0,2,22,262,281,0,0,0,0,0,0),('management',283,2,'admin/nodeconnect/add/%','admin/nodeconnect/add/%','Choose node type to create and add','a:0:{}','system',0,0,0,0,0,2,0,2,283,0,0,0,0,0,0,0,0),('navigation',284,48,'node/%/revisions/view','node/%/revisions/view','Compare revisions','a:0:{}','system',-1,0,0,0,0,3,0,7,48,284,0,0,0,0,0,0,0),('management',285,30,'admin/config/content/diff','admin/config/content/diff','Diff','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:14:\"Diff settings.\";}}','system',0,0,0,0,0,4,0,2,10,30,285,0,0,0,0,0,0),('management',286,43,'admin/config/media/imce','admin/config/media/imce','IMCE','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Control how your image/file browser works.\";}}','system',0,0,0,0,0,4,0,2,10,43,286,0,0,0,0,0,0),('navigation',287,254,'node/%/moderation/diff','node/%/moderation/diff','Compare revisions','a:0:{}','system',-1,0,0,0,0,3,0,7,254,287,0,0,0,0,0,0,0),('management',288,262,'admin/structure/views/import','admin/structure/views/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,2,22,262,288,0,0,0,0,0,0),('management',289,262,'admin/structure/views/list','admin/structure/views/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,262,289,0,0,0,0,0,0),('management',290,249,'admin/structure/entity_boxes_types/list','admin/structure/entity_boxes_types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,249,290,0,0,0,0,0,0),('management',291,183,'admin/reports/fields/list','admin/reports/fields/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,20,183,291,0,0,0,0,0,0),('navigation',292,48,'node/%/revisions/list','node/%/revisions/list','List revisions','a:0:{}','system',-1,0,0,0,0,3,0,7,48,292,0,0,0,0,0,0,0),('management',293,39,'admin/structure/features/features_override','admin/structure/features/features_override','Review Overrides','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Show override details for a component and element.\";}}','system',-1,0,0,0,8,4,0,2,22,39,293,0,0,0,0,0,0),('navigation',294,254,'node/%/moderation/view','node/%/moderation/view','Revisions','a:0:{}','system',-1,0,0,0,-1,3,0,7,254,294,0,0,0,0,0,0,0),('management',295,262,'admin/structure/views/settings','admin/structure/views/settings','Settings','a:0:{}','system',-1,0,0,0,0,4,0,2,22,262,295,0,0,0,0,0,0),('management',296,36,'admin/config/development/strongarm','admin/config/development/strongarm','Strongarm','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"Manage Drupal variable settings that have been strongarmed.\";}}','system',0,0,0,0,0,4,0,2,10,36,296,0,0,0,0,0,0),('management',297,183,'admin/reports/fields/views-fields','admin/reports/fields/views-fields','Used in views','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"Overview of fields used in all views.\";}}','system',-1,0,0,0,0,4,0,2,20,183,297,0,0,0,0,0,0),('management',298,264,'admin/config/workbench/moderation','admin/config/workbench/moderation','Workbench Moderation','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Configure content moderation.\";}}','system',0,0,0,0,0,4,0,2,10,264,298,0,0,0,0,0,0),('management',299,30,'admin/config/content/wysiwyg','admin/config/content/wysiwyg','Wysiwyg profiles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Configure client-side editors.\";}}','system',0,0,1,0,0,4,0,2,10,30,299,0,0,0,0,0,0),('management',301,255,'admin/workbench/content/edited','admin/workbench/content/edited','My Edits','a:0:{}','system',-1,0,0,0,1,4,0,2,248,255,301,0,0,0,0,0,0),('management',302,255,'admin/workbench/content/all','admin/workbench/content/all','All Recent Content','a:0:{}','system',-1,0,0,0,2,4,0,2,248,255,302,0,0,0,0,0,0),('management',306,286,'admin/config/media/imce/profile','admin/config/media/imce/profile','Add new profile','a:0:{}','system',-1,0,0,0,0,5,0,2,10,43,286,306,0,0,0,0,0),('management',309,295,'admin/structure/views/settings/advanced','admin/structure/views/settings/advanced','Advanced','a:0:{}','system',-1,0,0,0,1,5,0,2,22,262,295,309,0,0,0,0,0),('management',310,295,'admin/structure/views/settings/basic','admin/structure/views/settings/basic','Basic','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,295,310,0,0,0,0,0),('management',311,222,'admin/config/search/path/update_bulk','admin/config/search/path/update_bulk','Bulk generate','a:0:{}','system',-1,0,0,0,30,5,0,2,10,49,222,311,0,0,0,0,0),('management',312,298,'admin/config/workbench/moderation/check-permissions','admin/config/workbench/moderation/check-permissions','Check permissions','a:0:{}','system',-1,0,0,0,10,5,0,2,10,264,298,312,0,0,0,0,0),('navigation',313,287,'node/%/moderation/diff/list','node/%/moderation/diff/list','Compare revisions','a:0:{}','system',-1,0,0,0,-1,4,0,7,254,287,313,0,0,0,0,0,0),('management',314,222,'admin/config/search/path/delete_bulk','admin/config/search/path/delete_bulk','Delete aliases','a:0:{}','system',-1,0,0,0,40,5,0,2,10,49,222,314,0,0,0,0,0),('management',315,285,'admin/config/content/diff/entities','admin/config/content/diff/entities','Entities','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"Entity settings.\";}}','system',-1,0,0,0,0,5,0,2,10,30,285,315,0,0,0,0,0),('management',316,285,'admin/config/content/diff/fields','admin/config/content/diff/fields','Fields','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Field support and settings overview.\";}}','system',-1,0,0,0,0,5,0,2,10,30,285,316,0,0,0,0,0),('navigation',317,287,'node/%/moderation/diff/view','node/%/moderation/diff/view','Compare revisions','a:0:{}','system',-1,0,0,0,0,4,0,7,254,287,317,0,0,0,0,0,0),('management',319,222,'admin/config/search/path/patterns','admin/config/search/path/patterns','Patterns','a:0:{}','system',-1,0,0,0,10,5,0,2,10,49,222,319,0,0,0,0,0),('management',320,222,'admin/config/search/path/settings','admin/config/search/path/settings','Settings','a:0:{}','system',-1,0,0,0,20,5,0,2,10,49,222,320,0,0,0,0,0),('management',321,285,'admin/config/content/diff/settings','admin/config/content/diff/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,2,10,30,285,321,0,0,0,0,0),('navigation',322,284,'node/%/revisions/view/latest','node/%/revisions/view/latest','Show latest difference','a:0:{}','system',-1,0,0,0,0,4,0,7,48,284,322,0,0,0,0,0,0),('management',323,262,'admin/structure/views/view/%','admin/structure/views/view/%','','a:0:{}','system',0,0,0,0,0,4,0,2,22,262,323,0,0,0,0,0,0),('management',324,298,'admin/config/workbench/moderation/general','admin/config/workbench/moderation/general','States','a:0:{}','system',-1,0,0,0,-1,5,0,2,10,264,298,324,0,0,0,0,0),('management',325,298,'admin/config/workbench/moderation/transitions','admin/config/workbench/moderation/transitions','Transitions','a:0:{}','system',-1,0,0,0,0,5,0,2,10,264,298,325,0,0,0,0,0),('management',326,249,'admin/structure/entity_boxes_types/manage/%','admin/structure/entity_boxes_types/manage/%','Edit','a:0:{}','system',0,0,1,0,0,4,0,2,22,249,326,0,0,0,0,0,0),('management',327,39,'admin/structure/features/%/diff','admin/structure/features/%/diff','Review overrides','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Compare default and current feature.\";}}','system',-1,0,0,0,0,4,0,2,22,39,327,0,0,0,0,0,0),('management',329,323,'admin/structure/views/view/%/break-lock','admin/structure/views/view/%/break-lock','Break lock','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,329,0,0,0,0,0),('management',330,323,'admin/structure/views/view/%/edit','admin/structure/views/view/%/edit','Edit view','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,262,323,330,0,0,0,0,0),('management',331,250,'admin/workbench/create/node/add/external','admin/workbench/create/node/add/external','External','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Use this to link to content on external sites.\";}}','system',0,0,0,0,0,4,0,2,248,250,331,0,0,0,0,0,0),('management',332,316,'admin/config/content/diff/fields/%','admin/config/content/diff/fields/%','Global field settings','a:0:{}','system',-1,0,0,0,0,6,0,2,10,30,285,316,332,0,0,0,0),('management',333,250,'admin/workbench/create/node/add/landing-page','admin/workbench/create/node/add/landing-page','Landing Page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"A page referencing other content on the site\";}}','system',0,0,0,0,0,4,0,2,248,250,333,0,0,0,0,0,0),('management',334,315,'admin/config/content/diff/entities/node','admin/config/content/diff/entities/node','Node','a:0:{}','system',-1,0,0,0,-10,6,0,2,10,30,285,315,334,0,0,0,0),('management',335,250,'admin/workbench/create/node/add/photo','admin/workbench/create/node/add/photo','Photo','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:27:\"An image and its meta data.\";}}','system',0,0,0,0,0,4,0,2,248,250,335,0,0,0,0,0,0),('management',336,250,'admin/workbench/create/node/add/press-release','admin/workbench/create/node/add/press-release','Press Release','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:91:\"A traditional \"press release\" of text-only content about a new development or announcement.\";}}','system',0,0,0,0,0,4,0,2,248,250,336,0,0,0,0,0,0),('management',337,250,'admin/workbench/create/node/add/profile','admin/workbench/create/node/add/profile','Profile','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:90:\"Create a profile for a person, which may be an author, a staff member, or even a business.\";}}','system',0,0,0,0,0,4,0,2,248,250,337,0,0,0,0,0,0),('management',338,250,'admin/workbench/create/node/add/rotator','admin/workbench/create/node/add/rotator','Rotator','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Carousel of highlighted content\";}}','system',0,0,0,0,0,4,0,2,248,250,338,0,0,0,0,0,0),('management',339,250,'admin/workbench/create/node/add/site-page','admin/workbench/create/node/add/site-page','Site Page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"A simple page of static HTML content, to be used for infrequently updated information.\";}}','system',0,0,0,0,0,4,0,2,248,250,339,0,0,0,0,0,0),('management',340,323,'admin/structure/views/view/%/clone','admin/structure/views/view/%/clone','Clone','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,340,0,0,0,0,0),('management',341,323,'admin/structure/views/view/%/delete','admin/structure/views/view/%/delete','Delete','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,341,0,0,0,0,0),('management',342,323,'admin/structure/views/view/%/export','admin/structure/views/view/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,342,0,0,0,0,0),('management',343,323,'admin/structure/views/view/%/revert','admin/structure/views/view/%/revert','Revert','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,343,0,0,0,0,0),('management',344,326,'admin/structure/entity_boxes_types/manage/%/%','admin/structure/entity_boxes_types/manage/%/%','','a:0:{}','system',0,0,0,0,0,5,0,2,22,249,326,344,0,0,0,0,0),('management',345,326,'admin/structure/entity_boxes_types/manage/%/clone','admin/structure/entity_boxes_types/manage/%/clone','Clone','a:0:{}','system',0,0,0,0,0,5,0,2,22,249,326,345,0,0,0,0,0),('management',346,326,'admin/structure/entity_boxes_types/manage/%/edit','admin/structure/entity_boxes_types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,2,22,249,326,346,0,0,0,0,0),('management',347,299,'admin/config/content/wysiwyg/profile/%/edit','admin/config/content/wysiwyg/profile/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,2,10,30,299,347,0,0,0,0,0),('management',348,262,'admin/structure/views/nojs/preview/%/%','admin/structure/views/nojs/preview/%/%','','a:0:{}','system',0,0,0,0,0,4,0,2,22,262,348,0,0,0,0,0,0),('management',349,299,'admin/config/content/wysiwyg/profile/%/delete','admin/config/content/wysiwyg/profile/%/delete','Remove','a:0:{}','system',-1,0,0,0,10,5,0,2,10,30,299,349,0,0,0,0,0),('management',350,323,'admin/structure/views/view/%/preview/%','admin/structure/views/view/%/preview/%','','a:0:{}','system',-1,0,0,0,0,5,0,2,22,262,323,350,0,0,0,0,0),('management',351,262,'admin/structure/views/ajax/preview/%/%','admin/structure/views/ajax/preview/%/%','','a:0:{}','system',0,0,0,0,0,4,0,2,22,262,351,0,0,0,0,0,0),('main-menu',356,0,'node/79','node/%','Home','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:0:\"\";}}','menu',0,0,0,0,-50,1,1,356,0,0,0,0,0,0,0,0,0),('main-menu',357,0,'node/57','node/%','Checklists','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:10:\"Checklists\";}}','menu',0,0,0,0,-48,1,1,357,0,0,0,0,0,0,0,0,0),('main-menu',358,0,'node/62','node/%','About','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:9:\"About NMC\";}}','menu',0,0,0,0,-49,1,1,358,0,0,0,0,0,0,0,0,0),('main-menu',407,0,'node/60','node/%','Drug Testing ','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:13:\"Drug Testing \";}}','menu',0,0,0,0,-46,1,1,407,0,0,0,0,0,0,0,0,0),('main-menu',408,0,'node/54','node/%','RECs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:4:\"RECs\";}}','menu',0,0,0,0,-43,1,1,408,0,0,0,0,0,0,0,0,0),('management',456,39,'admin/structure/features/settings','admin/structure/features/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"Adjust settings for using features module.\";}}','system',-1,0,0,0,11,4,0,2,22,39,456,0,0,0,0,0,0),('management',457,75,'admin/config/regional/date-time/date-views','admin/config/regional/date-time/date-views','Date views','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"Configure settings for date views.\";}}','system',-1,0,0,0,0,5,0,2,10,47,75,457,0,0,0,0,0),('management',742,11,'admin/content/entity_boxes','admin/content/entity_boxes','Entity Boxes','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:19:\"Manage entity_boxes\";}}','system',-1,0,0,0,0,3,0,2,11,742,0,0,0,0,0,0,0),('management',743,742,'admin/content/entity_boxes/list','admin/content/entity_boxes/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,11,742,743,0,0,0,0,0,0),('navigation',1174,4,'filter/tips/%','filter/tips/%','Compose tips','a:0:{}','system',0,0,0,0,0,2,0,4,1174,0,0,0,0,0,0,0,0),('management',1175,299,'admin/config/content/wysiwyg/list','admin/config/content/wysiwyg/list','List','a:0:{}','system',-1,0,0,0,-10,5,0,2,10,30,299,1175,0,0,0,0,0),('management',1176,299,'admin/config/content/wysiwyg/profile/%','admin/config/content/wysiwyg/profile/%','','a:0:{}','system',0,0,0,0,0,5,0,2,10,30,299,1176,0,0,0,0,0),('main-menu',4544,0,'node/51','node/%','Medical','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"CG-719K Credential Medical Evaluation Report\";}}','menu',0,0,0,0,-44,1,1,4544,0,0,0,0,0,0,0,0,0),('management',4554,132,'admin/structure/block/list/tao/add','admin/structure/block/list/tao/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,132,4554,0,0,0,0,0),('management',4718,130,'admin/structure/block/list/seven/add','admin/structure/block/list/seven/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,130,4718,0,0,0,0,0),('main-menu',4720,0,'node/65','node/%','Contact','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:10:\"Contact Us\";}}','menu',0,0,0,0,-47,1,1,4720,0,0,0,0,0,0,0,0,0),('main-menu',4722,0,'node/67','node/%','FEES','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:4:\"FEES\";}}','menu',0,0,0,0,-45,1,1,4722,0,0,0,0,0,0,0,0,0),('main-menu',4724,0,'node/70','node/%','TWIC','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:4:\"TWIC\";}}','menu',0,0,0,0,-41,1,1,4724,0,0,0,0,0,0,0,0,0),('main-menu',4725,0,'node/71','node/%','STCW','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:4:\"STCW\";}}','menu',0,0,0,0,-42,1,1,4725,0,0,0,0,0,0,0,0,0),('management',4782,44,'admin/structure/menu/manage/menu-sidemenu','admin/structure/menu/manage/%','sidemenu','a:0:{}','menu',0,0,0,0,0,4,0,2,22,44,4782,0,0,0,0,0,0),('management',4842,118,'admin/structure/block/list/dhs_wcm_theme/add','admin/structure/block/list/dhs_wcm_theme/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,118,4842,0,0,0,0,0),('management',4851,114,'admin/structure/block/list/bartik/add','admin/structure/block/list/bartik/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,2,22,25,114,4851,0,0,0,0,0),('management',4876,22,'admin/structure/context','admin/structure/context','Context','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:84:\"Associate menus, views, blocks, etc. with different contexts to structure your site.\";}}','system',0,0,0,0,0,3,0,2,22,4876,0,0,0,0,0,0,0),('management',4885,181,'admin/help/context_ui','admin/help/context_ui','context_ui','a:0:{}','system',-1,0,0,0,0,3,0,2,181,4885,0,0,0,0,0,0,0),('management',4888,4876,'admin/structure/context/add','admin/structure/context/add','Add','a:0:{}','system',-1,0,0,0,0,4,0,2,22,4876,4888,0,0,0,0,0,0),('management',4894,4876,'admin/structure/context/import','admin/structure/context/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,2,22,4876,4894,0,0,0,0,0,0),('management',4900,4876,'admin/structure/context/list','admin/structure/context/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,4876,4900,0,0,0,0,0,0),('management',4906,4876,'admin/structure/context/settings','admin/structure/context/settings','Settings','a:0:{}','system',-1,0,0,0,3,4,0,2,22,4876,4906,0,0,0,0,0,0),('management',4909,4900,'admin/structure/context/list/%/edit','admin/structure/context/list/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,4876,4900,4909,0,0,0,0,0),('management',4915,4900,'admin/structure/context/list/%/export','admin/structure/context/list/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,2,22,4876,4900,4915,0,0,0,0,0),('navigation',4919,8,'node/add/nmc-about','node/add/nmc-about','NMC About','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:355:\"<bold>NMC Vision</bold>\r\n\r\nWe envision creating a world class credentialing program leading to a safe, secure, environmentally sound Marine Transportation System manned by fully compliant U.S. mariners. Our staff of highly competent professionals strives to accomplish this vision with leading edge technology, strengthened by stakeholder partnerships. \r\n\";}}','system',0,0,0,0,0,2,0,8,4919,0,0,0,0,0,0,0,0),('management',4922,250,'admin/workbench/create/node/add/nmc-about','admin/workbench/create/node/add/nmc-about','NMC About','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:355:\"<bold>NMC Vision</bold>\r\n\r\nWe envision creating a world class credentialing program leading to a safe, secure, environmentally sound Marine Transportation System manned by fully compliant U.S. mariners. Our staff of highly competent professionals strives to accomplish this vision with leading edge technology, strengthened by stakeholder partnerships. \r\n\";}}','system',0,0,0,0,0,4,0,2,248,250,4922,0,0,0,0,0,0),('management',4925,20,'admin/reports/libraries','admin/reports/libraries','Libraries','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"An overview of libraries installed on this site.\";}}','system',0,0,1,0,0,3,0,2,20,4925,0,0,0,0,0,0,0),('management',4934,4925,'admin/reports/libraries/%','admin/reports/libraries/%','Library status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Status overview for a single library\";}}','system',0,0,0,0,0,4,0,2,20,4925,4934,0,0,0,0,0,0),('navigation',4959,0,'contact','contact','Contact','a:0:{}','system',1,0,0,0,0,1,0,4959,0,0,0,0,0,0,0,0,0),('navigation',4962,18,'user/%/contact','user/%/contact','Contact','a:0:{}','system',-1,0,0,0,2,2,0,18,4962,0,0,0,0,0,0,0,0),('management',4965,22,'admin/structure/contact','admin/structure/contact','Contact form','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:71:\"Create a system contact form and set up categories for the form to use.\";}}','system',0,0,1,0,0,3,0,2,22,4965,0,0,0,0,0,0,0),('management',4968,9,'admin/appearance/delta','admin/appearance/delta','Delta','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Create additional instances of your theme settings.\";}}','system',-1,0,1,0,0,3,0,2,9,4968,0,0,0,0,0,0,0),('management',4971,248,'admin/workbench/sections','admin/workbench/sections','My sections','a:0:{}','system',-1,0,0,0,5,3,0,2,248,4971,0,0,0,0,0,0,0),('management',4974,22,'admin/structure/pages','admin/structure/pages','Pages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:84:\"Add, edit and remove overridden system pages and user defined pages from the system.\";}}','system',0,0,1,0,0,3,0,2,22,4974,0,0,0,0,0,0,0),('management',4977,20,'admin/reports/hits','admin/reports/hits','Recent hits','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View pages that have recently been visited.\";}}','system',0,0,0,0,0,3,0,2,20,4977,0,0,0,0,0,0,0),('management',4980,20,'admin/reports/dblog','admin/reports/dblog','Recent log messages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}','system',0,0,0,0,-1,3,0,2,20,4980,0,0,0,0,0,0,0),('navigation',4983,18,'user/%/sections','user/%/sections','Sections','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:57:\"Assign users to sections for the Workbench Access module.\";}}','system',-1,0,0,0,1,2,0,18,4983,0,0,0,0,0,0,0,0),('management',4986,20,'admin/reports/access-denied','admin/reports/access-denied','Top \'access denied\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}','system',0,0,0,0,0,3,0,2,20,4986,0,0,0,0,0,0,0),('management',4989,20,'admin/reports/page-not-found','admin/reports/page-not-found','Top \'page not found\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}','system',0,0,0,0,0,3,0,2,20,4989,0,0,0,0,0,0,0),('management',4992,20,'admin/reports/pages','admin/reports/pages','Top pages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"View pages that have been hit frequently.\";}}','system',0,0,0,0,1,3,0,2,20,4992,0,0,0,0,0,0,0),('management',4995,20,'admin/reports/referrers','admin/reports/referrers','Top referrers','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:19:\"View top referrers.\";}}','system',0,0,0,0,0,3,0,2,20,4995,0,0,0,0,0,0,0),('management',4998,20,'admin/reports/search','admin/reports/search','Top search phrases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"View most popular search phrases.\";}}','system',0,0,0,0,0,3,0,2,20,4998,0,0,0,0,0,0,0),('management',5001,20,'admin/reports/visitors','admin/reports/visitors','Top visitors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View visitors that hit many pages.\";}}','system',0,0,0,0,2,3,0,2,20,5001,0,0,0,0,0,0,0),('navigation',5004,7,'node/%/track','node/%/track','Track','a:0:{}','system',-1,0,0,0,2,2,0,7,5004,0,0,0,0,0,0,0,0),('navigation',5007,7,'node/%/translate','node/%/translate','Translate','a:0:{}','system',-1,0,0,0,2,2,0,7,5007,0,0,0,0,0,0,0,0),('management',5010,181,'admin/help/color','admin/help/color','color','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5010,0,0,0,0,0,0,0),('management',5013,181,'admin/help/contact','admin/help/contact','contact','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5013,0,0,0,0,0,0,0),('management',5016,181,'admin/help/context_layouts','admin/help/context_layouts','context_layouts','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5016,0,0,0,0,0,0,0),('management',5019,181,'admin/help/dblog','admin/help/dblog','dblog','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5019,0,0,0,0,0,0,0),('management',5022,181,'admin/help/locale','admin/help/locale','locale','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5022,0,0,0,0,0,0,0),('management',5025,181,'admin/help/simpletest','admin/help/simpletest','simpletest','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5025,0,0,0,0,0,0,0),('management',5028,181,'admin/help/statistics','admin/help/statistics','statistics','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5028,0,0,0,0,0,0,0),('management',5031,181,'admin/help/translation','admin/help/translation','translation','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5031,0,0,0,0,0,0,0),('management',5034,4974,'admin/structure/pages/add','admin/structure/pages/add','Add custom page','a:0:{}','system',-1,0,0,0,0,4,0,2,22,4974,5034,0,0,0,0,0,0),('management',5037,4965,'admin/structure/contact/add','admin/structure/contact/add','Add category','a:0:{}','system',-1,0,0,0,1,4,0,2,22,4965,5037,0,0,0,0,0,0),('management',5040,52,'admin/config/system/boost','admin/config/system/boost','Boost','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configuration for Boost.\";}}','system',0,0,0,0,0,4,0,2,10,52,5040,0,0,0,0,0,0),('management',5043,9,'admin/appearance/omega-tools/add','admin/appearance/omega-tools/add','Create new Omega subtheme','a:0:{}','system',-1,0,0,0,100,3,0,2,9,5043,0,0,0,0,0,0,0),('management',5046,20,'admin/reports/event/%','admin/reports/event/%','Details','a:0:{}','system',0,0,0,0,0,3,0,2,20,5046,0,0,0,0,0,0,0),('management',5049,20,'admin/reports/access/%','admin/reports/access/%','Details','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:16:\"View access log.\";}}','system',0,0,0,0,0,3,0,2,20,5049,0,0,0,0,0,0,0),('management',5052,4974,'admin/structure/pages/import','admin/structure/pages/import','Import page','a:0:{}','system',-1,0,0,0,0,4,0,2,22,4974,5052,0,0,0,0,0,0),('management',5055,47,'admin/config/regional/language','admin/config/regional/language','Languages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:55:\"Configure languages for content and the user interface.\";}}','system',0,0,1,0,-10,4,0,2,10,47,5055,0,0,0,0,0,0),('management',5058,4974,'admin/structure/pages/list','admin/structure/pages/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,4974,5058,0,0,0,0,0,0),('management',5061,52,'admin/config/system/statistics','admin/config/system/statistics','Statistics','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Control details about what and how your site logs access statistics.\";}}','system',0,0,0,0,-15,4,0,2,10,52,5061,0,0,0,0,0,0),('management',5064,36,'admin/config/development/testing','admin/config/development/testing','Testing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:122:\"Run tests against Drupal core and your active modules. These tests help assure that your site code is working as designed.\";}}','system',0,0,1,0,-5,4,0,2,10,36,5064,0,0,0,0,0,0),('navigation',5067,18,'user/%/track/navigation','user/%/track/navigation','Track page visits','a:0:{}','system',-1,0,0,0,2,2,0,18,5067,0,0,0,0,0,0,0,0),('management',5070,47,'admin/config/regional/translate','admin/config/regional/translate','Translate interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"Translate the built in interface and optionally other text.\";}}','system',0,0,1,0,-5,4,0,2,10,47,5070,0,0,0,0,0,0),('management',5073,4974,'admin/structure/pages/wizard','admin/structure/pages/wizard','Wizards','a:0:{}','system',-1,0,0,0,-5,4,0,2,22,4974,5073,0,0,0,0,0,0),('management',5076,264,'admin/config/workbench/access','admin/config/workbench/access','Workbench Access','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Workbench access control settings\";}}','system',0,0,0,0,0,4,0,2,10,264,5076,0,0,0,0,0,0),('management',5079,5040,'admin/config/system/boost/htaccess','admin/config/system/boost/htaccess','.htaccess','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\".htaccess configuration for Boost.\";}}','system',-1,0,0,0,0,5,0,2,10,52,5040,5079,0,0,0,0,0),('management',5082,5055,'admin/config/regional/language/add','admin/config/regional/language/add','Add language','a:0:{}','system',-1,0,0,0,5,5,0,2,10,47,5055,5082,0,0,0,0,0),('management',5085,25,'admin/structure/block/box-add/node_reference','admin/structure/block/box-add/node_reference','Add node reference box','a:0:{}','system',-1,0,0,0,0,4,0,2,22,25,5085,0,0,0,0,0,0),('management',5088,5040,'admin/config/system/boost/default','admin/config/system/boost/default','Boost Settings','a:0:{}','system',-1,0,0,0,0,5,0,2,10,52,5040,5088,0,0,0,0,0),('management',5091,5040,'admin/config/system/boost/expiration','admin/config/system/boost/expiration','Cache Expiration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Cache expiration configuration for Boost.\";}}','system',-1,0,0,0,0,5,0,2,10,52,5040,5091,0,0,0,0,0),('management',5094,5040,'admin/config/system/boost/debug','admin/config/system/boost/debug','Debug','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Debug configuration for Boost.\";}}','system',-1,0,0,0,0,5,0,2,10,52,5040,5094,0,0,0,0,0),('management',5097,4965,'admin/structure/contact/delete/%','admin/structure/contact/delete/%','Delete contact','a:0:{}','system',0,0,0,0,0,4,0,2,22,4965,5097,0,0,0,0,0,0),('management',5100,5055,'admin/config/regional/language/configure','admin/config/regional/language/configure','Detection and selection','a:0:{}','system',-1,0,0,0,10,5,0,2,10,47,5055,5100,0,0,0,0,0),('management',5103,4974,'admin/structure/pages/edit/%','admin/structure/pages/edit/%','Edit','a:0:{}','system',0,0,0,0,0,4,0,2,22,4974,5103,0,0,0,0,0,0),('management',5106,4965,'admin/structure/contact/edit/%','admin/structure/contact/edit/%','Edit contact category','a:0:{}','system',0,0,0,0,0,4,0,2,22,4965,5106,0,0,0,0,0,0),('management',5109,5076,'admin/config/workbench/access/editors','admin/config/workbench/access/editors','Editors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"The editor assignment settings.\";}}','system',-1,0,0,0,-10,5,0,2,10,264,5076,5109,0,0,0,0,0),('management',5112,5070,'admin/config/regional/translate/export','admin/config/regional/translate/export','Export','a:0:{}','system',-1,0,0,0,30,5,0,2,10,47,5070,5112,0,0,0,0,0),('management',5115,5040,'admin/config/system/boost/filesystem','admin/config/system/boost/filesystem','File System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"File system configuration for Boost.\";}}','system',-1,0,0,0,0,5,0,2,10,52,5040,5115,0,0,0,0,0),('management',5118,5070,'admin/config/regional/translate/import','admin/config/regional/translate/import','Import','a:0:{}','system',-1,0,0,0,20,5,0,2,10,47,5070,5118,0,0,0,0,0),('management',5121,5055,'admin/config/regional/language/overview','admin/config/regional/language/overview','List','a:0:{}','system',-1,0,0,0,0,5,0,2,10,47,5055,5121,0,0,0,0,0),('management',5124,5064,'admin/config/development/testing/list','admin/config/development/testing/list','List','a:0:{}','system',-1,0,0,0,0,5,0,2,10,36,5064,5124,0,0,0,0,0),('management',5127,75,'admin/config/regional/date-time/locale','admin/config/regional/date-time/locale','Localize','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Configure date formats for each locale\";}}','system',-1,0,1,0,-8,5,0,2,10,47,75,5127,0,0,0,0,0),('management',5130,5070,'admin/config/regional/translate/overview','admin/config/regional/translate/overview','Overview','a:0:{}','system',-1,0,0,0,0,5,0,2,10,47,5070,5130,0,0,0,0,0),('management',5133,5040,'admin/config/system/boost/listmodules','admin/config/system/boost/listmodules','Related Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\" Compatible Modules that add features to Boost.\";}}','system',-1,0,0,0,100,5,0,2,10,52,5040,5133,0,0,0,0,0),('management',5136,5076,'admin/config/workbench/access/roles','admin/config/workbench/access/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:14:\"Role settings.\";}}','system',-1,0,0,0,-8,5,0,2,10,264,5076,5136,0,0,0,0,0),('management',5139,5076,'admin/config/workbench/access/sections','admin/config/workbench/access/sections','Sections','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:56:\"Define content sections for the Workbench Access module.\";}}','system',-1,0,0,0,-5,5,0,2,10,264,5076,5139,0,0,0,0,0),('management',5142,5064,'admin/config/development/testing/settings','admin/config/development/testing/settings','Settings','a:0:{}','system',-1,0,0,0,0,5,0,2,10,36,5064,5142,0,0,0,0,0),('management',5145,5076,'admin/config/workbench/access/settings','admin/config/workbench/access/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Settings for the Workbench Access module.\";}}','system',-1,0,0,0,0,5,0,2,10,264,5076,5145,0,0,0,0,0),('management',5148,5070,'admin/config/regional/translate/translate','admin/config/regional/translate/translate','Translate','a:0:{}','system',-1,0,0,0,10,5,0,2,10,47,5070,5148,0,0,0,0,0),('management',5151,5079,'admin/config/system/boost/htaccess/generator','admin/config/system/boost/htaccess/generator','.htaccess Generation','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\".htaccess generation for Boost.\";}}','system',-1,0,0,0,0,6,0,2,10,52,5040,5079,5151,0,0,0,0),('management',5154,5079,'admin/config/system/boost/htaccess/default','admin/config/system/boost/htaccess/default','.htaccess Settings','a:0:{}','system',-1,0,0,0,0,6,0,2,10,52,5040,5079,5154,0,0,0,0),('management',5157,4974,'admin/structure/pages/%/operation/%','admin/structure/pages/%/operation/%','','a:0:{}','system',0,0,0,0,0,4,0,2,22,4974,5157,0,0,0,0,0,0),('management',5160,5055,'admin/config/regional/language/delete/%','admin/config/regional/language/delete/%','Confirm','a:0:{}','system',0,0,0,0,0,5,0,2,10,47,5055,5160,0,0,0,0,0),('management',5163,5070,'admin/config/regional/translate/delete/%','admin/config/regional/translate/delete/%','Delete string','a:0:{}','system',0,0,0,0,0,5,0,2,10,47,5070,5163,0,0,0,0,0),('management',5166,5055,'admin/config/regional/language/edit/%','admin/config/regional/language/edit/%','Edit language','a:0:{}','system',0,0,0,0,0,5,0,2,10,47,5055,5166,0,0,0,0,0),('management',5169,5070,'admin/config/regional/translate/edit/%','admin/config/regional/translate/edit/%','Edit string','a:0:{}','system',0,0,0,0,0,5,0,2,10,47,5070,5169,0,0,0,0,0),('management',5172,5100,'admin/config/regional/language/configure/session','admin/config/regional/language/configure/session','Session language detection configuration','a:0:{}','system',-1,0,0,0,0,6,0,2,10,47,5055,5100,5172,0,0,0,0),('management',5175,4968,'admin/appearance/delta/list/%/configure','admin/appearance/delta/list/%/configure','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Override settings for a layout.\";}}','system',0,0,0,0,0,4,0,2,9,4968,5175,0,0,0,0,0,0),('management',5178,5064,'admin/config/development/testing/results/%','admin/config/development/testing/results/%','Test result','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:21:\"View result of tests.\";}}','system',0,0,0,0,0,5,0,2,10,36,5064,5178,0,0,0,0,0),('management',5181,5100,'admin/config/regional/language/configure/url','admin/config/regional/language/configure/url','URL language detection configuration','a:0:{}','system',-1,0,0,0,0,6,0,2,10,47,5055,5100,5181,0,0,0,0),('management',5184,5127,'admin/config/regional/date-time/locale/%/edit','admin/config/regional/date-time/locale/%/edit','Localize date formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Configure date formats for each locale\";}}','system',0,0,0,0,0,6,0,2,10,47,75,5127,5184,0,0,0,0),('management',5187,5127,'admin/config/regional/date-time/locale/%/reset','admin/config/regional/date-time/locale/%/reset','Reset date formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Reset localized date formats to global defaults\";}}','system',0,0,0,0,0,6,0,2,10,47,75,5127,5187,0,0,0,0),('management',5189,22,'admin/structure/ctools-content','admin/structure/ctools-content','Custom content panes','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Add, edit or delete custom content panes.\";}}','system',0,0,0,0,0,3,0,2,22,5189,0,0,0,0,0,0,0),('management',5192,22,'admin/structure/stylizer','admin/structure/stylizer','Stylizer','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Add, edit or delete stylizer styles.\";}}','system',0,0,0,0,0,3,0,2,22,5192,0,0,0,0,0,0,0),('management',5195,181,'admin/help/libraries','admin/help/libraries','libraries','a:0:{}','system',-1,0,0,0,0,3,0,2,181,5195,0,0,0,0,0,0,0),('management',5198,4968,'admin/appearance/delta/add','admin/appearance/delta/add','Add','a:0:{}','system',-1,0,0,0,0,4,0,2,9,4968,5198,0,0,0,0,0,0),('management',5201,5189,'admin/structure/ctools-content/import','admin/structure/ctools-content/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,2,22,5189,5201,0,0,0,0,0,0),('management',5204,5189,'admin/structure/ctools-content/list','admin/structure/ctools-content/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,5189,5204,0,0,0,0,0,0),('management',5207,4968,'admin/appearance/delta/list','admin/appearance/delta/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,9,4968,5207,0,0,0,0,0,0),('management',5210,5189,'admin/structure/ctools-content/add','admin/structure/ctools-content/add','Add','a:0:{}','system',-1,0,0,0,0,4,0,2,22,5189,5210,0,0,0,0,0,0),('management',5213,5192,'admin/structure/stylizer/add','admin/structure/stylizer/add','Add','a:0:{}','system',-1,0,0,0,0,4,0,2,22,5192,5213,0,0,0,0,0,0),('management',5216,4968,'admin/appearance/delta/import','admin/appearance/delta/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,2,9,4968,5216,0,0,0,0,0,0),('management',5219,5192,'admin/structure/stylizer/import','admin/structure/stylizer/import','Import','a:0:{}','system',-1,0,0,0,0,4,0,2,22,5192,5219,0,0,0,0,0,0),('management',5222,5192,'admin/structure/stylizer/list','admin/structure/stylizer/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,2,22,5192,5222,0,0,0,0,0,0),('management',5240,5204,'admin/structure/ctools-content/list/%/edit','admin/structure/ctools-content/list/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,5189,5204,5240,0,0,0,0,0),('management',5243,5207,'admin/appearance/delta/list/%/edit','admin/appearance/delta/list/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,2,9,4968,5207,5243,0,0,0,0,0),('management',5246,5222,'admin/structure/stylizer/list/%/edit','admin/structure/stylizer/list/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,2,22,5192,5222,5246,0,0,0,0,0),('management',5249,5204,'admin/structure/ctools-content/list/%/export','admin/structure/ctools-content/list/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,2,22,5189,5204,5249,0,0,0,0,0),('management',5252,5207,'admin/appearance/delta/list/%/export','admin/appearance/delta/list/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,2,9,4968,5207,5252,0,0,0,0,0),('management',5255,5222,'admin/structure/stylizer/list/%/export','admin/structure/stylizer/list/%/export','Export','a:0:{}','system',-1,0,0,0,0,5,0,2,22,5192,5222,5255,0,0,0,0,0),('management',5256,216,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,2,22,185,216,5256,0,0,0,0,0),('management',5259,60,'admin/config/people/accounts/display','admin/config/people/accounts/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,2,10,45,60,5259,0,0,0,0,0),('management',5262,216,'admin/structure/taxonomy/%/fields','admin/structure/taxonomy/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,2,22,185,216,5262,0,0,0,0,0),('management',5265,60,'admin/config/people/accounts/fields','admin/config/people/accounts/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,2,10,45,60,5265,0,0,0,0,0),('management',5268,5256,'admin/structure/taxonomy/%/display/default','admin/structure/taxonomy/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,2,22,185,216,5256,5268,0,0,0,0),('management',5271,5259,'admin/config/people/accounts/display/default','admin/config/people/accounts/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,2,10,45,60,5259,5271,0,0,0,0),('management',5274,119,'admin/structure/types/manage/%/display','admin/structure/types/manage/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,2,22,31,119,5274,0,0,0,0,0),('management',5277,119,'admin/structure/types/manage/%/fields','admin/structure/types/manage/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,2,22,31,119,5277,0,0,0,0,0),('management',5280,5256,'admin/structure/taxonomy/%/display/diff_standard','admin/structure/taxonomy/%/display/diff_standard','Revision comparison','a:0:{}','system',-1,0,0,0,1,6,0,2,22,185,216,5256,5280,0,0,0,0),('management',5283,5259,'admin/config/people/accounts/display/diff_standard','admin/config/people/accounts/display/diff_standard','Revision comparison','a:0:{}','system',-1,0,0,0,1,6,0,2,10,45,60,5259,5283,0,0,0,0),('management',5286,5256,'admin/structure/taxonomy/%/display/full','admin/structure/taxonomy/%/display/full','Taxonomy term page','a:0:{}','system',-1,0,0,0,0,6,0,2,22,185,216,5256,5286,0,0,0,0),('management',5289,5256,'admin/structure/taxonomy/%/display/token','admin/structure/taxonomy/%/display/token','Tokens','a:0:{}','system',-1,0,0,0,2,6,0,2,22,185,216,5256,5289,0,0,0,0),('management',5292,5259,'admin/config/people/accounts/display/token','admin/config/people/accounts/display/token','Tokens','a:0:{}','system',-1,0,0,0,2,6,0,2,10,45,60,5259,5292,0,0,0,0),('management',5295,5259,'admin/config/people/accounts/display/full','admin/config/people/accounts/display/full','User account','a:0:{}','system',-1,0,0,0,0,6,0,2,10,45,60,5259,5295,0,0,0,0),('management',5298,5262,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,2,22,185,216,5262,5298,0,0,0,0),('management',5301,5265,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,2,10,45,60,5265,5301,0,0,0,0),('management',5304,5274,'admin/structure/types/manage/%/display/default','admin/structure/types/manage/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,2,22,31,119,5274,5304,0,0,0,0),('management',5307,5274,'admin/structure/types/manage/%/display/full','admin/structure/types/manage/%/display/full','Full content','a:0:{}','system',-1,0,0,0,0,6,0,2,22,31,119,5274,5307,0,0,0,0),('management',5310,5274,'admin/structure/types/manage/%/display/rss','admin/structure/types/manage/%/display/rss','RSS','a:0:{}','system',-1,0,0,0,2,6,0,2,22,31,119,5274,5310,0,0,0,0),('management',5313,5274,'admin/structure/types/manage/%/display/diff_standard','admin/structure/types/manage/%/display/diff_standard','Revision comparison','a:0:{}','system',-1,0,0,0,5,6,0,2,22,31,119,5274,5313,0,0,0,0),('management',5316,5274,'admin/structure/types/manage/%/display/search_index','admin/structure/types/manage/%/display/search_index','Search index','a:0:{}','system',-1,0,0,0,3,6,0,2,22,31,119,5274,5316,0,0,0,0),('management',5319,5274,'admin/structure/types/manage/%/display/search_result','admin/structure/types/manage/%/display/search_result','Search result highlighting input','a:0:{}','system',-1,0,0,0,4,6,0,2,22,31,119,5274,5319,0,0,0,0),('management',5322,5274,'admin/structure/types/manage/%/display/teaser','admin/structure/types/manage/%/display/teaser','Teaser','a:0:{}','system',-1,0,0,0,1,6,0,2,22,31,119,5274,5322,0,0,0,0),('management',5325,5274,'admin/structure/types/manage/%/display/token','admin/structure/types/manage/%/display/token','Tokens','a:0:{}','system',-1,0,0,0,6,6,0,2,22,31,119,5274,5325,0,0,0,0),('management',5328,5277,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,2,22,31,119,5277,5328,0,0,0,0),('management',5331,5298,'admin/structure/taxonomy/%/fields/%/delete','admin/structure/taxonomy/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,2,22,185,216,5262,5298,5331,0,0,0),('management',5334,5298,'admin/structure/taxonomy/%/fields/%/edit','admin/structure/taxonomy/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,2,22,185,216,5262,5298,5334,0,0,0),('management',5337,5298,'admin/structure/taxonomy/%/fields/%/field-settings','admin/structure/taxonomy/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,2,22,185,216,5262,5298,5337,0,0,0),('management',5340,5298,'admin/structure/taxonomy/%/fields/%/widget-type','admin/structure/taxonomy/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,2,22,185,216,5262,5298,5340,0,0,0),('management',5343,5301,'admin/config/people/accounts/fields/%/delete','admin/config/people/accounts/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,2,10,45,60,5265,5301,5343,0,0,0),('management',5346,5301,'admin/config/people/accounts/fields/%/edit','admin/config/people/accounts/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,2,10,45,60,5265,5301,5346,0,0,0),('management',5349,5301,'admin/config/people/accounts/fields/%/field-settings','admin/config/people/accounts/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,2,10,45,60,5265,5301,5349,0,0,0),('management',5352,5301,'admin/config/people/accounts/fields/%/widget-type','admin/config/people/accounts/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,2,10,45,60,5265,5301,5352,0,0,0),('management',5355,5328,'admin/structure/types/manage/%/fields/%/delete','admin/structure/types/manage/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,2,22,31,119,5277,5328,5355,0,0,0),('management',5358,5328,'admin/structure/types/manage/%/fields/%/edit','admin/structure/types/manage/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,2,22,31,119,5277,5328,5358,0,0,0),('management',5361,5328,'admin/structure/types/manage/%/fields/%/field-settings','admin/structure/types/manage/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,2,22,31,119,5277,5328,5361,0,0,0),('management',5364,5328,'admin/structure/types/manage/%/fields/%/widget-type','admin/structure/types/manage/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,2,22,31,119,5277,5328,5364,0,0,0);
/*!40000 ALTER TABLE `menu_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_router`
--

DROP TABLE IF EXISTS `menu_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_router`
--

LOCK TABLES `menu_router` WRITE;
/*!40000 ALTER TABLE `menu_router` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_router` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node`
--

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
INSERT INTO `node` VALUES (51,53,'site_page','und','Medical',23,1,1464874135,1464874268,0,0,0,0,0),(54,54,'site_page','en','RECs',27,1,1464882591,1464882653,0,0,0,0,0),(57,60,'site_page','en','Checklists',27,1,1464885194,1464885227,0,0,0,0,0),(60,63,'site_page','en','Drug Testing ',27,1,1464891054,1464891072,0,0,0,0,0),(62,65,'site_page','en','About ',27,1,1464891666,1464891677,0,0,0,0,0),(65,68,'site_page','en','Contact',27,1,1464893364,1464893373,0,0,0,0,0),(67,70,'site_page','en','FEES',27,1,1464962773,1464962779,0,0,0,0,0),(70,76,'site_page','en','TWIC ',27,1,1464962833,1464962855,0,0,0,0,0),(71,77,'site_page','en','STCW',27,1,1464962893,1464962898,0,0,0,0,0),(74,80,'photo','en','background image',27,1,1465397938,1465397976,0,0,0,0,0),(75,81,'photo','en','Stcw Image',27,1,1465838413,1465838460,0,0,0,0,0),(77,83,'photo','en','Medical Image',27,1,1465838562,1465838562,0,0,0,0,0),(78,84,'rotator','en','Slide Show',27,1,1465838679,1465838689,0,0,0,0,0),(79,85,'landing_page','en','Home',27,1,1465842443,1465842449,0,0,0,0,0);
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_access`
--

LOCK TABLES `node_access` WRITE;
/*!40000 ALTER TABLE `node_access` DISABLE KEYS */;
INSERT INTO `node_access` VALUES (0,0,'all',1,0,0),(51,0,'all',1,0,0),(54,0,'all',1,0,0),(57,0,'all',1,0,0),(60,0,'all',1,0,0),(62,0,'all',1,0,0),(65,0,'all',1,0,0),(67,0,'all',1,0,0),(70,0,'all',1,0,0),(71,0,'all',1,0,0),(74,0,'all',1,0,0),(75,0,'all',1,0,0),(77,0,'all',1,0,0),(78,0,'all',1,0,0),(79,0,'all',1,0,0);
/*!40000 ALTER TABLE `node_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_counter`
--

DROP TABLE IF EXISTS `node_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_counter` (
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid for these statistics.',
  `totalcount` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed.',
  `daycount` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of times the node has been viewed today.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The most recent time the node has been viewed.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Access statistics for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_counter`
--

LOCK TABLES `node_counter` WRITE;
/*!40000 ALTER TABLE `node_counter` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_revision`
--

LOCK TABLES `node_revision` WRITE;
/*!40000 ALTER TABLE `node_revision` DISABLE KEYS */;
INSERT INTO `node_revision` VALUES (51,53,23,'Medical','Edited by larry.adams.',1464874268,1,0,0,0),(54,54,27,'RECs','Created by james.mckinlay.',1464882653,1,0,0,0),(54,57,27,'RECs','Edited by james.mckinlay.',1464884254,0,0,0,0),(57,60,27,'Checklists','Created by james.mckinlay.',1464885227,1,0,0,0),(60,63,27,'Drug Testing ','Created by james.mckinlay.',1464891072,1,0,0,0),(62,65,27,'About ','Created by james.mckinlay.',1464891677,1,0,0,0),(65,68,27,'Contact','Created by james.mckinlay.',1464893373,1,0,0,0),(67,70,27,'FEES','Created by james.mckinlay.',1464962779,1,0,0,0),(70,73,27,'TWIC ','Created by james.mckinlay.',1464962833,0,0,0,0),(70,76,27,'TWIC ','Edited by james.mckinlay.',1464962855,1,0,0,0),(71,77,27,'STCW','Created by james.mckinlay.',1464962898,1,0,0,0),(74,80,27,'background image','Created by james.mckinlay.',1465397976,1,0,0,0),(75,81,27,'Stcw Image','Created by james.mckinlay.',1465838460,1,0,0,0),(77,83,27,'Medical Image','Created by james.mckinlay.',1465838562,1,0,0,0),(78,84,27,'Slide Show','Created by james.mckinlay.',1465838689,1,0,0,0),(79,85,27,'Home','Created by james.mckinlay.',1465842449,1,0,0,0);
/*!40000 ALTER TABLE `node_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_type`
--

LOCK TABLES `node_type` WRITE;
/*!40000 ALTER TABLE `node_type` DISABLE KEYS */;
INSERT INTO `node_type` VALUES ('external','External','node_content','node','Use this to link to content on external sites.','',1,'Title',1,1,0,0,'external'),('landing_page','Landing Page','node_content','dhs_wcm_landing_page','A page referencing other content on the site','',1,'Title',0,0,1,0,'landing_page'),('nmc_about','NMC About','node_content','node','<bold>NMC Vision</bold>\r\n\r\nWe envision creating a world class credentialing program leading to a safe, secure, environmentally sound Marine Transportation System manned by fully compliant U.S. mariners. Our staff of highly competent professionals strives to accomplish this vision with leading edge technology, strengthened by stakeholder partnerships. \r\n','',1,'Title',1,1,0,0,'nmc_about'),('photo','Photo','node_content','node','An image and its meta data.','',1,'Title',1,1,0,0,'photo'),('press_release','Press Release','node_content','dhs_wcm_press_release','A traditional \"press release\" of text-only content about a new development or announcement.','',1,'Title',0,0,1,0,'press_release'),('profile','Profile','node_content','node','Create a profile for a person, which may be an author, a staff member, or even a business.','This is the name used as the title of this content. This may be comprised of the First and Last names, or of the Organization name, or any other name that you choose.',1,'Full Name',1,1,0,0,'profile'),('rotator','Rotator','node_content','node','Carousel of highlighted content','',1,'Title',1,1,0,0,'rotator'),('site_page','Site Page','node_content','dhs_wcm_site_page','A simple page of static HTML content, to be used for infrequently updated information.','',1,'Short Title',0,0,1,0,'site_page');
/*!40000 ALTER TABLE `node_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_manager_handlers`
--

DROP TABLE IF EXISTS `page_manager_handlers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_handlers` (
  `did` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `task` varchar(64) DEFAULT NULL COMMENT 'ID of the task this handler is for.',
  `subtask` varchar(64) NOT NULL DEFAULT '' COMMENT 'ID of the subtask this handler is for.',
  `handler` varchar(64) DEFAULT NULL COMMENT 'ID of the task handler being used.',
  `weight` int(11) DEFAULT NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the handler, if needed.',
  PRIMARY KEY (`did`),
  UNIQUE KEY `name` (`name`),
  KEY `fulltask` (`task`,`subtask`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_manager_handlers`
--

LOCK TABLES `page_manager_handlers` WRITE;
/*!40000 ALTER TABLE `page_manager_handlers` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_manager_handlers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_manager_pages`
--

DROP TABLE IF EXISTS `page_manager_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_pages` (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this subtask. Used to identify it programmatically.',
  `task` varchar(64) DEFAULT 'page' COMMENT 'What type of page this is, so that we can use the same mechanism for creating tighter UIs for targeted pages.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Human readable title for this page subtask.',
  `admin_description` longtext COMMENT 'Administrative description of this item.',
  `path` varchar(255) DEFAULT NULL COMMENT 'The menu path that will invoke this task.',
  `access` longtext NOT NULL COMMENT 'Access configuration for this path.',
  `menu` longtext NOT NULL COMMENT 'Serialized configuration of Drupal menu visibility settings for this item.',
  `arguments` longtext NOT NULL COMMENT 'Configuration of arguments for this menu item.',
  `conf` longtext NOT NULL COMMENT 'Serialized configuration of the page, if needed.',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `name` (`name`),
  KEY `task` (`task`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains page subtasks for implementing pages with...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_manager_pages`
--

LOCK TABLES `page_manager_pages` WRITE;
/*!40000 ALTER TABLE `page_manager_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_manager_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_manager_weights`
--

DROP TABLE IF EXISTS `page_manager_weights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page_manager_weights` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Unique ID for this task handler. Used to identify it programmatically.',
  `weight` int(11) DEFAULT NULL COMMENT 'The order in which this handler appears. Lower numbers go first.',
  PRIMARY KEY (`name`),
  KEY `weights` (`name`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains override weights for page_manager handlers that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_manager_weights`
--

LOCK TABLES `page_manager_weights` WRITE;
/*!40000 ALTER TABLE `page_manager_weights` DISABLE KEYS */;
/*!40000 ALTER TABLE `page_manager_weights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pathauto_state`
--

DROP TABLE IF EXISTS `pathauto_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pathauto_state` (
  `entity_type` varchar(32) NOT NULL COMMENT 'The entity type.',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity ID.',
  `pathauto` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The automatic alias status of the entity.',
  PRIMARY KEY (`entity_type`,`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The status of each entity alias (whether it was...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pathauto_state`
--

LOCK TABLES `pathauto_state` WRITE;
/*!40000 ALTER TABLE `pathauto_state` DISABLE KEYS */;
INSERT INTO `pathauto_state` VALUES ('node',51,0),('node',54,0),('node',57,0),('node',60,0),('node',62,0),('node',65,0),('node',67,0),('node',70,0),('node',71,0),('node',74,0),('node',75,0),('node',77,0),('node',78,0),('node',79,0);
/*!40000 ALTER TABLE `pathauto_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry`
--

LOCK TABLES `registry` WRITE;
/*!40000 ALTER TABLE `registry` DISABLE KEYS */;
INSERT INTO `registry` VALUES ('AccessDeniedTestCase','class','modules/system/system.test','system',0),('AcquiaAgentTestCase','class','sites/all/modules/contrib/acquia_connector/acquia_agent/tests/acquia_agent.test','acquia_agent',0),('AcquiaSearchUnitTestCase','class','sites/all/modules/contrib/acquia_connector/acquia_search/tests/acquia_search.test','acquia_search',0),('AcquiaSearchWebTestCase','class','sites/all/modules/contrib/acquia_connector/acquia_search/tests/acquia_search.test','acquia_search',0),('AcquiaSPITestCase','class','sites/all/modules/contrib/acquia_connector/acquia_spi/tests/acquia_spi.test','acquia_spi',0),('ActionLoopTestCase','class','modules/simpletest/tests/actions.test','simpletest',0),('ActionsConfigurationTestCase','class','modules/simpletest/tests/actions.test','simpletest',0),('AddFeedTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('AdminMenuCustomizedTestCase','class','sites/all/modules/contrib/admin_menu/tests/admin_menu.test','admin_menu',0),('AdminMenuDynamicLinksTestCase','class','sites/all/modules/contrib/admin_menu/tests/admin_menu.test','admin_menu',0),('AdminMenuLinkTypesTestCase','class','sites/all/modules/contrib/admin_menu/tests/admin_menu.test','admin_menu',0),('AdminMenuPermissionsTestCase','class','sites/all/modules/contrib/admin_menu/tests/admin_menu.test','admin_menu',0),('AdminMenuWebTestCase','class','sites/all/modules/contrib/admin_menu/tests/admin_menu.test','admin_menu',0),('AdminMetaTagTestCase','class','modules/system/system.test','system',0),('AggregatorConfigurationTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('AggregatorCronTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('AggregatorRenderingTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('AggregatorTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('AggregatorUpdatePathTestCase','class','modules/simpletest/tests/upgrade/update.aggregator.test','simpletest',0),('AJAXCommandsTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXElementValidation','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXFormPageCacheTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXFormValuesTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXFrameworkTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXMultiFormTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AJAXTestCase','class','modules/simpletest/tests/ajax.test','simpletest',0),('AkamaiHomepageTestCase','class','sites/all/modules/contrib/akamai/akamai.test','akamai',0),('AkamaiHookTestCase','class','sites/all/modules/contrib/akamai/akamai.test','akamai',0),('AkamaiTestCase','class','sites/all/modules/contrib/akamai/akamai.test','akamai',0),('AquiaAgentUnitTestCase','class','sites/all/modules/contrib/acquia_connector/acquia_agent/tests/acquia_agent.test','acquia_agent',0),('ArchiverInterface','interface','includes/archiver.inc','',0),('ArchiverTar','class','modules/system/system.archiver.inc','system',0),('ArchiverZip','class','modules/system/system.archiver.inc','system',0),('Archive_Tar','class','modules/system/system.tar.inc','system',0),('ArrayDiffUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('BasicMinimalUpdatePath','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('BasicStandardUpdatePath','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('BasicUpgradePath','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('BatchMemoryQueue','class','includes/batch.queue.inc','',0),('BatchPageTestCase','class','modules/simpletest/tests/batch.test','simpletest',0),('BatchPercentagesUnitTestCase','class','modules/simpletest/tests/batch.test','simpletest',0),('BatchProcessingTestCase','class','modules/simpletest/tests/batch.test','simpletest',0),('BatchQueue','class','includes/batch.queue.inc','',0),('BlockAdminThemeTestCase','class','modules/block/block.test','block',-5),('BlockCacheTestCase','class','modules/block/block.test','block',-5),('BlockHashTestCase','class','modules/block/block.test','block',-5),('BlockHiddenRegionTestCase','class','modules/block/block.test','block',-5),('BlockHTMLIdTestCase','class','modules/block/block.test','block',-5),('BlockInvalidRegionTestCase','class','modules/block/block.test','block',-5),('BlockTemplateSuggestionsUnitTest','class','modules/block/block.test','block',-5),('BlockTestCase','class','modules/block/block.test','block',-5),('BlockViewModuleDeltaAlterWebTest','class','modules/block/block.test','block',-5),('BlogTestCase','class','modules/blog/blog.test','blog',0),('BookTestCase','class','modules/book/book.test','book',0),('BootstrapAutoloadTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapDestinationTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapGetFilenameTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapIPAddressTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapMiscTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapOverrideServerVariablesTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapPageCacheTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapResettableStaticTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapTimerTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BootstrapVariableTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('BoxEntityTypeUIController','class','sites/all/modules/contrib/entity_boxes/entity_boxes_type.admin.inc','entity_boxes',0),('BoxEntityUIController','class','sites/all/modules/contrib/entity_boxes/entity_boxes.admin.inc','entity_boxes',0),('BoxesAjaxTestCase','class','sites/all/modules/contrib/boxes/tests/boxes.test','boxes',0),('BoxesBasicAjaxTestCase','class','sites/all/modules/contrib/boxes/tests/boxes.test','boxes',0),('BoxesTestCase','class','sites/all/modules/contrib/boxes/tests/boxes.test','boxes',0),('boxes_box','class','sites/all/modules/contrib/boxes/plugins/boxes_box.inc','boxes',0),('boxes_simple','class','sites/all/modules/contrib/boxes/plugins/boxes_simple.inc','boxes',0),('CacheClearCase','class','modules/simpletest/tests/cache.test','simpletest',0),('CacheGetMultipleUnitTest','class','modules/simpletest/tests/cache.test','simpletest',0),('CacheIsEmptyCase','class','modules/simpletest/tests/cache.test','simpletest',0),('CacheSavingCase','class','modules/simpletest/tests/cache.test','simpletest',0),('CacheTestCase','class','modules/simpletest/tests/cache.test','simpletest',0),('CaptchaAdminTestCase','class','sites/all/modules/contrib/captcha/captcha.test','captcha',0),('CaptchaBaseWebTestCase','class','sites/all/modules/contrib/captcha/captcha.test','captcha',0),('CaptchaPersistenceTestCase','class','sites/all/modules/contrib/captcha/captcha.test','captcha',0),('CaptchaSessionReuseAttackTestCase','class','sites/all/modules/contrib/captcha/captcha.test','captcha',0),('CaptchaTestCase','class','sites/all/modules/contrib/captcha/captcha.test','captcha',0),('CascadingStylesheetsTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('CascadingStylesheetsUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('CategorizeFeedItemTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('CategorizeFeedTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('ColorTestCase','class','modules/color/color.test','color',0),('CommentActionsTestCase','class','modules/comment/comment.test','comment',0),('CommentAnonymous','class','modules/comment/comment.test','comment',0),('CommentApprovalTest','class','modules/comment/comment.test','comment',0),('CommentBlockFunctionalTest','class','modules/comment/comment.test','comment',0),('CommentContentRebuild','class','modules/comment/comment.test','comment',0),('CommentFieldsTest','class','modules/comment/comment.test','comment',0),('CommentHelperCase','class','modules/comment/comment.test','comment',0),('CommentInterfaceTest','class','modules/comment/comment.test','comment',0),('CommentNodeAccessTest','class','modules/comment/comment.test','comment',0),('CommentNodeChangesTestCase','class','modules/comment/comment.test','comment',0),('CommentPagerTest','class','modules/comment/comment.test','comment',0),('CommentPreviewTest','class','modules/comment/comment.test','comment',0),('CommentRSSUnitTest','class','modules/comment/comment.test','comment',0),('CommentThreadingTestCase','class','modules/comment/comment.test','comment',0),('CommentTokenReplaceTestCase','class','modules/comment/comment.test','comment',0),('CommentUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.comment.test','simpletest',0),('CommonSizeTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('CommonURLUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('CommonXssUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('ConditionalStylesheetsTestCase','class','sites/all/modules/contrib/conditional_styles/tests/conditional_styles.test','conditional_styles',0),('ConfirmFormTest','class','modules/system/system.test','system',0),('ConnectionUnitTest','class','modules/simpletest/tests/database_test.test','simpletest',0),('ContactPersonalTestCase','class','modules/contact/contact.test','contact',0),('ContactSitewideTestCase','class','modules/contact/contact.test','contact',0),('ContextConditionBookroot','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionBookTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionContextTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionLanguageTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionMenuTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionNodeTaxonomyTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionNodeTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionPathTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionSitewideTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionUserPageTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextConditionUserTest','class','sites/all/modules/contrib/context/tests/context.conditions.test','context',0),('ContextReactionBlockAjaxAccessTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionBlockAjaxTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionBlockTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionBreadcrumbTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionMenuTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionRegionTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextReactionThemeHtmlTest','class','sites/all/modules/contrib/context/tests/context.reactions.test','context',0),('ContextualDynamicContextTestCase','class','modules/contextual/contextual.test','contextual',0),('ContextUiTestCase','class','sites/all/modules/contrib/context/context_ui/tests/context_ui.test','context_ui',0),('ContextUnitTest','class','sites/all/modules/contrib/context/tests/context.test','context',0),('context_condition','class','sites/all/modules/contrib/context/plugins/context_condition.inc','context',0),('context_condition_context','class','sites/all/modules/contrib/context/plugins/context_condition_context.inc','context',0),('context_condition_context_all','class','sites/all/modules/contrib/context/plugins/context_condition_context_all.inc','context',0),('context_condition_default','class','sites/all/modules/contrib/context/plugins/context_condition_default.inc','context',0),('context_condition_language','class','sites/all/modules/contrib/context/plugins/context_condition_language.inc','context',0),('context_condition_menu','class','sites/all/modules/contrib/context/plugins/context_condition_menu.inc','context',0),('context_condition_node','class','sites/all/modules/contrib/context/plugins/context_condition_node.inc','context',0),('context_condition_node_taxonomy','class','sites/all/modules/contrib/context/plugins/context_condition_node_taxonomy.inc','context',0),('context_condition_path','class','sites/all/modules/contrib/context/plugins/context_condition_path.inc','context',0),('context_condition_query_string','class','sites/all/modules/contrib/context/plugins/context_condition_query_string.inc','context',0),('context_condition_sitewide','class','sites/all/modules/contrib/context/plugins/context_condition_sitewide.inc','context',0),('context_condition_taxonomy_term','class','sites/all/modules/contrib/context/plugins/context_condition_taxonomy_term.inc','context',0),('context_condition_user','class','sites/all/modules/contrib/context/plugins/context_condition_user.inc','context',0),('context_condition_user_page','class','sites/all/modules/contrib/context/plugins/context_condition_user_page.inc','context',0),('context_condition_views','class','sites/all/modules/contrib/context/plugins/context_condition_views.inc','context',0),('context_export_ui','class','sites/all/modules/contrib/context/context_ui/export_ui/context_export_ui.class.php','context_ui',0),('context_layouts_reaction_block','class','sites/all/modules/contrib/context/context_layouts/plugins/context_layouts_reaction_block.inc','context_layouts',0),('context_reaction','class','sites/all/modules/contrib/context/plugins/context_reaction.inc','context',0),('context_reaction_block','class','sites/all/modules/contrib/context/plugins/context_reaction_block.inc','context',0),('context_reaction_breadcrumb','class','sites/all/modules/contrib/context/plugins/context_reaction_breadcrumb.inc','context',0),('context_reaction_debug','class','sites/all/modules/contrib/context/plugins/context_reaction_debug.inc','context',0),('context_reaction_delta','class','sites/all/modules/contrib/delta/plugins/context/context_reaction_delta.inc','delta',0),('context_reaction_menu','class','sites/all/modules/contrib/context/plugins/context_reaction_menu.inc','context',0),('context_reaction_region','class','sites/all/modules/contrib/context/plugins/context_reaction_region.inc','context',0),('context_reaction_template_suggestions','class','sites/all/modules/contrib/context/plugins/context_reaction_template_suggestions.inc','context',0),('context_reaction_theme','class','sites/all/modules/contrib/context/plugins/context_reaction_theme.inc','context',0),('context_reaction_theme_html','class','sites/all/modules/contrib/context/plugins/context_reaction_theme_html.inc','context',0),('CronQueueTestCase','class','modules/system/system.test','system',0),('CronRunTestCase','class','modules/system/system.test','system',0),('CtoolsContextKeywordsSubstitutionTestCase','class','sites/all/modules/contrib/ctools/tests/context.test','ctools_plugin_test',0),('CToolsCssCache','class','sites/all/modules/contrib/ctools/includes/css-cache.inc','ctools',0),('CtoolsCssTestCase','class','sites/all/modules/contrib/ctools/tests/css.test','ctools_plugin_test',0),('CtoolsExportCrudTestCase','class','sites/all/modules/contrib/ctools/tests/ctools_export_test/ctools_export.test','ctools_export_test',0),('CtoolsMathExpressionStackTestCase','class','sites/all/modules/contrib/ctools/tests/math_expression_stack.test','ctools_plugin_test',0),('CtoolsMathExpressionTestCase','class','sites/all/modules/contrib/ctools/tests/math_expression.test','ctools_plugin_test',0),('CtoolsObjectCache','class','sites/all/modules/contrib/ctools/tests/object_cache.test','ctools_plugin_test',0),('CtoolsPluginsGetInfoTestCase','class','sites/all/modules/contrib/ctools/tests/ctools.plugins.test','ctools_plugin_test',0),('ctools_context','class','sites/all/modules/contrib/ctools/includes/context.inc','ctools',0),('ctools_context_optional','class','sites/all/modules/contrib/ctools/includes/context.inc','ctools',0),('ctools_context_required','class','sites/all/modules/contrib/ctools/includes/context.inc','ctools',0),('ctools_custom_content_ui','class','sites/all/modules/contrib/ctools/ctools_custom_content/plugins/export_ui/ctools_custom_content_ui.class.php','ctools_custom_content',0),('ctools_export_ui','class','sites/all/modules/contrib/ctools/plugins/export_ui/ctools_export_ui.class.php','ctools',0),('ctools_math_expr','class','sites/all/modules/contrib/ctools/includes/math-expr.inc','ctools',0),('ctools_math_expr_stack','class','sites/all/modules/contrib/ctools/includes/math-expr.inc','ctools',0),('ctools_stylizer_image_processor','class','sites/all/modules/contrib/ctools/includes/stylizer.inc','ctools',0),('DashboardBlocksTestCase','class','modules/dashboard/dashboard.test','dashboard',0),('Database','class','includes/database/database.inc','',0),('DatabaseAlterTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseBasicSyntaxTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseCaseSensitivityTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseCondition','class','includes/database/query.inc','',0),('DatabaseConnection','class','includes/database/database.inc','',0),('DatabaseConnectionNotDefinedException','class','includes/database/database.inc','',0),('DatabaseConnectionTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseConnection_mysql','class','includes/database/mysql/database.inc','',0),('DatabaseConnection_pgsql','class','includes/database/pgsql/database.inc','',0),('DatabaseConnection_sqlite','class','includes/database/sqlite/database.inc','',0),('DatabaseDeleteTruncateTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseDriverNotSpecifiedException','class','includes/database/database.inc','',0),('DatabaseEmptyStatementTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseFetch2TestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseFetchTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseInsertDefaultsTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseInsertLOBTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseInsertTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseInvalidDataTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseLog','class','includes/database/log.inc','',0),('DatabaseLoggingTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseMergeTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseNextIdCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseQueryTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseRangeQueryTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseRegressionTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSchema','class','includes/database/schema.inc','',0),('DatabaseSchemaObjectDoesNotExistException','class','includes/database/schema.inc','',0),('DatabaseSchemaObjectExistsException','class','includes/database/schema.inc','',0),('DatabaseSchema_mysql','class','includes/database/mysql/schema.inc','',0),('DatabaseSchema_pgsql','class','includes/database/pgsql/schema.inc','',0),('DatabaseSchema_sqlite','class','includes/database/sqlite/schema.inc','',0),('DatabaseSelectCloneTest','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectComplexTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectComplexTestCase2','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectOrderedTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectPagerDefaultTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectSubqueryTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectTableSortDefaultTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSelectTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseSerializeQueryTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseStatementBase','class','includes/database/database.inc','',0),('DatabaseStatementEmpty','class','includes/database/database.inc','',0),('DatabaseStatementInterface','interface','includes/database/database.inc','',0),('DatabaseStatementPrefetch','class','includes/database/prefetch.inc','',0),('DatabaseStatement_sqlite','class','includes/database/sqlite/database.inc','',0),('DatabaseTaggingTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseTaskException','class','includes/install.inc','',0),('DatabaseTasks','class','includes/install.inc','',0),('DatabaseTasks_mysql','class','includes/database/mysql/install.inc','',0),('DatabaseTasks_pgsql','class','includes/database/pgsql/install.inc','',0),('DatabaseTasks_sqlite','class','includes/database/sqlite/install.inc','',0),('DatabaseTemporaryQueryTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseTransaction','class','includes/database/database.inc','',0),('DatabaseTransactionCommitFailedException','class','includes/database/database.inc','',0),('DatabaseTransactionExplicitCommitNotAllowedException','class','includes/database/database.inc','',0),('DatabaseTransactionNameNonUniqueException','class','includes/database/database.inc','',0),('DatabaseTransactionNoActiveException','class','includes/database/database.inc','',0),('DatabaseTransactionOutOfOrderException','class','includes/database/database.inc','',0),('DatabaseTransactionTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseUpdateComplexTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseUpdateLOBTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DatabaseUpdateTestCase','class','modules/simpletest/tests/database_test.test','simpletest',0),('DateAPITestCase','class','sites/all/modules/contrib/date/tests/date_api.test','date',0),('DateFieldBasic','class','sites/all/modules/contrib/date/tests/date_field.test','date',0),('DateFieldTestCase','class','sites/all/modules/contrib/date/tests/date_field.test','date',0),('DateMigrateExampleUnitTest','class','sites/all/modules/contrib/date/tests/date_migrate.test','date',0),('DateMigrateFieldHandler','class','sites/all/modules/contrib/date/date.migrate.inc','date',0),('DateObject','class','sites/all/modules/contrib/date/date_api/date_api.module','date_api',0),('DateRepeatFormTestCase','class','sites/all/modules/contrib/date/date_repeat/tests/date_repeat_form.test','date_repeat',0),('DateRepeatTestCase','class','sites/all/modules/contrib/date/date_repeat/tests/date_repeat.test','date_repeat',0),('DateTimeFunctionalTest','class','modules/system/system.test','system',0),('DateTimezoneTestCase','class','sites/all/modules/contrib/date/tests/date_timezone.test','date',0),('DateToolsTestCase','class','sites/all/modules/contrib/date/date_tools/tests/date_tools.test','date_tools',0),('DateUITestCase','class','sites/all/modules/contrib/date/tests/date.test','date',0),('DateValidationTestCase','class','sites/all/modules/contrib/date/tests/date_validation.test','date',0),('DateViewsPopupTestCase','class','sites/all/modules/contrib/date/tests/date_views_popup.test','date',0),('date_sql_handler','class','sites/all/modules/contrib/date/date_api/date_api_sql.inc','date_api',0),('date_views_argument_handler','class','sites/all/modules/contrib/date/date_views/includes/date_views_argument_handler.inc','date_views',0),('date_views_argument_handler_simple','class','sites/all/modules/contrib/date/date_views/includes/date_views_argument_handler_simple.inc','date_views',0),('date_views_filter_handler','class','sites/all/modules/contrib/date/date_views/includes/date_views_filter_handler.inc','date_views',0),('date_views_filter_handler_simple','class','sites/all/modules/contrib/date/date_views/includes/date_views_filter_handler_simple.inc','date_views',0),('date_views_plugin_pager','class','sites/all/modules/contrib/date/date_views/includes/date_views_plugin_pager.inc','date_views',0),('DBLogTestCase','class','modules/dblog/dblog.test','dblog',0),('defaultcontent_condition','class','sites/all/modules/contrib/defaultcontent/context/plugins/defaultcontent_condition.inc','defaultcontent',0),('DefaultMailSystem','class','modules/system/system.mail.inc','system',0),('DeleteQuery','class','includes/database/query.inc','',0),('DeleteQuery_sqlite','class','includes/database/sqlite/query.inc','',0),('delta_export_ui','class','sites/all/modules/contrib/delta/delta_ui/export_ui/delta_export_ui.class.php','delta_ui',0),('delta_injection','class','sites/all/modules/contrib/delta/plugins/delta/delta_injection.inc','delta',0),('delta_injection_color','class','sites/all/modules/contrib/delta/delta_color/plugins/delta_injection_color.inc','delta_color',0),('delta_injection_theme_settings','class','sites/all/modules/contrib/delta/plugins/delta/delta_injection_theme_settings.inc','delta',0),('Diff','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('DiffFormatter','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('DisabledNodeTypeTestCase','class','modules/simpletest/tests/upgrade/upgrade.node.test','simpletest',0),('DrupalAddFeedTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalAlterTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalAttributesUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalCacheArray','class','includes/bootstrap.inc','',0),('DrupalCacheInterface','interface','includes/cache.inc','',0),('DrupalDataApiTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalDatabaseCache','class','includes/cache.inc','',0),('DrupalDefaultEntityController','class','includes/entity.inc','',0),('DrupalDiffFormatter','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('DrupalDiffInline','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('DrupalEntityControllerInterface','interface','includes/entity.inc','',0),('DrupalErrorCollectionUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalErrorHandlerTestCase','class','modules/simpletest/tests/error.test','simpletest',0),('DrupalFakeCache','class','includes/cache-install.inc','',0),('DrupalGetQueryArrayTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalGetRdfNamespacesTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalGotoTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalHTMLIdentifierTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalHtmlToTextTestCase','class','modules/simpletest/tests/mail.test','simpletest',0),('DrupalHTTPRequestTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalHTTPResponseStatusLineTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalJSONTest','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalLocalStreamWrapper','class','includes/stream_wrappers.inc','',0),('DrupalMatchPathTestCase','class','modules/simpletest/tests/path.test','simpletest',0),('DrupalPrivateStreamWrapper','class','includes/stream_wrappers.inc','',0),('DrupalPublicStreamWrapper','class','includes/stream_wrappers.inc','',0),('DrupalQueue','class','modules/system/system.queue.inc','system',0),('DrupalQueueInterface','interface','modules/system/system.queue.inc','system',0),('DrupalReliableQueueInterface','interface','modules/system/system.queue.inc','system',0),('DrupalRenderTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalSetContentTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalSetMessageTest','class','modules/system/system.test','system',0),('DrupalStreamWrapperInterface','interface','includes/stream_wrappers.inc','',0),('DrupalSystemListingTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalTagsHandlingTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('DrupalTemporaryStreamWrapper','class','includes/stream_wrappers.inc','',0),('DrupalTestCase','class','modules/simpletest/drupal_web_test_case.php','simpletest',0),('DrupalUnitTestCase','class','modules/simpletest/drupal_web_test_case.php','simpletest',0),('DrupalUpdateException','class','includes/update.inc','',0),('DrupalUpdaterInterface','interface','includes/updater.inc','',0),('DrupalWebTestCase','class','modules/simpletest/drupal_web_test_case.php','simpletest',0),('EarlyBootstrapTestCase','class','modules/simpletest/tests/boot.test','simpletest',0),('EnableDisableTestCase','class','modules/system/system.test','system',0),('Entity','class','sites/all/modules/contrib/entity/includes/entity.inc','entity',0),('EntityAPICommentNodeAccessTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityAPIController','class','sites/all/modules/contrib/entity/includes/entity.controller.inc','entity',0),('EntityAPIControllerExportable','class','sites/all/modules/contrib/entity/includes/entity.controller.inc','entity',0),('EntityAPIControllerInterface','interface','sites/all/modules/contrib/entity/includes/entity.controller.inc','entity',0),('EntityAPIControllerRevisionableInterface','interface','sites/all/modules/contrib/entity/includes/entity.controller.inc','entity',0),('EntityAPIi18nItegrationTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityAPIRulesIntegrationTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityAPITestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityBundleableUIController','class','sites/all/modules/contrib/entity/includes/entity.ui.inc','entity',0),('EntityCacheBlogTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheBookTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentAnonymous','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentApprovalTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentBlockFunctionalTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentContentRebuild','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentController','class','sites/all/modules/contrib/entitycache/includes/entitycache.comment.inc','entitycache',0),('EntityCacheCommentFieldsTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentHelperCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentNodeAccessTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentNodeTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentPagerTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentPreviewTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentRSSUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheCommentTokenReplaceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheControllerHelper','class','sites/all/modules/contrib/entitycache/includes/entitycache.entitycachecontrollerhelper.inc','entitycache',0),('EntityCacheDefaultEntityController','class','sites/all/modules/contrib/entitycache/includes/entitycache.defaultentitycontroller.inc','entitycache',0),('EntityCacheMultiStepNodeFormBasicOptionsTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeAccessRebuildTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeAccessRecordsUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeAccessUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeAdminTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeBlockFunctionalTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeBlockTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeBuildContent','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeController','class','sites/all/modules/contrib/entitycache/includes/entitycache.node.inc','entitycache',0),('EntityCacheNodeCreationTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeEntityFieldQueryAlter','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeFeedTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeLoadHooksTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeLoadMultipleUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodePostSettingsTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeQueryAlter','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeRevisionsTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeRSSContentTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeSaveTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeTitleTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeTitleXSSTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeTokenReplaceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeTypePersistenceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheNodeTypeTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePageEditTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePagePreviewTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePageViewTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollBlockTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollCreateTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollExpirationTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollJSAddChoice','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollTokenReplaceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollVoteCheckHostname','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCachePollVoteTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheSummaryLengthTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyHooksTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyLegacyTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyLoadMultipleUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyTermController','class','sites/all/modules/contrib/entitycache/includes/entitycache.taxonomy.inc','entitycache',0),('EntityCacheTaxonomyTermFieldTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyTermTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyTermUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyThemeTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyTokenReplaceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyVocabularyController','class','sites/all/modules/contrib/entitycache/includes/entitycache.taxonomy.inc','entitycache',0),('EntityCacheTaxonomyVocabularyFunctionalTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyVocabularyUnitTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTaxonomyWebTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheTranslationTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserAccountLinksUnitTests','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserAdminTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserAuthmapAssignmentTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserAutocompleteTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserBlocksUnitTests','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserCancelTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserController','class','sites/all/modules/contrib/entitycache/includes/entitycache.user.inc','entitycache',0),('EntityCacheUserCreateTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserEditedOwnAccountTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserEditTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserLoginTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserPermissionsTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserPictureTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserRegistrationTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserRoleAdminTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserRolesAssignmentTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserSaveTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserSignatureTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserTimeZoneFunctionalTest','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserTokenReplaceTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserUserSearchTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserValidateCurrentPassCustomForm','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityCacheUserValidationTestCase','class','sites/all/modules/contrib/entitycache/entitycache.test','entitycache',0),('EntityContentUIController','class','sites/all/modules/contrib/entity/includes/entity.ui.inc','entity',0),('EntityCrudHookTestCase','class','modules/simpletest/tests/entity_crud_hook_test.test','simpletest',0),('EntityDB','class','sites/all/modules/contrib/entity/includes/entity.inc','entity',0),('EntityDBExtendable','class','sites/all/modules/contrib/entity/includes/entity.inc','entity',0),('EntityDefaultExtraFieldsController','class','sites/all/modules/contrib/entity/entity.info.inc','entity',0),('EntityDefaultFeaturesController','class','sites/all/modules/contrib/entity/entity.features.inc','entity',0),('EntityDefaultI18nStringController','class','sites/all/modules/contrib/entity/entity.i18n.inc','entity',0),('EntityDefaultMetadataController','class','sites/all/modules/contrib/entity/entity.info.inc','entity',0),('EntityDefaultRulesController','class','sites/all/modules/contrib/entity/entity.rules.inc','entity',0),('EntityDefaultUIController','class','sites/all/modules/contrib/entity/includes/entity.ui.inc','entity',0),('EntityDefaultViewsController','class','sites/all/modules/contrib/entity/views/entity.views.inc','entity',0),('EntityDrupalWrapper','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityExtendable','class','sites/all/modules/contrib/entity/includes/entity.inc','entity',0),('EntityExtraFieldsControllerInterface','interface','sites/all/modules/contrib/entity/entity.info.inc','entity',0),('EntityFieldHandlerHelper','class','sites/all/modules/contrib/entity/views/handlers/entity_views_field_handler_helper.inc','entity',0),('EntityFieldQuery','class','includes/entity.inc','',0),('EntityFieldQueryException','class','includes/entity.inc','',0),('EntityFieldQueryTestCase','class','modules/simpletest/tests/entity_query.test','simpletest',0),('EntityInterface','interface','sites/all/modules/contrib/entity/includes/entity.inc','entity',0),('EntityListWrapper','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityLoadTestCase','class','modules/simpletest/tests/entity_crud.test','simpletest',0),('EntityMalformedException','class','includes/entity.inc','',0),('EntityMetadataArrayObject','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityMetadataIntegrationTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityMetadataNodeAccessTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityMetadataNodeCreateAccessTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityMetadataNodeRevisionAccessTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityMetadataTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityMetadataWrapper','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityMetadataWrapperException','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityMetadataWrapperIterator','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityPropertiesTestCase','class','modules/field/tests/field.test','field',0),('EntityStructureWrapper','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityTokenTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('EntityValueWrapper','class','sites/all/modules/contrib/entity/includes/entity.wrapper.inc','entity',0),('EntityWebTestCase','class','sites/all/modules/contrib/entity/entity.test','entity',0),('entity_boxes_handler_delete_link_field','class','sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_delete_link_field.inc','entity_boxes',0),('entity_boxes_handler_edit_link_field','class','sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_edit_link_field.inc','entity_boxes',0),('entity_boxes_handler_entity_boxes_operations_field','class','sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_entity_boxes_operations_field.inc','entity_boxes',0),('entity_boxes_handler_link_field','class','sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_link_field.inc','entity_boxes',0),('entity_views_handler_area_entity','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_area_entity.inc','entity',0),('entity_views_handler_field_boolean','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_boolean.inc','entity',0),('entity_views_handler_field_date','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_date.inc','entity',0),('entity_views_handler_field_duration','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_duration.inc','entity',0),('entity_views_handler_field_entity','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_entity.inc','entity',0),('entity_views_handler_field_field','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_field.inc','entity',0),('entity_views_handler_field_numeric','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_numeric.inc','entity',0),('entity_views_handler_field_options','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_options.inc','entity',0),('entity_views_handler_field_text','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_text.inc','entity',0),('entity_views_handler_field_uri','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_uri.inc','entity',0),('entity_views_handler_relationship','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_relationship.inc','entity',0),('entity_views_handler_relationship_by_bundle','class','sites/all/modules/contrib/entity/views/handlers/entity_views_handler_relationship_by_bundle.inc','entity',0),('entity_views_plugin_row_entity_view','class','sites/all/modules/contrib/entity/views/plugins/entity_views_plugin_row_entity_view.inc','entity',0),('FakeRecord','class','modules/simpletest/tests/database_test.test','simpletest',0),('FeaturesCtoolsIntegrationTest','class','sites/all/modules/contrib/features/tests/features.test','features',20),('FeaturesDetectionTestCase','class','sites/all/modules/contrib/features/tests/features.test','features',20),('FeaturesEnableTestCase','class','sites/all/modules/contrib/features/tests/features.test','features',20),('FeaturesUserTestCase','class','sites/all/modules/contrib/features/tests/features.test','features',20),('FeedIconTest','class','modules/simpletest/tests/common.test','simpletest',0),('FeedParserTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('FieldAttachOtherTestCase','class','modules/field/tests/field.test','field',0),('FieldAttachStorageTestCase','class','modules/field/tests/field.test','field',0),('FieldAttachTestCase','class','modules/field/tests/field.test','field',0),('FieldBulkDeleteTestCase','class','modules/field/tests/field.test','field',0),('FieldCrudTestCase','class','modules/field/tests/field.test','field',0),('FieldDisplayAPITestCase','class','modules/field/tests/field.test','field',0),('FieldException','class','modules/field/field.module','field',0),('FieldFormTestCase','class','modules/field/tests/field.test','field',0),('FieldInfo','class','modules/field/field.info.class.inc','field',0),('FieldInfoTestCase','class','modules/field/tests/field.test','field',0),('FieldInstanceCrudTestCase','class','modules/field/tests/field.test','field',0),('FieldsOverlapException','class','includes/database/database.inc','',0),('FieldSqlStorageTestCase','class','modules/field/modules/field_sql_storage/field_sql_storage.test','field_sql_storage',0),('FieldTestCase','class','modules/field/tests/field.test','field',0),('FieldTranslationsTestCase','class','modules/field/tests/field.test','field',0),('FieldUIAlterTestCase','class','modules/field_ui/field_ui.test','field_ui',0),('FieldUIManageDisplayTestCase','class','modules/field_ui/field_ui.test','field_ui',0),('FieldUIManageFieldsTestCase','class','modules/field_ui/field_ui.test','field_ui',0),('FieldUITestCase','class','modules/field_ui/field_ui.test','field_ui',0),('FieldUpdateForbiddenException','class','modules/field/field.module','field',0),('FieldUpdatePathTestCase','class','modules/simpletest/tests/upgrade/update.field.test','simpletest',0),('FieldValidationException','class','modules/field/field.attach.inc','field',0),('FileCopyTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileDeleteTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileDirectoryTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileDownloadTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileFieldDisplayTestCase','class','modules/file/tests/file.test','file',0),('FileFieldPathTestCase','class','modules/file/tests/file.test','file',0),('FileFieldRevisionTestCase','class','modules/file/tests/file.test','file',0),('FileFieldTestCase','class','modules/file/tests/file.test','file',0),('FileFieldValidateTestCase','class','modules/file/tests/file.test','file',0),('FileFieldWidgetTestCase','class','modules/file/tests/file.test','file',0),('FileHookTestCase','class','modules/simpletest/tests/file.test','simpletest',0),('FileLoadTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileManagedFileElementTestCase','class','modules/file/tests/file.test','file',0),('FileMimeTypeTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileMoveTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileNameMungingTest','class','modules/simpletest/tests/file.test','simpletest',0),('FilePrivateTestCase','class','modules/file/tests/file.test','file',0),('FileSaveDataTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileSaveTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileSaveUploadTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileScanDirectoryTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileSpaceUsedTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileTaxonomyTermTestCase','class','modules/file/tests/file.test','file',0),('FileTestCase','class','modules/simpletest/tests/file.test','simpletest',0),('FileTokenReplaceTestCase','class','modules/file/tests/file.test','file',0),('FileTranferTest','class','modules/simpletest/tests/filetransfer.test','simpletest',0),('FileTransfer','class','includes/filetransfer/filetransfer.inc','',0),('FileTransferChmodInterface','interface','includes/filetransfer/filetransfer.inc','',0),('FileTransferException','class','includes/filetransfer/filetransfer.inc','',0),('FileTransferFTP','class','includes/filetransfer/ftp.inc','',0),('FileTransferFTPExtension','class','includes/filetransfer/ftp.inc','',0),('FileTransferLocal','class','includes/filetransfer/local.inc','',0),('FileTransferSSH','class','includes/filetransfer/ssh.inc','',0),('FileUnmanagedCopyTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileUnmanagedDeleteRecursiveTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileUnmanagedDeleteTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileUnmanagedMoveTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileUnmanagedSaveDataTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileURLRewritingTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileUsageTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileValidateTest','class','modules/simpletest/tests/file.test','simpletest',0),('FileValidatorTest','class','modules/simpletest/tests/file.test','simpletest',0),('FilledMinimalUpdatePath','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('FilledStandardUpdatePath','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('FilterAdminTestCase','class','modules/filter/filter.test','filter',0),('FilterCRUDTestCase','class','modules/filter/filter.test','filter',0),('FilterDefaultFormatTestCase','class','modules/filter/filter.test','filter',0),('FilterDOMSerializeTestCase','class','modules/filter/filter.test','filter',0),('FilterFormatAccessTestCase','class','modules/filter/filter.test','filter',0),('FilterFormatUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.filter.test','simpletest',0),('FilterHooksTestCase','class','modules/filter/filter.test','filter',0),('FilterNoFormatTestCase','class','modules/filter/filter.test','filter',0),('FilterSecurityTestCase','class','modules/filter/filter.test','filter',0),('FilterSettingsTestCase','class','modules/filter/filter.test','filter',0),('FilterUnitTestCase','class','modules/filter/filter.test','filter',0),('FloodFunctionalTest','class','modules/system/system.test','system',0),('FormAlterTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormatDateUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('FormCheckboxTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormElementTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsArbitraryRebuildTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsElementsLabelsTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsElementsTableSelectFunctionalTest','class','modules/simpletest/tests/form.test','simpletest',0),('FormsElementsVerticalTabsFunctionalTest','class','modules/simpletest/tests/form.test','simpletest',0),('FormsFileInclusionTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsFormStoragePageCacheTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsFormStorageTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsFormWrapperTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsProgrammaticTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsRebuildTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsRedirectTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormStateValuesCleanAdvancedTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormStateValuesCleanTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormsTriggeringElementTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('FormValidationTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('ForumIndexTestCase','class','modules/forum/forum.test','forum',0),('ForumTestCase','class','modules/forum/forum.test','forum',0),('ForumUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.forum.test','simpletest',0),('FrontPageTestCase','class','modules/system/system.test','system',0),('GoogleAnalyticsBasicTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GoogleAnalyticsCustomDimensionsAndMetricsTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GoogleAnalyticsPhpFilterTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GoogleAnalyticsRolesTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GoogleAnalyticsSearchTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GoogleAnalyticsStatusMessagesTest','class','sites/all/modules/contrib/google_analytics/googleanalytics.test','googleanalytics',0),('GraphUnitTest','class','modules/simpletest/tests/graph.test','simpletest',0),('GroupDisplayTestCase','class','sites/all/modules/contrib/field_group/tests/field_group.display.test','field_group',1),('GroupUITestCase','class','sites/all/modules/contrib/field_group/tests/field_group.ui.test','field_group',1),('HelpTestCase','class','modules/help/help.test','help',0),('HookBootExitTestCase','class','modules/simpletest/tests/bootstrap.test','simpletest',0),('HookRequirementsTestCase','class','modules/system/system.test','system',0),('HTMLIdTestCase','class','modules/simpletest/tests/form.test','simpletest',0),('ImageAdminStylesUnitTest','class','modules/image/image.test','image',0),('ImageAdminUiTestCase','class','modules/image/image.test','image',0),('ImageDimensionsScaleTestCase','class','modules/image/image.test','image',0),('ImageDimensionsTestCase','class','modules/image/image.test','image',0),('ImageEffectsUnitTest','class','modules/image/image.test','image',0),('ImageFieldDefaultImagesTestCase','class','modules/image/image.test','image',0),('ImageFieldDisplayTestCase','class','modules/image/image.test','image',0),('ImageFieldTestCase','class','modules/image/image.test','image',0),('ImageFieldValidateTestCase','class','modules/image/image.test','image',0),('ImageFileMoveTest','class','modules/simpletest/tests/image.test','simpletest',0),('ImageStyleFlushTest','class','modules/image/image.test','image',0),('ImageStylesPathAndUrlTestCase','class','modules/image/image.test','image',0),('ImageThemeFunctionWebTestCase','class','modules/image/image.test','image',0),('ImageToolkitGdTestCase','class','modules/simpletest/tests/image.test','simpletest',0),('ImageToolkitTestCase','class','modules/simpletest/tests/image.test','simpletest',0),('ImageToolkitUnitTest','class','modules/simpletest/tests/image.test','simpletest',0),('ImportOPMLTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('InfoFileParserTestCase','class','modules/system/system.test','system',0),('InsertQuery','class','includes/database/query.inc','',0),('InsertQuery_mysql','class','includes/database/mysql/query.inc','',0),('InsertQuery_pgsql','class','includes/database/pgsql/query.inc','',0),('InsertQuery_sqlite','class','includes/database/sqlite/query.inc','',0),('InvalidMergeQueryException','class','includes/database/database.inc','',0),('IPAddressBlockingTestCase','class','modules/system/system.test','system',0),('JavaScriptTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('LibrariesAdminWebTest','class','sites/all/modules/contrib/libraries/tests/LibrariesAdminWebTest.test','libraries',0),('LibrariesLoadWebTest','class','sites/all/modules/contrib/libraries/tests/LibrariesLoadWebTest.test','libraries',0),('LibrariesUnitTest','class','sites/all/modules/contrib/libraries/tests/LibrariesUnitTest.test','libraries',0),('LibrariesWebTestBase','class','sites/all/modules/contrib/libraries/tests/LibrariesWebTestBase.test','libraries',0),('LinkAttributeCrudTest','class','sites/all/modules/contrib/link/tests/link.attribute.test','link',0),('LinkBaseTestClass','class','sites/all/modules/contrib/link/tests/link.test','link',0),('LinkContentCrudTest','class','sites/all/modules/contrib/link/tests/link.crud.test','link',0),('LinkEntityTokenTest','class','sites/all/modules/contrib/link/tests/link.entity_token.test','link',0),('LinkTokenTest','class','sites/all/modules/contrib/link/tests/link.token.test','link',0),('LinkUITest','class','sites/all/modules/contrib/link/tests/link.crud_browser.test','link',0),('LinkValidateSpecificURL','class','sites/all/modules/contrib/link/tests/link.validate.test','link',0),('LinkValidateTest','class','sites/all/modules/contrib/link/tests/link.validate.test','link',0),('LinkValidateTestCase','class','sites/all/modules/contrib/link/tests/link.validate.test','link',0),('LinkValidateTestNews','class','sites/all/modules/contrib/link/tests/link.validate.test','link',0),('LinkValidateUrlLight','class','sites/all/modules/contrib/link/tests/link.validate.test','link',0),('link_views_handler_argument_target','class','sites/all/modules/contrib/link/views/link_views_handler_argument_target.inc','link',0),('link_views_handler_filter_protocol','class','sites/all/modules/contrib/link/views/link_views_handler_filter_protocol.inc','link',0),('ListDynamicValuesTestCase','class','modules/field/modules/list/tests/list.test','list',0),('ListDynamicValuesValidationTestCase','class','modules/field/modules/list/tests/list.test','list',0),('ListFieldTestCase','class','modules/field/modules/list/tests/list.test','list',0),('ListFieldUITestCase','class','modules/field/modules/list/tests/list.test','list',0),('LocaleBrowserDetectionTest','class','modules/locale/locale.test','locale',0),('LocaleCommentLanguageFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleConfigurationTest','class','modules/locale/locale.test','locale',0),('LocaleContentFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleCSSAlterTest','class','modules/locale/locale.test','locale',0),('LocaleDateFormatsFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleExportFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleImportFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleInstallTest','class','modules/locale/locale.test','locale',0),('LocaleJavascriptTranslationTest','class','modules/locale/locale.test','locale',0),('LocaleLanguageNegotiationInfoFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleLanguageSwitchingFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleLibraryInfoAlterTest','class','modules/locale/locale.test','locale',0),('LocaleMultilingualFieldsFunctionalTest','class','modules/locale/locale.test','locale',0),('LocalePathFunctionalTest','class','modules/locale/locale.test','locale',0),('LocalePluralFormatTest','class','modules/locale/locale.test','locale',0),('LocaleTranslationFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleUILanguageNegotiationTest','class','modules/locale/locale.test','locale',0),('LocaleUninstallFrenchFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleUninstallFunctionalTest','class','modules/locale/locale.test','locale',0),('LocaleUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.locale.test','simpletest',0),('LocaleUrlRewritingTest','class','modules/locale/locale.test','locale',0),('LocaleUserCreationTest','class','modules/locale/locale.test','locale',0),('LocaleUserLanguageFunctionalTest','class','modules/locale/locale.test','locale',0),('LockFunctionalTest','class','modules/simpletest/tests/lock.test','simpletest',0),('MailSystemInterface','interface','includes/mail.inc','',0),('MailTestCase','class','modules/simpletest/tests/mail.test','simpletest',0),('MappedDiff','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('MemCacheClearCase','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemCacheGetMultipleUnitTest','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemcacheLockFunctionalTest','class','sites/all/modules/contrib/memcache/tests/memcache-lock.test','memcache',0),('MemCacheRealWorldCase','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemCacheSavingCase','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemcacheSessionTestCase','class','sites/all/modules/contrib/memcache/tests/memcache-session.test','memcache',0),('MemCacheStampedeProtection','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemCacheStatisticsTestCase','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemcacheTestCase','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MemoryQueue','class','modules/system/system.queue.inc','system',0),('MenuBreadcrumbTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuLinksUnitTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuNodeTestCase','class','modules/menu/menu.test','menu',0),('MenuRebuildTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuRouterTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuTestCase','class','modules/menu/menu.test','menu',0),('MenuTrailTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuTreeDataTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuTreeOutputTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MenuUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.menu.test','simpletest',0),('MenuWebTestCase','class','modules/simpletest/tests/menu.test','simpletest',0),('MergeQuery','class','includes/database/query.inc','',0),('MigrateLinkFieldHandler','class','sites/all/modules/contrib/link/link.migrate.inc','link',0),('MockMemCacheDrupal','class','sites/all/modules/contrib/memcache/tests/memcache.test','memcache',0),('MockTestConnection','class','modules/simpletest/tests/filetransfer.test','simpletest',0),('ModuleDependencyTestCase','class','modules/system/system.test','system',0),('ModuleImplementsAlterTestCase','class','modules/simpletest/tests/module.test','simpletest',0),('ModuleInstallTestCase','class','modules/simpletest/tests/module.test','simpletest',0),('ModuleRequiredTestCase','class','modules/system/system.test','system',0),('ModuleTestCase','class','modules/system/system.test','system',0),('ModuleUninstallTestCase','class','modules/simpletest/tests/module.test','simpletest',0),('ModuleUnitTest','class','modules/simpletest/tests/module.test','simpletest',0),('ModuleUpdater','class','modules/system/system.updater.inc','system',0),('ModuleVersionTestCase','class','modules/system/system.test','system',0),('MultiStepNodeFormBasicOptionsTest','class','modules/node/node.test','node',0),('NewDefaultThemeBlocks','class','modules/block/block.test','block',-5),('NoAuthEndpointTestRunner','class','sites/all/modules/contrib/services/tests/functional/NoAuthEndpointTestRunner.test','services',0),('NodeAccessBaseTableTestCase','class','modules/node/node.test','node',0),('NodeAccessFieldTestCase','class','modules/node/node.test','node',0),('NodeAccessPagerTestCase','class','modules/node/node.test','node',0),('NodeAccessRebuildTestCase','class','modules/node/node.test','node',0),('NodeAccessRecordsTestCase','class','modules/node/node.test','node',0),('NodeAccessTestCase','class','modules/node/node.test','node',0),('NodeAdminTestCase','class','modules/node/node.test','node',0),('NodeBlockFunctionalTest','class','modules/node/node.test','node',0),('NodeBlockTestCase','class','modules/node/node.test','node',0),('NodeBodyUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.node.test','simpletest',0),('NodeBuildContent','class','modules/node/node.test','node',0),('NodeController','class','modules/node/node.module','node',0),('NodeCreationTestCase','class','modules/node/node.test','node',0),('NodeEntityFieldQueryAlter','class','modules/node/node.test','node',0),('NodeEntityViewModeAlterTest','class','modules/node/node.test','node',0),('NodeFeedTestCase','class','modules/node/node.test','node',0),('NodeLoadHooksTestCase','class','modules/node/node.test','node',0),('NodeLoadMultipleTestCase','class','modules/node/node.test','node',0),('NodePageCacheTest','class','modules/node/node.test','node',0),('NodePostSettingsTestCase','class','modules/node/node.test','node',0),('NodeQueryAlter','class','modules/node/node.test','node',0),('NodequeueAdministerTestCase','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueApacheSolrUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueAPIAccessUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueAPICRUDUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueAPIMiscUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueAPINodeUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueAPISubqueueUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueExternalFetchingUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueHooksUnitTest','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueManipulateAllTestCase','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueManipulateTestCase','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodequeueWebTestCase','class','sites/all/modules/contrib/nodequeue/tests/nodequeue.test','nodequeue',0),('NodeReferenceFormTest','class','sites/all/modules/contrib/references/node_reference/node_reference.test','node_reference',0),('NodeRevisionPermissionsTestCase','class','modules/node/node.test','node',0),('NodeRevisionsTestCase','class','modules/node/node.test','node',0),('NodeRSSContentTestCase','class','modules/node/node.test','node',0),('NodeSaveTestCase','class','modules/node/node.test','node',0),('NodeTitleTestCase','class','modules/node/node.test','node',0),('NodeTitleXSSTestCase','class','modules/node/node.test','node',0),('NodeTokenReplaceTestCase','class','modules/node/node.test','node',0),('NodeTypePersistenceTestCase','class','modules/node/node.test','node',0),('NodeTypeTestCase','class','modules/node/node.test','node',0),('NodeWebTestCase','class','modules/node/node.test','node',0),('node_reference_box','class','sites/all/modules/contrib/node_reference_box/plugins/node_reference_box.inc','node_reference_box',0),('NoFieldsException','class','includes/database/database.inc','',0),('NoHelpTestCase','class','modules/help/help.test','help',0),('NonDefaultBlockAdmin','class','modules/block/block.test','block',-5),('NumberFieldTestCase','class','modules/field/modules/number/number.test','number',0),('OpenIDFunctionalTestCase','class','modules/openid/openid.test','openid',0),('OpenIDInvalidIdentifierTransitionTestCase','class','modules/openid/openid.test','openid',0),('OpenIDRegistrationTestCase','class','modules/openid/openid.test','openid',0),('OpenIDTestCase','class','modules/openid/openid.test','openid',0),('OpenIDWebTestCase','class','modules/openid/openid.test','openid',0),('OptionsSelectDynamicValuesTestCase','class','modules/field/modules/options/options.test','options',0),('OptionsWidgetsTestCase','class','modules/field/modules/options/options.test','options',0),('OverrideNodeOptionsTestCase','class','sites/all/modules/contrib/override_node_options/override_node_options.test','override_node_options',0),('PageEditTestCase','class','modules/node/node.test','node',0),('PageNotFoundTestCase','class','modules/system/system.test','system',0),('PagePreviewTestCase','class','modules/node/node.test','node',0),('PagerDefault','class','includes/pager.inc','',0),('PagerFunctionalWebTestCase','class','modules/simpletest/tests/pager.test','simpletest',0),('PageTitleFiltering','class','modules/system/system.test','system',0),('PageViewTestCase','class','modules/node/node.test','node',0),('ParseInfoFilesTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('PasswordHashingTest','class','modules/simpletest/tests/password.test','simpletest',0),('PasswordPolicyExpirationTestCase','class','sites/all/modules/contrib/password_policy/tests/password_policy_expiration.test','password_policy',0),('PasswordPolicyForcePasswordChangeTestCase','class','sites/all/modules/contrib/password_policy/tests/password_policy.test','password_policy',0),('PasswordPolicyPasswordTabTestCase','class','sites/all/modules/contrib/password_policy/contrib/password_tab/password_policy_password_tab.test','password_policy_password_tab',0),('PasswordPolicyTestCase','class','sites/all/modules/contrib/password_policy/tests/password_policy.test','password_policy',0),('PathautoBulkUpdateTestCase','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoFunctionalTestCase','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoFunctionalTestHelper','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoLocaleTestCase','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoMigrationHandler','class','sites/all/modules/contrib/pathauto/pathauto.migrate.inc','pathauto',1),('PathautoPersistTestCase','class','sites/all/modules/contrib/pathauto_persist/pathauto_persist.test','pathauto_persist',0),('PathautoTestHelper','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoTokenTestCase','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathautoUnitTestCase','class','sites/all/modules/contrib/pathauto/pathauto.test','pathauto',1),('PathLanguageTestCase','class','modules/path/path.test','path',0),('PathLanguageUITestCase','class','modules/path/path.test','path',0),('PathLookupTest','class','modules/simpletest/tests/path.test','simpletest',0),('PathMonolingualTestCase','class','modules/path/path.test','path',0),('PathSaveTest','class','modules/simpletest/tests/path.test','simpletest',0),('PathTaxonomyTermTestCase','class','modules/path/path.test','path',0),('PathTestCase','class','modules/path/path.test','path',0),('PHPAccessTestCase','class','modules/php/php.test','php',0),('PHPFilterTestCase','class','modules/php/php.test','php',0),('PHPTestCase','class','modules/php/php.test','php',0),('PollBlockTestCase','class','modules/poll/poll.test','poll',0),('PollCreateTestCase','class','modules/poll/poll.test','poll',0),('PollDeleteChoiceTestCase','class','modules/poll/poll.test','poll',0),('PollExpirationTestCase','class','modules/poll/poll.test','poll',0),('PollJSAddChoice','class','modules/poll/poll.test','poll',0),('PollTestCase','class','modules/poll/poll.test','poll',0),('PollTokenReplaceTestCase','class','modules/poll/poll.test','poll',0),('PollTranslateTestCase','class','modules/poll/poll.test','poll',0),('PollUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.node.test','simpletest',0),('PollVoteCheckHostname','class','modules/poll/poll.test','poll',0),('PollVoteTestCase','class','modules/poll/poll.test','poll',0),('ProfileBlockTestCase','class','modules/profile/profile.test','profile',0),('ProfileCrudTestCase','class','modules/profile/profile.test','profile',0),('ProfileTestAutocomplete','class','modules/profile/profile.test','profile',0),('ProfileTestBrowsing','class','modules/profile/profile.test','profile',0),('ProfileTestCase','class','modules/profile/profile.test','profile',0),('ProfileTestDate','class','modules/profile/profile.test','profile',0),('ProfileTestFields','class','modules/profile/profile.test','profile',0),('ProfileTestSelect','class','modules/profile/profile.test','profile',0),('ProfileTestWeights','class','modules/profile/profile.test','profile',0),('Query','class','includes/database/query.inc','',0),('QueryAlterableInterface','interface','includes/database/query.inc','',0),('QueryConditionInterface','interface','includes/database/query.inc','',0),('QueryExtendableInterface','interface','includes/database/select.inc','',0),('QueryPlaceholderInterface','interface','includes/database/query.inc','',0),('QueueTestCase','class','modules/system/system.test','system',0),('RdfCommentAttributesTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfCrudTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfGetRdfNamespacesTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfMappingDefinitionTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfMappingHookTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfRdfaMarkupTestCase','class','modules/rdf/rdf.test','rdf',0),('RdfTrackerAttributesTestCase','class','modules/rdf/rdf.test','rdf',0),('references_handler_argument','class','sites/all/modules/contrib/references/views/references_handler_argument.inc','references',0),('references_handler_relationship','class','sites/all/modules/contrib/references/views/references_handler_relationship.inc','references',0),('references_plugin_display','class','sites/all/modules/contrib/references/views/references_plugin_display.inc','references',0),('references_plugin_row_fields','class','sites/all/modules/contrib/references/views/references_plugin_row_fields.inc','references',0),('references_plugin_style','class','sites/all/modules/contrib/references/views/references_plugin_style.inc','references',0),('RegistryParseFilesTestCase','class','modules/simpletest/tests/registry.test','simpletest',0),('RegistryParseFileTestCase','class','modules/simpletest/tests/registry.test','simpletest',0),('RemoteFileDirectoryTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileSaveUploadTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileScanDirectoryTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileUnmanagedCopyTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileUnmanagedDeleteRecursiveTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileUnmanagedDeleteTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileUnmanagedMoveTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoteFileUnmanagedSaveDataTest','class','modules/simpletest/tests/file.test','simpletest',0),('RemoveFeedItemTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('RemoveFeedTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('RenderElementTypesTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('RetrieveFileTestCase','class','modules/system/system.test','system',0),('SchemaCache','class','includes/bootstrap.inc','',0),('SchemaTestCase','class','modules/simpletest/tests/schema.test','simpletest',0),('SearchAdvancedSearchForm','class','modules/search/search.test','search',0),('SearchBlockTestCase','class','modules/search/search.test','search',0),('SearchCommentCountToggleTestCase','class','modules/search/search.test','search',0),('SearchCommentTestCase','class','modules/search/search.test','search',0),('SearchConfigSettingsForm','class','modules/search/search.test','search',0),('SearchEmbedForm','class','modules/search/search.test','search',0),('SearchExactTestCase','class','modules/search/search.test','search',0),('SearchExcerptTestCase','class','modules/search/search.test','search',0),('SearchExpressionInsertExtractTestCase','class','modules/search/search.test','search',0),('SearchKeywordsConditions','class','modules/search/search.test','search',0),('SearchLanguageTestCase','class','modules/search/search.test','search',0),('SearchMatchTestCase','class','modules/search/search.test','search',0),('SearchNodeAccessTest','class','modules/search/search.test','search',0),('SearchNodeTagTest','class','modules/search/search.test','search',0),('SearchNumberMatchingTestCase','class','modules/search/search.test','search',0),('SearchNumbersTestCase','class','modules/search/search.test','search',0),('SearchPageOverride','class','modules/search/search.test','search',0),('SearchPageText','class','modules/search/search.test','search',0),('SearchQuery','class','modules/search/search.extender.inc','search',0),('SearchRankingTestCase','class','modules/search/search.test','search',0),('SearchSetLocaleTest','class','modules/search/search.test','search',0),('SearchSimplifyTestCase','class','modules/search/search.test','search',0),('SearchTokenizerTestCase','class','modules/search/search.test','search',0),('SecKitTestCase','class','sites/all/modules/contrib/seckit/seckit.test','seckit',0),('SelectQuery','class','includes/database/select.inc','',0),('SelectQueryExtender','class','includes/database/select.inc','',0),('SelectQueryInterface','interface','includes/database/select.inc','',0),('SelectQuery_pgsql','class','includes/database/pgsql/select.inc','',0),('SelectQuery_sqlite','class','includes/database/sqlite/select.inc','',0),('ServicesAliasTests','class','sites/all/modules/contrib/services/tests/functional/ServicesAliasTests.test','services',0),('ServicesArgumentsTestCase','class','sites/all/modules/contrib/services/tests/functional/ServicesArgumentsTests.test','services',0),('ServicesEndpointTests','class','sites/all/modules/contrib/services/tests/functional/ServicesEndpointTests.test','services',0),('ServicesParserTests','class','sites/all/modules/contrib/services/tests/functional/ServicesParserTests.test','services',0),('ServicesResourceCommentTests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceCommentTests.test','services',0),('ServicesResourceDisabledTest','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceDisabledTests.test','services',0),('ServicesResourceFileTests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceFileTests.test','services',0),('ServicesResourceNodeTaxonomytests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceNodeTests.test','services',0),('ServicesResourceNodetests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceNodeTests.test','services',0),('ServicesResourceSystemTests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceSystemTests.test','services',0),('ServicesResourceTaxonomyTests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceTaxonomyTests.test','services',0),('ServicesResourceUsertests','class','sites/all/modules/contrib/services/tests/functional/ServicesResourceUserTests.test','services',0),('ServicesRESTServerTests','class','sites/all/modules/contrib/services/servers/rest_server/tests/ServicesRESTServerTests.test','rest_server',0),('ServicesSecurityTests','class','sites/all/modules/contrib/services/tests/functional/ServicesSecurityTests.test','services',0),('ServicesSpycLibraryTests','class','sites/all/modules/contrib/services/tests/unit/ServicesSpycLibraryTests.test','services',0),('ServicesUITest','class','sites/all/modules/contrib/services/tests/ui/ServicesUITests.test','services',0),('ServicesVersionTests','class','sites/all/modules/contrib/services/tests/functional/ServicesVersionTests.test','services',0),('ServicesWebTestCase','class','sites/all/modules/contrib/services/tests/services.test','services',0),('ServicesXMLRPCTestCase','class','sites/all/modules/contrib/services/tests/functional/ServicesXMLRPCTests.test','services',0),('SessionHttpsTestCase','class','modules/simpletest/tests/session.test','simpletest',0),('SessionTestCase','class','modules/simpletest/tests/session.test','simpletest',0),('ShortcutLinksTestCase','class','modules/shortcut/shortcut.test','shortcut',0),('ShortcutSetsTestCase','class','modules/shortcut/shortcut.test','shortcut',0),('ShortcutTestCase','class','modules/shortcut/shortcut.test','shortcut',0),('ShutdownFunctionsTest','class','modules/system/system.test','system',0),('SimpleTestBrokenSetUp','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestBrowserTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestDiscoveryTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestFolderTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestFunctionalTest','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestInstallationProfileModuleTestsTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestMailCaptureTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestMissingDependentModuleUnitTest','class','modules/simpletest/simpletest.test','simpletest',0),('SimpleTestOtherInstallationProfileModuleTestsTestCase','class','modules/simpletest/simpletest.test','simpletest',0),('SiteMaintenanceTestCase','class','modules/system/system.test','system',0),('SkipDotsRecursiveDirectoryIterator','class','includes/filetransfer/filetransfer.inc','',0),('SmtpUnitTest','class','sites/all/modules/contrib/smtp/tests/smtp.unit.test','smtp',0),('spaces_controller_boxes','class','sites/all/modules/contrib/boxes/plugins/spaces_controller_boxes.inc','boxes',0),('StatisticsAdminTestCase','class','modules/statistics/statistics.test','statistics',0),('StatisticsBlockVisitorsTestCase','class','modules/statistics/statistics.test','statistics',0),('StatisticsLoggingTestCase','class','modules/statistics/statistics.test','statistics',0),('StatisticsReportsTestCase','class','modules/statistics/statistics.test','statistics',0),('StatisticsTestCase','class','modules/statistics/statistics.test','statistics',0),('StatisticsTokenReplaceTestCase','class','modules/statistics/statistics.test','statistics',0),('StreamWrapperInterface','interface','includes/stream_wrappers.inc','',0),('StreamWrapperTest','class','modules/simpletest/tests/file.test','simpletest',0),('stylizer_ui','class','sites/all/modules/contrib/ctools/stylizer/plugins/export_ui/stylizer_ui.class.php','stylizer',0),('SummaryLengthTestCase','class','modules/node/node.test','node',0),('SyslogTestCase','class','modules/syslog/syslog.test','syslog',0),('SystemAdminTestCase','class','modules/system/system.test','system',0),('SystemAuthorizeCase','class','modules/system/system.test','system',0),('SystemBlockTestCase','class','modules/system/system.test','system',0),('SystemIndexPhpTest','class','modules/system/system.test','system',0),('SystemInfoAlterTestCase','class','modules/system/system.test','system',0),('SystemMainContentFallback','class','modules/system/system.test','system',0),('SystemQueue','class','modules/system/system.queue.inc','system',0),('SystemThemeFunctionalTest','class','modules/system/system.test','system',0),('SystemValidTokenTest','class','modules/system/system.test','system',0),('TableSort','class','includes/tablesort.inc','',0),('TableSortTest','class','modules/simpletest/tests/tablesort.test','simpletest',0),('TaxonomyEFQTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyHooksTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyLegacyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyLoadMultipleTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyRSSTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTermController','class','modules/taxonomy/taxonomy.module','taxonomy',0),('TaxonomyTermFieldMultipleVocabularyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTermFieldTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTermFunctionTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTermIndexTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTermTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyThemeTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyTokenReplaceTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyVocabularyController','class','modules/taxonomy/taxonomy.module','taxonomy',0),('TaxonomyVocabularyFunctionalTest','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyVocabularyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TaxonomyWebTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0),('TestFileTransfer','class','modules/simpletest/tests/filetransfer.test','simpletest',0),('TestingMailSystem','class','modules/system/system.mail.inc','system',0),('TextFieldTestCase','class','modules/field/modules/text/text.test','text',0),('TextSummaryTestCase','class','modules/field/modules/text/text.test','text',0),('TextTranslationTestCase','class','modules/field/modules/text/text.test','text',0),('ThemeDebugMarkupTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeFastTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeHookInitTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeItemListUnitTest','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeLinksTest','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeRegistry','class','includes/theme.inc','',0),('ThemeRegistryTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeTableTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeTestCase','class','modules/simpletest/tests/theme.test','simpletest',0),('ThemeUpdater','class','modules/system/system.updater.inc','system',0),('TokenArrayTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenBlockTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenCommentTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenCurrentPageTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenDateTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenEntityTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenFileTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenMenuTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenNodeTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenProfileTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenRandomTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenReplaceTestCase','class','modules/system/system.test','system',0),('TokenScanTest','class','modules/system/system.test','system',0),('TokenTaxonomyTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenTestHelper','class','sites/all/modules/contrib/token/token.test','token',0),('TokenUnitTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenURLTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TokenUserTestCase','class','sites/all/modules/contrib/token/token.test','token',0),('TrackerTest','class','modules/tracker/tracker.test','tracker',0),('TranslatableUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.translatable.test','simpletest',0),('TranslationTestCase','class','modules/translation/translation.test','translation',0),('TriggerActionTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerContentTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerCronTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerOrphanedActionsTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerOtherTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerUnassignTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerUpdatePathTestCase','class','modules/simpletest/tests/upgrade/update.trigger.test','simpletest',0),('TriggerUserActionTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerUserTokenTestCase','class','modules/trigger/trigger.test','trigger',0),('TriggerWebTestCase','class','modules/trigger/trigger.test','trigger',0),('TruncateQuery','class','includes/database/query.inc','',0),('TruncateQuery_mysql','class','includes/database/mysql/query.inc','',0),('TruncateQuery_sqlite','class','includes/database/sqlite/query.inc','',0),('UnicodeUnitTest','class','modules/simpletest/tests/unicode.test','simpletest',0),('UpdateCoreTestCase','class','modules/update/update.test','update',0),('UpdateCoreUnitTestCase','class','modules/update/update.test','update',0),('UpdateDependencyHookInvocationTestCase','class','modules/simpletest/tests/update.test','simpletest',0),('UpdateDependencyMissingTestCase','class','modules/simpletest/tests/update.test','simpletest',0),('UpdateDependencyOrderingTestCase','class','modules/simpletest/tests/update.test','simpletest',0),('UpdateFeedItemTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('UpdateFeedTestCase','class','modules/aggregator/aggregator.test','aggregator',0),('UpdatePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('UpdateQuery','class','includes/database/query.inc','',0),('UpdateQuery_pgsql','class','includes/database/pgsql/query.inc','',0),('UpdateQuery_sqlite','class','includes/database/sqlite/query.inc','',0),('Updater','class','includes/updater.inc','',0),('UpdaterException','class','includes/updater.inc','',0),('UpdaterFileTransferException','class','includes/updater.inc','',0),('UpdateScriptFunctionalTest','class','modules/system/system.test','system',0),('UpdateTestContribCase','class','modules/update/update.test','update',0),('UpdateTestHelper','class','modules/update/update.test','update',0),('UpdateTestUploadCase','class','modules/update/update.test','update',0),('UpgradePathTaxonomyTestCase','class','modules/simpletest/tests/upgrade/upgrade.taxonomy.test','simpletest',0),('UpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.test','simpletest',0),('UpgradePathTriggerTestCase','class','modules/simpletest/tests/upgrade/upgrade.trigger.test','simpletest',0),('UploadUpgradePathTestCase','class','modules/simpletest/tests/upgrade/upgrade.upload.test','simpletest',0),('UrlAlterFunctionalTest','class','modules/simpletest/tests/path.test','simpletest',0),('UrlIsExternalUnitTest','class','modules/simpletest/tests/common.test','simpletest',0),('UserAccountLinksUnitTests','class','modules/user/user.test','user',0),('UserAdminTestCase','class','modules/user/user.test','user',0),('UserAuthmapAssignmentTestCase','class','modules/user/user.test','user',0),('UserAutocompleteTestCase','class','modules/user/user.test','user',0),('UserBlocksUnitTests','class','modules/user/user.test','user',0),('UserCancelTestCase','class','modules/user/user.test','user',0),('UserController','class','modules/user/user.module','user',0),('UserCreateTestCase','class','modules/user/user.test','user',0),('UserEditedOwnAccountTestCase','class','modules/user/user.test','user',0),('UserEditTestCase','class','modules/user/user.test','user',0),('UserLoginTestCase','class','modules/user/user.test','user',0),('UserPasswordResetTestCase','class','modules/user/user.test','user',0),('UserPermissionsTestCase','class','modules/user/user.test','user',0),('UserPictureTestCase','class','modules/user/user.test','user',0),('UserRegistrationTestCase','class','modules/user/user.test','user',0),('UserRoleAdminTestCase','class','modules/user/user.test','user',0),('UserRolesAssignmentTestCase','class','modules/user/user.test','user',0),('UserSaveTestCase','class','modules/user/user.test','user',0),('UserSignatureTestCase','class','modules/user/user.test','user',0),('UserTimeZoneFunctionalTest','class','modules/user/user.test','user',0),('UserTokenReplaceTestCase','class','modules/user/user.test','user',0),('UserUpdatePathTestCase','class','modules/simpletest/tests/upgrade/update.user.test','simpletest',0),('UserUpgradePathDuplicatedPermissionTestCase','class','modules/simpletest/tests/upgrade/upgrade.user.test','simpletest',0),('UserUpgradePathNoPasswordTokenTestCase','class','modules/simpletest/tests/upgrade/upgrade.user.test','simpletest',0),('UserUpgradePathPasswordTokenTestCase','class','modules/simpletest/tests/upgrade/upgrade.user.test','simpletest',0),('UserUserSearchTestCase','class','modules/user/user.test','user',0),('UserValidateCurrentPassCustomForm','class','modules/user/user.test','user',0),('UserValidationTestCase','class','modules/user/user.test','user',0),('ValidUrlTestCase','class','modules/simpletest/tests/common.test','simpletest',0),('view','class','sites/all/modules/contrib/views/includes/view.inc','views',10),('ViewsAccessTest','class','sites/all/modules/contrib/views/tests/views_access.test','views',0),('ViewsAnalyzeTest','class','sites/all/modules/contrib/views/tests/views_analyze.test','views',0),('ViewsArgumentDefaultTest','class','sites/all/modules/contrib/views/tests/views_argument_default.test','views',0),('ViewsArgumentValidatorTest','class','sites/all/modules/contrib/views/tests/views_argument_validator.test','views',0),('ViewsBasicTest','class','sites/all/modules/contrib/views/tests/views_basic.test','views',0),('ViewsCacheTest','class','sites/all/modules/contrib/views/tests/views_cache.test','views',10),('ViewsExposedFormTest','class','sites/all/modules/contrib/views/tests/views_exposed_form.test','views',0),('viewsFieldApiDataTest','class','sites/all/modules/contrib/views/tests/field/views_fieldapi.test','views',0),('ViewsFieldApiTestHelper','class','sites/all/modules/contrib/views/tests/field/views_fieldapi.test','views',0),('ViewsGlossaryTestCase','class','sites/all/modules/contrib/views/tests/views_glossary.test','views',0),('ViewsHandlerAreaTextTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_area_text.test','views',0),('viewsHandlerArgumentCommentUserUidTest','class','sites/all/modules/contrib/views/tests/comment/views_handler_argument_comment_user_uid.test','views',0),('ViewsHandlerArgumentNullTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_argument_null.test','views',0),('ViewsHandlerArgumentStringTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_argument_string.test','views',0),('ViewsHandlerFieldBooleanTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_boolean.test','views',0),('ViewsHandlerFieldCustomTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_custom.test','views',0),('ViewsHandlerFieldDateTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_date.test','views',10),('viewsHandlerFieldFieldTest','class','sites/all/modules/contrib/views/tests/field/views_fieldapi.test','views',0),('ViewsHandlerFieldMath','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_math.test','views',0),('ViewsHandlerFieldTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field.test','views',0),('ViewsHandlerFieldUrlTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_url.test','views',0),('viewsHandlerFieldUserNameTest','class','sites/all/modules/contrib/views/tests/user/views_handler_field_user_name.test','views',0),('ViewsHandlerFileExtensionTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_extension.test','views',10),('ViewsHandlerFilterCombineTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_combine.test','views',0),('viewsHandlerFilterCommentUserUidTest','class','sites/all/modules/contrib/views/tests/comment/views_handler_filter_comment_user_uid.test','views',0),('ViewsHandlerFilterCounterTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_counter.test','views',0),('ViewsHandlerFilterDateTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_date.test','views',10),('ViewsHandlerFilterEqualityTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_equality.test','views',0),('ViewsHandlerFilterInOperator','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_in_operator.test','views',0),('ViewsHandlerFilterNumericTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_numeric.test','views',0),('ViewsHandlerFilterStringTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_filter_string.test','views',0),('ViewsHandlerRelationshipNodeTermDataTest','class','sites/all/modules/contrib/views/tests/taxonomy/views_handler_relationship_node_term_data.test','views',0),('ViewsHandlerSortDateTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_sort_date.test','views',0),('ViewsHandlerSortRandomTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_sort_random.test','views',0),('ViewsHandlerSortTest','class','sites/all/modules/contrib/views/tests/handlers/views_handler_sort.test','views',0),('ViewsHandlersTest','class','sites/all/modules/contrib/views/tests/views_handlers.test','views',0),('ViewsHandlerTest','class','sites/all/modules/contrib/views/tests/handlers/views_handlers.test','views',10),('ViewsHandlerTestFileSize','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_size.test','views',0),('ViewsHandlerTestXss','class','sites/all/modules/contrib/views/tests/handlers/views_handler_field_xss.test','views',0),('ViewsModuleTest','class','sites/all/modules/contrib/views/tests/views_module.test','views',10),('ViewsNodeRevisionRelationsTestCase','class','sites/all/modules/contrib/views/tests/node/views_node_revision_relations.test','views',0),('ViewsPagerTest','class','sites/all/modules/contrib/views/tests/views_pager.test','views',0),('ViewsPagerTestCase','class','sites/all/modules/contrib/date/tests/date_views_pager.test','date',0),('ViewsPluginDisplayTestCase','class','sites/all/modules/contrib/views/tests/plugins/views_plugin_display.test','views',0),('viewsPluginStyleJumpMenuTest','class','sites/all/modules/contrib/views/tests/styles/views_plugin_style_jump_menu.test','views',0),('ViewsPluginStyleMappingTest','class','sites/all/modules/contrib/views/tests/styles/views_plugin_style_mapping.test','views',0),('ViewsPluginStyleTestBase','class','sites/all/modules/contrib/views/tests/styles/views_plugin_style_base.test','views',0),('ViewsPluginStyleTestCase','class','sites/all/modules/contrib/views/tests/styles/views_plugin_style.test','views',10),('ViewsPluginStyleUnformattedTestCase','class','sites/all/modules/contrib/views/tests/styles/views_plugin_style_unformatted.test','views',0),('ViewsQueryGroupByTest','class','sites/all/modules/contrib/views/tests/views_groupby.test','views',10),('viewsSearchQuery','class','sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc','views',10),('ViewsSqlTest','class','sites/all/modules/contrib/views/tests/views_query.test','views',10),('ViewsTestCase','class','sites/all/modules/contrib/views/tests/views_query.test','views',10),('ViewsTranslatableTest','class','sites/all/modules/contrib/views/tests/views_translatable.test','views',0),('ViewsUiBaseViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php','views_ui',0),('ViewsUiFileManagedViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_file_managed_views_wizard.class.php','views_ui',0),('viewsUiGroupbyTestCase','class','sites/all/modules/contrib/views/tests/views_groupby.test','views',10),('ViewsUiNodeRevisionViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_revision_views_wizard.class.php','views_ui',0),('ViewsUiNodeViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_views_wizard.class.php','views_ui',0),('ViewsUiTaxonomyTermViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_taxonomy_term_views_wizard.class.php','views_ui',0),('ViewsUiUsersViewsWizard','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_users_views_wizard.class.php','views_ui',0),('ViewsUIWizardBasicTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardDefaultViewsTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardHelper','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardItemsPerPageTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardJumpMenuTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardMenuTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardOverrideDisplaysTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardSortingTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUIWizardTaggedWithTestCase','class','sites/all/modules/contrib/views/tests/views_ui.test','views',0),('ViewsUpgradeTestCase','class','sites/all/modules/contrib/views/tests/views_upgrade.test','views',0),('ViewsUserArgumentDefault','class','sites/all/modules/contrib/views/tests/user/views_user_argument_default.test','views',0),('ViewsUserArgumentValidate','class','sites/all/modules/contrib/views/tests/user/views_user_argument_validate.test','views',0),('ViewsUserTestCase','class','sites/all/modules/contrib/views/tests/user/views_user.test','views',0),('ViewsViewTest','class','sites/all/modules/contrib/views/tests/views_view.test','views',0),('ViewsWizardException','class','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php','views_ui',0),('ViewsWizardInterface','interface','sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php','views_ui',0),('views_db_object','class','sites/all/modules/contrib/views/includes/view.inc','views',10),('views_display','class','sites/all/modules/contrib/views/includes/view.inc','views',10),('views_handler','class','sites/all/modules/contrib/views/includes/handlers.inc','views',10),('views_handler_area','class','sites/all/modules/contrib/views/handlers/views_handler_area.inc','views',0),('views_handler_area_broken','class','sites/all/modules/contrib/views/handlers/views_handler_area.inc','views',0),('views_handler_area_messages','class','sites/all/modules/contrib/views/handlers/views_handler_area_messages.inc','views',10),('views_handler_area_result','class','sites/all/modules/contrib/views/handlers/views_handler_area_result.inc','views',0),('views_handler_area_text','class','sites/all/modules/contrib/views/handlers/views_handler_area_text.inc','views',0),('views_handler_area_text_custom','class','sites/all/modules/contrib/views/handlers/views_handler_area_text_custom.inc','views',0),('views_handler_area_view','class','sites/all/modules/contrib/views/handlers/views_handler_area_view.inc','views',10),('views_handler_argument','class','sites/all/modules/contrib/views/handlers/views_handler_argument.inc','views',10),('views_handler_argument_aggregator_category_cid','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc','views',0),('views_handler_argument_aggregator_fid','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_fid.inc','views',0),('views_handler_argument_aggregator_iid','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_iid.inc','views',0),('views_handler_argument_broken','class','sites/all/modules/contrib/views/handlers/views_handler_argument.inc','views',10),('views_handler_argument_comment_user_uid','class','sites/all/modules/contrib/views/modules/comment/views_handler_argument_comment_user_uid.inc','views',0),('views_handler_argument_date','class','sites/all/modules/contrib/views/handlers/views_handler_argument_date.inc','views',0),('views_handler_argument_field_list','class','sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list.inc','views',0),('views_handler_argument_field_list_string','class','sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list_string.inc','views',0),('views_handler_argument_file_fid','class','sites/all/modules/contrib/views/modules/system/views_handler_argument_file_fid.inc','views',0),('views_handler_argument_formula','class','sites/all/modules/contrib/views/handlers/views_handler_argument_formula.inc','views',0),('views_handler_argument_group_by_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_argument_group_by_numeric.inc','views',0),('views_handler_argument_locale_group','class','sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_group.inc','views',0),('views_handler_argument_locale_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_language.inc','views',0),('views_handler_argument_many_to_one','class','sites/all/modules/contrib/views/handlers/views_handler_argument_many_to_one.inc','views',0),('views_handler_argument_node_created_day','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_created_fulldate','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_created_month','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_created_week','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_created_year','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_created_year_month','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','views',0),('views_handler_argument_node_language','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_node_language.inc','views',0),('views_handler_argument_node_nid','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_node_nid.inc','views',0),('views_handler_argument_node_tnid','class','sites/all/modules/contrib/views/modules/translation/views_handler_argument_node_tnid.inc','views',0),('views_handler_argument_node_type','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_node_type.inc','views',0),('views_handler_argument_node_uid_revision','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_node_uid_revision.inc','views',0),('views_handler_argument_node_vid','class','sites/all/modules/contrib/views/modules/node/views_handler_argument_node_vid.inc','views',0),('views_handler_argument_null','class','sites/all/modules/contrib/views/handlers/views_handler_argument_null.inc','views',0),('views_handler_argument_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_argument_numeric.inc','views',0),('views_handler_argument_search','class','sites/all/modules/contrib/views/modules/search/views_handler_argument_search.inc','views',10),('views_handler_argument_string','class','sites/all/modules/contrib/views/handlers/views_handler_argument_string.inc','views',0),('views_handler_argument_taxonomy','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_taxonomy.inc','views',0),('views_handler_argument_term_node_tid','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid.inc','views',0),('views_handler_argument_term_node_tid_depth','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc','views',0),('views_handler_argument_term_node_tid_depth_join','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc','views',10),('views_handler_argument_term_node_tid_depth_modifier','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc','views',0),('views_handler_argument_tracker_comment_user_uid','class','sites/all/modules/contrib/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc','views',0),('views_handler_argument_users_roles_rid','class','sites/all/modules/contrib/views/modules/user/views_handler_argument_users_roles_rid.inc','views',0),('views_handler_argument_user_uid','class','sites/all/modules/contrib/views/modules/user/views_handler_argument_user_uid.inc','views',0),('views_handler_argument_vocabulary_machine_name','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc','views',0),('views_handler_argument_vocabulary_vid','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc','views',0),('views_handler_field','class','sites/all/modules/contrib/views/handlers/views_handler_field.inc','views',0),('views_handler_field_accesslog_path','class','sites/all/modules/contrib/views/modules/statistics/views_handler_field_accesslog_path.inc','views',0),('views_handler_field_aggregator_category','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_category.inc','views',0),('views_handler_field_aggregator_title_link','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_title_link.inc','views',0),('views_handler_field_aggregator_xss','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_xss.inc','views',0),('views_handler_field_boolean','class','sites/all/modules/contrib/views/handlers/views_handler_field_boolean.inc','views',0),('views_handler_field_broken','class','sites/all/modules/contrib/views/handlers/views_handler_field.inc','views',0),('views_handler_field_comment','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment.inc','views',0),('views_handler_field_comment_depth','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_depth.inc','views',0),('views_handler_field_comment_link','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link.inc','views',0),('views_handler_field_comment_link_approve','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_approve.inc','views',0),('views_handler_field_comment_link_delete','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_delete.inc','views',0),('views_handler_field_comment_link_edit','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_edit.inc','views',0),('views_handler_field_comment_link_reply','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_reply.inc','views',0),('views_handler_field_comment_node_link','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_node_link.inc','views',0),('views_handler_field_comment_username','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_username.inc','views',0),('views_handler_field_contact_link','class','sites/all/modules/contrib/views/modules/contact/views_handler_field_contact_link.inc','views',0),('views_handler_field_contextual_links','class','sites/all/modules/contrib/views/handlers/views_handler_field_contextual_links.inc','views',10),('views_handler_field_counter','class','sites/all/modules/contrib/views/handlers/views_handler_field_counter.inc','views',10),('views_handler_field_ctools_dropdown','class','sites/all/modules/contrib/views/handlers/views_handler_field_ctools_dropdown.inc','views',10),('views_handler_field_custom','class','sites/all/modules/contrib/views/handlers/views_handler_field_custom.inc','views',0),('views_handler_field_date','class','sites/all/modules/contrib/views/handlers/views_handler_field_date.inc','views',10),('views_handler_field_entity','class','sites/all/modules/contrib/views/handlers/views_handler_field_entity.inc','views',0),('views_handler_field_field','class','sites/all/modules/contrib/views/modules/field/views_handler_field_field.inc','views',10),('views_handler_field_file','class','sites/all/modules/contrib/views/modules/system/views_handler_field_file.inc','views',0),('views_handler_field_file_extension','class','sites/all/modules/contrib/views/modules/system/views_handler_field_file_extension.inc','views',10),('views_handler_field_file_filemime','class','sites/all/modules/contrib/views/modules/system/views_handler_field_file_filemime.inc','views',0),('views_handler_field_file_size','class','sites/all/modules/contrib/views/handlers/views_handler_field.inc','views',0),('views_handler_field_file_status','class','sites/all/modules/contrib/views/modules/system/views_handler_field_file_status.inc','views',0),('views_handler_field_file_uri','class','sites/all/modules/contrib/views/modules/system/views_handler_field_file_uri.inc','views',0),('views_handler_field_filter_format_name','class','sites/all/modules/contrib/views/modules/filter/views_handler_field_filter_format_name.inc','views',0),('views_handler_field_history_user_timestamp','class','sites/all/modules/contrib/views/modules/node/views_handler_field_history_user_timestamp.inc','views',0),('views_handler_field_last_comment_timestamp','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_last_comment_timestamp.inc','views',0),('views_handler_field_links','class','sites/all/modules/contrib/views/handlers/views_handler_field_links.inc','views',10),('views_handler_field_locale_group','class','sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_group.inc','views',0),('views_handler_field_locale_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_language.inc','views',0),('views_handler_field_locale_link_edit','class','sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_link_edit.inc','views',10),('views_handler_field_machine_name','class','sites/all/modules/contrib/views/handlers/views_handler_field_machine_name.inc','views',0),('views_handler_field_markup','class','sites/all/modules/contrib/views/handlers/views_handler_field_markup.inc','views',0),('views_handler_field_math','class','sites/all/modules/contrib/views/handlers/views_handler_field_math.inc','views',10),('views_handler_field_ncs_last_comment_name','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_comment_name.inc','views',0),('views_handler_field_ncs_last_updated','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_updated.inc','views',0),('views_handler_field_node','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node.inc','views',0),('views_handler_field_node_comment','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_node_comment.inc','views',0),('views_handler_field_node_counter_timestamp','class','sites/all/modules/contrib/views/modules/statistics/views_handler_field_node_counter_timestamp.inc','views',10),('views_handler_field_node_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_field_node_language.inc','views',0),('views_handler_field_node_link','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_link.inc','views',0),('views_handler_field_node_link_delete','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_delete.inc','views',0),('views_handler_field_node_link_edit','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_edit.inc','views',0),('views_handler_field_node_link_translate','class','sites/all/modules/contrib/views/modules/translation/views_handler_field_node_link_translate.inc','views',0),('views_handler_field_node_new_comments','class','sites/all/modules/contrib/views/modules/comment/views_handler_field_node_new_comments.inc','views',0),('views_handler_field_node_path','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_path.inc','views',0),('views_handler_field_node_revision','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision.inc','views',0),('views_handler_field_node_revision_link','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link.inc','views',0),('views_handler_field_node_revision_link_delete','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_delete.inc','views',0),('views_handler_field_node_revision_link_revert','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_revert.inc','views',0),('views_handler_field_node_translation_link','class','sites/all/modules/contrib/views/modules/translation/views_handler_field_node_translation_link.inc','views',0),('views_handler_field_node_type','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_type.inc','views',0),('views_handler_field_node_version_count','class','sites/all/modules/contrib/views/modules/node/views_handler_field_node_version_count.inc','views',10),('views_handler_field_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_field_numeric.inc','views',10),('views_handler_field_prerender_list','class','sites/all/modules/contrib/views/handlers/views_handler_field_prerender_list.inc','views',0),('views_handler_field_profile_date','class','sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_date.inc','views',10),('views_handler_field_profile_list','class','sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_list.inc','views',0),('views_handler_field_search_score','class','sites/all/modules/contrib/views/modules/search/views_handler_field_search_score.inc','views',0),('views_handler_field_serialized','class','sites/all/modules/contrib/views/handlers/views_handler_field_serialized.inc','views',0),('views_handler_field_statistics_numeric','class','sites/all/modules/contrib/views/modules/statistics/views_handler_field_statistics_numeric.inc','views',10),('views_handler_field_taxonomy','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_taxonomy.inc','views',0),('views_handler_field_term_link_edit','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_link_edit.inc','views',0),('views_handler_field_term_node_tid','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_node_tid.inc','views',0),('views_handler_field_time_interval','class','sites/all/modules/contrib/views/handlers/views_handler_field_time_interval.inc','views',0),('views_handler_field_url','class','sites/all/modules/contrib/views/handlers/views_handler_field_url.inc','views',0),('views_handler_field_user','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user.inc','views',0),('views_handler_field_user_language','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_language.inc','views',0),('views_handler_field_user_link','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_link.inc','views',0),('views_handler_field_user_link_cancel','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_cancel.inc','views',10),('views_handler_field_user_link_edit','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_edit.inc','views',0),('views_handler_field_user_mail','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_mail.inc','views',0),('views_handler_field_user_name','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_name.inc','views',0),('views_handler_field_user_permissions','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_permissions.inc','views',0),('views_handler_field_user_picture','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_picture.inc','views',0),('views_handler_field_user_roles','class','sites/all/modules/contrib/views/modules/user/views_handler_field_user_roles.inc','views',0),('views_handler_field_xss','class','sites/all/modules/contrib/views/handlers/views_handler_field.inc','views',0),('views_handler_filter','class','sites/all/modules/contrib/views/handlers/views_handler_filter.inc','views',10),('views_handler_filter_aggregator_category_cid','class','sites/all/modules/contrib/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc','views',0),('views_handler_filter_boolean_operator','class','sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator.inc','views',0),('views_handler_filter_boolean_operator_string','class','sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator_string.inc','views',10),('views_handler_filter_broken','class','sites/all/modules/contrib/views/handlers/views_handler_filter.inc','views',10),('views_handler_filter_combine','class','sites/all/modules/contrib/views/handlers/views_handler_filter_combine.inc','views',10),('views_handler_filter_comment_user_uid','class','sites/all/modules/contrib/views/modules/comment/views_handler_filter_comment_user_uid.inc','views',0),('views_handler_filter_date','class','sites/all/modules/contrib/views/handlers/views_handler_filter_date.inc','views',10),('views_handler_filter_entity_bundle','class','sites/all/modules/contrib/views/handlers/views_handler_filter_entity_bundle.inc','views',0),('views_handler_filter_equality','class','sites/all/modules/contrib/views/handlers/views_handler_filter_equality.inc','views',0),('views_handler_filter_fields_compare','class','sites/all/modules/contrib/views/handlers/views_handler_filter_fields_compare.inc','views',10),('views_handler_filter_field_list','class','sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list.inc','views',0),('views_handler_filter_field_list_boolean','class','sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list_boolean.inc','views',10),('views_handler_filter_file_status','class','sites/all/modules/contrib/views/modules/system/views_handler_filter_file_status.inc','views',0),('views_handler_filter_group_by_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_filter_group_by_numeric.inc','views',0),('views_handler_filter_history_user_timestamp','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_history_user_timestamp.inc','views',0),('views_handler_filter_in_operator','class','sites/all/modules/contrib/views/handlers/views_handler_filter_in_operator.inc','views',0),('views_handler_filter_locale_group','class','sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_group.inc','views',0),('views_handler_filter_locale_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_language.inc','views',0),('views_handler_filter_locale_version','class','sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_version.inc','views',0),('views_handler_filter_many_to_one','class','sites/all/modules/contrib/views/handlers/views_handler_filter_many_to_one.inc','views',0),('views_handler_filter_ncs_last_updated','class','sites/all/modules/contrib/views/modules/comment/views_handler_filter_ncs_last_updated.inc','views',0),('views_handler_filter_node_access','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_node_access.inc','views',0),('views_handler_filter_node_comment','class','sites/all/modules/contrib/views/modules/comment/views_handler_filter_node_comment.inc','views',0),('views_handler_filter_node_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_filter_node_language.inc','views',0),('views_handler_filter_node_status','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_node_status.inc','views',0),('views_handler_filter_node_tnid','class','sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid.inc','views',0),('views_handler_filter_node_tnid_child','class','sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid_child.inc','views',0),('views_handler_filter_node_type','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_node_type.inc','views',0),('views_handler_filter_node_uid_revision','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_node_uid_revision.inc','views',10),('views_handler_filter_node_version_count','class','sites/all/modules/contrib/views/modules/node/views_handler_filter_node_version_count.inc','views',10),('views_handler_filter_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_filter_numeric.inc','views',0),('views_handler_filter_profile_selection','class','sites/all/modules/contrib/views/modules/profile/views_handler_filter_profile_selection.inc','views',0),('views_handler_filter_search','class','sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc','views',10),('views_handler_filter_string','class','sites/all/modules/contrib/views/handlers/views_handler_filter_string.inc','views',0),('views_handler_filter_system_type','class','sites/all/modules/contrib/views/modules/system/views_handler_filter_system_type.inc','views',0),('views_handler_filter_term_node_tid','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid.inc','views',10),('views_handler_filter_term_node_tid_depth','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc','views',0),('views_handler_filter_term_node_tid_depth_join','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc','views',10),('views_handler_filter_tracker_boolean_operator','class','sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc','views',0),('views_handler_filter_tracker_comment_user_uid','class','sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc','views',0),('views_handler_filter_user_current','class','sites/all/modules/contrib/views/modules/user/views_handler_filter_user_current.inc','views',0),('views_handler_filter_user_name','class','sites/all/modules/contrib/views/modules/user/views_handler_filter_user_name.inc','views',0),('views_handler_filter_user_permissions','class','sites/all/modules/contrib/views/modules/user/views_handler_filter_user_permissions.inc','views',0),('views_handler_filter_user_roles','class','sites/all/modules/contrib/views/modules/user/views_handler_filter_user_roles.inc','views',0),('views_handler_filter_vocabulary_machine_name','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc','views',0),('views_handler_filter_vocabulary_vid','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc','views',0),('views_handler_relationship','class','sites/all/modules/contrib/views/handlers/views_handler_relationship.inc','views',0),('views_handler_relationship_broken','class','sites/all/modules/contrib/views/handlers/views_handler_relationship.inc','views',0),('views_handler_relationship_entity_reverse','class','sites/all/modules/contrib/views/modules/field/views_handler_relationship_entity_reverse.inc','views',0),('views_handler_relationship_groupwise_max','class','sites/all/modules/contrib/views/handlers/views_handler_relationship_groupwise_max.inc','views',0),('views_handler_relationship_node_term_data','class','sites/all/modules/contrib/views/modules/taxonomy/views_handler_relationship_node_term_data.inc','views',10),('views_handler_relationship_translation','class','sites/all/modules/contrib/views/modules/translation/views_handler_relationship_translation.inc','views',0),('views_handler_sort','class','sites/all/modules/contrib/views/handlers/views_handler_sort.inc','views',0),('views_handler_sort_broken','class','sites/all/modules/contrib/views/handlers/views_handler_sort.inc','views',0),('views_handler_sort_comment_thread','class','sites/all/modules/contrib/views/modules/comment/views_handler_sort_comment_thread.inc','views',0),('views_handler_sort_date','class','sites/all/modules/contrib/views/handlers/views_handler_sort_date.inc','views',0),('views_handler_sort_group_by_numeric','class','sites/all/modules/contrib/views/handlers/views_handler_sort_group_by_numeric.inc','views',0),('views_handler_sort_menu_hierarchy','class','sites/all/modules/contrib/views/handlers/views_handler_sort_menu_hierarchy.inc','views',0),('views_handler_sort_ncs_last_comment_name','class','sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc','views',0),('views_handler_sort_ncs_last_updated','class','sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_updated.inc','views',0),('views_handler_sort_node_language','class','sites/all/modules/contrib/views/modules/locale/views_handler_sort_node_language.inc','views',10),('views_handler_sort_node_version_count','class','sites/all/modules/contrib/views/modules/node/views_handler_sort_node_version_count.inc','views',10),('views_handler_sort_random','class','sites/all/modules/contrib/views/handlers/views_handler_sort_random.inc','views',0),('views_handler_sort_search_score','class','sites/all/modules/contrib/views/modules/search/views_handler_sort_search_score.inc','views',0),('views_join','class','sites/all/modules/contrib/views/includes/handlers.inc','views',10),('views_join_subquery','class','sites/all/modules/contrib/views/includes/handlers.inc','views',10),('views_many_to_one_helper','class','sites/all/modules/contrib/views/includes/handlers.inc','views',10),('views_object','class','sites/all/modules/contrib/views/includes/base.inc','views',10),('views_plugin','class','sites/all/modules/contrib/views/includes/plugins.inc','views',10),('views_plugin_access','class','sites/all/modules/contrib/views/plugins/views_plugin_access.inc','views',0),('views_plugin_access_none','class','sites/all/modules/contrib/views/plugins/views_plugin_access_none.inc','views',0),('views_plugin_access_perm','class','sites/all/modules/contrib/views/plugins/views_plugin_access_perm.inc','views',0),('views_plugin_access_role','class','sites/all/modules/contrib/views/plugins/views_plugin_access_role.inc','views',0),('views_plugin_argument_default','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_default.inc','views',0),('views_plugin_argument_default_book_root','class','sites/all/modules/contrib/views/modules/book/views_plugin_argument_default_book_root.inc','views',0),('views_plugin_argument_default_current_user','class','sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_current_user.inc','views',0),('views_plugin_argument_default_fixed','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_default_fixed.inc','views',0),('views_plugin_argument_default_node','class','sites/all/modules/contrib/views/modules/node/views_plugin_argument_default_node.inc','views',0),('views_plugin_argument_default_php','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_default_php.inc','views',0),('views_plugin_argument_default_raw','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_default_raw.inc','views',0),('views_plugin_argument_default_taxonomy_tid','class','sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc','views',0),('views_plugin_argument_default_user','class','sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_user.inc','views',0),('views_plugin_argument_validate','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_validate.inc','views',10),('views_plugin_argument_validate_node','class','sites/all/modules/contrib/views/modules/node/views_plugin_argument_validate_node.inc','views',0),('views_plugin_argument_validate_numeric','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_numeric.inc','views',0),('views_plugin_argument_validate_php','class','sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_php.inc','views',0),('views_plugin_argument_validate_taxonomy_term','class','sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc','views',0),('views_plugin_argument_validate_user','class','sites/all/modules/contrib/views/modules/user/views_plugin_argument_validate_user.inc','views',0),('views_plugin_cache','class','sites/all/modules/contrib/views/plugins/views_plugin_cache.inc','views',10),('views_plugin_cache_none','class','sites/all/modules/contrib/views/plugins/views_plugin_cache_none.inc','views',0),('views_plugin_cache_time','class','sites/all/modules/contrib/views/plugins/views_plugin_cache_time.inc','views',10),('views_plugin_display','class','sites/all/modules/contrib/views/plugins/views_plugin_display.inc','views',10),('views_plugin_display_attachment','class','sites/all/modules/contrib/views/plugins/views_plugin_display_attachment.inc','views',10),('views_plugin_display_block','class','sites/all/modules/contrib/views/plugins/views_plugin_display_block.inc','views',10),('views_plugin_display_default','class','sites/all/modules/contrib/views/plugins/views_plugin_display_default.inc','views',0),('views_plugin_display_embed','class','sites/all/modules/contrib/views/plugins/views_plugin_display_embed.inc','views',0),('views_plugin_display_extender','class','sites/all/modules/contrib/views/plugins/views_plugin_display_extender.inc','views',0),('views_plugin_display_feed','class','sites/all/modules/contrib/views/plugins/views_plugin_display_feed.inc','views',10),('views_plugin_display_page','class','sites/all/modules/contrib/views/plugins/views_plugin_display_page.inc','views',10),('views_plugin_exposed_form','class','sites/all/modules/contrib/views/plugins/views_plugin_exposed_form.inc','views',10),('views_plugin_exposed_form_basic','class','sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_basic.inc','views',0),('views_plugin_exposed_form_input_required','class','sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_input_required.inc','views',10),('views_plugin_localization','class','sites/all/modules/contrib/views/plugins/views_plugin_localization.inc','views',0),('views_plugin_localization_core','class','sites/all/modules/contrib/views/plugins/views_plugin_localization_core.inc','views',0),('views_plugin_localization_none','class','sites/all/modules/contrib/views/plugins/views_plugin_localization_none.inc','views',0),('views_plugin_localization_test','class','sites/all/modules/contrib/views/tests/views_plugin_localization_test.inc','views',0),('views_plugin_pager','class','sites/all/modules/contrib/views/plugins/views_plugin_pager.inc','views',10),('views_plugin_pager_full','class','sites/all/modules/contrib/views/plugins/views_plugin_pager_full.inc','views',10),('views_plugin_pager_mini','class','sites/all/modules/contrib/views/plugins/views_plugin_pager_mini.inc','views',10),('views_plugin_pager_none','class','sites/all/modules/contrib/views/plugins/views_plugin_pager_none.inc','views',0),('views_plugin_pager_some','class','sites/all/modules/contrib/views/plugins/views_plugin_pager_some.inc','views',0),('views_plugin_query','class','sites/all/modules/contrib/views/plugins/views_plugin_query.inc','views',0),('views_plugin_query_default','class','sites/all/modules/contrib/views/plugins/views_plugin_query_default.inc','views',10),('views_plugin_row','class','sites/all/modules/contrib/views/plugins/views_plugin_row.inc','views',0),('views_plugin_row_aggregator_rss','class','sites/all/modules/contrib/views/modules/aggregator/views_plugin_row_aggregator_rss.inc','views',0),('views_plugin_row_comment_rss','class','sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_rss.inc','views',10),('views_plugin_row_comment_view','class','sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_view.inc','views',0),('views_plugin_row_fields','class','sites/all/modules/contrib/views/plugins/views_plugin_row_fields.inc','views',0),('views_plugin_row_node_rss','class','sites/all/modules/contrib/views/modules/node/views_plugin_row_node_rss.inc','views',10),('views_plugin_row_node_view','class','sites/all/modules/contrib/views/modules/node/views_plugin_row_node_view.inc','views',0),('views_plugin_row_rss_fields','class','sites/all/modules/contrib/views/plugins/views_plugin_row_rss_fields.inc','views',0),('views_plugin_row_search_view','class','sites/all/modules/contrib/views/modules/search/views_plugin_row_search_view.inc','views',0),('views_plugin_row_user_view','class','sites/all/modules/contrib/views/modules/user/views_plugin_row_user_view.inc','views',0),('views_plugin_style','class','sites/all/modules/contrib/views/plugins/views_plugin_style.inc','views',10),('views_plugin_style_default','class','sites/all/modules/contrib/views/plugins/views_plugin_style_default.inc','views',0),('views_plugin_style_grid','class','sites/all/modules/contrib/views/plugins/views_plugin_style_grid.inc','views',0),('views_plugin_style_jump_menu','class','sites/all/modules/contrib/views/plugins/views_plugin_style_jump_menu.inc','views',10),('views_plugin_style_list','class','sites/all/modules/contrib/views/plugins/views_plugin_style_list.inc','views',0),('views_plugin_style_mapping','class','sites/all/modules/contrib/views/plugins/views_plugin_style_mapping.inc','views',0),('views_plugin_style_rss','class','sites/all/modules/contrib/views/plugins/views_plugin_style_rss.inc','views',10),('views_plugin_style_summary','class','sites/all/modules/contrib/views/plugins/views_plugin_style_summary.inc','views',0),('views_plugin_style_summary_jump_menu','class','sites/all/modules/contrib/views/plugins/views_plugin_style_summary_jump_menu.inc','views',0),('views_plugin_style_summary_unformatted','class','sites/all/modules/contrib/views/plugins/views_plugin_style_summary_unformatted.inc','views',0),('views_plugin_style_table','class','sites/all/modules/contrib/views/plugins/views_plugin_style_table.inc','views',0),('views_test_area_access','class','sites/all/modules/contrib/views/tests/test_handlers/views_test_area_access.inc','views',10),('views_test_plugin_access_test_dynamic','class','sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc','views',0),('views_test_plugin_access_test_static','class','sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_static.inc','views',0),('views_test_plugin_style_test_mapping','class','sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc','views',0),('views_ui','class','sites/all/modules/contrib/views/plugins/export_ui/views_ui.class.php','views_ui',0),('WebformComponentsTestCase','class','sites/all/modules/contrib/webform/tests/components.test','webform',0),('WebformConditionalsTestCase','class','sites/all/modules/contrib/webform/tests/conditionals.test','webform',0),('WebformGeneralTestCase','class','sites/all/modules/contrib/webform/tests/webform.test','webform',0),('WebformPermissionsTestCase','class','sites/all/modules/contrib/webform/tests/permissions.test','webform',0),('WebformSubmissionTestCase','class','sites/all/modules/contrib/webform/tests/submission.test','webform',0),('WebformTestCase','class','sites/all/modules/contrib/webform/tests/webform.test','webform',0),('WordLevelDiff','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('WorkbenchAccessBaseTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchAccessMenuTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchAccessRoleTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchAccessTaxonomyTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchAccessTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchAccessTokenTestCase','class','sites/all/modules/contrib/workbench_access/tests/workbench_access.test','workbench_access',0),('WorkbenchModerationDraftTabTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('WorkbenchModerationExternalNodeUpdateTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/external_node_update.test','workbench_moderation',5),('WorkbenchModerationFilesTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.files.test','workbench_moderation',0),('WorkbenchModerationMigrateDestinationHandler','class','sites/all/modules/contrib/workbench_moderation/workbench_moderation.migrate.inc','workbench_moderation',0),('WorkbenchModerationModerateTabTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('WorkbenchModerationPublishFromNodeFormTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('WorkbenchModerationTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('WorkbenchModerationUnpublishTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('WorkbenchRedirectAfterTitleChangeTestCase','class','sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','workbench_moderation',0),('workbench_access_handler_field_edit_node','class','sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_field_edit_node.inc','workbench_access',0),('workbench_access_handler_field_section','class','sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_field_section.inc','workbench_access',0),('workbench_access_handler_filter_access','class','sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_filter_access.inc','workbench_access',0),('workbench_access_handler_sort_section','class','sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_sort_section.inc','workbench_access',0),('workbench_moderation_handler_field_history_link','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_history_link.inc','workbench_moderation',0),('workbench_moderation_handler_field_links','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_links.inc','workbench_moderation',5),('workbench_moderation_handler_field_state','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_state.inc','workbench_moderation',0),('workbench_moderation_handler_filter_moderated_type','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_moderated_type.inc','workbench_moderation',0),('workbench_moderation_handler_filter_state','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_state.inc','workbench_moderation',0),('workbench_moderation_handler_filter_user_can_moderate','class','sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_user_can_moderate.inc','workbench_moderation',0),('WysiwygProfileController','class','sites/all/modules/contrib/wysiwyg/wysiwyg.module','wysiwyg',0),('XMLRPCBasicTestCase','class','modules/simpletest/tests/xmlrpc.test','simpletest',0),('XMLRPCMessagesTestCase','class','modules/simpletest/tests/xmlrpc.test','simpletest',0),('XMLRPCValidator1IncTestCase','class','modules/simpletest/tests/xmlrpc.test','simpletest',0),('_DiffEngine','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_DiffOp','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_DiffOp_Add','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_DiffOp_Change','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_DiffOp_Copy','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_DiffOp_Delete','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0),('_HWLDF_WordAccumulator','class','sites/all/modules/contrib/diff/DiffEngine.php','diff',0);
/*!40000 ALTER TABLE `registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registry_file`
--

DROP TABLE IF EXISTS `registry_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_file`
--

LOCK TABLES `registry_file` WRITE;
/*!40000 ALTER TABLE `registry_file` DISABLE KEYS */;
INSERT INTO `registry_file` VALUES ('includes/actions.inc','f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759'),('includes/ajax.inc','a22c8f7345c1f714ea40bbaa1385fa0e3763b389c82656cf6ff3e4d051532ee4'),('includes/archiver.inc','bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9'),('includes/authorize.inc','6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13'),('includes/batch.inc','1fe00f9a25481cd43e19fbd6bd37b7ff9dca79f8405ec3e55ffb011be12ec2c3'),('includes/batch.queue.inc','554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f'),('includes/bootstrap.inc','548711fd5157503b4eec07af40c36989008ade3aa2294b6978b2b86cfeea8d56'),('includes/cache-install.inc','e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e'),('includes/cache.inc','ee0bf13c7e067695dffcb9ade3b79fea82a3a8db9e9a422ebfcc91c383aa4b4c'),('includes/common.inc','702abbaa542957e33410454e60c082ddc331776da34c53f87101de7eba8c14a6'),('includes/database/database.inc','27f874fb21e1a85c86e0317669e2e26c1c6611a5e913c5bbce4c7aa62734edfe'),('includes/database/log.inc','9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1'),('includes/database/mysql/database.inc','b92eedf14735579e11a9d14810650d95b6eb1809c4b6648f47d36dd7f957ac75'),('includes/database/mysql/install.inc','6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0'),('includes/database/mysql/query.inc','0212a871646c223bf77aa26b945c77a8974855373967b5fb9fdc09f8a1de88a6'),('includes/database/mysql/schema.inc','6f43ac87508f868fe38ee09994fc18d69915bada0237f8ac3b717cafe8f22c6b'),('includes/database/pgsql/database.inc','d737f95947d78eb801e8ec8ca8b01e72d2e305924efce8abca0a98c1b5264cff'),('includes/database/pgsql/install.inc','585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5'),('includes/database/pgsql/query.inc','0df57377686c921e722a10b49d5e433b131176c8059a4ace4680964206fc14b4'),('includes/database/pgsql/schema.inc','1588daadfa53506aa1f5d94572162a45a46dc3ceabdd0e2f224532ded6508403'),('includes/database/pgsql/select.inc','fd4bba7887c1dc6abc8f080fc3a76c01d92ea085434e355dc1ecb50d8743c22d'),('includes/database/prefetch.inc','b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb'),('includes/database/query.inc','4016a397f10f071cac338fd0a9b004296106e42ab2b9db8c7ff0db341658e88f'),('includes/database/schema.inc','9fecfd13fc1d4056a62d385840dccd052ea0e184dc47101f4bd8f57f10b68174'),('includes/database/select.inc','5e9cdc383564ba86cb9dcad0046990ce15415a3000e4f617d6e0f30a205b852c'),('includes/database/sqlite/database.inc','4281c6e80932560ecbeb07d1757efd133e8699a6fccf58c27a55df0f71794622'),('includes/database/sqlite/install.inc','6620f354aa175a116ba3a0562c980d86cc3b8b481042fc3cc5ed6a4d1a7a6d74'),('includes/database/sqlite/query.inc','f33ab1b6350736a231a4f3f93012d3aac4431ac4e5510fb3a015a5aa6cab8303'),('includes/database/sqlite/schema.inc','cd829700205a8574f8b9d88cd1eaf909519c64754c6f84d6c62b5d21f5886f8d'),('includes/database/sqlite/select.inc','8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68'),('includes/date.inc','18c047be64f201e16d189f1cc47ed9dcf0a145151b1ee187e90511b24e5d2b36'),('includes/entity.inc','e4fc9ff21b165a804d7ac4f036b3b5bd1d3c73da7029bf3f761d4bdee9ae3c96'),('includes/errors.inc','72cc29840b24830df98a5628286b4d82738f2abbb78e69b4980310ff12062668'),('includes/file.inc','9de0398940bf2db560902736f1832d8b72b3e8b49dbbaba5f94c9331425ee04a'),('includes/file.mimetypes.inc','33266e837f4ce076378e7e8cef6c5af46446226ca4259f83e13f605856a7f147'),('includes/filetransfer/filetransfer.inc','fdea8ae48345ec91885ac48a9bc53daf87616271472bb7c29b7e3ce219b22034'),('includes/filetransfer/ftp.inc','51eb119b8e1221d598ffa6cc46c8a322aa77b49a3d8879f7fb38b7221cf7e06d'),('includes/filetransfer/local.inc','7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492'),('includes/filetransfer/ssh.inc','92f1232158cb32ab04cbc93ae38ad3af04796e18f66910a9bc5ca8e437f06891'),('includes/form.inc','e8740cc136c284b132cc2f970a2bfc618e011f85b96140aaf7f7c49c891eca31'),('includes/graph.inc','8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536'),('includes/image.inc','bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826'),('includes/install.core.inc','733ec6fac8e51747d1c83f266a42e4a0cb6bf31ac50f17f06e37c9e0865f4a38'),('includes/install.inc','fbb23627b06abb070b4531da786c1e06bf1dbd6f923bb2b404f4808c2340b0f9'),('includes/iso.inc','0ce4c225edcfa9f037703bc7dd09d4e268a69bcc90e55da0a3f04c502bd2f349'),('includes/json-encode.inc','02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e'),('includes/language.inc','4e08f30843a7ccaeea5c041083e9f77d33d57ff002f1ab4f66168e2c683ce128'),('includes/locale.inc','f8a3ba7868698e9b43c2ceaebe2cbdcb92d6c68427e817a6e10a76b937b5a127'),('includes/lock.inc','a181c8bd4f88d292a0a73b9f1fbd727e3314f66ec3631f288e6b9a54ba2b70fa'),('includes/mail.inc','41d0e657119a05f8d7e85ebf32e74b12a1c3107d717a348158414b113e208b9c'),('includes/menu.inc','96d92a30fe030e3bfff87ca0904777cd9e89d0e224e26d37adee0089724796c4'),('includes/module.inc','50cf3d3a93d72d1f261c6eceeaa23688ab7272315c5b806f702e518b8d000bfd'),('includes/pager.inc','6f9494b85c07a2cc3be4e54aff2d2757485238c476a7da084d25bde1d88be6d8'),('includes/password.inc','fd9a1c94fe5a0fa7c7049a2435c7280b1d666b2074595010e3c492dd15712775'),('includes/path.inc','2dca08d14a46e5ac6a665b7a5dde78045d8de2b35aaa78c6fb811e1125ce4953'),('includes/registry.inc','f47b20859f0fc80bf4bb2849a1282d6c54006957b69da0e5f4691de585ca4cdf'),('includes/session.inc','7548621ae4c273179a76eba41aa58b740100613bc015ad388a5c30132b61e34b'),('includes/stream_wrappers.inc','4f1feb774a8dbc04ca382fa052f59e58039c7261625f3df29987d6b31f08d92d'),('includes/tablesort.inc','2d88768a544829595dd6cda2a5eb008bedb730f36bba6dfe005d9ddd999d5c0f'),('includes/theme.inc','193e6453b5e1534ba48c40bfa13528c6ba21b819e8ebe618309b302a2ba90f4c'),('includes/theme.maintenance.inc','39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a'),('includes/token.inc','5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428'),('includes/unicode.entities.inc','2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54'),('includes/unicode.inc','e18772dafe0f80eb139fcfc582fef1704ba9f730647057d4f4841d6a6e4066ca'),('includes/update.inc','77403195059de797422d9d9202f18548a38558995120c7f9ffb9bd044730a3bc'),('includes/updater.inc','d2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380'),('includes/utility.inc','3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5'),('includes/xmlrpc.inc','ea24176ec445c440ba0c825fc7b04a31b440288df8ef02081560dc418e34e659'),('includes/xmlrpcs.inc','925c4d5bf429ad9650f059a8862a100bd394dce887933f5b3e7e32309a51fd8e'),('modules/aggregator/aggregator.test','1288945ead1e0b250cb0f2d8bc5486ab1c67295b78b5f1ba0f77ade7bf1243b4'),('modules/block/block.test','40d9de00589211770a85c47d38c8ad61c598ec65d9332128a882eb8750e65a16'),('modules/blog/blog.test','f7534b972951c05d34bd832d3e06176b372fff6f4999c428f789fdd7703ed2e2'),('modules/book/book.test','a75a4ec12f930d85adbf7c46d6a1a4ed1356657466874f21e9cc931b6cd41aa0'),('modules/color/color.test','013806279bd47ceb2f82ca854b57f880ba21058f7a2592c422afae881a7f5d15'),('modules/comment/comment.test','0443a4dbc5aef3d64405a7cabf462c8c5e0b24517d89410d261027b85292cd4b'),('modules/contact/contact.test','d49eedd71859fbb6ffa26b87226f640db56694c8f43c863c83d920cf3632f9ad'),('modules/contextual/contextual.test','023dafa199bd325ecc55a17b2a3db46ac0a31e23059f701f789f3bc42427ba0b'),('modules/dashboard/dashboard.test','125df00fc6deb985dc554aa7807a48e60a68dbbddbad9ec2c4718da724f0e683'),('modules/dblog/dblog.test','e6c6ba087256e007159a2dbfcd3554f824503cc3b2ef1335497e3f05d4cd67c0'),('modules/field/field.attach.inc','2df4687b5ec078c4893dc1fea514f67524fd5293de717b9e05caf977e5ae2327'),('modules/field/field.info.class.inc','cf18178e119d43897d3abd882ba3acc0cf59d1ad747663437c57b1ec4d0a4322'),('modules/field/field.module','e9359f8cac64b2d81ac067d7da22972116dc10b9b346752a8ef8292943a958c9'),('modules/field/modules/field_sql_storage/field_sql_storage.test','315eedaf2022afc884c35efd3b7c400eddab6ea30bec91924bc82ab5cd3e79f2'),('modules/field/modules/list/tests/list.test','97e55bd49f6f4b0562d04aa3773b5ab9b35063aee05c8c7231780cdcf9c97714'),('modules/field/modules/number/number.test','9ccf835bbf80ff31b121286f6fbcf59cc42b622a51ab56b22362b2f55c656e18'),('modules/field/modules/options/options.test','5a9d86ddda33bef96468072c53bd0f7b28966e5d23d58a965724a672c9dae62a'),('modules/field/modules/text/text.test','a1e5cb0fa8c0651c68d560d9bb7781463a84200f701b00b6e797a9ca792a7e42'),('modules/field/tests/field.test','5eaad7a933ef8ea05b958056492ce17858cd542111f0fe81dd1a5949ad8f966e'),('modules/field_ui/field_ui.test','ded58a83a37cf111834f68fde9c34cddc7f4d36b91f31281e41ed5220c65dac4'),('modules/file/tests/file.test','e255648f4178ad702f1f0017d19679a30b2a1ac95c0ef0f9174579cdfdc04b38'),('modules/filter/filter.test','268488be9d8e6a4bfa906bbb5bbf1f0df5881c04a421cbefcd7aa4f05fb63ba0'),('modules/forum/forum.test','d282b29d6312d63183e003ba036d7645a946e828c94448592f930d80fceb42d6'),('modules/help/help.test','bc934de8c71bd9874a05ccb5e8f927f4c227b3b2397d739e8504c8fd6ae5a83c'),('modules/image/image.test','3f07aff7b581be787d8ee4bea178c1b416d24906be99a3afb894154f1da801d8'),('modules/locale/locale.test','61c6a80ba44ff92e6ba4a350b7c95890368e2f9e029b8f84563df2490a8e93b1'),('modules/menu/menu.test','51817d6c591c28cf268145c2d39b41f66e453edf42c86472e61b7081da1d86bb'),('modules/node/node.module','70f969229d03819dba439546ae7aef30283b93e410af1b45f5a25b90d3cb8edd'),('modules/node/node.test','b08b445f7580848468bf2b2822ae378074e05246b006e0bf56f4fb0e7c9feb70'),('modules/openid/openid.test','3decf7faf3a9396671d52c6065a31f0ef81828015e0348a0ba9358b618e737a1'),('modules/path/path.test','2004183b2c7c86028bf78c519c6a7afc4397a8267874462b0c2b49b0f8c20322'),('modules/php/php.test','d234f9c1ab18a05834a3cb6dc532fb4c259aa25612551f953ba6e3bb714657b8'),('modules/poll/poll.test','cc8486dc337471d13014954e1c1e4e5ad4956e4a0cbd395adbd064f8e5849c72'),('modules/profile/profile.test','de3e5807b3dc5f658270194f6ef012b5ad858ca9ad79f2782a69531754b442a3'),('modules/rdf/rdf.test','9849d2b717119aa6b5f1496929e7ac7c9c0a6e98486b66f3876bda0a8c165525'),('modules/search/search.extender.inc','013a6a841cc48a6dc991153fb692b8d1546e56b78d9c95e97e0d7e92296d3481'),('modules/search/search.test','84e3939f935d661ecc856549719dae35c6eb8825f4540454cf78774a87d5d85b'),('modules/shortcut/shortcut.test','0d78280d4d0a05aa772218e45911552e39611ca9c258b9dd436307914ac3f254'),('modules/simpletest/drupal_web_test_case.php','70e832baa9cb7f2a3009dd3a2314e8987bc753429bde23334bd2a88ac7e398a5'),('modules/simpletest/simpletest.test','8112284b928297e326a2cb2a029a8ee35490732ce73ab0b54a91e9613a84e951'),('modules/simpletest/tests/actions.test','4e61dcbff514581321b47b8b2402cfb387d859b1a9944cb70bf9f33977dd5220'),('modules/simpletest/tests/ajax.test','0581306ba076da005db073036806a4d393a166221cd7171e3e3b1974b7082106'),('modules/simpletest/tests/batch.test','665a621f4d5f819295ca7c53158d586ed98c42d8a8e6db1e67fb332032ec07d5'),('modules/simpletest/tests/boot.test','1a7cf3c120a8e544cb251ba049ae598f8b25c0a9c3283e15df07a3a562641799'),('modules/simpletest/tests/bootstrap.test','4e63c03ccc8a072762be12a31831a623cec6edd4326d4726d08aa5019a91b2bc'),('modules/simpletest/tests/cache.test','2ff9a42287a6419acba6589cd887e9c0d765c1c201865799abe03ee6f3234dfb'),('modules/simpletest/tests/common.test','73de4221bc275f30d0504aa4df09448490da89f638142abe9b6c6f3866bc9592'),('modules/simpletest/tests/database_test.test','64baa1520d815e049310ae697fa79390b6b0a02fb03d47c64d3caec8d40ab8e9'),('modules/simpletest/tests/entity_crud.test','0db2e08cb15ef287ed622fa56cee85e6a61b6e7a8547c77531a80a9ec1379d87'),('modules/simpletest/tests/entity_crud_hook_test.test','5f3f083a018c1c0e78c8532cfc87b95d3c2b1740577a2f0eab8bc75e1db069b4'),('modules/simpletest/tests/entity_query.test','8b107f796e9febb8080b153d3c9b969cea5bbb3cd4ee410c8f612bf7bdbb0a63'),('modules/simpletest/tests/error.test','df8360738a4b3c946209a560ae83065728ae1aa56744cd8aaee398325a7cda60'),('modules/simpletest/tests/file.test','25fdee40ceb8c84f08677224db941e251906f2caa185b351de80eba76f20c90b'),('modules/simpletest/tests/filetransfer.test','a5ae7e24c43f994968d059c93d56be0dfd580699e2cb884afb074b9ae5895fd9'),('modules/simpletest/tests/form.test','1d932031c1b2e33947c1cb480457f9f6c95b1ee93bab6eab785c2cde290fd9d7'),('modules/simpletest/tests/graph.test','3038b97305b54f859a78356c184feeb773056e6c54b9ad511cc4c487ea3355c2'),('modules/simpletest/tests/image.test','fbad58b83e40aec654bf66835e30f81b83a76714efc560d73e7be3841ab5e996'),('modules/simpletest/tests/lock.test','0d63de7e57c405dae03a6c04e13392c59c8dc19a843e0818cc43212af2e26242'),('modules/simpletest/tests/mail.test','857526ad270b9aa32cfb625ac09e9b875704b435d4c4e6e519dec50442fecc8a'),('modules/simpletest/tests/menu.test','b7602b23403271fd404646cd5f4970ce278eb3c014ed30676f1ba680cfd749a1'),('modules/simpletest/tests/module.test','056de988f33d43c39e62f067af8f449f5192cd27bbbcf358a6e3b0d34d94167c'),('modules/simpletest/tests/pager.test','9586bc07f5ed2791ae69e8cacf1a257ffe85dde3be7769ce6e84435a001bc296'),('modules/simpletest/tests/password.test','fadb23077d9364d0dba4fa7462d31f2ad842d840ad173f685cf6944aa679c9a7'),('modules/simpletest/tests/path.test','814b32c225e1a73f225b52c0e5a9579a754dd9f597cb71189fa0b62c5ce821ad'),('modules/simpletest/tests/registry.test','eadaa4f04ffbe49656ee9c8d477a4855de12f5f7fd6923894ab6565b86fde28f'),('modules/simpletest/tests/schema.test','14a7975e040ae8d3a7c8bb82c9e26dabe78978f6371dec22ae8c81b71cf3e4bb'),('modules/simpletest/tests/session.test','6416694ef7c79680f99e405468401567357c38abead1e0ce9e232a15e7dcd823'),('modules/simpletest/tests/tablesort.test','0c0e011775ffc0e8f2d9c6f1284de28ad849ffa88df6e48677ed1c395c2267d1'),('modules/simpletest/tests/theme.test','f542bdf4efc342609b8804767b793521c6641ab5cd31a7130865feeef5f2cfa1'),('modules/simpletest/tests/unicode.test','91f0f16bbdb987035b562f4621bea1522aa74851e7c107663ae17d11b2ac0959'),('modules/simpletest/tests/update.test','49f64b9b84521f9f8eaebb9610f5cc3378d0665683032320a36abda12d16be43'),('modules/simpletest/tests/upgrade/update.aggregator.test','a2b6a574993591e93dacbd303a300b852775a3beea1343fb1f11578a8cdd26e1'),('modules/simpletest/tests/upgrade/update.field.test','e8a443db8d58d743cf06957ff949370dde65b0ad35837368fd89a95ea6594d52'),('modules/simpletest/tests/upgrade/update.trigger.test','421b8986a71c8cf30c442cd9f1736ae7ce8838214a1b6e9eae30c9c5c108acd3'),('modules/simpletest/tests/upgrade/update.user.test','b21ec55d94d3baec7ce807c7972fb3b348deba70a53bfb78a66553c66ede63af'),('modules/simpletest/tests/upgrade/upgrade.comment.test','a20a8b44b46a6bc1cc0f0a18e67a12933d0b101d463bcdc21212e5f35d93c379'),('modules/simpletest/tests/upgrade/upgrade.filter.test','0485b6d466476a85e7591eb4bdaf303b1b75a871038f1d5669a3f6d4cd81ecd0'),('modules/simpletest/tests/upgrade/upgrade.forum.test','6330fe5d85a81d7d5686da5a40cf18b275bef4c5819afb334f8fc0b043532bb4'),('modules/simpletest/tests/upgrade/upgrade.locale.test','ec2d285222dd85022a16daed2b3a3e951dba97ab4de9fd46d89d2064f5db7595'),('modules/simpletest/tests/upgrade/upgrade.menu.test','fa6e46dcb1028e6c3faad86c50d3d9296d7a4095115ffb8d39b627dbd31996d7'),('modules/simpletest/tests/upgrade/upgrade.node.test','f16f1ae5b5b3584e4d1d119473a962112fb28796efb5283aaa8df2db0ddec364'),('modules/simpletest/tests/upgrade/upgrade.taxonomy.test','805528f81162014479d94e70bcaf234f818a1898d057e05d08b148a9120743b9'),('modules/simpletest/tests/upgrade/upgrade.test','877364dd82e5e1ed28e1ee93c48fbec083237012f44038a8fef39d9c6cb8b4f9'),('modules/simpletest/tests/upgrade/upgrade.translatable.test','7a53241c9df9c671fb1da2789fe32c0e0425267f1647293a89adadbfa49bc4ac'),('modules/simpletest/tests/upgrade/upgrade.trigger.test','4ba820349ef89f6eaa73f429c053e09f937d36808149a00563efa5b551e8669d'),('modules/simpletest/tests/upgrade/upgrade.upload.test','8fc15f53a5ef54b48133a8525fcd384729563ba2d9bd49ab035549d07fabf3c4'),('modules/simpletest/tests/upgrade/upgrade.user.test','9c11a51f2bd262f957e6c609ec84b26ac9d1fa00feeb0078b7a12beb450daab3'),('modules/simpletest/tests/xmlrpc.test','6a4f2fec0c3b8027655069ac71c41d9ee7ec7838257081ede18a4647d7dacec4'),('modules/statistics/statistics.test','3fd921d3cc26f9363bba0d6f29efb96c49c88ca51e2e2376b6554afaff8ceeb5'),('modules/syslog/syslog.test','ad873b3d499ebad748784ae88df3496f39de1b9bbfd98c3193ef1ea70c6376ae'),('modules/system/system.archiver.inc','faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1'),('modules/system/system.mail.inc','d31e1769f5defbe5f27dc68f641ab80fb8d3de92f6e895f4c654ec05fc7e5f0f'),('modules/system/system.queue.inc','a60cff401fc410cd81dc1d105ed66f79396ed7b15fdc3a5c5b80593ad5d4352a'),('modules/system/system.tar.inc','d0d2f191d79b3227852e7436908386bdd7a25f78c73f3c8bf9ef5903892ae993'),('modules/system/system.test','a8b6d3a8f11944af3e947ac53b8ad4cd37f1af11256e12768c7c24b9b4052711'),('modules/system/system.updater.inc','338cf14cb691ba16ee551b3b9e0fa4f579a2f25c964130658236726d17563b6a'),('modules/taxonomy/taxonomy.module','ee7f4b7021d72b7deac3d01ca79d90a411d235bdf92edb6800128432ce679eb6'),('modules/taxonomy/taxonomy.test','8525035816906e327ad48bd48bb071597f4c58368a692bcec401299a86699e6e'),('modules/tracker/tracker.test','bea7303dfe934afeb271506da43bcf24a51d7d5546181796d7f9f70b6283ed67'),('modules/translation/translation.test','c2ad71934a9a2139cdf8213df35f4c91dcc0e643fabb883c38e3ffbdd313d608'),('modules/trigger/trigger.test','662f1a55e62832d7d5258965ca70ebe9d36ce8ae34e05fda2a2f9dc72418978b'),('modules/update/update.test','1ea3e22bd4d47afb8b2799057cdbdfbb57ce09013d9d5f2de7e61ef9c2ebc72d'),('modules/user/user.module','c50e0b5a775c6ae4c918219056c7d8ec083a32971522672756802e8da89d2dbb'),('modules/user/user.test','5bb03ec7ffec6eac7df049115b6c3c64558e9d6fbb4a084ba86999db02177f46'),('profiles/dhs_wcm/dhs_wcm.profile','bfdc4319176a765e0756fbdc1c1fb7513d189c088f1ecbef6dfe0dbcb176abde'),('sites/all/modules/contrib/acquia_connector/acquia_agent/tests/acquia_agent.test','43bdd64f0fe44259dba158a20077846976766d93a0698be78539c5e53499ce61'),('sites/all/modules/contrib/acquia_connector/acquia_search/tests/acquia_search.test','9d49756c204ecfdbd2723a2a9823af974a06fc20e1feef766674bfe2aa77edc9'),('sites/all/modules/contrib/acquia_connector/acquia_spi/tests/acquia_spi.test','73e8303c80ac7da99c56f16463f0c829d3a5388d2bf38093e505812e324743a0'),('sites/all/modules/contrib/admin_menu/tests/admin_menu.test','185f8244f7a086cda1bd9435ec529e8632598e9b09d1e0d7363b75cf87c04afb'),('sites/all/modules/contrib/akamai/akamai.test','21f9886586aa17c35fb00db1e1db9ba39f22925a9887f4558ff357be8924a928'),('sites/all/modules/contrib/boost/boost.admin.inc','73f207031cc376b3c118418a92d5be994b4cbfdd72f619dd7715578a81e5d337'),('sites/all/modules/contrib/boost/boost.blocks.inc','06c491a27551df7bb85f9d9d1d4973b582ff79976c63046e638f1285f213e01d'),('sites/all/modules/contrib/boost/boost.module','d326e026f33674f427141a5ba5b4c09eb860e1aaec68b293566a4cc4f7703394'),('sites/all/modules/contrib/boxes/boxes.admin.inc','9f57e4b3ee80cdec886386ee0b8f33d7a4ef5947e571aa42b26a9d936881c6c5'),('sites/all/modules/contrib/boxes/boxes.module','9b2e942fafe5d74b31c069c4bea2c72f9f983ee663f5f4d59cf12db5277feb4d'),('sites/all/modules/contrib/boxes/plugins/boxes_box.inc','755f5b7183d47b32bc58403e9a7dc928387f04a9382b2b87f78242b539b73789'),('sites/all/modules/contrib/boxes/plugins/boxes_simple.inc','fca2a6c1e2c793e23e8718c66ced75acdb58ee56c60598c80eb37fb326970fb0'),('sites/all/modules/contrib/boxes/plugins/spaces_controller_boxes.inc','5a1644eaae6f4c773b385da88748a4f794ceda21a4ae7f74ddb8fcba8dee261a'),('sites/all/modules/contrib/boxes/tests/boxes.test','8477f8dbf238bbd4307e56028ef2466d97cb8bd74d48344e0c94f50d692511ed'),('sites/all/modules/contrib/captcha/captcha.test','bfd7be7d26d1dc83861aae51261fc51455381a9ce3b6f5c6f8d1f64b6eecb066'),('sites/all/modules/contrib/conditional_styles/conditional_styles.install','a71407bab4afa833cbb0905a524ff269920694bddd7b1839540d794cac49a7ca'),('sites/all/modules/contrib/conditional_styles/conditional_styles.module','385853e5988eb58956096d3608a5a5c6add8631bf1ff964b4cb9cc4ff89eb7fd'),('sites/all/modules/contrib/conditional_styles/tests/conditional_styles.test','5706b6892d482902e768a6a4cc84a5a99d7c63264c7d1bdf8b0b750e8c26687e'),('sites/all/modules/contrib/context/context_layouts/plugins/context_layouts_reaction_block.inc','9d4b9d7b8fc0d2a03804f13c462000e3a233229f954ba85c299a79b052861e69'),('sites/all/modules/contrib/context/context_ui/export_ui/context_export_ui.class.php','669518a4d1dcbf4b01ac4aea05074e342419a07b7bbda23d2c5ba04c8b3be6a7'),('sites/all/modules/contrib/context/context_ui/tests/context_ui.test','c30c5cb7193436a17e7e7892064232dc6b53a4e02ede31d5f12e4ae0f970e903'),('sites/all/modules/contrib/context/plugins/context_condition.inc','2701acb0f8667cf922052a9265bb84c936a3b716afaf3a8eff2ad04e332b5a2f'),('sites/all/modules/contrib/context/plugins/context_condition_context.inc','cc3630470442db0c92d2def23cc03eeb9de30fb1c00dd2e00660646e292a705c'),('sites/all/modules/contrib/context/plugins/context_condition_context_all.inc','80b00ab0cd49aa4cfe4493a2cd08dde594d73ba3f3563d34c15ae2b46fc5983e'),('sites/all/modules/contrib/context/plugins/context_condition_default.inc','5764948ea3f0c7b55e14b0cd3690ab279f2237eb45043fac102a82b5d392c4a2'),('sites/all/modules/contrib/context/plugins/context_condition_language.inc','edbd457b68a4dd1e213792dce89d89ae17127d21ec3aa7e64eb6e636f11b2034'),('sites/all/modules/contrib/context/plugins/context_condition_menu.inc','1043c5b26abfb064ee307a21d8893c97593e1bc3f1b77c848542248afe7b4c89'),('sites/all/modules/contrib/context/plugins/context_condition_node.inc','8d54a13f2ed57cd1a36d1dbcba62e32f256ed6e71554643599fca50a3dddbbd0'),('sites/all/modules/contrib/context/plugins/context_condition_node_taxonomy.inc','bc21088c7859b6db39417b1ee3124da8b3ea720b18d3731063299d3b0edf1ecb'),('sites/all/modules/contrib/context/plugins/context_condition_path.inc','c9ad2e426c75c8ba6bc4c94181aadadf3f474272cd0dc0bc67bd7c6cd810fea7'),('sites/all/modules/contrib/context/plugins/context_condition_query_string.inc','3902793c371098e42e0d3336fb8a0c26a0f18685ac03c6ac9a04f755a8ebd0cc'),('sites/all/modules/contrib/context/plugins/context_condition_sitewide.inc','cb5061fe6757287744f3db7296380120089c4e56af3298395aeaa3da16aedc3b'),('sites/all/modules/contrib/context/plugins/context_condition_taxonomy_term.inc','94eb955d5705e75936cc440417893e341905fa7fb3df3b6d3e7d838fa33e313c'),('sites/all/modules/contrib/context/plugins/context_condition_user.inc','a6fd04ce6574d5391427a038da1f158f47b062cde7655811fa5a41271e75d20c'),('sites/all/modules/contrib/context/plugins/context_condition_user_page.inc','c5c48146a183e6d2cdfa07222e7f614bd9ba3ff4b745131c9910aeb79bbf4bcd'),('sites/all/modules/contrib/context/plugins/context_condition_views.inc','5cd3e84b22977af2d1a72ecc9dffb9b1beb1ac42f2ad2741de5a015a45734473'),('sites/all/modules/contrib/context/plugins/context_reaction.inc','497ce814344a5789eebd05e77f9a84625d20f8bf38cf77bf794ac85fdd1c1c0a'),('sites/all/modules/contrib/context/plugins/context_reaction_block.inc','e387623a2916d3ecd34eb455a8b62d621edd2f84ba6a2a925bdd835338120fbb'),('sites/all/modules/contrib/context/plugins/context_reaction_breadcrumb.inc','74497dfd46b263561fb22e395049edc7ba24d14ff4b6b9c89af0ae1136aba8b5'),('sites/all/modules/contrib/context/plugins/context_reaction_debug.inc','c57b92ccf0b1278dce108089989eb32fb532e786f9bc01d2cb694819b468f322'),('sites/all/modules/contrib/context/plugins/context_reaction_menu.inc','b4fe6cd7738895c013ba7bae05fe0d23e34003f5bfcf18cd2c89c666a3688eed'),('sites/all/modules/contrib/context/plugins/context_reaction_region.inc','fc61c32bcdd8da4db6441424a4b5af8c7ccfd388386b0a0f3e497fe694006241'),('sites/all/modules/contrib/context/plugins/context_reaction_template_suggestions.inc','9f819f86c6e2865d33e5a73473ce5ca2bfccd236d7880d6bab04eff56ceb2a4e'),('sites/all/modules/contrib/context/plugins/context_reaction_theme.inc','eae05dc2e34947aacc18bdfb4925df9a7946d64d9b23e7cde92ee23610cadffd'),('sites/all/modules/contrib/context/plugins/context_reaction_theme_html.inc','b0b4f355aebce29dbaa3e2bf26c35443d134f73649f1e197170e73d5ab93e0a2'),('sites/all/modules/contrib/context/tests/context.conditions.test','d13d632b7140e82946c2238bffdaab99893c3cab9d8a59ae6a1e2bebb5a42c88'),('sites/all/modules/contrib/context/tests/context.reactions.test','4d1d8d1497fc32e685446e52e387e537a6ec183ed598d224e356ad1461676efa'),('sites/all/modules/contrib/context/tests/context.test','05e97800946a534d2a4f3f017f6ac3ee682c7ef8a430cef5bb769574701d9419'),('sites/all/modules/contrib/ctools/ctools_custom_content/plugins/export_ui/ctools_custom_content_ui.class.php','1b15f1595c6d1ca3abbd1439182d5613d5af7c3155d5f3e52ade4111833bc51b'),('sites/all/modules/contrib/ctools/includes/context.inc','4cec11a71872eb916c4315c9f727a184d46758aa64bb950d86877a60b9007157'),('sites/all/modules/contrib/ctools/includes/css-cache.inc','db90ff67669d9fa445e91074ac67fb97cdb191a19e68d42744f0fd4158649cfa'),('sites/all/modules/contrib/ctools/includes/math-expr.inc','601db581743dd22d67f7aaf228bd8d26298d72033fc675d02385a1fd6d31888f'),('sites/all/modules/contrib/ctools/includes/stylizer.inc','3f91f5ed42fb6ee1b65ddef7ac22577b07a5d75ca1eb2df60041243ced5c7079'),('sites/all/modules/contrib/ctools/plugins/export_ui/ctools_export_ui.class.php','2fd87a7d80689e4d44673b31c07b762144eb8ac57324fd0b9cd9ede5f4ea34b5'),('sites/all/modules/contrib/ctools/stylizer/plugins/export_ui/stylizer_ui.class.php','a59daf0b749aa681c31c117a7d72f023c83a5b9de91690c13b9614ac0e7ea769'),('sites/all/modules/contrib/ctools/tests/context.test','3a8dd81dd1b99da05a28425f9a017cb611e0470ba88cf000c8b74339c8c91d91'),('sites/all/modules/contrib/ctools/tests/css.test','20ba7d780a8bdd8f512472a8becef11240da74b96599f6968fecea0ad7ae49c6'),('sites/all/modules/contrib/ctools/tests/css_cache.test','0dbc038efedb1fa06d2617b7c72b3a45d6ee5b5b791dcb1134876f174a2a7733'),('sites/all/modules/contrib/ctools/tests/ctools.plugins.test','6af9d9caa3afe93faf5051d3d42c0ce33a1ff6e3a18a09f281df1260d43337d6'),('sites/all/modules/contrib/ctools/tests/ctools_export_test/ctools_export.test','65e96eabc5c62d7ad29f63309671e2761f221a1c15bb6836d7eadfd263653abc'),('sites/all/modules/contrib/ctools/tests/math_expression.test','b99d5c3096857de944dba0e88e21628c7268d8056f42903786172b7a95563dbf'),('sites/all/modules/contrib/ctools/tests/math_expression_stack.test','797d9e0844f9e214799d96b33d55dd041720d27b11ceb96c3790634d93a62be6'),('sites/all/modules/contrib/ctools/tests/object_cache.test','18e03c7760a2fc8858d801479ec5471b8c93bd4044c80db557c5e77e7ab20d79'),('sites/all/modules/contrib/date/date.migrate.inc','47ffb48daf97c13ef154cf2ffff577018f02a7091b85dfb39e9c2c89e1da6a5d'),('sites/all/modules/contrib/date/date_api/date_api.module','af2124c5727d839871309b31fe288fe3945d6ef67eb469ddcc02839be98860dc'),('sites/all/modules/contrib/date/date_api/date_api_sql.inc','5a484b487c13fd6094348e2011c19e72d6c6c9ceb0b0a4143ef5542cd1c495fa'),('sites/all/modules/contrib/date/date_repeat/tests/date_repeat.test','3702268fa89aa7ed9bcae025f0fb21bd67f90e89d53122049854de60a5316d4a'),('sites/all/modules/contrib/date/date_repeat/tests/date_repeat_form.test','2ec4e5d57d5b9f1adf81505d40890c63dc684f2d0f00669b9c8c12518eb3bf4a'),('sites/all/modules/contrib/date/date_tools/tests/date_tools.test','bdb9b310295207ce2284b23556810296e1477b9604e98a3d0fb21aba7da04394'),('sites/all/modules/contrib/date/date_views/includes/date_views.views.inc','7ddcf452b6da1c6e8d6e983674f1108b1d13a93d63948a5c7c9831e4e1c6ccee'),('sites/all/modules/contrib/date/date_views/includes/date_views_argument_handler.inc','8f4debf9b3db7698f2633c39b75aa252e40db5aba07a082468614773e2958e9a'),('sites/all/modules/contrib/date/date_views/includes/date_views_argument_handler_simple.inc','082dc7463949c86d32e637c2eb0d0568670ae7100c39ee8b4b52e96246487d28'),('sites/all/modules/contrib/date/date_views/includes/date_views_filter_handler.inc','936bbe570617d6b1d2878fe869c722c5826e6d913c48c1b1a842a5500c2ef5fd'),('sites/all/modules/contrib/date/date_views/includes/date_views_filter_handler_simple.inc','93f85798f6b2b962c90c5d2520beedc45fa443453cd206bba0db3d7e0a33d0bd'),('sites/all/modules/contrib/date/date_views/includes/date_views_plugin_pager.inc','43d496c6c834cd26d4b74ddd6291d5da959d402e60b360b37aa90126808a0a4d'),('sites/all/modules/contrib/date/tests/date.test','6cb38e9ed60bfdfa268051b47fcad699f1c8104accc7286abafbeddbbc9d143c'),('sites/all/modules/contrib/date/tests/date_api.test','280148ca742592a1e22f663fe4d810532b95d09975db0182347a0bbd6917f996'),('sites/all/modules/contrib/date/tests/date_field.test','bae59aee63ed204e27909709e59eeae1a6192e5f7456de2ce2cce06c49732dc4'),('sites/all/modules/contrib/date/tests/date_migrate.test','a43f448732d474c5136d89ff560b7e14c1ff5622f9c35a1998aa0570cd0c536c'),('sites/all/modules/contrib/date/tests/date_timezone.test','598ac52aa82f79fe90faa401c2c6dc7114295c0321800ea9a9b4058717d00409'),('sites/all/modules/contrib/date/tests/date_validation.test','2e4d27c29192c9d55eb27b985d7e9838702c4324d36ed6e3a85999e9f25ada99'),('sites/all/modules/contrib/date/tests/date_views_pager.test','aceff66e11dd3ea418e9905b28384432f4fe7cf9746e711cf56add73e64336dd'),('sites/all/modules/contrib/date/tests/date_views_popup.test','0684ad4977093fd7338eb045f85ceda195e82f50bd33fecbf0dca00e42b0385e'),('sites/all/modules/contrib/defaultcontent/context/plugins/defaultcontent_condition.inc','8dba2d770a02f5d40489ffdd8d0f4a50620b15bf35bc8825bf6d5fbe750fd0d4'),('sites/all/modules/contrib/delta/delta_color/plugins/delta_injection_color.inc','7de614ae681911ec911659c1c622b4c864528627adad5f59db5298b5941cf57c'),('sites/all/modules/contrib/delta/delta_ui/export_ui/delta_export_ui.class.php','c33fc9d489fce9f58ffc6d23c57130693a53fead897573463364acbdd362beb9'),('sites/all/modules/contrib/delta/plugins/context/context_reaction_delta.inc','1ba6747717315ae1c3f7752ee9cc90474cc31744e3b91d7983057281479e4309'),('sites/all/modules/contrib/delta/plugins/delta/delta_injection.inc','286f7009e4466e56942ab32bbb64e77ba245c8d24c79ab88ac27df3501743602'),('sites/all/modules/contrib/delta/plugins/delta/delta_injection_theme_settings.inc','e8e7cb65ef7540797a0f215a02d19919300c9aae91f177834b7b2bd90661588b'),('sites/all/modules/contrib/diff/DiffEngine.php','703ce171950b72c8f97795e79251145ffb1d35dfcc91c619a1d5e7b73faec1fc'),('sites/all/modules/contrib/entity/entity.features.inc','0117b5792e94ef56acac7ee7f292b4dd103397d0af0486e42dc0293af71169ff'),('sites/all/modules/contrib/entity/entity.i18n.inc','41e0e62af7e2774f62b162d597bb3244551c280296b692b29d039a2c243d7059'),('sites/all/modules/contrib/entity/entity.info.inc','8799080b9393c9560e64feae1276fb7d26fef4d92bb0edacc863ee3e7b67bf04'),('sites/all/modules/contrib/entity/entity.rules.inc','774199059d1b3ebe6d3fe7a49dbb1550df489055a3d066b5de54edda8dd7ba84'),('sites/all/modules/contrib/entity/entity.test','df253128e41f152b45ef30b5674009c51cf4112450e5dad8e815f39ced280db5'),('sites/all/modules/contrib/entity/includes/entity.controller.inc','342db185e6170b63c59a9b360a196eb322edb9a5b8c7819f66b0eae48ed13ebd'),('sites/all/modules/contrib/entity/includes/entity.inc','02c3c8b1d4b7230f875c4fae8e6ba3bd57431e01f312b32f3ed305a7be734774'),('sites/all/modules/contrib/entity/includes/entity.ui.inc','e0d5af6794dc6369dfb7fa57ae20d585a4592f368fabc9bed8142830853968c1'),('sites/all/modules/contrib/entity/includes/entity.wrapper.inc','0db08cbb6b730035e3e9a483e6e5c06a744a73f19e4ca83936446b44f0c3d158'),('sites/all/modules/contrib/entity/views/entity.views.inc','de657f42389ed6832df787e4b618d8d7117b60d145d34ce5dcf3a5b65db29df9'),('sites/all/modules/contrib/entity/views/handlers/entity_views_field_handler_helper.inc','4ec395881109a71327ab8d7c5b5702bef30288ca66557e44e8539cc15a2135bb'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_area_entity.inc','7b7bb88e53861739b7279f705f0492fc83ce95f5b20d89339480f546422ebf25'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_boolean.inc','b28b8eee8761ba7a6af35d97ab7aaee28406e6c227271f9769818560626c5791'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_date.inc','b0f5be5b399de94934b24e84c8cf6053a043f6b00c60dcffa752daeafdd38778'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_duration.inc','ed7bb64cb63b94a20c8cde98cfb053b5ea252804396cf61ac562faf1d850266b'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_entity.inc','4f255918a22fefebe9c7734f200751457a7ca4d3648e32a98511bb51968d7521'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_field.inc','893121efbce2a7181e31147bade260c9cc657cbd33b0d254cb28b2650e57566d'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_numeric.inc','f14e2b063930e8820af381b4f5e83c7278440e7804ab88cfde865b6c94e7c0f6'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_options.inc','27ef31b8ee7b9999930380d6a5fdb477772329c4ddbd5c70cc34bcdc7543ce56'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_text.inc','5fb0a85d35d29944c699ceaf6efed5eda2df757009e44caba8ff2be397568b60'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_field_uri.inc','79ecaa3eb17dfdd0ca077351b75a2c0adf411ebc04720e7cc0e2397674225f24'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_relationship.inc','b69bc538d1e1e0f91f8485ca54c3b6e2be025caa47619734c467377cf89041b9'),('sites/all/modules/contrib/entity/views/handlers/entity_views_handler_relationship_by_bundle.inc','65300c793c4591d60ad908dc02cf3148fe4e899fa6ad218e875fd92d411374dc'),('sites/all/modules/contrib/entity/views/plugins/entity_views_plugin_row_entity_view.inc','e489ca209c66b76228383864b8267067e7cf3a1e375d9a195339f89932fed71f'),('sites/all/modules/contrib/entitycache/entitycache.test','8a798ccc0e618f9325e8074e448d2e1176c205690fd2666e1d5f8bab8ab5d3d3'),('sites/all/modules/contrib/entitycache/includes/entitycache.comment.inc','baa551bd73feeda9c736c08a1bd04c97cc75b5487e8c486a0142b62b8cac31e6'),('sites/all/modules/contrib/entitycache/includes/entitycache.defaultentitycontroller.inc','a8bb4bb3561545f862f0cf91cd894eb53ac4ec102881c3e647e0ecb8862a51e7'),('sites/all/modules/contrib/entitycache/includes/entitycache.entitycachecontrollerhelper.inc','a5ef82407da697f2c03bc00724ad32130fd3a74d559cfe30b41e70af7f595248'),('sites/all/modules/contrib/entitycache/includes/entitycache.node.inc','3d4ec0198171ec0bb54d852464f47c5857152fb59ef67e616bbe6a76c14f30e0'),('sites/all/modules/contrib/entitycache/includes/entitycache.taxonomy.inc','8c0022cfbb932e01e7afaaffe947dcc05a44f80051f9866700bc36bafe564b45'),('sites/all/modules/contrib/entitycache/includes/entitycache.user.inc','56fb6ade28df10130560c20d6472798235ff961beb8930a0e080c687321867ed'),('sites/all/modules/contrib/entity_boxes/entity_boxes.admin.inc','54bccabe87c14eda4b6cdf7b93afe1e16e6a30d99e811533513f2402a1e8fc43'),('sites/all/modules/contrib/entity_boxes/entity_boxes_type.admin.inc','7e9c4e10abfffe3b6316289adaa8c3e5d77fd8293eea1fd46c7ff74e8fb0742b'),('sites/all/modules/contrib/entity_boxes/views/entity_boxes.views.inc','e59335a4b28dd786997bec232f3041282c3841c99129870f6d1c26f1b11d745f'),('sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_delete_link_field.inc','aeeb640d279d03a2e41fcd8609ae843bb7823d44d6ff29a92280e11ca8aa71c8'),('sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_edit_link_field.inc','bd70d57063980df3535175c139f37eea1367bd85ca88f53fc5ce2342b786d5ca'),('sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_entity_boxes_operations_field.inc','fa268bf908aa68b1c1353e2bec80ce1ea35ec82443567c96b444855f326d030b'),('sites/all/modules/contrib/entity_boxes/views/entity_boxes_handler_link_field.inc','9ab5783035a1d9ef3b2bd14ed29205f5b3333ad9719b8af335a1bf2243ad5c57'),('sites/all/modules/contrib/features/tests/features.test','5fc1c5733eb4c76c32f1a79736c064f1f89001f7987eb7bf183c8d438c8f8baf'),('sites/all/modules/contrib/field_group/tests/field_group.display.test','68b48634e0311fb4a804d39d8c03acc3de868719df0f4cca495c81e9de4e2035'),('sites/all/modules/contrib/field_group/tests/field_group.ui.test','17486a055b85febf5cc55cdb638bf104ef3acab75b76735763650217dd5ab9d4'),('sites/all/modules/contrib/google_analytics/googleanalytics.test','e209d4647220fdd34fe165fb34d6a679b3e417645ba642268c72eae4f8412798'),('sites/all/modules/contrib/libraries/tests/LibrariesAdminWebTest.test','933af00ee9ad342999e20c0a82440ab04933b5d7713ffe2e7371a9af15492bf5'),('sites/all/modules/contrib/libraries/tests/LibrariesLoadWebTest.test','4cfaf88ce29e72f8ecd52b02cc9f7bac2ea60a715530cd9ff4fea929dac161ee'),('sites/all/modules/contrib/libraries/tests/LibrariesUnitTest.test','08139d770447993484828d0a642b6a771314c74e392074e94c2b7dcebc10b093'),('sites/all/modules/contrib/libraries/tests/LibrariesWebTestBase.test','056dfdd67ac9d6a84ffbe0f507e165fd6f07a0c82c3c7efbc1874e870e85e83a'),('sites/all/modules/contrib/link/link.migrate.inc','0a17ff0daa79813174fff92e9db787e75e710fe757b6924eec193c66fe13f3df'),('sites/all/modules/contrib/link/link.module','39bc7a76730d855c17544d4a67ef6dbf3e018b74bc2f2b5d2431b6a370e1da3d'),('sites/all/modules/contrib/link/tests/link.attribute.test','92c76292e0b2f74ef21d6bca563cf5d47d0331d72bacc454a550c6ace51697cc'),('sites/all/modules/contrib/link/tests/link.crud.test','de19e2c5e8c6cb02f25d7051bdd1db77852379ac59ce8185c25b4bf927478f22'),('sites/all/modules/contrib/link/tests/link.crud_browser.test','13da1fde2aa1c45ec11c8b343004d116aed074789a5b46f8dd6b299781e9755d'),('sites/all/modules/contrib/link/tests/link.entity_token.test','e3c414eb7bdc1a27b8408446ded03b77c52b3419f38f6a3d3ada68effda4b616'),('sites/all/modules/contrib/link/tests/link.test','fe5d8cd577fbfc07929e7216e115530a28777ace9b7135fbc853a3a78d550456'),('sites/all/modules/contrib/link/tests/link.token.test','74d2a9888005d08fba8c6d3720592a4d9dffa5d30a25fee1714ce89fa0688041'),('sites/all/modules/contrib/link/tests/link.validate.test','ff8a018f4ecf621e8f5f0fdec7c8d505305778c615ef17a84c7542bee0e29c47'),('sites/all/modules/contrib/link/views/link_views_handler_argument_target.inc','d77c23c6b085382c63e7dbce3d95afc9756517edcdc4cd455892d8333520d4c9'),('sites/all/modules/contrib/link/views/link_views_handler_filter_protocol.inc','e10a0d2de73bfa9a56fadbac023c6ac16022ced40c0444ab6ffed1b5d7ea7358'),('sites/all/modules/contrib/memcache/tests/memcache-lock.test','db8644e50838306bc8f969c71a02735bafde361435ae0dfe491c1bc3035f4839'),('sites/all/modules/contrib/memcache/tests/memcache-session.test','13f9f958b927b13ad1b08a4ac2d68e115f2af74a5eb2dd69d72860d0cad095ac'),('sites/all/modules/contrib/memcache/tests/memcache.test','3f533eb03321ddde3fb7aba795b4b18a67dcea9ff6d5e1c49a2cac4dd8223a13'),('sites/all/modules/contrib/nodequeue/tests/nodequeue.test','6c25980f46c413023e9a647cd337126e84404ad1f8554efdb681d44a78127e6b'),('sites/all/modules/contrib/node_reference_box/node_reference_box.module','8a02614dadeaa026e7cdebcc6641d3992b5d341ededd0bf9968136000103449f'),('sites/all/modules/contrib/node_reference_box/plugins/node_reference_box.inc','44f03d5ec4ed2ef4e3ea6addfe395cae8a906d13a8017b339684ffd81a270ff0'),('sites/all/modules/contrib/omega_tools/includes/omega_tools.admin.inc','d66aa6aad3f09b1bbc788144608245160ce2111ec04a79bfc4f1ff32d866981c'),('sites/all/modules/contrib/omega_tools/includes/omega_tools.drush.inc','2de6a551cac27eea5b1469cdeac7e5607cdded83b98615f2652d66f8cd5230f7'),('sites/all/modules/contrib/omega_tools/includes/omega_tools.wizard.inc','4dcf14f86f2d152d3dd2c8c0d005d2a9945c0eedf348a0643f978fd989e66362'),('sites/all/modules/contrib/omega_tools/omega_tools.module','e4a9a16223e295e45b99ed2291a4e55cbd33ed212b136c83befb461a4c2b3d53'),('sites/all/modules/contrib/override_node_options/override_node_options.test','7a9e6fc3c562dc0404066186fc8b8272eaccd6489c82eca15ef937517976aacd'),('sites/all/modules/contrib/password_policy/contrib/password_tab/password_policy_password_tab.test','77d37ba7492753dc7aba27edacac3178f6532585e76ee613434408a1b0bde10d'),('sites/all/modules/contrib/password_policy/tests/password_policy.test','565c4cde7efa96910ab47cc1104ce768306c6ba9489a04f4544dd1b75dfd93a5'),('sites/all/modules/contrib/password_policy/tests/password_policy_expiration.test','4a2b22b780fd68709359a4692208bc9be2ac66cffb2afcde749c60acfb57096b'),('sites/all/modules/contrib/pathauto/pathauto.migrate.inc','31084f25620be5620aecf9d60356dba662b6eda426c0c94ba996821110e4b1cc'),('sites/all/modules/contrib/pathauto/pathauto.test','1297560df48bad9b325d775d3bc64a411c03a0fd630c5e53ff8e46c4550a6977'),('sites/all/modules/contrib/pathauto_persist/pathauto_persist.test','8b20b282fe489c1b2479ae124b78fdb5dfee0a5646b63aad341f66e78be22003'),('sites/all/modules/contrib/references/node_reference/node_reference.test','69f352e6eaddd471301a292b74ae8dd281b53283112b9823d9fec3a51fd1310a'),('sites/all/modules/contrib/references/views/references_handler_argument.inc','231031508b499e882e2b80e66c000c38577ed9a64975ea43d0b7441bff1a98d3'),('sites/all/modules/contrib/references/views/references_handler_relationship.inc','e67c5293c59c179005999d67465946793b99f92b5c9421bc5346eaf9dfea14db'),('sites/all/modules/contrib/references/views/references_plugin_display.inc','c0abab2ec372f0c5382ec2fc48593d635806be65e0e806874f095315b8a87896'),('sites/all/modules/contrib/references/views/references_plugin_row_fields.inc','2bff7a5f9a7357f8618b514a437807156d940ba76fceb34720d2a1de10a6b679'),('sites/all/modules/contrib/references/views/references_plugin_style.inc','b0dad018a03974bde55d6b20d50a33187a856d59b42cb57287cf3b5644428f4d'),('sites/all/modules/contrib/seckit/seckit.test','0b69bc869a662a4c932dbb8e9ed2e85b384b6a8bff88681ae42df438a7903ae7'),('sites/all/modules/contrib/services/servers/rest_server/tests/ServicesRESTServerTests.test','3bbef5971279ef1e52214d8cff146f980a227f5635bd93279cd3c87adf9159df'),('sites/all/modules/contrib/services/tests/functional/NoAuthEndpointTestRunner.test','c2563cd96d0345f6678683489e39a596ea4c63809b64c1c0e75110622ec0b6ab'),('sites/all/modules/contrib/services/tests/functional/ServicesAliasTests.test','888e9239d567775b348d6ae528cc11c5a3e7a9cad1fe95109cdd4824cdeaeba7'),('sites/all/modules/contrib/services/tests/functional/ServicesArgumentsTests.test','90aad776578d77b2158e8bb949a36eec7fd5bb0316ccb1663d1de939a47a8ff0'),('sites/all/modules/contrib/services/tests/functional/ServicesEndpointTests.test','7e11aaa489828373a3070976b8afe306beb6e9dcb39794f1eda3ee81077a165a'),('sites/all/modules/contrib/services/tests/functional/ServicesParserTests.test','aaccbaeeb28610fb5d8bbb6f29cae5c54382de37561f818fa461a4c97c032338'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceCommentTests.test','b01a746620ad146fb8e46ac2bd933f87f76e6273ca355ff7b17149d23a558f62'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceDisabledTests.test','2624c05b293b7b2c17d81afa1356269d31d51a53ae24e539ba34be905bb1c480'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceFileTests.test','332ff471ad6011b52068aa4fc5aee98629c7759292ddbd4a92fe452e366df172'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceNodeTests.test','072cdc125c55991b89aca5ac3b639779e22926c23280754105ce2abf08fd59ab'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceSystemTests.test','4c7bed23294a4d07ebe5fec153e476e25905f8fd7bae7538b0a0daa27d102dac'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceTaxonomyTests.test','fdf005ceeaaa9e9f86c79d4edaf4660434a344bd6c42af54e3bbadcd834ebf20'),('sites/all/modules/contrib/services/tests/functional/ServicesResourceUserTests.test','8baf6702ad5d38672109831db660a14a3617d2ff478b007e527c5f13767fda4f'),('sites/all/modules/contrib/services/tests/functional/ServicesSecurityTests.test','661ac86d86337b0cebe812ebd52ae65148d5c9c38c15d3984af67fe3780349a8'),('sites/all/modules/contrib/services/tests/functional/ServicesVersionTests.test','9931b0e921a7999c1d6bace48d93667919bd82f8bbecdfa5d7d5754909303f6c'),('sites/all/modules/contrib/services/tests/functional/ServicesXMLRPCTests.test','86c2a78c8be5be82639ebea7951ce025f7ae0e1499afe8f407923dee3a934e24'),('sites/all/modules/contrib/services/tests/services.test','c64854d76ceccc6f85c0a115d40db05b8846e47355991ecd89da3faac8919351'),('sites/all/modules/contrib/services/tests/ui/ServicesUITests.test','6ed160c052ed656c20851c9cb62b9144ff798362afac2546ed0c7fedf945c543'),('sites/all/modules/contrib/services/tests/unit/ServicesSpycLibraryTests.test','e9fbeac1f1dfb0a79eb57f4f49818dff4f9ebbd2d07ec7b59e8699d0eaeac601'),('sites/all/modules/contrib/smtp/tests/smtp.unit.test','60706eb6c4a31d7887439ef80bf0dc1f39ecd845012e41210229e8654b4a9a05'),('sites/all/modules/contrib/strongarm/strongarm.admin.inc','5e50651c629ba2bdc71f73051cd876e91f76d523d6fd4ad1d6d66d1f092d3af4'),('sites/all/modules/contrib/strongarm/strongarm.install','d198563f5fcc7a1b4b9a98c1ed8439d48a6d7d10577cc966d3a55edd06a4a365'),('sites/all/modules/contrib/strongarm/strongarm.module','3e338f1099aff4e501ad99d76bb179aafcc086760d222bbc1bd89fef0bb1c8e5'),('sites/all/modules/contrib/token/token.test','79c44cc6bb46caa41eaf371df9c77d7ef98bbee7d96c04ca1039375dc6674961'),('sites/all/modules/contrib/views/handlers/views_handler_area.inc','95d4374c805c057c9855304ded14ce316cdee8aca0744120a74400e2a8173fae'),('sites/all/modules/contrib/views/handlers/views_handler_area_messages.inc','de94f83a65b47d55bbb4949fcf93dd4ad628a4a105cea2b47cdc22593f3e5925'),('sites/all/modules/contrib/views/handlers/views_handler_area_result.inc','836747c024cc153ec4516737da0c42a864eb708e0b77d2f8ba606411c57356a2'),('sites/all/modules/contrib/views/handlers/views_handler_area_text.inc','531d0ac3b64206970593762df0abac60524f607253c3af876dd66ba747786dce'),('sites/all/modules/contrib/views/handlers/views_handler_area_text_custom.inc','35b702060c192b0adf6601ed437d0a02effd3accb71c07d6156013c8be9d5a15'),('sites/all/modules/contrib/views/handlers/views_handler_area_view.inc','e604b5716d9ea202ab0b8e51d2bd0a4a8eeab461db0a74bf37745d6cbba25c41'),('sites/all/modules/contrib/views/handlers/views_handler_argument.inc','1f0498d1878e331f59b9f0cc87b67df330437c736e565a05fe1a14ab65ec3f26'),('sites/all/modules/contrib/views/handlers/views_handler_argument_date.inc','1b423d5a437bbd8ed97d0bfb69c635d36f15114699a7bc0056568cc87937477d'),('sites/all/modules/contrib/views/handlers/views_handler_argument_formula.inc','5a29748494a7e1c37606224de0c3cac45566efe057e4748b6676a898ac224a61'),('sites/all/modules/contrib/views/handlers/views_handler_argument_group_by_numeric.inc','b8d29f27592448b63f15138510128203d726590daef56cf153a09407c90ec481'),('sites/all/modules/contrib/views/handlers/views_handler_argument_many_to_one.inc','b2de259c2d00fe7ed04eb5d45eb5107ce60535dd0275823883cc29b04d1a3974'),('sites/all/modules/contrib/views/handlers/views_handler_argument_null.inc','26699660fd0915ec078d7eb35a93ef39fd53e3a2a4841c0ac5dbf0bb02207bee'),('sites/all/modules/contrib/views/handlers/views_handler_argument_numeric.inc','ae23d847fa0f1e92baec32665a8894e26660999e338bebffb49ee42daac5a063'),('sites/all/modules/contrib/views/handlers/views_handler_argument_string.inc','f8fe4daf0a636cc93d520a0d5ff212840d8bdaa704ddc3c59a24667f341ed3a1'),('sites/all/modules/contrib/views/handlers/views_handler_field.inc','3d059d737e738436a15651f9ac8374f460a71eb569619ba0a8a14a55a3efc87e'),('sites/all/modules/contrib/views/handlers/views_handler_field_boolean.inc','dc00b916a223935e05f51d94a2dffbaf430b162517072f7c2122332af41e8fc2'),('sites/all/modules/contrib/views/handlers/views_handler_field_contextual_links.inc','2f54701c9f71a4a525e724a6787b5e0089a3c38e426d1925bf8344d017d571bf'),('sites/all/modules/contrib/views/handlers/views_handler_field_counter.inc','865a5ad7df830dae9e167709446e66cebf3e32e91ec05b5c2b887c96d0d6b0d8'),('sites/all/modules/contrib/views/handlers/views_handler_field_ctools_dropdown.inc','a78c424ef884ae9878c0b140d532bdf3b116fdc0e8a7cd519848c675d5b1a5a6'),('sites/all/modules/contrib/views/handlers/views_handler_field_custom.inc','a3d25fc20401ae0a1af4b7d6e83376a5b7dc18ab0aed17a3c6d81e2314cf19f8'),('sites/all/modules/contrib/views/handlers/views_handler_field_date.inc','79cb6583981104d70d20393fe62281c749680f375cb67355635ef00688258934'),('sites/all/modules/contrib/views/handlers/views_handler_field_entity.inc','909ab36aff896ad8fa4306d95a052172ec27e471ab385a035fcadef8d019e0f9'),('sites/all/modules/contrib/views/handlers/views_handler_field_links.inc','331a7c8e68a9a94a41a0d7e3e2b6a5c8436792cf244b409ffd732f9cbbab3642'),('sites/all/modules/contrib/views/handlers/views_handler_field_machine_name.inc','df2fe47cf9c6d2e7de8627c08da809fb60883c38697340966f303c223e22aee4'),('sites/all/modules/contrib/views/handlers/views_handler_field_markup.inc','a0c652fdf47f7efe35bbf2371f00e230409fe90ea0038eb101bf0c93ae0718e9'),('sites/all/modules/contrib/views/handlers/views_handler_field_math.inc','08c9fb88b20ca346ee3dc29773b2341ea294ba85b659dbd8c1cc92a9ddf900e8'),('sites/all/modules/contrib/views/handlers/views_handler_field_numeric.inc','1e36f9d55b4cfeb268068e5c9bd6f326999c04191485d3db4610e94e6f57fad9'),('sites/all/modules/contrib/views/handlers/views_handler_field_prerender_list.inc','0fe605bf457886fbca5f041a422fc51c6a1927654dcd06cbfc619496fe57de0e'),('sites/all/modules/contrib/views/handlers/views_handler_field_serialized.inc','ad3d82a9f37ae4c71a875526c353839da2ff529351efc7861f8b7c9d4b5a47db'),('sites/all/modules/contrib/views/handlers/views_handler_field_time_interval.inc','280d569784312d19dabfb7aeb94639442ae37e16cba02659a8251de08a4f1de2'),('sites/all/modules/contrib/views/handlers/views_handler_field_url.inc','7ca57a8dcc42a3d1e7e7ec5defa64a689cb678073e15153ff6a7cafe54c90249'),('sites/all/modules/contrib/views/handlers/views_handler_filter.inc','b21fbc12bf620db26d391ac0f9e12f5076bbd188c8086c593187365d70bb2861'),('sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator.inc','f4ca59e4e1f91f219a1b33690a4ad412269946804fe7cacf24f2574b2c6d8599'),('sites/all/modules/contrib/views/handlers/views_handler_filter_boolean_operator_string.inc','0ddd32cda535112c187de1c062797849ff90d9b312a8659056e76d2d209f694a'),('sites/all/modules/contrib/views/handlers/views_handler_filter_combine.inc','802f033bba6a9965896b02e3c3e0ea4493e4be282f2c5444ebbeec7e8a478072'),('sites/all/modules/contrib/views/handlers/views_handler_filter_date.inc','fb63877ecfa64f2be8557a21dcf34e28b59c4a9c5f561f55738162d2301c4aa1'),('sites/all/modules/contrib/views/handlers/views_handler_filter_entity_bundle.inc','02db977a67a09f70bdc8e2bbc46a05fff8a6d8bd6423308c95418476e84714a3'),('sites/all/modules/contrib/views/handlers/views_handler_filter_equality.inc','2100cdd7f5232348adae494c5122ba41ff051eee0a8cc14aeaf6a66202cb7ed1'),('sites/all/modules/contrib/views/handlers/views_handler_filter_fields_compare.inc','e116c3796f1bd409b150f5ab896b9bab956d6e71a82e5770ed6fde44605751b2'),('sites/all/modules/contrib/views/handlers/views_handler_filter_group_by_numeric.inc','9401c4c0fe0d678898e5288ef8152784a12e0743df21dec15457353eb2cdb01d'),('sites/all/modules/contrib/views/handlers/views_handler_filter_in_operator.inc','8fd7f075468bddde5c4208b1c3a6105f8fea0ac0c214452a37c00fc2f3453a7d'),('sites/all/modules/contrib/views/handlers/views_handler_filter_many_to_one.inc','b4a415c2824195d3d7d0e37ada9d69ebec0b9cd833ebcac2439efc20aac15595'),('sites/all/modules/contrib/views/handlers/views_handler_filter_numeric.inc','8a999227d17674a70381ab8b45fbdc91269a83a45e5f7514607ed8b4a5bf6a9f'),('sites/all/modules/contrib/views/handlers/views_handler_filter_string.inc','140006335ac5b19b6253b431afde624db70385b9d22390b8c275296ae469cc7b'),('sites/all/modules/contrib/views/handlers/views_handler_relationship.inc','4fefdb6c9c48b72dcfe86484123b97eb5f5b90b6a440d8026d71f74dccbd1cd6'),('sites/all/modules/contrib/views/handlers/views_handler_relationship_groupwise_max.inc','47dcfe351159b10153697c17b3a92607edb34a258ba3b44087c947b9cc88e86f'),('sites/all/modules/contrib/views/handlers/views_handler_sort.inc','06aab8d75f3dce81eb032128b8f755bfff752dcefc2e5d494b137bca161fdefa'),('sites/all/modules/contrib/views/handlers/views_handler_sort_date.inc','d7e771abf74585bd09cc8e666747a093f40848b451de8ba67c8158317946f1b2'),('sites/all/modules/contrib/views/handlers/views_handler_sort_group_by_numeric.inc','4ba1c38c9af32789a951b8f9377e13631ae26bf1dac3371b31a37ead25b32eb8'),('sites/all/modules/contrib/views/handlers/views_handler_sort_menu_hierarchy.inc','ccd65ea3b3270366b7175e2cd7cc9167a09c27e1486949e4a05495ff5c7be5c1'),('sites/all/modules/contrib/views/handlers/views_handler_sort_random.inc','05a00c3bf76c3278ae0ce39a206a6224089faf5ac4a00dd5b8a558f06fab8e46'),('sites/all/modules/contrib/views/includes/base.inc','5ad8155dbc31cc4460b65747d99b70a64a83f6fefa00231c8d965293a7a183ee'),('sites/all/modules/contrib/views/includes/handlers.inc','2f1a8ab8dad27856cf7fc14ef59314ded0722dfe06152bd8a8bd7caaea363518'),('sites/all/modules/contrib/views/includes/plugins.inc','11c03b1c69be7e9969ec0665b07ddfe170c9505f8d4e862cb27f1232a2a4240e'),('sites/all/modules/contrib/views/includes/view.inc','c11ed134250ed074b7ac2ed21d6ae28ba84ec663407dc4ceebcf15b078ce69ce'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_category_cid.inc','97acf41d6694fd4451909c18b118f482db9f39aa4b8c5cfa75d044d410c46012'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_fid.inc','c37def91d635b01db36809141d147d263cc910895e11c05e73d703e86b39fd43'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_argument_aggregator_iid.inc','344f2806344d9c6356f2e19d297522f53bab7a4cebdf23c76d04c85c9e0a0d8e'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_category.inc','252b30b832d8c0097d6878f5d56beecfc8cc1fc7cc8b5a4670d8d95a80b4f17d'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_title_link.inc','1bb18967b11f2f4de62075d27e483f175b5e3431622c2e5e8292afcd000beadf'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_field_aggregator_xss.inc','2db2e1f0500e0a252c7367e6a92906870b3247f9d424f999c381368ee2c76597'),('sites/all/modules/contrib/views/modules/aggregator/views_handler_filter_aggregator_category_cid.inc','7c7c0690c836ac1b75bca3433aca587b79aec3e7d072ce97dc9b33a35780ad4f'),('sites/all/modules/contrib/views/modules/aggregator/views_plugin_row_aggregator_rss.inc','591e5bb7272e389fe5fc2b563f8887dbc3674811ffbb41333d36a7a9a1859e56'),('sites/all/modules/contrib/views/modules/book/views_plugin_argument_default_book_root.inc','bd3bd9496bf519b1688cf39396f3afa495a29c8190a3e173c0740f4d20606a53'),('sites/all/modules/contrib/views/modules/comment/views_handler_argument_comment_user_uid.inc','5e29f7523010a074bda7c619b24c5d31e0c060cdbe47136b8b16b2f198ed4b4a'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment.inc','a126d690cc5bf8491cb4bee4cc8237b90e86768bebbbecb8a9409a3c1e00fa9e'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_depth.inc','1dc353a31d3c71c67d0b3e6854d9e767e421010fbbf6a8b04a14035e5f7c097f'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link.inc','1f7382f7cb05c65a7cba44e4cd58022bbc6ce5597b96228d1891d7720510bf0e'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_approve.inc','f6db8a0b4dd9fffba9d8ecb7b7363ba99d3b2dc7176436a0a6dd7a93195a5789'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_delete.inc','905a4cb1f91a4b40ee1ca1d1ded9958ae18e82286589fec100adb676769b1fe9'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_edit.inc','8139c932cde20f366a3019111c054b1ed00dbc0c40634b91239b400243b7723a'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_link_reply.inc','8807884efb840407696c909b9d5d07f60bde9d7f385a59eca214178ce5369558'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_node_link.inc','64746ff2b80a5f8e83b996a325c3d5c8393934c331510b93d5815ea11c1db162'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_comment_username.inc','1ce3fa61b3933a3e15466760e4c5d4a85407ba4c8753422b766fc04395fa4d02'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_last_comment_timestamp.inc','30c55ec6d55bf4928b757f2a236aab56d34a8e6955944a1471e9d7b7aed057c0'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_comment_name.inc','82025f3ad22b63abc57172d358b3f975006109802f4a5ecac93ce3785c505cae'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_ncs_last_updated.inc','facfbc5defd843f4dfb60e645f09a784234d87876628c8de98d2dfa6bb98a895'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_node_comment.inc','0cf9e8fb416dca35c3b9df3125eb3a8585f798c6a8f8d0e1034b1fccb5cec38b'),('sites/all/modules/contrib/views/modules/comment/views_handler_field_node_new_comments.inc','e0830d1f70dea473e46ab2b86e380ef741b2907f033777889f812f46989f2ff7'),('sites/all/modules/contrib/views/modules/comment/views_handler_filter_comment_user_uid.inc','f526c2c4153b28d7b144054828261ba7b26566169350477cd4fb3f5b5f280719'),('sites/all/modules/contrib/views/modules/comment/views_handler_filter_ncs_last_updated.inc','9369675dfee24891fe19bddf85a847c275b8127949c55112ae5cb4d422977d24'),('sites/all/modules/contrib/views/modules/comment/views_handler_filter_node_comment.inc','70706c47bad9180c2426005da6c178ed8d27b75b28cb797ca2a1925a96dcef09'),('sites/all/modules/contrib/views/modules/comment/views_handler_sort_comment_thread.inc','a64bc780cba372bd408f08a5ea9289cdf3d40562bdf2f7320657be9a9f6c7882'),('sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_comment_name.inc','9f039e8b8a046c058fda620804e3503be7b3e7e3e4119f0b015ccbae0922635b'),('sites/all/modules/contrib/views/modules/comment/views_handler_sort_ncs_last_updated.inc','fa8b9c3614ad5838aa40194940d9dc6935175a16e141ac919f40e74a7428c4e3'),('sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_rss.inc','96f651234e30a3aff805ae9a524c99813a286bf75b5a9fd8da2d7d4fbec50810'),('sites/all/modules/contrib/views/modules/comment/views_plugin_row_comment_view.inc','82d7296fa3109ca170f66f6f3b5e1209af98a9519bb5e4a2c42d9fc0e95d7078'),('sites/all/modules/contrib/views/modules/contact/views_handler_field_contact_link.inc','ec783b215a06c89c0933107a580c144051118305dd0129ac28a7fea5f95a8fd5'),('sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list.inc','eff5152a2c120425a2a75fe7dbcb49ed86e5d48392b0f45b49c2e7abee9fa72b'),('sites/all/modules/contrib/views/modules/field/views_handler_argument_field_list_string.inc','534af91d92da7a622580ab8b262f9ef76241671a5185f30ba81898806c7b7f15'),('sites/all/modules/contrib/views/modules/field/views_handler_field_field.inc','94ff7382dba773fc637c777e20b810ae7d4aa4936fb0bc067e6a3824ba929d2d'),('sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list.inc','3b55cd0a14453c95ebd534507ab842a8505496d0b7e4c7fcd61c186034c7322d'),('sites/all/modules/contrib/views/modules/field/views_handler_filter_field_list_boolean.inc','d33035e141ca686b3f18da1e97adaa1ff8e5d1db266340d3030e873a744685e2'),('sites/all/modules/contrib/views/modules/field/views_handler_relationship_entity_reverse.inc','060035c5430c81671e4541bcf7de833c8a1eb3fa3f3a9db94dd3cebfa4299ef1'),('sites/all/modules/contrib/views/modules/filter/views_handler_field_filter_format_name.inc','fc3f074ffb39822182783a8d5cf2b89ffcc097ccbb2ed15818a72a99e3a18468'),('sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_group.inc','c8545411096da40f48eef8ec59391f4729c884079482e3e5b3cdd5578a1f9ad7'),('sites/all/modules/contrib/views/modules/locale/views_handler_argument_locale_language.inc','a1b6505bb26e4b3abce543b9097cd0a7b8cddf00bf1e49fbba86febebb0f4486'),('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_group.inc','5b62afe18f92ee4a5fb49eb0995e65b4744bbe3b9c24ffe8f6c21f3191c04afc'),('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_language.inc','0cc08bd2d42e07f26e7acc92642b36f0ac62bf23ee9ba3fd21e6cab9a80e9f72'),('sites/all/modules/contrib/views/modules/locale/views_handler_field_locale_link_edit.inc','3883d3f37030d6d8e397e79ccb99ec3cb715ba7a789510f4b79b7515e314e7ae'),('sites/all/modules/contrib/views/modules/locale/views_handler_field_node_language.inc','a6ccdb6c1c4df3b4fd31b714f5aa4ac99771ffce63439d6c5de6c0ae2f09a2c1'),('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_group.inc','40fbc041bab64f336f59d1e0593f184b879b2a0c9e2a6050709bdc54cceb2716'),('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_language.inc','3433893d988aad36b918dd6214f5258b701506bc9c0c6a72fd854a036b635e20'),('sites/all/modules/contrib/views/modules/locale/views_handler_filter_locale_version.inc','9337ea5216784ffc67a0aa45c946e65ad11fc40849189cc70911a81366b78620'),('sites/all/modules/contrib/views/modules/locale/views_handler_filter_node_language.inc','d7edea3f35891cc76aa3bb185b9c1404378623ea7fd214c2a1f0d824df12779a'),('sites/all/modules/contrib/views/modules/locale/views_handler_sort_node_language.inc','b7b70efcf7de1f4dee4722ac8aa16031f17d62e60b1b5772f9985cadf91e4415'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_dates_various.inc','d2c17e6ec3d221bdd0d1c060da4b0c85274c8ac5a0b624b1469b162694a8d0f5'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_language.inc','7ee3ba02bddaa6aeef9961cdf6af7bb386fc2b12529f095b28520bb98af51775'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_nid.inc','11c5b62413ffd1b2c66d4b60a2fe21cf6eb839ae40d4ef81c7a938c5be3e30de'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_type.inc','9e21b4cc4ae861f58c804ea7e2c17fbc5dd2a7938b9abfeb54437b531fc95e6e'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_uid_revision.inc','675c99f8da9748ac507e202f546914bee3ed4065f6ce83a23a2aaafdaefd084e'),('sites/all/modules/contrib/views/modules/node/views_handler_argument_node_vid.inc','7e5da5594a336c1d0f4cf080ab3fcd690e0de1ee6b5e1830b5fb76a46bced19c'),('sites/all/modules/contrib/views/modules/node/views_handler_field_history_user_timestamp.inc','7d6d9c8273d317ab908d4873a32086dbd5f78a2b2d07b7ed79975841a2cadea6'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node.inc','99a0ef52b68e8913eb3563d5c47097c09e46c6493fcb006f383c6f6798edb7fc'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link.inc','26d8309a3a9140682d7d90e4d16ff664a3d7ce662af6ccbf75dc4c493515d7d9'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_delete.inc','3eeed8c9ffc088ee28b8ffaa5e2b084db24284acc4d1b2e69f90c96cc889016d'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_link_edit.inc','28f8c3b7d3d60c31fec3cdf81c84cfbb20f492220457694a0e150c3ddee030c0'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_path.inc','f392fde21e434fd40fc672546ef684780179d91827350ba9c348bb1cc5924727'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision.inc','3f510d58acaa8f844292b86c388cb1e78eac8c732bb5e7c9e92439c425710240'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link.inc','ace72f296cf4a4da4b7dd7b303532aebf93b6b1c18a5d30b51b65738475e3889'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_delete.inc','0a36602f080c4ef2bb5cb7dbddc5533deab7743c2fbf3bd88b9e478432cac7fb'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_revision_link_revert.inc','80ddc7f0c001fde9af491bb22d6044b85324fe90bea611fc3822408fd60008fa'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_type.inc','f8f39c6f238f837270d1b2e42e67bf9ab400a37fe24246c8b86dfcfacc1c4fd9'),('sites/all/modules/contrib/views/modules/node/views_handler_field_node_version_count.inc','1298f7f7ee4b6e6e2957b266fbb7c63e102b9d7e9ccca8d5a86592736bce9493'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_history_user_timestamp.inc','2970f270e071cad079880e9598d9f7b71d4dd2a2a42a31cd4489029a3cafe158'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_access.inc','ca625167c8928f1c5b354c27c120ed9b19c1df665dc3b02ed6d96b58194d6243'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_status.inc','f7099a59d3f237f2870ecb6b0b5e49dd9d785b1085e94baf55687251e7f3231b'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_type.inc','6842082e7b6e131d6e002e627e6b4490b93ca6ffe7fc0b158d31843217c8c929'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_uid_revision.inc','2cfe9ba95e5ea8c240a57cfa1bed58385cbfed0c7f35e3d8c4da6d873b5a61fa'),('sites/all/modules/contrib/views/modules/node/views_handler_filter_node_version_count.inc','de61f3547604e5905486cdae5f5e94d1a45bdac4d3c43157193dd6fe0dd6473c'),('sites/all/modules/contrib/views/modules/node/views_handler_sort_node_version_count.inc','ce2a392319ebed3dbb2b660f3d6f4c6690b1cd46cf6b1c01802f12158114c4c4'),('sites/all/modules/contrib/views/modules/node/views_plugin_argument_default_node.inc','7fb79c8f4adb9bcef7c7da4bf4046fe3490e16c244f6ab96fdca97a8567315ff'),('sites/all/modules/contrib/views/modules/node/views_plugin_argument_validate_node.inc','f10d3f4081eed5ca32c41b67e9a0e6f35b2f8ba2cd7897230cb5a680b410a6de'),('sites/all/modules/contrib/views/modules/node/views_plugin_row_node_rss.inc','1e55454684102fad08c947695c370a890a22ea22c3c9aca3207f2299aa3daf7e'),('sites/all/modules/contrib/views/modules/node/views_plugin_row_node_view.inc','713e1c83702ac2d0d7fe76374110cdfd657598a8f3b086ec2352f2de38101504'),('sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_date.inc','e206509ef8b592e602e005f6e3fa5ba8ef7222bdb5bacd0aaeea898c4001e9b0'),('sites/all/modules/contrib/views/modules/profile/views_handler_field_profile_list.inc','da5fa527ab4bb6a1ff44cc2f9cec91cf3b094670f9e6e3884e1fedce714afe6f'),('sites/all/modules/contrib/views/modules/profile/views_handler_filter_profile_selection.inc','758dea53760a1b655986c33d21345ac396ad41d10ddf39dd16bc7d8c68e72da7'),('sites/all/modules/contrib/views/modules/search/views_handler_argument_search.inc','0a96f3a3201091b95a0ed3763a98ed290cdda8f10ff89b58d432d0523bbe6f83'),('sites/all/modules/contrib/views/modules/search/views_handler_field_search_score.inc','711af637c864b775672d9f6203fc2da0902ed17404181d1117b400012aac366f'),('sites/all/modules/contrib/views/modules/search/views_handler_filter_search.inc','5082e294639d5048e4167adcb9b2a43d0f1420e3c5c4284764fa9bc79e1f2bcc'),('sites/all/modules/contrib/views/modules/search/views_handler_sort_search_score.inc','9d23dd6c464d486266749106caec1d10cec2da1cc3ae5f907f39056c46badbdf'),('sites/all/modules/contrib/views/modules/search/views_plugin_row_search_view.inc','bc25864154d4df0a58bc1ac1148581c76df36267a1d18f8caee2e3e1233c8286'),('sites/all/modules/contrib/views/modules/statistics/views_handler_field_accesslog_path.inc','7843e5f4b35f4322d673b5646e840c274f7d747f2c60c4d4e9c47e282e6db37d'),('sites/all/modules/contrib/views/modules/statistics/views_handler_field_node_counter_timestamp.inc','a1de51345d268dc0f080104ff9ae4c9ca1f7a2dd45560a59630b2bb03bdc54c9'),('sites/all/modules/contrib/views/modules/statistics/views_handler_field_statistics_numeric.inc','b46b6b14e14631941ac2dc9baf0b1290c148f42801f05cb419f84a2091d03e40'),('sites/all/modules/contrib/views/modules/system/views_handler_argument_file_fid.inc','e9bf1fdf12f210f0a77774381b670c77ee88e7789971ce732b254f6be5a0e451'),('sites/all/modules/contrib/views/modules/system/views_handler_field_file.inc','0fff4adb471c0c164a78f507b035a68d41f404ab10535f06f6c11206f39a7681'),('sites/all/modules/contrib/views/modules/system/views_handler_field_file_extension.inc','768aa56198c7e82327391084f5dd27d7efdb8179ff6b8c941f892fe30469a0da'),('sites/all/modules/contrib/views/modules/system/views_handler_field_file_filemime.inc','bdd7f1255f3000f7f2900341d4c4ca378244b96390ef52a30db2962d017b61a4'),('sites/all/modules/contrib/views/modules/system/views_handler_field_file_status.inc','bfb0b9d796a4dbf95c4bb7a3deef7724bcda9e0d9067939b74ec787da934f2b0'),('sites/all/modules/contrib/views/modules/system/views_handler_field_file_uri.inc','350d7dde27ee97cb4279360374eb8633ce7fee115a109346bea85c2c4e3a68c2'),('sites/all/modules/contrib/views/modules/system/views_handler_filter_file_status.inc','9210a34795f9db36974525e718c91c03c28554da1199932791925d7c4a2f3b11'),('sites/all/modules/contrib/views/modules/system/views_handler_filter_system_type.inc','d27513703a75c4d8af79b489266cf4102a36e350c3d90404dab24403ab637205'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_taxonomy.inc','8962fa76f1e03316932468b0fd805817af94726beb82bf9f4786e0c709264662'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid.inc','79a80284231b3bc5aab36833e8200853686784f880dc6b104552d61fc602f27c'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth.inc','5b2806fbad4a6cc104e733a3a0faf6eb1c19975930c67c4149fb3267976e0b7d'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_join.inc','ca667646f99645c00e6dfb7eb52e2f54faf848be41c99af5caf2201dcd56926b'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_term_node_tid_depth_modifier.inc','d85ebe68290239b25fc240451655b825325854e9707cf742fbd75de81e0f1aa7'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_machine_name.inc','888647527bec3444b2d0a571a77900396d7c5e884bca04a2a3667a61f6377b5e'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_argument_vocabulary_vid.inc','bf4be783ef6899f004f4dbd06c1bf2cd6dbc322678c825eec36bee81d667e81f'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_taxonomy.inc','b0dd5cfa87c44b95aefd819444e4985c1773350bcf9fe073a2ef5c82b680b833'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_link_edit.inc','3da63f6feb1fa3312853b54585d761d037dac8841b4c06e01e35463c9098064a'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_field_term_node_tid.inc','29c5132ac98a2959405e44f9a83096b0dcfa30ed7fb4688453ca7e1fc779684b'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid.inc','3216febeeb3ab73ae29b77cb97b1d787394dd8cccacc32e13ab223db4fc044e9'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth.inc','0b05ec052dcc03081e20338808dda17beb0bdf869b0cfc1375ca96cfb758c22a'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_term_node_tid_depth_join.inc','76d59ca83bdcb40493055829a9132646ed89478d7eb6e468db2d879e66e3794c'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_machine_name.inc','f1787b436b914cfe5ca6f2575d4c0595f4f496795711d6e8a116a39986728b0a'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_filter_vocabulary_vid.inc','2a4d7dfbb6b795d217e2617595238f552bbea04b80217c933f1ee9978ceb7a0e'),('sites/all/modules/contrib/views/modules/taxonomy/views_handler_relationship_node_term_data.inc','2ef7502b02b7ea435ac166274c0e7b8576ef76353fc196a26ab79e9057b6da56'),('sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_default_taxonomy_tid.inc','fc4c3ace525162fc922de581af0710c7d92dc355e9630040a29a5c3a6ab7f9af'),('sites/all/modules/contrib/views/modules/taxonomy/views_plugin_argument_validate_taxonomy_term.inc','d1a7aa7ebd9c698afcdcf75b2f0affa981124064ff787ebc716bfac3ee0f60af'),('sites/all/modules/contrib/views/modules/tracker/views_handler_argument_tracker_comment_user_uid.inc','91f5b7e9537942eee7a1798906f772cb9806eebfdc201c54fcdecf027cd71d0f'),('sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_boolean_operator.inc','5efea908902052d68141017b6f29f17381e7bb8ebb6d88245471926f0a552207'),('sites/all/modules/contrib/views/modules/tracker/views_handler_filter_tracker_comment_user_uid.inc','05e07f74d1e3978afd4c80a9b4bd72444872b84a44949a512f1d3040ce28421c'),('sites/all/modules/contrib/views/modules/translation/views_handler_argument_node_tnid.inc','b0e3c87d3790cfa2e265f3d9700f2b3c2857932aa4b6e003e5d0114fc1b4d499'),('sites/all/modules/contrib/views/modules/translation/views_handler_field_node_link_translate.inc','27a1ac81b50d4807d9a1eff4c5dc8929e4472f9d363f70f5391a794db73424a2'),('sites/all/modules/contrib/views/modules/translation/views_handler_field_node_translation_link.inc','641ff25cd317bb803de2ace4bd23e8c5f5af5ba4ac38aab7be2fdc58fbb9e86a'),('sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid.inc','0942fd793740e3aec032a1abb7132f53788a9cdeaeb3d931cac908ac30b73950'),('sites/all/modules/contrib/views/modules/translation/views_handler_filter_node_tnid_child.inc','2a7a96d6caa4a99996549be0457bf40fa619731543a636d4573e55c190c64c7a'),('sites/all/modules/contrib/views/modules/translation/views_handler_relationship_translation.inc','9137c85f5ca309d4ee0d3243c470563a5853f5926b8cbd3e843438d4308c9516'),('sites/all/modules/contrib/views/modules/user/views_handler_argument_users_roles_rid.inc','72da80e7f3c6980da024d86f37ba3721021cc1ead2cfcc1ab9b27897b7b5077a'),('sites/all/modules/contrib/views/modules/user/views_handler_argument_user_uid.inc','a4af1bdc1ec5e40587c22c14e839980050baaa346c9d5934ef3f01794932cdc5'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user.inc','1a2141524e43d86b52c7828fe6df61dd603ad433743c1139cfc5cc28ccb5ce74'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_language.inc','5a3da9e08ebeebbcb5abc6a9b16e0d380c5bb5c57b608afb540a3ca6dc1b2959'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link.inc','5a0f35d5305a29816658385ecbd804bf43c92d4b3629fbe4bd9b8d0e9574b6ff'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_cancel.inc','b865881b15ce86b5a00f2892d3fc62f40131417527211275ff9a3d09d485750b'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_link_edit.inc','5d7c1155d9eccbd6b07c7446fe2b6a8848d6a500f508ac3779f16df56816f92b'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_mail.inc','b7355b704f19322afb4876cea27744367e20098d4ed973e480bf2baf1ddd111c'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_name.inc','5fd9a4d7843fee83cf529384a52d7ae69e40a9c8846e7f285e94f4bbbf8c7e29'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_permissions.inc','ec37373524bf23ae107adda6b825570c550e6654c0f0956409fc58df2c860903'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_picture.inc','0103d136a91fb219fd981801301b7df00adf90617900ded08efbf6d7df04959b'),('sites/all/modules/contrib/views/modules/user/views_handler_field_user_roles.inc','ab5068c4f01a05c6511f7d4b973a77650d5b5c481d4a73f63b7a9b1ef9c0d138'),('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_current.inc','7f70b7e3b3c10e75d95f54afc9c2fe2f1af9b7a9eab2308d2961b2588dc05845'),('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_name.inc','5225e5d89051313e0e49ea833709bb4dc44369afeee970b0cfaf1818ababa22c'),('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_permissions.inc','a72e8d02c1075cebfee33e5b046460eef9193b2a7c1d47ff130457e4485b6fe5'),('sites/all/modules/contrib/views/modules/user/views_handler_filter_user_roles.inc','3bb69fbc4e352ce8e4840ec78bdd0f1f29e8709097ce6b29cc2fedd2c74c023e'),('sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_current_user.inc','11e729115350deffe46ebfe3a55281fa169a90e38a76c3a9d98f26c87900a22b'),('sites/all/modules/contrib/views/modules/user/views_plugin_argument_default_user.inc','fe567f009a8e20f402f104b157fd44c04d6bd886a39b2f3355104f644f905419'),('sites/all/modules/contrib/views/modules/user/views_plugin_argument_validate_user.inc','40d623b0a678fa7c292da92582f06449d0396341ab161069f0fe8d1086ab95da'),('sites/all/modules/contrib/views/modules/user/views_plugin_row_user_view.inc','52548cca3f18d25b06cfce15ee00acea530b85bd22a10944d984b5a798c5969f'),('sites/all/modules/contrib/views/plugins/export_ui/views_ui.class.php','8cd921da4fc00f0441808c6d521fa9fdfc753976244518a001a6354975eb6fe8'),('sites/all/modules/contrib/views/plugins/views_plugin_access.inc','cc16bf7dc4c10eab382e948cfd91902ac1055514b627e3c50932376d3e3f1b91'),('sites/all/modules/contrib/views/plugins/views_plugin_access_none.inc','8e0a6b706c60abf63ab84d8624567ca12a5b80ad293e4334790065fbe6fa14d4'),('sites/all/modules/contrib/views/plugins/views_plugin_access_perm.inc','1807a9c91485a5abd3fb2f6590ed4bc185fdabe308db37b169be8abdfc30cab2'),('sites/all/modules/contrib/views/plugins/views_plugin_access_role.inc','8784836ea87ec6b0974125ed95ed6bbf6fdf91624f496f22c28e9229c695068d'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_default.inc','43e593760f0e8f031f2e7b861385caa5e39f37de400fe4595925288c78f52f23'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_fixed.inc','daaa3b59b54cbb11e411e010303f67a51348bb97a4e06997b475f4c41e91c4e0'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_php.inc','7a133b603294bfe498bfdeb50fade0b6e3cf8862270376067d86f69e7dc50eb8'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_default_raw.inc','4318e0dfa56f167183453cf8cd913f3b7ee539b77a096507905e36db12ded97e'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate.inc','2ada4fdc59b366f33209c0cfc515b06e765b487091760cfa22e94ca1c028c9cb'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_numeric.inc','c050d3b5723dbfdca9ad312c7fa198e509c626057b95eed326820ce733dd9730'),('sites/all/modules/contrib/views/plugins/views_plugin_argument_validate_php.inc','56a09922081a5e368d5796907727e35cbf43b0d634e53f947990c8a42d5b5f3e'),('sites/all/modules/contrib/views/plugins/views_plugin_cache.inc','b684e3ce1aeed33dd5e30f53527399a7a733d4cf1aae8acac9c6a2ca8b51b24b'),('sites/all/modules/contrib/views/plugins/views_plugin_cache_none.inc','a0d0ba252e1e2b65350c7ce648b97364726fa8ded5a366bfcce30c62daee4450'),('sites/all/modules/contrib/views/plugins/views_plugin_cache_time.inc','3a0a0f86f4f3d9a9d8b17accde4aa61150a627e3d782b96c6ab4d997c24fa94f'),('sites/all/modules/contrib/views/plugins/views_plugin_display.inc','89eebaf4d1ced12cd8bbfcd36cf2655a88a34b62b9c67750be73874fae2bc33f'),('sites/all/modules/contrib/views/plugins/views_plugin_display_attachment.inc','6124e2ec51eadd7500fb878c25d9c5044b4ae9b6323dbbaa40b4806b69dd4cc0'),('sites/all/modules/contrib/views/plugins/views_plugin_display_block.inc','0246e9010ff70d04c8bdf859eb4f8e7e8143c411d7b72f676cf00031dc8727a1'),('sites/all/modules/contrib/views/plugins/views_plugin_display_default.inc','91c6554d8f41f848bf30093d44d076051c54e998f6b50bdc2a922bfeeef9c54d'),('sites/all/modules/contrib/views/plugins/views_plugin_display_embed.inc','5424f2ea9e031faade7a562b8013aea193db5b0bc1be92b97bd7967de0d7bfff'),('sites/all/modules/contrib/views/plugins/views_plugin_display_extender.inc','75fb9f80e7f153715b911690c7140f251df588e6a541fab5881fbfafc0bbf778'),('sites/all/modules/contrib/views/plugins/views_plugin_display_feed.inc','f2fb6152e12da300b9bb8e1b45621dfe921c3ce0e769970ee1532e32a3657c53'),('sites/all/modules/contrib/views/plugins/views_plugin_display_page.inc','f7138a876ee88c50266d9fcb65f632d8d46d43d8152f760630cb11ae5e69afde'),('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form.inc','0632ce61b4e39f8c0f39866987e4908657020298520fcf7c2712c0135e77d95b'),('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_basic.inc','c736e1862b393e15ecc80deb58663405a1d68c2db07eb620d8e640406876cd17'),('sites/all/modules/contrib/views/plugins/views_plugin_exposed_form_input_required.inc','98b81e3b78f7242dd30a3754830bdde2fb1dfe8f002ae0daa06976f1bb64fa75'),('sites/all/modules/contrib/views/plugins/views_plugin_localization.inc','d7239cc693994dcd069c1f1e7847a7902c5bd29b8d64a93cdf37c602576661fb'),('sites/all/modules/contrib/views/plugins/views_plugin_localization_core.inc','f0900c0640e7c779e9b876223ea395f613c8fe8449f6c8eb5d060e2d54a6afcc'),('sites/all/modules/contrib/views/plugins/views_plugin_localization_none.inc','4930c3a13ddc0df3065f4920a836ffdc933b037e1337764e6687d7311f49dd8a'),('sites/all/modules/contrib/views/plugins/views_plugin_pager.inc','d7c32e38f149e9009e175395dff2b00ec429867653c7535301b705a7cc69d9ed'),('sites/all/modules/contrib/views/plugins/views_plugin_pager_full.inc','60e4dec532de00bf7e785e5fa29a0be43c7b550efa85df0346a1712a3c39f7cd'),('sites/all/modules/contrib/views/plugins/views_plugin_pager_mini.inc','0a9d101d5a4217fb888c643bfddd7bf7f2f9c0937faa2753a31452a5ee68190b'),('sites/all/modules/contrib/views/plugins/views_plugin_pager_none.inc','822cab1ada25f4902a0505f13db86886061d2ced655438b33b197d031ccceddd'),('sites/all/modules/contrib/views/plugins/views_plugin_pager_some.inc','bc6aa7cbf1bc09374eced33334195c8897e4078336b8306d02d71c7aaaa22c99'),('sites/all/modules/contrib/views/plugins/views_plugin_query.inc','0594d1fd0c34b86c6b81741e134da2d385d6be47b667af6660dd1d268fb7fa95'),('sites/all/modules/contrib/views/plugins/views_plugin_query_default.inc','cfb70855fde94bf257a9fef9f8cf34a37a3cc0e98196ee2c65edcd63aacedb7f'),('sites/all/modules/contrib/views/plugins/views_plugin_row.inc','3ca81529526b930cfb0dda202757f203649236b90441e3c035bb79cd419ee2a6'),('sites/all/modules/contrib/views/plugins/views_plugin_row_fields.inc','875fb2868cdbcc5f7af03098cbe55b9bb91ef512e5e52ccde89f7a02a0c5fbe2'),('sites/all/modules/contrib/views/plugins/views_plugin_row_rss_fields.inc','62f4a0ceef14aec9958ee8b98d352303f10818ddc66031814cc8b9d21752ade9'),('sites/all/modules/contrib/views/plugins/views_plugin_style.inc','015f7682a6535d0254e5b39edf22d95121eb41438d94a28c8659a2bc3a1ca237'),('sites/all/modules/contrib/views/plugins/views_plugin_style_default.inc','bf411e635d2fd9e09eb245b43581a0a7b670359180ccb042d42a5e579bbe9c30'),('sites/all/modules/contrib/views/plugins/views_plugin_style_grid.inc','35094b7f644b7e0692c9026b6b6b4c4c864c37fcdedef04b359dd2bdba496a47'),('sites/all/modules/contrib/views/plugins/views_plugin_style_jump_menu.inc','102fb3041a2f9a4ce9607a5bc2acc296ed625bee2fcbfa70354c1edd613066cd'),('sites/all/modules/contrib/views/plugins/views_plugin_style_list.inc','407b928d2c74a91903b681088bccce926d2268d0a9a6a34c185a4849dc0d7e31'),('sites/all/modules/contrib/views/plugins/views_plugin_style_mapping.inc','af4b75dd08f1597280a8deb6086259be4f10af50acace43ce2013170655f752c'),('sites/all/modules/contrib/views/plugins/views_plugin_style_rss.inc','ac72d530faffee78a1695a0b3893528ceb8451f18be0521c580485904a5ba57b'),('sites/all/modules/contrib/views/plugins/views_plugin_style_summary.inc','872df59f8f389eaf9b019e82d859dd198d31166e26a9102132e3932c7f1f2916'),('sites/all/modules/contrib/views/plugins/views_plugin_style_summary_jump_menu.inc','2ec0d225824ee65b6bb61317979e1dabe2be524a66ab19da924c6949dd31af3b'),('sites/all/modules/contrib/views/plugins/views_plugin_style_summary_unformatted.inc','c1e6f9dd1d75e29fee271171440d2182e633a1dbbc996cb186f637ff7ad93ed9'),('sites/all/modules/contrib/views/plugins/views_plugin_style_table.inc','0cbcc5d256a13953fbd3e5966a33d2426d5c3bd8c228ef370daebf2f428e693c'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_base_views_wizard.class.php','d8325414c8ddde5c955a5cfb053b77478bb4d73cb2f7d75b857b082bc5a1e12d'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_file_managed_views_wizard.class.php','5734fb564ba9e2485cfa5d4a49f0c76f65a9be357b78e769ee4af92c4ef9e22a'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_revision_views_wizard.class.php','6faf9ef92501a4f1aeaf86bcff9edaeb47bd7526ba50d06b841c9366149e7725'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_node_views_wizard.class.php','f10e588fcfe2dc37d0df1c520c3cd797b85d6f729335606b1aa11fcb5884e6eb'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_taxonomy_term_views_wizard.class.php','87d72dba2aef587994307cb287b638a409d148911e4b90109798ecacf5a721e7'),('sites/all/modules/contrib/views/plugins/views_wizard/views_ui_users_views_wizard.class.php','f9fe2fb1ee87a1871e6ad32bad61b2457313f24da1bd5423977ced12de542919'),('sites/all/modules/contrib/views/tests/comment/views_handler_argument_comment_user_uid.test','b8b417ef0e05806a88bd7d5e2f7dcb41339fbf5b66f39311defc9fb65476d561'),('sites/all/modules/contrib/views/tests/comment/views_handler_filter_comment_user_uid.test','347c6ffd4383706dbde844235aaf31cff44a22e95d2e6d8ef4da34a41b70edd1'),('sites/all/modules/contrib/views/tests/field/views_fieldapi.test','53e6d57c2d1d6cd0cd92e15ca4077ba532214daf41e9c7c0f940c7c8dbd86a66'),('sites/all/modules/contrib/views/tests/handlers/views_handlers.test','f94dd3c4ba0bb1ffbf42704f600b94a808c1202a9ca26e7bdef8e7921c2724e9'),('sites/all/modules/contrib/views/tests/handlers/views_handler_area_text.test','af74a74a3357567b844606add76d7ca1271317778dd7bd245a216cf963c738b4'),('sites/all/modules/contrib/views/tests/handlers/views_handler_argument_null.test','1d174e1f467b905d67217bd755100d78ffeca4aa4ada5c4be40270cd6d30b721'),('sites/all/modules/contrib/views/tests/handlers/views_handler_argument_string.test','3d0213af0041146abb61dcdc750869ed773d0ac80cfa74ffbadfdd03b1f11c52'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field.test','af552bf825ab77486b3d0d156779b7c4806ce5a983c6116ad68b633daf9bb927'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_boolean.test','d334b12a850f36b41fe89ab30a9d758fd3ce434286bd136404344b7b288460ae'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_counter.test','75b31942adf06b107f5ffd3c97545fde8cd1040b1d00f682e3c7c1320026e26c'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_custom.test','1446bc3d5a6b1180a79edfa46a5268dbf7f089836aa3bc45df00ddaff9dd0ce1'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_date.test','02df76a93a42d6131957748b1e69254835f9e44a47dafca1e833914e6b7f88a0'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_extension.test','606ca091ad7e5709f7653324aaa021484d1f0e07e8639b3f0f7c26d3cfdee53c'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_file_size.test','49184db68af398a54e81c8a76261acd861da8fd7846b9d51dcf476d61396bfb9'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_math.test','6e39e4f782e6b36151ceafb41a5509f7c661be79b393b24f6f5496d724535887'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_url.test','b41f762a71594b438a2e60a79c8260ba54e6305635725b0747e29f0d3ffe08c9'),('sites/all/modules/contrib/views/tests/handlers/views_handler_field_xss.test','f129ee16c03f84673e33990cbb2da5aa88c362f46e9ba1620b2a842ffd1c9cd2'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_combine.test','05842d83a11822afe7d566835f5db9f0f94fdb27ddfc388d38138767bdf36f8b'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_date.test','ad2ca901c6a4ac3a82fc349a33826f043c6c80f773f40374be2e95acb39491e3'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_equality.test','c88f21c9cbf1aae83393b26616908f8020c18fe378d76256c7ba192df2ec17af'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_in_operator.test','89420a4071677232e0eb82b184b37b818a82bdb2ff90a8b21293f9ecb21808bf'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_numeric.test','35ac7a34e696b979e86ef7209b6697098d9abe218e30a02cc4fe39fb11f2a852'),('sites/all/modules/contrib/views/tests/handlers/views_handler_filter_string.test','b7d090780748faad478e619fd55673d746d4a0cf343d9e40ea96881324c34cbd'),('sites/all/modules/contrib/views/tests/handlers/views_handler_sort.test','f4ff79e6bc54e83c4eb2777811f33702b7e9fe7416ef70ae00d100fa54d44fec'),('sites/all/modules/contrib/views/tests/handlers/views_handler_sort_date.test','f548584d7c6a71cabd3ce07e04053a38df3f3e1685210ce8114238fd05344c10'),('sites/all/modules/contrib/views/tests/handlers/views_handler_sort_random.test','4fdba9bf05a26720ffa97e7a37da65ddc9044bd2832f8c89007b82feb062f182'),('sites/all/modules/contrib/views/tests/node/views_node_revision_relations.test','9467497a6d693615b48c8f57611a850002317bcb091b926d2efbbe56a4e61480'),('sites/all/modules/contrib/views/tests/plugins/views_plugin_display.test','4a6b136543a60999604c54125fa9d4f5aa61a5dcc71e2133d89325d81bc0fc2d'),('sites/all/modules/contrib/views/tests/styles/views_plugin_style.test','d38f553c625a1eee5527dcef0bd1087374555dc0643bc2329dec594dc8a75bf1'),('sites/all/modules/contrib/views/tests/styles/views_plugin_style_base.test','54fb7816d18416d8b0db67e9f55aa2aa50ac204eb9311be14b6700b7d7a95ae7'),('sites/all/modules/contrib/views/tests/styles/views_plugin_style_jump_menu.test','b88baa8aebe183943a6e4cf2df314fef13ac41b5844cd5fa4aa91557dd624895'),('sites/all/modules/contrib/views/tests/styles/views_plugin_style_mapping.test','a4e68bc8cfbeff4a1d9b8085fd115bfe7a8c4b84c049573fa0409b0dc8c2f053'),('sites/all/modules/contrib/views/tests/styles/views_plugin_style_unformatted.test','033ca29d41af47cd7bd12d50fea6c956dde247202ebda9df7f637111481bb51d'),('sites/all/modules/contrib/views/tests/taxonomy/views_handler_relationship_node_term_data.test','6074f5c7ae63225ea0cd26626ace6c017740e226f4d3c234e39869c31308223d'),('sites/all/modules/contrib/views/tests/test_handlers/views_test_area_access.inc','619e39bc4535976865b96751535d0d5aac4a7a87c1d47cb6d4c4bb9c9fa74716'),('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_dynamic.inc','6a3ce8c256b84734b6b67a893ab24465a5f62d7bdf9ab5d22082a31849346b7d'),('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_access_test_static.inc','e345e42d443cfa73db0ed2be61291117ebd57b86196cdb77c6f440e93443def3'),('sites/all/modules/contrib/views/tests/test_plugins/views_test_plugin_style_test_mapping.inc','0b2c68626105bd5f6b9074022a37c3d09d3a6bd70b811bb26d5eacad6d74546f'),('sites/all/modules/contrib/views/tests/user/views_handler_field_user_name.test','69641b6da26d8daee9a2ceb2d0df56668bf09b86db1d4071c275b6e8d0885f9e'),('sites/all/modules/contrib/views/tests/user/views_user.test','fbb63b42a0b7051bd4d33cf36841f39d7cc13a63b0554eca431b2a08c19facae'),('sites/all/modules/contrib/views/tests/user/views_user_argument_default.test','6423f2db7673763991b1fd0c452a7d84413c7dd888ca6c95545fadc531cfaaf4'),('sites/all/modules/contrib/views/tests/user/views_user_argument_validate.test','c88c9e5d162958f8924849758486a0d83822ada06088f5cf71bfbe76932d8d84'),('sites/all/modules/contrib/views/tests/views_access.test','f8b9d04b43c09a67ec722290a30408c1df8c163cf6e5863b41468bb4e381ee6f'),('sites/all/modules/contrib/views/tests/views_analyze.test','5548e36c99bb626209d63e5cddbc31f49ad83865c983d2662c6826b328d24ffb'),('sites/all/modules/contrib/views/tests/views_argument_default.test','5950937aae4608bba5b86f366ef3a56cc6518bbccfeaeacda79fa13246d220e4'),('sites/all/modules/contrib/views/tests/views_argument_validator.test','31f8f49946c8aa3b03d6d9a2281bdfb11c54071b28e83fb3e827ca6ff5e38c88'),('sites/all/modules/contrib/views/tests/views_basic.test','655bd33983f84bbea68a3f24bfab545d2c02f36a478566edf35a98a58ff0c6cf'),('sites/all/modules/contrib/views/tests/views_cache.test','4e9b8ae1d9e72a9eaee95f5083004316d2199617f7d6c8f4bea40e99d17efcd8'),('sites/all/modules/contrib/views/tests/views_exposed_form.test','2b2b16373af8ecade91d7c77bd8c2da8286a33bde554874f5d81399d201c3228'),('sites/all/modules/contrib/views/tests/views_glossary.test','118d50177a68a6f88e3727e10f8bcc6f95176282cc42fbd604458eeb932a36e8'),('sites/all/modules/contrib/views/tests/views_groupby.test','f26ad6857dc4821a4a0780642bda05fcb69ed506968e521f759bb28be4080143'),('sites/all/modules/contrib/views/tests/views_handlers.test','a696e3d6b1748da03a04ac532f403700d07c920b9c405c628a6c94ea6764f501'),('sites/all/modules/contrib/views/tests/views_module.test','5137e27449639d3e02f1b27206ef3ff96957546333b517318dfe8f58239dc860'),('sites/all/modules/contrib/views/tests/views_pager.test','6f448c8c13c5177afb35103119d6281958a2d6dbdfb96ae5f4ee77cb3b44adc5'),('sites/all/modules/contrib/views/tests/views_plugin_localization_test.inc','baedcf6c7381f9c5d3a5062f7d256f96808d06e04b6e73eff8e791e5f5293f45'),('sites/all/modules/contrib/views/tests/views_query.test','f8cb1649e43c8a2b036fec742e86b8eb9c2c4c095a4c4e7a7c3ca13c6ce8e6e6'),('sites/all/modules/contrib/views/tests/views_test.views_default.inc','9664b95577fe2664410921bb751e1d99109e79b734f2c8c142d4083449282bd0'),('sites/all/modules/contrib/views/tests/views_translatable.test','6899c7b09ab72c262480cf78d200ecddfb683e8f2495438a55b35ae0e103a1b3'),('sites/all/modules/contrib/views/tests/views_ui.test','f9687a363d7cc2828739583e3eedeb68c99acd505ff4e3036c806a42b93a2688'),('sites/all/modules/contrib/views/tests/views_upgrade.test','c48bd74b85809dd78d963e525e38f3b6dd7e12aa249f73bd6a20247a40d6713a'),('sites/all/modules/contrib/views/tests/views_view.test','a52e010d27cc2eb29804a3acd30f574adf11fad1f5860e431178b61cddbdbb69'),('sites/all/modules/contrib/views/views_ui.module','095267aa333282d53c70f7b01aa21229edbce45697f0ec490031ad4d388fea06'),('sites/all/modules/contrib/webform/tests/components.test','3c3933763024a02ecf00197e48792a4cb3d7d38ee433a687d862403d1b33597b'),('sites/all/modules/contrib/webform/tests/conditionals.test','cd6c0093d349a9b5e9e2c88b67f61ca037fab12f9d6baaf556d2592d460484b4'),('sites/all/modules/contrib/webform/tests/permissions.test','a3a44e69e38d99f100bc8e38ecac9c732e7f6559d08760f17d090f83b3661b6b'),('sites/all/modules/contrib/webform/tests/submission.test','29b2d613653a21a3644e6401e4156827eaeb344e79b5c2140ed8e1751f6a00fa'),('sites/all/modules/contrib/webform/tests/webform.test','a1f5ca21126eaefbd33bea6bbebd231798428fccf430f20f263d9f0aedcf0fd0'),('sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_field_edit_node.inc','ad6d809771602a398c12516f7ee1ed7bca6b11b3b9bdf9e217758760b2d75373'),('sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_field_section.inc','6a9354fc48d867879d5cd0d7a7db21d3b50fc025bd464752cc77323b823e6e67'),('sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_filter_access.inc','2ae2d006dfa74802294a48e8ef0718c1e401602f90c4a7751166f1370fccf67d'),('sites/all/modules/contrib/workbench_access/includes/workbench_access_handler_sort_section.inc','7f69326711a03d7e0808c9aeca838a2ecd7f351bf0ab672f067820fdeb953d24'),('sites/all/modules/contrib/workbench_access/modules/menu.workbench_access.inc','570928177b6b35692e81794c9c3247bba03a5a230952a91ccd3695db0ea75bab'),('sites/all/modules/contrib/workbench_access/modules/taxonomy.workbench_access.inc','fb873ff2a7d2a967fe68cfebf54af0c4493c4d7f6bdfea7dee88941f4cdd3cac'),('sites/all/modules/contrib/workbench_access/tests/workbench_access.test','6c36af3337e6d3f5f0718c36c58f0823bfb5ac086bbf807edaa115665531c255'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_history_link.inc','3f1410691487fe240c69af311341ec4b8f16adabdcefcb22302b3d4cba087c47'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_links.inc','3c0f620afc7c53f90545e2d673a7f99eb45434ea65f4ea9037373a4b0ea6cf97'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_field_state.inc','7f7eae559f87614125617f2aeddf8cf293af03b3a7dd6b4aa52e096c7774b2c6'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_moderated_type.inc','19af994a9c310b4d0ea0dffab5550498006ec38c49b6885a6ed317d1e887ef4d'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_state.inc','7f30430737af54946f0c26b53f4b2b0280622220fad325e2ac47441c1b5859e0'),('sites/all/modules/contrib/workbench_moderation/includes/workbench_moderation_handler_filter_user_can_moderate.inc','8d08ff167860610f177238c682511d39abd3d2cf7b29b7c9d9fd79ec0e3025dd'),('sites/all/modules/contrib/workbench_moderation/tests/external_node_update.test','3a1cd2662d48a2f157f2d2fabfc0b2b10588643a3a4b2e65f548629124930601'),('sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.files.test','bfa3d20fe514f8d7393ed67473aea5a3e3a9ebc06c7c2d197a6c3618dbc0f1cb'),('sites/all/modules/contrib/workbench_moderation/tests/workbench_moderation.test','ce2c70116ac90cfd2fa5f8cdebebd3e3feac496cc25ab21f2b708094b08d75cf'),('sites/all/modules/contrib/workbench_moderation/workbench_moderation.migrate.inc','b62e9964ee551d153618824eefec11da200a90f05422b2de51d6fdb5fb42f0db'),('sites/all/modules/contrib/workbench_moderation/workbench_moderation.module','a08ff3b07eb05f86c3629976c3c80013f2983c41856a714838a5e92a37486a15'),('sites/all/modules/contrib/wysiwyg/tests/wysiwyg.test','351bd7ed3eb279052b92cd900ceaedb3baa97ab502eed61a390efed83d8cefd8'),('sites/all/modules/contrib/wysiwyg/wysiwyg.module','581ff8c11926a13ad97dff60c1c206c801b49cb792126508f1c14df51c7a7a8c'),('sites/all/modules/contrib/wysiwyg_filter/wysiwyg_filter.admin.inc','de61893893d7da828f62763420f7e76e03aab7853bc8419214145c4ddd942ec1'),('sites/all/modules/contrib/wysiwyg_filter/wysiwyg_filter.inc','b5ca4f66a24b657cd0feaafcd45934ba4b08e199b8278b29f12353ecf35ea46b'),('sites/all/modules/contrib/wysiwyg_filter/wysiwyg_filter.install','88ccec4d0b3bf268b520277587bc9997aaba30615ddd1362904737bcc87de2f2'),('sites/all/modules/contrib/wysiwyg_filter/wysiwyg_filter.module','901e9e84c55cff242d4c766bd58a25df9504e9853dfd7120823da062cacb6957'),('sites/all/modules/contrib/wysiwyg_filter/wysiwyg_filter.pages.inc','f7108bc187a6a7ab912cdf8ee8c144fe19dd40dbbcab5f557603987c358e73c4');
/*!40000 ALTER TABLE `registry_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (3,'administrator',2),(1,'anonymous user',0),(2,'authenticated user',1),(5,'author',5),(4,'publisher',4),(6,'web staff',3);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,'access content','node'),(1,'search content','search'),(1,'use text format filtered_html','filter'),(2,'access content','node'),(2,'access workbench','workbench'),(2,'search content','search'),(2,'use text format filtered_html','filter'),(2,'use workbench_moderation my drafts tab','workbench_moderation'),(2,'view moderation history','workbench_moderation'),(2,'view moderation messages','workbench_moderation'),(3,'access administration pages','system'),(3,'access all views','views'),(3,'access content','node'),(3,'access content overview','node'),(3,'access contextual links','contextual'),(3,'access dashboard','dashboard'),(3,'access site in maintenance mode','system'),(3,'access site reports','system'),(3,'access site-wide contact form','contact'),(3,'access statistics','statistics'),(3,'access toolbar','toolbar'),(3,'access user contact forms','contact'),(3,'access user profiles','user'),(3,'access workbench','workbench'),(3,'access workbench access by role','workbench_access'),(3,'administer actions','system'),(3,'administer blocks','block'),(3,'administer boxes','boxes'),(3,'administer contact forms','contact'),(3,'administer content types','node'),(3,'administer contexts','context_ui'),(3,'administer custom content','ctools_custom_content'),(3,'administer delta','delta_ui'),(3,'administer delta blocks','delta_blocks'),(3,'administer entity_boxes','entity_boxes'),(3,'administer entity_boxes types','entity_boxes'),(3,'administer features','features'),(3,'administer federal google analytics','usfedgov_google_analytics'),(3,'administer fieldgroups','field_group'),(3,'administer filters','filter'),(3,'administer google analytics','googleanalytics'),(3,'administer image styles','image'),(3,'administer imce','imce'),(3,'administer languages','locale'),(3,'administer menu','menu'),(3,'administer module filter','module_filter'),(3,'administer modules','system'),(3,'administer nodes','node'),(3,'administer page manager','page_manager'),(3,'administer pathauto','pathauto'),(3,'administer permissions','user'),(3,'administer search','search'),(3,'administer shortcuts','shortcut'),(3,'administer site configuration','system'),(3,'administer software updates','system'),(3,'administer statistics','statistics'),(3,'administer stylizer','stylizer'),(3,'administer taxonomy','taxonomy'),(3,'administer themes','system'),(3,'administer unit tests','simpletest'),(3,'administer url aliases','path'),(3,'administer users','user'),(3,'administer views','views'),(3,'administer workbench','workbench'),(3,'administer workbench access','workbench_access'),(3,'administer workbench moderation','workbench_moderation'),(3,'assign workbench access','workbench_access'),(3,'batch update workbench access','workbench_access'),(3,'block IP addresses','system'),(3,'boost flush pages','boost'),(3,'bypass node access','node'),(3,'bypass workbench moderation','workbench_moderation'),(3,'create external content','node'),(3,'create landing_page content','node'),(3,'create photo content','node'),(3,'create press_release content','node'),(3,'create profile content','node'),(3,'create rotator content','node'),(3,'create site_page content','node'),(3,'create url aliases','path'),(3,'customize shortcut links','shortcut'),(3,'delete any external content','node'),(3,'delete any landing_page content','node'),(3,'delete any photo content','node'),(3,'delete any press_release content','node'),(3,'delete any profile content','node'),(3,'delete any rotator content','node'),(3,'delete any site_page content','node'),(3,'delete own external content','node'),(3,'delete own landing_page content','node'),(3,'delete own photo content','node'),(3,'delete own press_release content','node'),(3,'delete own profile content','node'),(3,'delete own rotator content','node'),(3,'delete own site_page content','node'),(3,'delete revisions','node'),(3,'edit any alert_box entity_boxes','entity_boxes'),(3,'edit any carousel_box entity_boxes','entity_boxes'),(3,'edit any content_list_box entity_boxes','entity_boxes'),(3,'edit any external content','node'),(3,'edit any landing_page content','node'),(3,'edit any photo content','node'),(3,'edit any photo_box entity_boxes','entity_boxes'),(3,'edit any press_release content','node'),(3,'edit any profile content','node'),(3,'edit any rotator content','node'),(3,'edit any site_page content','node'),(3,'edit any slideshow_box entity_boxes','entity_boxes'),(3,'edit boxes','boxes'),(3,'edit node machine name','defaultcontent'),(3,'edit node reference box node types','node_reference_box'),(3,'edit own external content','node'),(3,'edit own landing_page content','node'),(3,'edit own photo content','node'),(3,'edit own press_release content','node'),(3,'edit own profile content','node'),(3,'edit own rotator content','node'),(3,'edit own site_page content','node'),(3,'enter external revision log entry','override_node_options'),(3,'enter landing_page revision log entry','override_node_options'),(3,'enter photo revision log entry','override_node_options'),(3,'enter press_release revision log entry','override_node_options'),(3,'enter profile revision log entry','override_node_options'),(3,'enter rotator revision log entry','override_node_options'),(3,'enter site_page revision log entry','override_node_options'),(3,'manage features','features'),(3,'moderate content from draft to needs_review','workbench_moderation'),(3,'moderate content from needs_review to draft','workbench_moderation'),(3,'moderate content from needs_review to published','workbench_moderation'),(3,'moderate content from published to draft','workbench_moderation'),(3,'notify of path changes','pathauto'),(3,'opt-in or out of tracking','googleanalytics'),(3,'override external authored by option','override_node_options'),(3,'override external authored on option','override_node_options'),(3,'override external promote to front page option','override_node_options'),(3,'override external published option','override_node_options'),(3,'override external revision option','override_node_options'),(3,'override external sticky option','override_node_options'),(3,'override landing_page authored by option','override_node_options'),(3,'override landing_page authored on option','override_node_options'),(3,'override landing_page promote to front page option','override_node_options'),(3,'override landing_page published option','override_node_options'),(3,'override landing_page revision option','override_node_options'),(3,'override landing_page sticky option','override_node_options'),(3,'override photo authored by option','override_node_options'),(3,'override photo authored on option','override_node_options'),(3,'override photo promote to front page option','override_node_options'),(3,'override photo published option','override_node_options'),(3,'override photo revision option','override_node_options'),(3,'override photo sticky option','override_node_options'),(3,'override press_release authored by option','override_node_options'),(3,'override press_release authored on option','override_node_options'),(3,'override press_release promote to front page option','override_node_options'),(3,'override press_release published option','override_node_options'),(3,'override press_release revision option','override_node_options'),(3,'override press_release sticky option','override_node_options'),(3,'override profile authored by option','override_node_options'),(3,'override profile authored on option','override_node_options'),(3,'override profile promote to front page option','override_node_options'),(3,'override profile published option','override_node_options'),(3,'override profile revision option','override_node_options'),(3,'override profile sticky option','override_node_options'),(3,'override rotator authored by option','override_node_options'),(3,'override rotator authored on option','override_node_options'),(3,'override rotator promote to front page option','override_node_options'),(3,'override rotator published option','override_node_options'),(3,'override rotator revision option','override_node_options'),(3,'override rotator sticky option','override_node_options'),(3,'override site_page authored by option','override_node_options'),(3,'override site_page authored on option','override_node_options'),(3,'override site_page promote to front page option','override_node_options'),(3,'override site_page published option','override_node_options'),(3,'override site_page revision option','override_node_options'),(3,'override site_page sticky option','override_node_options'),(3,'revert revisions','node'),(3,'search content','search'),(3,'switch shortcut sets','shortcut'),(3,'translate content','translation'),(3,'translate interface','locale'),(3,'use advanced search','search'),(3,'use page manager','page_manager'),(3,'use PHP for tracking visibility','googleanalytics'),(3,'use text format filtered_html','filter'),(3,'use text format full_html','filter'),(3,'use workbench_moderation my drafts tab','workbench_moderation'),(3,'use workbench_moderation needs review tab','workbench_moderation'),(3,'view all unpublished content','workbench_moderation'),(3,'view any alert_box entity_boxes','entity_boxes'),(3,'view any carousel_box entity_boxes','entity_boxes'),(3,'view any content_list_box entity_boxes','entity_boxes'),(3,'view any photo_box entity_boxes','entity_boxes'),(3,'view any slideshow_box entity_boxes','entity_boxes'),(3,'view moderation history','workbench_moderation'),(3,'view moderation messages','workbench_moderation'),(3,'view own unpublished content','node'),(3,'view post access counter','statistics'),(3,'view revisions','node'),(3,'view the administration theme','system'),(3,'view workbench access information','workbench_access'),(3,'view workbench taxonomy pages','workbench_access'),(4,'access administration pages','system'),(4,'access content','node'),(4,'access content overview','node'),(4,'access contextual links','contextual'),(4,'access dashboard','dashboard'),(4,'access site in maintenance mode','system'),(4,'access toolbar','toolbar'),(4,'access user profiles','user'),(4,'administer menu','menu'),(4,'administer url aliases','path'),(4,'bypass workbench moderation','workbench_moderation'),(4,'create url aliases','path'),(4,'delete revisions','node'),(4,'edit boxes','boxes'),(4,'moderate content from draft to needs_review','workbench_moderation'),(4,'moderate content from needs_review to draft','workbench_moderation'),(4,'moderate content from needs_review to published','workbench_moderation'),(4,'moderate content from published to draft','workbench_moderation'),(4,'revert revisions','node'),(4,'search content','search'),(4,'use advanced search','search'),(4,'use workbench_moderation needs review tab','workbench_moderation'),(4,'view all unpublished content','workbench_moderation'),(4,'view own unpublished content','node'),(4,'view revisions','node'),(4,'view the administration theme','system'),(5,'access content','node'),(5,'access content overview','node'),(5,'access dashboard','dashboard'),(5,'access site in maintenance mode','system'),(5,'access toolbar','toolbar'),(5,'access user profiles','user'),(5,'create url aliases','path'),(5,'moderate content from draft to needs_review','workbench_moderation'),(5,'search content','search'),(5,'use advanced search','search'),(5,'view all unpublished content','workbench_moderation'),(5,'view own unpublished content','node'),(5,'view revisions','node'),(5,'view the administration theme','system'),(6,'access administration pages','system'),(6,'access content','node'),(6,'access content overview','node'),(6,'access contextual links','contextual'),(6,'access dashboard','dashboard'),(6,'access site in maintenance mode','system'),(6,'access site reports','system'),(6,'access toolbar','toolbar'),(6,'access user profiles','user'),(6,'administer entity_boxes types','entity_boxes'),(6,'administer nodes','node'),(6,'administer pathauto','pathauto'),(6,'administer search','search'),(6,'administer taxonomy','taxonomy'),(6,'administer url aliases','path'),(6,'administer views','views'),(6,'block IP addresses','system'),(6,'bypass workbench moderation','workbench_moderation'),(6,'create url aliases','path'),(6,'customize shortcut links','shortcut'),(6,'delete revisions','node'),(6,'edit boxes','boxes'),(6,'moderate content from draft to needs_review','workbench_moderation'),(6,'moderate content from needs_review to draft','workbench_moderation'),(6,'moderate content from needs_review to published','workbench_moderation'),(6,'moderate content from published to draft','workbench_moderation'),(6,'notify of path changes','pathauto'),(6,'revert revisions','node'),(6,'search content','search'),(6,'switch shortcut sets','shortcut'),(6,'use advanced search','search'),(6,'use workbench_moderation needs review tab','workbench_moderation'),(6,'view all unpublished content','workbench_moderation'),(6,'view own unpublished content','node'),(6,'view revisions','node'),(6,'view the administration theme','system');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_dataset`
--

DROP TABLE IF EXISTS `search_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_dataset`
--

LOCK TABLES `search_dataset` WRITE;
/*!40000 ALTER TABLE `search_dataset` DISABLE KEYS */;
INSERT INTO `search_dataset` VALUES (51,'node',' medical medical applications cg719k credential medical evaluation report the merchant mariner physical exam cg719k is required for officers and mariners with a qualified rating the examination and form must be completed within 12 months of application date 36 months if applying for raise of grade the medical provider completing the required examination must be a physician physician assistant or nurse practitioner who is licensed in the united states or one of the us territories merchant mariner physical examination form cg719k cg719k instruction guide common errors on the cg719k form disclaimer uscg practices with respect to the physical and medical evaluation process continually evolve to align with current medical standards of care and current safety standards although the current nvic 408 details specific medical conditions and the recommended data for evaluation of these conditions it is not all inclusive or definitive and may be subject to further review  ',0),(54,'node',' recs recs regional exam centers rec  regional exam centers rec  ',0),(57,'node',' checklists checklists checklists overview checklist ',0),(60,'node',' drug testing drug testing drug testing content drug testing ',0),(62,'node',' about about about nmc about nmc ',0),(65,'node',' contact contact us contact nmc contact us ',0),(67,'node',' fees fees fees content fees ',0),(70,'node',' twic twic twic content twic ',0),(71,'node',' stcw stcw stcw stcw ',0),(74,'node',' background image background image wednesday june 8 2016  ',0),(75,'node',' stcw image stcw image monday june 13 2016  ',0),(77,'node',' medical image medical image monday june 13 2016  ',0),(78,'node',' slide show cg719k credential medical evaluation report the merchant mariner physical exam cg719k is required for officers and mariners with a qualified rating the examination and form must be completed within 12 months of application date 36 months if applying for raise of grade the medical provider completing the required examination must be a physician physician assistant or nurse practitioner who is licensed in the united states or one of the us territories merchant mariner physical examination form cg719k cg719k instruction guide common errors on the cg719k form disclaimer uscg practices with respect to the physical and medical evaluation process continually evolve to align with current medical standards of care and current safety standards although the current nvic 408 details specific medical conditions and the recommended data for evaluation of these conditions it is not all inclusive or definitive and may be subject to further review stcw slide show  ',0),(79,'node',' home the mission of the national maritime center nmc is to issue credentials to mariners who are fully compliant with current regulations in the most effective and efficient manner possible  ',0);
/*!40000 ALTER TABLE `search_dataset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_index`
--

DROP TABLE IF EXISTS `search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_index`
--

LOCK TABLES `search_index` WRITE;
/*!40000 ALTER TABLE `search_index` DISABLE KEYS */;
INSERT INTO `search_index` VALUES ('12',51,'node',1),('12',78,'node',1),('13',75,'node',1),('13',77,'node',1),('2016',74,'node',1),('2016',75,'node',1),('2016',77,'node',1),('36',51,'node',1),('36',78,'node',1),('408',51,'node',1),('408',78,'node',1),('8',74,'node',1),('about',62,'node',39),('align',51,'node',1),('align',78,'node',1),('all',51,'node',1),('all',78,'node',1),('although',51,'node',1),('although',78,'node',1),('and',51,'node',6),('and',78,'node',6),('and',79,'node',1),('application',51,'node',1),('application',78,'node',1),('applications',51,'node',1),('applying',51,'node',1),('applying',78,'node',1),('are',79,'node',1),('assistant',51,'node',1),('assistant',78,'node',1),('background',74,'node',27),('care',51,'node',1),('care',78,'node',1),('center',79,'node',1),('centers',54,'node',12),('cg719k',51,'node',5),('cg719k',78,'node',5),('checklist',57,'node',11),('checklists',57,'node',28),('common',51,'node',1),('common',78,'node',1),('completed',51,'node',1),('completed',78,'node',1),('completing',51,'node',1),('completing',78,'node',1),('compliant',79,'node',1),('conditions',51,'node',2),('conditions',78,'node',2),('contact',65,'node',39),('content',60,'node',1),('content',67,'node',1),('content',70,'node',1),('continually',51,'node',1),('continually',78,'node',1),('credential',51,'node',1),('credential',78,'node',1),('credentials',79,'node',1),('current',51,'node',3),('current',78,'node',3),('current',79,'node',1),('data',51,'node',1),('data',78,'node',1),('date',51,'node',1),('date',78,'node',1),('definitive',51,'node',1),('definitive',78,'node',1),('details',51,'node',1),('details',78,'node',1),('disclaimer',51,'node',1),('disclaimer',78,'node',1),('drug',60,'node',39),('effective',79,'node',1),('efficient',79,'node',1),('errors',51,'node',1),('errors',78,'node',1),('evaluation',51,'node',3),('evaluation',78,'node',3),('evolve',51,'node',1),('evolve',78,'node',1),('exam',51,'node',1),('exam',54,'node',12),('exam',78,'node',1),('examination',51,'node',3),('examination',78,'node',3),('fees',67,'node',39),('for',51,'node',3),('for',78,'node',3),('form',51,'node',3),('form',78,'node',3),('fully',79,'node',1),('further',51,'node',1),('further',78,'node',1),('grade',51,'node',1),('grade',78,'node',1),('guide',51,'node',1),('guide',78,'node',1),('home',79,'node',26),('image',74,'node',27),('image',75,'node',27),('image',77,'node',27),('inclusive',51,'node',1),('inclusive',78,'node',1),('instruction',51,'node',1),('instruction',78,'node',1),('issue',79,'node',1),('june',74,'node',1),('june',75,'node',1),('june',77,'node',1),('licensed',51,'node',1),('licensed',78,'node',1),('manner',79,'node',1),('mariner',51,'node',2),('mariner',78,'node',2),('mariners',51,'node',1),('mariners',78,'node',1),('mariners',79,'node',1),('maritime',79,'node',1),('may',51,'node',1),('may',78,'node',1),('medical',51,'node',32),('medical',77,'node',27),('medical',78,'node',5),('merchant',51,'node',2),('merchant',78,'node',2),('mission',79,'node',1),('monday',75,'node',1),('monday',77,'node',1),('months',51,'node',2),('months',78,'node',2),('most',79,'node',1),('must',51,'node',2),('must',78,'node',2),('national',79,'node',1),('nmc',62,'node',12),('nmc',65,'node',1),('nmc',79,'node',1),('not',51,'node',1),('not',78,'node',1),('nurse',51,'node',1),('nurse',78,'node',1),('nvic',51,'node',1),('nvic',78,'node',1),('officers',51,'node',1),('officers',78,'node',1),('one',51,'node',1),('one',78,'node',1),('overview',57,'node',1),('physical',51,'node',3),('physical',78,'node',3),('physician',51,'node',2),('physician',78,'node',2),('possible',79,'node',1),('practices',51,'node',1),('practices',78,'node',1),('practitioner',51,'node',1),('practitioner',78,'node',1),('process',51,'node',1),('process',78,'node',1),('provider',51,'node',1),('provider',78,'node',1),('qualified',51,'node',1),('qualified',78,'node',1),('raise',51,'node',1),('raise',78,'node',1),('rating',51,'node',1),('rating',78,'node',1),('rec',54,'node',12),('recommended',51,'node',1),('recommended',78,'node',1),('recs',54,'node',27),('regional',54,'node',12),('regulations',79,'node',1),('report',51,'node',1),('report',78,'node',1),('required',51,'node',2),('required',78,'node',2),('respect',51,'node',1),('respect',78,'node',1),('review',51,'node',1),('review',78,'node',1),('safety',51,'node',1),('safety',78,'node',1),('show',78,'node',27),('slide',78,'node',27),('specific',51,'node',1),('specific',78,'node',1),('standards',51,'node',2),('standards',78,'node',2),('states',51,'node',1),('states',78,'node',1),('stcw',71,'node',39),('stcw',75,'node',27),('stcw',78,'node',1),('subject',51,'node',1),('subject',78,'node',1),('territories',51,'node',1),('territories',78,'node',1),('testing',60,'node',39),('the',51,'node',10),('the',78,'node',10),('the',79,'node',3),('these',51,'node',1),('these',78,'node',1),('twic',70,'node',39),('united',51,'node',1),('united',78,'node',1),('uscg',51,'node',1),('uscg',78,'node',1),('wednesday',74,'node',1),('who',51,'node',1),('who',78,'node',1),('who',79,'node',1),('with',51,'node',3),('with',78,'node',3),('with',79,'node',1),('within',51,'node',1),('within',78,'node',1);
/*!40000 ALTER TABLE `search_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_node_links`
--

DROP TABLE IF EXISTS `search_node_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_node_links`
--

LOCK TABLES `search_node_links` WRITE;
/*!40000 ALTER TABLE `search_node_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `search_node_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_total`
--

DROP TABLE IF EXISTS `search_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_total`
--

LOCK TABLES `search_total` WRITE;
/*!40000 ALTER TABLE `search_total` DISABLE KEYS */;
INSERT INTO `search_total` VALUES ('12',0.176091),('13',0.176091),('2016',0.124939),('36',0.176091),('408',0.176091),('8',0.30103),('about',0.00496091),('align',0.176091),('all',0.176091),('although',0.176091),('and',0.0321847),('application',0.176091),('applications',0.104085),('applying',0.176091),('are',0.30103),('assistant',0.176091),('background',0.0157943),('care',0.176091),('center',0.30103),('centers',0.031368),('cg719k',0.0413927),('checklist',0.0377886),('checklists',0.01524),('common',0.176091),('completed',0.176091),('completing',0.176091),('compliant',0.30103),('conditions',0.09691),('contact',0.00998422),('content',0.124939),('continually',0.176091),('credential',0.176091),('credentials',0.30103),('current',0.0579919),('data',0.176091),('date',0.176091),('definitive',0.176091),('details',0.176091),('disclaimer',0.176091),('drug',0.0109954),('effective',0.30103),('efficient',0.30103),('errors',0.176091),('evaluation',0.0669468),('evolve',0.176091),('exam',0.0299632),('examination',0.0669468),('fees',0.0109954),('for',0.0669468),('form',0.0669468),('fully',0.30103),('further',0.176091),('grade',0.176091),('guide',0.176091),('home',0.0163904),('image',0.00532883),('inclusive',0.176091),('instruction',0.176091),('issue',0.30103),('june',0.124939),('licensed',0.176091),('manner',0.30103),('mariner',0.09691),('mariners',0.124939),('maritime',0.30103),('may',0.176091),('medical',0.00673338),('merchant',0.09691),('mission',0.30103),('monday',0.176091),('months',0.09691),('most',0.30103),('must',0.09691),('national',0.30103),('nmc',0.0299632),('not',0.176091),('nurse',0.176091),('nvic',0.176091),('officers',0.176091),('one',0.176091),('overview',0.00399479),('physical',0.0669468),('physician',0.09691),('possible',0.30103),('practices',0.176091),('practitioner',0.176091),('process',0.176091),('provider',0.176091),('qualified',0.176091),('raise',0.176091),('rating',0.176091),('rec',0.0347621),('recommended',0.176091),('recs',0.0157943),('regional',0.0347621),('regulations',0.30103),('report',0.176091),('required',0.09691),('respect',0.176091),('review',0.176091),('safety',0.176091),('show',0.0157943),('slide',0.0157943),('specific',0.176091),('standards',0.09691),('states',0.176091),('stcw',0.00643411),('subject',0.176091),('territories',0.176091),('testing',0.0109954),('the',0.0184834),('these',0.176091),('twic',0.0109954),('united',0.176091),('uscg',0.176091),('wednesday',0.30103),('who',0.124939),('with',0.0579919),('within',0.176091);
/*!40000 ALTER TABLE `search_total` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semaphore`
--

LOCK TABLES `semaphore` WRITE;
/*!40000 ALTER TABLE `semaphore` DISABLE KEYS */;
/*!40000 ALTER TABLE `semaphore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
INSERT INTO `sequences` VALUES (30);
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (27,'5jjJeKL1qkM6xx3aiLjYQ8tqhHLzcQpWo7oh0nGrfSg','5jjJeKL1qkM6xx3aiLjYQ8tqhHLzcQpWo7oh0nGrfSg','131.103.137.219',1466603659,0,'cache_flush|a:1:{s:10:\"cache_page\";i:1466603433;}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set`
--

LOCK TABLES `shortcut_set` WRITE;
/*!40000 ALTER TABLE `shortcut_set` DISABLE KEYS */;
INSERT INTO `shortcut_set` VALUES ('shortcut-set-1','Default');
/*!40000 ALTER TABLE `shortcut_set` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shortcut_set_users`
--

DROP TABLE IF EXISTS `shortcut_set_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set_users`
--

LOCK TABLES `shortcut_set_users` WRITE;
/*!40000 ALTER TABLE `shortcut_set_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `shortcut_set_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simpletest`
--

DROP TABLE IF EXISTS `simpletest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simpletest` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique simpletest message ID.',
  `test_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Test ID, messages belonging to the same ID are reported together',
  `test_class` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the class that created this message.',
  `status` varchar(9) NOT NULL DEFAULT '' COMMENT 'Message status. Core understands pass, fail, exception.',
  `message` text NOT NULL COMMENT 'The message itself.',
  `message_group` varchar(255) NOT NULL DEFAULT '' COMMENT 'The message group this message belongs to. For example: warning, browser, user.',
  `function` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the assertion function or method that created this message.',
  `line` int(11) NOT NULL DEFAULT '0' COMMENT 'Line number on which the function is called.',
  `file` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file where the function is called.',
  PRIMARY KEY (`message_id`),
  KEY `reporter` (`test_class`,`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores simpletest messages';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simpletest`
--

LOCK TABLES `simpletest` WRITE;
/*!40000 ALTER TABLE `simpletest` DISABLE KEYS */;
/*!40000 ALTER TABLE `simpletest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `simpletest_test_id`
--

DROP TABLE IF EXISTS `simpletest_test_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simpletest_test_id` (
  `test_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique simpletest ID used to group test results together. Each time a set of tests\n                            are run a new test ID is used.',
  `last_prefix` varchar(60) DEFAULT '' COMMENT 'The last database prefix used during testing.',
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores simpletest test IDs, used to auto-incrament the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `simpletest_test_id`
--

LOCK TABLES `simpletest_test_id` WRITE;
/*!40000 ALTER TABLE `simpletest_test_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `simpletest_test_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stylizer`
--

DROP TABLE IF EXISTS `stylizer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stylizer` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Unique ID for this style. Used to identify it programmatically.',
  `admin_title` varchar(255) DEFAULT NULL COMMENT 'Human readable title for this style.',
  `admin_description` longtext COMMENT 'Administrative description of this style.',
  `settings` longtext COMMENT 'A serialized array of settings specific to the style base that describes this plugin.',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Customized stylizer styles created by administrative users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stylizer`
--

LOCK TABLES `stylizer` WRITE;
/*!40000 ALTER TABLE `stylizer` DISABLE KEYS */;
/*!40000 ALTER TABLE `stylizer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  PRIMARY KEY (`nid`,`tid`),
  KEY `term_node` (`tid`,`sticky`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_index`
--

LOCK TABLES `taxonomy_index` WRITE;
/*!40000 ALTER TABLE `taxonomy_index` DISABLE KEYS */;
INSERT INTO `taxonomy_index` VALUES (54,3,0,1464882591),(57,6,0,1464885194),(60,9,0,1464891054),(62,11,0,1464891666),(65,14,0,1464893364),(67,16,0,1464962773),(70,19,0,1464962833),(71,20,0,1464962893);
/*!40000 ALTER TABLE `taxonomy_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_data`
--

LOCK TABLES `taxonomy_term_data` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_data` DISABLE KEYS */;
INSERT INTO `taxonomy_term_data` VALUES (3,1,'Regional Exam Centers (REC)',NULL,NULL,0),(6,1,'checklist',NULL,NULL,0),(9,1,'Drug Testing',NULL,NULL,0),(11,1,'About NMC',NULL,NULL,0),(14,1,'Contact Us',NULL,NULL,0),(16,1,'FEES',NULL,NULL,0),(19,1,'TWIC',NULL,NULL,0),(20,1,'STCW',NULL,NULL,0),(22,4,'Exhibits','Test term for Workbench Access.','plain_text',-5),(25,4,'Exhibits Staff','Test child term for Workbench Access.','plain_text',0),(28,4,'Exhibits Visitors','Test child term for Workbench Access.','plain_text',0),(31,4,'Library','Test term for Workbench Access.','plain_text',0),(34,4,'Library Staff','Test child term for Workbench Access.','plain_text',0),(37,4,'Library Visitors','Test child term for Workbench Access.','plain_text',0),(40,4,'Gift Shop','Test term for Workbench Access.','plain_text',5),(43,4,'Gift Shop Staff','Test child term for Workbench Access.','plain_text',0),(46,4,'Gift Shop Visitors','Test child term for Workbench Access.','plain_text',0);
/*!40000 ALTER TABLE `taxonomy_term_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_hierarchy`
--

LOCK TABLES `taxonomy_term_hierarchy` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` DISABLE KEYS */;
INSERT INTO `taxonomy_term_hierarchy` VALUES (3,0),(6,0),(9,0),(11,0),(14,0),(16,0),(19,0),(20,0),(22,0),(25,22),(28,22),(31,0),(34,31),(37,31),(40,0),(43,40),(46,40);
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_vocabulary`
--

LOCK TABLES `taxonomy_vocabulary` WRITE;
/*!40000 ALTER TABLE `taxonomy_vocabulary` DISABLE KEYS */;
INSERT INTO `taxonomy_vocabulary` VALUES (1,'Keywords','tags','Use tags to group articles on similar topics into categories.',0,'taxonomy',0),(4,'Museum','workbench_access','Access control for editorial content.',1,'workbench_access',-10);
/*!40000 ALTER TABLE `taxonomy_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_alias`
--

LOCK TABLES `url_alias` WRITE;
/*!40000 ALTER TABLE `url_alias` DISABLE KEYS */;
INSERT INTO `url_alias` VALUES (95,'user/1','users/admin','und'),(96,'user/8','users/cbp-test','und'),(100,'user/19','users/ctracy','und'),(104,'user/23','users/larryadams','und'),(108,'node/51','medical','und'),(111,'user/27','users/jamesmckinlay','und'),(114,'taxonomy/term/3','keywords/regional-exam-centers-rec','und'),(117,'node/54','RECs','en'),(120,'taxonomy/term/6','keywords/checklist','und'),(123,'node/57','checklists','en'),(126,'taxonomy/term/9','keywords/drug-testing','und'),(129,'node/60','drug-testing','en'),(131,'taxonomy/term/11','keywords/about-nmc','und'),(134,'node/62','about','en'),(137,'taxonomy/term/14','keywords/contact-us','und'),(140,'node/65','contact-0','en'),(142,'taxonomy/term/16','keywords/fees','und'),(145,'node/67','fees','en'),(148,'node/70','twic','en'),(151,'taxonomy/term/19','keywords/twic','und'),(152,'taxonomy/term/20','keywords/stcw','und'),(155,'node/71','stcw','en'),(157,'taxonomy/term/22','museum/exhibits','und'),(160,'taxonomy/term/25','museum/exhibits-staff','und'),(163,'taxonomy/term/28','museum/exhibits-visitors','und'),(166,'taxonomy/term/31','museum/library','und'),(169,'taxonomy/term/34','museum/library-staff','und'),(172,'taxonomy/term/37','museum/library-visitors','und'),(175,'taxonomy/term/40','museum/gift-shop','und'),(178,'taxonomy/term/43','museum/gift-shop-staff','und'),(181,'taxonomy/term/46','museum/gift-shop-visitors','und'),(182,'node/74','photo/background-image','en'),(183,'node/75','photo/stcw-image','en'),(185,'node/77','photo/medical-image','en'),(186,'node/78','rotator/slide-show','en'),(187,'node/79','home','en');
/*!40000 ALTER TABLE `url_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (0,'','','','','',NULL,0,0,0,0,NULL,'',0,'',NULL),(1,'admin','$S$DkkCbP8mFJFniDH2B5Nv00JYyYYpJhNmkFJXSIeC/Ai8f8w/Fgz3','admin@edit-wcms-testint.dhs.gov','','',NULL,1379957121,1379957325,1379957325,1,'America/New_York','',0,'admin@edit-wcms-testint.dhs.gov','b:0;'),(8,'cbp_test','$S$D3FxvRRPUR90M5FxLTGT9vdCHRt9hVaULOSxYKY0TRvzgYMIK/ij',NULL,'','',NULL,1423255343,1423675376,1423675376,1,NULL,'',0,'','b:0;'),(19,'ctracy','$S$DKRmEA9uNS0jm6O7SYPo/Jrgd1u9HtOJvjubLKMpCvIJaqb12MRA','test@example.com','','',NULL,1464801786,1464801892,1464801892,1,NULL,'',0,'','b:0;'),(23,'larry.adams','$S$Db9mMHtvX1KvgDqQvXhpUS5cnao3vDiNUYsIPWGuU1zC44Q/bLoW','Larry.L.Adams@uscg.mil','','','full_html',1464801962,1465225690,1465225690,1,'America/New_York','',0,'Larry.L.Adams@uscg.mil',NULL),(27,'james.mckinlay','$S$DXx17fqZaajoTZR2epXgpVaU2Rdsc5NCH6T.x2QsW7TH8XURu/xR','james.f.mckinlayIII@uscg.mil','','','full_html',1464875081,1466603659,1466599932,1,'America/New_York','',0,'james.f.mckinlay@uscg.mil','a:1:{s:7:\"contact\";i:1;}');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,3),(8,3),(19,3),(23,3),(27,3);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
INSERT INTO `variable` VALUES ('acquia_spi_boot_last','i:1410539834;'),('acquia_spi_module_rebuild','i:1424005479;'),('additional_settings__active_tab_external','s:13:\"edit-workflow\";'),('additional_settings__active_tab_landing_page','s:9:\"edit-menu\";'),('additional_settings__active_tab_nmc_about','s:13:\"edit-workflow\";'),('additional_settings__active_tab_photo','s:15:\"edit-submission\";'),('additional_settings__active_tab_press_release','s:9:\"edit-diff\";'),('additional_settings__active_tab_profile','s:9:\"edit-diff\";'),('additional_settings__active_tab_rotator','s:9:\"edit-diff\";'),('additional_settings__active_tab_site_page','s:9:\"edit-diff\";'),('admin_theme','s:5:\"seven\";'),('block_cache','b:0;'),('boost_comment_end_application/rss','s:4:\" -->\";'),('boost_comment_end_application/rss+xml','s:4:\" -->\";'),('boost_comment_end_application/xml','s:4:\" -->\";'),('boost_comment_end_text/html','s:4:\" -->\";'),('boost_comment_end_text/javascript','s:3:\" */\";'),('boost_comment_end_text/xml','s:4:\" -->\";'),('boost_comment_start_application/rss','s:5:\"<!-- \";'),('boost_comment_start_application/rss+xml','s:5:\"<!-- \";'),('boost_comment_start_application/xml','s:5:\"<!-- \";'),('boost_comment_start_text/html','s:5:\"<!-- \";'),('boost_comment_start_text/javascript','s:3:\"/* \";'),('boost_comment_start_text/xml','s:5:\"<!-- \";'),('boost_enabled_application/rss','b:0;'),('boost_enabled_application/rss+xml','b:0;'),('boost_enabled_application/xml','b:0;'),('boost_enabled_text/html','b:1;'),('boost_enabled_text/javascript','b:0;'),('boost_enabled_text/xml','b:0;'),('boost_extension_application/rss','s:3:\"xml\";'),('boost_extension_application/rss+xml','s:3:\"xml\";'),('boost_extension_application/xml','s:3:\"xml\";'),('boost_extension_text/html','s:4:\"html\";'),('boost_extension_text/javascript','s:4:\"json\";'),('boost_extension_text/xml','s:3:\"xml\";'),('boost_gzip_application/rss','b:1;'),('boost_gzip_application/rss+xml','b:1;'),('boost_gzip_application/xml','b:1;'),('boost_gzip_text/html','b:1;'),('boost_gzip_text/javascript','b:1;'),('boost_gzip_text/xml','b:1;'),('boost_lifetime_max_application/rss','i:3600;'),('boost_lifetime_max_application/rss+xml','i:3600;'),('boost_lifetime_max_application/xml','i:3600;'),('boost_lifetime_max_text/html','i:3600;'),('boost_lifetime_max_text/javascript','i:3600;'),('boost_lifetime_max_text/xml','i:3600;'),('boost_lifetime_min_application/rss','i:0;'),('boost_lifetime_min_application/rss+xml','i:0;'),('boost_lifetime_min_application/xml','i:0;'),('boost_lifetime_min_text/html','i:0;'),('boost_lifetime_min_text/javascript','i:0;'),('boost_lifetime_min_text/xml','i:0;'),('cache','i:0;'),('cache_class_cache_ctools_css','s:14:\"CToolsCssCache\";'),('cache_content_flush_cache_block','i:1466603433;'),('cache_content_flush_cache_page','i:1466603433;'),('cache_flush_cache','i:1466523771;'),('cache_flush_cache_block','i:1466523771;'),('cache_flush_cache_bootstrap','i:1466523771;'),('cache_flush_cache_entity_file','i:1466523771;'),('cache_flush_cache_entity_node','i:1466523771;'),('cache_flush_cache_entity_taxonomy_term','i:1466523771;'),('cache_flush_cache_entity_taxonomy_vocabulary','i:1466523771;'),('cache_flush_cache_entity_user','i:1466523771;'),('cache_flush_cache_features','i:1466523771;'),('cache_flush_cache_field','i:1466523771;'),('cache_flush_cache_filter','i:1466523771;'),('cache_flush_cache_form','i:0;'),('cache_flush_cache_image','i:1466523771;'),('cache_flush_cache_libraries','i:1466523771;'),('cache_flush_cache_menu','i:1466603433;'),('cache_flush_cache_page','i:1466523771;'),('cache_flush_cache_path','i:1466523771;'),('cache_flush_cache_token','i:1466523771;'),('cache_flush_cache_views','i:1466523771;'),('cache_flush_cache_views_data','i:1466523771;'),('cache_lifetime','s:2:\"60\";'),('cache_temporary_flush_cache','i:1466622580;'),('cache_temporary_flush_cache_block','i:1466622580;'),('cache_temporary_flush_cache_entity_file','i:1466622580;'),('cache_temporary_flush_cache_entity_node','i:1466622580;'),('cache_temporary_flush_cache_entity_taxonomy_term','i:1466622580;'),('cache_temporary_flush_cache_entity_taxonomy_vocabulary','i:1466622580;'),('cache_temporary_flush_cache_entity_user','i:1466622580;'),('cache_temporary_flush_cache_features','i:1466622580;'),('cache_temporary_flush_cache_field','i:1466622580;'),('cache_temporary_flush_cache_filter','i:1466622580;'),('cache_temporary_flush_cache_image','i:1466622580;'),('cache_temporary_flush_cache_libraries','i:1466622580;'),('cache_temporary_flush_cache_menu','i:1466622580;'),('cache_temporary_flush_cache_page','i:1466622580;'),('cache_temporary_flush_cache_path','i:1466622580;'),('cache_temporary_flush_cache_token','i:1466622580;'),('cache_temporary_flush_cache_views','i:1466622580;'),('cache_temporary_flush_cache_views_data','i:1466622580;'),('clean_url','s:1:\"1\";'),('comment_anonymous_profile','s:1:\"0\";'),('comment_anonymous_site_page','i:0;'),('comment_default_mode_profile','i:1;'),('comment_default_mode_site_page','i:1;'),('comment_default_per_page_profile','s:2:\"50\";'),('comment_default_per_page_site_page','s:2:\"50\";'),('comment_form_location_profile','i:1;'),('comment_form_location_site_page','i:1;'),('comment_preview_profile','s:1:\"1\";'),('comment_preview_site_page','s:1:\"1\";'),('comment_profile','s:1:\"0\";'),('comment_site_page','s:1:\"2\";'),('comment_subject_field_profile','i:1;'),('comment_subject_field_site_page','i:1;'),('context_block_rebuild_needed','b:1;'),('cron_key','s:43:\"QDVsyRvZqCeQOGaMGWzIagNVs7YQU4wet0Jh0rqWhA4\";'),('cron_last','i:1466622579;'),('css_js_query_string','s:6:\"o94ozb\";'),('ctools_last_cron','i:1466597260;'),('date_api_version','s:3:\"7.2\";'),('date_default_timezone','s:16:\"America/New_York\";'),('date_first_day','i:0;'),('date_format_full_month_day_year','s:6:\"F j, Y\";'),('date_format_long','s:15:\"l, F j, Y - H:i\";'),('date_format_medium','s:14:\"D, m/d/Y - H:i\";'),('date_format_short','s:11:\"m/d/Y - H:i\";'),('date_format_time_only','s:5:\"g:i a\";'),('date_views_day_format_without_year','s:6:\"l, F j\";'),('date_views_day_format_with_year','s:9:\"l, F j, Y\";'),('date_views_month_format_without_year','s:1:\"F\";'),('date_views_month_format_with_year','s:3:\"F Y\";'),('date_views_week_format_without_year','s:3:\"F j\";'),('date_views_week_format_with_year','s:6:\"F j, Y\";'),('defaultcontent_hashes','a:0:{}'),('default_nodes_main','s:2:\"10\";'),('delta_blocks_branding_logo_linked','b:1;'),('delta_blocks_branding_logo_render','b:1;'),('delta_blocks_branding_site_name_hidden','b:0;'),('delta_blocks_branding_site_name_linked','b:1;'),('delta_blocks_branding_site_slogan_hidden','b:0;'),('delta_blocks_breadcrumb_current','b:1;'),('delta_blocks_breadcrumb_title_hidden','b:1;'),('delta_blocks_logo_linked','b:1;'),('delta_blocks_page_title_hidden','b:0;'),('delta_blocks_site_name_hidden','b:0;'),('delta_blocks_site_name_linked','b:1;'),('delta_blocks_site_slogan_hidden','b:0;'),('diff_enable_revisions_page_node_nmc_about','i:1;'),('diff_enable_revisions_page_node_photo','i:1;'),('diff_show_preview_changes_node_nmc_about','i:1;'),('diff_show_preview_changes_node_photo','i:1;'),('diff_view_mode_preview_node_nmc_about','s:4:\"full\";'),('diff_view_mode_preview_node_photo','s:4:\"full\";'),('drupal_css_cache_files','a:31:{s:64:\"823ba1006db72809515d2221cd02ec1075d7b49b0c07f49307b3a7930bfdd9e4\";s:64:\"public://css/css_xE-rWrJf-fncB6ztZfd2huxqgxu4WO-qwma6Xer30m4.css\";s:64:\"f05494fc83c9c8e2c74180252d01c9ea50f347143d606c3ea4a216ea0f24ce6e\";s:64:\"public://css/css_BR3eb_ceEn8jEAv9rAj8_gjpfC6A1BpCm8JGn5sUfnY.css\";s:64:\"f18fbad81f67b6bef4b2efe201d219b13bbd6e6eb7d8ffd52b46c2e0b27967b0\";s:64:\"public://css/css_EPsgvacVXxxhwhLr4DGj8P1D4es4L_QnnRJPHn_TJHE.css\";s:64:\"14f16eed8801e6206d50fcd9ecb7e19a7e72ec23ec258715ad87583205300dcc\";s:64:\"public://css/css_R5mqMlkr7S09U6ZZXaX-9DXKJriRwwuU0ZhrEY4C5pU.css\";s:64:\"ebb3f433ad4107b1ac31e9d7de0f9a5d399040e9f82b6364211dcfaadea158c0\";s:64:\"public://css/css_Nv0ct-zkzztuah_LbaPFF8ZkdSEk-LxBtTWMm9mN_F8.css\";s:64:\"65ee581e47f3fa6c6ad7d9c021aae3ab51269e7a47a27e11b956611681626cb2\";s:64:\"public://css/css_gtnXCHMNJErLF7rozM4J6Nv_etP7cu_Z1dfkJHOui_Q.css\";s:64:\"c4dd4926f4f1a015ad0e6de9f89018cce44c6419ad4e2565e70642fe413922ec\";s:64:\"public://css/css_8ctlm8Bd4ry6loUI5ia-4d0MV6Jwiqhpr3-un5xl_Nc.css\";s:64:\"981e6ae9b0f74fde1b691714540d2ca6a8b09de21b49f5eed30d36d512e55aa5\";s:64:\"public://css/css_ANSlr1Yq27NZuANQ2kUmrKLPH5IIwrCDIBEA4wOi_cQ.css\";s:64:\"83ddf723a6378c76e6c7db914e999a4acfe28d6aa7654cdc7866ca5c4bd457ca\";s:64:\"public://css/css_uXLxr_XFxydupm8HBL8qa7-Xz5Rf6OnLmA_LPNNsOII.css\";s:64:\"dc7f6422fcaccae0aafa6da0ee8f7161ee7a390693ccca0a4c9a24b5c451ee6f\";s:64:\"public://css/css_ZElgkRjN2OZQNAsu9P7mOKs0zeatc-vtdO_L2O2DGQk.css\";s:64:\"efa0568e2f84511d15a9ecc10a9d03c5e3efc17f6bfabe1206ad951d58fcab9b\";s:64:\"public://css/css_GU2PF_5gFYE7GVmOxjiRZLTG4z8zJNbDH2zmr4JEa_I.css\";s:64:\"b1cc3aa3af5349efc9a51119e95e5cf290bc44aeed26801aa868940377a00ed4\";s:64:\"public://css/css_a0U_ggE5QkyPbSjCCsjJrTgWjMH9pRui3khTrMJHr8s.css\";s:64:\"88007659988e416b8e3e1d000a92b495a5f5b4d09497f7906a2e15a414df08a2\";s:64:\"public://css/css_sA5y-yiZ-fbttkWqUYju7lnWwjkAKM-NwBAePaM1F-k.css\";s:64:\"a2509a792348d1a1f560574a3c6812d2954051f794c0e824a86e6bd1a6af81fe\";s:64:\"public://css/css_AjkJOp0TCrHkhsfgG1V-9gUKPyVq9eCmHFCMH6MziVU.css\";s:64:\"5facc0a2ac9e99248be5b97e1e6244df52470b310d050b6fdbaf678213063cb8\";s:64:\"public://css/css_iSOJnLDdB_M5YlTbNyu4Shm28rMZCYkWxHKJpWkZaMI.css\";s:64:\"58070b6be8b19a65833e9b4dddc26a5c66466da3049336b758164bc52707dabb\";s:64:\"public://css/css_GqCqCmGspWzZsDVTgkFoFb2eEt4xaByq4GFNcVi8QG4.css\";s:64:\"3d6446f3fd4bbb396cadaed157bf2ea84d9005fedc8225ad40b9110737ce19b1\";s:64:\"public://css/css_Mkt4gbAMnG75msULZyyAbDnlxdMusYMsipDJDe73keY.css\";s:64:\"4e494b8da9b3c0bc735799978bf119d89191b679fd921fbebafad2c59e309d27\";s:64:\"public://css/css_FnHLxPqhwHlpmpe8VLTlBv4Y3roObM1KRw3wdpGDQ2Q.css\";s:64:\"b23e0ec5254ebf410f39965aad8c096012f824e0390b211ea21e2ee256a9be28\";s:64:\"public://css/css_FH0iYp8Szxu3VM8f32XJulf4CqPHqAo5PD0T3eboMW8.css\";s:64:\"2a7c9b5f0ef9f9f776ec9f0fc803f88f769195e06b014d4faff5b662bf0a5e07\";s:64:\"public://css/css_9IcNTILHVLB-9QLVpgA4g4gN2BR2pKPKUwobXyY0ozA.css\";s:64:\"8c7059c42c4bd43222771b96b9893271ab86985b2d552691a1daa4ae9f656411\";s:64:\"public://css/css_P1_iGwjTRnwWEW3XFkRTOneXsPh2-jn8eSfBSg4YDLE.css\";s:64:\"d35383c36efda6ed6005b5c42df9fd5efdad6b66d9aa3c2a1fa06cf8e8cd8fc8\";s:64:\"public://css/css_sb3wps6f7jKbrTKawIWLXUs_D0W_RI6A3tZOkDbGX00.css\";s:64:\"263a66497f2cb7ac063f6969330c2479d14dc567e2c3ade5fe2175fa2137c963\";s:64:\"public://css/css_ANSlr1Yq27NZuANQ2kUmrKLPH5IIwrCDIBEA4wOi_cQ.css\";s:64:\"2eba5aefd3a45e9afab29bb6f89295d121c961333ab5478a65d88e7fde6cf189\";s:64:\"public://css/css_uXLxr_XFxydupm8HBL8qa7-Xz5Rf6OnLmA_LPNNsOII.css\";s:64:\"f7fecd9a61936457ce29b0b70004d0bcc1c76e9390fa05bb363368c81dee00d0\";s:64:\"public://css/css_ZElgkRjN2OZQNAsu9P7mOKs0zeatc-vtdO_L2O2DGQk.css\";s:64:\"c93c16d4f76bd2c64379d9aae70fa84c9af9a34e7ffbc16225f838ae8f9397bb\";s:64:\"public://css/css_GU2PF_5gFYE7GVmOxjiRZLTG4z8zJNbDH2zmr4JEa_I.css\";s:64:\"6ca09b2eed10d36c55446a77b259045eb6bc30a4aed01d04286cdf6e5966b0c0\";s:64:\"public://css/css_a0U_ggE5QkyPbSjCCsjJrTgWjMH9pRui3khTrMJHr8s.css\";s:64:\"45e9c62b93283d3b28946788d56f5b7c719d0a6a4eb78cd4d74cd2a918441811\";s:64:\"public://css/css_sA5y-yiZ-fbttkWqUYju7lnWwjkAKM-NwBAePaM1F-k.css\";s:64:\"559c7bfc8d6f82b9a064a4cd9610ee3c6fdc88207966b7f8d5ae51b99ad2f2a2\";s:64:\"public://css/css_AjkJOp0TCrHkhsfgG1V-9gUKPyVq9eCmHFCMH6MziVU.css\";s:64:\"f7cdc92d01712cfc314332d160c432104f8d944a68ed9276f86638ec4a134307\";s:64:\"public://css/css_iSOJnLDdB_M5YlTbNyu4Shm28rMZCYkWxHKJpWkZaMI.css\";s:64:\"20f8eaf5847d9a8a6df28ecc9bcf2cd47f2354023590585b97ca5c054ae0e0a5\";s:64:\"public://css/css_Wu8npAzy16WmnnnWKxpexfgsAryolGGaX6yO3GWA5bU.css\";}'),('drupal_http_request_fails','b:1;'),('drupal_js_cache_files','a:21:{s:64:\"a571bc4156d0556568d7f04bc93f81c658b2e21fef9bb8229528c077ce9a0ccf\";s:61:\"public://js/js_UWQINlriydSoeSiGQxToOUdv493zEa7dpsXC1OtYlZU.js\";s:64:\"7a91c19f94141e8060b13e3547b197dff1ba6825afc145308ce75a59065d8db6\";s:61:\"public://js/js_R9UbiVw2xuTUI0GZoaqMDOdX0lrZtgX-ono8RVOUEVc.js\";s:64:\"f60eb1c0a46fe71b5fe748acf253931eb654e4fcdd61bcb5ac2288b95bff952a\";s:61:\"public://js/js_TWKm9-6PK6lnTvWvkAb3sZE01kZEDuEoVWsRRP4CQw0.js\";s:64:\"b7dc8837ae038c6648f318258c4622c3f00acf3e9dc6065f43f0541a24abf005\";s:61:\"public://js/js_L96nOzqC527LirBWMARuUiYA9asFKPoJMnaxLBFtv70.js\";s:64:\"7a18fd134b90ccf30f0402863e9066494a7da88bb630913d66f8276a4f54fc0e\";s:61:\"public://js/js_bQkfn7aPjbOOUYAAjRJY1-PavkNWRnzoF6KWmOgTATU.js\";s:64:\"1f3889d1c0e812119ea6362d1306b7dea7b4244f1467d613d5140dae41fbe4c5\";s:61:\"public://js/js_lHeL0WbAjSr6rQ_CBXVEajk8jKcw7r5-EPFG7ahYSrg.js\";s:64:\"663ea22b02dde38114a6b0699f42e9ca6561e5ddb58489838a9e3d1e675307ca\";s:61:\"public://js/js_1wpi0UumtaAe9d8YZVm7lLdDXXK_GratZ6gD3hJhX2U.js\";s:64:\"4ae9a95afa43ece34b1efb2f7cad7f62e2eb64479f41ef7d66bc6e7147a8966a\";s:61:\"public://js/js_vNfk0E4QpZNmnRYJCe6E7LXYcNSNtAJmZCBP8gL0YD0.js\";s:64:\"d288a3d4fd1d684aa28c8ded5d15ecd3339852d9ef898295700da3888b3df103\";s:61:\"public://js/js_w1BSSP0KCEq9B-bs6TR-25bhGd4cDkDSTytyRF9vAnc.js\";s:64:\"a4b4f29b9d2747f9d80f559999a2f12c7c2b286110d71c94051fd6c16e54c97d\";s:61:\"public://js/js_3yPY2LJLeRQY5OGdnvqeOkJjLzlvfKeJSgCIlYmHjFo.js\";s:64:\"2ab270dc6bccb352da6754bea668bd991ca0a85b2c27a842981bf99760e5badd\";s:61:\"public://js/js_7paS1_NOy7F7aD3OaVkfsvRQ1iHEalksPQ2ykVSNWiU.js\";s:64:\"9e02b1aa554513cf3837ef06812cc868f0cd48070121065f5e3331f171a876de\";s:61:\"public://js/js_TCEVSfM447-kpQ8c1tBfJ6NfHzfNFQMK4fBbAp2fD4A.js\";s:64:\"9ffaf1ac4fe200ad8ee4c7a72f633edff2f6526fb56dcc7acc6c5d63d7f79812\";s:61:\"public://js/js_-oa7SKnsotdEsBvqpsCgfqCd_gSb_G2dHr3KCIPISDg.js\";s:64:\"28f01ca041cbdc7d0948c263bd6e15ff08e7ebb7498537c5a90d983d77e73590\";s:61:\"public://js/js_cCh8cBg2pYLGqCOuEsro9kh6z0eyR0q9TdiaGObBQGc.js\";s:64:\"6b9c371a53422aa3cbd6ad68f15f7c00ddab90dd700b89bc7309478aaac4cbb8\";s:61:\"public://js/js_OWFQr5-otkScGoOyYRsvSI_3hEG9tYHnx4dH7c-RI1w.js\";s:64:\"088cd30db95d0c84748f0b57166b1f7e271999de9e159af0a80df486421b4e4a\";s:61:\"public://js/js_j_YagrHVoWKwAf-5SDDMjyaJTH9k6ZCp-2UBR3Cbf8Y.js\";s:64:\"b37548e4c0341bca47a139430f1cc50a67789e54ad2351b09c284b59baaa5660\";s:61:\"public://js/js_bNxBlt2omqX5sKNp1yYFhqytgKP1UjmY_0H1tejwAE4.js\";s:64:\"07e5effef2792ac7adb8397067062b210307ddc68cc17bbe8ae0da598d810ccb\";s:61:\"public://js/js_vIcoj3GW1vy6sBrkG9r7G7Zz-dvAZTxW-vus3iL1rTM.js\";s:64:\"a8d1aa86ebe8a8daf21e2de67a0fd2376ccd6685133b5ce6b267a0e46b757e1c\";s:61:\"public://js/js_UAXsnfr-3-6iYHMEMsc_hVUKZy8Kg29IFrCMY8TPaa0.js\";s:64:\"179ba294430e111268012b975fde1e5f7d550c16989fb1b88ad1e9bbf7548546\";s:61:\"public://js/js_y0ljG2A7zV1Tbk8rBM1ZjX499DZ-Q73zKvXtbsVHKJ0.js\";s:64:\"3368c8907a216193b42c6c41e1bd99ec043c58016a69ef161409c2e5ccfe16d9\";s:61:\"public://js/js_lHO3MVt06I6sKo3LAbfFAXtF_9sQadAgeP_DaofHLkY.js\";}'),('drupal_private_key','s:43:\"XGPPCG3iRt5IADvzzj1N_HarkGzj_6xpZpn2uofXy98\";'),('enable_revisions_page_external','i:1;'),('enable_revisions_page_landing_page','i:1;'),('enable_revisions_page_photo','i:1;'),('enable_revisions_page_press_release','i:1;'),('enable_revisions_page_profile','i:1;'),('enable_revisions_page_rotator','i:1;'),('enable_revisions_page_site_page','i:1;'),('entitycache_enabled','b:1;'),('entity_cache_tables_created','N;'),('features_codecache','a:14:{s:23:\"dhs_wcm_config_defaults\";a:3:{s:12:\"dependencies\";s:32:\"19c2974f2d03bb94c91b8a599c2536ae\";s:8:\"variable\";s:32:\"f18d6348fbf88e09dd06390714b127f0\";s:6:\"filter\";s:32:\"55595e15f2482355133a6462934d5929\";}s:16:\"dhs_wcm_external\";a:4:{s:12:\"dependencies\";s:32:\"2792ac3293c8e38ff67a2b5890232b1a\";s:8:\"variable\";s:32:\"6e2499eb48f4cf17a5455747877e56da\";s:5:\"field\";s:32:\"297e5f358165d240cc2acac8d5b40d3a\";s:4:\"node\";s:32:\"6ec1b4c778dfeeae9e3f94ae70e732a3\";}s:20:\"dhs_wcm_landing_page\";a:4:{s:12:\"dependencies\";s:32:\"fb1451b4f6fc9dc04d013e7c295c19ff\";s:8:\"variable\";s:32:\"e6b46549a74b7aebc3d92149ca132d30\";s:5:\"field\";s:32:\"e843bfed64a8210e454db911b576d1cc\";s:4:\"node\";s:32:\"aede171599d7b3d7cd1179240f1542c3\";}s:18:\"dhs_wcm_taxonomies\";a:3:{s:12:\"dependencies\";s:32:\"d585882ee96a5dbb616f98e55bfbbabb\";s:8:\"variable\";s:32:\"e6c4697955f30c303d0160989186ec7b\";s:8:\"taxonomy\";s:32:\"5a866c6d0c1809ceca35436c88a643e9\";}s:21:\"dhs_wcm_press_release\";a:5:{s:12:\"dependencies\";s:32:\"3ee57acc67b04a07b9fbd1cd7d10c1ef\";s:8:\"variable\";s:32:\"87f2cf6aba22abab1eee922c54963af0\";s:5:\"field\";s:32:\"e8092f9f326ab4d6d7394ecaf195945e\";s:4:\"node\";s:32:\"edfc2a193ed24231578f613194e21230\";s:10:\"views_view\";s:32:\"b4cc668fb0acf67bc6da65796410498c\";}s:17:\"dhs_wcm_site_page\";a:4:{s:12:\"dependencies\";s:32:\"fcf7acdd8817f9e8df0efc0aa46e6624\";s:8:\"variable\";s:32:\"32b5d95a0ac22aed6136317ce905c6e7\";s:5:\"field\";s:32:\"c72672cf6e2acee3ba3842738fb2e226\";s:4:\"node\";s:32:\"d3bebd38ec33404541ebb758ca76faa9\";}s:19:\"dhs_wcm_theme_style\";a:3:{s:12:\"dependencies\";s:32:\"93a1dfcb449553d452964d6c4797329a\";s:8:\"variable\";s:32:\"a03743788f17652fd6ea580748a3a66d\";s:3:\"box\";s:32:\"810dbb853a42a2bbb35edb93f7bd1f33\";}s:15:\"dhs_wcm_layouts\";a:6:{s:12:\"dependencies\";s:32:\"437712af57e4ec0712a6b2ac641cbeba\";s:8:\"variable\";s:32:\"16c678c8b680afcbc668dc5aee3a713c\";s:5:\"field\";s:32:\"b731f74ef622af1e2fb09aa522daa502\";s:3:\"box\";s:32:\"8ad94e0433db0409478211c165571427\";s:7:\"context\";s:32:\"71c1490be2cb5c3dea73b23b32b856f7\";s:17:\"entity_boxes_type\";s:32:\"fabbe12309cfbbdad68828f8e9efeb1a\";}s:13:\"dhs_wcm_photo\";a:6:{s:12:\"dependencies\";s:32:\"b1ffcfb9f570b3b2577a93683d39d4ce\";s:8:\"variable\";s:32:\"f761a87940c689557a96727c3a9a82e9\";s:5:\"field\";s:32:\"852a17db8cf3820c00be9c8f14bf854d\";s:17:\"entity_boxes_type\";s:32:\"25764a7df2db1c5d078f4746b9f3c36d\";s:4:\"node\";s:32:\"a3896bd791a24faa48e9c00323b1a683\";s:10:\"views_view\";s:32:\"2a5f8a686c5f27d2d9cfcef709c1b3c3\";}s:15:\"dhs_wcm_profile\";a:4:{s:12:\"dependencies\";s:32:\"d6e413ba2d4952678e9f95c6e0828e71\";s:8:\"variable\";s:32:\"71fc04ba50bc131842d0c062e0edd84f\";s:5:\"field\";s:32:\"680e28d26c898e3249d81fd339a02a92\";s:4:\"node\";s:32:\"0b3b04af81b7ce3ca8a3286dc77f1d8e\";}s:15:\"dhs_wcm_rotator\";a:4:{s:12:\"dependencies\";s:32:\"1b88f387ad6e6370389f9255e77e533c\";s:8:\"variable\";s:32:\"e0ae716e65eb3ba4604ae4e7c4e69d00\";s:5:\"field\";s:32:\"6ec0cd3dcff7b846031e47c51d005662\";s:4:\"node\";s:32:\"00863158ee5a968b5c18cdc6d5939ce2\";}s:16:\"dhs_wcm_workflow\";a:3:{s:12:\"dependencies\";s:32:\"74157da3e49af862ca229b075b1cf604\";s:8:\"variable\";s:32:\"f7e60458fcdf8554c06b799c04bc5610\";s:15:\"user_permission\";s:32:\"ff1fc4bf8a2db9e693399086c1474711\";}s:13:\"dhs_wcm_perms\";a:3:{s:12:\"dependencies\";s:32:\"bd045b87e7e6aedfb9c1df0091c5f658\";s:9:\"user_role\";s:32:\"50a71446553adb0971463e26f42e2941\";s:15:\"user_permission\";s:32:\"baef410a0ea79b90849eb42629831473\";}s:23:\"dhs_wcm_default_content\";a:4:{s:15:\"user_permission\";s:32:\"26064b30ac3585014a7bfb8360356c13\";s:12:\"dependencies\";s:32:\"b99cc583534a298102323651da169967\";s:7:\"content\";s:32:\"47cbb2cc01be76b350e64522b6c33a24\";s:18:\"content_menu_links\";s:32:\"e8ed6be427a5db4eca7b4fdb5e8f2cb0\";}}'),('features_ignored_orphans','a:0:{}'),('features_modules_changed','b:0;'),('features_semaphore','a:0:{}'),('field_bundle_settings_node__external','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"5\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__landing_page','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"5\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__nmc_about','a:2:{s:10:\"view_modes\";a:0:{}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:3:{s:5:\"title\";a:1:{s:6:\"weight\";s:2:\"-5\";}s:4:\"path\";a:1:{s:6:\"weight\";s:2:\"30\";}s:16:\"workbench_access\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__photo','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:3:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"5\";}s:16:\"workbench_access\";a:1:{s:6:\"weight\";s:1:\"0\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__press_release','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"9\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__profile','a:2:{s:10:\"view_modes\";a:8:{s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:1;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:1;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:1;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:2:\"11\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__rotator','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"4\";}}s:7:\"display\";a:0:{}}}'),('field_bundle_settings_node__site_page','a:2:{s:10:\"view_modes\";a:8:{s:6:\"teaser\";a:1:{s:15:\"custom_settings\";b:1;}s:4:\"full\";a:1:{s:15:\"custom_settings\";b:1;}s:3:\"rss\";a:1:{s:15:\"custom_settings\";b:0;}s:12:\"search_index\";a:1:{s:15:\"custom_settings\";b:0;}s:13:\"search_result\";a:1:{s:15:\"custom_settings\";b:0;}s:5:\"token\";a:1:{s:15:\"custom_settings\";b:0;}s:9:\"slideshow\";a:1:{s:15:\"custom_settings\";b:1;}s:8:\"carousel\";a:1:{s:15:\"custom_settings\";b:1;}}s:12:\"extra_fields\";a:2:{s:4:\"form\";a:2:{s:5:\"title\";a:1:{s:6:\"weight\";s:1:\"0\";}s:4:\"path\";a:1:{s:6:\"weight\";s:1:\"8\";}}s:7:\"display\";a:0:{}}}'),('file_default_scheme','s:6:\"public\";'),('file_public_path','s:19:\"sites/default/files\";'),('filter_fallback_format','s:10:\"plain_text\";'),('image_toolkit','s:2:\"gd\";'),('imce_profiles','a:1:{i:1;a:10:{s:4:\"name\";s:6:\"User-1\";s:7:\"usertab\";i:1;s:8:\"filesize\";i:0;s:5:\"quota\";i:0;s:7:\"tuquota\";i:0;s:10:\"extensions\";s:1:\"*\";s:10:\"dimensions\";s:9:\"1200x1200\";s:7:\"filenum\";i:0;s:11:\"directories\";a:1:{i:0;a:7:{s:4:\"name\";s:1:\".\";s:6:\"subnav\";i:1;s:6:\"browse\";i:1;s:6:\"upload\";i:1;s:5:\"thumb\";i:1;s:6:\"delete\";i:1;s:6:\"resize\";i:1;}}s:10:\"thumbnails\";a:3:{i:0;a:4:{s:4:\"name\";s:5:\"Small\";s:10:\"dimensions\";s:5:\"90x90\";s:6:\"prefix\";s:6:\"small_\";s:6:\"suffix\";s:0:\"\";}i:1;a:4:{s:4:\"name\";s:6:\"Medium\";s:10:\"dimensions\";s:7:\"120x120\";s:6:\"prefix\";s:7:\"medium_\";s:6:\"suffix\";s:0:\"\";}i:2;a:4:{s:4:\"name\";s:5:\"Large\";s:10:\"dimensions\";s:7:\"180x180\";s:6:\"prefix\";s:6:\"large_\";s:6:\"suffix\";s:0:\"\";}}}}'),('imce_roles_profiles','a:6:{i:3;a:2:{s:6:\"weight\";s:1:\"0\";s:10:\"public_pid\";i:0;}i:4;a:2:{s:6:\"weight\";s:1:\"0\";s:10:\"public_pid\";i:0;}i:6;a:2:{s:6:\"weight\";s:1:\"0\";s:10:\"public_pid\";i:0;}i:5;a:2:{s:6:\"weight\";s:1:\"0\";s:10:\"public_pid\";i:0;}i:2;a:2:{s:6:\"weight\";i:11;s:10:\"public_pid\";i:0;}i:1;a:2:{s:6:\"weight\";i:12;s:10:\"public_pid\";i:0;}}'),('imce_settings_absurls','i:0;'),('imce_settings_disable_private','i:1;'),('imce_settings_replace','s:1:\"0\";'),('imce_settings_textarea','s:0:\"\";'),('imce_settings_thumb_method','s:14:\"scale_and_crop\";'),('install_profile','s:7:\"dhs_wcm\";'),('install_task','s:4:\"done\";'),('install_time','i:1379957325;'),('javascript_parsed','a:30:{i:0;s:14:\"misc/drupal.js\";i:1;s:14:\"misc/jquery.js\";i:2;s:19:\"misc/jquery.once.js\";i:3;s:63:\"sites/all/modules/contrib/admin_menu/admin_devel/admin_devel.js\";i:4;s:53:\"sites/all/themes/omega/omega/js/omega-mediaqueries.js\";i:5;s:53:\"sites/all/themes/omega/omega/js/omega-equalheights.js\";i:6;s:21:\"misc/jquery.cookie.js\";i:7;s:19:\"misc/jquery.form.js\";i:8;s:12:\"misc/form.js\";i:9;s:16:\"misc/progress.js\";i:10;s:12:\"misc/ajax.js\";i:11;s:29:\"misc/ui/jquery.ui.core.min.js\";i:12;s:31:\"misc/ui/jquery.ui.widget.min.js\";i:13;s:31:\"misc/ui/jquery.ui.button.min.js\";i:14;s:30:\"misc/ui/jquery.ui.mouse.min.js\";i:15;s:34:\"misc/ui/jquery.ui.draggable.min.js\";i:16;s:33:\"misc/ui/jquery.ui.position.min.js\";i:17;s:34:\"misc/ui/jquery.ui.resizable.min.js\";i:18;s:31:\"misc/ui/jquery.ui.dialog.min.js\";i:19;s:60:\"sites/all/modules/contrib/views/js/jquery.ui.dialog.patch.js\";i:20;s:40:\"sites/all/modules/contrib/boxes/boxes.js\";i:21;s:26:\"modules/toolbar/toolbar.js\";i:22;s:16:\"misc/textarea.js\";i:23;s:14:\"misc/states.js\";i:24;s:16:\"misc/collapse.js\";i:25;s:21:\"misc/vertical-tabs.js\";i:26;s:19:\"misc/tableheader.js\";i:27;s:50:\"sites/all/modules/contrib/ctools/js/auto-submit.js\";i:28;s:20:\"misc/machine-name.js\";i:29;s:19:\"misc/tableselect.js\";}'),('language_content_type_nmc_about','s:1:\"0\";'),('language_content_type_photo','s:1:\"0\";'),('language_negotiation_language','a:0:{}'),('language_negotiation_language_content','a:1:{s:16:\"locale-interface\";a:2:{s:9:\"callbacks\";a:1:{s:8:\"language\";s:30:\"locale_language_from_interface\";}s:4:\"file\";s:19:\"includes/locale.inc\";}}'),('language_negotiation_language_url','a:2:{s:10:\"locale-url\";a:2:{s:9:\"callbacks\";a:3:{s:8:\"language\";s:24:\"locale_language_from_url\";s:8:\"switcher\";s:28:\"locale_language_switcher_url\";s:11:\"url_rewrite\";s:31:\"locale_language_url_rewrite_url\";}s:4:\"file\";s:19:\"includes/locale.inc\";}s:19:\"locale-url-fallback\";a:2:{s:9:\"callbacks\";a:1:{s:8:\"language\";s:28:\"locale_language_url_fallback\";}s:4:\"file\";s:19:\"includes/locale.inc\";}}'),('language_types','a:3:{s:8:\"language\";b:1;s:16:\"language_content\";b:0;s:12:\"language_url\";b:0;}'),('maintenance_mode','i:0;'),('memcache_wildcard_flushes','a:2:{s:5:\"cache\";a:6:{s:7:\"schema:\";a:1:{i:7;i:1466523720;}s:7:\"theme_r\";a:1:{i:14;i:1466523720;}s:7:\"entity_\";a:2:{i:12;i:1466523720;i:21;i:1466523762;}s:7:\"node_ty\";a:1:{i:11;i:1466523720;}s:7:\"context\";a:1:{i:7;i:1466523762;}s:7:\"plugins\";a:1:{i:15;i:1466523762;}}s:11:\"cache_field\";a:2:{s:11:\"field_info:\";a:1:{i:11;i:1466523720;}s:11:\"field_info_\";a:1:{i:17;i:1466523720;}}}'),('menu_expanded','a:0:{}'),('menu_masks','a:36:{i:0;i:501;i:1;i:250;i:2;i:245;i:3;i:125;i:4;i:124;i:5;i:123;i:6;i:122;i:7;i:121;i:8;i:117;i:9;i:112;i:10;i:63;i:11;i:62;i:12;i:61;i:13;i:60;i:14;i:59;i:15;i:58;i:16;i:44;i:17;i:42;i:18;i:31;i:19;i:30;i:20;i:29;i:21;i:28;i:22;i:24;i:23;i:23;i:24;i:21;i:25;i:15;i:26;i:14;i:27;i:13;i:28;i:12;i:29;i:11;i:30;i:7;i:31;i:6;i:32;i:5;i:33;i:3;i:34;i:2;i:35;i:1;}'),('menu_options_external','a:0:{}'),('menu_options_landing_page','a:1:{i:0;s:14:\"menu-left-menu\";}'),('menu_options_nmc_about','a:1:{i:0;s:9:\"main-menu\";}'),('menu_options_photo','a:0:{}'),('menu_options_press_release','a:1:{i:0;s:14:\"menu-left-menu\";}'),('menu_options_profile','a:0:{}'),('menu_options_rotator','a:0:{}'),('menu_options_site_page','a:1:{i:0;s:14:\"menu-left-menu\";}'),('menu_parent_external','s:11:\"main-menu:0\";'),('menu_parent_landing_page','s:16:\"menu-left-menu:0\";'),('menu_parent_nmc_about','s:11:\"main-menu:0\";'),('menu_parent_photo','s:11:\"main-menu:0\";'),('menu_parent_press_release','s:16:\"menu-left-menu:0\";'),('menu_parent_profile','s:11:\"main-menu:0\";'),('menu_parent_rotator','s:11:\"main-menu:0\";'),('menu_parent_site_page','s:16:\"menu-left-menu:0\";'),('module_filter_recent_modules','a:1:{s:13:\"module_filter\";i:1465305083;}'),('node_admin_theme','i:1;'),('node_content_enabled','b:1;'),('node_cron_last','s:10:\"1465842449\";'),('node_options_external','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_landing_page','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_nmc_about','a:2:{i:0;s:6:\"status\";i:1;s:7:\"promote\";}'),('node_options_photo','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_press_release','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_profile','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_rotator','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_options_site_page','a:2:{i:0;s:10:\"moderation\";i:1;s:8:\"revision\";}'),('node_preview_external','s:1:\"1\";'),('node_preview_landing_page','s:1:\"1\";'),('node_preview_nmc_about','s:1:\"1\";'),('node_preview_photo','s:1:\"1\";'),('node_preview_press_release','s:1:\"1\";'),('node_preview_profile','s:1:\"1\";'),('node_preview_rotator','s:1:\"1\";'),('node_preview_site_page','s:1:\"1\";'),('node_submitted_external','i:0;'),('node_submitted_landing_page','i:0;'),('node_submitted_nmc_about','i:0;'),('node_submitted_photo','i:0;'),('node_submitted_press_release','i:0;'),('node_submitted_profile','i:0;'),('node_submitted_rotator','i:0;'),('node_submitted_site_page','i:0;'),('page_cache_maximum_age','s:5:\"86400\";'),('page_compression','i:1;'),('page_manager_node_edit_disabled','b:1;'),('page_manager_node_view_disabled','b:0;'),('page_manager_search_disabled_node','b:1;'),('page_manager_user_view_disabled','b:1;'),('pathauto_blog_pattern','s:17:\"blogs/[user:name]\";'),('pathauto_forum_pattern','s:29:\"[term:vocabulary]/[term:name]\";'),('pathauto_node_external_pattern','s:0:\"\";'),('pathauto_node_landing_page_pattern','s:12:\"[node:title]\";'),('pathauto_node_pattern','s:32:\"[node:content-type]/[node:title]\";'),('pathauto_node_photo_pattern','s:0:\"\";'),('pathauto_node_press_release_pattern','s:104:\"[node:content-type]/[node:created:custom:Y]/[node:created:custom:m]/[node:created:custom:d]/[node:title]\";'),('pathauto_node_profile_pattern','s:0:\"\";'),('pathauto_node_rotator_pattern','s:0:\"\";'),('pathauto_node_site_page_pattern','s:12:\"[node:title]\";'),('pathauto_punctuation_hyphen','i:1;'),('pathauto_punctuation_underscore','s:1:\"1\";'),('pathauto_taxonomy_term_pattern','s:29:\"[term:vocabulary]/[term:name]\";'),('pathauto_taxonomy_term_tags_pattern','s:0:\"\";'),('pathauto_user_pattern','s:17:\"users/[user:name]\";'),('path_alias_whitelist','a:3:{s:4:\"node\";b:1;s:8:\"taxonomy\";b:1;s:4:\"user\";b:1;}'),('preprocess_css','i:1;'),('preprocess_js','i:1;'),('save_continue_external','s:19:\"Save and add fields\";'),('save_continue_landing_page','s:19:\"Save and add fields\";'),('save_continue_nmc_about','s:19:\"Save and add fields\";'),('save_continue_photo','s:19:\"Save and add fields\";'),('save_continue_rotator','s:19:\"Save and add fields\";'),('show_diff_inline_external','i:0;'),('show_diff_inline_landing_page','i:0;'),('show_diff_inline_photo','i:0;'),('show_diff_inline_press_release','i:0;'),('show_diff_inline_profile','i:0;'),('show_diff_inline_rotator','i:0;'),('show_diff_inline_site_page','i:0;'),('show_preview_changes_external','i:1;'),('show_preview_changes_landing_page','i:1;'),('show_preview_changes_photo','i:1;'),('show_preview_changes_press_release','i:1;'),('show_preview_changes_profile','i:1;'),('show_preview_changes_rotator','i:1;'),('show_preview_changes_site_page','i:1;'),('site_403','s:0:\"\";'),('site_404','s:0:\"\";'),('site_default_country','s:2:\"US\";'),('site_frontpage','s:4:\"node\";'),('site_mail','s:31:\"admin@edit-wcms-testint.dhs.gov\";'),('site_name','s:25:\"National Maritime Center \";'),('site_slogan','s:34:\"One Mission...One Team...One Voice\";'),('statistics_day_timestamp','i:1466554156;'),('theme_default','s:9:\"openomega\";'),('theme_dhs_wcm_theme_settings','a:386:{s:11:\"toggle_logo\";i:1;s:11:\"toggle_name\";i:1;s:13:\"toggle_slogan\";i:0;s:24:\"toggle_node_user_picture\";i:1;s:27:\"toggle_comment_user_picture\";i:1;s:32:\"toggle_comment_user_verification\";i:1;s:14:\"toggle_favicon\";i:1;s:16:\"toggle_main_menu\";i:1;s:21:\"toggle_secondary_menu\";i:0;s:12:\"default_logo\";i:1;s:9:\"logo_path\";s:0:\"\";s:11:\"logo_upload\";s:0:\"\";s:15:\"default_favicon\";i:1;s:12:\"favicon_path\";s:0:\"\";s:14:\"favicon_upload\";s:0:\"\";s:10:\"alpha_grid\";s:13:\"alpha_default\";s:16:\"alpha_responsive\";i:1;s:14:\"alpha_viewport\";i:1;s:28:\"alpha_viewport_initial_scale\";s:1:\"1\";s:24:\"alpha_viewport_min_scale\";s:1:\"1\";s:24:\"alpha_viewport_max_scale\";s:1:\"1\";s:29:\"alpha_viewport_user_scaleable\";i:0;s:27:\"alpha_primary_alpha_default\";s:6:\"normal\";s:44:\"alpha_layouts_alpha_default_fluid_responsive\";i:1;s:40:\"alpha_layouts_alpha_default_fluid_weight\";s:1:\"1\";s:39:\"alpha_layouts_alpha_default_fluid_media\";s:26:\"all and (min-width: 600px)\";s:45:\"alpha_layouts_alpha_default_normal_responsive\";i:1;s:41:\"alpha_layouts_alpha_default_normal_weight\";s:1:\"2\";s:40:\"alpha_layouts_alpha_default_normal_media\";s:144:\"all and (min-width: 980px) and (min-device-width: 980px), all and (max-device-width: 1024px) and (min-width: 1024px) and (orientation:landscape)\";s:45:\"alpha_layouts_alpha_default_narrow_responsive\";i:0;s:41:\"alpha_layouts_alpha_default_narrow_weight\";s:1:\"1\";s:40:\"alpha_layouts_alpha_default_narrow_media\";s:134:\"all and (min-width: 740px) and (min-device-width: 740px), (max-device-width: 800px) and (min-width: 740px) and (orientation:landscape)\";s:43:\"alpha_layouts_alpha_default_wide_responsive\";i:0;s:39:\"alpha_layouts_alpha_default_wide_weight\";s:1:\"3\";s:38:\"alpha_layouts_alpha_default_wide_media\";s:27:\"all and (min-width: 1220px)\";s:25:\"alpha_primary_alpha_fluid\";s:6:\"normal\";s:43:\"alpha_layouts_alpha_fluid_normal_responsive\";i:0;s:39:\"alpha_layouts_alpha_fluid_normal_weight\";s:1:\"0\";s:38:\"alpha_layouts_alpha_fluid_normal_media\";s:134:\"all and (min-width: 740px) and (min-device-width: 740px), (max-device-width: 800px) and (min-width: 740px) and (orientation:landscape)\";s:15:\"alpha_libraries\";a:3:{s:18:\"omega_mediaqueries\";s:18:\"omega_mediaqueries\";s:18:\"omega_equalheights\";s:18:\"omega_equalheights\";s:15:\"omega_formalize\";i:0;}s:9:\"alpha_css\";a:11:{s:15:\"alpha-reset.css\";s:15:\"alpha-reset.css\";s:16:\"alpha-mobile.css\";s:16:\"alpha-mobile.css\";s:15:\"alpha-alpha.css\";s:15:\"alpha-alpha.css\";s:14:\"omega-text.css\";s:14:\"omega-text.css\";s:18:\"omega-branding.css\";s:18:\"omega-branding.css\";s:14:\"omega-menu.css\";s:14:\"omega-menu.css\";s:17:\"omega-visuals.css\";s:17:\"omega-visuals.css\";s:10:\"global.css\";s:10:\"global.css\";s:18:\"dhs-wcm-global.css\";s:18:\"dhs-wcm-global.css\";s:15:\"omega-forms.css\";i:0;s:17:\"dhs-wcm-print.css\";i:0;}s:13:\"alpha_exclude\";a:31:{s:55:\"profiles/dhs_wcm/modules/contrib/date/date_api/date.css\";i:0;s:74:\"profiles/dhs_wcm/modules/contrib/date/date_popup/themes/datepicker.1.7.css\";i:0;s:29:\"modules/field/theme/field.css\";i:0;s:21:\"modules/node/node.css\";i:0;s:25:\"modules/search/search.css\";i:0;s:21:\"modules/user/user.css\";i:0;s:52:\"profiles/dhs_wcm/modules/contrib/views/css/views.css\";i:0;s:22:\"misc/vertical-tabs.css\";i:0;s:33:\"modules/aggregator/aggregator.css\";i:0;s:23:\"modules/block/block.css\";i:0;s:23:\"modules/dblog/dblog.css\";i:0;s:21:\"modules/file/file.css\";i:0;s:25:\"modules/filter/filter.css\";i:0;s:21:\"modules/help/help.css\";i:0;s:21:\"modules/menu/menu.css\";i:0;s:25:\"modules/openid/openid.css\";i:0;s:27:\"modules/profile/profile.css\";i:0;s:33:\"modules/statistics/statistics.css\";i:0;s:25:\"modules/syslog/syslog.css\";i:0;s:24:\"modules/system/admin.css\";i:0;s:30:\"modules/system/maintenance.css\";i:0;s:25:\"modules/system/system.css\";i:0;s:31:\"modules/system/system.admin.css\";i:0;s:30:\"modules/system/system.base.css\";i:0;s:37:\"modules/system/system.maintenance.css\";i:0;s:31:\"modules/system/system.menus.css\";i:0;s:34:\"modules/system/system.messages.css\";i:0;s:31:\"modules/system/system.theme.css\";i:0;s:29:\"modules/taxonomy/taxonomy.css\";i:0;s:27:\"modules/tracker/tracker.css\";i:0;s:25:\"modules/update/update.css\";i:0;}s:24:\"alpha_debug_block_toggle\";i:0;s:24:\"alpha_debug_block_active\";i:0;s:23:\"alpha_debug_grid_toggle\";i:0;s:23:\"alpha_debug_grid_active\";i:0;s:22:\"alpha_debug_grid_roles\";a:6:{i:1;i:0;i:2;i:0;i:3;i:0;i:7;i:0;i:4;i:0;i:5;i:0;}s:21:\"alpha_toggle_messages\";i:1;s:25:\"alpha_toggle_action_links\";i:1;s:17:\"alpha_toggle_tabs\";i:1;s:23:\"alpha_toggle_breadcrumb\";i:0;s:23:\"alpha_toggle_page_title\";i:1;s:23:\"alpha_toggle_feed_icons\";i:1;s:18:\"alpha_hidden_title\";i:0;s:22:\"alpha_hidden_site_name\";i:0;s:24:\"alpha_hidden_site_slogan\";i:0;s:36:\"alpha_region_dashboard_sidebar_force\";i:0;s:35:\"alpha_region_dashboard_sidebar_zone\";N;s:37:\"alpha_region_dashboard_sidebar_prefix\";s:1:\"0\";s:38:\"alpha_region_dashboard_sidebar_columns\";s:1:\"1\";s:37:\"alpha_region_dashboard_sidebar_suffix\";s:1:\"0\";s:37:\"alpha_region_dashboard_sidebar_weight\";s:3:\"-50\";s:39:\"alpha_region_dashboard_sidebar_position\";s:1:\"0\";s:34:\"alpha_region_dashboard_sidebar_css\";s:0:\"\";s:51:\"alpha_region_dashboard_sidebar_equal_height_element\";b:0;s:53:\"alpha_region_dashboard_sidebar_equal_height_container\";i:0;s:33:\"alpha_region_dashboard_main_force\";i:0;s:32:\"alpha_region_dashboard_main_zone\";N;s:34:\"alpha_region_dashboard_main_prefix\";s:1:\"0\";s:35:\"alpha_region_dashboard_main_columns\";s:1:\"1\";s:34:\"alpha_region_dashboard_main_suffix\";s:1:\"0\";s:34:\"alpha_region_dashboard_main_weight\";s:3:\"-50\";s:36:\"alpha_region_dashboard_main_position\";s:1:\"0\";s:31:\"alpha_region_dashboard_main_css\";s:0:\"\";s:48:\"alpha_region_dashboard_main_equal_height_element\";b:0;s:50:\"alpha_region_dashboard_main_equal_height_container\";i:0;s:37:\"alpha_region_dashboard_inactive_force\";i:0;s:36:\"alpha_region_dashboard_inactive_zone\";N;s:38:\"alpha_region_dashboard_inactive_prefix\";s:1:\"0\";s:39:\"alpha_region_dashboard_inactive_columns\";s:1:\"1\";s:38:\"alpha_region_dashboard_inactive_suffix\";s:1:\"0\";s:38:\"alpha_region_dashboard_inactive_weight\";s:3:\"-50\";s:40:\"alpha_region_dashboard_inactive_position\";s:1:\"0\";s:35:\"alpha_region_dashboard_inactive_css\";s:0:\"\";s:52:\"alpha_region_dashboard_inactive_equal_height_element\";b:0;s:54:\"alpha_region_dashboard_inactive_equal_height_container\";i:0;s:28:\"alpha_region_emergency_force\";i:0;s:27:\"alpha_region_emergency_zone\";N;s:29:\"alpha_region_emergency_prefix\";s:1:\"0\";s:30:\"alpha_region_emergency_columns\";s:1:\"1\";s:29:\"alpha_region_emergency_suffix\";s:1:\"0\";s:29:\"alpha_region_emergency_weight\";s:1:\"0\";s:31:\"alpha_region_emergency_position\";s:1:\"0\";s:26:\"alpha_region_emergency_css\";s:0:\"\";s:43:\"alpha_region_emergency_equal_height_element\";b:0;s:45:\"alpha_region_emergency_equal_height_container\";i:0;s:33:\"alpha_region_content_before_force\";i:0;s:32:\"alpha_region_content_before_zone\";N;s:34:\"alpha_region_content_before_prefix\";s:1:\"0\";s:35:\"alpha_region_content_before_columns\";s:1:\"1\";s:34:\"alpha_region_content_before_suffix\";s:1:\"0\";s:34:\"alpha_region_content_before_weight\";s:1:\"0\";s:36:\"alpha_region_content_before_position\";s:1:\"0\";s:31:\"alpha_region_content_before_css\";s:0:\"\";s:48:\"alpha_region_content_before_equal_height_element\";b:0;s:50:\"alpha_region_content_before_equal_height_container\";i:0;s:28:\"alpha_zone_emergency_wrapper\";i:0;s:26:\"alpha_zone_emergency_force\";i:0;s:26:\"alpha_zone_emergency_order\";i:0;s:28:\"alpha_zone_emergency_section\";N;s:27:\"alpha_zone_emergency_weight\";s:1:\"0\";s:28:\"alpha_zone_emergency_columns\";s:2:\"12\";s:28:\"alpha_zone_emergency_primary\";N;s:24:\"alpha_zone_emergency_css\";s:0:\"\";s:32:\"alpha_zone_emergency_wrapper_css\";s:0:\"\";s:43:\"alpha_zone_emergency_equal_height_container\";i:0;s:32:\"alpha_zone_prepostscript_wrapper\";i:0;s:30:\"alpha_zone_prepostscript_force\";i:0;s:30:\"alpha_zone_prepostscript_order\";i:0;s:32:\"alpha_zone_prepostscript_section\";N;s:31:\"alpha_zone_prepostscript_weight\";s:1:\"0\";s:32:\"alpha_zone_prepostscript_columns\";s:2:\"12\";s:32:\"alpha_zone_prepostscript_primary\";N;s:28:\"alpha_zone_prepostscript_css\";s:0:\"\";s:36:\"alpha_zone_prepostscript_wrapper_css\";s:0:\"\";s:47:\"alpha_zone_prepostscript_equal_height_container\";i:0;s:23:\"alpha_zone_user_wrapper\";i:1;s:21:\"alpha_zone_user_force\";i:0;s:21:\"alpha_zone_user_order\";i:0;s:23:\"alpha_zone_user_section\";s:6:\"header\";s:22:\"alpha_zone_user_weight\";s:1:\"1\";s:23:\"alpha_zone_user_columns\";s:2:\"12\";s:23:\"alpha_zone_user_primary\";N;s:19:\"alpha_zone_user_css\";s:0:\"\";s:27:\"alpha_zone_user_wrapper_css\";s:0:\"\";s:38:\"alpha_zone_user_equal_height_container\";i:0;s:29:\"alpha_region_user_first_force\";i:0;s:28:\"alpha_region_user_first_zone\";s:4:\"user\";s:30:\"alpha_region_user_first_prefix\";s:1:\"0\";s:31:\"alpha_region_user_first_columns\";s:2:\"12\";s:30:\"alpha_region_user_first_suffix\";s:1:\"0\";s:30:\"alpha_region_user_first_weight\";s:1:\"1\";s:32:\"alpha_region_user_first_position\";s:1:\"0\";s:27:\"alpha_region_user_first_css\";s:0:\"\";s:44:\"alpha_region_user_first_equal_height_element\";i:0;s:46:\"alpha_region_user_first_equal_height_container\";i:0;s:30:\"alpha_region_user_second_force\";i:0;s:29:\"alpha_region_user_second_zone\";s:4:\"user\";s:31:\"alpha_region_user_second_prefix\";s:1:\"0\";s:32:\"alpha_region_user_second_columns\";s:2:\"12\";s:31:\"alpha_region_user_second_suffix\";s:1:\"0\";s:31:\"alpha_region_user_second_weight\";s:1:\"2\";s:33:\"alpha_region_user_second_position\";s:1:\"0\";s:28:\"alpha_region_user_second_css\";s:0:\"\";s:45:\"alpha_region_user_second_equal_height_element\";i:0;s:47:\"alpha_region_user_second_equal_height_container\";i:0;s:27:\"alpha_zone_branding_wrapper\";i:1;s:25:\"alpha_zone_branding_force\";i:0;s:25:\"alpha_zone_branding_order\";i:0;s:27:\"alpha_zone_branding_section\";s:6:\"header\";s:26:\"alpha_zone_branding_weight\";s:1:\"2\";s:27:\"alpha_zone_branding_columns\";s:2:\"12\";s:27:\"alpha_zone_branding_primary\";N;s:23:\"alpha_zone_branding_css\";s:0:\"\";s:31:\"alpha_zone_branding_wrapper_css\";s:0:\"\";s:42:\"alpha_zone_branding_equal_height_container\";i:0;s:27:\"alpha_region_branding_force\";i:1;s:26:\"alpha_region_branding_zone\";s:8:\"branding\";s:28:\"alpha_region_branding_prefix\";s:1:\"0\";s:29:\"alpha_region_branding_columns\";s:2:\"12\";s:28:\"alpha_region_branding_suffix\";s:1:\"0\";s:28:\"alpha_region_branding_weight\";s:1:\"1\";s:30:\"alpha_region_branding_position\";s:1:\"0\";s:25:\"alpha_region_branding_css\";s:0:\"\";s:42:\"alpha_region_branding_equal_height_element\";i:0;s:44:\"alpha_region_branding_equal_height_container\";i:0;s:23:\"alpha_zone_menu_wrapper\";i:1;s:21:\"alpha_zone_menu_force\";i:0;s:21:\"alpha_zone_menu_order\";i:0;s:23:\"alpha_zone_menu_section\";s:6:\"header\";s:22:\"alpha_zone_menu_weight\";s:1:\"3\";s:23:\"alpha_zone_menu_columns\";s:2:\"12\";s:23:\"alpha_zone_menu_primary\";N;s:19:\"alpha_zone_menu_css\";s:0:\"\";s:27:\"alpha_zone_menu_wrapper_css\";s:0:\"\";s:38:\"alpha_zone_menu_equal_height_container\";i:0;s:23:\"alpha_region_menu_force\";i:1;s:22:\"alpha_region_menu_zone\";s:4:\"menu\";s:24:\"alpha_region_menu_prefix\";s:1:\"0\";s:25:\"alpha_region_menu_columns\";s:2:\"12\";s:24:\"alpha_region_menu_suffix\";s:1:\"0\";s:24:\"alpha_region_menu_weight\";s:1:\"1\";s:26:\"alpha_region_menu_position\";s:1:\"0\";s:21:\"alpha_region_menu_css\";s:0:\"\";s:38:\"alpha_region_menu_equal_height_element\";i:0;s:40:\"alpha_region_menu_equal_height_container\";i:0;s:25:\"alpha_zone_header_wrapper\";i:1;s:23:\"alpha_zone_header_force\";i:0;s:23:\"alpha_zone_header_order\";i:0;s:25:\"alpha_zone_header_section\";s:6:\"header\";s:24:\"alpha_zone_header_weight\";s:1:\"4\";s:25:\"alpha_zone_header_columns\";s:2:\"12\";s:25:\"alpha_zone_header_primary\";N;s:21:\"alpha_zone_header_css\";s:0:\"\";s:29:\"alpha_zone_header_wrapper_css\";s:0:\"\";s:40:\"alpha_zone_header_equal_height_container\";i:0;s:31:\"alpha_region_header_first_force\";i:0;s:30:\"alpha_region_header_first_zone\";s:6:\"header\";s:32:\"alpha_region_header_first_prefix\";s:1:\"0\";s:33:\"alpha_region_header_first_columns\";s:2:\"12\";s:32:\"alpha_region_header_first_suffix\";s:1:\"0\";s:32:\"alpha_region_header_first_weight\";s:1:\"1\";s:34:\"alpha_region_header_first_position\";s:1:\"0\";s:29:\"alpha_region_header_first_css\";s:0:\"\";s:46:\"alpha_region_header_first_equal_height_element\";i:0;s:48:\"alpha_region_header_first_equal_height_container\";i:0;s:32:\"alpha_region_header_second_force\";i:0;s:31:\"alpha_region_header_second_zone\";s:6:\"header\";s:33:\"alpha_region_header_second_prefix\";s:1:\"0\";s:34:\"alpha_region_header_second_columns\";s:2:\"12\";s:33:\"alpha_region_header_second_suffix\";s:1:\"0\";s:33:\"alpha_region_header_second_weight\";s:1:\"2\";s:35:\"alpha_region_header_second_position\";s:1:\"0\";s:30:\"alpha_region_header_second_css\";s:0:\"\";s:47:\"alpha_region_header_second_equal_height_element\";i:0;s:49:\"alpha_region_header_second_equal_height_container\";i:0;s:26:\"alpha_zone_preface_wrapper\";i:1;s:24:\"alpha_zone_preface_force\";i:0;s:24:\"alpha_zone_preface_order\";i:0;s:26:\"alpha_zone_preface_section\";s:7:\"content\";s:25:\"alpha_zone_preface_weight\";s:1:\"1\";s:26:\"alpha_zone_preface_columns\";s:2:\"12\";s:26:\"alpha_zone_preface_primary\";N;s:22:\"alpha_zone_preface_css\";s:0:\"\";s:30:\"alpha_zone_preface_wrapper_css\";s:0:\"\";s:41:\"alpha_zone_preface_equal_height_container\";i:0;s:32:\"alpha_region_preface_first_force\";i:0;s:31:\"alpha_region_preface_first_zone\";s:7:\"preface\";s:33:\"alpha_region_preface_first_prefix\";s:1:\"0\";s:34:\"alpha_region_preface_first_columns\";s:1:\"4\";s:33:\"alpha_region_preface_first_suffix\";s:1:\"0\";s:33:\"alpha_region_preface_first_weight\";s:1:\"1\";s:35:\"alpha_region_preface_first_position\";s:1:\"0\";s:30:\"alpha_region_preface_first_css\";s:0:\"\";s:47:\"alpha_region_preface_first_equal_height_element\";i:0;s:49:\"alpha_region_preface_first_equal_height_container\";i:0;s:33:\"alpha_region_preface_second_force\";i:0;s:32:\"alpha_region_preface_second_zone\";s:7:\"preface\";s:34:\"alpha_region_preface_second_prefix\";s:1:\"0\";s:35:\"alpha_region_preface_second_columns\";s:1:\"4\";s:34:\"alpha_region_preface_second_suffix\";s:1:\"0\";s:34:\"alpha_region_preface_second_weight\";s:1:\"2\";s:36:\"alpha_region_preface_second_position\";s:1:\"0\";s:31:\"alpha_region_preface_second_css\";s:0:\"\";s:48:\"alpha_region_preface_second_equal_height_element\";i:0;s:50:\"alpha_region_preface_second_equal_height_container\";i:0;s:32:\"alpha_region_preface_third_force\";i:0;s:31:\"alpha_region_preface_third_zone\";s:7:\"preface\";s:33:\"alpha_region_preface_third_prefix\";s:1:\"0\";s:34:\"alpha_region_preface_third_columns\";s:1:\"4\";s:33:\"alpha_region_preface_third_suffix\";s:1:\"0\";s:33:\"alpha_region_preface_third_weight\";s:1:\"3\";s:35:\"alpha_region_preface_third_position\";s:1:\"0\";s:30:\"alpha_region_preface_third_css\";s:0:\"\";s:47:\"alpha_region_preface_third_equal_height_element\";i:0;s:49:\"alpha_region_preface_third_equal_height_container\";i:0;s:26:\"alpha_zone_content_wrapper\";i:1;s:24:\"alpha_zone_content_force\";i:1;s:24:\"alpha_zone_content_order\";i:0;s:26:\"alpha_zone_content_section\";s:7:\"content\";s:25:\"alpha_zone_content_weight\";s:1:\"2\";s:26:\"alpha_zone_content_columns\";s:2:\"12\";s:26:\"alpha_zone_content_primary\";s:7:\"content\";s:22:\"alpha_zone_content_css\";s:0:\"\";s:30:\"alpha_zone_content_wrapper_css\";s:0:\"\";s:41:\"alpha_zone_content_equal_height_container\";i:0;s:32:\"alpha_region_sidebar_first_force\";i:0;s:31:\"alpha_region_sidebar_first_zone\";s:7:\"content\";s:33:\"alpha_region_sidebar_first_prefix\";s:1:\"0\";s:34:\"alpha_region_sidebar_first_columns\";s:1:\"3\";s:33:\"alpha_region_sidebar_first_suffix\";s:1:\"0\";s:33:\"alpha_region_sidebar_first_weight\";s:1:\"1\";s:35:\"alpha_region_sidebar_first_position\";s:1:\"0\";s:30:\"alpha_region_sidebar_first_css\";s:0:\"\";s:47:\"alpha_region_sidebar_first_equal_height_element\";i:0;s:49:\"alpha_region_sidebar_first_equal_height_container\";i:0;s:26:\"alpha_region_content_force\";i:0;s:25:\"alpha_region_content_zone\";s:7:\"content\";s:27:\"alpha_region_content_prefix\";s:1:\"0\";s:28:\"alpha_region_content_columns\";s:1:\"5\";s:27:\"alpha_region_content_suffix\";s:1:\"0\";s:27:\"alpha_region_content_weight\";s:1:\"2\";s:29:\"alpha_region_content_position\";s:1:\"0\";s:24:\"alpha_region_content_css\";s:0:\"\";s:41:\"alpha_region_content_equal_height_element\";i:0;s:43:\"alpha_region_content_equal_height_container\";i:0;s:33:\"alpha_region_sidebar_second_force\";i:0;s:32:\"alpha_region_sidebar_second_zone\";s:7:\"content\";s:34:\"alpha_region_sidebar_second_prefix\";s:1:\"0\";s:35:\"alpha_region_sidebar_second_columns\";s:1:\"4\";s:34:\"alpha_region_sidebar_second_suffix\";s:1:\"0\";s:34:\"alpha_region_sidebar_second_weight\";s:1:\"3\";s:36:\"alpha_region_sidebar_second_position\";s:1:\"0\";s:31:\"alpha_region_sidebar_second_css\";s:0:\"\";s:48:\"alpha_region_sidebar_second_equal_height_element\";i:0;s:50:\"alpha_region_sidebar_second_equal_height_container\";i:0;s:29:\"alpha_zone_postscript_wrapper\";i:1;s:27:\"alpha_zone_postscript_force\";i:0;s:27:\"alpha_zone_postscript_order\";i:0;s:29:\"alpha_zone_postscript_section\";s:7:\"content\";s:28:\"alpha_zone_postscript_weight\";s:1:\"3\";s:29:\"alpha_zone_postscript_columns\";s:2:\"12\";s:29:\"alpha_zone_postscript_primary\";N;s:25:\"alpha_zone_postscript_css\";s:0:\"\";s:33:\"alpha_zone_postscript_wrapper_css\";s:0:\"\";s:44:\"alpha_zone_postscript_equal_height_container\";i:0;s:35:\"alpha_region_postscript_first_force\";i:0;s:34:\"alpha_region_postscript_first_zone\";s:10:\"postscript\";s:36:\"alpha_region_postscript_first_prefix\";s:1:\"0\";s:37:\"alpha_region_postscript_first_columns\";s:1:\"3\";s:36:\"alpha_region_postscript_first_suffix\";s:1:\"0\";s:36:\"alpha_region_postscript_first_weight\";s:1:\"1\";s:38:\"alpha_region_postscript_first_position\";s:1:\"0\";s:33:\"alpha_region_postscript_first_css\";s:0:\"\";s:50:\"alpha_region_postscript_first_equal_height_element\";i:0;s:52:\"alpha_region_postscript_first_equal_height_container\";i:0;s:36:\"alpha_region_postscript_second_force\";i:0;s:35:\"alpha_region_postscript_second_zone\";s:10:\"postscript\";s:37:\"alpha_region_postscript_second_prefix\";s:1:\"0\";s:38:\"alpha_region_postscript_second_columns\";s:1:\"3\";s:37:\"alpha_region_postscript_second_suffix\";s:1:\"0\";s:37:\"alpha_region_postscript_second_weight\";s:1:\"2\";s:39:\"alpha_region_postscript_second_position\";s:1:\"0\";s:34:\"alpha_region_postscript_second_css\";s:0:\"\";s:51:\"alpha_region_postscript_second_equal_height_element\";i:0;s:53:\"alpha_region_postscript_second_equal_height_container\";i:0;s:35:\"alpha_region_postscript_third_force\";i:0;s:34:\"alpha_region_postscript_third_zone\";s:10:\"postscript\";s:36:\"alpha_region_postscript_third_prefix\";s:1:\"0\";s:37:\"alpha_region_postscript_third_columns\";s:1:\"3\";s:36:\"alpha_region_postscript_third_suffix\";s:1:\"0\";s:36:\"alpha_region_postscript_third_weight\";s:1:\"3\";s:38:\"alpha_region_postscript_third_position\";s:1:\"0\";s:33:\"alpha_region_postscript_third_css\";s:0:\"\";s:50:\"alpha_region_postscript_third_equal_height_element\";i:0;s:52:\"alpha_region_postscript_third_equal_height_container\";i:0;s:36:\"alpha_region_postscript_fourth_force\";i:0;s:35:\"alpha_region_postscript_fourth_zone\";s:10:\"postscript\";s:37:\"alpha_region_postscript_fourth_prefix\";s:1:\"0\";s:38:\"alpha_region_postscript_fourth_columns\";s:1:\"3\";s:37:\"alpha_region_postscript_fourth_suffix\";s:1:\"0\";s:37:\"alpha_region_postscript_fourth_weight\";s:1:\"4\";s:39:\"alpha_region_postscript_fourth_position\";s:1:\"0\";s:34:\"alpha_region_postscript_fourth_css\";s:0:\"\";s:51:\"alpha_region_postscript_fourth_equal_height_element\";i:0;s:53:\"alpha_region_postscript_fourth_equal_height_container\";i:0;s:25:\"alpha_zone_footer_wrapper\";i:1;s:23:\"alpha_zone_footer_force\";i:0;s:23:\"alpha_zone_footer_order\";i:0;s:25:\"alpha_zone_footer_section\";s:6:\"footer\";s:24:\"alpha_zone_footer_weight\";s:1:\"1\";s:25:\"alpha_zone_footer_columns\";s:2:\"12\";s:25:\"alpha_zone_footer_primary\";N;s:21:\"alpha_zone_footer_css\";s:0:\"\";s:29:\"alpha_zone_footer_wrapper_css\";s:0:\"\";s:40:\"alpha_zone_footer_equal_height_container\";i:0;s:31:\"alpha_region_footer_first_force\";i:0;s:30:\"alpha_region_footer_first_zone\";s:6:\"footer\";s:32:\"alpha_region_footer_first_prefix\";s:1:\"0\";s:33:\"alpha_region_footer_first_columns\";s:2:\"12\";s:32:\"alpha_region_footer_first_suffix\";s:1:\"0\";s:32:\"alpha_region_footer_first_weight\";s:1:\"1\";s:34:\"alpha_region_footer_first_position\";s:1:\"0\";s:29:\"alpha_region_footer_first_css\";s:0:\"\";s:46:\"alpha_region_footer_first_equal_height_element\";i:0;s:48:\"alpha_region_footer_first_equal_height_container\";i:0;s:32:\"alpha_region_footer_second_force\";i:1;s:31:\"alpha_region_footer_second_zone\";s:6:\"footer\";s:33:\"alpha_region_footer_second_prefix\";s:1:\"0\";s:34:\"alpha_region_footer_second_columns\";s:2:\"12\";s:33:\"alpha_region_footer_second_suffix\";s:1:\"0\";s:33:\"alpha_region_footer_second_weight\";s:1:\"2\";s:35:\"alpha_region_footer_second_position\";s:1:\"0\";s:30:\"alpha_region_footer_second_css\";s:0:\"\";s:47:\"alpha_region_footer_second_equal_height_element\";i:0;s:49:\"alpha_region_footer_second_equal_height_container\";i:0;}'),('theme_openomega_settings','a:365:{s:11:\"toggle_logo\";i:1;s:11:\"toggle_name\";i:1;s:13:\"toggle_slogan\";i:1;s:24:\"toggle_node_user_picture\";s:1:\"1\";s:27:\"toggle_comment_user_picture\";s:1:\"1\";s:32:\"toggle_comment_user_verification\";s:1:\"1\";s:14:\"toggle_favicon\";i:1;s:16:\"toggle_main_menu\";i:1;s:21:\"toggle_secondary_menu\";i:0;s:12:\"default_logo\";i:0;s:9:\"logo_path\";s:26:\"public://shield_exsm_1.png\";s:15:\"default_favicon\";i:1;s:12:\"favicon_path\";s:0:\"\";s:14:\"favicon_upload\";s:0:\"\";s:10:\"alpha_grid\";s:13:\"alpha_default\";s:16:\"alpha_responsive\";i:1;s:14:\"alpha_viewport\";i:1;s:28:\"alpha_viewport_initial_scale\";s:1:\"1\";s:24:\"alpha_viewport_min_scale\";s:1:\"1\";s:24:\"alpha_viewport_max_scale\";s:1:\"1\";s:29:\"alpha_viewport_user_scaleable\";i:0;s:27:\"alpha_primary_alpha_default\";s:6:\"normal\";s:44:\"alpha_layouts_alpha_default_fluid_responsive\";i:1;s:40:\"alpha_layouts_alpha_default_fluid_weight\";s:1:\"1\";s:39:\"alpha_layouts_alpha_default_fluid_media\";s:26:\"all and (min-width: 600px)\";s:45:\"alpha_layouts_alpha_default_normal_responsive\";i:1;s:41:\"alpha_layouts_alpha_default_normal_weight\";s:1:\"2\";s:40:\"alpha_layouts_alpha_default_normal_media\";s:144:\"all and (min-width: 980px) and (min-device-width: 980px), all and (max-device-width: 1024px) and (min-width: 1024px) and (orientation:landscape)\";s:45:\"alpha_layouts_alpha_default_narrow_responsive\";i:0;s:41:\"alpha_layouts_alpha_default_narrow_weight\";s:1:\"1\";s:40:\"alpha_layouts_alpha_default_narrow_media\";s:134:\"all and (min-width: 740px) and (min-device-width: 740px), (max-device-width: 800px) and (min-width: 740px) and (orientation:landscape)\";s:43:\"alpha_layouts_alpha_default_wide_responsive\";i:0;s:39:\"alpha_layouts_alpha_default_wide_weight\";s:1:\"3\";s:38:\"alpha_layouts_alpha_default_wide_media\";s:27:\"all and (min-width: 1220px)\";s:25:\"alpha_primary_alpha_fluid\";s:6:\"normal\";s:43:\"alpha_layouts_alpha_fluid_normal_responsive\";i:0;s:39:\"alpha_layouts_alpha_fluid_normal_weight\";s:1:\"0\";s:38:\"alpha_layouts_alpha_fluid_normal_media\";s:134:\"all and (min-width: 740px) and (min-device-width: 740px), (max-device-width: 800px) and (min-width: 740px) and (orientation:landscape)\";s:15:\"alpha_libraries\";a:3:{s:18:\"omega_mediaqueries\";s:18:\"omega_mediaqueries\";s:18:\"omega_equalheights\";s:18:\"omega_equalheights\";s:15:\"omega_formalize\";i:0;}s:9:\"alpha_css\";a:17:{s:15:\"alpha-reset.css\";s:15:\"alpha-reset.css\";s:16:\"alpha-mobile.css\";s:16:\"alpha-mobile.css\";s:15:\"alpha-alpha.css\";s:15:\"alpha-alpha.css\";s:14:\"omega-text.css\";s:14:\"omega-text.css\";s:18:\"omega-branding.css\";s:18:\"omega-branding.css\";s:14:\"omega-menu.css\";s:14:\"omega-menu.css\";s:17:\"omega-visuals.css\";s:17:\"omega-visuals.css\";s:10:\"global.css\";s:10:\"global.css\";s:28:\"features/openpublic_blog.css\";s:28:\"features/openpublic_blog.css\";s:37:\"features/openpublic_breaking_news.css\";s:37:\"features/openpublic_breaking_news.css\";s:32:\"features/openpublic_document.css\";s:32:\"features/openpublic_document.css\";s:33:\"features/openpublic_promotion.css\";s:33:\"features/openpublic_promotion.css\";s:29:\"features/openpublic_event.css\";s:29:\"features/openpublic_event.css\";s:30:\"features/openpublic_person.css\";s:30:\"features/openpublic_person.css\";s:37:\"features/openpublic_press_release.css\";s:37:\"features/openpublic_press_release.css\";s:31:\"features/openpublic_webform.css\";s:31:\"features/openpublic_webform.css\";s:15:\"omega-forms.css\";i:0;}s:13:\"alpha_exclude\";a:31:{s:48:\"sites/all/modules/contrib/date/date_api/date.css\";i:0;s:67:\"sites/all/modules/contrib/date/date_popup/themes/datepicker.1.7.css\";i:0;s:29:\"modules/field/theme/field.css\";i:0;s:21:\"modules/node/node.css\";i:0;s:25:\"modules/search/search.css\";i:0;s:21:\"modules/user/user.css\";i:0;s:45:\"sites/all/modules/contrib/views/css/views.css\";i:0;s:22:\"misc/vertical-tabs.css\";i:0;s:33:\"modules/aggregator/aggregator.css\";i:0;s:23:\"modules/block/block.css\";i:0;s:23:\"modules/dblog/dblog.css\";i:0;s:21:\"modules/file/file.css\";i:0;s:25:\"modules/filter/filter.css\";i:0;s:21:\"modules/help/help.css\";i:0;s:21:\"modules/menu/menu.css\";i:0;s:25:\"modules/openid/openid.css\";i:0;s:27:\"modules/profile/profile.css\";i:0;s:33:\"modules/statistics/statistics.css\";i:0;s:25:\"modules/syslog/syslog.css\";i:0;s:24:\"modules/system/admin.css\";i:0;s:30:\"modules/system/maintenance.css\";i:0;s:25:\"modules/system/system.css\";i:0;s:31:\"modules/system/system.admin.css\";i:0;s:30:\"modules/system/system.base.css\";i:0;s:37:\"modules/system/system.maintenance.css\";i:0;s:31:\"modules/system/system.menus.css\";i:0;s:34:\"modules/system/system.messages.css\";i:0;s:31:\"modules/system/system.theme.css\";i:0;s:29:\"modules/taxonomy/taxonomy.css\";i:0;s:27:\"modules/tracker/tracker.css\";i:0;s:25:\"modules/update/update.css\";i:0;}s:24:\"alpha_debug_block_toggle\";i:0;s:24:\"alpha_debug_block_active\";i:0;s:23:\"alpha_debug_grid_toggle\";i:0;s:23:\"alpha_debug_grid_active\";i:0;s:22:\"alpha_debug_grid_roles\";a:6:{i:1;i:0;i:2;i:0;i:3;i:0;i:6;i:0;i:4;i:0;i:5;i:0;}s:21:\"alpha_toggle_messages\";i:1;s:25:\"alpha_toggle_action_links\";i:1;s:17:\"alpha_toggle_tabs\";i:1;s:23:\"alpha_toggle_breadcrumb\";i:0;s:23:\"alpha_toggle_page_title\";i:1;s:23:\"alpha_toggle_feed_icons\";i:1;s:18:\"alpha_hidden_title\";i:0;s:22:\"alpha_hidden_site_name\";i:0;s:24:\"alpha_hidden_site_slogan\";i:0;s:36:\"alpha_region_dashboard_sidebar_force\";i:0;s:35:\"alpha_region_dashboard_sidebar_zone\";N;s:37:\"alpha_region_dashboard_sidebar_prefix\";s:1:\"0\";s:38:\"alpha_region_dashboard_sidebar_columns\";s:1:\"1\";s:37:\"alpha_region_dashboard_sidebar_suffix\";s:1:\"0\";s:37:\"alpha_region_dashboard_sidebar_weight\";s:3:\"-50\";s:39:\"alpha_region_dashboard_sidebar_position\";s:1:\"0\";s:34:\"alpha_region_dashboard_sidebar_css\";s:0:\"\";s:51:\"alpha_region_dashboard_sidebar_equal_height_element\";b:0;s:53:\"alpha_region_dashboard_sidebar_equal_height_container\";i:0;s:33:\"alpha_region_dashboard_main_force\";i:0;s:32:\"alpha_region_dashboard_main_zone\";N;s:34:\"alpha_region_dashboard_main_prefix\";s:1:\"0\";s:35:\"alpha_region_dashboard_main_columns\";s:1:\"1\";s:34:\"alpha_region_dashboard_main_suffix\";s:1:\"0\";s:34:\"alpha_region_dashboard_main_weight\";s:3:\"-50\";s:36:\"alpha_region_dashboard_main_position\";s:1:\"0\";s:31:\"alpha_region_dashboard_main_css\";s:0:\"\";s:48:\"alpha_region_dashboard_main_equal_height_element\";b:0;s:50:\"alpha_region_dashboard_main_equal_height_container\";i:0;s:37:\"alpha_region_dashboard_inactive_force\";i:0;s:36:\"alpha_region_dashboard_inactive_zone\";N;s:38:\"alpha_region_dashboard_inactive_prefix\";s:1:\"0\";s:39:\"alpha_region_dashboard_inactive_columns\";s:1:\"1\";s:38:\"alpha_region_dashboard_inactive_suffix\";s:1:\"0\";s:38:\"alpha_region_dashboard_inactive_weight\";s:3:\"-50\";s:40:\"alpha_region_dashboard_inactive_position\";s:1:\"0\";s:35:\"alpha_region_dashboard_inactive_css\";s:0:\"\";s:52:\"alpha_region_dashboard_inactive_equal_height_element\";b:0;s:54:\"alpha_region_dashboard_inactive_equal_height_container\";i:0;s:23:\"alpha_zone_user_wrapper\";i:1;s:21:\"alpha_zone_user_force\";i:0;s:21:\"alpha_zone_user_order\";i:0;s:23:\"alpha_zone_user_section\";s:6:\"header\";s:22:\"alpha_zone_user_weight\";s:1:\"1\";s:23:\"alpha_zone_user_columns\";s:2:\"12\";s:23:\"alpha_zone_user_primary\";N;s:19:\"alpha_zone_user_css\";s:0:\"\";s:27:\"alpha_zone_user_wrapper_css\";s:0:\"\";s:38:\"alpha_zone_user_equal_height_container\";i:0;s:29:\"alpha_region_user_first_force\";i:0;s:28:\"alpha_region_user_first_zone\";s:4:\"user\";s:30:\"alpha_region_user_first_prefix\";s:1:\"0\";s:31:\"alpha_region_user_first_columns\";s:2:\"12\";s:30:\"alpha_region_user_first_suffix\";s:1:\"0\";s:30:\"alpha_region_user_first_weight\";s:1:\"1\";s:32:\"alpha_region_user_first_position\";s:1:\"0\";s:27:\"alpha_region_user_first_css\";s:0:\"\";s:44:\"alpha_region_user_first_equal_height_element\";i:0;s:46:\"alpha_region_user_first_equal_height_container\";i:0;s:30:\"alpha_region_user_second_force\";i:0;s:29:\"alpha_region_user_second_zone\";s:4:\"user\";s:31:\"alpha_region_user_second_prefix\";s:1:\"0\";s:32:\"alpha_region_user_second_columns\";s:2:\"12\";s:31:\"alpha_region_user_second_suffix\";s:1:\"0\";s:31:\"alpha_region_user_second_weight\";s:1:\"2\";s:33:\"alpha_region_user_second_position\";s:1:\"0\";s:28:\"alpha_region_user_second_css\";s:0:\"\";s:45:\"alpha_region_user_second_equal_height_element\";i:0;s:47:\"alpha_region_user_second_equal_height_container\";i:0;s:27:\"alpha_zone_branding_wrapper\";i:1;s:25:\"alpha_zone_branding_force\";i:0;s:25:\"alpha_zone_branding_order\";i:0;s:27:\"alpha_zone_branding_section\";s:6:\"header\";s:26:\"alpha_zone_branding_weight\";s:1:\"2\";s:27:\"alpha_zone_branding_columns\";s:2:\"12\";s:27:\"alpha_zone_branding_primary\";N;s:23:\"alpha_zone_branding_css\";s:0:\"\";s:31:\"alpha_zone_branding_wrapper_css\";s:0:\"\";s:42:\"alpha_zone_branding_equal_height_container\";i:0;s:27:\"alpha_region_branding_force\";i:1;s:26:\"alpha_region_branding_zone\";s:8:\"branding\";s:28:\"alpha_region_branding_prefix\";s:1:\"0\";s:29:\"alpha_region_branding_columns\";s:2:\"12\";s:28:\"alpha_region_branding_suffix\";s:1:\"0\";s:28:\"alpha_region_branding_weight\";s:1:\"1\";s:30:\"alpha_region_branding_position\";s:1:\"0\";s:25:\"alpha_region_branding_css\";s:0:\"\";s:42:\"alpha_region_branding_equal_height_element\";i:0;s:44:\"alpha_region_branding_equal_height_container\";i:0;s:23:\"alpha_zone_menu_wrapper\";i:1;s:21:\"alpha_zone_menu_force\";i:0;s:21:\"alpha_zone_menu_order\";i:0;s:23:\"alpha_zone_menu_section\";s:6:\"header\";s:22:\"alpha_zone_menu_weight\";s:1:\"3\";s:23:\"alpha_zone_menu_columns\";s:2:\"16\";s:23:\"alpha_zone_menu_primary\";s:4:\"menu\";s:19:\"alpha_zone_menu_css\";s:0:\"\";s:27:\"alpha_zone_menu_wrapper_css\";s:0:\"\";s:38:\"alpha_zone_menu_equal_height_container\";i:0;s:23:\"alpha_region_menu_force\";i:1;s:22:\"alpha_region_menu_zone\";s:4:\"menu\";s:24:\"alpha_region_menu_prefix\";s:1:\"0\";s:25:\"alpha_region_menu_columns\";s:2:\"12\";s:24:\"alpha_region_menu_suffix\";s:1:\"0\";s:24:\"alpha_region_menu_weight\";s:1:\"1\";s:26:\"alpha_region_menu_position\";s:1:\"0\";s:21:\"alpha_region_menu_css\";s:0:\"\";s:38:\"alpha_region_menu_equal_height_element\";i:0;s:40:\"alpha_region_menu_equal_height_container\";i:0;s:25:\"alpha_zone_header_wrapper\";i:1;s:23:\"alpha_zone_header_force\";i:0;s:23:\"alpha_zone_header_order\";i:0;s:25:\"alpha_zone_header_section\";s:6:\"header\";s:24:\"alpha_zone_header_weight\";s:1:\"4\";s:25:\"alpha_zone_header_columns\";s:2:\"12\";s:25:\"alpha_zone_header_primary\";N;s:21:\"alpha_zone_header_css\";s:0:\"\";s:29:\"alpha_zone_header_wrapper_css\";s:0:\"\";s:40:\"alpha_zone_header_equal_height_container\";i:0;s:31:\"alpha_region_header_first_force\";i:0;s:30:\"alpha_region_header_first_zone\";s:6:\"header\";s:32:\"alpha_region_header_first_prefix\";s:1:\"0\";s:33:\"alpha_region_header_first_columns\";s:2:\"12\";s:32:\"alpha_region_header_first_suffix\";s:1:\"0\";s:32:\"alpha_region_header_first_weight\";s:1:\"1\";s:34:\"alpha_region_header_first_position\";s:1:\"0\";s:29:\"alpha_region_header_first_css\";s:0:\"\";s:46:\"alpha_region_header_first_equal_height_element\";i:0;s:48:\"alpha_region_header_first_equal_height_container\";i:0;s:32:\"alpha_region_header_second_force\";i:0;s:31:\"alpha_region_header_second_zone\";s:6:\"header\";s:33:\"alpha_region_header_second_prefix\";s:1:\"0\";s:34:\"alpha_region_header_second_columns\";s:2:\"12\";s:33:\"alpha_region_header_second_suffix\";s:1:\"0\";s:33:\"alpha_region_header_second_weight\";s:1:\"2\";s:35:\"alpha_region_header_second_position\";s:1:\"0\";s:30:\"alpha_region_header_second_css\";s:0:\"\";s:47:\"alpha_region_header_second_equal_height_element\";i:0;s:49:\"alpha_region_header_second_equal_height_container\";i:0;s:26:\"alpha_zone_preface_wrapper\";i:1;s:24:\"alpha_zone_preface_force\";i:0;s:24:\"alpha_zone_preface_order\";i:0;s:26:\"alpha_zone_preface_section\";s:7:\"content\";s:25:\"alpha_zone_preface_weight\";s:1:\"1\";s:26:\"alpha_zone_preface_columns\";s:2:\"12\";s:26:\"alpha_zone_preface_primary\";N;s:22:\"alpha_zone_preface_css\";s:0:\"\";s:30:\"alpha_zone_preface_wrapper_css\";s:0:\"\";s:41:\"alpha_zone_preface_equal_height_container\";i:0;s:32:\"alpha_region_preface_first_force\";i:0;s:31:\"alpha_region_preface_first_zone\";s:7:\"preface\";s:33:\"alpha_region_preface_first_prefix\";s:1:\"0\";s:34:\"alpha_region_preface_first_columns\";s:1:\"4\";s:33:\"alpha_region_preface_first_suffix\";s:1:\"0\";s:33:\"alpha_region_preface_first_weight\";s:1:\"1\";s:35:\"alpha_region_preface_first_position\";s:1:\"0\";s:30:\"alpha_region_preface_first_css\";s:0:\"\";s:47:\"alpha_region_preface_first_equal_height_element\";i:0;s:49:\"alpha_region_preface_first_equal_height_container\";i:0;s:33:\"alpha_region_preface_second_force\";i:0;s:32:\"alpha_region_preface_second_zone\";s:7:\"preface\";s:34:\"alpha_region_preface_second_prefix\";s:1:\"0\";s:35:\"alpha_region_preface_second_columns\";s:1:\"4\";s:34:\"alpha_region_preface_second_suffix\";s:1:\"0\";s:34:\"alpha_region_preface_second_weight\";s:1:\"2\";s:36:\"alpha_region_preface_second_position\";s:1:\"0\";s:31:\"alpha_region_preface_second_css\";s:0:\"\";s:48:\"alpha_region_preface_second_equal_height_element\";i:0;s:50:\"alpha_region_preface_second_equal_height_container\";i:0;s:32:\"alpha_region_preface_third_force\";i:0;s:31:\"alpha_region_preface_third_zone\";s:7:\"preface\";s:33:\"alpha_region_preface_third_prefix\";s:1:\"0\";s:34:\"alpha_region_preface_third_columns\";s:1:\"4\";s:33:\"alpha_region_preface_third_suffix\";s:1:\"0\";s:33:\"alpha_region_preface_third_weight\";s:1:\"3\";s:35:\"alpha_region_preface_third_position\";s:1:\"0\";s:30:\"alpha_region_preface_third_css\";s:0:\"\";s:47:\"alpha_region_preface_third_equal_height_element\";i:0;s:49:\"alpha_region_preface_third_equal_height_container\";i:0;s:33:\"alpha_region_preface_fourth_force\";i:0;s:32:\"alpha_region_preface_fourth_zone\";s:7:\"preface\";s:34:\"alpha_region_preface_fourth_prefix\";s:1:\"0\";s:35:\"alpha_region_preface_fourth_columns\";s:1:\"8\";s:34:\"alpha_region_preface_fourth_suffix\";s:1:\"0\";s:34:\"alpha_region_preface_fourth_weight\";s:1:\"4\";s:36:\"alpha_region_preface_fourth_position\";s:1:\"0\";s:31:\"alpha_region_preface_fourth_css\";s:0:\"\";s:48:\"alpha_region_preface_fourth_equal_height_element\";i:0;s:50:\"alpha_region_preface_fourth_equal_height_container\";i:0;s:32:\"alpha_region_preface_fifth_force\";i:0;s:31:\"alpha_region_preface_fifth_zone\";s:7:\"preface\";s:33:\"alpha_region_preface_fifth_prefix\";s:1:\"0\";s:34:\"alpha_region_preface_fifth_columns\";s:1:\"4\";s:33:\"alpha_region_preface_fifth_suffix\";s:1:\"0\";s:33:\"alpha_region_preface_fifth_weight\";s:1:\"5\";s:35:\"alpha_region_preface_fifth_position\";s:1:\"0\";s:30:\"alpha_region_preface_fifth_css\";s:0:\"\";s:47:\"alpha_region_preface_fifth_equal_height_element\";i:0;s:49:\"alpha_region_preface_fifth_equal_height_container\";i:0;s:26:\"alpha_zone_content_wrapper\";i:1;s:24:\"alpha_zone_content_force\";i:1;s:24:\"alpha_zone_content_order\";i:0;s:26:\"alpha_zone_content_section\";s:7:\"content\";s:25:\"alpha_zone_content_weight\";s:1:\"2\";s:26:\"alpha_zone_content_columns\";s:2:\"12\";s:26:\"alpha_zone_content_primary\";s:7:\"content\";s:22:\"alpha_zone_content_css\";s:0:\"\";s:30:\"alpha_zone_content_wrapper_css\";s:0:\"\";s:41:\"alpha_zone_content_equal_height_container\";i:0;s:32:\"alpha_region_sidebar_first_force\";i:0;s:31:\"alpha_region_sidebar_first_zone\";s:7:\"content\";s:33:\"alpha_region_sidebar_first_prefix\";s:1:\"0\";s:34:\"alpha_region_sidebar_first_columns\";s:1:\"3\";s:33:\"alpha_region_sidebar_first_suffix\";s:1:\"0\";s:33:\"alpha_region_sidebar_first_weight\";s:1:\"1\";s:35:\"alpha_region_sidebar_first_position\";s:1:\"0\";s:30:\"alpha_region_sidebar_first_css\";s:0:\"\";s:47:\"alpha_region_sidebar_first_equal_height_element\";i:0;s:49:\"alpha_region_sidebar_first_equal_height_container\";i:0;s:26:\"alpha_region_content_force\";i:0;s:25:\"alpha_region_content_zone\";s:7:\"content\";s:27:\"alpha_region_content_prefix\";s:1:\"0\";s:28:\"alpha_region_content_columns\";s:1:\"5\";s:27:\"alpha_region_content_suffix\";s:1:\"0\";s:27:\"alpha_region_content_weight\";s:1:\"2\";s:29:\"alpha_region_content_position\";s:1:\"0\";s:24:\"alpha_region_content_css\";s:0:\"\";s:41:\"alpha_region_content_equal_height_element\";i:0;s:43:\"alpha_region_content_equal_height_container\";i:0;s:33:\"alpha_region_sidebar_second_force\";i:0;s:32:\"alpha_region_sidebar_second_zone\";s:7:\"content\";s:34:\"alpha_region_sidebar_second_prefix\";s:1:\"0\";s:35:\"alpha_region_sidebar_second_columns\";s:1:\"4\";s:34:\"alpha_region_sidebar_second_suffix\";s:1:\"0\";s:34:\"alpha_region_sidebar_second_weight\";s:1:\"3\";s:36:\"alpha_region_sidebar_second_position\";s:1:\"0\";s:31:\"alpha_region_sidebar_second_css\";s:0:\"\";s:48:\"alpha_region_sidebar_second_equal_height_element\";i:0;s:50:\"alpha_region_sidebar_second_equal_height_container\";i:0;s:29:\"alpha_zone_postscript_wrapper\";i:1;s:27:\"alpha_zone_postscript_force\";i:0;s:27:\"alpha_zone_postscript_order\";i:0;s:29:\"alpha_zone_postscript_section\";s:7:\"content\";s:28:\"alpha_zone_postscript_weight\";s:1:\"3\";s:29:\"alpha_zone_postscript_columns\";s:2:\"12\";s:29:\"alpha_zone_postscript_primary\";N;s:25:\"alpha_zone_postscript_css\";s:0:\"\";s:33:\"alpha_zone_postscript_wrapper_css\";s:0:\"\";s:44:\"alpha_zone_postscript_equal_height_container\";i:0;s:35:\"alpha_region_postscript_first_force\";i:0;s:34:\"alpha_region_postscript_first_zone\";s:10:\"postscript\";s:36:\"alpha_region_postscript_first_prefix\";s:1:\"0\";s:37:\"alpha_region_postscript_first_columns\";s:1:\"3\";s:36:\"alpha_region_postscript_first_suffix\";s:1:\"0\";s:36:\"alpha_region_postscript_first_weight\";s:1:\"1\";s:38:\"alpha_region_postscript_first_position\";s:1:\"0\";s:33:\"alpha_region_postscript_first_css\";s:0:\"\";s:50:\"alpha_region_postscript_first_equal_height_element\";i:0;s:52:\"alpha_region_postscript_first_equal_height_container\";i:0;s:36:\"alpha_region_postscript_second_force\";i:0;s:35:\"alpha_region_postscript_second_zone\";s:10:\"postscript\";s:37:\"alpha_region_postscript_second_prefix\";s:1:\"0\";s:38:\"alpha_region_postscript_second_columns\";s:1:\"3\";s:37:\"alpha_region_postscript_second_suffix\";s:1:\"0\";s:37:\"alpha_region_postscript_second_weight\";s:1:\"2\";s:39:\"alpha_region_postscript_second_position\";s:1:\"0\";s:34:\"alpha_region_postscript_second_css\";s:0:\"\";s:51:\"alpha_region_postscript_second_equal_height_element\";i:0;s:53:\"alpha_region_postscript_second_equal_height_container\";i:0;s:35:\"alpha_region_postscript_third_force\";i:0;s:34:\"alpha_region_postscript_third_zone\";s:10:\"postscript\";s:36:\"alpha_region_postscript_third_prefix\";s:1:\"0\";s:37:\"alpha_region_postscript_third_columns\";s:1:\"3\";s:36:\"alpha_region_postscript_third_suffix\";s:1:\"0\";s:36:\"alpha_region_postscript_third_weight\";s:1:\"3\";s:38:\"alpha_region_postscript_third_position\";s:1:\"0\";s:33:\"alpha_region_postscript_third_css\";s:0:\"\";s:50:\"alpha_region_postscript_third_equal_height_element\";i:0;s:52:\"alpha_region_postscript_third_equal_height_container\";i:0;s:36:\"alpha_region_postscript_fourth_force\";i:0;s:35:\"alpha_region_postscript_fourth_zone\";s:10:\"postscript\";s:37:\"alpha_region_postscript_fourth_prefix\";s:1:\"0\";s:38:\"alpha_region_postscript_fourth_columns\";s:1:\"3\";s:37:\"alpha_region_postscript_fourth_suffix\";s:1:\"0\";s:37:\"alpha_region_postscript_fourth_weight\";s:1:\"4\";s:39:\"alpha_region_postscript_fourth_position\";s:1:\"0\";s:34:\"alpha_region_postscript_fourth_css\";s:0:\"\";s:51:\"alpha_region_postscript_fourth_equal_height_element\";i:0;s:53:\"alpha_region_postscript_fourth_equal_height_container\";i:0;s:25:\"alpha_zone_footer_wrapper\";i:1;s:23:\"alpha_zone_footer_force\";i:0;s:23:\"alpha_zone_footer_order\";i:0;s:25:\"alpha_zone_footer_section\";s:6:\"footer\";s:24:\"alpha_zone_footer_weight\";s:1:\"1\";s:25:\"alpha_zone_footer_columns\";s:2:\"12\";s:25:\"alpha_zone_footer_primary\";N;s:21:\"alpha_zone_footer_css\";s:0:\"\";s:29:\"alpha_zone_footer_wrapper_css\";s:0:\"\";s:40:\"alpha_zone_footer_equal_height_container\";i:0;s:31:\"alpha_region_footer_first_force\";i:0;s:30:\"alpha_region_footer_first_zone\";s:6:\"footer\";s:32:\"alpha_region_footer_first_prefix\";s:1:\"0\";s:33:\"alpha_region_footer_first_columns\";s:2:\"12\";s:32:\"alpha_region_footer_first_suffix\";s:1:\"0\";s:32:\"alpha_region_footer_first_weight\";s:1:\"1\";s:34:\"alpha_region_footer_first_position\";s:1:\"0\";s:29:\"alpha_region_footer_first_css\";s:0:\"\";s:46:\"alpha_region_footer_first_equal_height_element\";i:0;s:48:\"alpha_region_footer_first_equal_height_container\";i:0;s:32:\"alpha_region_footer_second_force\";i:0;s:31:\"alpha_region_footer_second_zone\";s:6:\"footer\";s:33:\"alpha_region_footer_second_prefix\";s:1:\"0\";s:34:\"alpha_region_footer_second_columns\";s:2:\"12\";s:33:\"alpha_region_footer_second_suffix\";s:1:\"0\";s:33:\"alpha_region_footer_second_weight\";s:1:\"2\";s:35:\"alpha_region_footer_second_position\";s:1:\"0\";s:30:\"alpha_region_footer_second_css\";s:0:\"\";s:47:\"alpha_region_footer_second_equal_height_element\";i:0;s:49:\"alpha_region_footer_second_equal_height_container\";i:0;}'),('theme_reset_settings','a:0:{}'),('user_admin_role','s:1:\"3\";'),('user_register','i:0;'),('views_block_hashes','a:1:{s:32:\"9cf22433e0efbd8b206c8e4c2edb177c\";s:32:\"workbench_recent_content-block_1\";}'),('workbench_access','s:4:\"menu\";'),('workbench_access_allow_multiple','i:0;'),('workbench_access_auto_assign','i:1;'),('workbench_access_custom_form','i:1;'),('workbench_access_label','s:7:\"Section\";'),('workbench_access_menu','a:5:{s:9:\"main-menu\";s:9:\"main-menu\";s:10:\"navigation\";s:10:\"navigation\";s:13:\"menu-sidemenu\";s:13:\"menu-sidemenu\";s:10:\"management\";i:0;s:9:\"user-menu\";i:0;}'),('workbench_access_menu_limit','i:1;'),('workbench_access_node_type_external','i:1;'),('workbench_access_node_type_landing_page','i:1;'),('workbench_access_node_type_nmc_about','i:1;'),('workbench_access_node_type_photo','i:1;'),('workbench_access_node_type_press_release','i:1;'),('workbench_access_node_type_profile','i:1;'),('workbench_access_node_type_rotator','i:1;'),('workbench_access_node_type_site_page','i:1;'),('workbench_access_taxonomy','a:2:{s:16:\"workbench_access\";s:16:\"workbench_access\";s:4:\"tags\";i:0;}'),('workbench_moderation_default_state_external','s:9:\"published\";'),('workbench_moderation_default_state_landing_page','s:5:\"draft\";'),('workbench_moderation_default_state_nmc_about','s:5:\"draft\";'),('workbench_moderation_default_state_photo','s:9:\"published\";'),('workbench_moderation_default_state_press_release','s:5:\"draft\";'),('workbench_moderation_default_state_profile','s:5:\"draft\";'),('workbench_moderation_default_state_rotator','s:5:\"draft\";'),('workbench_moderation_default_state_site_page','s:5:\"draft\";');
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `views_display`
--

DROP TABLE IF EXISTS `views_display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_display` (
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.',
  PRIMARY KEY (`vid`,`id`),
  KEY `vid` (`vid`,`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `views_display`
--

LOCK TABLES `views_display` WRITE;
/*!40000 ALTER TABLE `views_display` DISABLE KEYS */;
/*!40000 ALTER TABLE `views_display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `views_view`
--

DROP TABLE IF EXISTS `views_view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `views_view` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT '0' COMMENT 'Stores the drupal core version of the view.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `views_view`
--

LOCK TABLES `views_view` WRITE;
/*!40000 ALTER TABLE `views_view` DISABLE KEYS */;
/*!40000 ALTER TABLE `views_view` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `watchdog`
--

DROP TABLE IF EXISTS `watchdog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=1662638 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchdog`
--

LOCK TABLES `watchdog` WRITE;
/*!40000 ALTER TABLE `watchdog` DISABLE KEYS */;
/*!40000 ALTER TABLE `watchdog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_access`
--

DROP TABLE IF EXISTS `workbench_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_access` (
  `access_id` varchar(80) NOT NULL DEFAULT '' COMMENT 'The section identifier, which may be non-numeric.',
  `access_scheme` varchar(40) NOT NULL DEFAULT '' COMMENT 'The module responsbile for this access system.',
  `access_type` varchar(40) NOT NULL DEFAULT '' COMMENT 'The access type (e.g. taxonomy).',
  `access_type_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The primary key for the access type (e.g. a vocabulary id).',
  PRIMARY KEY (`access_id`,`access_scheme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines the active sections for hierarchical access...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_access`
--

LOCK TABLES `workbench_access` WRITE;
/*!40000 ALTER TABLE `workbench_access` DISABLE KEYS */;
INSERT INTO `workbench_access` VALUES ('1','menu','menu','navigation'),('108','menu','menu','navigation'),('1174','menu','menu','navigation'),('135','menu','menu','navigation'),('137','menu','menu','navigation'),('138','menu','menu','navigation'),('155','menu','menu','navigation'),('18','menu','menu','navigation'),('180','menu','menu','navigation'),('182','menu','menu','navigation'),('184','menu','menu','navigation'),('214','menu','menu','navigation'),('215','menu','menu','navigation'),('22','taxonomy','taxonomy','workbench_access'),('25','taxonomy','taxonomy','workbench_access'),('251','menu','menu','navigation'),('252','menu','menu','navigation'),('253','menu','menu','navigation'),('254','menu','menu','navigation'),('256','menu','menu','navigation'),('257','menu','menu','navigation'),('258','menu','menu','navigation'),('259','menu','menu','navigation'),('26','menu','menu','navigation'),('260','menu','menu','navigation'),('261','menu','menu','navigation'),('268','menu','menu','navigation'),('28','menu','menu','navigation'),('28','taxonomy','taxonomy','workbench_access'),('284','menu','menu','navigation'),('287','menu','menu','navigation'),('292','menu','menu','navigation'),('294','menu','menu','navigation'),('31','taxonomy','taxonomy','workbench_access'),('313','menu','menu','navigation'),('317','menu','menu','navigation'),('322','menu','menu','navigation'),('34','taxonomy','taxonomy','workbench_access'),('35','menu','menu','navigation'),('356','menu','menu','main-menu'),('357','menu','menu','main-menu'),('358','menu','menu','main-menu'),('37','menu','menu','navigation'),('37','taxonomy','taxonomy','workbench_access'),('38','menu','menu','navigation'),('4','menu','menu','navigation'),('40','taxonomy','taxonomy','workbench_access'),('407','menu','menu','main-menu'),('408','menu','menu','main-menu'),('43','taxonomy','taxonomy','workbench_access'),('4544','menu','menu','main-menu'),('4555','menu','menu','navigation'),('4558','menu','menu','navigation'),('4591','menu','menu','navigation'),('4594','menu','menu','navigation'),('46','taxonomy','taxonomy','workbench_access'),('4648','menu','menu','navigation'),('4720','menu','menu','main-menu'),('4722','menu','menu','main-menu'),('4724','menu','menu','main-menu'),('4725','menu','menu','main-menu'),('4788','menu','menu','navigation'),('48','menu','menu','navigation'),('4919','menu','menu','navigation'),('5','menu','menu','navigation'),('55','menu','menu','navigation'),('56','menu','menu','navigation'),('57','menu','menu','navigation'),('6','menu','menu','navigation'),('7','menu','menu','navigation'),('8','menu','menu','navigation'),('main-menu','menu','menu','main-menu'),('menu-sidemenu','menu','menu','menu-sidemenu'),('navigation','menu','menu','navigation'),('workbench_access','taxonomy','taxonomy','workbench_access');
/*!40000 ALTER TABLE `workbench_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_access_node`
--

DROP TABLE IF EXISTS `workbench_access_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_access_node` (
  `nid` int(11) NOT NULL COMMENT 'The node identifier. Foreign key to node.',
  `access_id` varchar(80) NOT NULL DEFAULT '' COMMENT 'The section identifier. Foreign key to workbench_access.',
  `access_scheme` varchar(40) NOT NULL DEFAULT '' COMMENT 'The module responsbile for this access system.',
  PRIMARY KEY (`nid`,`access_id`,`access_scheme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps sections to nodes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_access_node`
--

LOCK TABLES `workbench_access_node` WRITE;
/*!40000 ALTER TABLE `workbench_access_node` DISABLE KEYS */;
INSERT INTO `workbench_access_node` VALUES (51,'workbench_access','taxonomy'),(54,'workbench_access','taxonomy'),(57,'workbench_access','taxonomy'),(60,'workbench_access','taxonomy'),(62,'workbench_access','taxonomy'),(65,'workbench_access','taxonomy'),(67,'workbench_access','taxonomy'),(70,'workbench_access','taxonomy'),(71,'workbench_access','taxonomy'),(74,'260','menu'),(75,'main-menu','menu'),(77,'main-menu','menu'),(78,'main-menu','menu'),(79,'356','menu');
/*!40000 ALTER TABLE `workbench_access_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_access_role`
--

DROP TABLE IF EXISTS `workbench_access_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_access_role` (
  `rid` int(11) NOT NULL COMMENT 'The role identifier. Foreign key to role.',
  `access_id` varchar(80) NOT NULL DEFAULT '' COMMENT 'The section identifier. Foreign key to workbench_access.',
  `access_scheme` varchar(40) NOT NULL DEFAULT '' COMMENT 'The module responsbile for this access system.',
  PRIMARY KEY (`rid`,`access_id`,`access_scheme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps role access to sections';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_access_role`
--

LOCK TABLES `workbench_access_role` WRITE;
/*!40000 ALTER TABLE `workbench_access_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `workbench_access_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_access_user`
--

DROP TABLE IF EXISTS `workbench_access_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_access_user` (
  `uid` int(11) NOT NULL COMMENT 'The user identifier. Foreign key to users.',
  `access_id` varchar(80) NOT NULL DEFAULT '' COMMENT 'The section identifier. Foreign key to workbench_access.',
  `access_scheme` varchar(40) NOT NULL DEFAULT '' COMMENT 'The module responsbile for this access system.',
  PRIMARY KEY (`uid`,`access_id`,`access_scheme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps user access to sections';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_access_user`
--

LOCK TABLES `workbench_access_user` WRITE;
/*!40000 ALTER TABLE `workbench_access_user` DISABLE KEYS */;
INSERT INTO `workbench_access_user` VALUES (1,'workbench_access','taxonomy'),(27,'main-menu','menu'),(27,'menu-sidemenu','menu'),(27,'navigation','menu');
/*!40000 ALTER TABLE `workbench_access_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_moderation_node_history`
--

DROP TABLE IF EXISTS `workbench_moderation_node_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_moderation_node_history` (
  `hid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Node history entry key.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Node revision id. Foreign key to node_revision',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Node id. Foreign key to node',
  `from_state` varchar(255) DEFAULT NULL COMMENT 'The old moderation state of the node',
  `state` varchar(255) DEFAULT NULL COMMENT 'The current moderation state of the node.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user id of the moderator who made the change. Foreign key to users.',
  `stamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The timestamp of the change.',
  `published` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicated the live revision of a node.',
  `is_current` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Indicated the current revision of a node.',
  PRIMARY KEY (`hid`),
  KEY `nid` (`nid`),
  KEY `vid` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_moderation_node_history`
--

LOCK TABLES `workbench_moderation_node_history` WRITE;
/*!40000 ALTER TABLE `workbench_moderation_node_history` DISABLE KEYS */;
INSERT INTO `workbench_moderation_node_history` VALUES (36,51,51,'draft','draft',23,1464874135,0,0),(38,53,51,'draft','draft',23,1464874183,0,0),(40,53,51,'draft','published',23,1464874268,1,1),(42,54,54,'draft','draft',27,1464882591,0,0),(43,54,54,'draft','published',27,1464882653,1,0),(45,57,54,'published','draft',27,1464884254,0,1),(48,60,57,'draft','draft',27,1464885194,0,0),(51,60,57,'draft','published',27,1464885227,1,1),(54,63,60,'draft','draft',27,1464891054,0,0),(55,63,60,'draft','published',27,1464891072,1,1),(56,65,62,'draft','draft',27,1464891666,0,0),(59,65,62,'draft','published',27,1464891677,1,1),(62,68,65,'draft','draft',27,1464893364,0,0),(64,68,65,'draft','published',27,1464893373,1,1),(67,70,67,'draft','draft',27,1464962773,0,0),(70,70,67,'draft','published',27,1464962779,1,1),(73,73,70,'draft','draft',27,1464962833,0,0),(76,76,70,'draft','draft',27,1464962850,0,0),(79,76,70,'draft','published',27,1464962855,1,1),(80,77,71,'draft','draft',27,1464962893,0,0),(83,77,71,'draft','published',27,1464962898,1,1),(89,80,74,'draft','published',27,1465397938,0,0),(92,80,74,'published','needs_review',27,1465397969,0,0),(94,80,74,'needs_review','published',27,1465397976,1,1),(96,81,75,'draft','published',27,1465838413,0,0),(97,81,75,'published','draft',27,1465838450,0,0),(99,81,75,'draft','published',27,1465838460,1,1),(101,83,77,'draft','published',27,1465838562,1,1),(102,84,78,'draft','draft',27,1465838679,0,0),(105,84,78,'draft','published',27,1465838689,1,1),(106,85,79,'draft','draft',27,1465842443,0,0),(107,85,79,'draft','published',27,1465842449,1,1);
/*!40000 ALTER TABLE `workbench_moderation_node_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_moderation_states`
--

DROP TABLE IF EXISTS `workbench_moderation_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_moderation_states` (
  `name` varchar(255) NOT NULL COMMENT 'The machine name of the moderation state.',
  `label` varchar(255) DEFAULT NULL COMMENT 'A label for the moderation state.',
  `description` varchar(255) DEFAULT NULL COMMENT 'A description of the moderation state.',
  `weight` int(11) DEFAULT '0' COMMENT 'Sort weight for the moderation state.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Defines all possible states';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_moderation_states`
--

LOCK TABLES `workbench_moderation_states` WRITE;
/*!40000 ALTER TABLE `workbench_moderation_states` DISABLE KEYS */;
INSERT INTO `workbench_moderation_states` VALUES ('draft','Draft','Work in progress',-99),('needs_review','Ready for Review','Ready for review',0),('published','Published','Make this version live',99);
/*!40000 ALTER TABLE `workbench_moderation_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workbench_moderation_transitions`
--

DROP TABLE IF EXISTS `workbench_moderation_transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workbench_moderation_transitions` (
  `from_name` varchar(255) DEFAULT NULL COMMENT 'The starting moderation state.',
  `to_name` varchar(255) DEFAULT NULL COMMENT 'The ending moderation state.',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique workbench_moderation transition identifier.',
  `name` varchar(255) DEFAULT NULL COMMENT 'The machine-readable name of this workbench_moderation transition.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Defines the valid transitions for states';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workbench_moderation_transitions`
--

LOCK TABLES `workbench_moderation_transitions` WRITE;
/*!40000 ALTER TABLE `workbench_moderation_transitions` DISABLE KEYS */;
INSERT INTO `workbench_moderation_transitions` VALUES ('draft','needs_review',1,'draft-needs_review'),('needs_review','draft',2,'needs_review-draft'),('needs_review','published',3,'needs_review-published'),('published','draft',4,'published-draft');
/*!40000 ALTER TABLE `workbench_moderation_transitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wysiwyg`
--

DROP TABLE IF EXISTS `wysiwyg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wysiwyg` (
  `format` varchar(255) NOT NULL COMMENT 'The filter_format.format of the text format.',
  `editor` varchar(128) NOT NULL DEFAULT '' COMMENT 'Internal name of the editor attached to the text format.',
  `settings` text COMMENT 'Configuration settings for the editor.',
  PRIMARY KEY (`format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Wysiwyg profiles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wysiwyg`
--

LOCK TABLES `wysiwyg` WRITE;
/*!40000 ALTER TABLE `wysiwyg` DISABLE KEYS */;
INSERT INTO `wysiwyg` VALUES ('filtered_html','',NULL),('full_html','ckeditor',NULL),('plain_text','ckeditor',NULL),('wysiwyg_html','ckeditor',NULL);
/*!40000 ALTER TABLE `wysiwyg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wysiwyg_user`
--

DROP TABLE IF EXISTS `wysiwyg_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wysiwyg_user` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user.',
  `format` varchar(255) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the format is enabled by default.',
  PRIMARY KEY (`uid`,`format`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user preferences for wysiwyg profiles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wysiwyg_user`
--

LOCK TABLES `wysiwyg_user` WRITE;
/*!40000 ALTER TABLE `wysiwyg_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `wysiwyg_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-22 12:55:20