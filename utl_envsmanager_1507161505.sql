-- MySQL dump 10.13  Distrib 5.5.42, for Linux (x86_64)
--
-- Host: 192.168.1.102    Database: utl_envsmanager_1507161505
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `envs_config`
--

DROP TABLE IF EXISTS `envs_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `envs_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `db_host` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `db_user` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `db_pass` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `db_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `src_path` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envs_config`
--

LOCK TABLES `envs_config` WRITE;
/*!40000 ALTER TABLE `envs_config` DISABLE KEYS */;
INSERT INTO `envs_config` VALUES (1,'192.168.1.102','root','m8gR9Vf7','utl_envsmanager_1507161505','/var/www/html/environments/manualenvsblank');
/*!40000 ALTER TABLE `envs_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envs_environments`
--

DROP TABLE IF EXISTS `envs_environments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `envs_environments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dbname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_created` int(11) DEFAULT '0',
  `for_remove` int(11) DEFAULT '0',
  `project_id` int(11) DEFAULT NULL,
  `config_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id_idx` (`project_id`),
  KEY `config_id_idx` (`config_id`),
  CONSTRAINT `config_id` FOREIGN KEY (`config_id`) REFERENCES `envs_config` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `project_id` FOREIGN KEY (`project_id`) REFERENCES `envs_project` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envs_environments`
--

LOCK TABLES `envs_environments` WRITE;
/*!40000 ALTER TABLE `envs_environments` DISABLE KEYS */;
INSERT INTO `envs_environments` VALUES (337,'development','testing-1921','/var/www/html/environments/manualenvs/testing-1921','development1920.testing-1921.ecomwisedev.com','man_development1920_1508211042','development-1920',1,1,150,1),(338,'test','matrixorderingb2borderlist','/var/www/html/environments/manualenvs/matrixorderingb2borderlist','test1920.matrixorderingb2borderlist.ecomwisedev.com','man_test1920_1508261034','test-1920',1,0,151,1),(339,'test','test-1901','/var/www/html/environments/manualenvs/test-1901','test1901.test-1901.ecomwisedev.com','man_test1901_1508271528','test-1901',1,1,152,1),(340,'test','mage-1800','/var/www/html/environments/manualenvs/mage-1800','test1800.mage-1800.ecomwisedev.com','man_test1800_1508271602','test-1800',1,0,153,1),(341,'test','credit-limit','/var/www/html/environments/manualenvs/credit-limit','test1920.credit-limit.ecomwisedev.com','man_test1920_1508310957','test-1920',1,0,154,1),(342,'test','mage1920','/var/www/html/environments/manualenvs/mage1920','test1920.mage1920.ecomwisedev.com','man_test1920_1509041659','test-1920',1,0,155,1),(343,'test','1921','/var/www/html/environments/manualenvs/1921','test1920.1921.ecomwisedev.com','man_test1920_1509071035','test-1920',1,0,156,1),(344,'development','dev-1910','/var/www/html/environments/manualenvs/dev-1910','development1910.dev-1910.ecomwisedev.com','man_development1910_1509091114','development-1910',1,0,157,1),(345,'test','tierpercentage','/var/www/html/environments/manualenvs/tierpercentage','test1920.tierpercentage.ecomwisedev.com','man_test1920_1509110903','test-1920',1,0,158,1),(346,'test','mage1911','/var/www/html/environments/manualenvs/mage1911','test1910.mage1911.ecomwisedev.com','man_test1910_1509140953','test-1910',1,0,159,1),(347,'development','dev-1920','/var/www/html/environments/manualenvs/dev-1920','development1920.dev-1920.ecomwisedev.com','man_development1920_1509181635','development-1920',1,0,160,1),(349,'test','saleagents','/var/www/html/environments/manualenvs/saleagents','test1702.saleagents.ecomwisedev.com','man_test1702_1509231603','test-1702',1,0,162,1),(350,'test','salesagents1800','/var/www/html/environments/manualenvs/salesagents1800','test1800.salesagents1800.ecomwisedev.com','man_test1800_1509241044','test-1800',1,1,163,1),(351,'test','salesagents1810','/var/www/html/environments/manualenvs/salesagents1810','test1810.salesagents1810.ecomwisedev.com','man_test1810_1509241212','test-1810',1,0,164,1),(352,'test','salesagents1901','/var/www/html/environments/manualenvs/salesagents1901','test1901.salesagents1901.ecomwisedev.com','man_test1901_1509241244','test-1901',1,0,165,1),(353,'test','salesagents1910','/var/www/html/environments/manualenvs/salesagents1910','test1910.salesagents1910.ecomwisedev.com','man_test1910_1509241407','test-1910',1,0,166,1),(354,'test','salesagents1920','/var/www/html/environments/manualenvs/salesagents1920','test1920.salesagents1920.ecomwisedev.com','man_test1920_1509241435','test-1920',1,0,167,1),(355,'test','cmspermissions','/var/www/html/environments/manualenvs/cmspermissions','test1910.cmspermissions.ecomwisedev.com','man_test1910_1509281555','test-1910',1,0,168,1),(356,'development','mage-1920','/var/www/html/environments/manualenvs/mage-1920','development1702.mage-1920.ecomwisedev.com','man_development1702_1510011706','development-1702',1,1,169,1),(357,'test','bestseller','/var/www/html/environments/manualenvs/bestseller','test1920.bestseller.ecomwisedev.com','man_test1920_1510071114','test-1920',1,0,170,1),(358,'test','tierpercentage-pricerules','/var/www/html/environments/manualenvs/tierpercentage-pricerules','test1920.tierpercentage-pricerules.ecomwisedev.com','man_test1920_1510081649','test-1920',1,0,171,1),(359,'test','tierpercentage-pricerules-1702','/var/www/html/environments/manualenvs/tierpercentage-pricerules-1702','test1702.tierpercentage-pricerules-1702.ecomwisedev.com','man_test1702_1510081708','test-1702',1,0,172,1),(360,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1702.bestsellerpro.ecomwisedev.com','man_test1702_1510131442','test-1702',1,0,173,1),(361,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1800.bestsellerpro.ecomwisedev.com','man_test1800_1510131442','test-1800',1,0,173,1),(362,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1810.bestsellerpro.ecomwisedev.com','man_test1810_1510131442','test-1810',1,0,173,1),(363,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1901.bestsellerpro.ecomwisedev.com','man_test1901_1510131442','test-1901',1,0,173,1),(364,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1910.bestsellerpro.ecomwisedev.com','man_test1910_1510131442','test-1910',1,0,173,1),(365,'test','bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','test1920.bestsellerpro.ecomwisedev.com','man_test1920_1510131442','test-1920',1,0,173,1),(368,'development','test-1920','/var/www/html/environments/manualenvs/test-1920','development1920.test-1920.ecomwisedev.com','man_development1920_1510161415','development-1920',1,0,176,1),(369,'development','test-1910','/var/www/html/environments/manualenvs/test-1910','development1910.test-1910.ecomwisedev.com','man_development1910_1510161518','development-1910',1,0,177,1),(370,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1702.subscription-manager.ecomwisedev.com','man_test1702_1510190934','test-1702',1,0,178,1),(371,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1800.subscription-manager.ecomwisedev.com','man_test1800_1510190934','test-1800',1,0,178,1),(372,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1810.subscription-manager.ecomwisedev.com','man_test1810_1510190934','test-1810',1,0,178,1),(373,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1901.subscription-manager.ecomwisedev.com','man_test1901_1510190934','test-1901',1,0,178,1),(374,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1910.subscription-manager.ecomwisedev.com','man_test1910_1510190934','test-1910',1,0,178,1),(375,'test','subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','test1920.subscription-manager.ecomwisedev.com','man_test1920_1510190934','test-1920',1,0,178,1),(376,'development','b2bsuite','/var/www/html/environments/manualenvs/b2bsuite','development1920.b2bsuite.ecomwisedev.com','man_development1920_1510191225','development-1920',1,0,179,1),(377,'github','b2bsuite','/var/www/html/environments/manualenvs/b2bsuite/github-b2bsuite','','','',1,0,179,NULL),(378,'test','customerpricerules','/var/www/html/environments/manualenvs/customerpricerules','test1920.customerpricerules.ecomwisedev.com','man_test1920_1510211056','test-1920',1,0,180,1),(379,'development','granda-theme','/var/www/html/environments/manualenvs/granda-theme','development1920.granda-theme.ecomwisedev.com','man_development1920_1510211418','development-1920',1,0,181,1),(380,'test','bestsellerfree','/var/www/html/environments/manualenvs/bestsellerfree','test1901.bestsellerfree.ecomwisedev.com','man_test1901_1510261202','test-1901',1,0,182,1),(381,'test','bestsellerfree','/var/www/html/environments/manualenvs/bestsellerfree','test1910.bestsellerfree.ecomwisedev.com','man_test1910_1510261202','test-1910',1,0,182,1),(382,'test','bestsellerfree','/var/www/html/environments/manualenvs/bestsellerfree','test1920.bestsellerfree.ecomwisedev.com','man_test1920_1510261202','test-1920',1,0,182,1),(383,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1702.hideprice.ecomwisedev.com','man_test1702_1510301409','test-1702',1,0,183,1),(384,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1800.hideprice.ecomwisedev.com','man_test1800_1510301409','test-1800',1,0,183,1),(385,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1810.hideprice.ecomwisedev.com','man_test1810_1510301409','test-1810',1,0,183,1),(386,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1901.hideprice.ecomwisedev.com','man_test1901_1510301409','test-1901',1,0,183,1),(387,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1910.hideprice.ecomwisedev.com','man_test1910_1510301409','test-1910',1,0,183,1),(388,'test','hideprice','/var/www/html/environments/manualenvs/hideprice','test1920.hideprice.ecomwisedev.com','man_test1920_1510301409','test-1920',1,0,183,1),(389,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1702.creditlimitplus.ecomwisedev.com','man_test1702_1511021422','test-1702',1,0,184,1),(390,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1800.creditlimitplus.ecomwisedev.com','man_test1800_1511021422','test-1800',1,0,184,1),(391,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1810.creditlimitplus.ecomwisedev.com','man_test1810_1511021422','test-1810',1,0,184,1),(392,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1901.creditlimitplus.ecomwisedev.com','man_test1901_1511021422','test-1901',1,0,184,1),(393,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1910.creditlimitplus.ecomwisedev.com','man_test1910_1511021422','test-1910',1,0,184,1),(394,'test','creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','test1920.creditlimitplus.ecomwisedev.com','man_test1920_1511021422','test-1920',1,0,184,1),(395,'test','callback','/var/www/html/environments/manualenvs/callback','test1702.callback.ecomwisedev.com','man_test1702_1511031427','test-1702',1,0,185,1),(396,'test','callback','/var/www/html/environments/manualenvs/callback','test1800.callback.ecomwisedev.com','man_test1800_1511031427','test-1800',1,0,185,1),(397,'test','callback','/var/www/html/environments/manualenvs/callback','test1810.callback.ecomwisedev.com','man_test1810_1511031427','test-1810',1,0,185,1),(398,'test','callback','/var/www/html/environments/manualenvs/callback','test1901.callback.ecomwisedev.com','man_test1901_1511031427','test-1901',1,0,185,1),(399,'test','callback','/var/www/html/environments/manualenvs/callback','test1910.callback.ecomwisedev.com','man_test1910_1511031427','test-1910',1,0,185,1),(400,'test','callback','/var/www/html/environments/manualenvs/callback','test1920.callback.ecomwisedev.com','man_test1920_1511031427','test-1920',1,0,185,1),(401,'development','magento-1922','/var/www/html/environments/manualenvs/magento-1922','development1920.magento-1922.ecomwisedev.com','man_development1920_1511061112','development-1920',1,0,186,1),(402,'development','custom-themes','/var/www/html/environments/manualenvs/custom-themes','development1910.custom-themes.ecomwisedev.com','man_development1910_1511131557','development-1910',1,0,187,1);
/*!40000 ALTER TABLE `envs_environments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envs_project`
--

DROP TABLE IF EXISTS `envs_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `envs_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `path` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_email` varchar(70) COLLATE utf8_unicode_ci DEFAULT NULL,
  `development` int(11) DEFAULT '0',
  `test` int(11) DEFAULT '0',
  `github` int(11) DEFAULT '0',
  `is_email_sent` int(11) DEFAULT '0',
  `removed` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envs_project`
--

LOCK TABLES `envs_project` WRITE;
/*!40000 ALTER TABLE `envs_project` DISABLE KEYS */;
INSERT INTO `envs_project` VALUES (149,'b2borderlist','/var/www/html/environments/manualenvs/b2borderlist','www.b2borderlist.ecomwisedev.com','ilche@ecomwise.com',1,1,1,0,0),(150,'testing-1921','/var/www/html/environments/manualenvs/testing-1921','www.testing-1921.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,1),(151,'matrixorderingb2borderlist','/var/www/html/environments/manualenvs/matrixorderingb2borderlist','www.matrixorderingb2borderlist.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(152,'test-1901','/var/www/html/environments/manualenvs/test-1901','www.test-1901.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(153,'mage-1800','/var/www/html/environments/manualenvs/mage-1800','www.mage-1800.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(154,'credit-limit','/var/www/html/environments/manualenvs/credit-limit','www.credit-limit.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(155,'mage1920','/var/www/html/environments/manualenvs/mage1920','www.mage1920.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(156,'1921','/var/www/html/environments/manualenvs/1921','www.1921.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(157,'dev-1910','/var/www/html/environments/manualenvs/dev-1910','www.dev-1910.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(158,'tierpercentage','/var/www/html/environments/manualenvs/tierpercentage','www.tierpercentage.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(159,'mage1911','/var/www/html/environments/manualenvs/mage1911','www.mage1911.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(160,'dev-1920','/var/www/html/environments/manualenvs/dev-1920','www.dev-1920.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(161,'salesagents','/var/www/html/environments/manualenvs/salesagents','www.salesagents.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(162,'saleagents','/var/www/html/environments/manualenvs/saleagents','www.saleagents.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(163,'salesagents1800','/var/www/html/environments/manualenvs/salesagents1800','www.salesagents1800.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,1),(164,'salesagents1810','/var/www/html/environments/manualenvs/salesagents1810','www.salesagents1810.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(165,'salesagents1901','/var/www/html/environments/manualenvs/salesagents1901','www.salesagents1901.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(166,'salesagents1910','/var/www/html/environments/manualenvs/salesagents1910','www.salesagents1910.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(167,'salesagents1920','/var/www/html/environments/manualenvs/salesagents1920','www.salesagents1920.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(168,'cmspermissions','/var/www/html/environments/manualenvs/cmspermissions','www.cmspermissions.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(169,'mage-1920','/var/www/html/environments/manualenvs/mage-1920','www.mage-1920.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(170,'bestseller','/var/www/html/environments/manualenvs/bestseller','www.bestseller.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(171,'tierpercentage-pricerules','/var/www/html/environments/manualenvs/tierpercentage-pricerules','www.tierpercentage-pricerules.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(172,'tierpercentage-pricerules-1702','/var/www/html/environments/manualenvs/tierpercentage-pricerules-1702','www.tierpercentage-pricerules-1702.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(173,'bestsellerpro','/var/www/html/environments/manualenvs/bestsellerpro','www.bestsellerpro.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(176,'test-1920','/var/www/html/environments/manualenvs/test-1920','www.test-1920.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(177,'test-1910','/var/www/html/environments/manualenvs/test-1910','www.test-1910.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(178,'subscription-manager','/var/www/html/environments/manualenvs/subscription-manager','www.subscription-manager.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(179,'b2bsuite','/var/www/html/environments/manualenvs/b2bsuite','www.b2bsuite.ecomwisedev.com','blagoj@ecomwise.com',1,1,1,0,0),(180,'customerpricerules','/var/www/html/environments/manualenvs/customerpricerules','www.customerpricerules.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(181,'granda-theme','/var/www/html/environments/manualenvs/granda-theme','www.granda-theme.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(182,'bestsellerfree','/var/www/html/environments/manualenvs/bestsellerfree','www.bestsellerfree.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(183,'hideprice','/var/www/html/environments/manualenvs/hideprice','www.hideprice.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(184,'creditlimitplus','/var/www/html/environments/manualenvs/creditlimitplus','www.creditlimitplus.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(185,'callback','/var/www/html/environments/manualenvs/callback','www.callback.ecomwisedev.com','jasmina@ecomwise.com',1,1,0,0,0),(186,'magento-1922','/var/www/html/environments/manualenvs/magento-1922','www.magento-1922.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0),(187,'custom-themes','/var/www/html/environments/manualenvs/custom-themes','www.custom-themes.ecomwisedev.com','joana@ecomwise.com',1,1,0,0,0);
/*!40000 ALTER TABLE `envs_project` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-11-16 10:21:54
