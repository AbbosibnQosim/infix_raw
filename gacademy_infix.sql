-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	5.7.31

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
-- Table structure for table `chatter_categories`
--

DROP TABLE IF EXISTS `chatter_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatter_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chatter_categories_slug_unique` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatter_categories`
--

LOCK TABLES `chatter_categories` WRITE;
/*!40000 ALTER TABLE `chatter_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatter_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatter_discussions`
--

DROP TABLE IF EXISTS `chatter_discussions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatter_discussions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT '#232629',
  `category_id` int(10) unsigned NOT NULL DEFAULT '1',
  `user_id` int(10) unsigned NOT NULL,
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `views` int(10) unsigned NOT NULL DEFAULT '0',
  `answered` tinyint(1) NOT NULL DEFAULT '0',
  `last_reply_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chatter_discussions_slug_unique` (`slug`),
  KEY `chatter_discussions_category_id_foreign` (`category_id`),
  KEY `chatter_discussions_user_id_foreign` (`user_id`),
  CONSTRAINT `chatter_discussions_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `chatter_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chatter_discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatter_discussions`
--

LOCK TABLES `chatter_discussions` WRITE;
/*!40000 ALTER TABLE `chatter_discussions` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatter_discussions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatter_posts`
--

DROP TABLE IF EXISTS `chatter_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatter_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chatter_posts_discussion_id_foreign` (`discussion_id`),
  KEY `chatter_posts_user_id_foreign` (`user_id`),
  CONSTRAINT `chatter_posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `chatter_discussions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chatter_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatter_posts`
--

LOCK TABLES `chatter_posts` WRITE;
/*!40000 ALTER TABLE `chatter_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatter_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatter_reactions`
--

DROP TABLE IF EXISTS `chatter_reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatter_reactions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `reactionable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emoji` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `emoji_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reactionable_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chatter_reactions_user_id_foreign` (`user_id`),
  CONSTRAINT `chatter_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatter_reactions`
--

LOCK TABLES `chatter_reactions` WRITE;
/*!40000 ALTER TABLE `chatter_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatter_reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatter_user_discussion`
--

DROP TABLE IF EXISTS `chatter_user_discussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chatter_user_discussion` (
  `user_id` int(10) unsigned NOT NULL,
  `discussion_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `chatter_user_discussion_user_id_index` (`user_id`),
  KEY `chatter_user_discussion_discussion_id_index` (`discussion_id`),
  CONSTRAINT `chatter_user_discussion_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `chatter_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chatter_user_discussion_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatter_user_discussion`
--

LOCK TABLES `chatter_user_discussion` WRITE;
/*!40000 ALTER TABLE `chatter_user_discussion` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatter_user_discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continents`
--

DROP TABLE IF EXISTS `continents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `continents_school_id_foreign` (`school_id`),
  CONSTRAINT `continents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continents`
--

LOCK TABLES `continents` WRITE;
/*!40000 ALTER TABLE `continents` DISABLE KEYS */;
INSERT INTO `continents` VALUES (1,'AF','Africa',NULL,NULL,1),(2,'AN','Antarctica',NULL,NULL,1),(3,'AS','Asia',NULL,NULL,1),(4,'EU','Europe',NULL,NULL,1),(5,'NA','North America',NULL,NULL,1),(6,'OC','Oceania',NULL,NULL,1),(7,'SA','South America',NULL,NULL,1);
/*!40000 ALTER TABLE `continents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `continets`
--

DROP TABLE IF EXISTS `continets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `continets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `continets_school_id_foreign` (`school_id`),
  CONSTRAINT `continets_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `continets`
--

LOCK TABLES `continets` WRITE;
/*!40000 ALTER TABLE `continets` DISABLE KEYS */;
/*!40000 ALTER TABLE `continets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `native` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `continent` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capital` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `languages` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `countries_school_id_foreign` (`school_id`),
  KEY `countries_academic_id_foreign` (`academic_id`),
  CONSTRAINT `countries_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `countries_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'AD','Andorra','Andorra','376','EU','Andorra la Vella','EUR','ca',NULL,NULL,1,1),(2,'AE','United Arab Emirates','Ø¯ÙˆÙ„Ø© Ø§Ù„Ø¥Ù…Ø§Ø±Ø§Øª Ø§Ù„Ø¹Ø±Ø¨ÙŠØ© Ø§Ù„Ù…ØªØ­Ø¯Ø©','971','AS','Abu Dhabi','AED','ar',NULL,NULL,1,1),(3,'AF','Afghanistan','Ø§ÙØºØ§Ù†Ø³ØªØ§Ù†','93','AS','Kabul','AFN','ps,uz,tk',NULL,NULL,1,1),(4,'AG','Antigua and Barbuda','Antigua and Barbuda','1268','NA','Saint John\'s','XCD','en',NULL,NULL,1,1),(5,'AI','Anguilla','Anguilla','1264','NA','The Valley','XCD','en',NULL,NULL,1,1),(6,'AL','Albania','ShqipÃ«ria','355','EU','Tirana','ALL','sq',NULL,NULL,1,1),(7,'AM','Armenia','Õ€Õ¡ÕµÕ¡Õ½Õ¿Õ¡Õ¶','374','AS','Yerevan','AMD','hy,ru',NULL,NULL,1,1),(8,'AO','Angola','Angola','244','AF','Luanda','AOA','pt',NULL,NULL,1,1),(9,'AQ','Antarctica','Antarctica','672','AN','','','',NULL,NULL,1,1),(10,'AR','Argentina','Argentina','54','SA','Buenos Aires','ARS','es,gn',NULL,NULL,1,1),(11,'AS','American Samoa','American Samoa','1684','OC','Pago Pago','USD','en,sm',NULL,NULL,1,1),(12,'AT','Austria','Ã–sterreich','43','EU','Vienna','EUR','de',NULL,NULL,1,1),(13,'AU','Australia','Australia','61','OC','Canberra','AUD','en',NULL,NULL,1,1),(14,'AW','Aruba','Aruba','297','NA','Oranjestad','AWG','nl,pa',NULL,NULL,1,1),(15,'AX','Ã…land','Ã…land','358','EU','Mariehamn','EUR','sv',NULL,NULL,1,1),(16,'AZ','Azerbaijan','AzÉ™rbaycan','994','AS','Baku','AZN','az',NULL,NULL,1,1),(17,'BA','Bosnia and Herzegovina','Bosna i Hercegovina','387','EU','Sarajevo','BAM','bs,hr,sr',NULL,NULL,1,1),(18,'BB','Barbados','Barbados','1246','NA','Bridgetown','BBD','en',NULL,NULL,1,1),(19,'BD','Bangladesh','Bangladesh','880','AS','Dhaka','BDT','bn',NULL,NULL,1,1),(20,'BE','Belgium','BelgiÃ«','32','EU','Brussels','EUR','nl,fr,de',NULL,NULL,1,1),(21,'BF','Burkina Faso','Burkina Faso','226','AF','Ouagadougou','XOF','fr,ff',NULL,NULL,1,1),(22,'BG','Bulgaria','Ð‘ÑŠÐ»Ð³Ð°Ñ€Ð¸Ñ','359','EU','Sofia','BGN','bg',NULL,NULL,1,1),(23,'BH','Bahrain','â€Ø§Ù„Ø¨Ø­Ø±ÙŠÙ†','973','AS','Manama','BHD','ar',NULL,NULL,1,1),(24,'BI','Burundi','Burundi','257','AF','Bujumbura','BIF','fr,rn',NULL,NULL,1,1),(25,'BJ','Benin','BÃ©nin','229','AF','Porto-Novo','XOF','fr',NULL,NULL,1,1),(26,'BL','Saint BarthÃ©lemy','Saint-BarthÃ©lemy','590','NA','Gustavia','EUR','fr',NULL,NULL,1,1),(27,'BM','Bermuda','Bermuda','1441','NA','Hamilton','BMD','en',NULL,NULL,1,1),(28,'BN','Brunei','Negara Brunei Darussalam','673','AS','Bandar Seri Begawan','BND','ms',NULL,NULL,1,1),(29,'BO','Bolivia','Bolivia','591','SA','Sucre','BOB,BOV','es,ay,qu',NULL,NULL,1,1),(30,'BQ','Bonaire','Bonaire','5997','NA','Kralendijk','USD','nl',NULL,NULL,1,1),(31,'BR','Brazil','Brasil','55','SA','BrasÃ­lia','BRL','pt',NULL,NULL,1,1),(32,'BS','Bahamas','Bahamas','1242','NA','Nassau','BSD','en',NULL,NULL,1,1),(33,'BT','Bhutan','Ê¼brug-yul','975','AS','Thimphu','BTN,INR','dz',NULL,NULL,1,1),(34,'BV','Bouvet Island','BouvetÃ¸ya','47','AN','','NOK','no,nb,nn',NULL,NULL,1,1),(35,'BW','Botswana','Botswana','267','AF','Gaborone','BWP','en,tn',NULL,NULL,1,1),(36,'BY','Belarus','Ð‘ÐµÐ»Ð°Ñ€ÑƒÌÑÑŒ','375','EU','Minsk','BYR','be,ru',NULL,NULL,1,1),(37,'BZ','Belize','Belize','501','NA','Belmopan','BZD','en,es',NULL,NULL,1,1),(38,'CA','Canada','Canada','1','NA','Ottawa','CAD','en,fr',NULL,NULL,1,1),(39,'CC','Cocos [Keeling] Islands','Cocos (Keeling) Islands','61','AS','West Island','AUD','en',NULL,NULL,1,1),(40,'CD','Democratic Republic of the Congo','RÃ©publique dÃ©mocratique du Congo','243','AF','Kinshasa','CDF','fr,ln,kg,sw,lu',NULL,NULL,1,1),(41,'CF','Central African Republic','KÃ¶dÃ¶rÃ¶sÃªse tÃ® BÃªafrÃ®ka','236','AF','Bangui','XAF','fr,sg',NULL,NULL,1,1),(42,'CG','Republic of the Congo','RÃ©publique du Congo','242','AF','Brazzaville','XAF','fr,ln',NULL,NULL,1,1),(43,'CH','Switzerland','Schweiz','41','EU','Bern','CHE,CHF,CHW','de,fr,it',NULL,NULL,1,1),(44,'CI','Ivory Coast','CÃ´te d\'Ivoire','225','AF','Yamoussoukro','XOF','fr',NULL,NULL,1,1),(45,'CK','Cook Islands','Cook Islands','682','OC','Avarua','NZD','en',NULL,NULL,1,1),(46,'CL','Chile','Chile','56','SA','Santiago','CLF,CLP','es',NULL,NULL,1,1),(47,'CM','Cameroon','Cameroon','237','AF','YaoundÃ©','XAF','en,fr',NULL,NULL,1,1),(48,'CN','China','ä¸­å›½','86','AS','Beijing','CNY','zh',NULL,NULL,1,1),(49,'CO','Colombia','Colombia','57','SA','BogotÃ¡','COP','es',NULL,NULL,1,1),(50,'CR','Costa Rica','Costa Rica','506','NA','San JosÃ©','CRC','es',NULL,NULL,1,1),(51,'CU','Cuba','Cuba','53','NA','Havana','CUC,CUP','es',NULL,NULL,1,1),(52,'CV','Cape Verde','Cabo Verde','238','AF','Praia','CVE','pt',NULL,NULL,1,1),(53,'CW','Curacao','CuraÃ§ao','5999','NA','Willemstad','ANG','nl,pa,en',NULL,NULL,1,1),(54,'CX','Christmas Island','Christmas Island','61','AS','Flying Fish Cove','AUD','en',NULL,NULL,1,1),(55,'CY','Cyprus','ÎšÏÏ€ÏÎ¿Ï‚','357','EU','Nicosia','EUR','el,tr,hy',NULL,NULL,1,1),(56,'CZ','Czech Republic','ÄŒeskÃ¡ republika','420','EU','Prague','CZK','cs,sk',NULL,NULL,1,1),(57,'DE','Germany','Deutschland','49','EU','Berlin','EUR','de',NULL,NULL,1,1),(58,'DJ','Djibouti','Djibouti','253','AF','Djibouti','DJF','fr,ar',NULL,NULL,1,1),(59,'DK','Denmark','Danmark','45','EU','Copenhagen','DKK','da',NULL,NULL,1,1),(60,'DM','Dominica','Dominica','1767','NA','Roseau','XCD','en',NULL,NULL,1,1),(61,'DO','Dominican Republic','RepÃºblica Dominicana','1809,1829,1849','NA','Santo Domingo','DOP','es',NULL,NULL,1,1),(62,'DZ','Algeria','Ø§Ù„Ø¬Ø²Ø§Ø¦Ø±','213','AF','Algiers','DZD','ar',NULL,NULL,1,1),(63,'EC','Ecuador','Ecuador','593','SA','Quito','USD','es',NULL,NULL,1,1),(64,'EE','Estonia','Eesti','372','EU','Tallinn','EUR','et',NULL,NULL,1,1),(65,'EG','Egypt','Ù…ØµØ±â€Ž','20','AF','Cairo','EGP','ar',NULL,NULL,1,1),(66,'EH','Western Sahara','Ø§Ù„ØµØ­Ø±Ø§Ø¡ Ø§Ù„ØºØ±Ø¨ÙŠØ©','212','AF','El AaiÃºn','MAD,DZD,MRU','es',NULL,NULL,1,1),(67,'ER','Eritrea','áŠ¤áˆ­á‰µáˆ«','291','AF','Asmara','ERN','ti,ar,en',NULL,NULL,1,1),(68,'ES','Spain','EspaÃ±a','34','EU','Madrid','EUR','es,eu,ca,gl,oc',NULL,NULL,1,1),(69,'ET','Ethiopia','áŠ¢á‰µá‹®áŒµá‹«','251','AF','Addis Ababa','ETB','am',NULL,NULL,1,1),(70,'FI','Finland','Suomi','358','EU','Helsinki','EUR','fi,sv',NULL,NULL,1,1),(71,'FJ','Fiji','Fiji','679','OC','Suva','FJD','en,fj,hi,ur',NULL,NULL,1,1),(72,'FK','Falkland Islands','Falkland Islands','500','SA','Stanley','FKP','en',NULL,NULL,1,1),(73,'FM','Micronesia','Micronesia','691','OC','Palikir','USD','en',NULL,NULL,1,1),(74,'FO','Faroe Islands','FÃ¸royar','298','EU','TÃ³rshavn','DKK','fo',NULL,NULL,1,1),(75,'FR','France','France','33','EU','Paris','EUR','fr',NULL,NULL,1,1),(76,'GA','Gabon','Gabon','241','AF','Libreville','XAF','fr',NULL,NULL,1,1),(77,'GB','United Kingdom','United Kingdom','44','EU','London','GBP','en',NULL,NULL,1,1),(78,'GD','Grenada','Grenada','1473','NA','St. George\'s','XCD','en',NULL,NULL,1,1),(79,'GE','Georgia','áƒ¡áƒáƒ¥áƒáƒ áƒ—áƒ•áƒ”áƒšáƒ','995','AS','Tbilisi','GEL','ka',NULL,NULL,1,1),(80,'GF','French Guiana','Guyane franÃ§aise','594','SA','Cayenne','EUR','fr',NULL,NULL,1,1),(81,'GG','Guernsey','Guernsey','44','EU','St. Peter Port','GBP','en,fr',NULL,NULL,1,1),(82,'GH','Ghana','Ghana','233','AF','Accra','GHS','en',NULL,NULL,1,1),(83,'GI','Gibraltar','Gibraltar','350','EU','Gibraltar','GIP','en',NULL,NULL,1,1),(84,'GL','Greenland','Kalaallit Nunaat','299','NA','Nuuk','DKK','kl',NULL,NULL,1,1),(85,'GM','Gambia','Gambia','220','AF','Banjul','GMD','en',NULL,NULL,1,1),(86,'GN','Guinea','GuinÃ©e','224','AF','Conakry','GNF','fr,ff',NULL,NULL,1,1),(87,'GP','Guadeloupe','Guadeloupe','590','NA','Basse-Terre','EUR','fr',NULL,NULL,1,1),(88,'GQ','Equatorial Guinea','Guinea Ecuatorial','240','AF','Malabo','XAF','es,fr',NULL,NULL,1,1),(89,'GR','Greece','Î•Î»Î»Î¬Î´Î±','30','EU','Athens','EUR','el',NULL,NULL,1,1),(90,'GS','South Georgia and the South Sandwich Islands','South Georgia','500','AN','King Edward Point','GBP','en',NULL,NULL,1,1),(91,'GT','Guatemala','Guatemala','502','NA','Guatemala City','GTQ','es',NULL,NULL,1,1),(92,'GU','Guam','Guam','1671','OC','HagÃ¥tÃ±a','USD','en,ch,es',NULL,NULL,1,1),(93,'GW','Guinea-Bissau','GuinÃ©-Bissau','245','AF','Bissau','XOF','pt',NULL,NULL,1,1),(94,'GY','Guyana','Guyana','592','SA','Georgetown','GYD','en',NULL,NULL,1,1),(95,'HK','Hong Kong','é¦™æ¸¯','852','AS','City of Victoria','HKD','zh,en',NULL,NULL,1,1),(96,'HM','Heard Island and McDonald Islands','Heard Island and McDonald Islands','61','AN','','AUD','en',NULL,NULL,1,1),(97,'HN','Honduras','Honduras','504','NA','Tegucigalpa','HNL','es',NULL,NULL,1,1),(98,'HR','Croatia','Hrvatska','385','EU','Zagreb','HRK','hr',NULL,NULL,1,1),(99,'HT','Haiti','HaÃ¯ti','509','NA','Port-au-Prince','HTG,USD','fr,ht',NULL,NULL,1,1),(100,'HU','Hungary','MagyarorszÃ¡g','36','EU','Budapest','HUF','hu',NULL,NULL,1,1),(101,'ID','Indonesia','Indonesia','62','AS','Jakarta','IDR','id',NULL,NULL,1,1),(102,'IE','Ireland','Ã‰ire','353','EU','Dublin','EUR','ga,en',NULL,NULL,1,1),(103,'IL','Israel','×™Ö´×©Ö°×‚×¨Ö¸×Öµ×œ','972','AS','Jerusalem','ILS','he,ar',NULL,NULL,1,1),(104,'IM','Isle of Man','Isle of Man','44','EU','Douglas','GBP','en,gv',NULL,NULL,1,1),(105,'IN','India','à¤­à¤¾à¤°à¤¤','91','AS','New Delhi','INR','hi,en',NULL,NULL,1,1),(106,'IO','British Indian Ocean Territory','British Indian Ocean Territory','246','AS','Diego Garcia','USD','en',NULL,NULL,1,1),(107,'IQ','Iraq','Ø§Ù„Ø¹Ø±Ø§Ù‚','964','AS','Baghdad','IQD','ar,ku',NULL,NULL,1,1),(108,'IR','Iran','Ø§ÛŒØ±Ø§Ù†','98','AS','Tehran','IRR','fa',NULL,NULL,1,1),(109,'IS','Iceland','Ãsland','354','EU','Reykjavik','ISK','is',NULL,NULL,1,1),(110,'IT','Italy','Italia','39','EU','Rome','EUR','it',NULL,NULL,1,1),(111,'JE','Jersey','Jersey','44','EU','Saint Helier','GBP','en,fr',NULL,NULL,1,1),(112,'JM','Jamaica','Jamaica','1876','NA','Kingston','JMD','en',NULL,NULL,1,1),(113,'JO','Jordan','Ø§Ù„Ø£Ø±Ø¯Ù†','962','AS','Amman','JOD','ar',NULL,NULL,1,1),(114,'JP','Japan','æ—¥æœ¬','81','AS','Tokyo','JPY','ja',NULL,NULL,1,1),(115,'KE','Kenya','Kenya','254','AF','Nairobi','KES','en,sw',NULL,NULL,1,1),(116,'KG','Kyrgyzstan','ÐšÑ‹Ñ€Ð³Ñ‹Ð·ÑÑ‚Ð°Ð½','996','AS','Bishkek','KGS','ky,ru',NULL,NULL,1,1),(117,'KH','Cambodia','KÃ¢mpÅ­chÃ©a','855','AS','Phnom Penh','KHR','km',NULL,NULL,1,1),(118,'KI','Kiribati','Kiribati','686','OC','South Tarawa','AUD','en',NULL,NULL,1,1),(119,'KM','Comoros','Komori','269','AF','Moroni','KMF','ar,fr',NULL,NULL,1,1),(120,'KN','Saint Kitts and Nevis','Saint Kitts and Nevis','1869','NA','Basseterre','XCD','en',NULL,NULL,1,1),(121,'KP','North Korea','ë¶í•œ','850','AS','Pyongyang','KPW','ko',NULL,NULL,1,1),(122,'KR','South Korea','ëŒ€í•œë¯¼êµ­','82','AS','Seoul','KRW','ko',NULL,NULL,1,1),(123,'KW','Kuwait','Ø§Ù„ÙƒÙˆÙŠØª','965','AS','Kuwait City','KWD','ar',NULL,NULL,1,1),(124,'KY','Cayman Islands','Cayman Islands','1345','NA','George Town','KYD','en',NULL,NULL,1,1),(125,'KZ','Kazakhstan','ÒšÐ°Ð·Ð°Ò›ÑÑ‚Ð°Ð½','76,77','AS','Astana','KZT','kk,ru',NULL,NULL,1,1),(126,'LA','Laos','àºªàº›àº›àº¥àº²àº§','856','AS','Vientiane','LAK','lo',NULL,NULL,1,1),(127,'LB','Lebanon','Ù„Ø¨Ù†Ø§Ù†','961','AS','Beirut','LBP','ar,fr',NULL,NULL,1,1),(128,'LC','Saint Lucia','Saint Lucia','1758','NA','Castries','XCD','en',NULL,NULL,1,1),(129,'LI','Liechtenstein','Liechtenstein','423','EU','Vaduz','CHF','de',NULL,NULL,1,1),(130,'LK','Sri Lanka','Å›rÄ« laá¹ƒkÄva','94','AS','Colombo','LKR','si,ta',NULL,NULL,1,1),(131,'LR','Liberia','Liberia','231','AF','Monrovia','LRD','en',NULL,NULL,1,1),(132,'LS','Lesotho','Lesotho','266','AF','Maseru','LSL,ZAR','en,st',NULL,NULL,1,1),(133,'LT','Lithuania','Lietuva','370','EU','Vilnius','EUR','lt',NULL,NULL,1,1),(134,'LU','Luxembourg','Luxembourg','352','EU','Luxembourg','EUR','fr,de,lb',NULL,NULL,1,1),(135,'LV','Latvia','Latvija','371','EU','Riga','EUR','lv',NULL,NULL,1,1),(136,'LY','Libya','â€Ù„ÙŠØ¨ÙŠØ§','218','AF','Tripoli','LYD','ar',NULL,NULL,1,1),(137,'MA','Morocco','Ø§Ù„Ù…ØºØ±Ø¨','212','AF','Rabat','MAD','ar',NULL,NULL,1,1),(138,'MC','Monaco','Monaco','377','EU','Monaco','EUR','fr',NULL,NULL,1,1),(139,'MD','Moldova','Moldova','373','EU','ChiÈ™inÄƒu','MDL','ro',NULL,NULL,1,1),(140,'ME','Montenegro','Ð¦Ñ€Ð½Ð° Ð“Ð¾Ñ€Ð°','382','EU','Podgorica','EUR','sr,bs,sq,hr',NULL,NULL,1,1),(141,'MF','Saint Martin','Saint-Martin','590','NA','Marigot','EUR','en,fr,nl',NULL,NULL,1,1),(142,'MG','Madagascar','Madagasikara','261','AF','Antananarivo','MGA','fr,mg',NULL,NULL,1,1),(143,'MH','Marshall Islands','MÌ§ajeÄ¼','692','OC','Majuro','USD','en,mh',NULL,NULL,1,1),(144,'MK','Macedonia','ÐœÐ°ÐºÐµÐ´Ð¾Ð½Ð¸Ñ˜Ð°','389','EU','Skopje','MKD','mk',NULL,NULL,1,1),(145,'ML','Mali','Mali','223','AF','Bamako','XOF','fr',NULL,NULL,1,1),(146,'MM','Myanmar [Burma]','á€™á€¼á€”á€ºá€™á€¬','95','AS','Naypyidaw','MMK','my',NULL,NULL,1,1),(147,'MN','Mongolia','ÐœÐ¾Ð½Ð³Ð¾Ð» ÑƒÐ»Ñ','976','AS','Ulan Bator','MNT','mn',NULL,NULL,1,1),(148,'MO','Macao','æ¾³é–€','853','AS','','MOP','zh,pt',NULL,NULL,1,1),(149,'MP','Northern Mariana Islands','Northern Mariana Islands','1670','OC','Saipan','USD','en,ch',NULL,NULL,1,1),(150,'MQ','Martinique','Martinique','596','NA','Fort-de-France','EUR','fr',NULL,NULL,1,1),(151,'MR','Mauritania','Ù…ÙˆØ±ÙŠØªØ§Ù†ÙŠØ§','222','AF','Nouakchott','MRU','ar',NULL,NULL,1,1),(152,'MS','Montserrat','Montserrat','1664','NA','Plymouth','XCD','en',NULL,NULL,1,1),(153,'MT','Malta','Malta','356','EU','Valletta','EUR','mt,en',NULL,NULL,1,1),(154,'MU','Mauritius','Maurice','230','AF','Port Louis','MUR','en',NULL,NULL,1,1),(155,'MV','Maldives','Maldives','960','AS','MalÃ©','MVR','dv',NULL,NULL,1,1),(156,'MW','Malawi','Malawi','265','AF','Lilongwe','MWK','en,ny',NULL,NULL,1,1),(157,'MX','Mexico','MÃ©xico','52','NA','Mexico City','MXN','es',NULL,NULL,1,1),(158,'MY','Malaysia','Malaysia','60','AS','Kuala Lumpur','MYR','ms',NULL,NULL,1,1),(159,'MZ','Mozambique','MoÃ§ambique','258','AF','Maputo','MZN','pt',NULL,NULL,1,1),(160,'NA','Namibia','Namibia','264','AF','Windhoek','NAD,ZAR','en,af',NULL,NULL,1,1),(161,'NC','New Caledonia','Nouvelle-CalÃ©donie','687','OC','NoumÃ©a','XPF','fr',NULL,NULL,1,1),(162,'NE','Niger','Niger','227','AF','Niamey','XOF','fr',NULL,NULL,1,1),(163,'NF','Norfolk Island','Norfolk Island','672','OC','Kingston','AUD','en',NULL,NULL,1,1),(164,'NG','Nigeria','Nigeria','234','AF','Abuja','NGN','en',NULL,NULL,1,1),(165,'NI','Nicaragua','Nicaragua','505','NA','Managua','NIO','es',NULL,NULL,1,1),(166,'NL','Netherlands','Nederland','31','EU','Amsterdam','EUR','nl',NULL,NULL,1,1),(167,'NO','Norway','Norge','47','EU','Oslo','NOK','no,nb,nn',NULL,NULL,1,1),(168,'NP','Nepal','à¤¨à¤ªà¤²','977','AS','Kathmandu','NPR','ne',NULL,NULL,1,1),(169,'NR','Nauru','Nauru','674','OC','Yaren','AUD','en,na',NULL,NULL,1,1),(170,'NU','Niue','NiuÄ“','683','OC','Alofi','NZD','en',NULL,NULL,1,1),(171,'NZ','New Zealand','New Zealand','64','OC','Wellington','NZD','en,mi',NULL,NULL,1,1),(172,'OM','Oman','Ø¹Ù…Ø§Ù†','968','AS','Muscat','OMR','ar',NULL,NULL,1,1),(173,'PA','Panama','PanamÃ¡','507','NA','Panama City','PAB,USD','es',NULL,NULL,1,1),(174,'PE','Peru','PerÃº','51','SA','Lima','PEN','es',NULL,NULL,1,1),(175,'PF','French Polynesia','PolynÃ©sie franÃ§aise','689','OC','PapeetÄ“','XPF','fr',NULL,NULL,1,1),(176,'PG','Papua New Guinea','Papua Niugini','675','OC','Port Moresby','PGK','en',NULL,NULL,1,1),(177,'PH','Philippines','Pilipinas','63','AS','Manila','PHP','en',NULL,NULL,1,1),(178,'PK','Pakistan','Pakistan','92','AS','Islamabad','PKR','en,ur',NULL,NULL,1,1),(179,'PL','Poland','Polska','48','EU','Warsaw','PLN','pl',NULL,NULL,1,1),(180,'PM','Saint Pierre and Miquelon','Saint-Pierre-et-Miquelon','508','NA','Saint-Pierre','EUR','fr',NULL,NULL,1,1),(181,'PN','Pitcairn Islands','Pitcairn Islands','64','OC','Adamstown','NZD','en',NULL,NULL,1,1),(182,'PR','Puerto Rico','Puerto Rico','1787,1939','NA','San Juan','USD','es,en',NULL,NULL,1,1),(183,'PS','Palestine','ÙÙ„Ø³Ø·ÙŠÙ†','970','AS','Ramallah','ILS','ar',NULL,NULL,1,1),(184,'PT','Portugal','Portugal','351','EU','Lisbon','EUR','pt',NULL,NULL,1,1),(185,'PW','Palau','Palau','680','OC','Ngerulmud','USD','en',NULL,NULL,1,1),(186,'PY','Paraguay','Paraguay','595','SA','AsunciÃ³n','PYG','es,gn',NULL,NULL,1,1),(187,'QA','Qatar','Ù‚Ø·Ø±','974','AS','Doha','QAR','ar',NULL,NULL,1,1),(188,'RE','RÃ©union','La RÃ©union','262','AF','Saint-Denis','EUR','fr',NULL,NULL,1,1),(189,'RO','Romania','RomÃ¢nia','40','EU','Bucharest','RON','ro',NULL,NULL,1,1),(190,'RS','Serbia','Ð¡Ñ€Ð±Ð¸Ñ˜Ð°','381','EU','Belgrade','RSD','sr',NULL,NULL,1,1),(191,'RU','Russia','Ð Ð¾ÑÑÐ¸Ñ','7','EU','Moscow','RUB','ru',NULL,NULL,1,1),(192,'RW','Rwanda','Rwanda','250','AF','Kigali','RWF','rw,en,fr',NULL,NULL,1,1),(193,'SA','Saudi Arabia','Ø§Ù„Ø¹Ø±Ø¨ÙŠØ© Ø§Ù„Ø³Ø¹ÙˆØ¯ÙŠØ©','966','AS','Riyadh','SAR','ar',NULL,NULL,1,1),(194,'SB','Solomon Islands','Solomon Islands','677','OC','Honiara','SBD','en',NULL,NULL,1,1),(195,'SC','Seychelles','Seychelles','248','AF','Victoria','SCR','fr,en',NULL,NULL,1,1),(196,'SD','Sudan','Ø§Ù„Ø³ÙˆØ¯Ø§Ù†','249','AF','Khartoum','SDG','ar,en',NULL,NULL,1,1),(197,'SE','Sweden','Sverige','46','EU','Stockholm','SEK','sv',NULL,NULL,1,1),(198,'SG','Singapore','Singapore','65','AS','Singapore','SGD','en,ms,ta,zh',NULL,NULL,1,1),(199,'SH','Saint Helena','Saint Helena','290','AF','Jamestown','SHP','en',NULL,NULL,1,1),(200,'SI','Slovenia','Slovenija','386','EU','Ljubljana','EUR','sl',NULL,NULL,1,1),(201,'SJ','Svalbard and Jan Mayen','Svalbard og Jan Mayen','4779','EU','Longyearbyen','NOK','no',NULL,NULL,1,1),(202,'SK','Slovakia','Slovensko','421','EU','Bratislava','EUR','sk',NULL,NULL,1,1),(203,'SL','Sierra Leone','Sierra Leone','232','AF','Freetown','SLL','en',NULL,NULL,1,1),(204,'SM','San Marino','San Marino','378','EU','City of San Marino','EUR','it',NULL,NULL,1,1),(205,'SN','Senegal','SÃ©nÃ©gal','221','AF','Dakar','XOF','fr',NULL,NULL,1,1),(206,'SO','Somalia','Soomaaliya','252','AF','Mogadishu','SOS','so,ar',NULL,NULL,1,1),(207,'SR','Suriname','Suriname','597','SA','Paramaribo','SRD','nl',NULL,NULL,1,1),(208,'SS','South Sudan','South Sudan','211','AF','Juba','SSP','en',NULL,NULL,1,1),(209,'ST','SÃ£o TomÃ© and PrÃ­ncipe','SÃ£o TomÃ© e PrÃ­ncipe','239','AF','SÃ£o TomÃ©','STN','pt',NULL,NULL,1,1),(210,'SV','El Salvador','El Salvador','503','NA','San Salvador','SVC,USD','es',NULL,NULL,1,1),(211,'SX','Sint Maarten','Sint Maarten','1721','NA','Philipsburg','ANG','nl,en',NULL,NULL,1,1),(212,'SY','Syria','Ø³ÙˆØ±ÙŠØ§','963','AS','Damascus','SYP','ar',NULL,NULL,1,1),(213,'SZ','Swaziland','Swaziland','268','AF','Lobamba','SZL','en,ss',NULL,NULL,1,1),(214,'TC','Turks and Caicos Islands','Turks and Caicos Islands','1649','NA','Cockburn Town','USD','en',NULL,NULL,1,1),(215,'TD','Chad','Tchad','235','AF','N\'Djamena','XAF','fr,ar',NULL,NULL,1,1),(216,'TF','French Southern Territories','Territoire des Terres australes et antarctiques fr','262','AN','Port-aux-FranÃ§ais','EUR','fr',NULL,NULL,1,1),(217,'TG','Togo','Togo','228','AF','LomÃ©','XOF','fr',NULL,NULL,1,1),(218,'TH','Thailand','à¸›à¸£à¸°à¹€à¸—à¸¨à¹„à¸—à¸¢','66','AS','Bangkok','THB','th',NULL,NULL,1,1),(219,'TJ','Tajikistan','Ð¢Ð¾Ò·Ð¸ÐºÐ¸ÑÑ‚Ð¾Ð½','992','AS','Dushanbe','TJS','tg,ru',NULL,NULL,1,1),(220,'TK','Tokelau','Tokelau','690','OC','Fakaofo','NZD','en',NULL,NULL,1,1),(221,'TL','East Timor','Timor-Leste','670','OC','Dili','USD','pt',NULL,NULL,1,1),(222,'TM','Turkmenistan','TÃ¼rkmenistan','993','AS','Ashgabat','TMT','tk,ru',NULL,NULL,1,1),(223,'TN','Tunisia','ØªÙˆÙ†Ø³','216','AF','Tunis','TND','ar',NULL,NULL,1,1),(224,'TO','Tonga','Tonga','676','OC','Nuku\'alofa','TOP','en,to',NULL,NULL,1,1),(225,'TR','Turkey','TÃ¼rkiye','90','AS','Ankara','TRY','tr',NULL,NULL,1,1),(226,'TT','Trinidad and Tobago','Trinidad and Tobago','1868','NA','Port of Spain','TTD','en',NULL,NULL,1,1),(227,'TV','Tuvalu','Tuvalu','688','OC','Funafuti','AUD','en',NULL,NULL,1,1),(228,'TW','Taiwan','è‡ºç£','886','AS','Taipei','TWD','zh',NULL,NULL,1,1),(229,'TZ','Tanzania','Tanzania','255','AF','Dodoma','TZS','sw,en',NULL,NULL,1,1),(230,'UA','Ukraine','Ð£ÐºÑ€Ð°Ñ—Ð½Ð°','380','EU','Kyiv','UAH','uk',NULL,NULL,1,1),(231,'UG','Uganda','Uganda','256','AF','Kampala','UGX','en,sw',NULL,NULL,1,1),(232,'UM','U.S. Minor Outlying Islands','United States Minor Outlying Islands','1','OC','','USD','en',NULL,NULL,1,1),(233,'US','United States','United States','1','NA','Washington D.C.','USD,USN,USS','en',NULL,NULL,1,1),(234,'UY','Uruguay','Uruguay','598','SA','Montevideo','UYI,UYU','es',NULL,NULL,1,1),(235,'UZ','Uzbekistan','Oâ€˜zbekiston','998','AS','Tashkent','UZS','uz,ru',NULL,NULL,1,1),(236,'VA','Vatican City','Vaticano','39066,379','EU','Vatican City','EUR','it,la',NULL,NULL,1,1),(237,'VC','Saint Vincent and the Grenadines','Saint Vincent and the Grenadines','1784','NA','Kingstown','XCD','en',NULL,NULL,1,1),(238,'VE','Venezuela','Venezuela','58','SA','Caracas','VES','es',NULL,NULL,1,1),(239,'VG','British Virgin Islands','British Virgin Islands','1284','NA','Road Town','USD','en',NULL,NULL,1,1),(240,'VI','U.S. Virgin Islands','United States Virgin Islands','1340','NA','Charlotte Amalie','USD','en',NULL,NULL,1,1),(241,'VN','Vietnam','Viá»‡t Nam','84','AS','Hanoi','VND','vi',NULL,NULL,1,1),(242,'VU','Vanuatu','Vanuatu','678','OC','Port Vila','VUV','bi,en,fr',NULL,NULL,1,1),(243,'WF','Wallis and Futuna','Wallis et Futuna','681','OC','Mata-Utu','XPF','fr',NULL,NULL,1,1),(244,'WS','Samoa','Samoa','685','OC','Apia','WST','sm,en',NULL,NULL,1,1),(245,'XK','Kosovo','Republika e KosovÃ«s','377,381,383,386','EU','Pristina','EUR','sq,sr',NULL,NULL,1,1),(246,'YE','Yemen','Ø§Ù„ÙŠÙŽÙ…ÙŽÙ†','967','AS','Sana\'a','YER','ar',NULL,NULL,1,1),(247,'YT','Mayotte','Mayotte','262','AF','Mamoudzou','EUR','fr',NULL,NULL,1,1),(248,'ZA','South Africa','South Africa','27','AF','Pretoria','ZAR','af,en,nr,st,ss,tn,ts,ve,xh,zu',NULL,NULL,1,1),(249,'ZM','Zambia','Zambia','260','AF','Lusaka','ZMK','en',NULL,NULL,1,1),(250,'ZW','Zimbabwe','Zimbabwe','263','AF','Harare','USD,ZAR,BWP,GBP,AUD,CNY,INR,JP','en,sn,nd',NULL,NULL,1,1);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_result_settings`
--

DROP TABLE IF EXISTS `custom_result_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_result_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_term_id1` int(11) NOT NULL,
  `percentage1` double(8,2) NOT NULL,
  `exam_term_id2` int(11) NOT NULL,
  `percentage2` double(8,2) NOT NULL,
  `exam_term_id3` int(11) NOT NULL,
  `percentage3` double(8,2) NOT NULL,
  `academic_year` int(11) NOT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custom_result_settings_school_id_foreign` (`school_id`),
  KEY `custom_result_settings_academic_id_foreign` (`academic_id`),
  CONSTRAINT `custom_result_settings_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `custom_result_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_result_settings`
--

LOCK TABLES `custom_result_settings` WRITE;
/*!40000 ALTER TABLE `custom_result_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_result_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infix_module_infos`
--

DROP TABLE IF EXISTS `infix_module_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infix_module_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `type` int(11) DEFAULT NULL COMMENT '1 for module, 2 for module link, 3 for module links crud',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `infix_module_infos_created_by_foreign` (`created_by`),
  KEY `infix_module_infos_updated_by_foreign` (`updated_by`),
  KEY `infix_module_infos_school_id_foreign` (`school_id`),
  CONSTRAINT `infix_module_infos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `infix_module_infos_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `infix_module_infos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=571 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infix_module_infos`
--

LOCK TABLES `infix_module_infos` WRITE;
/*!40000 ALTER TABLE `infix_module_infos` DISABLE KEYS */;
INSERT INTO `infix_module_infos` VALUES (1,1,0,'Dashboard Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(2,1,1,'âž¡ Number of Student','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(3,1,1,'âž¡ Number of Teacher','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(4,1,1,'âž¡ Number of Parents','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(5,1,1,'âž¡ Number of Staff','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(6,1,1,'âž¡ Current Month Income and Expense Chart','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(7,1,1,'âž¡ Current Year Income and Expense Chart','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(8,1,1,'âž¡ Notice Board','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(9,1,1,'âž¡ Calendar Section','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(10,1,1,'âž¡ To Do list','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(11,2,0,'Admin Section Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(12,2,11,'Admission Query menu','admission-query',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(13,2,12,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(14,2,12,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(15,2,12,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(16,2,11,'Visitor Book Menu','visitor',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(17,2,16,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(18,2,16,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(19,2,16,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(20,2,16,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(21,2,11,'Complaint Menu','complaint',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(22,2,21,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(23,2,21,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(24,2,21,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(25,2,21,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(26,2,21,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(27,2,11,'Postal Receive Menu','postal-receive',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(28,2,27,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(29,2,27,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(30,2,27,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(31,2,27,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(32,2,11,'Postal Dispatch Menu','postal-dispatch',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(33,2,32,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(34,2,32,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(35,2,32,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(36,2,11,'Phone Call Log Menu','phone-call',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(37,2,36,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(38,2,36,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(39,2,36,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(40,2,36,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(41,2,11,'Admin Setup Menu','setup-admin',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(42,2,41,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(43,2,41,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(44,2,41,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(45,2,11,'Student ID Menu','student-id-card',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(46,2,45,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(47,2,45,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(48,2,45,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(49,2,11,'Student Certificate Menu','student-certificate',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(50,2,49,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(51,2,49,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(52,2,49,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(53,2,11,'Generate Certificate Menu','generate-certificate',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(54,2,53,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(55,2,53,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(56,2,53,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(57,2,11,'Generate ID Card Menu','generate-id-card',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(58,2,57,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(59,2,57,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(60,2,57,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(61,3,0,'Student Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(62,3,61,'Student Admission Menu','student-admission',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(63,3,62,'Import Student','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(64,3,61,'Student List Menu','student-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(65,3,64,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(66,3,64,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(67,3,64,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(68,3,61,'Student Attendance Menu','student-attendance',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(69,3,68,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(70,3,61,'Student Attendance Report Menu','student-attendance-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(71,3,61,'Student Category Menu','student-category',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(72,3,71,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(73,3,71,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(74,3,71,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(75,3,71,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(76,3,61,'Student Group Menu','student-group',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(77,3,76,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(79,3,76,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(80,3,76,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(81,3,61,'Student Promote Menu','student-promote',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(82,3,81,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(83,3,61,'Disabled Students Menu','disabled-student',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(84,3,83,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(85,3,83,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(86,3,83,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(87,4,0,'Study Material Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(88,4,87,'Upload Content Menu','upload-content',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(89,4,88,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(90,4,88,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(91,4,88,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(92,4,87,'Assignment Menu','assignment-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(93,4,92,'Add','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(94,4,92,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(95,4,92,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(96,4,87,'Study Material Menu','study-metarial-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(97,4,96,'Add','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(98,4,96,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(99,4,96,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(100,4,87,'Syllabus Menu','syllabus-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(101,4,100,'Add','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(102,4,100,'Edit','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(103,4,100,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(104,4,100,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(105,4,87,'Other Downloads Menu','other-download-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(106,4,105,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(107,4,105,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(108,5,0,'Fees Collection Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(109,5,108,'Collect Fees Menu','collect-fees',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(110,5,109,' Collect Fees','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(111,5,109,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(112,5,109,'Print','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(113,5,108,'Search Fees Payment Menu','search-fees-payment',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(114,5,113,'Add','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(115,5,113,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(116,5,108,'Search Fees Due Menu','search-fees-due',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(117,5,116,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(118,5,108,'Fees Master Menu','fees-master',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(119,5,118,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(120,5,118,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(121,5,118,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(122,5,118,'Assign','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(123,5,108,'Fees Group Menu','fees-group',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(124,5,123,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(125,5,123,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(126,5,123,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(127,5,108,'Fees Type Menu','fees-type',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(128,5,127,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(129,5,127,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(130,5,127,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(131,5,108,'Fees Discount Menu','fees-discount',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(132,5,131,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(133,5,131,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(134,5,131,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(135,5,131,'Assign','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(136,5,108,'Fees Carry Forward Menu','fees-forward',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(137,6,0,'Accounts Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(138,6,137,'Profit Menu','profit',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(139,6,137,'Income Menu','add-income',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(140,6,139,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(141,6,139,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(142,6,139,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(143,6,137,'Expense Menu','add-expense',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(144,6,143,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(145,6,143,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(146,6,143,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(147,6,137,'Search Menu','search-account',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(148,6,137,'Chart of Account Menu','chart-of-account',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(149,6,148,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(150,6,148,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(151,6,148,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(152,6,137,'Payment method Menu','payment-method',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(153,6,152,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(154,6,152,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(155,6,152,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(156,6,137,'Bank Account Menu','bank-account',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(157,6,156,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(158,6,156,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(159,6,156,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(160,7,0,'Human Resource Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(161,7,160,'Staff Directory Menu','staff-directory',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(162,7,161,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(163,7,161,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(164,7,161,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(165,7,160,'Staff Attendance Menu','staff-attendance',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(166,7,165,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(167,7,165,'Edit','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(168,7,165,'Delete','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(169,7,160,'Staff Attendance Report Menu','staff-attendance-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(170,7,160,'Payroll Menu','payroll',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(171,7,170,'Edit','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(172,7,170,'Delete','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(173,7,170,'Search','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(174,7,170,'Generate Payroll','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(175,7,170,'Create','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(176,7,170,'Proceed To Pay','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(177,7,170,'View Payslip','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(178,7,160,'Payroll Report Menu','payroll-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(179,7,178,'Report Search','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(180,7,160,'Designations Menu','designation',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(181,7,180,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(182,7,180,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(183,7,180,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(184,7,160,'Departments Menu','department',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(185,7,184,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(186,7,184,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(187,7,184,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(188,8,0,'Leave Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(189,8,188,'Approve Leave Menu','approve-leave',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(190,8,189,'Add','',0,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(191,8,189,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(192,8,189,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(193,8,188,'Apply Leave Menu','apply-leave',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(194,8,193,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(195,8,193,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(196,8,188,'Pending Leave Menu','pending-leave',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(197,8,196,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(198,8,196,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(199,8,188,'Leave Define Menu','leave-define',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(200,8,199,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(201,8,199,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(202,8,199,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(203,8,188,'Leave Type Menu','leave-type',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(204,8,203,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(205,8,203,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(206,8,203,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(207,9,0,'Examination Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(208,9,207,'Add Exam Type Menu','exam-type',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(209,9,208,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(210,9,208,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(211,9,208,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(214,9,207,'Exam Setup Menu','exam',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(215,9,214,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(216,9,214,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(217,9,207,'Exam Schedule Menu','exam-schedule',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(218,9,217,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(219,9,217,'Create','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(220,9,207,'Exam Attendance Menu','exam-attendance',0,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(221,9,220,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(222,9,220,'Marks Register Menu','marks-register',0,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(223,9,220,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(224,9,220,'Create','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(225,9,207,'Marks Grade Menu','marks-grade',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(226,9,225,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(227,9,225,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(228,9,225,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(229,9,207,'Send Marks By SMS Menu','send-marks-by-sms',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(230,9,207,'Question Group Menu','question-group',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(231,9,230,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(232,9,230,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(233,9,230,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(234,9,207,'Question Bank Menu','question-bank',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(235,9,234,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(236,9,234,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(237,9,234,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(238,9,207,'Online Exam Menu','online-exam',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(239,9,238,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(240,9,238,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(241,9,238,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(242,9,238,'Manage Question','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(243,9,238,'Marks Register','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(244,9,238,'Result','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(245,10,0,'Academics Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(246,10,245,'Class Routine Menu','class-routine-new',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(247,10,246,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(248,10,246,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(249,10,246,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(250,10,245,'Assign Subject Menu','assign-subject',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(251,10,250,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(252,10,250,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(253,10,245,'Assign Class Teacher Menu','assign-class-teacher',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(254,10,253,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(255,10,253,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(256,10,253,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(257,10,245,'Subjects Menu','subject',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(258,10,257,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(259,10,257,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(260,10,257,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(261,10,245,'Class Menu','class',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(262,10,261,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(263,10,261,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(264,10,261,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(265,10,245,'Section Menu','section',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(266,10,265,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(267,10,265,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(268,10,265,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(269,10,245,'Class Room Menu','class-room',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(270,10,269,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(271,10,269,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(272,10,269,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(273,10,245,'CL/EX Time Setup Menu','class-time',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(274,10,273,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(275,10,273,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(276,10,273,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(277,11,0,'Homework Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(278,11,277,'Add Homework Menu','add-homeworks',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(279,11,278,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(280,11,277,'Homework List Menu','homework-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(281,11,280,'Evaluation','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(282,11,280,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(283,11,280,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(284,11,277,'Homework Evaluation Report Menu','evaluation-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(285,11,284,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(286,12,0,'Communicate Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(287,12,286,'Notice Board Menu','notice-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(288,12,287,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(289,12,287,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(290,12,287,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(291,12,286,'Send Email / SMS  Menu','send-email-sms-view',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(292,12,291,'Send','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(293,12,286,'Email / SMS Log Menu','email-sms-log',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(294,12,286,'Event Menu','event',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(295,12,294,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(296,12,294,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(297,12,294,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(298,13,0,'Library Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(299,13,298,'Add Book Menu','add-book',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(300,13,299,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(301,13,298,'Book List  Menu','book-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(302,13,301,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(303,13,301,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(304,13,298,'Book Category Menu','book-category-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(305,13,304,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(306,13,304,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(307,13,304,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(308,13,298,'Add Member Menu','library-member',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(309,13,308,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(310,13,308,'Cancel','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(311,13,298,'Issue/Return Book Menu','member-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(312,13,311,'Issue','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(313,13,311,'Return','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(314,13,298,'All Issued Book','all-issed-book',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(315,14,0,'Inventory Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(316,14,315,'Item Category Menu','item-category',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(317,14,316,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(318,14,316,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(319,14,316,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(320,14,315,'Item List Menu','item-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(321,14,320,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(322,14,320,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(323,14,320,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(324,14,315,'Item Store Menu','item-store',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(325,14,324,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(326,14,324,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(327,14,324,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(328,14,315,'Supplier Menu','suppliers',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(329,14,328,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(330,14,328,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(331,14,328,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(332,14,315,'Item Receive Menu','item-receive',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(333,14,332,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(334,14,315,'Item Receive List Menu','item-receive-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(335,14,334,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(336,14,334,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(337,14,334,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(338,14,334,'Cancel','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(339,14,315,'Item Sell Menu','item-sell-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(340,14,339,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(341,14,339,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(342,14,339,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(343,14,339,'Add Payment','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(344,14,339,'View Payment','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(345,14,315,'Item Issue Menu','item-issue',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(346,14,345,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(347,14,345,'Return','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(348,15,0,'Transport Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(349,15,348,'Routes Menu','transport-route',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(350,15,349,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(351,15,349,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(352,15,349,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(353,15,348,'Vehicle Menu','vehicle',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(354,15,353,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(355,15,353,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(356,15,353,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(357,15,348,'Assign Vehicle Menu','assign-vehicle',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(358,15,357,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(359,15,357,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(360,15,357,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(361,15,348,'Student Transport Report Menu','student-transport-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(362,16,0,'Dormitory Menu','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(363,16,362,'Dormitory Rooms Menu','room-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(364,16,363,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(365,16,363,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(366,16,363,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(367,16,362,'Dormitory Menu','dormitory-list',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(368,16,367,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(369,16,367,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(370,16,367,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(371,16,362,'Room Type Menu','room-type',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(372,16,371,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(373,16,371,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(374,16,371,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(375,16,362,'Student Dormitory Report Menu','student-dormitory-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(376,17,0,'Reports Menu','student-report',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(377,17,376,'Guardian Report Menu','guardian-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(378,17,376,'Student History Menu','student-history',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(379,17,376,'Student Login Report','student-login-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(380,17,379,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(381,17,376,'Fees Statement Menu','fees-statement',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(382,17,376,'Balance Fees Report Menu','balance-fees-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(383,17,376,'Transaction Report Menu','transaction-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(384,17,376,'Class Report Menu','class-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(385,17,376,'Class Routine Menu','class-routine-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(386,17,376,'Exam Routine Menu','exam-routine-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(387,17,376,'Teacher Class Routine Menu','teacher-class-routine-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(388,17,376,'Merit List Report Menu','merit-list-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(389,17,376,'Online Exam Report Menu','online-exam-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(390,17,376,'Mark Sheet Report Menu','mark-sheet-report-student',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(391,17,376,'Tabulation Sheet Report Menu','tabulation-sheet-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(392,17,376,'Progress Card Report Menu','progress-card-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(393,17,376,'Student Fine Report Menu','student-fine-report',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(394,17,376,'User Log Menu','user-log',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(395,8,394,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(396,8,394,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(397,9,394,'Exam Setup Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(398,18,0,'Systemm settings module','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(399,18,398,'Manage Add-ons','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(400,18,399,'Verify','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(401,18,398,'Manage Currency','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(402,18,401,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(403,18,401,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(404,18,401,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(405,18,398,'General Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(406,18,405,'Logo Change','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(407,18,405,'Fevicon Change','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(408,18,405,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(409,18,405,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(410,18,398,'Email Setting','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(411,18,410,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(412,18,398,'Payment Method Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(413,18,412,'Gateway Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(414,18,412,'PayPal Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(415,18,412,'Stripe Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(416,18,412,'Paystack Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(417,18,398,'Role','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(418,18,417,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(419,18,417,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(420,18,417,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(421,18,398,'Login Permission','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(422,18,421,'On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(423,18,421,'Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(424,18,398,'Optional Subject Setup','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(425,18,424,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(426,18,424,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(427,18,424,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(428,18,398,'Base Setup','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(429,18,428,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(430,18,428,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(431,18,428,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(432,18,398,'Academic Year','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(433,18,432,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(434,18,432,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(435,18,432,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(436,18,398,'Custom Result Setting','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(437,18,436,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(438,18,436,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(439,18,436,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(440,18,398,'Holiday','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(441,18,440,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(442,18,440,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(443,18,440,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(444,18,398,'Sms Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(445,18,444,' Select SMS Service','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(446,18,444,' Twilio Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(447,18,444,' MSG91 Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(448,18,398,'Weekend','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(449,18,448,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(450,18,448,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(451,18,398,'Language Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(452,18,451,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(453,18,451,'Make Default','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(454,18,451,'Setup','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(455,18,451,'Remove','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(456,18,398,'Backup','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(457,18,456,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(458,18,456,'Download','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(459,18,456,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(460,18,456,'Image','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(461,18,456,'Full Project','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(462,18,456,'Database','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(463,18,398,'Button Manage','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(464,18,463,'Custom URL Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(465,18,463,'Website On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(466,18,463,'Website Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(467,18,463,'Dashboard On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(468,18,463,'Dashboard Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(469,18,463,'Report On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(470,18,463,'Report Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(471,18,463,'Language On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(472,18,463,'Language Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(473,18,463,'Style On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(474,18,463,'Style Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(475,18,463,'LTL To RTL On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(476,18,463,'LTL To RTL Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(477,18,398,'About','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(478,18,477,'Update','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(479,18,477,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(480,18,398,'Email Template','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(481,18,480,'Save','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(482,18,398,'API Permission','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(483,18,482,'On','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(484,18,482,'Off','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(485,19,0,'Style Module','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(486,19,485,'Background Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(487,19,486,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(488,19,486,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(489,19,486,'Make Default','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(490,19,485,'Color Themes','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(491,19,490,'Make Default','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(492,20,0,'Front settings Module','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(493,20,492,'Home Page','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(494,20,493,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(495,20,492,'News List','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(496,20,495,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(497,20,495,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(498,20,495,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(499,20,495,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(500,20,492,'News Category','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(501,20,500,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(502,20,500,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(503,20,500,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(504,20,492,'Testimonial','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(505,20,504,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(506,20,504,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(507,20,504,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(508,20,504,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(509,20,492,'Course List','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(510,20,509,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(511,20,509,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(512,20,509,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(513,20,509,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(514,20,492,'Contact Page','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(515,20,514,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(516,20,514,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(517,20,492,'Contact Messages','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(518,20,517,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(519,20,517,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(520,20,492,'About Page','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(521,20,520,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(522,20,520,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(523,20,492,'News Heading','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(524,20,523,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(525,20,492,'Course Heading','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(526,20,525,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(527,20,492,'Custom Links','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(528,20,527,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(529,20,492,'Social Media','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(530,20,529,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(531,20,529,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(532,20,529,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(533,3,61,'Subject Wise Attendance','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(534,3,533,'Save','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(535,3,61,'Subject Wise Attendance Report','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(536,3,535,'Print','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(537,10,245,'Optional Subject','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(538,17,376,'Student Report','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(539,17,376,'Previous Result','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(540,17,376,'Previous Record','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(541,18,417,'Assign Permission','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(542,21,0,'Registration','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(543,21,542,'Student List','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(544,21,543,'View','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(545,21,543,'Approve','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(546,21,543,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(547,21,542,'Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(548,21,547,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(549,18,398,'Language','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(550,18,549,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(551,18,549,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(552,18,549,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(553,8,193,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(554,22,0,'Zoom','',1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(555,22,554,'Virtual Class','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(556,22,555,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(557,22,555,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(558,22,555,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(559,22,555,'Start Class','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(560,22,554,'Virtual Meeting','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(561,22,560,'Add','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(562,22,560,'Edit','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(563,22,560,'Delete','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(564,22,560,'Start Meeing','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(565,22,554,'Class Report','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(566,22,565,'Search','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(567,22,554,'Meeting Report','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(568,22,567,'Search','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(569,22,554,'Settings','',1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(570,22,569,'Update','',1,1,1,1,3,'2019-07-24 21:21:21','2019-07-24 23:24:22');
/*!40000 ALTER TABLE `infix_module_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infix_module_managers`
--

DROP TABLE IF EXISTS `infix_module_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infix_module_managers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `version` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `purchase_code` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `installed_domain` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activated_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infix_module_managers`
--

LOCK TABLES `infix_module_managers` WRITE;
/*!40000 ALTER TABLE `infix_module_managers` DISABLE KEYS */;
INSERT INTO `infix_module_managers` VALUES (1,'RolePermission','support@spondonit.com','This is Role Permission Module for manage module. Thanks for using.','0.1','https://spondonit.com/contact','1597057102','http://g-academy.uz','2020-08-10','2020-08-10 05:58:22','2020-08-10 05:58:22'),(2,'TemplateSettings','support@spondonit.com','This is Template setting module for Email & SMS Template. Thanks for using.','0.1','https://spondonit.com/contact','1597057102','http://g-academy.uz','2020-08-10','2020-08-10 05:58:22','2020-08-10 05:58:22');
/*!40000 ALTER TABLE `infix_module_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infix_module_student_parent_infos`
--

DROP TABLE IF EXISTS `infix_module_student_parent_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infix_module_student_parent_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `type` int(11) DEFAULT NULL COMMENT '1 for module, 2 for module link, 3 for module options',
  `user_type` int(11) DEFAULT NULL COMMENT '1 for student, 2 for parent',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `infix_module_student_parent_infos_created_by_foreign` (`created_by`),
  KEY `infix_module_student_parent_infos_updated_by_foreign` (`updated_by`),
  KEY `infix_module_student_parent_infos_school_id_foreign` (`school_id`),
  CONSTRAINT `infix_module_student_parent_infos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `infix_module_student_parent_infos_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `infix_module_student_parent_infos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infix_module_student_parent_infos`
--

LOCK TABLES `infix_module_student_parent_infos` WRITE;
/*!40000 ALTER TABLE `infix_module_student_parent_infos` DISABLE KEYS */;
INSERT INTO `infix_module_student_parent_infos` VALUES (1,1,0,'Dashboard Menu','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(2,1,1,'Subject','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(3,1,1,'Notice','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(4,1,1,'Exam','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(5,1,1,'Online Exam','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(6,1,1,'Teachers','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(7,1,1,'Issued books','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(8,1,1,'Pending homeworks','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(9,1,1,'attendance in current month','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(10,1,1,'Calendar','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(11,2,0,'My Profile','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(12,2,11,'Profile','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(13,2,11,'Fees','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(14,2,11,'Exam','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(15,2,11,'Document','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(16,2,15,'Upload','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(17,2,15,'download','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(18,2,15,'delete','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(19,2,11,'Timeline','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(20,3,0,'Fees','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(21,3,20,'Pay Fees','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(22,4,0,'Class Routine','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(23,5,0,'Homework List','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(24,5,23,'View','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(25,5,23,'Add Content','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(26,6,0,'Download Center','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(27,6,26,'Assignment','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(28,6,27,'Download','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(29,6,26,'Study Material','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(30,6,29,'Download','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(31,6,26,'Syllabus','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(32,6,31,'Download','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(33,6,26,'Other Downloads','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(34,6,33,'Download','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(35,7,0,'Attendance','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(36,8,0,'Examination','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(37,8,36,'Result','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(38,8,36,'Exam Schedule','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(39,9,0,'Leave','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(40,9,39,'Apply Leave','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(41,9,40,'Save','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(42,9,40,'Edit','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(44,9,39,'Pending Leave','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(45,10,0,'Online Exam','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(46,10,45,'Active Exams','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(47,10,45,'View Results','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(48,11,0,'Notice Board','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(49,12,0,'Subject','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(50,13,0,'Teachers List','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(51,14,0,'Library','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(52,14,51,'Book List','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(53,14,51,'Book Issued','',1,1,1,1,2,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(54,15,0,'Transport','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(55,16,0,'Dormitory','',1,1,1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(56,1,0,'Dashboard Menu','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(57,1,56,'Subject','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(58,1,56,'Notice','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(59,1,56,'Exam','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(60,1,56,'Online Exam','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(61,1,56,'Teachers','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(62,1,56,'Issued books','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(63,1,56,'Pending homeworks','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(64,1,56,'attendance in current month','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(65,1,56,'Calendar','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(66,2,0,'My Children','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(67,2,66,'Profile','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(68,2,66,'Fees','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(69,2,66,'Exam','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(70,2,66,'Timeline','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(71,3,0,'Fees','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(72,4,0,'Class Routine','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(73,5,0,'HomeWork ','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(74,5,73,'View','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(75,6,0,'Attendance ','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(76,7,0,'Exam ','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(77,7,76,'Exam Result','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(78,7,76,'Exam Schedule','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(79,7,76,'Online Exam','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(80,8,0,'Leave','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(81,8,80,'Apply Leave','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(82,8,81,'Save','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(83,8,81,'Edit','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(84,8,80,'Pending Leave','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(85,9,0,'Notice Board','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(86,10,0,'Subject','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(87,11,0,'Teachers List','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(88,12,0,'Library','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(89,12,88,'Book List','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(90,12,88,'Book Issued','',1,1,1,1,2,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(91,13,0,'Transport','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(92,14,0,'Dormitory','',1,1,1,1,1,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(93,9,40,'View','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(94,9,40,'Delete','',1,1,1,1,3,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(95,8,81,'View','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(96,8,81,'Delete','',1,1,1,1,3,2,'2019-07-24 21:21:21','2019-07-24 23:24:22');
/*!40000 ALTER TABLE `infix_module_student_parent_infos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infix_permission_assigns`
--

DROP TABLE IF EXISTS `infix_permission_assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infix_permission_assigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL COMMENT ' module id, module link id, module link options id',
  `role_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `infix_permission_assigns_role_id_foreign` (`role_id`),
  KEY `infix_permission_assigns_school_id_foreign` (`school_id`),
  CONSTRAINT `infix_permission_assigns_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `infix_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `infix_permission_assigns_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1044 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infix_permission_assigns`
--

LOCK TABLES `infix_permission_assigns` WRITE;
/*!40000 ALTER TABLE `infix_permission_assigns` DISABLE KEYS */;
INSERT INTO `infix_permission_assigns` VALUES (1,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',1,5,1,1,1),(2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',2,5,1,1,1),(3,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',3,5,1,1,1),(4,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',4,5,1,1,1),(5,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',5,5,1,1,1),(6,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',6,5,1,1,1),(7,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',7,5,1,1,1),(8,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',8,5,1,1,1),(9,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',9,5,1,1,1),(10,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',10,5,1,1,1),(11,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',11,5,1,1,1),(12,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',12,5,1,1,1),(13,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',13,5,1,1,1),(14,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',14,5,1,1,1),(15,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',15,5,1,1,1),(16,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',16,5,1,1,1),(17,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',17,5,1,1,1),(18,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',18,5,1,1,1),(19,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',19,5,1,1,1),(20,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',20,5,1,1,1),(21,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',21,5,1,1,1),(22,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',22,5,1,1,1),(23,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',23,5,1,1,1),(24,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',24,5,1,1,1),(25,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',25,5,1,1,1),(26,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',26,5,1,1,1),(27,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',27,5,1,1,1),(28,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',28,5,1,1,1),(29,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',29,5,1,1,1),(30,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',30,5,1,1,1),(31,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',31,5,1,1,1),(32,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',32,5,1,1,1),(33,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',33,5,1,1,1),(34,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',34,5,1,1,1),(35,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',35,5,1,1,1),(36,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',36,5,1,1,1),(37,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',37,5,1,1,1),(38,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',38,5,1,1,1),(39,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',39,5,1,1,1),(40,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',40,5,1,1,1),(41,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',41,5,1,1,1),(42,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',42,5,1,1,1),(43,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',43,5,1,1,1),(44,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',44,5,1,1,1),(45,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',45,5,1,1,1),(46,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',46,5,1,1,1),(47,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',47,5,1,1,1),(48,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',48,5,1,1,1),(49,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',49,5,1,1,1),(50,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',50,5,1,1,1),(51,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',51,5,1,1,1),(52,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',52,5,1,1,1),(53,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',53,5,1,1,1),(54,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',54,5,1,1,1),(55,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',55,5,1,1,1),(56,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',56,5,1,1,1),(57,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',57,5,1,1,1),(58,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',58,5,1,1,1),(59,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',59,5,1,1,1),(60,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',60,5,1,1,1),(61,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',61,5,1,1,1),(62,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',62,5,1,1,1),(63,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',63,5,1,1,1),(64,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',64,5,1,1,1),(65,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',65,5,1,1,1),(66,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',66,5,1,1,1),(67,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',67,5,1,1,1),(68,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',68,5,1,1,1),(69,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',69,5,1,1,1),(70,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',70,5,1,1,1),(71,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',71,5,1,1,1),(72,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',72,5,1,1,1),(73,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',73,5,1,1,1),(74,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',74,5,1,1,1),(75,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',75,5,1,1,1),(76,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',76,5,1,1,1),(77,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',77,5,1,1,1),(78,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',79,5,1,1,1),(79,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',80,5,1,1,1),(80,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',81,5,1,1,1),(81,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',82,5,1,1,1),(82,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',83,5,1,1,1),(83,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',84,5,1,1,1),(84,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',85,5,1,1,1),(85,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',86,5,1,1,1),(86,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',533,5,1,1,1),(87,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',534,5,1,1,1),(88,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',535,5,1,1,1),(89,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',536,5,1,1,1),(90,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',87,5,1,1,1),(91,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',88,5,1,1,1),(92,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',89,5,1,1,1),(93,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',90,5,1,1,1),(94,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',91,5,1,1,1),(95,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',92,5,1,1,1),(96,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',93,5,1,1,1),(97,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',94,5,1,1,1),(98,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',95,5,1,1,1),(99,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',96,5,1,1,1),(100,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',97,5,1,1,1),(101,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',98,5,1,1,1),(102,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',99,5,1,1,1),(103,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',100,5,1,1,1),(104,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',101,5,1,1,1),(105,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',102,5,1,1,1),(106,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',103,5,1,1,1),(107,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',104,5,1,1,1),(108,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',105,5,1,1,1),(109,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',106,5,1,1,1),(110,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',107,5,1,1,1),(111,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',108,5,1,1,1),(112,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',109,5,1,1,1),(113,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',110,5,1,1,1),(114,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',111,5,1,1,1),(115,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',112,5,1,1,1),(116,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',113,5,1,1,1),(117,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',114,5,1,1,1),(118,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',115,5,1,1,1),(119,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',116,5,1,1,1),(120,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',117,5,1,1,1),(121,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',118,5,1,1,1),(122,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',119,5,1,1,1),(123,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',120,5,1,1,1),(124,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',121,5,1,1,1),(125,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',122,5,1,1,1),(126,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',123,5,1,1,1),(127,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',124,5,1,1,1),(128,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',125,5,1,1,1),(129,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',126,5,1,1,1),(130,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',127,5,1,1,1),(131,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',128,5,1,1,1),(132,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',129,5,1,1,1),(133,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',130,5,1,1,1),(134,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',131,5,1,1,1),(135,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',132,5,1,1,1),(136,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',133,5,1,1,1),(137,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',134,5,1,1,1),(138,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',135,5,1,1,1),(139,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',136,5,1,1,1),(140,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',160,5,1,1,1),(141,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',161,5,1,1,1),(142,1,'2020-08-10 05:58:21','2020-08-10 05:58:21',162,5,1,1,1),(143,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',163,5,1,1,1),(144,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',164,5,1,1,1),(145,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',165,5,1,1,1),(146,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',166,5,1,1,1),(147,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',167,5,1,1,1),(148,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',168,5,1,1,1),(149,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',169,5,1,1,1),(150,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',170,5,1,1,1),(151,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',171,5,1,1,1),(152,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',172,5,1,1,1),(153,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',173,5,1,1,1),(154,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',174,5,1,1,1),(155,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',175,5,1,1,1),(156,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',176,5,1,1,1),(157,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',177,5,1,1,1),(158,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',178,5,1,1,1),(159,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',179,5,1,1,1),(160,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',180,5,1,1,1),(161,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',181,5,1,1,1),(162,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',182,5,1,1,1),(163,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',183,5,1,1,1),(164,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',184,5,1,1,1),(165,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',185,5,1,1,1),(166,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',186,5,1,1,1),(167,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',187,5,1,1,1),(168,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,5,1,1,1),(169,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',189,5,1,1,1),(170,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',190,5,1,1,1),(171,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',191,5,1,1,1),(172,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',192,5,1,1,1),(173,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,5,1,1,1),(174,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,5,1,1,1),(175,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',195,5,1,1,1),(176,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',196,5,1,1,1),(177,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',197,5,1,1,1),(178,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',198,5,1,1,1),(179,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',199,5,1,1,1),(180,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',200,5,1,1,1),(181,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',201,5,1,1,1),(182,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',202,5,1,1,1),(183,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',203,5,1,1,1),(184,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',204,5,1,1,1),(185,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',205,5,1,1,1),(186,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',206,5,1,1,1),(187,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',207,5,1,1,1),(188,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',208,5,1,1,1),(189,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',209,5,1,1,1),(190,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',210,5,1,1,1),(191,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',211,5,1,1,1),(192,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',214,5,1,1,1),(193,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',215,5,1,1,1),(194,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',216,5,1,1,1),(195,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',217,5,1,1,1),(196,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',218,5,1,1,1),(197,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',219,5,1,1,1),(198,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',225,5,1,1,1),(199,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',226,5,1,1,1),(200,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',227,5,1,1,1),(201,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',228,5,1,1,1),(202,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',229,5,1,1,1),(203,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',230,5,1,1,1),(204,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',231,5,1,1,1),(205,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',232,5,1,1,1),(206,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',233,5,1,1,1),(207,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',234,5,1,1,1),(208,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',235,5,1,1,1),(209,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',236,5,1,1,1),(210,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',237,5,1,1,1),(211,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',238,5,1,1,1),(212,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',239,5,1,1,1),(213,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',240,5,1,1,1),(214,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',241,5,1,1,1),(215,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',242,5,1,1,1),(216,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',243,5,1,1,1),(217,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',244,5,1,1,1),(218,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',245,5,1,1,1),(219,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',246,5,1,1,1),(220,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',247,5,1,1,1),(221,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',248,5,1,1,1),(222,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',249,5,1,1,1),(223,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',250,5,1,1,1),(224,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',251,5,1,1,1),(225,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',252,5,1,1,1),(226,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',253,5,1,1,1),(227,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',254,5,1,1,1),(228,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',255,5,1,1,1),(229,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',256,5,1,1,1),(230,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',257,5,1,1,1),(231,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',258,5,1,1,1),(232,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',259,5,1,1,1),(233,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',260,5,1,1,1),(234,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',261,5,1,1,1),(235,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',262,5,1,1,1),(236,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',263,5,1,1,1),(237,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',264,5,1,1,1),(238,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',265,5,1,1,1),(239,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',266,5,1,1,1),(240,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',267,5,1,1,1),(241,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',268,5,1,1,1),(242,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',269,5,1,1,1),(243,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',270,5,1,1,1),(244,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',271,5,1,1,1),(245,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',272,5,1,1,1),(246,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',273,5,1,1,1),(247,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',274,5,1,1,1),(248,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',275,5,1,1,1),(249,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',276,5,1,1,1),(250,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',537,5,1,1,1),(251,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',286,5,1,1,1),(252,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',287,5,1,1,1),(253,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',288,5,1,1,1),(254,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',289,5,1,1,1),(255,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',290,5,1,1,1),(256,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',291,5,1,1,1),(257,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',292,5,1,1,1),(258,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',293,5,1,1,1),(259,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',294,5,1,1,1),(260,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',295,5,1,1,1),(261,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',296,5,1,1,1),(262,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',297,5,1,1,1),(263,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',298,5,1,1,1),(264,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',299,5,1,1,1),(265,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',300,5,1,1,1),(266,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',301,5,1,1,1),(267,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',302,5,1,1,1),(268,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',303,5,1,1,1),(269,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',304,5,1,1,1),(270,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',305,5,1,1,1),(271,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',306,5,1,1,1),(272,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',307,5,1,1,1),(273,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',308,5,1,1,1),(274,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',309,5,1,1,1),(275,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',310,5,1,1,1),(276,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',311,5,1,1,1),(277,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',312,5,1,1,1),(278,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',313,5,1,1,1),(279,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',314,5,1,1,1),(280,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',315,5,1,1,1),(281,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',316,5,1,1,1),(282,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',317,5,1,1,1),(283,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',318,5,1,1,1),(284,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',319,5,1,1,1),(285,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',320,5,1,1,1),(286,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',321,5,1,1,1),(287,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',322,5,1,1,1),(288,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',323,5,1,1,1),(289,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',324,5,1,1,1),(290,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',325,5,1,1,1),(291,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',326,5,1,1,1),(292,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',327,5,1,1,1),(293,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',328,5,1,1,1),(294,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',329,5,1,1,1),(295,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',330,5,1,1,1),(296,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',331,5,1,1,1),(297,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',332,5,1,1,1),(298,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',333,5,1,1,1),(299,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',334,5,1,1,1),(300,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',335,5,1,1,1),(301,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',336,5,1,1,1),(302,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',337,5,1,1,1),(303,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',338,5,1,1,1),(304,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',339,5,1,1,1),(305,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',340,5,1,1,1),(306,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',341,5,1,1,1),(307,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',342,5,1,1,1),(308,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',343,5,1,1,1),(309,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',344,5,1,1,1),(310,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',345,5,1,1,1),(311,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',346,5,1,1,1),(312,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',347,5,1,1,1),(313,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',348,5,1,1,1),(314,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',349,5,1,1,1),(315,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',350,5,1,1,1),(316,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',351,5,1,1,1),(317,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',352,5,1,1,1),(318,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',353,5,1,1,1),(319,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',354,5,1,1,1),(320,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',355,5,1,1,1),(321,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',356,5,1,1,1),(322,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',357,5,1,1,1),(323,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',358,5,1,1,1),(324,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',359,5,1,1,1),(325,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',360,5,1,1,1),(326,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',361,5,1,1,1),(327,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',362,5,1,1,1),(328,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',363,5,1,1,1),(329,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',364,5,1,1,1),(330,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',365,5,1,1,1),(331,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',366,5,1,1,1),(332,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',367,5,1,1,1),(333,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',368,5,1,1,1),(334,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',369,5,1,1,1),(335,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',370,5,1,1,1),(336,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',371,5,1,1,1),(337,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',372,5,1,1,1),(338,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',373,5,1,1,1),(339,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',374,5,1,1,1),(340,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',375,5,1,1,1),(341,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',376,5,1,1,1),(342,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',377,5,1,1,1),(343,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',378,5,1,1,1),(344,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',379,5,1,1,1),(345,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',380,5,1,1,1),(346,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',381,5,1,1,1),(347,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',382,5,1,1,1),(348,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',383,5,1,1,1),(349,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',384,5,1,1,1),(350,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',385,5,1,1,1),(351,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',386,5,1,1,1),(352,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',387,5,1,1,1),(353,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',388,5,1,1,1),(354,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',389,5,1,1,1),(355,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',390,5,1,1,1),(356,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',391,5,1,1,1),(357,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',392,5,1,1,1),(358,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',393,5,1,1,1),(359,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',394,5,1,1,1),(360,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',395,5,1,1,1),(361,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',396,5,1,1,1),(362,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',397,5,1,1,1),(363,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',538,5,1,1,1),(364,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',539,5,1,1,1),(365,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',540,5,1,1,1),(366,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',485,5,1,1,1),(367,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',486,5,1,1,1),(368,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',487,5,1,1,1),(369,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',488,5,1,1,1),(370,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',489,5,1,1,1),(371,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',490,5,1,1,1),(372,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',491,5,1,1,1),(373,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,5,1,1,1),(374,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,5,1,1,1),(375,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',555,5,1,1,1),(376,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',556,5,1,1,1),(377,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',557,5,1,1,1),(378,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',558,5,1,1,1),(379,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',559,5,1,1,1),(380,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,5,1,1,1),(381,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',561,5,1,1,1),(382,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',562,5,1,1,1),(383,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',563,5,1,1,1),(384,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,5,1,1,1),(385,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',565,5,1,1,1),(386,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',566,5,1,1,1),(387,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',567,5,1,1,1),(388,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',568,5,1,1,1),(389,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',569,5,1,1,1),(390,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',570,5,1,1,1),(391,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,4,1,1,1),(392,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,4,1,1,1),(393,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,4,1,1,1),(394,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,4,1,1,1),(395,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,4,1,1,1),(396,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,4,1,1,1),(397,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,4,1,1,1),(398,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,4,1,1,1),(399,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,4,1,1,1),(400,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,4,1,1,1),(401,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',61,4,1,1,1),(402,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',62,4,1,1,1),(403,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',63,4,1,1,1),(404,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',64,4,1,1,1),(405,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',65,4,1,1,1),(406,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',66,4,1,1,1),(407,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',67,4,1,1,1),(408,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',68,4,1,1,1),(409,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',69,4,1,1,1),(410,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',70,4,1,1,1),(411,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',71,4,1,1,1),(412,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',72,4,1,1,1),(413,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',73,4,1,1,1),(414,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',74,4,1,1,1),(415,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',75,4,1,1,1),(416,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',76,4,1,1,1),(417,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',77,4,1,1,1),(418,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',79,4,1,1,1),(419,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',80,4,1,1,1),(420,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',81,4,1,1,1),(421,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',82,4,1,1,1),(422,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',83,4,1,1,1),(423,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',84,4,1,1,1),(424,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',85,4,1,1,1),(425,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',86,4,1,1,1),(426,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',533,4,1,1,1),(427,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',534,4,1,1,1),(428,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',535,4,1,1,1),(429,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',536,4,1,1,1),(430,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',87,4,1,1,1),(431,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',88,4,1,1,1),(432,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',89,4,1,1,1),(433,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',90,4,1,1,1),(434,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',91,4,1,1,1),(435,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',92,4,1,1,1),(436,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',93,4,1,1,1),(437,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',94,4,1,1,1),(438,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',95,4,1,1,1),(439,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',96,4,1,1,1),(440,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',97,4,1,1,1),(441,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',98,4,1,1,1),(442,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',99,4,1,1,1),(443,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',100,4,1,1,1),(444,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',101,4,1,1,1),(445,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',102,4,1,1,1),(446,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',103,4,1,1,1),(447,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',104,4,1,1,1),(448,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',105,4,1,1,1),(449,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',106,4,1,1,1),(450,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',107,4,1,1,1),(451,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',160,4,1,1,1),(452,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',161,4,1,1,1),(453,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',162,4,1,1,1),(454,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',163,4,1,1,1),(455,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',164,4,1,1,1),(456,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',165,4,1,1,1),(457,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',166,4,1,1,1),(458,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',167,4,1,1,1),(459,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',168,4,1,1,1),(460,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',169,4,1,1,1),(461,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',170,4,1,1,1),(462,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',171,4,1,1,1),(463,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',172,4,1,1,1),(464,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',173,4,1,1,1),(465,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',174,4,1,1,1),(466,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',175,4,1,1,1),(467,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',176,4,1,1,1),(468,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',177,4,1,1,1),(469,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',178,4,1,1,1),(470,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',179,4,1,1,1),(471,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',180,4,1,1,1),(472,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',181,4,1,1,1),(473,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',182,4,1,1,1),(474,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',183,4,1,1,1),(475,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',184,4,1,1,1),(476,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',185,4,1,1,1),(477,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',186,4,1,1,1),(478,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',187,4,1,1,1),(479,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,4,1,1,1),(480,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',189,4,1,1,1),(481,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',190,4,1,1,1),(482,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',191,4,1,1,1),(483,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',192,4,1,1,1),(484,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,4,1,1,1),(485,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,4,1,1,1),(486,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',195,4,1,1,1),(487,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',196,4,1,1,1),(488,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',197,4,1,1,1),(489,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',198,4,1,1,1),(490,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',199,4,1,1,1),(491,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',200,4,1,1,1),(492,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',201,4,1,1,1),(493,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',202,4,1,1,1),(494,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',203,4,1,1,1),(495,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',204,4,1,1,1),(496,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',205,4,1,1,1),(497,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',206,4,1,1,1),(498,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',207,4,1,1,1),(499,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',208,4,1,1,1),(500,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',209,4,1,1,1),(501,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',210,4,1,1,1),(502,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',211,4,1,1,1),(503,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',214,4,1,1,1),(504,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',215,4,1,1,1),(505,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',216,4,1,1,1),(506,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',217,4,1,1,1),(507,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',218,4,1,1,1),(508,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',219,4,1,1,1),(509,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',225,4,1,1,1),(510,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',226,4,1,1,1),(511,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',227,4,1,1,1),(512,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',228,4,1,1,1),(513,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',229,4,1,1,1),(514,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',230,4,1,1,1),(515,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',231,4,1,1,1),(516,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',232,4,1,1,1),(517,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',233,4,1,1,1),(518,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',234,4,1,1,1),(519,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',235,4,1,1,1),(520,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',236,4,1,1,1),(521,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',237,4,1,1,1),(522,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',238,4,1,1,1),(523,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',239,4,1,1,1),(524,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',240,4,1,1,1),(525,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',241,4,1,1,1),(526,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',242,4,1,1,1),(527,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',243,4,1,1,1),(528,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',244,4,1,1,1),(529,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',245,4,1,1,1),(530,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',246,4,1,1,1),(531,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',247,4,1,1,1),(532,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',248,4,1,1,1),(533,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',249,4,1,1,1),(534,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',250,4,1,1,1),(535,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',251,4,1,1,1),(536,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',252,4,1,1,1),(537,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',253,4,1,1,1),(538,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',254,4,1,1,1),(539,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',255,4,1,1,1),(540,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',256,4,1,1,1),(541,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',257,4,1,1,1),(542,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',258,4,1,1,1),(543,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',259,4,1,1,1),(544,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',260,4,1,1,1),(545,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',261,4,1,1,1),(546,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',262,4,1,1,1),(547,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',263,4,1,1,1),(548,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',264,4,1,1,1),(549,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',265,4,1,1,1),(550,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',266,4,1,1,1),(551,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',267,4,1,1,1),(552,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',268,4,1,1,1),(553,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',269,4,1,1,1),(554,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',270,4,1,1,1),(555,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',271,4,1,1,1),(556,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',272,4,1,1,1),(557,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',273,4,1,1,1),(558,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',274,4,1,1,1),(559,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',275,4,1,1,1),(560,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',276,4,1,1,1),(561,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',537,4,1,1,1),(562,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',286,4,1,1,1),(563,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',287,4,1,1,1),(564,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',288,4,1,1,1),(565,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',289,4,1,1,1),(566,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',290,4,1,1,1),(567,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',291,4,1,1,1),(568,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',292,4,1,1,1),(569,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',293,4,1,1,1),(570,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',294,4,1,1,1),(571,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',295,4,1,1,1),(572,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',296,4,1,1,1),(573,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',297,4,1,1,1),(574,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',298,4,1,1,1),(575,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',299,4,1,1,1),(576,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',300,4,1,1,1),(577,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',301,4,1,1,1),(578,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',302,4,1,1,1),(579,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',303,4,1,1,1),(580,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',304,4,1,1,1),(581,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',305,4,1,1,1),(582,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',306,4,1,1,1),(583,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',307,4,1,1,1),(584,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',308,4,1,1,1),(585,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',309,4,1,1,1),(586,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',310,4,1,1,1),(587,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',311,4,1,1,1),(588,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',312,4,1,1,1),(589,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',313,4,1,1,1),(590,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',314,4,1,1,1),(591,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',348,4,1,1,1),(592,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',349,4,1,1,1),(593,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',350,4,1,1,1),(594,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',351,4,1,1,1),(595,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',352,4,1,1,1),(596,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',353,4,1,1,1),(597,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',354,4,1,1,1),(598,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',355,4,1,1,1),(599,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',356,4,1,1,1),(600,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',357,4,1,1,1),(601,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',358,4,1,1,1),(602,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',359,4,1,1,1),(603,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',360,4,1,1,1),(604,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',361,4,1,1,1),(605,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',362,4,1,1,1),(606,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',363,4,1,1,1),(607,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',364,4,1,1,1),(608,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',365,4,1,1,1),(609,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',366,4,1,1,1),(610,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',367,4,1,1,1),(611,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',368,4,1,1,1),(612,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',369,4,1,1,1),(613,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',370,4,1,1,1),(614,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',371,4,1,1,1),(615,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',372,4,1,1,1),(616,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',373,4,1,1,1),(617,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',374,4,1,1,1),(618,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',375,4,1,1,1),(619,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',277,4,1,1,1),(620,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',278,4,1,1,1),(621,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',279,4,1,1,1),(622,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',280,4,1,1,1),(623,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',281,4,1,1,1),(624,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',282,4,1,1,1),(625,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',283,4,1,1,1),(626,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',284,4,1,1,1),(627,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',285,4,1,1,1),(628,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,4,1,1,1),(629,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,4,1,1,1),(630,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',555,4,1,1,1),(631,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',556,4,1,1,1),(632,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',557,4,1,1,1),(633,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',558,4,1,1,1),(634,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',559,4,1,1,1),(635,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,4,1,1,1),(636,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',561,4,1,1,1),(637,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',562,4,1,1,1),(638,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',563,4,1,1,1),(639,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,4,1,1,1),(640,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',565,4,1,1,1),(641,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',566,4,1,1,1),(642,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',567,4,1,1,1),(643,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,7,1,1,1),(644,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,7,1,1,1),(645,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,7,1,1,1),(646,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,7,1,1,1),(647,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,7,1,1,1),(648,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,7,1,1,1),(649,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,7,1,1,1),(650,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,7,1,1,1),(651,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,7,1,1,1),(652,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,7,1,1,1),(653,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',11,7,1,1,1),(654,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',12,7,1,1,1),(655,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',13,7,1,1,1),(656,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',14,7,1,1,1),(657,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',15,7,1,1,1),(658,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',16,7,1,1,1),(659,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',17,7,1,1,1),(660,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',18,7,1,1,1),(661,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',19,7,1,1,1),(662,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',20,7,1,1,1),(663,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',21,7,1,1,1),(664,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',22,7,1,1,1),(665,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',23,7,1,1,1),(666,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',24,7,1,1,1),(667,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',25,7,1,1,1),(668,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',26,7,1,1,1),(669,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',27,7,1,1,1),(670,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',28,7,1,1,1),(671,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',29,7,1,1,1),(672,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',30,7,1,1,1),(673,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',31,7,1,1,1),(674,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',32,7,1,1,1),(675,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',33,7,1,1,1),(676,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',34,7,1,1,1),(677,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',35,7,1,1,1),(678,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',36,7,1,1,1),(679,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',37,7,1,1,1),(680,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',38,7,1,1,1),(681,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',39,7,1,1,1),(682,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',40,7,1,1,1),(683,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',41,7,1,1,1),(684,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',42,7,1,1,1),(685,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',43,7,1,1,1),(686,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',44,7,1,1,1),(687,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',45,7,1,1,1),(688,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',46,7,1,1,1),(689,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',47,7,1,1,1),(690,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',48,7,1,1,1),(691,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',49,7,1,1,1),(692,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',50,7,1,1,1),(693,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',51,7,1,1,1),(694,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',52,7,1,1,1),(695,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',53,7,1,1,1),(696,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',54,7,1,1,1),(697,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',55,7,1,1,1),(698,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',56,7,1,1,1),(699,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',57,7,1,1,1),(700,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',58,7,1,1,1),(701,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',59,7,1,1,1),(702,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',60,7,1,1,1),(703,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',61,7,1,1,1),(704,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',64,7,1,1,1),(705,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',65,7,1,1,1),(706,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',66,7,1,1,1),(707,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',67,7,1,1,1),(708,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',83,7,1,1,1),(709,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',84,7,1,1,1),(710,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',85,7,1,1,1),(711,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',86,7,1,1,1),(712,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',160,7,1,1,1),(713,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',161,7,1,1,1),(714,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',162,7,1,1,1),(715,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',163,7,1,1,1),(716,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',164,7,1,1,1),(717,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,7,1,1,1),(718,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,7,1,1,1),(719,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,7,1,1,1),(720,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',195,7,1,1,1),(721,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',376,7,1,1,1),(722,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',377,7,1,1,1),(723,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',378,7,1,1,1),(724,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',379,7,1,1,1),(725,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',380,7,1,1,1),(726,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,7,1,1,1),(727,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,7,1,1,1),(728,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,7,1,1,1),(729,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,7,1,1,1),(730,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,8,1,1,1),(731,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,8,1,1,1),(732,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,8,1,1,1),(733,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,8,1,1,1),(734,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,8,1,1,1),(735,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,8,1,1,1),(736,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,8,1,1,1),(737,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,8,1,1,1),(738,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,8,1,1,1),(739,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,8,1,1,1),(740,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',61,8,1,1,1),(741,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',64,8,1,1,1),(742,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',65,8,1,1,1),(743,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',66,8,1,1,1),(744,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',67,8,1,1,1),(745,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',83,8,1,1,1),(746,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',84,8,1,1,1),(747,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',85,8,1,1,1),(748,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',86,8,1,1,1),(749,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',160,8,1,1,1),(750,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',161,8,1,1,1),(751,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',162,8,1,1,1),(752,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',163,8,1,1,1),(753,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',164,8,1,1,1),(754,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,8,1,1,1),(755,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,8,1,1,1),(756,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,8,1,1,1),(757,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',195,8,1,1,1),(758,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',298,8,1,1,1),(759,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',299,8,1,1,1),(760,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',300,8,1,1,1),(761,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',301,8,1,1,1),(762,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',302,8,1,1,1),(763,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',303,8,1,1,1),(764,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',304,8,1,1,1),(765,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',305,8,1,1,1),(766,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',306,8,1,1,1),(767,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',307,8,1,1,1),(768,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',308,8,1,1,1),(769,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',309,8,1,1,1),(770,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',310,8,1,1,1),(771,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',311,8,1,1,1),(772,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',312,8,1,1,1),(773,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',313,8,1,1,1),(774,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',314,8,1,1,1),(775,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',376,8,1,1,1),(776,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',377,8,1,1,1),(777,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',378,8,1,1,1),(778,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',379,8,1,1,1),(779,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',380,8,1,1,1),(780,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,8,1,1,1),(781,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,8,1,1,1),(782,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,8,1,1,1),(783,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,8,1,1,1),(784,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,9,1,1,1),(785,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,9,1,1,1),(786,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,9,1,1,1),(787,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,9,1,1,1),(788,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,9,1,1,1),(789,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,9,1,1,1),(790,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,9,1,1,1),(791,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,9,1,1,1),(792,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,9,1,1,1),(793,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,9,1,1,1),(794,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,9,1,1,1),(795,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,9,1,1,1),(796,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,9,1,1,1),(797,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',19,9,1,1,1),(798,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,9,1,1,1),(799,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,9,1,1,1),(800,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,9,1,1,1),(801,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,9,1,1,1),(802,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,6,1,1,1),(803,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,6,1,1,1),(804,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,6,1,1,1),(805,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,6,1,1,1),(806,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,6,1,1,1),(807,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,6,1,1,1),(808,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,6,1,1,1),(809,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,6,1,1,1),(810,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,6,1,1,1),(811,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,6,1,1,1),(812,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',11,6,1,1,1),(813,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',12,6,1,1,1),(814,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',13,6,1,1,1),(815,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',14,6,1,1,1),(816,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',15,6,1,1,1),(817,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',16,6,1,1,1),(818,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',17,6,1,1,1),(819,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',18,6,1,1,1),(820,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',19,6,1,1,1),(821,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',20,6,1,1,1),(822,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',21,6,1,1,1),(823,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',22,6,1,1,1),(824,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',23,6,1,1,1),(825,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',24,6,1,1,1),(826,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',25,6,1,1,1),(827,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',26,6,1,1,1),(828,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',27,6,1,1,1),(829,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',28,6,1,1,1),(830,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',29,6,1,1,1),(831,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',30,6,1,1,1),(832,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',31,6,1,1,1),(833,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',32,6,1,1,1),(834,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',33,6,1,1,1),(835,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',34,6,1,1,1),(836,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',35,6,1,1,1),(837,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',36,6,1,1,1),(838,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',37,6,1,1,1),(839,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',38,6,1,1,1),(840,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',39,6,1,1,1),(841,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',40,6,1,1,1),(842,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',41,6,1,1,1),(843,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',42,6,1,1,1),(844,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',43,6,1,1,1),(845,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',44,6,1,1,1),(846,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',45,6,1,1,1),(847,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',46,6,1,1,1),(848,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',47,6,1,1,1),(849,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',48,6,1,1,1),(850,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',49,6,1,1,1),(851,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',50,6,1,1,1),(852,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',51,6,1,1,1),(853,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',52,6,1,1,1),(854,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',53,6,1,1,1),(855,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',54,6,1,1,1),(856,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',55,6,1,1,1),(857,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',56,6,1,1,1),(858,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',57,6,1,1,1),(859,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',58,6,1,1,1),(860,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',59,6,1,1,1),(861,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',60,6,1,1,1),(862,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',61,6,1,1,1),(863,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',64,6,1,1,1),(864,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',65,6,1,1,1),(865,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',66,6,1,1,1),(866,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',67,6,1,1,1),(867,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',68,6,1,1,1),(868,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',69,6,1,1,1),(869,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',70,6,1,1,1),(870,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',83,6,1,1,1),(871,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',84,6,1,1,1),(872,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',85,6,1,1,1),(873,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',86,6,1,1,1),(874,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',108,6,1,1,1),(875,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',109,6,1,1,1),(876,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',110,6,1,1,1),(877,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',111,6,1,1,1),(878,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',112,6,1,1,1),(879,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',113,6,1,1,1),(880,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',114,6,1,1,1),(881,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',115,6,1,1,1),(882,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',116,6,1,1,1),(883,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',117,6,1,1,1),(884,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',118,6,1,1,1),(885,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',119,6,1,1,1),(886,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',120,6,1,1,1),(887,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',121,6,1,1,1),(888,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',122,6,1,1,1),(889,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',123,6,1,1,1),(890,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',124,6,1,1,1),(891,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',125,6,1,1,1),(892,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',126,6,1,1,1),(893,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',127,6,1,1,1),(894,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',128,6,1,1,1),(895,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',129,6,1,1,1),(896,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',130,6,1,1,1),(897,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',131,6,1,1,1),(898,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',132,6,1,1,1),(899,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',133,6,1,1,1),(900,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',134,6,1,1,1),(901,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',135,6,1,1,1),(902,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',136,6,1,1,1),(903,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',160,6,1,1,1),(904,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',161,6,1,1,1),(905,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',162,6,1,1,1),(906,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',163,6,1,1,1),(907,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',164,6,1,1,1),(908,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',165,6,1,1,1),(909,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',166,6,1,1,1),(910,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',167,6,1,1,1),(911,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',168,6,1,1,1),(912,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',169,6,1,1,1),(913,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',170,6,1,1,1),(914,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',171,6,1,1,1),(915,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',172,6,1,1,1),(916,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',173,6,1,1,1),(917,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',174,6,1,1,1),(918,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',175,6,1,1,1),(919,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',176,6,1,1,1),(920,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',177,6,1,1,1),(921,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',178,6,1,1,1),(922,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',179,6,1,1,1),(923,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',188,6,1,1,1),(924,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',193,6,1,1,1),(925,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',194,6,1,1,1),(926,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',195,6,1,1,1),(927,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',376,6,1,1,1),(928,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',377,6,1,1,1),(929,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',378,6,1,1,1),(930,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',379,6,1,1,1),(931,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',380,6,1,1,1),(932,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',381,6,1,1,1),(933,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',382,6,1,1,1),(934,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',383,6,1,1,1),(935,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',553,6,1,1,1),(936,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,6,1,1,1),(937,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,6,1,1,1),(938,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,6,1,1,1),(939,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',1,2,1,1,1),(940,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',2,2,1,1,1),(941,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',3,2,1,1,1),(942,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',4,2,1,1,1),(943,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',5,2,1,1,1),(944,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',6,2,1,1,1),(945,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',7,2,1,1,1),(946,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',8,2,1,1,1),(947,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',9,2,1,1,1),(948,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',10,2,1,1,1),(949,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',11,2,1,1,1),(950,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',12,2,1,1,1),(951,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',13,2,1,1,1),(952,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',14,2,1,1,1),(953,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',15,2,1,1,1),(954,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',16,2,1,1,1),(955,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',17,2,1,1,1),(956,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',18,2,1,1,1),(957,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',19,2,1,1,1),(958,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',20,2,1,1,1),(959,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',21,2,1,1,1),(960,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',22,2,1,1,1),(961,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',23,2,1,1,1),(962,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',24,2,1,1,1),(963,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',25,2,1,1,1),(964,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',26,2,1,1,1),(965,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',27,2,1,1,1),(966,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',28,2,1,1,1),(967,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',29,2,1,1,1),(968,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',30,2,1,1,1),(969,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',31,2,1,1,1),(970,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',32,2,1,1,1),(971,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',33,2,1,1,1),(972,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',34,2,1,1,1),(973,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',35,2,1,1,1),(974,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',36,2,1,1,1),(975,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',37,2,1,1,1),(976,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',38,2,1,1,1),(977,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',39,2,1,1,1),(978,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',40,2,1,1,1),(979,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',41,2,1,1,1),(980,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',42,2,1,1,1),(981,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',43,2,1,1,1),(982,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',44,2,1,1,1),(983,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',45,2,1,1,1),(984,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',46,2,1,1,1),(985,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',47,2,1,1,1),(986,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',48,2,1,1,1),(987,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',49,2,1,1,1),(988,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',50,2,1,1,1),(989,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',51,2,1,1,1),(990,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',52,2,1,1,1),(991,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',53,2,1,1,1),(992,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',54,2,1,1,1),(993,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',55,2,1,1,1),(994,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,2,1,1,1),(995,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',555,2,1,1,1),(996,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',559,2,1,1,1),(997,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,2,1,1,1),(998,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',56,3,1,1,1),(999,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',57,3,1,1,1),(1000,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',58,3,1,1,1),(1001,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',59,3,1,1,1),(1002,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',60,3,1,1,1),(1003,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',61,3,1,1,1),(1004,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',62,3,1,1,1),(1005,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',63,3,1,1,1),(1006,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',64,3,1,1,1),(1007,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',65,3,1,1,1),(1008,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',66,3,1,1,1),(1009,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',67,3,1,1,1),(1010,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',68,3,1,1,1),(1011,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',69,3,1,1,1),(1012,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',70,3,1,1,1),(1013,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',71,3,1,1,1),(1014,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',72,3,1,1,1),(1015,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',73,3,1,1,1),(1016,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',74,3,1,1,1),(1017,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',75,3,1,1,1),(1018,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',76,3,1,1,1),(1019,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',77,3,1,1,1),(1020,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',78,3,1,1,1),(1021,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',79,3,1,1,1),(1022,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',80,3,1,1,1),(1023,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',81,3,1,1,1),(1024,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',82,3,1,1,1),(1025,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',83,3,1,1,1),(1026,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',84,3,1,1,1),(1027,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',85,3,1,1,1),(1028,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',86,3,1,1,1),(1029,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',87,3,1,1,1),(1030,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',88,3,1,1,1),(1031,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',89,3,1,1,1),(1032,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',90,3,1,1,1),(1033,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',91,3,1,1,1),(1034,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',92,3,1,1,1),(1035,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',93,3,1,1,1),(1036,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',94,3,1,1,1),(1037,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',95,3,1,1,1),(1038,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',96,3,1,1,1),(1039,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',554,3,1,1,1),(1040,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',555,3,1,1,1),(1041,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',560,3,1,1,1),(1042,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',559,3,1,1,1),(1043,1,'2020-08-10 05:58:22','2020-08-10 05:58:22',564,3,1,1,1);
/*!40000 ALTER TABLE `infix_permission_assigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `infix_roles`
--

DROP TABLE IF EXISTS `infix_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `infix_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'System',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `updated_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `infix_roles_school_id_foreign` (`school_id`),
  CONSTRAINT `infix_roles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `infix_roles`
--

LOCK TABLES `infix_roles` WRITE;
/*!40000 ALTER TABLE `infix_roles` DISABLE KEYS */;
INSERT INTO `infix_roles` VALUES (1,'Super admin','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(2,'Student','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(3,'Parents','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(4,'Teacher','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(5,'Admin','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(6,'Accountant','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(7,'Receptionist','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(8,'Librarian','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(9,'Driver','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(10,'Internal verified','User Defined',1,'1','1','2020-09-15 04:10:16','2020-09-15 04:10:16',1),(11,'Program leader','User Defined',1,'1','1','2020-09-15 04:10:30','2020-09-15 04:10:30',1),(12,'Head of Centre','User Defined',1,'1','1','2020-09-15 04:10:57','2020-09-15 04:10:57',1);
/*!40000 ALTER TABLE `infix_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `native` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rtl` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `languages_school_id_foreign` (`school_id`),
  CONSTRAINT `languages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'af','Afrikaans','Afrikaans',0,NULL,NULL,1),(2,'am','Amharic','áŠ áˆ›áˆ­áŠ›',0,NULL,NULL,1),(3,'ar','Arabic','Ø§Ù„Ø¹Ø±Ø¨ÙŠØ©',1,NULL,NULL,1),(4,'ay','Aymara','Aymar',0,NULL,NULL,1),(5,'az','Azerbaijani','AzÉ™rbaycanca / Ø¢Ø°Ø±Ø¨Ø§ÙŠØ¬Ø§Ù†',0,NULL,NULL,1),(6,'be','Belarusian','Ð‘ÐµÐ»Ð°Ñ€ÑƒÑÐºÐ°Ñ',0,NULL,NULL,1),(7,'bg','Bulgarian','Ð‘ÑŠÐ»Ð³Ð°Ñ€ÑÐºÐ¸',0,NULL,NULL,1),(8,'bi','Bislama','Bislama',0,NULL,NULL,1),(9,'bn','Bengali','à¦¬à¦¾à¦‚à¦²à¦¾',0,NULL,NULL,1),(10,'bs','Bosnian','Bosanski',0,NULL,NULL,1),(11,'ca','Catalan','CatalÃ ',0,NULL,NULL,1),(12,'ch','Chamorro','Chamoru',0,NULL,NULL,1),(13,'cs','Czech','ÄŒesky',0,NULL,NULL,1),(14,'da','Danish','Dansk',0,NULL,NULL,1),(15,'de','German','Deutsch',0,NULL,NULL,1),(16,'dv','Divehi','Þ‹Þ¨ÞˆÞ¬Þ€Þ¨Þ„Þ¦ÞÞ°',1,NULL,NULL,1),(17,'dz','Dzongkha','à½‡à½¼à½„à¼‹à½',0,NULL,NULL,1),(18,'el','Greek','Î•Î»Î»Î·Î½Î¹ÎºÎ¬',0,NULL,NULL,1),(19,'en','English','English',0,NULL,NULL,1),(20,'es','Spanish','EspaÃ±ol',0,NULL,NULL,1),(21,'et','Estonian','Eesti',0,NULL,NULL,1),(22,'eu','Basque','Euskara',0,NULL,NULL,1),(23,'fa','Persian','ÙØ§Ø±Ø³ÛŒ',1,NULL,NULL,1),(24,'ff','Peul','Fulfulde',0,NULL,NULL,1),(25,'fi','Finnish','Suomi',0,NULL,NULL,1),(26,'fj','Fijian','Na Vosa Vakaviti',0,NULL,NULL,1),(27,'fo','Faroese','FÃ¸royskt',0,NULL,NULL,1),(28,'fr','French','FranÃ§ais',0,NULL,NULL,1),(29,'ga','Irish','Gaeilge',0,NULL,NULL,1),(30,'gl','Galician','Galego',0,NULL,NULL,1),(31,'gn','Guarani','AvaÃ±e\'áº½',0,NULL,NULL,1),(32,'gv','Manx','Gaelg',0,NULL,NULL,1),(33,'he','Hebrew','×¢×‘×¨×™×ª',1,NULL,NULL,1),(34,'hi','Hindi','à¤¹à¤¿à¤¨à¥à¤¦à¥€',0,NULL,NULL,1),(35,'hr','Croatian','Hrvatski',0,NULL,NULL,1),(36,'ht','Haitian','KrÃ¨yol ayisyen',0,NULL,NULL,1),(37,'hu','Hungarian','Magyar',0,NULL,NULL,1),(38,'hy','Armenian','Õ€Õ¡ÕµÕ¥Ö€Õ¥Õ¶',0,NULL,NULL,1),(39,'indo','Indonesian','Bahasa Indonesia',0,NULL,NULL,1),(40,'is','Icelandic','Ãslenska',0,NULL,NULL,1),(41,'it','Italian','Italiano',0,NULL,NULL,1),(42,'ja','Japanese','æ—¥æœ¬èªž',0,NULL,NULL,1),(43,'ka','Georgian','áƒ¥áƒáƒ áƒ—áƒ£áƒšáƒ˜',0,NULL,NULL,1),(44,'kg','Kongo','KiKongo',0,NULL,NULL,1),(45,'kk','Kazakh','ÒšÐ°Ð·Ð°Ò›ÑˆÐ°',0,NULL,NULL,1),(46,'kl','Greenlandic','Kalaallisut',0,NULL,NULL,1),(47,'km','Cambodian','áž—áž¶ážŸáž¶ážáŸ’áž˜áŸ‚ážš',0,NULL,NULL,1),(48,'ko','Korean','í•œêµ­ì–´',0,NULL,NULL,1),(49,'ku','Kurdish','KurdÃ® / ÙƒÙˆØ±Ø¯ÛŒ',1,NULL,NULL,1),(50,'ky','Kirghiz','KÄ±rgÄ±zca / ÐšÑ‹Ñ€Ð³Ñ‹Ð·Ñ‡Ð°',0,NULL,NULL,1),(51,'la','Latin','Latina',0,NULL,NULL,1),(52,'lb','Luxembourgish','LÃ«tzebuergesch',0,NULL,NULL,1),(53,'ln','Lingala','LingÃ¡la',0,NULL,NULL,1),(54,'lo','Laotian','àº¥àº²àº§ / Pha xa lao',0,NULL,NULL,1),(55,'lt','Lithuanian','LietuviÅ³',0,NULL,NULL,1),(56,'lu','','',0,NULL,NULL,1),(57,'lv','Latvian','LatvieÅ¡u',0,NULL,NULL,1),(58,'mg','Malagasy','Malagasy',0,NULL,NULL,1),(59,'mh','Marshallese','Kajin Majel / Ebon',0,NULL,NULL,1),(60,'mi','Maori','MÄori',0,NULL,NULL,1),(61,'mk','Macedonian','ÐœÐ°ÐºÐµÐ´Ð¾Ð½ÑÐºÐ¸',0,NULL,NULL,1),(62,'mn','Mongolian','ÐœÐ¾Ð½Ð³Ð¾Ð»',0,NULL,NULL,1),(63,'ms','Malay','Bahasa Melayu',0,NULL,NULL,1),(64,'mt','Maltese','bil-Malti',0,NULL,NULL,1),(65,'my','Burmese','á€™á€¼á€”á€ºá€™á€¬á€…á€¬',0,NULL,NULL,1),(66,'na','Nauruan','Dorerin Naoero',0,NULL,NULL,1),(67,'nb','','',0,NULL,NULL,1),(68,'nd','North Ndebele','Sindebele',0,NULL,NULL,1),(69,'ne','Nepali','à¤¨à¥‡à¤ªà¤¾à¤²à¥€',0,NULL,NULL,1),(70,'nl','Dutch','Nederlands',0,NULL,NULL,1),(71,'nn','Norwegian Nynorsk','Norsk (nynorsk)',0,NULL,NULL,1),(72,'no','Norwegian','Norsk (bokmÃ¥l / riksmÃ¥l)',0,NULL,NULL,1),(73,'nr','South Ndebele','isiNdebele',0,NULL,NULL,1),(74,'ny','Chichewa','Chi-Chewa',0,NULL,NULL,1),(75,'oc','Occitan','Occitan',0,NULL,NULL,1),(76,'pa','Panjabi / Punjabi','à¨ªà©°à¨œà¨¾à¨¬à©€ / à¤ªà¤‚à¤œà¤¾à¤¬à¥€ / Ù¾Ù†Ø¬Ø§Ø¨ÙŠ',0,NULL,NULL,1),(77,'pl','Polish','Polski',0,NULL,NULL,1),(78,'ps','Pashto','Ù¾ÚšØªÙˆ',1,NULL,NULL,1),(79,'pt','Portuguese','PortuguÃªs',0,NULL,NULL,1),(80,'qu','Quechua','Runa Simi',0,NULL,NULL,1),(81,'rn','Kirundi','Kirundi',0,NULL,NULL,1),(82,'ro','Romanian','RomÃ¢nÄƒ',0,NULL,NULL,1),(83,'ru','Russian','Ð ÑƒÑÑÐºÐ¸Ð¹',0,NULL,NULL,1),(84,'rw','Rwandi','Kinyarwandi',0,NULL,NULL,1),(85,'sg','Sango','SÃ¤ngÃ¶',0,NULL,NULL,1),(86,'si','Sinhalese','à·ƒà·’à¶‚à·„à¶½',0,NULL,NULL,1),(87,'sk','Slovak','SlovenÄina',0,NULL,NULL,1),(88,'sl','Slovenian','SlovenÅ¡Äina',0,NULL,NULL,1),(89,'sm','Samoan','Gagana Samoa',0,NULL,NULL,1),(90,'sn','Shona','chiShona',0,NULL,NULL,1),(91,'so','Somalia','Soomaaliga',0,NULL,NULL,1),(92,'sq','Albanian','Shqip',0,NULL,NULL,1),(93,'sr','Serbian','Ð¡Ñ€Ð¿ÑÐºÐ¸',0,NULL,NULL,1),(94,'ss','Swati','SiSwati',0,NULL,NULL,1),(95,'st','Southern Sotho','Sesotho',0,NULL,NULL,1),(96,'sv','Swedish','Svenska',0,NULL,NULL,1),(97,'sw','Swahili','Kiswahili',0,NULL,NULL,1),(98,'ta','Tamil','à®¤à®®à®¿à®´à¯',0,NULL,NULL,1),(99,'tg','Tajik','Ð¢Ð¾Ò·Ð¸ÐºÓ£',0,NULL,NULL,1),(100,'th','Thai','à¹„à¸—à¸¢ / Phasa Thai',0,NULL,NULL,1),(101,'ti','Tigrinya','á‰µáŒáˆ­áŠ›',0,NULL,NULL,1),(102,'tk','Turkmen','Ð¢ÑƒÑ€ÐºÐ¼ÐµÐ½ / ØªØ±ÙƒÙ…Ù†',0,NULL,NULL,1),(103,'tn','Tswana','Setswana',0,NULL,NULL,1),(104,'to','Tonga','Lea Faka-Tonga',0,NULL,NULL,1),(105,'tr','Turkish','TÃ¼rkÃ§e',0,NULL,NULL,1),(106,'ts','Tsonga','Xitsonga',0,NULL,NULL,1),(107,'uk','Ukrainian','Ð£ÐºÑ€Ð°Ñ—Ð½ÑÑŒÐºÐ°',0,NULL,NULL,1),(108,'ur','Urdu','Ø§Ø±Ø¯Ùˆ',1,NULL,NULL,1),(109,'uz','Uzbek','ÐŽÐ·Ð±ÐµÐº',0,NULL,NULL,1),(110,'ve','Venda','Tshivená¸“a',0,NULL,NULL,1),(111,'vi','Vietnamese','Tiáº¿ng Viá»‡t',0,NULL,NULL,1),(112,'xh','Xhosa','isiXhosa',0,NULL,NULL,1),(113,'zh','Chinese','ä¸­æ–‡',0,NULL,NULL,1),(114,'zu','Zulu','isiZulu',0,NULL,NULL,1);
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_subjects`
--

DROP TABLE IF EXISTS `library_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sb_category_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'T',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `library_subjects_school_id_foreign` (`school_id`),
  KEY `library_subjects_academic_id_foreign` (`academic_id`),
  CONSTRAINT `library_subjects_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `library_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_subjects`
--

LOCK TABLES `library_subjects` WRITE;
/*!40000 ALTER TABLE `library_subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_11_01_000001_create_sm_schools_table',1),(2,'2014_11_01_000021_create_sm_academic_years_table',1),(3,'2014_11_12_100000_create_password_resets_table',1),(4,'2014_12_01_000001_create_infix_roles_table',1),(5,'2014_12_01_000002_create_roles_table',1),(6,'2014_12_01_000003_create_users_table',1),(7,'2014_12_01_000004_create_sm_base_groups_table',1),(8,'2014_12_01_000005_create_sm_base_setups_table',1),(9,'2014_12_01_000006_create_sm_classes_table',1),(10,'2014_12_01_000007_create_sm_sections_table',1),(11,'2014_12_01_000008_create_sm_class_sections_table',1),(12,'2014_12_01_000009_create_sm_subjects_table',1),(13,'2014_12_01_000010_create_sm_visitors_table',1),(14,'2014_12_01_000011_create_sm_fees_groups_table',1),(15,'2014_12_01_000012_create_sm_fees_types_table',1),(16,'2014_12_01_000013_create_sm_fees_discounts_table',1),(17,'2014_12_01_000014_create_sm_income_heads_table',1),(18,'2014_12_01_000015_create_sm_chart_of_accounts_table',1),(19,'2014_12_01_000016_create_sm_bank_accounts_table',1),(20,'2014_12_01_000017_create_sm_payment_gateway_settings_table',1),(21,'2014_12_01_000018_create_sm_payment_methhods_table',1),(22,'2014_12_01_000019_create_sm_add_incomes_table',1),(23,'2014_12_01_000020_create_sm_student_groups_table',1),(24,'2014_12_01_000022_create_sm_sessions_table',1),(25,'2014_12_01_000023_create_sm_dormitory_lists_table',1),(26,'2014_12_01_000024_create_sm_room_types_table',1),(27,'2014_12_01_000025_create_sm_room_lists_table',1),(28,'2014_12_01_000026_create_sm_designations_table',1),(29,'2014_12_01_000027_create_sm_human_departments_table',1),(30,'2014_12_01_000028_create_sm_staffs_table',1),(31,'2014_12_01_000029_create_sm_vehicles_table',1),(32,'2014_12_01_000030_create_sm_routes_table',1),(33,'2014_12_01_000031_create_sm_instructions_table',1),(34,'2014_12_01_000032_create_sm_question_levels_table',1),(35,'2014_12_01_000033_create_sm_question_groups_table',1),(36,'2014_12_01_000034_create_sm_question_banks_table',1),(37,'2014_12_01_000035_create_sm_online_exams_table',1),(38,'2014_12_01_000036_create_sm_exam_types_table',1),(39,'2014_12_01_000037_create_sm_marks_grades_table',1),(40,'2014_12_01_000038_create_sm_exams_table',1),(41,'2014_12_01_000039_create_sm_hourly_rates_table',1),(42,'2014_12_01_000040_create_sm_leave_types_table',1),(43,'2014_12_01_000041_create_sm_leave_defines_table',1),(44,'2014_12_01_000042_create_sm_leave_requests_table',1),(45,'2014_12_01_000043_create_sm_expense_heads_table',1),(46,'2014_12_01_000044_create_sm_add_expenses_table',1),(47,'2014_12_01_000045_create_sm_fees_masters_table',1),(48,'2014_12_01_000046_create_sm_setup_admins_table',1),(49,'2014_12_01_000047_create_sm_complaints_table',1),(50,'2014_12_01_000048_create_sm_postal_receives_table',1),(51,'2014_12_01_000049_create_sm_postal_dispatches_table',1),(52,'2014_12_01_000050_create_sm_phone_call_logs_table',1),(53,'2014_12_01_000051_create_sm_student_categories_table',1),(54,'2014_12_01_000052_create_sm_parents_table',1),(55,'2014_12_01_000054_create_sm_students_table',1),(56,'2014_12_01_000055_create_sm_student_attendances_table',1),(57,'2014_12_01_000056_create_sm_student_promotions_table',1),(58,'2014_12_01_000057_create_sm_staff_attendences_table',1),(59,'2014_12_01_000058_create_sm_student_homeworks_table',1),(60,'2014_12_01_000059_create_sm_teacher_upload_contents_table',1),(61,'2014_12_01_000060_create_sm_hr_salary_templates_table',1),(62,'2014_12_01_000061_create_sm_hr_payroll_generates_table',1),(63,'2014_12_01_000062_create_sm_exam_marks_registers_table',1),(64,'2014_12_01_000063_create_sm_marks_send_sms_table',1),(65,'2014_12_01_000064_create_sm_class_routines_table',1),(66,'2014_12_01_000064_create_sm_class_times_table',1),(67,'2014_12_01_000065_create_languages_table',1),(68,'2014_12_01_000065_create_sm_assign_subjects_table',1),(69,'2014_12_01_000066_create_sm_modules_table',1),(70,'2014_12_01_000067_create_sm_languages_table',1),(71,'2014_12_01_000068_create_sm_date_formats_table',1),(72,'2014_12_01_000069_create_sm_news_categories_table',1),(73,'2016_06_01_000001_create_oauth_auth_codes_table',1),(74,'2016_06_01_000002_create_oauth_access_tokens_table',1),(75,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(76,'2016_06_01_000004_create_oauth_clients_table',1),(77,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(78,'2018_12_04_050352_create_sm_notice_boards_table',1),(79,'2018_12_04_051648_create_sm_send_messages_table',1),(80,'2018_12_04_060828_create_sm_events_table',1),(81,'2018_12_04_062330_create_sm_holidays_table',1),(82,'2018_12_04_062714_create_sm_book_categories_table',1),(83,'2018_12_04_063012_create_sm_books_table',1),(84,'2018_12_04_075138_create_sm_library_members_table',1),(85,'2018_12_04_075911_create_sm_book_issues_table',1),(86,'2018_12_13_093741_create_sm_fees_carry_forwards_table',1),(87,'2018_12_17_104146_create_sm_fees_assigns_table',1),(88,'2018_12_17_111529_create_sm_hr_payroll_earn_deducs_table',1),(89,'2018_12_20_064256_create_sm_fees_assign_discounts_table',1),(90,'2018_12_20_090159_create_sm_fees_payments_table',1),(91,'2018_12_24_052328_create_sm_homeworks_table',1),(92,'2018_12_26_084518_create_sm_homework_students_table',1),(93,'2018_12_28_054159_create_sm_upload_contents_table',1),(94,'2018_12_28_075918_create_sm_content_types_table',1),(95,'2018_12_28_122146_create_sm_assign_class_teachers_table',1),(96,'2018_12_28_122205_create_sm_class_teachers_table',1),(97,'2018_12_31_112538_create_sm_exam_schedules_table',1),(98,'2018_12_31_112600_create_sm_exam_schedule_subjects_table',1),(99,'2019_01_02_061148_create_sm_marks_registers_table',1),(100,'2019_01_02_061238_create_sm_marks_register_children_table',1),(101,'2019_01_03_105718_create_sm_class_rooms_table',1),(102,'2019_01_06_060144_create_sm_seat_plans_table',1),(103,'2019_01_06_060213_create_sm_seat_plan_children_table',1),(104,'2019_01_07_132108_create_sm_exam_attendances_table',1),(105,'2019_01_07_132220_create_sm_exam_attendance_children_table',1),(106,'2019_01_09_101421_create_sm_online_exam_questions_table',1),(107,'2019_01_09_101533_create_sm_online_exam_question_mu_options_table',1),(108,'2019_01_10_050231_create_sm_item_categories_table',1),(109,'2019_01_10_050645_create_sm_items_table',1),(110,'2019_01_10_054622_create_sm_item_stores_table',1),(111,'2019_01_10_070859_create_sm_suppliers_table',1),(112,'2019_01_10_112518_create_sm_item_receives_table',1),(113,'2019_01_12_104449_create_sm_item_receive_children_table',1),(114,'2019_01_13_113100_create_sm_online_exam_marks_table',1),(115,'2019_01_14_061003_create_sm_assign_vehicles_table',1),(116,'2019_01_16_065238_create_sm_module_links_table',1),(117,'2019_01_19_094137_create_sm_inventory_payments_table',1),(118,'2019_01_21_063031_create_sm_student_excel_formats_table',1),(119,'2019_01_21_131008_create_sm_item_sells_table',1),(120,'2019_01_22_104243_create_sm_item_sell_children_table',1),(121,'2019_01_23_121931_create_sm_item_issues_table',1),(122,'2019_01_26_054046_create_sm_sms_gateways_table',1),(123,'2019_01_30_122524_create_sm_student_documents_table',1),(124,'2019_01_31_052142_create_sm_student_timelines_table',1),(125,'2019_01_31_101401_create_sm_question_bank_mu_options_table',1),(126,'2019_02_02_043028_create_sm_online_exam_question_assigns_table',1),(127,'2019_02_02_112647_create_sm_student_take_online_exams_table',1),(128,'2019_02_02_112719_create_sm_student_take_online_exam_questions_table',1),(129,'2019_02_02_115540_create_sm_student_take_onln_ex_ques_options_table',1),(130,'2019_02_09_050800_create_sm_email_sms_logs_table',1),(131,'2019_02_10_125119_create_sm_general_settings_table',1),(132,'2019_02_11_093834_create_sm_user_logs_table',1),(133,'2019_02_12_064024_create_sm_email_settings_table',1),(134,'2019_02_16_082050_create_sm_student_certificates_table',1),(135,'2019_02_17_124203_create_sm_student_id_cards_table',1),(136,'2019_02_24_124115_create_sm_to_dos_table',1),(137,'2019_03_13_075602_create_sm_admission_queries_table',1),(138,'2019_03_14_075324_create_sm_admission_query_followups_table',1),(139,'2019_04_04_124508_create_sm_backups_table',1),(140,'2019_04_10_054237_create_sm_temporary_meritlists',1),(141,'2019_04_13_062212_create_sm_exam_setups_table',1),(142,'2019_04_15_055616_create_sm_mark_stores_table',1),(143,'2019_04_17_101844_create_sm_result_stores_table',1),(144,'2019_04_21_071626_create_sm_class_routine_updates_table',1),(145,'2019_04_23_051315_create_sm_weekends_table',1),(146,'2019_04_25_164649_create_sm_countries_table',1),(147,'2019_04_27_121353_create_sm_language_phrases_table',1),(148,'2019_04_28_074534_create_sm_notifications_table',1),(149,'2019_04_30_181622_create_continents_table',1),(150,'2019_04_30_181730_create_countries_table',1),(151,'2019_05_07_103627_create_sm_currencies_table',1),(152,'2019_05_26_095459_create_sm_news_table',1),(153,'2019_05_27_103844_create_sm_testimonials_table',1),(154,'2019_06_01_113053_create_sm_contact_pages_table',1),(155,'2019_06_01_165107_create_sm_contact_messages_table',1),(156,'2019_06_10_155041_create_sm_product_purchases_table',1),(157,'2019_06_11_112109_create_sm_about_pages_table',1),(158,'2019_06_12_143430_create_sm_courses_table',1),(159,'2019_07_17_182142_create_sm_dashboard_settings_table',1),(160,'2019_07_18_141858_create_sm_background_settings_table',1),(161,'2019_07_20_151115_create_sm_custom_links_table',1),(162,'2019_07_20_183407_create_sm_frontend_persmissions_table',1),(163,'2019_07_21_110814_create_sm_home_page_settings_table',1),(164,'2019_09_01_171428_create_sm_system_versions_table',1),(165,'2019_09_06_113029_create_continets_table',1),(166,'2019_09_09_142112_create_sm_styles_table',1),(167,'2019_09_25_183656_create_sm_module_permissions_table',1),(168,'2019_09_26_115256_create_sm_module_permission_assigns_table',1),(169,'2019_10_16_160104_create_sm_time_zones_table',1),(170,'2019_11_27_120508_create_sm_student_attendance_imports_table',1),(171,'2019_11_27_181351_create_sm_staff_attendance_imports_table',1),(172,'2020_01_23_125935_create_sm_optional_subject_assigns_table',1),(173,'2020_01_26_112215_create_sm_class_optional_subject',1),(174,'2020_01_28_103859_create_sm_news_pages_table',1),(175,'2020_01_28_121210_create_sm_course_pages_table',1),(176,'2020_01_29_110503_create_sm_subject_attendances_table',1),(177,'2020_02_05_105739_create_custom_result_settings_table',1),(178,'2020_02_05_131307_create_sm_custom_temporary_results_table',1),(179,'2020_03_09_153421_create_sm_add_ons_table',1),(180,'2020_03_14_123955_create_sms_templates_table',1),(181,'2020_03_21_200226_create_sm_social_media_icons_table',1),(182,'2020_03_29_102518_create_sm_upload_homework_contents_table',1),(183,'2020_04_01_060324_create_jobs_table',1),(184,'2020_04_11_141636_create_infix_module_infos_table',1),(185,'2020_04_12_125728_create_infix_permission_assigns_table',1),(186,'2020_04_16_064434_create_infix_module_student_parent_infos_table',1),(187,'2020_06_10_193309_create_infix_module_managers_table',1),(188,'2020_06_17_091643_create_student_bulk_temporaries_table',1),(189,'2020_06_22_120034_create_student_attendance_bulks_table',1),(190,'2020_06_26_144311_create_library_subjects_table',1),(191,'2020_07_14_052504_create_sm_bank_payment_slips_table',1),(192,'2020_11_16_065239_create_sm_role_permissions_table',1),(201,'2016_07_29_171118_create_chatter_categories_table',2),(202,'2016_07_29_171118_create_chatter_discussion_table',2),(203,'2016_07_29_171118_create_chatter_post_table',2),(204,'2017_01_16_121747_create_chatter_user_discussion_pivot_table',2),(205,'2019_12_01_233706_create_username_field',2),(206,'2019_12_13_230000_create_reactions_table',3),(207,'2020_09_09_202219_add_students_group_id',4);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_auth_codes`
--

LOCK TABLES `oauth_auth_codes` WRITE;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_token_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_clients`
--

LOCK TABLES `oauth_clients` WRITE;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_personal_access_clients`
--

LOCK TABLES `oauth_personal_access_clients` WRITE;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `access_token_id` bigint(20) DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_refresh_tokens`
--

LOCK TABLES `oauth_refresh_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'System',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `updated_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `roles_school_id_foreign` (`school_id`),
  CONSTRAINT `roles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Super admin','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(2,'Student','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(3,'Parents','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(4,'Teacher','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(5,'Admin','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(6,'Accountant','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(7,'Receptionist','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(8,'Librarian','System',1,'1','1','2020-08-10 05:58:14',NULL,1),(9,'Driver','System',1,'1','1','2020-08-10 05:58:14',NULL,1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_about_pages`
--

DROP TABLE IF EXISTS `sm_about_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_about_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `main_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_about_pages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_about_pages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_about_pages`
--

LOCK TABLES `sm_about_pages` WRITE;
/*!40000 ALTER TABLE `sm_about_pages` DISABLE KEYS */;
INSERT INTO `sm_about_pages` VALUES (1,NULL,NULL,'About Infix','Lisus consequat sapien metus dis urna, facilisi. Nonummy rutrum eu lacinia platea a, ipsum parturient, orci tristique. Nisi diam natoque.','Under Graduate Education','INFIX has all in one place. Youâ€™ll find everything what you are looking into education management system software. We care! User will never bothered in our real eye catchy user friendly UI & UX  Interface design. You know! Smart Idea always comes to well planners. And Our INFIX is Smart for its Well Documentation. Explore in new support world! Itâ€™s now faster & quicker. Youâ€™ll find us on Support Ticket, Email, Skype, WhatsApp.','public/uploads/about_page/about.jpg','public/uploads/about_page/about-img.jpg','Learn More About Us','about',1,1,1,1);
/*!40000 ALTER TABLE `sm_about_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_academic_years`
--

DROP TABLE IF EXISTS `sm_academic_years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_academic_years` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `year` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `starting_date` date NOT NULL,
  `ending_date` date NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_academic_years_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_academic_years_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_academic_years`
--

LOCK TABLES `sm_academic_years` WRITE;
/*!40000 ALTER TABLE `sm_academic_years` DISABLE KEYS */;
INSERT INTO `sm_academic_years` VALUES (1,'2021','Spring','2021-01-01','2021-06-30',1,'2021-01-01 00:00:00','2020-09-06 17:32:17',1,1,1),(2,'2020','Fall','2020-07-01','2020-12-31',1,'2020-07-01 00:00:00','2020-09-06 17:31:44',1,1,1);
/*!40000 ALTER TABLE `sm_academic_years` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_add_expenses`
--

DROP TABLE IF EXISTS `sm_add_expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_add_expenses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expense_head_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `payment_method_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_add_expenses_expense_head_id_foreign` (`expense_head_id`),
  KEY `sm_add_expenses_account_id_foreign` (`account_id`),
  KEY `sm_add_expenses_payment_method_id_foreign` (`payment_method_id`),
  KEY `sm_add_expenses_school_id_foreign` (`school_id`),
  KEY `sm_add_expenses_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_add_expenses_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_expenses_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `sm_bank_accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_expenses_expense_head_id_foreign` FOREIGN KEY (`expense_head_id`) REFERENCES `sm_expense_heads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_expenses_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `sm_payment_methhods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_expenses_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_add_expenses`
--

LOCK TABLES `sm_add_expenses` WRITE;
/*!40000 ALTER TABLE `sm_add_expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_add_expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_add_incomes`
--

DROP TABLE IF EXISTS `sm_add_incomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_add_incomes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `income_head_id` int(10) unsigned DEFAULT NULL,
  `account_id` int(10) unsigned DEFAULT NULL,
  `payment_method_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_add_incomes_income_head_id_foreign` (`income_head_id`),
  KEY `sm_add_incomes_account_id_foreign` (`account_id`),
  KEY `sm_add_incomes_payment_method_id_foreign` (`payment_method_id`),
  KEY `sm_add_incomes_school_id_foreign` (`school_id`),
  KEY `sm_add_incomes_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_add_incomes_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_incomes_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `sm_bank_accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_incomes_income_head_id_foreign` FOREIGN KEY (`income_head_id`) REFERENCES `sm_income_heads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_incomes_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `sm_payment_methhods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_add_incomes_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_add_incomes`
--

LOCK TABLES `sm_add_incomes` WRITE;
/*!40000 ALTER TABLE `sm_add_incomes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_add_incomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_add_ons`
--

DROP TABLE IF EXISTS `sm_add_ons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_add_ons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_add_ons`
--

LOCK TABLES `sm_add_ons` WRITE;
/*!40000 ALTER TABLE `sm_add_ons` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_add_ons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_admission_queries`
--

DROP TABLE IF EXISTS `sm_admission_queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_admission_queries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `follow_up_date` date DEFAULT NULL,
  `next_follow_up_date` date DEFAULT NULL,
  `assigned` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference` int(11) DEFAULT NULL,
  `source` int(11) DEFAULT NULL,
  `no_of_child` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_admission_queries_class_foreign` (`class`),
  KEY `sm_admission_queries_school_id_foreign` (`school_id`),
  KEY `sm_admission_queries_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_admission_queries_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_admission_queries_class_foreign` FOREIGN KEY (`class`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_admission_queries_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_admission_queries`
--

LOCK TABLES `sm_admission_queries` WRITE;
/*!40000 ALTER TABLE `sm_admission_queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_admission_queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_admission_query_followups`
--

DROP TABLE IF EXISTS `sm_admission_query_followups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_admission_query_followups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `response` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `date` date DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `admission_query_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_admission_query_followups_admission_query_id_foreign` (`admission_query_id`),
  KEY `sm_admission_query_followups_school_id_foreign` (`school_id`),
  KEY `sm_admission_query_followups_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_admission_query_followups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_admission_query_followups_admission_query_id_foreign` FOREIGN KEY (`admission_query_id`) REFERENCES `sm_admission_queries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_admission_query_followups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_admission_query_followups`
--

LOCK TABLES `sm_admission_query_followups` WRITE;
/*!40000 ALTER TABLE `sm_admission_query_followups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_admission_query_followups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_assign_class_teachers`
--

DROP TABLE IF EXISTS `sm_assign_class_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_assign_class_teachers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_assign_class_teachers_class_id_foreign` (`class_id`),
  KEY `sm_assign_class_teachers_section_id_foreign` (`section_id`),
  KEY `sm_assign_class_teachers_school_id_foreign` (`school_id`),
  KEY `sm_assign_class_teachers_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_assign_class_teachers_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_class_teachers_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_class_teachers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_class_teachers_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_assign_class_teachers`
--

LOCK TABLES `sm_assign_class_teachers` WRITE;
/*!40000 ALTER TABLE `sm_assign_class_teachers` DISABLE KEYS */;
INSERT INTO `sm_assign_class_teachers` VALUES (1,1,'2020-09-06 17:12:39','2020-09-06 17:12:39',2,2,1,1,1,1);
/*!40000 ALTER TABLE `sm_assign_class_teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_assign_subjects`
--

DROP TABLE IF EXISTS `sm_assign_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_assign_subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_assign_subjects_teacher_id_foreign` (`teacher_id`),
  KEY `sm_assign_subjects_class_id_foreign` (`class_id`),
  KEY `sm_assign_subjects_section_id_foreign` (`section_id`),
  KEY `sm_assign_subjects_subject_id_foreign` (`subject_id`),
  KEY `sm_assign_subjects_school_id_foreign` (`school_id`),
  KEY `sm_assign_subjects_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_assign_subjects_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_subjects_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_subjects_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_subjects_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_subjects_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_assign_subjects`
--

LOCK TABLES `sm_assign_subjects` WRITE;
/*!40000 ALTER TABLE `sm_assign_subjects` DISABLE KEYS */;
INSERT INTO `sm_assign_subjects` VALUES (1,1,'2020-08-19 22:44:43','2020-08-20 10:44:43',2,1,2,1,1,1,1,1);
/*!40000 ALTER TABLE `sm_assign_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_assign_vehicles`
--

DROP TABLE IF EXISTS `sm_assign_vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_assign_vehicles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `vehicle_id` int(10) unsigned DEFAULT NULL,
  `route_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_assign_vehicles_vehicle_id_foreign` (`vehicle_id`),
  KEY `sm_assign_vehicles_route_id_foreign` (`route_id`),
  KEY `sm_assign_vehicles_school_id_foreign` (`school_id`),
  KEY `sm_assign_vehicles_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_assign_vehicles_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_vehicles_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `sm_routes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_vehicles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_assign_vehicles_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `sm_vehicles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_assign_vehicles`
--

LOCK TABLES `sm_assign_vehicles` WRITE;
/*!40000 ALTER TABLE `sm_assign_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_assign_vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_background_settings`
--

DROP TABLE IF EXISTS `sm_background_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_background_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` int(11) NOT NULL DEFAULT '0',
  `school_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_background_settings_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_background_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_background_settings`
--

LOCK TABLES `sm_background_settings` WRITE;
/*!40000 ALTER TABLE `sm_background_settings` DISABLE KEYS */;
INSERT INTO `sm_background_settings` VALUES (1,'Dashboard Background','image','public/backEnd/img/body-bg.jpg','',1,1,NULL,NULL),(2,'Login Background','image','public/backEnd/img/login-bg.jpg','',0,1,NULL,NULL);
/*!40000 ALTER TABLE `sm_background_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_backups`
--

DROP TABLE IF EXISTS `sm_backups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_backups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` tinyint(4) DEFAULT NULL COMMENT '0=Database, 1=File, 2=Image',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_backups_school_id_foreign` (`school_id`),
  KEY `sm_backups_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_backups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_backups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_backups`
--

LOCK TABLES `sm_backups` WRITE;
/*!40000 ALTER TABLE `sm_backups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_backups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_bank_accounts`
--

DROP TABLE IF EXISTS `sm_bank_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_bank_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opening_balance` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_bank_accounts_school_id_foreign` (`school_id`),
  KEY `sm_bank_accounts_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_bank_accounts_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_bank_accounts_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_bank_accounts`
--

LOCK TABLES `sm_bank_accounts` WRITE;
/*!40000 ALTER TABLE `sm_bank_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_bank_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_bank_payment_slips`
--

DROP TABLE IF EXISTS `sm_bank_payment_slips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_bank_payment_slips` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `slip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `approve_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 pending, 1 approve',
  `payment_mode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Bk= bank, Cq=Cheque',
  `fees_discount_id` int(10) unsigned DEFAULT NULL,
  `fees_type_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_bank_payment_slips_fees_discount_id_foreign` (`fees_discount_id`),
  KEY `sm_bank_payment_slips_fees_type_id_foreign` (`fees_type_id`),
  KEY `sm_bank_payment_slips_student_id_foreign` (`student_id`),
  KEY `sm_bank_payment_slips_school_id_foreign` (`school_id`),
  KEY `sm_bank_payment_slips_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_bank_payment_slips_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_bank_payment_slips_fees_discount_id_foreign` FOREIGN KEY (`fees_discount_id`) REFERENCES `sm_fees_discounts` (`id`),
  CONSTRAINT `sm_bank_payment_slips_fees_type_id_foreign` FOREIGN KEY (`fees_type_id`) REFERENCES `sm_fees_types` (`id`),
  CONSTRAINT `sm_bank_payment_slips_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`),
  CONSTRAINT `sm_bank_payment_slips_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_bank_payment_slips`
--

LOCK TABLES `sm_bank_payment_slips` WRITE;
/*!40000 ALTER TABLE `sm_bank_payment_slips` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_bank_payment_slips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_base_groups`
--

DROP TABLE IF EXISTS `sm_base_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_base_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_base_groups_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_base_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_base_groups`
--

LOCK TABLES `sm_base_groups` WRITE;
/*!40000 ALTER TABLE `sm_base_groups` DISABLE KEYS */;
INSERT INTO `sm_base_groups` VALUES (1,'Gender',1,'2020-08-10 05:58:14',NULL,1,1,1),(2,'Religion',1,'2020-08-10 05:58:14',NULL,1,1,1),(3,'Blood Group',1,'2020-08-10 05:58:14',NULL,1,1,1);
/*!40000 ALTER TABLE `sm_base_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_base_setups`
--

DROP TABLE IF EXISTS `sm_base_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_base_setups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `base_setup_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `base_group_id` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_base_setups_base_group_id_foreign` (`base_group_id`),
  KEY `sm_base_setups_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_base_setups_base_group_id_foreign` FOREIGN KEY (`base_group_id`) REFERENCES `sm_base_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_base_setups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_base_setups`
--

LOCK TABLES `sm_base_setups` WRITE;
/*!40000 ALTER TABLE `sm_base_setups` DISABLE KEYS */;
INSERT INTO `sm_base_setups` VALUES (1,'Male',1,'2020-08-10 05:58:14',NULL,1,1,1,1),(2,'Female',1,'2020-08-10 05:58:14',NULL,1,1,1,1),(3,'Others',1,'2020-08-10 05:58:14',NULL,1,1,1,1),(4,'Islam',1,'2020-08-10 05:58:14',NULL,1,1,2,1),(5,'Hinduism',1,'2020-08-10 05:58:14',NULL,1,1,2,1),(6,'Sikhism',1,'2020-08-10 05:58:14',NULL,1,1,2,1),(7,'Buddhism',1,'2020-08-10 05:58:14',NULL,1,1,2,1),(8,'Protestantism',1,'2020-08-10 05:58:14',NULL,1,1,2,1),(9,'A+',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(10,'O+',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(11,'B+',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(12,'AB+',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(13,'A-',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(14,'O-',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(15,'B-',1,'2020-08-10 05:58:14',NULL,1,1,3,1),(16,'AB-',1,'2020-08-10 05:58:14',NULL,1,1,3,1);
/*!40000 ALTER TABLE `sm_base_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_book_categories`
--

DROP TABLE IF EXISTS `sm_book_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_book_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_book_categories_school_id_foreign` (`school_id`),
  KEY `sm_book_categories_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_book_categories_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_book_categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_book_categories`
--

LOCK TABLES `sm_book_categories` WRITE;
/*!40000 ALTER TABLE `sm_book_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_book_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_book_issues`
--

DROP TABLE IF EXISTS `sm_book_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_book_issues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int(11) DEFAULT NULL,
  `given_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `issue_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `book_id` int(10) unsigned DEFAULT NULL,
  `member_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_book_issues_book_id_foreign` (`book_id`),
  KEY `sm_book_issues_member_id_foreign` (`member_id`),
  KEY `sm_book_issues_school_id_foreign` (`school_id`),
  KEY `sm_book_issues_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_book_issues_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_book_issues_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `sm_books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_book_issues_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_book_issues_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_book_issues`
--

LOCK TABLES `sm_book_issues` WRITE;
/*!40000 ALTER TABLE `sm_book_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_book_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_books`
--

DROP TABLE IF EXISTS `sm_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_books` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `book_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `book_number` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isbn_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `publisher_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rack_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT '0',
  `book_price` int(11) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `details` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `book_category_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_books_book_category_id_foreign` (`book_category_id`),
  KEY `sm_books_school_id_foreign` (`school_id`),
  KEY `sm_books_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_books_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_books_book_category_id_foreign` FOREIGN KEY (`book_category_id`) REFERENCES `sm_book_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_books_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_books`
--

LOCK TABLES `sm_books` WRITE;
/*!40000 ALTER TABLE `sm_books` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_chart_of_accounts`
--

DROP TABLE IF EXISTS `sm_chart_of_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_chart_of_accounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `head` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'E = expense, I = income',
  `active_status` int(11) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_chart_of_accounts_school_id_foreign` (`school_id`),
  KEY `sm_chart_of_accounts_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_chart_of_accounts_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_chart_of_accounts_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_chart_of_accounts`
--

LOCK TABLES `sm_chart_of_accounts` WRITE;
/*!40000 ALTER TABLE `sm_chart_of_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_chart_of_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_optional_subject`
--

DROP TABLE IF EXISTS `sm_class_optional_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_optional_subject` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` int(11) NOT NULL,
  `gpa_above` double(8,2) NOT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_class_optional_subject_school_id_foreign` (`school_id`),
  KEY `sm_class_optional_subject_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_optional_subject_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_optional_subject_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_optional_subject`
--

LOCK TABLES `sm_class_optional_subject` WRITE;
/*!40000 ALTER TABLE `sm_class_optional_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_class_optional_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_rooms`
--

DROP TABLE IF EXISTS `sm_class_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_rooms_school_id_foreign` (`school_id`),
  KEY `sm_class_rooms_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_rooms_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_rooms_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_rooms`
--

LOCK TABLES `sm_class_rooms` WRITE;
/*!40000 ALTER TABLE `sm_class_rooms` DISABLE KEYS */;
INSERT INTO `sm_class_rooms` VALUES (1,'203',25,1,'2020-08-19 09:15:33','2020-08-20 10:21:53',1,1,1,1),(2,'201',125,1,'2020-08-20 10:19:56','2020-08-20 10:20:40',1,1,1,1),(3,'202',50,1,'2020-08-20 10:20:14','2020-08-20 10:20:55',1,1,1,1),(4,'204',25,1,'2020-08-20 10:22:09','2020-08-20 10:22:09',1,1,1,1),(5,'205',25,1,'2020-08-20 10:22:15','2020-08-20 10:22:15',1,1,1,1),(6,'206',25,1,'2020-08-20 10:22:21','2020-08-20 10:22:21',1,1,1,1),(7,'207',25,1,'2020-08-20 10:22:26','2020-08-20 10:22:26',1,1,1,1),(8,'208',25,1,'2020-08-20 10:22:31','2020-08-20 10:22:31',1,1,1,1),(9,'301',125,1,'2020-08-20 10:23:09','2020-08-20 10:23:09',1,1,1,1),(10,'302',50,1,'2020-08-20 10:23:19','2020-08-20 10:23:19',1,1,1,1),(11,'303',25,1,'2020-08-20 10:23:31','2020-08-20 10:23:31',1,1,1,1),(12,'304',50,1,'2020-08-20 10:23:40','2020-08-20 10:23:40',1,1,1,1),(13,'305',25,1,'2020-08-20 10:23:46','2020-08-20 10:23:46',1,1,1,1),(14,'306',50,1,'2020-08-20 10:23:54','2020-08-20 10:23:54',1,1,1,1);
/*!40000 ALTER TABLE `sm_class_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_routine_updates`
--

DROP TABLE IF EXISTS `sm_class_routine_updates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_routine_updates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `day` int(11) DEFAULT NULL COMMENT '1=sat,2=sun,7=fri',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `class_period_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_routine_updates_room_id_foreign` (`room_id`),
  KEY `sm_class_routine_updates_teacher_id_foreign` (`teacher_id`),
  KEY `sm_class_routine_updates_class_period_id_foreign` (`class_period_id`),
  KEY `sm_class_routine_updates_subject_id_foreign` (`subject_id`),
  KEY `sm_class_routine_updates_class_id_foreign` (`class_id`),
  KEY `sm_class_routine_updates_section_id_foreign` (`section_id`),
  KEY `sm_class_routine_updates_school_id_foreign` (`school_id`),
  KEY `sm_class_routine_updates_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_routine_updates_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_class_period_id_foreign` FOREIGN KEY (`class_period_id`) REFERENCES `sm_class_times` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `sm_class_rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routine_updates_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_routine_updates`
--

LOCK TABLES `sm_class_routine_updates` WRITE;
/*!40000 ALTER TABLE `sm_class_routine_updates` DISABLE KEYS */;
INSERT INTO `sm_class_routine_updates` VALUES (1,3,1,'2020-08-20 10:45:44','2020-08-20 10:45:44',2,2,1,1,1,2,1,1,1,1),(2,4,1,'2020-09-06 17:15:11','2020-09-06 17:15:11',4,2,1,1,1,2,1,1,1,1);
/*!40000 ALTER TABLE `sm_class_routine_updates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_routines`
--

DROP TABLE IF EXISTS `sm_class_routines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_routines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `monday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `monday_room_id` int(10) unsigned DEFAULT NULL,
  `tuesday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuesday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuesday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuesday_room_id` int(10) unsigned DEFAULT NULL,
  `wednesday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wednesday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wednesday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wednesday_room_id` int(10) unsigned DEFAULT NULL,
  `thursday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thursday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thursday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thursday_room_id` int(10) unsigned DEFAULT NULL,
  `friday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friday_room_id` int(10) unsigned DEFAULT NULL,
  `saturday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saturday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saturday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saturday_room_id` int(10) unsigned DEFAULT NULL,
  `sunday` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunday_start_from` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunday_end_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunday_room_id` int(10) unsigned DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_routines_class_id_foreign` (`class_id`),
  KEY `sm_class_routines_section_id_foreign` (`section_id`),
  KEY `sm_class_routines_subject_id_foreign` (`subject_id`),
  KEY `sm_class_routines_school_id_foreign` (`school_id`),
  KEY `sm_class_routines_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_routines_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routines_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routines_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routines_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_routines_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_routines`
--

LOCK TABLES `sm_class_routines` WRITE;
/*!40000 ALTER TABLE `sm_class_routines` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_class_routines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_sections`
--

DROP TABLE IF EXISTS `sm_class_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_sections_class_id_foreign` (`class_id`),
  KEY `sm_class_sections_section_id_foreign` (`section_id`),
  KEY `sm_class_sections_school_id_foreign` (`school_id`),
  KEY `sm_class_sections_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_sections_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_sections_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_sections_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_sections_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_sections`
--

LOCK TABLES `sm_class_sections` WRITE;
/*!40000 ALTER TABLE `sm_class_sections` DISABLE KEYS */;
INSERT INTO `sm_class_sections` VALUES (5,1,'2020-08-19 22:16:00','2020-08-20 10:16:00',1,2,1,1),(6,1,'2020-08-19 22:17:15','2020-08-20 10:17:15',2,2,1,1),(7,1,'2021-09-09 06:05:41','2020-09-09 18:05:41',3,1,1,1),(8,1,'2021-09-09 06:06:33','2020-09-09 18:06:33',4,1,1,1),(9,1,'2021-09-09 06:06:33','2020-09-09 18:06:33',4,2,1,1);
/*!40000 ALTER TABLE `sm_class_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_teachers`
--

DROP TABLE IF EXISTS `sm_class_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_teachers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `teacher_id` int(10) unsigned DEFAULT NULL,
  `assign_class_teacher_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_teachers_teacher_id_foreign` (`teacher_id`),
  KEY `sm_class_teachers_assign_class_teacher_id_foreign` (`assign_class_teacher_id`),
  KEY `sm_class_teachers_school_id_foreign` (`school_id`),
  KEY `sm_class_teachers_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_teachers_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_teachers_assign_class_teacher_id_foreign` FOREIGN KEY (`assign_class_teacher_id`) REFERENCES `sm_assign_class_teachers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_teachers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_teachers_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_teachers`
--

LOCK TABLES `sm_class_teachers` WRITE;
/*!40000 ALTER TABLE `sm_class_teachers` DISABLE KEYS */;
INSERT INTO `sm_class_teachers` VALUES (1,1,'2020-09-06 17:12:39','2020-09-06 17:12:39',2,1,1,1,1,1);
/*!40000 ALTER TABLE `sm_class_teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_class_times`
--

DROP TABLE IF EXISTS `sm_class_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_class_times` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('exam','class') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `period` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_break` tinyint(4) DEFAULT NULL COMMENT '1 = tiffin time, 0 = class',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_class_times_school_id_foreign` (`school_id`),
  KEY `sm_class_times_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_class_times_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_class_times_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_class_times`
--

LOCK TABLES `sm_class_times` WRITE;
/*!40000 ALTER TABLE `sm_class_times` DISABLE KEYS */;
INSERT INTO `sm_class_times` VALUES (1,'class','90 minutes','08:30:00','09:30:00',NULL,'2020-08-20 10:26:13','2020-08-20 10:26:13',1,1),(2,'class','90 minutes','10:15:00','11:45:00',NULL,'2020-08-20 10:28:21','2020-08-20 10:28:21',1,1),(3,'class','90 minutes','12:00:00','13:30:00',NULL,'2020-08-20 10:28:55','2020-08-20 10:28:55',1,1),(4,'class','90 minutes','14:30:00','16:00:00',NULL,'2020-08-20 10:29:30','2020-08-20 10:29:30',1,1),(5,'class','90 minutes','16:15:00','17:45:00',NULL,'2020-08-20 10:49:01','2020-08-20 10:49:01',1,1);
/*!40000 ALTER TABLE `sm_class_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_classes`
--

DROP TABLE IF EXISTS `sm_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_classes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_classes_school_id_foreign` (`school_id`),
  KEY `sm_classes_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_classes_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_classes_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_classes`
--

LOCK TABLES `sm_classes` WRITE;
/*!40000 ALTER TABLE `sm_classes` DISABLE KEYS */;
INSERT INTO `sm_classes` VALUES (1,'Business Program',1,'2021-01-01 00:00:00','2021-01-01 00:00:00',1,1,1,1),(2,'Information Technology',1,'2021-01-01 00:00:00','2021-01-01 00:00:00',1,1,1,1),(3,'SOme',1,'2021-09-09 06:05:41','2020-09-09 18:05:41',1,1,1,1),(4,'Some123',1,'2021-09-09 06:06:33','2020-09-09 18:06:33',1,1,1,1);
/*!40000 ALTER TABLE `sm_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_complaints`
--

DROP TABLE IF EXISTS `sm_complaints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_complaints` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `complaint_by` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complaint_type` tinyint(4) DEFAULT NULL,
  `complaint_source` tinyint(4) DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `action_taken` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `assigned` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_complaints_school_id_foreign` (`school_id`),
  KEY `sm_complaints_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_complaints_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_complaints_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_complaints`
--

LOCK TABLES `sm_complaints` WRITE;
/*!40000 ALTER TABLE `sm_complaints` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_complaints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_contact_messages`
--

DROP TABLE IF EXISTS `sm_contact_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_contact_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `view_status` tinyint(4) NOT NULL DEFAULT '0',
  `reply_status` tinyint(4) NOT NULL DEFAULT '0',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_contact_messages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_contact_messages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_contact_messages`
--

LOCK TABLES `sm_contact_messages` WRITE;
/*!40000 ALTER TABLE `sm_contact_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_contact_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_contact_pages`
--

DROP TABLE IF EXISTS `sm_contact_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_contact_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_map_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_contact_pages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_contact_pages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_contact_pages`
--

LOCK TABLES `sm_contact_pages` WRITE;
/*!40000 ALTER TABLE `sm_contact_pages` DISABLE KEYS */;
INSERT INTO `sm_contact_pages` VALUES (1,'Contact Us','Have any questions? Weâ€™d love to hear from you! Hereâ€™s how to get in touch with us.','public/uploads/contactPage/contact.jpg','Learn More About Us','about','56/8 Panthapath, Dhanmondi,Dhaka','Santa monica bullevard','0184113625','Mon to Fri 9am to 6 pm','admin@infixedu.com','Send us your query anytime!','23.707310','90.415480','Panthapath, Dhaka',1,NULL,NULL,1,1,NULL);
/*!40000 ALTER TABLE `sm_contact_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_content_types`
--

DROP TABLE IF EXISTS `sm_content_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_content_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_content_types_school_id_foreign` (`school_id`),
  KEY `sm_content_types_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_content_types_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_content_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_content_types`
--

LOCK TABLES `sm_content_types` WRITE;
/*!40000 ALTER TABLE `sm_content_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_content_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_countries`
--

DROP TABLE IF EXISTS `sm_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `native` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `continent` varchar(255) DEFAULT NULL,
  `capital` varchar(255) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `languages` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_countries_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_countries_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_countries`
--

LOCK TABLES `sm_countries` WRITE;
/*!40000 ALTER TABLE `sm_countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_course_pages`
--

DROP TABLE IF EXISTS `sm_course_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_course_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `main_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_course_pages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_course_pages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_course_pages`
--

LOCK TABLES `sm_course_pages` WRITE;
/*!40000 ALTER TABLE `sm_course_pages` DISABLE KEYS */;
INSERT INTO `sm_course_pages` VALUES (1,NULL,NULL,'Course Infix','Lisus consequat sapien metus dis urna, facilisi. Nonummy rutrum eu lacinia platea a, ipsum parturient, orci tristique. Nisi diam natoque.','Under Graduate Education','INFIX has all in one place. Youâ€™ll find everything what you are looking into education management system software. We care! User will never bothered in our real eye catchy user friendly UI & UX  Interface design. You know! Smart Idea always comes to well planners. And Our INFIX is Smart for its Well Documentation. Explore in new support world! Itâ€™s now faster & quicker. Youâ€™ll find us on Support Ticket, Email, Skype, WhatsApp.','public/uploads/about_page/about.jpg','public/uploads/about_page/about-img.jpg','Learn More News ','news',1,1,1,1);
/*!40000 ALTER TABLE `sm_course_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_courses`
--

DROP TABLE IF EXISTS `sm_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_courses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `overview` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `outline` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `prerequisites` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `resources` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `stats` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_courses_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_courses_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_courses`
--

LOCK TABLES `sm_courses` WRITE;
/*!40000 ALTER TABLE `sm_courses` DISABLE KEYS */;
INSERT INTO `sm_courses` VALUES (1,'Culpa veniam eos velit.','public/uploads/course/academic1.jpg','In at est optio sunt quasi nesciunt deserunt. Illum voluptatum illum dolorum corrupti placeat et. Suscipit qui assumenda velit nam ut. Nostrum aliquid et odit eligendi quae non eveniet. Voluptatem pariatur voluptatem qui. Iste consequatur porro reprehenderit minus qui aut officia earum. Aut tenetur perspiciatis et. Beatae qui in voluptate repellat id vero et. Nam aliquam similique eos eaque. Velit quae corrupti qui necessitatibus unde eum esse tempora. Iste voluptatem et dignissimos sit tenetur enim. Nemo voluptatem commodi optio. Aspernatur ut non est quidem vitae pariatur qui dolor. Repellendus voluptas tempore aut voluptas illum. Quis voluptas dolores itaque nobis. Autem nobis delectus eligendi dicta ut aut. Dolorum quaerat qui illum tempora aut et. Enim eveniet animi quod dolorem. Velit ex tempora quidem consequatur. Ducimus doloribus praesentium eligendi facilis rerum laboriosam. Occaecati est aut autem praesentium autem in consectetur. Nesciunt et possimus sapiente et. Laborum quis fugiat harum dolorem non sunt illo. Sed et omnis rerum similique. Excepturi quo vitae sit dolores. Voluptates aut non sint nemo fuga. Dignissimos quo placeat facilis omnis officia. Sint sint omnis maxime aut tempore soluta laboriosam. Sunt rerum aut consequuntur molestias reprehenderit. Beatae atque magnam voluptatem sit dicta eum temporibus. Fugit a aliquam accusantium amet porro totam. Aperiam architecto porro molestias amet reprehenderit laboriosam deleniti. Blanditiis in qui hic id autem odit. Nulla ut quam laborum eos. Maiores aut qui explicabo natus. Minima eos rerum similique itaque consequatur architecto aut. Veritatis eum recusandae totam omnis expedita cupiditate hic. Aut rem voluptas quia labore iste. Hic eius repudiandae a excepturi eveniet. Atque eum eum modi nostrum. Repellat sapiente ducimus accusamus excepturi. Aliquid cumque harum id excepturi cum. Omnis itaque sunt est qui.','Voluptas id deleniti velit animi quas eos ut pariatur. Qui atque facilis magnam totam molestias. Blanditiis saepe aut officia eligendi alias fugit. Amet excepturi accusantium quae exercitationem aliquam eum quos. Nobis magnam sed quis qui. Ut et ut aut quisquam facilis magnam incidunt corrupti. Asperiores quia omnis nulla est architecto. Quia unde aperiam sint ad. Enim aut et aut ut veniam aliquam. Omnis sed vel nemo libero ipsum laudantium. Cumque molestiae culpa sit nemo voluptates consequatur. Omnis quis aut est veniam. Quo suscipit minus sit qui ad. Vel labore deleniti voluptatem. Odio sequi quaerat a quas nisi. Eum sequi debitis tenetur eum nam. Autem omnis vitae nesciunt consequatur. Perspiciatis et et sit alias est fugit. Perspiciatis minima nulla est non aliquam porro aperiam. Sed voluptas tempore ex eaque id et ea. Recusandae veniam aperiam aut. Eum in itaque debitis. Ut sunt expedita alias qui error tempore. Voluptatum velit ad rerum et doloremque numquam. Eius nihil quia eaque culpa distinctio voluptatem id. Quisquam incidunt eaque accusantium id. Sint ipsam officia consequuntur et voluptate rerum. Omnis repellendus aliquam sequi ut alias. Voluptate consectetur et dolor quia eum. Dicta dolorem in ullam quod eaque eius est. Consequatur repellendus voluptatem quia sint dolorum facilis perferendis. Et facere nihil porro nostrum quam modi non. Voluptates sit aspernatur sit et fuga ea quia nam. Iste labore ea molestias quia dolorem. Tempore hic perferendis veniam blanditiis corrupti. Dolore recusandae explicabo est quod. Necessitatibus quae rerum veniam repellendus. Asperiores enim sed perspiciatis occaecati placeat et. Eaque dolores eum nostrum. Accusantium ipsa quam ut veritatis. Aut eum sed dolorem perspiciatis. Repudiandae et aliquid voluptate natus. Ducimus ratione doloribus et nemo dolores id hic. Rerum quaerat quia consequatur et et dolore hic a. Facere delectus at debitis ea explicabo.','Sapiente qui explicabo occaecati. Libero maiores rem in occaecati ipsa. Adipisci delectus consectetur architecto porro dolor ut. Blanditiis aut iure tempora illum. Eum libero quos officiis dolorem distinctio in atque. Illum atque voluptatem reiciendis molestiae neque fugiat. Voluptas debitis distinctio alias autem praesentium reprehenderit quo. Sunt veniam consequatur esse sit nemo ut pariatur. Dolores quod sapiente omnis deleniti. Officia eaque qui excepturi reprehenderit quo minus officiis. Voluptatem consequatur hic similique accusamus. Corrupti est reiciendis autem nihil. Aspernatur dignissimos ipsum qui molestiae aperiam sequi. Ipsa mollitia quasi molestias aperiam totam. Sint sed eveniet at aliquam. Minima ratione quas dolores omnis deleniti aperiam. Porro ea est praesentium vero eius et optio. Sint et dolor aut praesentium totam. Natus neque assumenda quas aut. Voluptatibus ea sunt consequatur et. Porro cupiditate consectetur porro cum. Beatae aut est tempore occaecati accusamus. Fugiat ratione cupiditate non sed. Ea eos consequatur perspiciatis. Illo voluptatum voluptatum est omnis. Repellendus enim iusto officiis nihil. Quibusdam voluptas deserunt quidem sed consequatur aliquid eos qui. Iusto cum eum voluptatem molestiae voluptatibus. Deleniti quaerat cumque est modi praesentium asperiores. Temporibus autem ut quia quia voluptas eveniet. Dicta consequatur ut ut. Vel facere et est accusamus molestiae dolor. Omnis voluptatem ducimus voluptas dolor. Eveniet vero odio quod ipsum eligendi. In ratione doloribus sequi ea. Et minus ut non veritatis libero culpa non. Facilis beatae dignissimos sit quisquam quisquam reiciendis. Voluptas maiores occaecati voluptas ut ea aut odio. Voluptatibus distinctio consectetur aut blanditiis aut illo est recusandae. Reprehenderit odit ut sint atque. Sit cupiditate molestiae ad. Reiciendis suscipit aut ea voluptas vel velit molestias. Repellat est quia nostrum et modi ex deserunt.','Sint architecto natus ut qui et tempore et dicta. Et eum ut est dolor commodi. Optio sed nihil est libero odio. Aspernatur sequi nostrum et. Placeat expedita expedita qui. Laborum beatae omnis quidem consequatur eos dolorem. Dolore suscipit dolorum natus quia ut. Sit nobis cumque quos ipsum deleniti repellat veniam. Sed ipsum aut omnis delectus porro blanditiis. Provident dicta incidunt et soluta praesentium omnis. Voluptas dolorum excepturi ea velit laudantium exercitationem neque. Expedita atque quam et nihil consequatur eos. Aliquid doloremque nam dolorum rerum. Dolorem corporis ut animi mollitia corporis molestiae tenetur. Fuga occaecati modi nobis eaque. Adipisci molestiae voluptatem tempora aut. Enim totam aut aut sit. Tempore illum reprehenderit autem molestiae. Ut autem quod voluptates officiis. Consequatur omnis necessitatibus dicta aut aut dolores cupiditate. Voluptatum deleniti sint hic nostrum neque architecto. Velit qui voluptates dolorem animi accusantium. Deserunt deleniti laudantium fugiat veritatis culpa. Totam consequatur praesentium eum ab. Perspiciatis dolores non molestiae sed animi non. Labore et quia vero aut et. Quaerat cumque incidunt soluta minima eos aut dolorum. Cumque qui repellendus nostrum reiciendis. Ut facilis facilis accusamus cupiditate. Consequatur voluptas tempore omnis aut amet assumenda iusto vero. Porro sint unde non id. Non eaque porro quo dolorum eligendi tenetur et. Cupiditate corrupti hic at et totam numquam molestiae quia. Ducimus odit impedit perferendis exercitationem aspernatur tempore ab vero. Quia beatae voluptas facere dolores nemo est. Numquam aliquid est est maiores quia. Nulla est beatae quos maiores autem. Debitis est consequuntur eum. Aut aut asperiores culpa in qui. Laudantium culpa odit temporibus. Sit adipisci cumque optio similique in modi non. Ipsa blanditiis consequatur est voluptatem voluptates. Est voluptatem corporis voluptas enim. Mollitia qui at ipsum similique ducimus odit.','Repellendus praesentium nostrum temporibus maxime. Autem numquam quam impedit a perspiciatis consequatur iusto. Eum quia quasi veniam tempora sunt dolorem consequatur. Tempore quis eveniet autem beatae inventore. Pariatur aut eos architecto fugit. Ratione nostrum occaecati ut molestiae aut tempora quia. Quis omnis accusamus exercitationem id quia velit qui. Aliquam ea sequi aut sequi dolor quisquam. Quo non quo dolore beatae totam reiciendis. Velit accusantium enim non maiores error nulla dolorem. Dolores iusto earum placeat voluptatem. Et cum consequatur enim eum quia reiciendis quia. Corrupti sit est nostrum dolores quis. Deleniti odio sed eius saepe autem. Officia est qui voluptas. Laborum praesentium eos sequi eius in sequi dolor. Suscipit dolorem et totam voluptas omnis dolorum. Pariatur quam esse omnis dolore praesentium. Quam nobis ut tempora fugiat tenetur nesciunt. Est saepe et suscipit voluptatem. Aliquid est voluptas eligendi sapiente consequatur ullam totam magnam. Consequatur minima esse rerum adipisci. Quod quo corrupti sed consequatur. Odio corporis fugiat corporis animi velit. Explicabo harum asperiores doloremque officia a et consequatur. Porro aut voluptatem similique molestias. Quis at voluptatibus veritatis quia quia provident. Porro maxime voluptatum rerum cumque et sed vero voluptas. Rem fuga laboriosam quod enim harum. Eaque atque possimus recusandae asperiores perspiciatis. Fugit quae facilis hic nulla. Unde harum autem eligendi voluptatibus cupiditate consequuntur. Delectus voluptates harum est ipsum ad impedit impedit architecto. Maxime asperiores atque sint dolorum iure veritatis. Consequatur accusantium dicta quia. Officiis quis accusamus rem est et voluptatum. Omnis harum totam et aliquid. Incidunt maxime eligendi veniam voluptatem aut voluptas. Odio eius excepturi laboriosam culpa neque architecto doloribus. Voluptas sint dolorum ut. Repudiandae sed quisquam quia recusandae incidunt. Id deserunt ex omnis et ea.',1,'2020-08-10 05:58:21',NULL,1),(2,'Architecto blanditiis voluptatum sed excepturi.','public/uploads/course/academic3.jpg','Eveniet id omnis aut dolore placeat optio similique. Veritatis quod aliquam eum ratione tenetur. Excepturi voluptas quos quia quaerat. Perspiciatis iusto consectetur saepe. Quas et facere occaecati id. Veniam sequi in labore nihil labore quam cum. Quam quia impedit esse neque reprehenderit vel tempore. Fuga velit est aspernatur. Vero aut magni voluptatibus quo. Aliquam molestias sint dolorum. Reprehenderit doloremque perferendis harum. Sed voluptate harum et fuga. Ut et officia provident deleniti dolorem amet. Accusamus asperiores veniam laudantium odit laborum esse repellendus atque. Maxime sit sit praesentium aliquid eum atque consequatur. Quibusdam consectetur iusto et pariatur ut. Pariatur provident iusto nesciunt laborum dignissimos aliquid praesentium. Fugit dolores odio aut error officia voluptas sint. Ut tempora maxime optio et facere repellendus. Rerum natus temporibus consequatur reprehenderit. Quia est tempore nisi sed omnis. Illo repellendus illo quo doloribus et incidunt. Excepturi nisi cum quam aut enim veritatis eum. Aut quia nihil ut vel sapiente. Vitae laudantium vitae quae fugit rerum. In in ut sit doloremque expedita a neque. Debitis ex odit dolores quia doloribus sed. Est aut dolore voluptatem unde. Pariatur voluptatem sit nihil nulla repudiandae. Expedita fugit recusandae sunt fugiat aut non. Dolores fuga laboriosam laborum assumenda in officia. Id enim ipsam esse minus voluptatibus architecto mollitia. Omnis voluptatibus perferendis distinctio quidem velit. Est eum in accusantium porro. Aut sed saepe a alias. Amet necessitatibus dolores optio tempore non eum. Voluptatibus illo explicabo doloremque impedit. In est soluta velit ipsum odit non. Et unde soluta laborum accusamus alias. Distinctio voluptatem ad minus qui minima nobis beatae dolores. Provident praesentium eaque id in in. Voluptas repellendus et modi ullam aspernatur. Sit minus reiciendis labore ratione ut.','Et officia quos est corrupti. Est numquam consequatur sed aut ut illum inventore. Nulla natus ut debitis voluptas consequatur. Amet neque qui ut alias enim. Voluptatem nihil odit nobis minus quo et adipisci. Necessitatibus sapiente cum dolores minima facere facilis enim. Rerum dolore rem explicabo. Et quia ad rem ea illo et. Libero ab inventore recusandae ea ut. Voluptas voluptas veniam voluptates ipsam quis corporis. Nobis ab rerum repellendus nostrum dolorum ea veritatis autem. Qui quia ut sit quia. Enim voluptatem quae blanditiis quia autem natus ex. Libero quaerat doloremque aliquid fugit aut. Assumenda suscipit voluptatem optio labore est natus consequatur. Possimus voluptatem libero omnis doloribus. Atque vitae aperiam explicabo aut. Qui qui voluptas non voluptas. Odit nemo officiis facilis corporis quia perspiciatis. Et occaecati quod voluptatem consequuntur corporis qui ab. Dolorem eaque velit quam voluptatum odio quia. Impedit culpa deserunt saepe et odit expedita. Quia reprehenderit totam vel magni dolore dolores consectetur. Omnis voluptatem eum eaque eius molestias. Amet et sunt itaque repellat quo. Veritatis maxime reiciendis quam est quod. Nemo odit qui nisi aut adipisci. Quo qui ab suscipit excepturi qui. Accusantium dolores itaque quam harum. Fuga reprehenderit quam omnis. Tempora illum qui qui nihil. Repudiandae cupiditate rerum ratione numquam harum. Qui debitis temporibus eligendi iste modi dicta dolorem. Earum veniam magnam quos sit est cum. Dolor hic suscipit error dignissimos sed non est. Culpa molestiae ut quis nihil ut commodi. Voluptas rerum cumque temporibus. Incidunt voluptatibus est aliquam aliquid voluptatem iusto recusandae. Ipsum occaecati nihil ut expedita consequatur voluptate. Soluta saepe nihil voluptatem nihil repellat a incidunt. Qui aspernatur et qui quis. Aperiam sunt ex velit. Illo id eos dolores eos blanditiis. Quasi quia et culpa in nihil vel consequatur.','Assumenda nulla est natus recusandae qui. In aperiam expedita ut sit. Quia inventore blanditiis laboriosam voluptatum aliquam tempora. Rerum quia consectetur atque ea quas asperiores ex aliquam. Cum cumque at necessitatibus dolor itaque. Corporis voluptatum et delectus et voluptatum sed temporibus. Adipisci mollitia nemo maiores iure. Consequatur autem quasi sed voluptatem occaecati. Accusantium autem veniam eveniet. Est sapiente consequatur veritatis est est. Expedita autem tempore velit. Eum veniam fuga incidunt ut. Ut ipsum dolores commodi ut dolor dolor amet. Est vitae et id maiores sequi quia. Voluptatem quia dolores nulla impedit voluptas. Quo accusantium voluptatem exercitationem repudiandae repudiandae temporibus. Velit praesentium voluptas id commodi. Doloremque molestiae et possimus aut perspiciatis vitae. Sunt est qui dolorem omnis. Impedit sunt illo quam veniam in optio. Dolore velit incidunt itaque. In ut itaque quis delectus temporibus assumenda quis impedit. Voluptatum est et vitae quam voluptas. Qui vel sed et qui voluptatem. Expedita omnis ullam veritatis voluptas et. Vitae nihil possimus voluptatem eaque et nemo. Nobis veniam architecto culpa quaerat quis cum. Quidem voluptate esse sed at at ullam autem. Mollitia sit unde expedita consequatur voluptas id aut. Fuga dignissimos consequatur odio et amet. Facere ut in aut quis illo. Aliquam ut id ex accusantium consequuntur qui est dolor. Magni eum vitae accusantium facilis quia. Laboriosam repellendus ut aut autem expedita aut eveniet. In recusandae dolorum magni alias consectetur hic laboriosam. Sint reprehenderit illum quam fugit unde suscipit vitae. Necessitatibus beatae distinctio ut rerum sint magni. Alias dignissimos aliquam fugit rerum odio dicta quo. Aut ut est saepe neque aliquam in voluptatem fuga. Et rerum excepturi ratione consequuntur enim non. Quia pariatur doloremque saepe animi odit non. Quas dolor quia voluptatibus pariatur.','Eveniet a non consequatur numquam. Doloremque adipisci magnam cum. Non quisquam deserunt et. Alias error molestiae provident sed deserunt fuga aut quidem. Animi perspiciatis sint est qui voluptatem. Eveniet quia sit facere non natus nobis. Exercitationem eligendi sit itaque molestiae laudantium. Vel ipsa architecto ipsa assumenda quaerat. Doloremque sed odio explicabo aut. Dolorum tempora minima dolorem sit ut laboriosam. Est voluptatem excepturi asperiores sapiente et consequuntur. Unde qui vel eum ut laboriosam nostrum eum. Minima eaque aut qui. Libero sed distinctio voluptatem doloremque accusamus molestias. Perspiciatis nemo deleniti aliquam et excepturi. Nam non dolor libero autem veniam excepturi. Error quibusdam in et dignissimos hic. Molestiae deleniti perferendis quasi harum aut sint. Libero omnis odio at quia dolores. Provident ipsum nihil est. Consequuntur ipsam debitis alias adipisci corporis. Odit accusantium nostrum est. Odit et enim et doloribus voluptas blanditiis. Rerum voluptatem optio asperiores recusandae accusantium error. Dolorem ut delectus velit cumque nostrum ipsa rem. Autem ut rem facilis nostrum itaque ipsam. Nostrum cumque similique consectetur veritatis. Est nam porro ea totam ea sint. Dolore beatae atque corrupti repudiandae quod ut. Id minus voluptas provident alias ipsa nemo praesentium nemo. Perspiciatis laudantium ut libero velit facilis neque. Cupiditate et incidunt id id. Aliquid est eaque eos unde fugit. Deserunt ut quia aut aut. Maiores eos necessitatibus nihil quisquam quibusdam ab. Accusamus tenetur molestiae est impedit ipsa ipsa soluta voluptates. Et aspernatur similique voluptas aut neque. Ipsam veritatis libero quia. Rerum dolor ad dolor quos fugiat corporis. Corrupti ut veritatis dolor sapiente fuga excepturi officiis velit. Odit voluptatem sit ut quia facere nihil. Dolor dolorem maiores tempora.','Dolores molestiae est suscipit dolorem dolorem ipsam. Adipisci perferendis voluptate eum nobis. Laudantium assumenda consectetur fuga et omnis aliquid perferendis consequatur. Nulla explicabo autem consectetur et. Maxime adipisci libero quo est atque deleniti. Sint velit facere recusandae natus. Nihil quod laudantium veniam repellat non asperiores error. Occaecati repellat recusandae sint laboriosam assumenda et nostrum eos. Unde dolorem eum facere sed harum suscipit. Culpa assumenda omnis velit voluptatibus necessitatibus deleniti. Libero architecto atque cumque beatae ullam. Illum molestiae ipsam velit voluptas accusamus. Adipisci sunt dolorem quis numquam et debitis. Id voluptatem veritatis praesentium magni qui optio ut. Libero ut sed in sit omnis et. Eius sed qui ipsa ipsa cum repellat. Et consequuntur qui qui laborum reprehenderit molestiae voluptas. Quasi iste excepturi occaecati magnam eos perspiciatis. Saepe blanditiis id aut dolor consequatur nulla sit. Sint saepe beatae aut pariatur magni qui. Enim magnam perspiciatis quibusdam eos. Doloremque debitis libero molestiae id doloremque illo. Quasi veniam deleniti omnis tempora. Mollitia aut porro quibusdam dignissimos et maxime cupiditate. Quas rerum reprehenderit consectetur ab ducimus quia non. Totam labore tempora culpa sapiente quae natus libero et. Recusandae repellendus incidunt expedita ea vel incidunt. Aut molestiae aut veritatis consequatur. Saepe tenetur beatae rerum. Qui excepturi voluptas ullam dolorem quos deserunt. Officia et expedita in quasi. Eum laborum magnam laudantium amet voluptas. Voluptate architecto temporibus saepe reprehenderit mollitia consectetur. Similique est sequi dolores quia et repellat. Quis sint enim nobis eius esse aut. Eum error voluptas vitae aliquam officia ut. Sit nesciunt facilis mollitia rerum reiciendis. Aspernatur distinctio occaecati doloribus sed.',1,'2020-08-10 05:58:21',NULL,1),(3,'Voluptate id id expedita.','public/uploads/course/academic5.jpg','Ut unde doloribus dolorum repellat eaque culpa voluptates aut. Omnis blanditiis dolorem voluptatem sed dicta. Ea error itaque in ut doloribus rerum eos veniam. Iure adipisci impedit velit beatae cupiditate dolores reiciendis. Atque rerum dolorum necessitatibus placeat consequatur vero. Explicabo repudiandae ut architecto. Iste velit aspernatur in eum optio est rerum. At odit veniam expedita est culpa voluptatibus. Ut rerum aut omnis unde ullam sed veniam voluptatem. Minus et aspernatur blanditiis ea rerum ipsam. Cum est deleniti et optio. Omnis molestiae omnis eum earum esse distinctio. Beatae rerum neque totam natus eveniet nostrum culpa. Cum sit quod dignissimos quo sunt quo. Deserunt est nobis inventore similique quia voluptatem quos. Ipsum non consectetur doloremque voluptatibus quisquam. Eveniet aut aut quos rerum. Aut officia neque voluptatem aperiam ut. Odio iste corrupti quibusdam voluptatem fugit. Velit voluptas reiciendis magnam ex. Velit totam odio nostrum rerum aut. Blanditiis quis nesciunt qui aut minus. Illo quo officia accusantium veritatis eveniet. Necessitatibus id dolore sed. Sed ea consequatur accusamus non. Soluta officiis occaecati vel molestiae doloribus non. Id dolorem ut sint voluptatum deleniti vero. Perspiciatis delectus libero in tempora iure natus similique. Laboriosam harum enim voluptatem doloremque eos illo quo. Dolor sed est at reprehenderit magni odit. Qui beatae quaerat vel aliquam minus ea. Voluptate aut est accusantium cupiditate error ut nam. Molestias corporis reiciendis beatae numquam minima consequatur possimus. Dolorem fugiat vel numquam. Et est iusto nihil delectus. Perferendis amet debitis ad repellat id necessitatibus eaque. Itaque a debitis ea necessitatibus earum ratione molestias possimus. Quae autem sit aliquid reprehenderit aliquid autem neque.','Qui et ducimus eos tempora ut quod a voluptatibus. Facere eligendi voluptatem vel dicta quae. Eius autem tenetur nisi omnis laboriosam dolore. Voluptatum amet doloremque repudiandae aspernatur soluta magni hic. Doloribus alias ullam aut rerum. Cum in et quia eveniet repellat. Explicabo quisquam atque similique consequuntur ut harum. Maxime iure praesentium et odit fugiat modi et. Necessitatibus cum beatae dolorum earum dolorum nihil voluptas. Repellendus laboriosam sint commodi. Dolorem error reprehenderit est molestiae vitae qui. Dolorem corrupti delectus qui eligendi. Dolorum cumque ratione blanditiis dolore nisi aperiam ratione omnis. Quia accusamus mollitia maiores ex dolores incidunt qui. Aliquam earum est aut et blanditiis. Laborum totam aut odio. Rerum laboriosam cumque itaque qui. Et et assumenda quam occaecati velit. Molestiae aut animi maxime molestias omnis veniam nulla. Tempora voluptatibus aliquam minus repellendus. Qui ut ea quaerat ea et ipsum. Voluptate cupiditate explicabo ut quidem doloremque sint. Veritatis velit et sed dolorem qui accusantium. Voluptatem fugit dolore praesentium voluptatem. Optio ut illo corporis non facere. Odit earum error voluptate commodi nesciunt consequatur inventore. Omnis reprehenderit eos ullam autem et nisi. Maiores eius quia id est. Ratione rem sunt ut et maiores possimus nostrum. Architecto officia rerum incidunt voluptas. Et ducimus quibusdam porro vel. Rem dolorem sunt error. Ullam voluptate et velit labore. Voluptatem repellendus ut voluptatem natus quis a perspiciatis. Impedit vero est debitis iste provident corrupti id. Expedita sunt ut consequatur quos quod. Mollitia voluptatum explicabo aperiam harum delectus consequuntur quasi enim. Hic maxime cupiditate molestias maxime. Odit quam et est sed laboriosam sunt. Deserunt debitis sit facilis et. Voluptatem perspiciatis officia enim sapiente. Sit ut voluptates et in provident. Voluptates eos voluptate aspernatur id ab dolor optio.','Ullam sequi veniam et enim. Nisi aut ipsam eos praesentium voluptatem. Quibusdam occaecati doloremque dolores et tenetur eligendi vitae. Eius atque delectus voluptate qui alias fugiat labore cupiditate. Ut ipsum doloribus soluta eveniet. Cum incidunt mollitia magnam quia quibusdam. Consequatur aut asperiores est temporibus commodi ex culpa. Unde ex esse possimus omnis temporibus. Autem reprehenderit sunt doloremque et rerum. Tempora eveniet temporibus voluptatem aut ipsum voluptatibus. Et tenetur ut et velit ex optio modi. Error aspernatur et quod quia est. Suscipit culpa autem aspernatur dolorem magni quibusdam unde. Et sint dolorum saepe quia qui rerum quod aliquid. A est ducimus modi blanditiis. Est id aperiam amet voluptatum expedita atque quia. Reiciendis quo consectetur sapiente quia atque alias. Hic quasi et nobis est ex vel. Quia quis nesciunt soluta blanditiis enim maiores. Deserunt autem aut officiis voluptatum. Quia reprehenderit aut atque cum cupiditate. Doloribus sit omnis necessitatibus temporibus ducimus facere. Perferendis cupiditate mollitia voluptatem provident. Commodi voluptate occaecati eius dolore quos iusto. Enim sequi nihil repellendus. Adipisci dolorem alias perferendis est esse voluptates. Voluptatem et numquam ex enim. Fugit accusantium assumenda quaerat consequatur vitae ratione. Cupiditate reiciendis dignissimos voluptatum perspiciatis commodi. Quia molestias voluptatem suscipit doloremque quod. Id consequuntur dolore sed modi. Iste eaque aut vel voluptas. Ab temporibus quia aut necessitatibus ex sapiente quaerat. Modi quis non sed. Ut aspernatur natus nesciunt voluptatibus minus ullam ab. Saepe maxime accusamus ipsum maiores et. Hic inventore voluptate occaecati quisquam. Eveniet est facilis suscipit quasi. Voluptas eos esse quisquam facilis quae consequatur ut. Et impedit ipsam voluptatem. Non dolore amet sit omnis ad accusantium. Molestias distinctio recusandae veniam et.','Adipisci optio iure voluptatem vel vero tenetur voluptatum aspernatur. Rem doloremque consequatur et ad. Eaque ut corporis tempore ut nostrum et et. Officiis quisquam ratione eius deserunt dignissimos et. Est ullam aut et qui modi. Quia distinctio voluptate rerum ea consectetur et est. Soluta voluptatem eius hic non ab qui aut. Et non incidunt sunt et corporis incidunt et. Laboriosam et provident quisquam dignissimos odio fugit. Impedit ipsa repellendus itaque modi praesentium possimus corrupti. Nulla dolorum non nisi expedita voluptatem labore esse. Quis aperiam in vel sed ex delectus. Rerum iure et debitis molestias reprehenderit suscipit harum autem. Et laudantium ut at accusantium. Nisi voluptas excepturi modi. Explicabo voluptatibus autem beatae. Quo minima accusantium ipsam dignissimos veritatis. Officiis rerum non ea sed inventore molestias autem assumenda. Delectus voluptatem est quia omnis. Voluptate ullam fugiat rerum consequuntur ut perspiciatis tempora. Natus tenetur numquam a minus voluptas necessitatibus quidem. Temporibus cupiditate ex in tempore accusantium. Iste quia perspiciatis nisi eos libero cum sint. Et distinctio quisquam dolorem a. Consequuntur quisquam iste quos reprehenderit molestias omnis et. Amet reiciendis laudantium ratione quis minima inventore occaecati. A saepe sit accusantium ea. Quia reprehenderit pariatur ut iusto eaque impedit praesentium nemo. Velit beatae ipsam nihil non dolore. Facere debitis numquam voluptas. Rerum voluptatem ad enim mollitia sapiente. Sed a aliquid ipsa at consequatur iure omnis. Quam incidunt harum consequatur. Aut sunt aperiam voluptatem sint in enim dolorem. Qui placeat placeat ut iusto quas doloremque molestiae in. Sit enim illum voluptas et ea nemo. Est eos sit distinctio velit porro ipsum animi. Et occaecati aliquam enim dolor. Officia sed voluptas reiciendis earum. Nihil officiis ab consequatur laborum totam.','Sint qui quidem et id tenetur et. Consectetur eligendi assumenda id fuga vel alias. Non quasi rerum voluptas voluptas voluptatum. Officia numquam assumenda vitae rerum eligendi ipsam ducimus vel. Eaque ducimus enim iste ipsam tempore perspiciatis sint quas. Earum optio dolorem necessitatibus eius. Reiciendis quo optio fugiat placeat et at veritatis vitae. Qui iusto totam voluptate consectetur omnis odio. Iusto dolores quas consequatur et culpa laborum. Consectetur dolorem incidunt consectetur qui rerum ut est. Sit est minima dolore nulla et error. Aliquam hic ab nostrum ipsum nemo qui. Qui mollitia ab velit ea et facere eius magnam. Deleniti temporibus pariatur repellendus hic iusto. Fugiat ut dolore fugiat rerum. Molestiae suscipit placeat atque quia architecto. Possimus corporis animi reprehenderit ipsa laborum corrupti ad. Modi omnis odit ut nostrum temporibus. Voluptate et et culpa quidem dolor est maxime. Repudiandae nesciunt culpa voluptatibus omnis veniam. Ut quibusdam quo et laborum debitis. Unde voluptatem et a voluptatem et omnis provident. Ipsum dolor delectus quod et sit asperiores eum expedita. Incidunt et praesentium quo reprehenderit qui quis repudiandae. Sequi ea voluptatem numquam quia soluta officia dolor. Maiores commodi quisquam consequatur commodi consequatur. Repudiandae facilis ea dignissimos. Assumenda porro praesentium est vero ut sed. Quia fuga est adipisci qui autem in error. Aut eveniet dicta ducimus eaque enim nulla. Qui minima et ab quis qui voluptas voluptas praesentium. Eveniet et blanditiis iure neque. Incidunt quo facere veniam a alias laboriosam eum sint. Inventore porro sit autem facere unde. Est vero hic voluptates eum tempora. Deserunt culpa magni culpa ut consequatur doloremque ipsa. Explicabo dolorem incidunt quas quis atque illum. Occaecati aut aut nulla est. Possimus eligendi distinctio quia tempore quibusdam ut.',1,'2020-08-10 05:58:21',NULL,1);
/*!40000 ALTER TABLE `sm_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_currencies`
--

DROP TABLE IF EXISTS `sm_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_currencies_school_id_foreign` (`school_id`),
  KEY `sm_currencies_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_currencies_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_currencies_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_currencies`
--

LOCK TABLES `sm_currencies` WRITE;
/*!40000 ALTER TABLE `sm_currencies` DISABLE KEYS */;
INSERT INTO `sm_currencies` VALUES (1,'Leke','ALL','Lek','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(2,'Dollars','USD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(3,'Afghanis','AFN','Ø‹','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(4,'Pesos','ARS','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(5,'Guilders','AWG','Æ’','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(6,'Dollars','AUD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(7,'New Manats','AZN','Ð¼Ð°Ð½','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(8,'Dollars','BSD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(9,'Dollars','BBD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(10,'Rubles','BYR','p.','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(11,'Euro','EUR','â‚¬','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(12,'Dollars','BZD','BZ$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(13,'Dollars','BMD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(14,'Bolivianos','BOB','$b','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(15,'Convertible Marka','BAM','KM','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(16,'Pula','BWP','P','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(17,'Leva','BGN','Ð»Ð²','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(18,'Reais','BRL','R$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(19,'Pounds','GBP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(20,'Dollars','BND','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(21,'Riels','KHR','áŸ›','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(22,'Dollars','CAD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(23,'Dollars','KYD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(24,'Pesos','CLP','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(25,'Yuan Renminbi','CNY','Â¥','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(26,'Pesos','COP','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(27,'ColÃ³n','CRC','â‚¡','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(28,'Kuna','HRK','kn','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(29,'Pesos','CUP','â‚±','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(30,'Koruny','CZK','KÄ','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(31,'Kroner','DKK','kr','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(32,'Pesos','DOP ','RD$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(33,'Dollars','XCD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(34,'Pounds','EGP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(35,'Colones','SVC','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(36,'Pounds','FKP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(37,'Dollars','FJD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(38,'Cedis','GHC','Â¢','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(39,'Pounds','GIP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(40,'Quetzales','GTQ','Q','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(41,'Pounds','GGP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(42,'Dollars','GYD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(43,'Lempiras','HNL','L','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(44,'Dollars','HKD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(45,'Forint','HUF','Ft','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(46,'Kronur','ISK','kr','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(47,'Rupees','INR','â‚¹','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(48,'Rupiahs','IDR','Rp','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(49,'Rials','IRR','ï·¼','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(50,'Pounds','IMP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(51,'New Shekels','ILS','â‚ª','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(52,'Dollars','JMD','J$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(53,'Yen','JPY','Â¥','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(54,'Pounds','JEP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(55,'Tenge','KZT','Ð»Ð²','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(56,'Won','KPW','â‚©','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(57,'Won','KRW','â‚©','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(58,'Soms','KGS','Ð»Ð²','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(59,'Kips','LAK','â‚­','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(60,'Lati','LVL','Ls','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(61,'Pounds','LBP','Â£','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(62,'Dollars','LRD','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(63,'Switzerland Francs','CHF','CHF','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(64,'Litai','LTL','Lt','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(65,'Denars','MKD','Ð´ÐµÐ½','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(66,'Ringgits','MYR','RM','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(67,'Rupees','MUR','â‚¨','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(68,'Pesos','MXN','$','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(69,'Tugriks','MNT','â‚®','2020-08-10 05:58:20','2020-08-10 05:58:20',1,1),(70,'Meticais','MZN','MT','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(71,'Dollars','NAD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(72,'Rupees','NPR','â‚¨','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(73,'Guilders','ANG','Æ’','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(74,'Dollars','NZD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(75,'Cordobas','NIO','C$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(76,'Nairas','NGN','â‚¦','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(77,'Krone','NOK','kr','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(78,'Rials','OMR','ï·¼','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(79,'Rupees','PKR','â‚¨','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(80,'Balboa','PAB','B/.','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(81,'Guarani','PYG','Gs','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(82,'Nuevos Soles','PEN','S/.','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(83,'Pesos','PHP','Php','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(84,'Zlotych','PLN','zÅ‚','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(85,'Rials','QAR','ï·¼','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(86,'New Lei','RON','lei','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(87,'Rubles','RUB','Ñ€ÑƒÐ±','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(88,'Pounds','SHP','Â£','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(89,'Riyals','SAR','ï·¼','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(90,'Dinars','RSD','Ð”Ð¸Ð½.','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(91,'Rupees','SCR','â‚¨','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(92,'Dollars','SGD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(93,'Dollars','SBD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(94,'Shillings','SOS','S','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(95,'Rand','ZAR','R','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(96,'Rupees','LKR','â‚¨','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(97,'Kronor','SEK','kr','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(98,'Dollars','SRD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(99,'Pounds','SYP','Â£','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(100,'New Dollars','TWD','NT$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(101,'Baht','THB','à¸¿','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(102,'Dollars','TTD','TT$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(103,'Lira','TRY','TL','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(104,'Liras','TRL','Â£','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(105,'Dollars','TVD','$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(106,'Hryvnia','UAH','â‚´','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(107,'Pesos','UYU','$U','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(108,'Sums','UZS','Ð»Ð²','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(109,'Bolivares Fuertes','VEF','Bs','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(110,'Dong','VND','â‚«','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(111,'Rials','YER','ï·¼','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(112,'Taka','BDT','à§³','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(113,'Zimbabwe Dollars','ZWD','Z$','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(114,'Kenya','KES','KSh','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(115,'Nigeria','naira','â‚¦','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(116,'Ghana','GHS','GHâ‚µ','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(117,'Ethiopian','ETB','Br','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(118,'Tanzania','TZS','TSh','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(119,'Uganda','UGX','USh','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1),(120,'Rwandan','FRW','FRw','2020-08-10 05:58:21','2020-08-10 05:58:21',1,1);
/*!40000 ALTER TABLE `sm_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_custom_links`
--

DROP TABLE IF EXISTS `sm_custom_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_custom_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href4` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href5` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label6` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href6` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label7` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href7` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label8` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href8` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label9` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href9` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label10` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href10` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label11` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href11` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label12` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href12` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label13` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href13` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label14` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href14` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label15` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href15` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_label16` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_href16` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitter_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dribble_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `behance_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_custom_links`
--

LOCK TABLES `sm_custom_links` WRITE;
/*!40000 ALTER TABLE `sm_custom_links` DISABLE KEYS */;
INSERT INTO `sm_custom_links` VALUES (1,'Departments','Health Care','About Our System','Resources','About Infix','http://infixedu.com','Infix Home','http://infixedu.com/home','Business','http://infixedu.com','','','','','','','','','','','Home','http://infixedu.com/home','About','http://infixedu.com/about','Contact','http://infixedu.com/contact','','','','','','','','','','',NULL,NULL,NULL,NULL,NULL,'2020-08-10 05:58:21','2020-09-13 09:24:41');
/*!40000 ALTER TABLE `sm_custom_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_custom_temporary_results`
--

DROP TABLE IF EXISTS `sm_custom_temporary_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_custom_temporary_results` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `admission_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term1` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpa1` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpa2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `term3` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpa3` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_result` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_grade` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_custom_temporary_results_school_id_foreign` (`school_id`),
  KEY `sm_custom_temporary_results_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_custom_temporary_results_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_custom_temporary_results_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_custom_temporary_results`
--

LOCK TABLES `sm_custom_temporary_results` WRITE;
/*!40000 ALTER TABLE `sm_custom_temporary_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_custom_temporary_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_dashboard_settings`
--

DROP TABLE IF EXISTS `sm_dashboard_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_dashboard_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboard_sec_id` int(11) NOT NULL,
  `active_status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_dashboard_settings_role_id_foreign` (`role_id`),
  KEY `sm_dashboard_settings_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_dashboard_settings_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_dashboard_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_dashboard_settings`
--

LOCK TABLES `sm_dashboard_settings` WRITE;
/*!40000 ALTER TABLE `sm_dashboard_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_dashboard_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_date_formats`
--

DROP TABLE IF EXISTS `sm_date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_date_formats` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `format` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `normal_view` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_date_formats_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_date_formats_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_date_formats`
--

LOCK TABLES `sm_date_formats` WRITE;
/*!40000 ALTER TABLE `sm_date_formats` DISABLE KEYS */;
INSERT INTO `sm_date_formats` VALUES (1,'jS M, Y','17th May, 2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(2,'Y-m-d','2019-05-17',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(3,'Y-d-m','2019-17-05',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(4,'d-m-Y','17-05-2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(5,'m-d-Y','05-17-2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(6,'Y/m/d','2019/05/17',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(7,'Y/d/m','2019/17/05',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(8,'d/m/Y','17/05/2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(9,'m/d/Y','05/17/2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(10,'l jS \\of F Y','Monday 17th of May 2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(11,'jS \\of F Y','17th of May 2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(12,'g:ia \\o\\n l jS F Y','12:00am on Monday 17th May 2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(13,'F j, Y, g:i a','May 7, 2019, 6:20 pm',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(14,'F j, Y','May 17, 2019',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1),(15,'\\i\\t \\i\\s \\t\\h\\e jS \\d\\a\\y','it is the 17th day',1,'2020-08-10 05:58:17','2020-08-10 05:58:17',1,1,1);
/*!40000 ALTER TABLE `sm_date_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_designations`
--

DROP TABLE IF EXISTS `sm_designations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_designations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_designations_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_designations_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_designations`
--

LOCK TABLES `sm_designations` WRITE;
/*!40000 ALTER TABLE `sm_designations` DISABLE KEYS */;
INSERT INTO `sm_designations` VALUES (1,'Head of Centre',1,'2020-08-10 05:58:15','2020-08-20 09:37:28',1,1,1),(2,'Quality Nominee',1,'2020-08-20 09:37:14','2020-08-20 09:37:14',1,1,1),(3,'Tutor/Assessor',1,'2020-08-20 09:37:43','2020-08-20 09:37:43',1,1,1),(4,'Internal Verifier',1,'2020-08-20 09:38:07','2020-08-20 09:38:07',1,1,1),(5,'Lead Internal Verifier',1,'2020-08-20 09:38:22','2020-08-20 09:38:22',1,1,1),(6,'Program Leader',1,'2020-08-20 09:38:28','2020-08-20 09:38:28',1,1,1);
/*!40000 ALTER TABLE `sm_designations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_dormitory_lists`
--

DROP TABLE IF EXISTS `sm_dormitory_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_dormitory_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dormitory_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'B=Boys, G=Girls',
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intake` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_dormitory_lists_school_id_foreign` (`school_id`),
  KEY `sm_dormitory_lists_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_dormitory_lists_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_dormitory_lists_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_dormitory_lists`
--

LOCK TABLES `sm_dormitory_lists` WRITE;
/*!40000 ALTER TABLE `sm_dormitory_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_dormitory_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_email_settings`
--

DROP TABLE IF EXISTS `sm_email_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_email_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email_engine_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_driver` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_host` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_port` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_encryption` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_email_settings_school_id_foreign` (`school_id`),
  KEY `sm_email_settings_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_email_settings_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_email_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_email_settings`
--

LOCK TABLES `sm_email_settings` WRITE;
/*!40000 ALTER TABLE `sm_email_settings` DISABLE KEYS */;
INSERT INTO `sm_email_settings` VALUES (1,'smtp','System Admin','admin@infixedu.com','smtp','smtp.gmail.com','587','spn5@spondonit.com','123456','tls',1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `sm_email_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_email_sms_logs`
--

DROP TABLE IF EXISTS `sm_email_sms_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_email_sms_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_date` date DEFAULT NULL,
  `send_through` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_to` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_email_sms_logs_school_id_foreign` (`school_id`),
  KEY `sm_email_sms_logs_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_email_sms_logs_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_email_sms_logs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_email_sms_logs`
--

LOCK TABLES `sm_email_sms_logs` WRITE;
/*!40000 ALTER TABLE `sm_email_sms_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_email_sms_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_events`
--

DROP TABLE IF EXISTS `sm_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `for_whom` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'teacher, student, parents, all',
  `event_location` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_des` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `uplad_image_file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_events_school_id_foreign` (`school_id`),
  KEY `sm_events_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_events_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_events_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_events`
--

LOCK TABLES `sm_events` WRITE;
/*!40000 ALTER TABLE `sm_events` DISABLE KEYS */;
INSERT INTO `sm_events` VALUES (1,'Biggest Robotics Competition in Campus',NULL,'Main Campus','Amet enim curabitur urna. Faucibus tincidunt pellentesque varius blandit fermentum tristique vulputate sodales tempus est hendrerit est tincidunt ligula lorem tellus eu malesuada tortor, lacinia posuere. Conubia Egestas sed senectus.','2019-06-12','2019-06-21','public/uploads/events/event1.jpg',1,NULL,NULL,1,1,1,1),(2,'Great Science Fair in main campus',NULL,'Main Campus','Magna odio in. Facilisi arcu nec augue lacus augue maecenas hendrerit euismod cras vulputate dignissim pellentesque sociis est. Ut congue Leo dignissim. Fermentum curabitur pede bibendum aptent, quam, ultrices Nam convallis sed condimentum. Adipiscing mollis lorem integer eget neque, vel.','2019-06-12','2019-06-21','public/uploads/events/event2.jpg',1,NULL,NULL,1,1,1,1),(3,'Seminar on Internet of Thing in Campus',NULL,'Main Campus','Libero erat porta ridiculus semper mi eleifend. Nisl nulla. Tempus, rhoncus per. Varius. Pharetra nisi potenti ut ultrices sociosqu adipiscing at. Suscipit vulputate senectus. Nostra. Aliquam fringilla eleifend accumsan dui.','2019-06-12','2019-06-21','public/uploads/events/event3.jpg',1,NULL,NULL,1,1,1,1),(4,'Art Competition in Campus',NULL,'Main Campus','Dui nunc faucibus Feugiat penatibus molestie taciti nibh nulla pellentesque convallis praesent. Fusce. Vivamus egestas Rutrum est eu dictum volutpat morbi et. Placerat justo elementum dictumst magna nisl ut mollis varius velit facilisi. Duis tellus ullamcorper aenean massa nibh mi.','2019-06-12','2019-06-21','public/uploads/events/event4.jpg',1,NULL,NULL,1,1,1,1);
/*!40000 ALTER TABLE `sm_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_attendance_children`
--

DROP TABLE IF EXISTS `sm_exam_attendance_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_attendance_children` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendance_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'P = present A = Absent',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_attendance_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_attendance_children_exam_attendance_id_foreign` (`exam_attendance_id`),
  KEY `sm_exam_attendance_children_student_id_foreign` (`student_id`),
  KEY `sm_exam_attendance_children_school_id_foreign` (`school_id`),
  KEY `sm_exam_attendance_children_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_attendance_children_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendance_children_exam_attendance_id_foreign` FOREIGN KEY (`exam_attendance_id`) REFERENCES `sm_exam_attendances` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendance_children_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendance_children_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_attendance_children`
--

LOCK TABLES `sm_exam_attendance_children` WRITE;
/*!40000 ALTER TABLE `sm_exam_attendance_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_attendance_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_attendances`
--

DROP TABLE IF EXISTS `sm_exam_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_attendances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_attendances_subject_id_foreign` (`subject_id`),
  KEY `sm_exam_attendances_exam_id_foreign` (`exam_id`),
  KEY `sm_exam_attendances_class_id_foreign` (`class_id`),
  KEY `sm_exam_attendances_section_id_foreign` (`section_id`),
  KEY `sm_exam_attendances_school_id_foreign` (`school_id`),
  KEY `sm_exam_attendances_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_attendances_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendances_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendances_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendances_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendances_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_attendances_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_attendances`
--

LOCK TABLES `sm_exam_attendances` WRITE;
/*!40000 ALTER TABLE `sm_exam_attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_marks_registers`
--

DROP TABLE IF EXISTS `sm_exam_marks_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_marks_registers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `obtained_marks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `comments` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) unsigned NOT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_marks_registers_exam_id_foreign` (`exam_id`),
  KEY `sm_exam_marks_registers_student_id_foreign` (`student_id`),
  KEY `sm_exam_marks_registers_subject_id_foreign` (`subject_id`),
  KEY `sm_exam_marks_registers_school_id_foreign` (`school_id`),
  KEY `sm_exam_marks_registers_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_marks_registers_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_marks_registers_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_marks_registers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_marks_registers_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_marks_registers_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_marks_registers`
--

LOCK TABLES `sm_exam_marks_registers` WRITE;
/*!40000 ALTER TABLE `sm_exam_marks_registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_marks_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_schedule_subjects`
--

DROP TABLE IF EXISTS `sm_exam_schedule_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_schedule_subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `start_time` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `room` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_mark` int(11) DEFAULT NULL,
  `pass_mark` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_schedule_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_schedule_subjects_exam_schedule_id_foreign` (`exam_schedule_id`),
  KEY `sm_exam_schedule_subjects_subject_id_foreign` (`subject_id`),
  KEY `sm_exam_schedule_subjects_school_id_foreign` (`school_id`),
  KEY `sm_exam_schedule_subjects_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_schedule_subjects_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedule_subjects_exam_schedule_id_foreign` FOREIGN KEY (`exam_schedule_id`) REFERENCES `sm_exam_schedules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedule_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedule_subjects_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_schedule_subjects`
--

LOCK TABLES `sm_exam_schedule_subjects` WRITE;
/*!40000 ALTER TABLE `sm_exam_schedule_subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_schedule_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_schedules`
--

DROP TABLE IF EXISTS `sm_exam_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_schedules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_period_id` int(10) unsigned DEFAULT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `exam_term_id` int(10) unsigned DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_schedules_exam_period_id_foreign` (`exam_period_id`),
  KEY `sm_exam_schedules_room_id_foreign` (`room_id`),
  KEY `sm_exam_schedules_subject_id_foreign` (`subject_id`),
  KEY `sm_exam_schedules_exam_term_id_foreign` (`exam_term_id`),
  KEY `sm_exam_schedules_exam_id_foreign` (`exam_id`),
  KEY `sm_exam_schedules_class_id_foreign` (`class_id`),
  KEY `sm_exam_schedules_section_id_foreign` (`section_id`),
  KEY `sm_exam_schedules_school_id_foreign` (`school_id`),
  KEY `sm_exam_schedules_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_schedules_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_exam_period_id_foreign` FOREIGN KEY (`exam_period_id`) REFERENCES `sm_class_times` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_exam_term_id_foreign` FOREIGN KEY (`exam_term_id`) REFERENCES `sm_exam_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `sm_room_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_schedules_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_schedules`
--

LOCK TABLES `sm_exam_schedules` WRITE;
/*!40000 ALTER TABLE `sm_exam_schedules` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_setups`
--

DROP TABLE IF EXISTS `sm_exam_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_setups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exam_mark` double(8,2) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `exam_term_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_setups_exam_id_foreign` (`exam_id`),
  KEY `sm_exam_setups_class_id_foreign` (`class_id`),
  KEY `sm_exam_setups_subject_id_foreign` (`subject_id`),
  KEY `sm_exam_setups_section_id_foreign` (`section_id`),
  KEY `sm_exam_setups_exam_term_id_foreign` (`exam_term_id`),
  KEY `sm_exam_setups_school_id_foreign` (`school_id`),
  KEY `sm_exam_setups_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_setups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_exam_term_id_foreign` FOREIGN KEY (`exam_term_id`) REFERENCES `sm_exam_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_setups_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_setups`
--

LOCK TABLES `sm_exam_setups` WRITE;
/*!40000 ALTER TABLE `sm_exam_setups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exam_types`
--

DROP TABLE IF EXISTS `sm_exam_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exam_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` int(11) NOT NULL DEFAULT '1',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exam_types_school_id_foreign` (`school_id`),
  KEY `sm_exam_types_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exam_types_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exam_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exam_types`
--

LOCK TABLES `sm_exam_types` WRITE;
/*!40000 ALTER TABLE `sm_exam_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exam_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_exams`
--

DROP TABLE IF EXISTS `sm_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_exams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_mark` double(8,2) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_type_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_exams_exam_type_id_foreign` (`exam_type_id`),
  KEY `sm_exams_class_id_foreign` (`class_id`),
  KEY `sm_exams_section_id_foreign` (`section_id`),
  KEY `sm_exams_subject_id_foreign` (`subject_id`),
  KEY `sm_exams_school_id_foreign` (`school_id`),
  KEY `sm_exams_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_exams_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exams_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exams_exam_type_id_foreign` FOREIGN KEY (`exam_type_id`) REFERENCES `sm_exam_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exams_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_exams_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_exams`
--

LOCK TABLES `sm_exams` WRITE;
/*!40000 ALTER TABLE `sm_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_expense_heads`
--

DROP TABLE IF EXISTS `sm_expense_heads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_expense_heads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_expense_heads_school_id_foreign` (`school_id`),
  KEY `sm_expense_heads_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_expense_heads_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_expense_heads_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_expense_heads`
--

LOCK TABLES `sm_expense_heads` WRITE;
/*!40000 ALTER TABLE `sm_expense_heads` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_expense_heads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_assign_discounts`
--

DROP TABLE IF EXISTS `sm_fees_assign_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_assign_discounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `fees_discount_id` int(10) unsigned DEFAULT NULL,
  `fees_group_id` int(11) DEFAULT NULL,
  `applied_amount` double DEFAULT '0',
  `unapplied_amount` double DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_assign_discounts_student_id_foreign` (`student_id`),
  KEY `sm_fees_assign_discounts_fees_discount_id_foreign` (`fees_discount_id`),
  KEY `sm_fees_assign_discounts_school_id_foreign` (`school_id`),
  KEY `sm_fees_assign_discounts_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_assign_discounts_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assign_discounts_fees_discount_id_foreign` FOREIGN KEY (`fees_discount_id`) REFERENCES `sm_fees_discounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assign_discounts_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assign_discounts_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_assign_discounts`
--

LOCK TABLES `sm_fees_assign_discounts` WRITE;
/*!40000 ALTER TABLE `sm_fees_assign_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_assign_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_assigns`
--

DROP TABLE IF EXISTS `sm_fees_assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_assigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fees_amount` double(10,2) DEFAULT NULL,
  `applied_discount` double(10,2) DEFAULT NULL,
  `fees_master_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_assigns_fees_master_id_foreign` (`fees_master_id`),
  KEY `sm_fees_assigns_student_id_foreign` (`student_id`),
  KEY `sm_fees_assigns_school_id_foreign` (`school_id`),
  KEY `sm_fees_assigns_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_assigns_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assigns_fees_master_id_foreign` FOREIGN KEY (`fees_master_id`) REFERENCES `sm_fees_masters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assigns_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_assigns_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_assigns`
--

LOCK TABLES `sm_fees_assigns` WRITE;
/*!40000 ALTER TABLE `sm_fees_assigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_assigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_carry_forwards`
--

DROP TABLE IF EXISTS `sm_fees_carry_forwards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_carry_forwards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `balance` double(16,2) NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_carry_forwards_student_id_foreign` (`student_id`),
  KEY `sm_fees_carry_forwards_school_id_foreign` (`school_id`),
  KEY `sm_fees_carry_forwards_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_carry_forwards_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_carry_forwards_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_carry_forwards_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_carry_forwards`
--

LOCK TABLES `sm_fees_carry_forwards` WRITE;
/*!40000 ALTER TABLE `sm_fees_carry_forwards` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_carry_forwards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_discounts`
--

DROP TABLE IF EXISTS `sm_fees_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_discounts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('once','year') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'once for one time, year for all months',
  `amount` double(10,2) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_discounts_school_id_foreign` (`school_id`),
  KEY `sm_fees_discounts_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_discounts_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_discounts_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_discounts`
--

LOCK TABLES `sm_fees_discounts` WRITE;
/*!40000 ALTER TABLE `sm_fees_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_groups`
--

DROP TABLE IF EXISTS `sm_fees_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_groups_school_id_foreign` (`school_id`),
  KEY `sm_fees_groups_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_groups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_groups`
--

LOCK TABLES `sm_fees_groups` WRITE;
/*!40000 ALTER TABLE `sm_fees_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_masters`
--

DROP TABLE IF EXISTS `sm_fees_masters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_masters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fees_group_id` int(10) unsigned DEFAULT NULL,
  `fees_type_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_masters_fees_group_id_foreign` (`fees_group_id`),
  KEY `sm_fees_masters_fees_type_id_foreign` (`fees_type_id`),
  KEY `sm_fees_masters_school_id_foreign` (`school_id`),
  KEY `sm_fees_masters_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_masters_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_masters_fees_group_id_foreign` FOREIGN KEY (`fees_group_id`) REFERENCES `sm_fees_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_masters_fees_type_id_foreign` FOREIGN KEY (`fees_type_id`) REFERENCES `sm_fees_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_masters_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_masters`
--

LOCK TABLES `sm_fees_masters` WRITE;
/*!40000 ALTER TABLE `sm_fees_masters` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_masters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_payments`
--

DROP TABLE IF EXISTS `sm_fees_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discount_month` tinyint(4) DEFAULT NULL,
  `discount_amount` double(8,2) DEFAULT NULL,
  `fine` double(8,2) DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_mode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `slip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fine_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fees_discount_id` int(10) unsigned DEFAULT NULL,
  `fees_type_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_payments_fees_discount_id_foreign` (`fees_discount_id`),
  KEY `sm_fees_payments_fees_type_id_foreign` (`fees_type_id`),
  KEY `sm_fees_payments_student_id_foreign` (`student_id`),
  KEY `sm_fees_payments_school_id_foreign` (`school_id`),
  KEY `sm_fees_payments_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_payments_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_payments_fees_discount_id_foreign` FOREIGN KEY (`fees_discount_id`) REFERENCES `sm_fees_discounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_payments_fees_type_id_foreign` FOREIGN KEY (`fees_type_id`) REFERENCES `sm_fees_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_payments_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_payments_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_payments`
--

LOCK TABLES `sm_fees_payments` WRITE;
/*!40000 ALTER TABLE `sm_fees_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_fees_types`
--

DROP TABLE IF EXISTS `sm_fees_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_fees_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(230) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fees_group_id` int(10) unsigned DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_fees_types_fees_group_id_foreign` (`fees_group_id`),
  KEY `sm_fees_types_school_id_foreign` (`school_id`),
  KEY `sm_fees_types_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_fees_types_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_types_fees_group_id_foreign` FOREIGN KEY (`fees_group_id`) REFERENCES `sm_fees_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_fees_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_fees_types`
--

LOCK TABLES `sm_fees_types` WRITE;
/*!40000 ALTER TABLE `sm_fees_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_fees_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_frontend_persmissions`
--

DROP TABLE IF EXISTS `sm_frontend_persmissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_frontend_persmissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `is_published` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_frontend_persmissions`
--

LOCK TABLES `sm_frontend_persmissions` WRITE;
/*!40000 ALTER TABLE `sm_frontend_persmissions` DISABLE KEYS */;
INSERT INTO `sm_frontend_persmissions` VALUES (1,'Home Page',0,1,'2020-08-10 05:58:21','2020-08-10 05:58:21'),(2,'About Page',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(3,'Image Banner',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(4,'Latest News',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(5,'Notice Board',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(6,'Event List',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(7,'Academics',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(8,'Testimonial',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(9,'Custom Links',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(10,'Social Icons',1,1,'2020-08-10 05:58:21','2020-09-13 09:26:20'),(11,'About Image',2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21'),(12,'Statistic Number Section',2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21'),(13,'Our History',2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21'),(14,'Our Mission and Vision',2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21'),(15,'Testimonial',2,1,'2020-08-10 05:58:21','2020-08-10 05:58:21');
/*!40000 ALTER TABLE `sm_frontend_persmissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_general_settings`
--

DROP TABLE IF EXISTS `sm_general_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_general_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `site_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'USD',
  `currency_symbol` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '$',
  `promotionSetting` int(11) DEFAULT '0',
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_version` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '4.4',
  `active_status` int(11) DEFAULT '1',
  `currency_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'USD',
  `language_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `session_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '2019',
  `system_purchase_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_activated_date` date DEFAULT NULL,
  `envato_user` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `envato_item_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_domain` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `copyright_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_url` int(11) NOT NULL DEFAULT '1',
  `website_btn` int(11) NOT NULL DEFAULT '1',
  `dashboard_btn` int(11) NOT NULL DEFAULT '1',
  `report_btn` int(11) NOT NULL DEFAULT '1',
  `style_btn` int(11) NOT NULL DEFAULT '1',
  `ltl_rtl_btn` int(11) NOT NULL DEFAULT '1',
  `lang_btn` int(11) NOT NULL DEFAULT '1',
  `website_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ttl_rtl` int(11) NOT NULL DEFAULT '2',
  `phone_number_privacy` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `time_zone_id` int(11) DEFAULT NULL,
  `session_id` int(10) unsigned DEFAULT NULL,
  `language_id` int(10) unsigned DEFAULT '1',
  `date_format_id` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `software_version` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `FeesCollection` int(11) DEFAULT '0',
  `InfixBiometrics` int(11) DEFAULT '0',
  `ResultReports` int(11) DEFAULT '0',
  `TemplateSettings` int(11) DEFAULT '1',
  `RolePermission` int(11) DEFAULT '1',
  `RazorPay` int(11) DEFAULT '0',
  `Saas` int(11) DEFAULT '0',
  `ParentRegistration` int(11) DEFAULT '0',
  `Zoom` int(11) DEFAULT '0',
  `SaasSubscription` int(11) DEFAULT '0',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_general_settings_session_id_foreign` (`session_id`),
  KEY `sm_general_settings_language_id_foreign` (`language_id`),
  KEY `sm_general_settings_date_format_id_foreign` (`date_format_id`),
  KEY `sm_general_settings_school_id_foreign` (`school_id`),
  KEY `sm_general_settings_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_general_settings_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_general_settings_date_format_id_foreign` FOREIGN KEY (`date_format_id`) REFERENCES `sm_date_formats` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_general_settings_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `sm_languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_general_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_general_settings_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_general_settings`
--

LOCK TABLES `sm_general_settings` WRITE;
/*!40000 ALTER TABLE `sm_general_settings` DISABLE KEYS */;
INSERT INTO `sm_general_settings` VALUES (1,'Cambridgeic','Infix Education software','12345678','89/2 Panthapath, Dhaka 1215, Bangladesh','+8801841412141','t.rakhmonov97@gmail.com','USD','$',0,'public/uploads/settings/logo.png','public/uploads/settings/favicon.png','4.4',1,'USD','en','2019','ebd7d886-e823-4d90-8037-deaab3bfd832','2020-08-10',NULL,NULL,'cambridge.uz','Copyright &copy; 2020 All rights reserved | This application is made by Codethemes',1,1,1,1,0,0,0,NULL,2,1,NULL,'2020-09-13 09:59:01',51,1,1,1,1,'5',0,0,0,1,1,0,0,0,0,0,1);
/*!40000 ALTER TABLE `sm_general_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_holidays`
--

DROP TABLE IF EXISTS `sm_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_holidays` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `holiday_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `upload_image_file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_holidays_school_id_foreign` (`school_id`),
  KEY `sm_holidays_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_holidays_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_holidays_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_holidays`
--

LOCK TABLES `sm_holidays` WRITE;
/*!40000 ALTER TABLE `sm_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_home_page_settings`
--

DROP TABLE IF EXISTS `sm_home_page_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_home_page_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `long_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_description` text COLLATE utf8mb4_unicode_ci,
  `link_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_home_page_settings`
--

LOCK TABLES `sm_home_page_settings` WRITE;
/*!40000 ALTER TABLE `sm_home_page_settings` DISABLE KEYS */;
INSERT INTO `sm_home_page_settings` VALUES (1,'Cambridge International College','CIC','Welcome to Orientation day',NULL,NULL,'public/backEnd/img/client/home-banner1.jpg','2020-08-10 05:58:21','2020-09-13 09:26:20');
/*!40000 ALTER TABLE `sm_home_page_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_homework_students`
--

DROP TABLE IF EXISTS `sm_homework_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_homework_students` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `marks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teacher_comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `complete_status` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `homework_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_homework_students_student_id_foreign` (`student_id`),
  KEY `sm_homework_students_homework_id_foreign` (`homework_id`),
  KEY `sm_homework_students_school_id_foreign` (`school_id`),
  KEY `sm_homework_students_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_homework_students_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homework_students_homework_id_foreign` FOREIGN KEY (`homework_id`) REFERENCES `sm_homeworks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homework_students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homework_students_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_homework_students`
--

LOCK TABLES `sm_homework_students` WRITE;
/*!40000 ALTER TABLE `sm_homework_students` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_homework_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_homeworks`
--

DROP TABLE IF EXISTS `sm_homeworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_homeworks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `homework_date` date DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `evaluation_date` date DEFAULT NULL,
  `file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marks` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `evaluated_by` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_homeworks_evaluated_by_foreign` (`evaluated_by`),
  KEY `sm_homeworks_class_id_foreign` (`class_id`),
  KEY `sm_homeworks_section_id_foreign` (`section_id`),
  KEY `sm_homeworks_subject_id_foreign` (`subject_id`),
  KEY `sm_homeworks_school_id_foreign` (`school_id`),
  KEY `sm_homeworks_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_homeworks_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homeworks_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homeworks_evaluated_by_foreign` FOREIGN KEY (`evaluated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homeworks_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homeworks_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_homeworks_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_homeworks`
--

LOCK TABLES `sm_homeworks` WRITE;
/*!40000 ALTER TABLE `sm_homeworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_homeworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_hourly_rates`
--

DROP TABLE IF EXISTS `sm_hourly_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_hourly_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `grade` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_hourly_rates_school_id_foreign` (`school_id`),
  KEY `sm_hourly_rates_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_hourly_rates_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hourly_rates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_hourly_rates`
--

LOCK TABLES `sm_hourly_rates` WRITE;
/*!40000 ALTER TABLE `sm_hourly_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_hourly_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_hr_payroll_earn_deducs`
--

DROP TABLE IF EXISTS `sm_hr_payroll_earn_deducs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_hr_payroll_earn_deducs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `earn_dedc_type` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e for earnings and d for deductions',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payroll_generate_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_hr_payroll_earn_deducs_payroll_generate_id_foreign` (`payroll_generate_id`),
  KEY `sm_hr_payroll_earn_deducs_school_id_foreign` (`school_id`),
  KEY `sm_hr_payroll_earn_deducs_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_hr_payroll_earn_deducs_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hr_payroll_earn_deducs_payroll_generate_id_foreign` FOREIGN KEY (`payroll_generate_id`) REFERENCES `sm_hr_payroll_generates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hr_payroll_earn_deducs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_hr_payroll_earn_deducs`
--

LOCK TABLES `sm_hr_payroll_earn_deducs` WRITE;
/*!40000 ALTER TABLE `sm_hr_payroll_earn_deducs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_hr_payroll_earn_deducs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_hr_payroll_generates`
--

DROP TABLE IF EXISTS `sm_hr_payroll_generates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_hr_payroll_generates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `basic_salary` double DEFAULT NULL,
  `total_earning` double DEFAULT NULL,
  `total_deduction` double DEFAULT NULL,
  `gross_salary` double DEFAULT NULL,
  `tax` double DEFAULT NULL,
  `net_salary` double DEFAULT NULL,
  `payroll_month` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payroll_year` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payroll_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'NG for not generated, G for generated, P for paid',
  `payment_mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `note` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_hr_payroll_generates_staff_id_foreign` (`staff_id`),
  KEY `sm_hr_payroll_generates_school_id_foreign` (`school_id`),
  KEY `sm_hr_payroll_generates_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_hr_payroll_generates_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hr_payroll_generates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hr_payroll_generates_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_hr_payroll_generates`
--

LOCK TABLES `sm_hr_payroll_generates` WRITE;
/*!40000 ALTER TABLE `sm_hr_payroll_generates` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_hr_payroll_generates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_hr_salary_templates`
--

DROP TABLE IF EXISTS `sm_hr_salary_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_hr_salary_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `salary_grades` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `salary_basic` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `overtime_rate` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `house_rent` int(11) DEFAULT NULL,
  `provident_fund` int(11) DEFAULT NULL,
  `gross_salary` int(11) DEFAULT NULL,
  `total_deduction` int(11) DEFAULT NULL,
  `net_salary` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_hr_salary_templates_school_id_foreign` (`school_id`),
  KEY `sm_hr_salary_templates_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_hr_salary_templates_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_hr_salary_templates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_hr_salary_templates`
--

LOCK TABLES `sm_hr_salary_templates` WRITE;
/*!40000 ALTER TABLE `sm_hr_salary_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_hr_salary_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_human_departments`
--

DROP TABLE IF EXISTS `sm_human_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_human_departments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_human_departments_created_by_foreign` (`created_by`),
  KEY `sm_human_departments_updated_by_foreign` (`updated_by`),
  KEY `sm_human_departments_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_human_departments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_human_departments_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_human_departments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_human_departments`
--

LOCK TABLES `sm_human_departments` WRITE;
/*!40000 ALTER TABLE `sm_human_departments` DISABLE KEYS */;
INSERT INTO `sm_human_departments` VALUES (1,'Admin',1,'2020-08-10 05:58:15',NULL,1,1,1),(2,'Business Program',1,'2020-08-20 09:34:55','2020-08-20 09:34:55',1,1,1),(3,'Information Technology Program',1,'2020-08-20 09:35:07','2020-08-20 09:35:07',1,1,1);
/*!40000 ALTER TABLE `sm_human_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_income_heads`
--

DROP TABLE IF EXISTS `sm_income_heads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_income_heads` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_income_heads_school_id_foreign` (`school_id`),
  KEY `sm_income_heads_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_income_heads_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_income_heads_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_income_heads`
--

LOCK TABLES `sm_income_heads` WRITE;
/*!40000 ALTER TABLE `sm_income_heads` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_income_heads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_instructions`
--

DROP TABLE IF EXISTS `sm_instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_instructions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_instructions_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_instructions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_instructions`
--

LOCK TABLES `sm_instructions` WRITE;
/*!40000 ALTER TABLE `sm_instructions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_instructions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_inventory_payments`
--

DROP TABLE IF EXISTS `sm_inventory_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_inventory_payments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_receive_sell_id` int(10) unsigned DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount` double(10,2) DEFAULT NULL,
  `reference_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_type` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'R for receive S for sell',
  `payment_method` int(10) unsigned DEFAULT NULL,
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_inventory_payments_school_id_foreign` (`school_id`),
  KEY `sm_inventory_payments_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_inventory_payments_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_inventory_payments_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_inventory_payments`
--

LOCK TABLES `sm_inventory_payments` WRITE;
/*!40000 ALTER TABLE `sm_inventory_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_inventory_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_categories`
--

DROP TABLE IF EXISTS `sm_item_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_categories_school_id_foreign` (`school_id`),
  KEY `sm_item_categories_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_categories_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_categories`
--

LOCK TABLES `sm_item_categories` WRITE;
/*!40000 ALTER TABLE `sm_item_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_issues`
--

DROP TABLE IF EXISTS `sm_item_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_issues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `issue_to` int(10) unsigned DEFAULT NULL,
  `issue_by` int(10) unsigned DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `quantity` int(10) unsigned DEFAULT NULL,
  `issue_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `item_category_id` int(10) unsigned DEFAULT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_issues_role_id_foreign` (`role_id`),
  KEY `sm_item_issues_item_category_id_foreign` (`item_category_id`),
  KEY `sm_item_issues_item_id_foreign` (`item_id`),
  KEY `sm_item_issues_school_id_foreign` (`school_id`),
  KEY `sm_item_issues_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_issues_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_issues_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `sm_item_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_issues_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `sm_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_issues_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_issues_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_issues`
--

LOCK TABLES `sm_item_issues` WRITE;
/*!40000 ALTER TABLE `sm_item_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_receive_children`
--

DROP TABLE IF EXISTS `sm_item_receive_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_receive_children` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `unit_price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sub_total` int(11) DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `item_receive_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_receive_children_item_id_foreign` (`item_id`),
  KEY `sm_item_receive_children_item_receive_id_foreign` (`item_receive_id`),
  KEY `sm_item_receive_children_school_id_foreign` (`school_id`),
  KEY `sm_item_receive_children_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_receive_children_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receive_children_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `sm_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receive_children_item_receive_id_foreign` FOREIGN KEY (`item_receive_id`) REFERENCES `sm_item_receives` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receive_children_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_receive_children`
--

LOCK TABLES `sm_item_receive_children` WRITE;
/*!40000 ALTER TABLE `sm_item_receive_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_receive_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_receives`
--

DROP TABLE IF EXISTS `sm_item_receives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_receives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receive_date` date DEFAULT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` int(11) DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `total_paid` int(11) DEFAULT NULL,
  `total_due` int(11) DEFAULT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `supplier_id` int(10) unsigned DEFAULT NULL,
  `store_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_receives_supplier_id_foreign` (`supplier_id`),
  KEY `sm_item_receives_store_id_foreign` (`store_id`),
  KEY `sm_item_receives_school_id_foreign` (`school_id`),
  KEY `sm_item_receives_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_receives_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receives_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receives_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `sm_item_stores` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_receives_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `sm_suppliers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_receives`
--

LOCK TABLES `sm_item_receives` WRITE;
/*!40000 ALTER TABLE `sm_item_receives` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_receives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_sell_children`
--

DROP TABLE IF EXISTS `sm_item_sell_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_sell_children` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sell_price` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `sub_total` int(11) DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `item_sell_id` int(10) unsigned DEFAULT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_sell_children_item_sell_id_foreign` (`item_sell_id`),
  KEY `sm_item_sell_children_item_id_foreign` (`item_id`),
  KEY `sm_item_sell_children_school_id_foreign` (`school_id`),
  KEY `sm_item_sell_children_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_sell_children_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_sell_children_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `sm_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_sell_children_item_sell_id_foreign` FOREIGN KEY (`item_sell_id`) REFERENCES `sm_item_sells` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_sell_children_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_sell_children`
--

LOCK TABLES `sm_item_sell_children` WRITE;
/*!40000 ALTER TABLE `sm_item_sell_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_sell_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_sells`
--

DROP TABLE IF EXISTS `sm_item_sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_sells` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_staff_id` int(11) DEFAULT NULL,
  `sell_date` date DEFAULT NULL,
  `reference_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grand_total` int(11) DEFAULT NULL,
  `total_quantity` int(11) DEFAULT NULL,
  `total_paid` int(11) DEFAULT NULL,
  `total_due` int(11) DEFAULT NULL,
  `payment_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_sells_role_id_foreign` (`role_id`),
  KEY `sm_item_sells_school_id_foreign` (`school_id`),
  KEY `sm_item_sells_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_sells_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_sells_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_sells_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_sells`
--

LOCK TABLES `sm_item_sells` WRITE;
/*!40000 ALTER TABLE `sm_item_sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_item_stores`
--

DROP TABLE IF EXISTS `sm_item_stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_item_stores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `store_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_no` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_item_stores_school_id_foreign` (`school_id`),
  KEY `sm_item_stores_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_item_stores_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_item_stores_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_item_stores`
--

LOCK TABLES `sm_item_stores` WRITE;
/*!40000 ALTER TABLE `sm_item_stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_item_stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_items`
--

DROP TABLE IF EXISTS `sm_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_in_stock` double(8,2) DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `item_category_id` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_items_item_category_id_foreign` (`item_category_id`),
  KEY `sm_items_school_id_foreign` (`school_id`),
  KEY `sm_items_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_items_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_items_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `sm_item_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_items_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_items`
--

LOCK TABLES `sm_items` WRITE;
/*!40000 ALTER TABLE `sm_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_language_phrases`
--

DROP TABLE IF EXISTS `sm_language_phrases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_language_phrases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `modules` text,
  `default_phrases` text,
  `en` text,
  `es` text,
  `bn` text,
  `fr` text,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1397 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_language_phrases`
--

LOCK TABLES `sm_language_phrases` WRITE;
/*!40000 ALTER TABLE `sm_language_phrases` DISABLE KEYS */;
INSERT INTO `sm_language_phrases` VALUES (1,'0','dashboard','Dashboard','Tablero','à¦¡à§à¦¯à¦¾à¦¶à¦¬à§‹à¦°à§à¦¡','Tableau de bord',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(2,'0','welcome','Welcome','Bienvenido','à¦¸à§à¦¬à¦¾à¦—à¦¤','Bienvenue',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(3,'0','student','Student','Estudiante','à¦›à¦¾à¦¤à§à¦°','Ã‰tudiant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(4,'0','total','Total','Total','à¦®à§‹à¦Ÿ','Total',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(5,'0','template','Template','Template','Template','Template',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(6,'0','early','Early','Early','Early','Early',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(7,'0','cheque_bounce','Cheque Bounce','Cheque Bounce','Cheque Bounce','Cheque Bounce',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(8,'0','checkout','Checkout','Checkout','Checkout','Checkout',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(9,'0','check','Check','Check','Check','Check',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(10,'0','credentials','Credentials','Credentials','Credentials','Credentials',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(11,'0','birthday','Birthday','Birthday','Birthday','Birthday',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(12,'0','application','Application','Application','Application','Application',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(13,'0','student_admitted_message','Student Admitted Message','Student Admitted Message','Student Admitted Message','Student Admitted Message',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(14,'0','student_admission_progress','Student Admission In Progress','Student Admission In Progress','Student Admission In Progress','Student Admission In Progress',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(15,'0','teachers','Teachers','Maestros','à¦¶à¦¿à¦•à§à¦·à¦•','Enseignants',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(16,'0','parents','Parents','Los padres','à¦®à¦¾à¦¤à¦¾à¦ªà¦¿à¦¤à¦¾','Parents',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(17,'0','staffs','Staffs','Personal','à¦•à¦°à§à¦®à§€à¦°à¦¾','Le personnel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(18,'0','income_and_expenses_for','Income and Expenses for','Ingresos y gastos para','à¦†à¦¯à¦¼ à¦à¦¬à¦‚ à¦¬à§à¦¯à¦¯à¦¼à§‡à¦° à¦œà¦¨à§à¦¯','Revenus et dÃ©penses pour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(19,'0','total_income','Total Income','Ingresos totales','à¦®à§‹à¦Ÿ à¦†à¦¯à¦¼','Revenu total',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(20,'0','total_expenses','Total Expenses','Gastos totales','à¦®à§‹à¦Ÿ à¦–à¦°à¦š','DÃ©penses totales',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(21,'0','total_profit','Total Profit','Beneficio total','à¦¸à¦®à¦¸à§à¦¤ à¦²à¦¾à¦­','BÃ©nÃ©fice total',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(22,'0','total_revenue','Total Revenue','Los ingresos totales','à¦®à§‹à¦Ÿ à¦°à¦¾à¦œà¦¸à§à¦¬','Revenu total',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(23,'0','title','Title','TÃ­tulo','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(24,'0','message','Message','Mensaje','à¦¬à¦¾à¦°à§à¦¤à¦¾','Message',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(25,'0','actions','Actions','Comportamiento','à¦•à§à¦°à¦¿à¦¯à¦¼à¦¾à¦•à¦²à¦¾à¦ª','actes',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(26,'0','calendar','Calendar','Calendario','à¦ªà¦¾à¦à¦œà¦¿','Calendrier',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(27,'0','view','View','Ver','à¦¦à§ƒà¦¶à§à¦¯','Vue',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(28,'0','to_do_list','To Do List','Lista de quehaceres','à¦¤à¦¾à¦²à¦¿à¦•à¦¾ à¦¤à§ˆà¦°à¦¿','Liste de choses Ã  faire',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(29,'0','add','Add','AÃ±adir','à¦¯à§‹à¦—','Ajouter',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(30,'0','edit','Edit','Editar','à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨ à¦•à¦°à¦¾','modifier',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(31,'0','no_do_lists_assigned_yet','No Do Lists Assigned Yet','No hay listas asignadas aÃºn','à¦à¦–à¦¨à¦“ à¦•à§‹à¦¨à¦“ à¦¤à¦¾à¦²à¦¿à¦•à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾à¦­à§à¦•à§à¦¤ à¦•à¦°à¦¾ à¦¹à¦¯à¦¼à¦¨à¦¿','Aucune liste assignÃ©e pour linstant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(32,'0','theme','Theme','Theme','à¦¬à¦¿à¦·à¦¯à¦¼','Theme',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(33,'0','time_zone','Time Zone','Time Zone','à¦¸à¦®à¦¯à¦¼ à¦…à¦žà§à¦šà¦²','Time Zone',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(34,'0','mail','Mail','Mail','à¦®à§‡à¦²','Mail',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(35,'0','host','Host','Host','à¦¨à¦¿à¦®à¦¨à§à¦¤à§à¦°à¦£à¦•à¦°à§à¦¤à¦¾','Host',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(36,'0','encryption','Encryption','Encryption','à¦œà§‹à¦¡à¦¼à¦¾ à¦²à¦¾à¦—à¦¾à¦¨à§‹','Encryption',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(37,'0','login','Login','Login','à¦ªà§à¦°à¦¬à§‡à¦¶ à¦•à¦°à§à¦¨','Login',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(38,'0','enter','Enter','Enter','à¦ªà§à¦°à¦¬à§‡à¦¶ à¦•à¦°à¦¾à¦¨','Enter',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(39,'0','remember_me','Remember Me','Remember Me','à¦†à¦®à¦¾à¦•à§‡ à¦®à¦¨à§‡ à¦•à¦°','Remember Me',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(40,'0','forget','Forget','Forget','à¦­à§à¦²à§‡ à¦¯à¦¾à¦¨','Forget',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(41,'0','current_month','Current Month','Current Month','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦®à¦¾à¦¸','Current Month',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(42,'0','keyword','Keyword','Keyword','à¦•à§€ à¦–à§à¦à¦œà¦¤à§‡ à¦¹à¦¬à§‡','Keyword',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(43,'0','manage','Manage','manage','à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾ à¦•à¦°à¦¾','manage',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(44,'0','manager','Manager','manager','à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾','Manager',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(45,'0','child','Child','Child','à¦¶à¦¿à¦¶à§','Child',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(46,'0','running','Running','Running','à¦šà¦²à¦®à¦¾à¦¨','Running',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(47,'0','select_academic_year','Select Intake','Select Academic Year','à¦à¦•à¦¾à¦¡à§‡à¦®à¦¿à¦• à¦¬à¦›à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Select Academic Year',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(48,'0','PDF','PDF','PDF','à¦ªà¦¿à¦¡à¦¿à¦à¦«','PDF',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(49,'0','biometrics','Biometrics','Biometrics','à¦¬à¦¾à¦¯à¦¼à§‹à¦®à§‡à¦Ÿà§à¦°à¦¿à¦•à§à¦¸','Biometrics',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(50,'1','admin_section','Admin Section','SecciÃ³n de AdministraciÃ³n','à¦ªà§à¦°à¦¶à¦¾à¦¸à¦¨ à¦¬à¦¿à¦­à¦¾à¦—','Section Admin',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(51,'1','admission_query','Admission Query','Consulta de AdmisiÃ³n','à¦­à¦°à§à¦¤à¦¿ à¦ªà§à¦°à¦¶à§à¦¨','RequÃªte dadmission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(52,'1','select_criteria','Select Criteria','Seleccione los criterios','à¦®à¦¾à¦¨à¦¦à¦£à§à¦¡ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner des critÃ¨res',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(53,'1','date_from','Date From','Fecha de','à¦¤à¦¾à¦°à¦¿à¦– à¦¥à§‡à¦•à§‡','Dater de',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(54,'1','date_to','Date To','Fecha para','à¦¤à¦¾à¦°à¦¿à¦–','Date Ã ',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(55,'1','select_source','Select Source','Seleccione Fuente','à¦‰à¦¤à§à¦¸ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la source',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(56,'1','select_status','Select status','Seleccionar estado','à¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez le statut',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(57,'1','Status','Status','Estado','à¦…à¦¬à¦¸à§à¦¥à¦¾','Statut',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(58,'1','active','Active','Activo','à¦¸à¦•à§à¦°à¦¿à¦¯à¦¼','actif',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(59,'1','inactive','Inactive','Inactivo','à¦¨à¦¿à¦·à§à¦•à§à¦°à¦¿à¦¯à¦¼','Inactif',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(60,'1','search','Search','Buscar','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦•à¦°à§à¦¨','Chercher',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(61,'1','query_list','Query List','Lista de consultas','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de requÃªtes',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(62,'1','name','Name','Nombre','à¦¨à¦¾à¦®','prÃ©nom',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(63,'1','phone','Phone','TelÃ©fono','à¦«à§‹à¦¨','TÃ©lÃ©phone',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(64,'1','source','Source','Fuente','à¦¸à§‚à¦¤à§à¦°','La source',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(65,'1','email','Email','Email','à¦‡à¦®à§‡à¦‡à¦²','Email',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(66,'1','query_date','Query Date','Fecha de consulta','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date de la requÃªte',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(67,'1','last_follow_up_date','last follow up date','Ãºltima fecha de seguimiento','à¦¶à§‡à¦· à¦…à¦¨à§à¦¸à¦°à¦£ à¦¤à¦¾à¦°à¦¿à¦–','derniÃ¨re date de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(68,'1','next_follow_up_date','next follow up date','siguiente fecha de seguimiento','à¦ªà¦°à¦¬à¦°à§à¦¤à§€ à¦…à¦¨à§à¦¸à¦°à¦£ à¦¤à¦¾à¦°à¦¿à¦–','prochaine date de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(69,'1','select','Select','Seleccionar','à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à¦¾','SÃ©lectionner',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(70,'1','add_query','Add Query','AÃ±adir consulta','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter une requÃªte',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(71,'1','delete','Delete','Borrar','à¦®à§à¦›à§‡ à¦«à§‡à¦²à¦¾','Effacer',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(72,'1','delete_admission_query','Delete Admission Query','Eliminar consulta de admisiÃ³n','à¦­à¦°à§à¦¤à¦¿ à¦ªà§à¦°à¦¶à§à¦¨ à¦®à§à¦›à§à¦¨','Supprimer la requÃªte dadmission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(73,'1','are_you_sure_to_delete','Are you sure to delete this item?','Â¿EstÃ¡s seguro de eliminar este elemento?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦†à¦‡à¦Ÿà§‡à¦®à¦Ÿà¦¿ à¦®à§à¦›à§‡ à¦«à§‡à¦²à¦¾à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de vouloir supprimer cet article?',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(74,'1','are_you_sure_to_disable','Are you sure to disable this item?','Â¿EstÃ¡s seguro de eliminar este elemento?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦†à¦‡à¦Ÿà§‡à¦®à¦Ÿà¦¿ à¦®à§à¦›à§‡ à¦«à§‡à¦²à¦¾à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de vouloir supprimer cet article?',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(75,'1','are_you_sure_to_enable','Are you sure to enable this item?','Â¿EstÃ¡s seguro de eliminar este elemento?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦†à¦‡à¦Ÿà§‡à¦®à¦Ÿà¦¿ à¦®à§à¦›à§‡ à¦«à§‡à¦²à¦¾à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de vouloir supprimer cet article?',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(76,'1','cancel','Cancel','Cancelar','à¦¬à¦¾à¦¤à¦¿à¦²','Annuler',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(77,'1','admission_enquiry','Admission Enquiry','Consulta de AdmisiÃ³n','à¦­à¦°à§à¦¤à¦¿ à¦¤à¦¦à¦¨à§à¦¤','EnquÃªte dadmission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(78,'1','address','Address','DirecciÃ³n','à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(79,'1','description','Description','DescripciÃ³n','à¦¬à¦¿à¦¬à¦°à¦£','La description',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(80,'1','date','Date','Fecha','à¦¤à¦¾à¦°à¦¿à¦–','Rendez-vous amoureux',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(81,'1','assigned','Assigned','Asignado','à¦¬à¦°à¦¾à¦¦à§à¦¦','AttribuÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(82,'1','reference','Reference','Referencia','à¦‰à¦²à§à¦²à§‡à¦–','RÃ©fÃ©rence',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(83,'1','number_of_child','Number of child','Numero de niÃ±o','à¦¸à¦¨à§à¦¤à¦¾à¦¨à§‡à¦° à¦¸à¦‚à¦–à§à¦¯à¦¾','Nombre denfant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(84,'1','save','Save','Salvar','à¦¸à¦‚à¦°à¦•à§à¦·à¦£','sauvegarder',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(85,'1','visitor_book','Visitor Book','Libro de visitas','à¦­à¦¿à¦œà¦¿à¦Ÿà¦° à¦¬à§à¦•','Livre de visites',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(86,'1','visitor','Visitor','Visitante','à¦¦à¦°à§à¦¶à¦¨à¦¾à¦°à§à¦¥à§€','Visiteur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(87,'1','purpose','Purpose','PropÃ³sito','à¦‰à¦¦à§à¦¦à§‡à¦¶à§à¦¯','Objectif',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(88,'1','id','Id','CARNÃ‰ DE IDENTIDAd','à¦†à¦‡à¦¡à¦¿','Id',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(89,'1','no_of_person','No. of Person','No. de persona','à¦¬à§à¦¯à¦•à§à¦¤à¦¿à¦° à¦¸à¦‚à¦–à§à¦¯à¦¾','No. de personne',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(90,'1','in_time','In Time','A tiempo','à¦¸à¦®à¦¯à¦¼','Ã€ lheure',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(91,'1','out_time','Out time','Fuera de tiempo','à¦¸à¦®à¦¯à¦¼ à¦¶à§‡à¦·','Temps de sortie',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(92,'1','browse','browse','vistazo','à¦¬à§à¦°à¦¾à¦‰à¦œ','Feuilleter',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(93,'1','update','Update','Actualizar','à¦¹à¦¾à¦²à¦¨à¦¾à¦—à¦¾à¦¦','Mettre Ã  jour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(94,'1','visitor_list','Visitor List','Lista de visitantes','à¦¦à¦°à§à¦¶à¦¨à¦¾à¦°à§à¦¥à§€à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de visiteurs',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(95,'1','download','Download','Descargar','à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡','TÃ©lÃ©charger',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(96,'1','complaint','Complaint','Queja','à¦…à¦­à¦¿à¦¯à§‹à¦—','Plainte',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(97,'1','by','By','Por','à¦¦à§à¦¬à¦¾à¦°à¦¾','Par',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(98,'1','type','Type','Tipo','à¦†à¦¦à¦°à§à¦¶','Type',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(99,'1','taken','Taken','Tomado','à¦§à¦°à¦¾','Pris',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(100,'1','list','List','Lista','à¦¤à¦¾à¦²à¦¿à¦•à¦¾','liste',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(101,'1','postal_receive','Postal Receive','Recibir Postal','à¦¡à¦¾à¦• à¦ªà§à¦°à¦¾à¦ªà§à¦¤à¦¿','RÃ©ception postale',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(102,'1','from_title','From Title','Del tÃ­tulo','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦® à¦¥à§‡à¦•à§‡','De titre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(103,'1','no','No','No','à¦¨à¦¾','Non',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(104,'1','note','Note','Nota','à¦¬à¦¿à¦ƒà¦¦à§à¦°à¦ƒ','Remarque',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(105,'1','to_title','To Title','Al tÃ­tulo','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Au titre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(106,'1','postal_dispatch','Postal Dispatch','Despacho Postal','à¦¡à¦¾à¦• à¦ªà§à¦°à§‡à¦°à¦£','Envoi postal',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(107,'1','phone_call_log','Phone Call Log','Registro de llamadas telefÃ³nicas','à¦«à§‹à¦¨ à¦•à¦² à¦²à¦—','Journal des appels tÃ©lÃ©phoniques',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(108,'1','phone_call','Phone Call','Llamada telefÃ³nica','à¦«à§‹à¦¨ à¦•à¦²','Appel tÃ©lÃ©phonique',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(109,'1','follow_up_date','Follow Up Date','Fecha de seguimiento','à¦…à¦¨à§à¦¸à¦°à¦£ à¦¤à¦¾à¦°à¦¿à¦–','Date de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(110,'1','call_duration','Call Duration','DuraciÃ³n de la llamada','à¦•à¦² à¦¸à¦®à¦¯à¦¼à¦•à¦¾à¦²','DurÃ©e dappel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(111,'1','incoming','Incoming','Entrante','à¦‡à¦¨à¦•à¦¾à¦®à¦¿à¦‚','Entrant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(112,'1','outgoing','Outgoing','Saliente','à¦¬à¦¿à¦¦à¦¾à¦¯à¦¼à§€','Sortant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(113,'1','call','Call','Llamada','à¦•à¦²','Appel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(114,'1','admin_setup','Admin Setup','ConfiguraciÃ³n de administrador','à¦…à§à¦¯à¦¾à¦¡à¦®à¦¿à¦¨ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration de ladministrateur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(115,'1','student_certificate','Student Certificate','Certificado de estudiante','à¦›à¦¾à¦¤à§à¦° à¦¶à¦‚à¦¸à¦¾à¦ªà¦¤à§à¦°','Certificat dÃ©tudiant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(116,'1','certificate','Certificate','Certificado','à¦¸à¦¨à¦¦à¦ªà¦¤à§à¦°','Certificat',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(117,'1','header_left_text','Header left text','Encabezado texto a la izquierda','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦® à¦¬à¦¾à¦® à¦ªà¦¾à¦ à§à¦¯','En-tÃªte gauche du texte',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(118,'1','body','Body','Cuerpo','à¦¶à¦°à§€à¦°','Corps',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(119,'1','footer_left_text','Footer left text','Pie de pÃ¡gina texto a la izquierda','à¦ªà¦¾à¦¦à¦šà¦°à¦£ à¦¬à¦¾à¦® à¦ªà¦¾à¦ à§à¦¯','Footer left text',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(120,'1','footer_center_text','Footer Center text','Texto del centro de pie de pÃ¡gina','à¦ªà¦¾à¦¦à¦šà¦°à¦£ à¦•à§‡à¦¨à§à¦¦à§à¦° à¦ªà¦¾à¦ à§à¦¯','Footer Center text',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(121,'1','footer_right_text','Footer Right text','Pie derecho texto','à¦ªà¦¾à¦¦à¦²à§‡à¦– à¦¡à¦¾à¦¨ à¦ªà¦¾à¦ à§à¦¯','Footer Right text',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(122,'1','student_photo','Student Photo','Foto de estudiante','à¦›à¦¾à¦¤à§à¦°à§‡à¦° à¦›à¦¬à¦¿','Photo Ã©tudiante',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(123,'1','yes','Yes','sÃ­','à¦¹à§à¦¯à¦¾à¦','Oui',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(124,'1','none','No','No','à¦¨à¦¾','Non',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(125,'1','background_image','Background Image','Imagen de fondo','à¦ªà¦Ÿà¦­à§‚à¦®à¦¿ à¦šà¦¿à¦¤à§à¦°','Image de fond',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(126,'1','generate_certificate','Generate Certificate','Generar certificado','à¦¶à¦‚à¦¸à¦¾à¦ªà¦¤à§à¦° à¦¤à§ˆà¦°à¦¿ à¦•à¦°à§à¦¨','GÃ©nÃ©rer un certificat',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(127,'1','select_section','SELECT LEVEL ','Seleccione la secciÃ³n','à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez une section',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(128,'1','generate','Generate','Generar','à¦œà§‡à¦¨à¦¾à¦°à§‡à¦Ÿ à¦•à¦°à§à¦¨','produire',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(129,'1','admission','STUDENT ID','AdmisiÃ³n','à¦¸à§à¦¬à§€à¦•à¦¾à¦°à§‹à¦•à§à¦¤à¦¿','Admission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(130,'1','class_Sec','Class (Sec.)','Clase (Sec.)','à¦•à§à¦²à¦¾à¦¸ (à¦¸à§‡à¦•à§‡à¦¨à§à¦¡)','Classe (Sec.)',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(131,'1','father','Father','Padre','à¦ªà¦¿à¦¤à¦¾','PÃ¨re',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(132,'1','date_of_birth','Date Of Birth','Fecha de nacimiento','à¦œà¦¨à§à¦® à¦¤à¦¾à¦°à¦¿à¦–','Date de naissance',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(133,'1','gender','Gender','GÃ©nero','à¦²à¦¿à¦™à§à¦—','Le sexe',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(134,'1','mobile','Mobile','MÃ³vil','à¦®à§à¦ à§‹à¦«à§‹à¦¨','Mobile',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(135,'1','student_id_card','Student ID Card','Credencial de estudiante','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦†à¦‡à¦¡à¦¿ à¦•à¦¾à¦°à§à¦¡','Carde didentitÃ© dÃ©tudiant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(136,'1','id_card_title','ID Card Title','TÃ­tulo de la tarjeta de identificaciÃ³n','à¦†à¦‡à¦¡à¦¿ à¦•à¦¾à¦°à§à¦¡à§‡à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre de la carte didentitÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(137,'1','number','Number','NÃºmero','à¦¸à¦‚à¦–à§à¦¯à¦¾','Nombre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(138,'1','mother','Mother','Madre','à¦®à¦¾','MÃ¨re',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(139,'1','blood_group','Blood Group','Grupo sanguÃ­neo','à¦°à¦•à§à¦¤à§‡à¦° à¦—à§à¦°à§à¦ª','Groupe sanguin',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(140,'1','id_card','ID Card','Tarjeta de identificaciÃ³n','à¦ªà¦°à¦¿à¦šà¦¯à¦¼ à¦ªà¦¤à§à¦°','Carte didentitÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(141,'1','generate_id_card','Generate ID Card','Generar tarjeta de identificaciÃ³n','à¦†à¦‡à¦¡à¦¿ à¦•à¦¾à¦°à§à¦¡ à¦¤à§ˆà¦°à¦¿ à¦•à¦°à§à¦¨','GÃ©nÃ©rer une carte didentitÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(142,'1','all','All','Todos','à¦¸à¦¬','Tout',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(143,'1','relation_with_guardian','Relation with Guardian','RelaciÃ³n con Guardian','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à§‡à¦° à¦¸à¦¾à¦¥à§‡ à¦¸à¦®à§à¦ªà¦°à§à¦•','Relation avec le gardien',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(144,'1','admin','Admin','AdministraciÃ³n','à¦…à§à¦¯à¦¾à¦¡à¦®à¦¿à¦¨','Admin',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(145,'1','follow_up','Follow up','Seguir','à¦…à¦¨à§à¦¸à¦°à¦£ à¦•à¦°à§à¦¨','Suivre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(146,'1','follow_up_admission_query','Follow Up Admission Query','Consulta de seguimiento de admisiÃ³n','à¦­à¦°à§à¦¤à¦¿ à¦ªà§à¦°à¦¶à§à¦¨ à¦…à¦¨à§à¦¸à¦°à¦£ à¦•à¦°à§à¦¨','RequÃªte dadmission de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(147,'1','response','Response','Respuesta','à¦ªà§à¦°à¦¤à¦¿à¦•à§à¦°à¦¿à¦¯à¦¼à¦¾','RÃ©ponse',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(148,'1','follow_up_list','Follow Up List','Lista de seguimiento','à¦«à¦²à§‹ à¦†à¦ª à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(149,'1','query_by','Query By','Consulta por','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦¦à§à¦¬à¦¾à¦°à¦¾','RequÃªte par',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(150,'1','delete_follow_up_query','Delete Follow up query','Eliminar consulta de seguimiento','à¦«à¦²à§‹ à¦†à¦ª à¦•à§‹à¦¯à¦¼à§‡à¦°à¦¿ à¦®à§à¦›à§à¦¨','Supprimer la requÃªte de suivi',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(151,'1','certificate_body_len','Max Character lenght 500','Longitud mÃ¡xima de caracteres 500','à¦¸à¦°à§à¦¬à§‹à¦šà§à¦š à¦…à¦•à§à¦·à¦° 500 à¦¦à§ˆà¦°à§à¦˜à§à¦¯ 500','Longueur maximum 500 caractÃ¨res',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(152,'1','class_section','Class (Sec.)','Clase (Sec.)','à¦•à§à¦²à¦¾à¦¸ (à¦¸à§‡à¦•à§‡à¦¨à§à¦¡)','Classe (Sec.)',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(153,'1','are_you_sure_to_remove','Are you sure to remove this item?','Â¿EstÃ¡s seguro de eliminar este elemento?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦†à¦‡à¦Ÿà§‡à¦®à¦Ÿà¦¿ à¦¸à¦°à¦¾à¦¨à§‹à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de vouloir supprimer cet article?',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(154,'1','admission_no','STUDENT ID','Admission No','à¦­à¦°à§à¦¤à¦¿ à¦¨à¦‚','Admission No',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(155,'1','no','No','No','à¦¨à¦¾','No',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(156,'1','fill_marks','Fill Marks','Fill Marks','à¦šà¦¿à¦¹à§à¦¨ à¦ªà§‚à¦°à¦£ à¦•à¦°à§à¦¨','Fill Marks',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(157,'1','main','Main','Main','à¦ªà§à¦°à¦§à¦¾à¦¨','Main',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(158,'1','duration','Duration','Duration','à¦¸à§à¦¥à¦¿à¦¤à¦¿à¦•à¦¾à¦²','Duration',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(159,'1','approve','Approve','Approve','à¦…à¦¨à§à¦®à§‹à¦¦à¦¨ à¦•à¦°à¦¾','Approve',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(160,'1','user_name','User Name','User Name','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦•à¦¾à¦°à§€à¦° à¦¨à¦¾à¦®','User Name',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(161,'1','rate','Rate','Rate','à¦¹à¦¾à¦°','Rate',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(162,'1','hourly_rate','Hourly Rate','Hourly Rate','à¦ªà§à¦°à¦¤à¦¿ à¦˜à¦£à§à¦Ÿà¦¾à¦° à¦®à§‚à¦²à§à¦¯','Hourly Rate',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(163,'1','add_new_staff','Add New Staff','Add New Staff','à¦¨à¦¤à§à¦¨ à¦¸à§à¦Ÿà¦¾à¦« à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Add New Staff',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(164,'1','first_name','First Name','First Name','à¦¨à¦¾à¦®à§‡à¦° à¦ªà§à¦°à¦¥à¦® à¦…à¦‚à¦¶','First Name',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(165,'1','last_name','Last Name','Last Name','à¦¨à¦¾à¦®à§‡à¦° à¦¶à§‡à¦·à¦¾à¦‚à¦¶','Last Name',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(166,'1','married','Married','Married','à¦¬à¦¿à¦¬à¦¾à¦¹à¦¿à¦¤','Married',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(167,'1','unmarried','Unmarried','Unmarried','à¦…à¦¬à¦¿à¦¬à¦¾à¦¹à¦¿à¦¤','Unmarried',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(168,'1','marital_status','Marital Status','Marital Status','à¦¬à§ˆà¦¬à¦¾à¦¹à¦¿à¦• à¦…à¦¬à¦¸à§à¦¥à¦¾','Marital Status',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(169,'1','driving_license','Driving License','Driving License','à¦¡à§à¦°à¦¾à¦‡à¦­à¦¿à¦‚ à¦²à¦¾à¦‡à¦¸à§‡à¦¨à§à¦¸','Driving License',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(170,'1','contract','Contract','Contract','à¦šà§à¦•à§à¦¤à¦¿','Contract',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(171,'1','crop','Crop','Crop','à¦«à¦¸à¦²','Crop',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(172,'1','crop_image_and_upload','Crop Image And Upload','Crop Image And Upload','à¦šà¦¿à¦¤à§à¦° à¦•à§à¦°à¦ª à¦•à¦°à§à¦¨ à¦à¦¬à¦‚ à¦†à¦ªà¦²à§‹à¦¡ à¦•à¦°à§à¦¨','Crop Image And Upload',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(173,'1','staff_ID','Staff ID','Staff ID','à¦¸à§à¦Ÿà¦¾à¦« à¦†à¦‡à¦¡à¦¿','Staff ID',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(174,'1','for_the_period_of','for the period of','for the period of','à¦¸à¦®à¦¯à¦¼à§‡à¦° à¦œà¦¨à§à¦¯','for the period of',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(175,'1','evaluated_by','Evaluated By','Evaluated By','à¦®à§‚à¦²à§à¦¯à¦¾à¦¯à¦¼à¦¨ à¦¦à§à¦¬à¦¾à¦°à¦¾','Evaluated By',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(176,'1','summary','Summary','Summary','à¦¸à¦¾à¦°à¦¸à¦‚à¦•à§à¦·à§‡à¦ª','Summary',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(177,'1','good','Good','Good','à¦­à¦¾à¦²','Good',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(178,'1','not','Not','Not','à¦¨à¦¾','Not',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(179,'1','comments','Comments','Comments','à¦®à¦¨à§à¦¤à¦¬à§à¦¯','Comments',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(180,'1','roll_number','Student ID','Roll Number','à¦°à§‹à¦² à¦¨à¦¾à¦®à§à¦¬à¦¾à¦°','Roll Number',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(181,'1','cash','Cash','Cash','à¦¨à¦—à¦¦','Cash',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(182,'1','cheque','Cheque','Cheque','à¦šà§‡à¦•','Cheque',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(183,'1','dd','DD','DD','à¦¡à¦¿à¦¡à¦¿','DD',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(184,'1','please_give_the_all_information_properly','Please Give the All Information Properly. We can not Save any of Your Data. Your Safety is our First Priority','Please Give the All Information Properly. We can not Save any of Your Data. Your Safety is our First Priority','à¦¦à¦¯à¦¼à¦¾ à¦•à¦°à§‡ à¦¸à¦®à¦¸à§à¦¤ à¦¤à¦¥à§à¦¯ à¦¸à¦ à¦¿à¦•à¦­à¦¾à¦¬à§‡ à¦¦à¦¿à¦¨à¥¤ à¦†à¦®à¦°à¦¾ à¦†à¦ªà¦¨à¦¾à¦° à¦•à§‹à¦¨à¦“ à¦¡à§‡à¦Ÿà¦¾ à¦¸à¦‚à¦°à¦•à§à¦·à¦£ à¦•à¦°à¦¤à§‡ à¦ªà¦¾à¦°à¦¿ à¦¨à¦¾à¥¤ à¦†à¦ªà¦¨à¦¾à¦° à¦¸à§à¦°à¦•à§à¦·à¦¾ à¦†à¦®à¦¾à¦¦à§‡à¦° à¦ªà§à¦°à¦¥à¦® à¦…à¦—à§à¦°à¦¾à¦§à¦¿à¦•à¦¾à¦°','Please Give the All Information Properly. We can not Save any of Your Data. Your Safety is our First Priority',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(185,'1','expiration','Expiration','Expiration','à¦¶à§à¦¬à¦¾à¦¸à¦¤à§à¦¯à¦¾à¦—','Expiration',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(186,'1','cvc','CVC','CVC','à¦¸à¦¿à¦­à¦¿à¦¸à¦¿','CVC',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(187,'1','card_number','Card Number','Card Number','à¦•à¦¾à¦°à§à¦¡ à¦¨à¦®à§à¦¬à¦°','Card Number',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(188,'1','name_on_card','Name on Card','Name on Card','à¦•à¦¾à¦°à§à¦¡à§‡à¦° à¦“à¦ªà¦° à¦¨à¦¾à¦®','Name on Card',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(189,'1','vai_card','vai Card','vai Card','à¦­à¦¾à¦‡ à¦•à¦¾à¦°à§à¦¡','vai Card',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(190,'1','pay_with','Pay with','Pay with','à¦¸à¦™à§à¦—à§‡ à¦¦à¦¿à¦¤à§‡','Pay with',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(191,'1','pay','Pay','Pay','Pay','Pay',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(192,'1','cvc','cvc','cvc','cvc','cvc',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(193,'1','fees','Fees','Fees','à¦«à¦¿','Fees',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(194,'1','all_fees','All Fees','All Fees','à¦¸à¦®à¦¸à§à¦¤ à¦«à¦¿','All Fees',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(195,'1','online','Online','Online','à¦…à¦¨à¦²à¦¾à¦‡à¦¨','Online',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(196,'1','assign_exam_room','Assign Exam Room','Assign Exam Room','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦˜à¦° à¦¬à¦°à¦¾à¦¦à§à¦¦ à¦•à¦°à§à¦¨','Assign Exam Room',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(197,'1','level','Level','Level','à¦‰à¦šà§à¦šà¦¤à¦¾','Level',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(198,'1','question_level','Question Level','Question Level','à¦ªà§à¦°à¦¶à§à¦¨ à¦¸à§à¦¤à¦°','Question Level',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(199,'1','update_online_exam_question','Update Online Exam Question','Update Online Exam Question','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦ªà§à¦°à¦¶à§à¦¨ à¦†à¦ªà¦¡à§‡à¦Ÿ à¦•à¦°à§à¦¨','Update Online Exam Question',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(200,'1','number_options','Number Options','Number Options','à¦¸à¦‚à¦–à§à¦¯à¦¾ à¦¬à¦¿à¦•à¦²à§à¦ª','Number Options',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(201,'1','currect_answer','Currect Answer','Currect Answer','à¦•à¦¾à¦°à§‡à¦¨à§à¦Ÿ à¦‰à¦¤à§à¦¤à¦°','Currect Answer',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(202,'1','currect','Currect','Currect','Currect','Currect',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(203,'1','exam_has_to_be_submitted_within','Exam Has To Be Submitted Within','Exam Has To Be Submitted Within','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦®à¦§à§à¦¯à§‡ à¦œà¦®à¦¾ à¦¦à¦¿à¦¤à§‡ à¦¹à¦¬à§‡','Exam Has To Be Submitted Within',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(204,'1','is_present','Is Present','Is Present','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤','Is Present',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(205,'1','roll_no','Roll No','Roll No','à¦•à§à¦°à¦®à¦¿à¦• à¦¨à¦¾à¦®à§à¦¬à¦¾à¦°','Roll No',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(206,'1','button_url','Button Url','Button Url','à¦¬à¦¾à¦Ÿà¦¨ à¦‡à¦‰à¦†à¦°','Button Url',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(207,'1','button_text','Button Text','Button Text','à¦¬à§‹à¦¤à¦¾à¦® à¦ªà¦¾à¦ à§à¦¯','Button Text',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(208,'1','course','Course','Course','à¦ªà¦¥','Course',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(209,'1','update_course_heading_section','Update Course Heading Section','Update Course Heading Section','à¦•à§‹à¦°à§à¦¸ à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦® à¦¬à¦¿à¦­à¦¾à¦— à¦†à¦ªà¦¡à§‡à¦Ÿ à¦•à¦°à§à¦¨','Update Course Heading Section',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(210,'1','stats','Stats','Stats','à¦ªà¦°à¦¿à¦¸à¦‚à¦–à§à¦¯à¦¾à¦¨','Stats',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(211,'1','resources','Resources','Resources','à¦¸à¦®à§à¦ªà¦¦','Resources',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(212,'1','prerequisites','Prerequisites','Prerequisites','à¦ªà§‚à¦°à§à¦¬à¦¶à¦°à§à¦¤','Prerequisites',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(213,'1','outline','Outline','Outline','à¦°à§‚à¦ªà¦°à§‡à¦–à¦¾','Outline',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(214,'1','overview','Overview','Overview','à¦¸à¦‚à¦•à§à¦·à¦¿à¦ªà§à¦¤ à¦¬à¦¿à¦¬à¦°à¦£','Overview',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(215,'1','export_to_csv','Export to CSV','Export to CSV','à¦¸à¦¿à¦à¦¸à¦­à¦¿à¦¤à§‡ à¦°à¦«à¦¤à¦¾à¦¨à¦¿ à¦•à¦°à§à¦¨','Export to CSV',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(216,'1','export_to_excel','Export to Excel','Export to Excel','à¦à¦•à§à¦¸à§‡à¦²à§‡ à¦°à¦«à¦¤à¦¾à¦¨à¦¿ à¦•à¦°à§à¦¨','Export to Excel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(217,'1','export_to_pdf','Export to PDF','Export to PDF','à¦ªà¦¿à¦¡à¦¿à¦à¦« à¦°à¦«à¦¤à¦¾à¦¨à¦¿ à¦•à¦°à§à¦¨','Export to PDF',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(218,'1','copy_table','Copy Table','Copy Table','à¦Ÿà§‡à¦¬à¦¿à¦² à¦…à¦¨à§à¦²à¦¿à¦ªà¦¿ à¦•à¦°à§à¦¨','Copy Table',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(219,'1','visibility','Visibility','visibility','à¦¦à§ƒà¦·à§à¦Ÿà¦¿à¦ªà¦¾à¦¤','visibility',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(220,'1','column_view','Column View','Column View','à¦•à¦²à¦¾à¦® à¦­à¦¿à¦‰','Column View',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(221,'1','student_name','Student Name','Student Name','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦° à¦¨à¦¾à¦®','Student Name',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(222,'1','is_published_web_site','Is Published Web Site','Is Published Web Site','à¦ªà§à¦°à¦•à¦¾à¦¶à¦¿à¦¤ à¦“à¦¯à¦¼à§‡à¦¬ à¦¸à¦¾à¦‡à¦Ÿ','Is Published Web Site',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(223,'10','home_work','HomeWork','Deberes','à¦¬à¦¾à¦¡à¦¼à¦¿à¦° à¦•à¦¾à¦œ','Devoirs',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(224,'10','add_homework','Add Homework','AÃ±adir tarea','à¦¹à§‹à¦®à¦“à¦¯à¦¼à¦¾à¦°à§à¦• à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter des devoirs',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(225,'10','homework_list','Homework List','Lista de tareas','à¦¹à§‹à¦®à¦“à¦¯à¦¼à¦¾à¦°à§à¦• à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de devoirs',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(226,'10','evaluation_report','Homework Evaluation Report','Informe de evaluaciÃ³n de tareas','à¦¹à§‹à¦® à¦“à¦¯à¦¼à¦¾à¦°à§à¦• à¦®à§‚à¦²à§à¦¯à¦¾à¦¯à¦¼à¦¨ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport dÃ©valuation des devoirs',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(227,'10','submission','Submission','SumisiÃ³n','à¦¨à¦®à¦¨','Soumission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(228,'10','attach_file','Attach File','Adjuntar archivo','à¦«à¦¾à¦‡à¦² à¦¸à¦‚à¦¯à§à¦•à§à¦¤','PiÃ¨ce jointe',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(229,'10','evaluation','Evaluation','EvaluaciÃ³n','à¦®à§‚à¦²à§à¦¯à¦¾à¦¯à¦¼à¦¨','Ã‰valuation',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(230,'10','created_by','Created By','Creado por','à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦¸à§ƒà¦·à§à¦Ÿà¦¿','CrÃ©Ã© par',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(231,'10','complete','Complete','Completar','à¦¸à¦®à§à¦ªà§‚à¦°à§à¦£','AchevÃ©e',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(232,'10','incomplete','Incomplete','Incompleto','à¦…à¦¸à¦®à§à¦ªà§‚à¦°à§à¦£','Incomplet',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(233,'11','notice_board','Notice Board','TablÃ³n de anuncios','à¦¨à§‹à¦Ÿà¦¿à¦¸à¦¬à§‹à¦°à§à¦¡','Tableau daffichage',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(234,'11','for_whom','For Whom','for whom','','',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(235,'11','send_message','Send Message','Enviar mensaje','à¦¬à¦¾à¦°à§à¦¤à¦¾ à¦ªà¦¾à¦ à¦¾à¦¨','Envoyer le message',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(236,'11','send_email','Send Email / Sms','Enviar correo electrÃ³nico / SMS','à¦‡à¦®à§‡à¦² / à¦à¦¸à¦à¦®à¦à¦¸ à¦ªà§à¦°à§‡à¦°à¦£ à¦•à¦°à§à¦¨','Envoyer un email / sms',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(237,'11','email_sms_log','Email / Sms Log','Email / Sms Log','à¦‡à¦®à§‡à¦² / à¦à¦¸à¦à¦®à¦à¦¸ à¦²à¦—','Journal Email / Sms',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(238,'11','event','Event','Evento','à¦˜à¦Ÿà¦¨à¦¾','un Ã©vÃ©nement',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(239,'11','notices','Notices','Avisos','à¦¨à§‹à¦Ÿà¦¿à¦¶','Les avis',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(240,'11','notice','Notice','darse cuenta','à¦¬à¦¿à¦œà§à¦žà¦ªà§à¦¤à¦¿','Remarquer',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(241,'11','publish','Publish','Publicar','à¦ªà§à¦°à¦•à¦¾à¦¶ à¦•à¦°à¦¾','Publier',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(242,'11','add_notice','Add Notice','AÃ±adir aviso','à¦¬à¦¿à¦œà§à¦žà¦ªà§à¦¤à¦¿ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter un avis',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(243,'11','add_a_notice','Add a Notice','AÃ±adir un aviso','à¦à¦•à¦Ÿà¦¿ à¦¨à§‹à¦Ÿà¦¿à¦¶ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter un avis',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(244,'11','publish_on','Publish On','Publicar en','à¦ªà§à¦°à¦•à¦¾à¦¶ à¦•à¦°à§à¦¨','Publier sur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(245,'11','Send_Email_Sms','Send Email','Enviar correo electrÃ³nico','à¦‡à¦®à§‡à¦‡à¦² à¦ªà¦¾à¦ à¦¾à¦¨','Envoyer un email',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(246,'11','sms','SMS','SMS','à¦–à§à¦¦à§‡à¦¬à¦¾à¦°à§à¦¤à¦¾','SMS',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(247,'11','individual','Individual','Individual','à¦¸à§à¦¬à¦¤à¦¨à§à¦¤à§à¦°','Individuel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(248,'11','select_all','Select All','Seleccionar todo','à¦¸à¦®à¦¸à§à¦¤ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Tout sÃ©lectionner',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(249,'11','For_Sending_Email','For Sending Email / Sms, It may take some seconds. So please take patience.','Para enviar correo electrÃ³nico / SMS, puede tardar unos segundos. AsÃ­ que por favor ten paciencia.','à¦‡à¦®à§‡à¦² / à¦à¦¸à¦à¦®à¦à¦¸ à¦ªà§à¦°à§‡à¦°à¦£à§‡à¦° à¦œà¦¨à§à¦¯, à¦à¦Ÿà¦¿ à¦•à¦¯à¦¼à§‡à¦• à¦¸à§‡à¦•à§‡à¦¨à§à¦¡ à¦¸à¦®à¦¯à¦¼ à¦¨à¦¿à¦¤à§‡ à¦ªà¦¾à¦°à§‡à¥¤ à¦¤à¦¾à¦‡ à¦¦à¦¯à¦¼à¦¾ à¦•à¦°à§‡ à¦§à§ˆà¦°à§à¦¯ à¦§à¦°à§à¦¨à¥¤','Pour lenvoi demails / sms, cela peut prendre quelques secondes. Alors sil vous plaÃ®t prenez patience.',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(250,'11','send','Send','Enviar','à¦ªà¦¾à¦ à¦¾à¦¨','Envoyer',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(251,'11','start_date','Start Date','Fecha de inicio','à¦¶à§à¦°à§à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date de dÃ©but',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(252,'11','to_date','To Date','Hasta la fecha','à¦à¦–à¦¨ à¦ªà¦°à§à¦¯à¦¨à§à¦¤','Ã€ ce jour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(253,'11','from_date','from Date','partir de la fecha','à¦¤à¦¾à¦°à¦¿à¦– à¦¹à¦‡à¦¤à§‡','partir de la date',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(254,'11','details','Details','Detalles','à¦¬à¦¿à¦¸à§à¦¤à¦¾à¦°à¦¿à¦¤','DÃ©tails',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(255,'11','notice_date','Notice Date','Fecha de notificacion','à¦¨à§‹à¦Ÿà¦¿à¦¶ à¦¤à¦¾à¦°à¦¿à¦–','Date davis',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(256,'11','update_content','Update content','Actualizar contenido','à¦¸à¦¾à¦®à¦—à§à¦°à§€ à¦†à¦ªà¦¡à§‡à¦Ÿ à¦•à¦°à§à¦¨','Mettre Ã  jour le contenu',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(257,'11','communicate','Communicate','Comunicar','à¦¯à§‹à¦—à¦¾à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Communiquer',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(258,'12','library','Library','Biblioteca','à¦—à§à¦°à¦¨à§à¦¥à¦¾à¦—à¦¾à¦°','BibliothÃ¨que',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(259,'12','add_book','Add Book','AÃ±adir libro','à¦¬à¦‡ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter un livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(260,'12','book_list','Book List','Lista de libros','à¦¬à¦‡à¦à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de livres',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(261,'12','book_category','Book Categories','CategorÃ­as de libros','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¬à¦¿à¦­à¦¾à¦—','CatÃ©gories de livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(262,'12','library_member','Add Member','AÃ±adir miembro','à¦¸à¦¦à¦¸à§à¦¯ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter un membre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(263,'12','member_list','Issue/Return Book','Libro de emisiÃ³n / devoluciÃ³n','à¦‡à¦¸à§à¦¯à§ / à¦°à¦¿à¦Ÿà¦¾à¦°à§à¦¨ à¦¬à¦‡','Livre dÃ©mission / retour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(264,'12','all_issued_book','All Issued Book','Todo el libro publicado','à¦¸à¦®à¦¸à§à¦¤ à¦‡à¦¸à§à¦¯à§ à¦•à¦°à¦¾ à¦¬à¦‡','Tous les livres publiÃ©s',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(265,'12','edit_book','Edit Book','Editar libro','à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨à¦¾ à¦¬à¦‡','Editer le livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(266,'12','book','Book','Libro','à¦¬à¦‡','Livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(267,'12','book_title','Book Title','Titulo del libro','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre de livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(268,'12','select_book_category','Select Book Category','Seleccionar categorÃ­a de libro','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez une catÃ©gorie de livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(269,'12','isbn','ISBN','ISBN','à¦†à¦‡à¦à¦¸à¦¬à¦¿à¦à¦¨','ISBN',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(270,'12','publisher','Publisher','Editor','à¦ªà§à¦°à¦•à¦¾à¦¶à¦•','Ã‰diteur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(271,'12','author_name','Author Name','Nombre del autor','à¦²à§‡à¦–à¦•à§‡à¦° à¦¨à¦¾à¦®','Nom de lauteur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(272,'12','rack','Rack','Estante','à¦¤à¦¾à¦•','Grille',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(273,'12','quantity','Quantity','Cantidad','à¦ªà¦°à¦¿à¦®à¦¾à¦£','QuantitÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(274,'12','book_price','Book Price','Precio del libro','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¦à¦¾à¦®','Prix â€‹â€‹du livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(275,'12','price','Price','Precio','à¦®à§‚à¦²à§à¦¯','Prix',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(276,'12','category_name','Category Name','nombre de la categorÃ­a','à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¾à¦®','Nom de catÃ©gorie',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(277,'12','add_member','Add Member','AÃ±adir miembro','à¦¸à¦¦à¦¸à§à¦¯ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter un membre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(278,'12','member','Member','Miembro','à¦¸à¦¦à¦¸à§à¦¯','Membre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(279,'12','member_type','Member Type','Tipo de miembro','à¦¸à¦¦à¦¸à§à¦¯à§‡à¦° à¦ªà§à¦°à¦•à¦¾à¦°','Type de membre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(280,'12','select_student','Select Student','Seleccionar estudiante','à¦›à¦¾à¦¤à§à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez Ã©tudiant',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(281,'12','issue_books','Issue Books','Libros de emisiÃ³n','à¦¬à¦‡ à¦‡à¦¸à§à¦¯à§','Livres de questions',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(282,'12','full_name','Full Name','Nombre completo','à¦ªà§à¦°à§‹ à¦¨à¦¾à¦®','Nom complet',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(283,'12','issue_return_Book','Issue / Return Book','Libro de emisiÃ³n / devoluciÃ³n','à¦‡à¦¸à§à¦¯à§ / à¦°à¦¿à¦Ÿà¦¾à¦°à§à¦¨ à¦¬à¦‡','Livre dÃ©mission / retour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(284,'12','issued_Book_List','Issued Book List','Lista de libros emitidos','à¦œà¦¾à¦°à¦¿ à¦•à¦°à¦¾ à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des livres publiÃ©s',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(285,'12','select_Book_Name','Select Book Name','Seleccione el nombre del libro','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¨à¦¾à¦® à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez le nom du livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(286,'12','search_By_Book_ID','Search By Book ID','Buscar por ID de libro','à¦¬à§à¦• à¦†à¦‡à¦¡à¦¿ à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦•à¦°à§à¦¨','Rechercher par numÃ©ro de livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(287,'12','author','Author','Autor','à¦²à§‡à¦–à¦•','Auteur',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(288,'12','library_book_issue','Library Book Issue','NÃºmero de libro de la biblioteca','à¦²à¦¾à¦‡à¦¬à§à¦°à§‡à¦°à¦¿à¦° à¦¬à¦‡ à¦‡à¦¸à§à¦¯à§','ProblÃ¨me de livre de bibliothÃ¨que',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(289,'12','staff_name','Staff Name','Nombre del personal','à¦¸à§à¦Ÿà¦¾à¦« à¦¨à¦¾à¦®','Nom du personnel',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(290,'12','select_book','Select Book','Seleccionar libro','à¦¬à¦‡ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(291,'12','issue_book','Issue Book','Libro de temas','à¦‡à¦¸à§à¦¯à§ à¦¬à§à¦•','NumÃ©ro de livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(292,'12','issued_book','Issued Book','Libro publicado','à¦‡à¦¸à§à¦¯à§ à¦•à¦°à¦¾ à¦¬à¦‡','Livre publiÃ©',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(293,'12','book_number','Book Number','NÃºmero de libro','à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¨à¦®à§à¦¬à¦°','NumÃ©ro du livre',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(294,'12','status','Status','Estado','à¦…à¦¬à¦¸à§à¦¥à¦¾','Statut',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(295,'12','issue_date','Issue Date','Fecha de asunto','à¦ªà§à¦°à¦¦à¦¾à¦¨à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date dÃ©mission',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(296,'12','return_this_book','Are you sure to Return This Book ?','Â¿Seguro que regresas este libro?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦¬à¦‡à¦Ÿà¦¿ à¦«à§‡à¦°à¦¤ à¦¦à§‡à¦“à¦¯à¦¼à¦¾à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de retourner ce livre?',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(297,'12','return_date','Return Date','Fecha de regreso','à¦«à§‡à¦°à¦¾à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date de retour',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(298,'13','inventory','Inventory','Inventario','à¦œà¦¾à¦¯à¦¼','Inventaire',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(299,'13','item_category','Item Category','CategorÃ­a de artÃ­culo','à¦†à¦‡à¦Ÿà§‡à¦® à¦¬à¦¿à¦­à¦¾à¦—','CatÃ©gorie darticle',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(300,'13','item_list','Item List','Lista de articulos','à¦‰à¦ªà¦•à¦°à¦£ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des articles',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(301,'13','item_store','Item Store','Tienda de articulos','à¦†à¦‡à¦Ÿà§‡à¦® à¦¸à§à¦Ÿà§‹à¦°','Magasin darticles',1,'2020-08-10 05:58:19','2020-08-10 05:58:19'),(302,'13','supplier','Supplier','Proveedor','à¦¸à¦°à¦¬à¦°à¦¾à¦¹à¦•à¦¾à¦°à§€','Fournisseur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(303,'13','item_receive','Item Receive','El artÃ­culo recibe','à¦†à¦‡à¦Ÿà§‡à¦® à¦°à¦¿à¦¸à¦¿à¦­','Point recevoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(304,'13','item_receive_list','Item Receive List','Lista de artÃ­culos recibidos','à¦†à¦‡à¦Ÿà§‡à¦®à§‡à¦° à¦ªà§à¦°à¦¾à¦ªà§à¦¤à¦¿à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Item Receive List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(305,'13','item_sell','Item Sell','Venta de artÃ­culos','à¦†à¦‡à¦Ÿà§‡à¦® à¦¬à¦¿à¦•à§à¦°à¦¯à¦¼','Article Vendre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(306,'13','item_issue','Item Issue','EmisiÃ³n del artÃ­culo','à¦†à¦‡à¦Ÿà§‡à¦® à¦‡à¦¸à§à¦¯à§','Question darticle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(307,'13','select_item_category','Select Item Category','Seleccione la categorÃ­a del artÃ­culo','à¦†à¦‡à¦Ÿà§‡à¦® à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner une catÃ©gorie darticle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(308,'13','selected','Selected','Seleccionado','à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¿à¦¤','Choisi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(309,'13','total_in_stock','Total in Stock','Total en Stock','à¦®à§‹à¦Ÿ à¦¸à§à¦Ÿà¦•','Total en stock',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(310,'13','store_name','Store Name','Nombre de la tienda','à¦¦à§‹à¦•à¦¾à¦¨à§‡à¦° à¦¨à¦¾à¦®','Nom du magasin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(311,'13','store_number','Store Number','NÃºmero de tienda','à¦¸à§à¦Ÿà§‹à¦° à¦¨à¦®à§à¦¬à¦°','NumÃ©ro de magasin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(312,'13','company','Company','Empresa','à¦ªà§à¦°à¦¤à¦¿à¦·à§à¦ à¦¾à¦¨','Entreprise',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(313,'13','contact_person_name','Contact Person Name','Nombre del Contacto','à¦¯à§‹à¦—à¦¾à¦¯à§‹à¦— à¦¬à§à¦¯à¦•à§à¦¤à¦¿à¦° à¦¨à¦¾à¦®','nom de contacte dune personne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(314,'13','contact_person','Contact Person','Persona de contacto','à¦¯à§‹à¦—à¦¾à¦¯à§‹à¦—','Contact',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(315,'13','receive_details','Receive Details','Recibir detalles','à¦¬à¦¿à¦¶à¦¦ à¦—à§à¦°à¦¹à¦£ à¦•à¦°à§à¦¨','Recevoir les dÃ©tails',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(316,'13','select_supplier','Select Supplier','Seleccionar Proveedor','à¦¸à¦°à¦¬à¦°à¦¾à¦¹à¦•à¦¾à¦°à§€ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner un fournisseur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(317,'13','receive_date','Receive Date','Fecha de recepciÃ³n','à¦—à§à¦°à¦¹à¦£à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','date de rÃ©ception',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(318,'13','product_name','Product Name','nombre del producto','à¦ªà¦£à§à¦¯à§‡à¦° à¦¨à¦¾à¦®','Nom du produit',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(319,'13','unit_price','Unit Price','Precio unitario','à¦à¦•à¦• à¦¦à¦¾à¦®','Prix â€‹â€‹unitaire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(320,'13','sub_total','Sub Total','Sub Total','à¦¸à¦¾à¦¬ à¦Ÿà§‹à¦Ÿà¦¾à¦²','Total partiel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(321,'13','full_paid','Full Paid','Completo pagado','à¦«à§à¦² à¦ªà§‡à¦‡à¦¡','Complet payÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(322,'13','total_paid','Total Paid','Total pagado','à¦ªà§à¦°à¦¾à¦ªà§à¦°à¦¿ à¦ªà¦°à¦¿à¦¶à§‹à¦§à¦¿à¦¤','Total payÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(323,'13','total_due','Total Due','Total a pagar','à¦®à§‹à¦Ÿ à¦¬à¦¾à¦•à¦¿','Total dÃ»',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(324,'13','receive','Receive','Recibir','à¦—à§à¦°à¦¹à¦£ à¦•à¦°à¦¾','Recevoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(325,'13','new','New','Nuevo','à¦¨à¦¤à§à¦¨','Nouveau',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(326,'13','total_quantity','Total Quantity','Cantidad total','à¦®à§‹à¦Ÿ à¦ªà¦°à¦¿à¦®à¦¾à¦£','QuantitÃ© totale',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(327,'13','partial_paid','Partial Paid','Parcial pagado','à¦†à¦‚à¦¶à¦¿à¦• à¦ªà§à¦°à¦¦à§‡à¦¯à¦¼','Partiellement payÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(328,'13','unpaid','Unpaid','No pagado','à¦…à¦¬à§ˆà¦¤à¦¨à¦¿à¦•','Non payÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(329,'13','refund','Refund','Reembolso','à¦ªà§à¦°à¦¤à§à¦¯à¦°à§à¦ªà¦£','Rembourser',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(330,'13','buyer','Buyer','Comprador','à¦•à§à¦°à§‡à¦¤à¦¾','Acheteur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(331,'13','issue_item','Issue Item','Elemento de emisiÃ³n','à¦†à¦‡à¦Ÿà§‡à¦® à¦‡à¦¸à§à¦¯à§ à¦•à¦°à§à¦¨','Point dÃ©mission',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(332,'13','issue_a_item','Issue a Item','Emitir un artÃ­culo','à¦à¦•à¦Ÿà¦¿ à¦†à¦‡à¦Ÿà§‡à¦® à¦‡à¦¸à§à¦¯à§ à¦•à¦°à§à¦¨','Ã‰mettre un article',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(333,'13','user_type','User Type','Tipo de usuario','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦•à¦¾à¦°à§€à¦° à¦§à¦°à¦¨','Type dutilisateur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(334,'13','select_student_for_issue','Select Student For Issue','Seleccionar estudiante para su emisiÃ³n','à¦‡à¦¸à§à¦¯à§ à¦•à¦°à¦¾à¦° à¦œà¦¨à§à¦¯ à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner un Ã©tudiant pour lÃ©dition',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(335,'13','issue_to','Issue To','Emitido a','à¦‡à¦¸à§à¦¯à§ à¦•à¦°à¦¤à§‡','Issue to',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(336,'13','issued_item_list','Issued Item List','Lista de elementos emitidos','à¦œà¦¾à¦°à¦¿ à¦•à¦°à¦¾ à¦†à¦‡à¦Ÿà§‡à¦®à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste darticles publiÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(337,'13','issued','Issued','Emitido','à¦‡à¦¸à§à¦¯à§ à¦•à¦°à¦¾','PubliÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(338,'13','returned','Returned','Devuelto','à¦«à§‡à¦°à§Ž','Revenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(339,'13','cancel_the_record','You are about to cancel the record. This cannot be undone. are you sure?','EstÃ¡s a punto de cancelar el registro. Esto no se puede deshacer. Â¿EstÃ¡s seguro?','à¦†à¦ªà¦¨à¦¿ à¦°à§‡à¦•à¦°à§à¦¡à¦Ÿà¦¿ à¦¬à¦¾à¦¤à¦¿à¦² à¦•à¦°à¦¤à§‡ à¦šà¦²à§‡à¦›à§‡à¦¨à¥¤ à¦à¦Ÿà¦¾ à¦…à¦¸à¦®à§à¦ªà§‚à¦°à§à¦£ à¦¥à¦¾à¦•à¦¤à§‡ à¦ªà¦¾à¦°à§‡ à¦¨à¦¾. à¦¤à§à¦®à¦¿ à¦•à¦¿ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','Vous Ãªtes sur le point dannuler lenregistrement. Ã‡a ne peut pas Ãªtre annulÃ©. Ãªtes-vous sÃ»r?',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(340,'13','return','Return','Regreso','à¦ªà§à¦°à¦¤à§à¦¯à¦¾à¦¬à¦°à§à¦¤à¦¨','Revenir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(341,'13','purchase_details','Purchase Details','Detalles de la compra','à¦•à§à¦°à¦¯à¦¼à§‡à¦° à¦¬à¦¿à¦¶à¦¦','Les dÃ©tails dachat',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(342,'14','transport','Transport','Transporte','à¦ªà¦°à¦¿à¦¬à¦¹à¦¨','Transport',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(343,'14','routes','Routes','Rutas','à¦°à§à¦Ÿ','ItinÃ©raires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(344,'14','vehicle','Vehicle','VehÃ­culo','à¦¬à¦¾à¦¹à¦¨','VÃ©hicule',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(345,'14','assign_vehicle','Assign Vehicle','Asignar vehÃ­culo','à¦¯à¦¾à¦¨à¦¬à¦¾à¦¹à¦¨ à¦¬à¦°à¦¾à¦¦à§à¦¦ à¦•à¦°à§à¦¨','Assigner un vÃ©hicule',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(346,'14','student_transport_report','Student Transport Report','Informe de transporte de estudiantes','à¦›à¦¾à¦¤à§à¦° à¦ªà¦°à¦¿à¦¬à¦¹à¦¨ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport de transport Ã©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(347,'14','transport_route','Transport Route','Ruta de transporte','à¦ªà¦°à¦¿à¦¬à¦¹à¦¨ à¦°à§à¦Ÿ','Route de transport',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(348,'14','route','Route','Ruta','à¦°à§à¦Ÿ','Route',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(349,'14','route_title','Route Title','TÃ­tulo de la ruta','à¦°à§à¦Ÿà§‡à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre de la route',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(350,'14','fare','Fare','Tarifa','à¦­à¦¾à¦¡à¦¼à¦¾','Tarif',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(351,'14','model','Model','Modelo','à¦®à¦¡à§‡à¦²','ModÃ¨le',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(352,'14','year_made','Year Made','AÃ±o hecho','à¦¬à¦›à¦° à¦¤à§ˆà¦°à¦¿','AnnÃ©e de fabrication',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(353,'14','select_driver','Select Driver','Seleccione Driver','à¦¡à§à¦°à¦¾à¦‡à¦­à¦¾à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez le pilote',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(354,'14','license','License','Licencia','à¦²à¦¾à¦‡à¦¸à§‡à¦¨à§à¦¸','Licence',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(355,'14','select_route','Select Route','Seleccione Ruta','à¦°à§à¦Ÿ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un itinÃ©raire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(356,'14','select_vehicle','Select Vehicle','Seleccionar vehiculo','à¦¯à¦¾à¦¨à¦¬à¦¾à¦¹à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Choisir un vÃ©hicule',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(357,'14','father_phone','Fathers Phone','Telefono del padre','à¦¬à¦¾à¦¬à¦¾à¦° à¦«à§‹à¦¨','TÃ©lÃ©phone du pÃ¨re',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(358,'14','mother_name','Mothers Name','Nombre de la madre','à¦®à¦¾à¦¯à¦¼à§‡à¦° à¦¨à¦¾à¦®','Le nom de la mÃ¨re',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(359,'14','mother_phone','Mothers Phone','TelÃ©fono de la madre','à¦®à¦¾à¦¯à¦¼à§‡à¦¦à§‡à¦° à¦«à§‹à¦¨','TÃ©lÃ©phone de la mÃ¨re',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(360,'15','dormitory','Dormitory','Dormitorio','à¦›à¦¾à¦¤à§à¦°à¦¾à¦¬à¦¾à¦¸','Dortoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(361,'15','dormitory_rooms','Dormitory Rooms','Dormitorios','à¦¡à¦°à¦®à§‡à¦Ÿà¦°à¦¿ à¦°à§à¦®','Dortoirs',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(362,'15','room_type','Room Type','Tipo de habitaciÃ³n','à¦˜à¦°à§‡à¦° à¦¬à¦¿à¦¬à¦°à¦£','Type de chambre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(363,'15','student_dormitory_report','Student Dormitory Report','Informe del dormitorio de estudiantes','à¦›à¦¾à¦¤à§à¦° à¦›à¦¾à¦¤à§à¦°à¦¾à¦¬à¦¾à¦¸ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport du dortoir des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(364,'15','number_of_bed','Number Of Bed','Numero de cama','à¦¬à¦¿à¦›à¦¾à¦¨à¦¾ à¦¸à¦‚à¦–à§à¦¯à¦¾','Nombre de lit',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(365,'15','cost_per_bed','Cost Per Bed','Costo por cama','à¦ªà§à¦°à¦¤à¦¿ à¦¬à¦¿à¦›à¦¾à¦¨à¦¾ à¦–à¦°à¦š','CoÃ»t par lit',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(366,'15','no_of_bed','NO. OF BEd','NO. DE LA CAMA','à¦•à§‹à¦¨à¥¤ à¦¬à¦¿à¦à¦¡ à¦à¦°','NON. DE LIT',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(367,'15','dormitory_list','Dormitory List','Lista de dormitorios','à¦†à¦¸à§à¦¤à¦¾à¦¨à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des dortoirs',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(368,'15','boys','Boys','Muchachos','à¦¬à¦¯à¦¼à§‡à¦œ','GarÃ§ons',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(369,'15','girls','Girls','Chicas','à¦—à¦¾à¦°à§à¦²à¦¸','Filles',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(370,'15','intake','Intake','Consumo','à¦˜à§‡à¦°à¦¾ à¦œà¦®à¦¿','Admission',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(371,'15','select_dormitory','Select Dormitory','Dormitorio selecto','à¦¡à¦°à¦®à§‡à¦Ÿà¦°à¦¿ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un dortoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(372,'15','guardian_phone','Guardians Phone','TelÃ©fono del guardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à¦°à¦¾ à¦«à§‹à¦¨','TÃ©lÃ©phone du gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(373,'16','reports','Reports','Informes','à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapports',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(374,'16','student_report','Student Report','Informe del estudiante','à¦›à¦¾à¦¤à§à¦° à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport dÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(375,'16','guardian_report','Guardian Reports','Informes del tutor','à¦—à¦¾à¦°à§à¦¡à¦¿à¦¯à¦¼à¦¾à¦¨ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿà¦¸','Rapports de gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(376,'16','student_history','Student History','Historia del estudiante','à¦›à¦¾à¦¤à§à¦° à¦‡à¦¤à¦¿à¦¹à¦¾à¦¸','Histoire des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(377,'16','student_login_report','Student Login Report','Informe de inicio de sesiÃ³n del estudiante','à¦›à¦¾à¦¤à§à¦° à¦²à¦—à¦‡à¦¨ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de connexion dÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(378,'16','fees_statement','Fees Statement','DeclaraciÃ³n de honorarios','à¦«à¦¿ à¦¬à¦¿à¦¬à§ƒà¦¤à¦¿','RelevÃ© des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(379,'16','balance_fees_report','Balance Fees Report','Informe de comisiones de saldo','à¦¬à§à¦¯à¦¾à¦²à§‡à¦¨à§à¦¸ à¦«à¦¿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Bilan des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(380,'16','transaction_report','Transaction Report','Reporte de transacciÃ³n','à¦²à§‡à¦¨à¦¦à§‡à¦¨ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de transaction',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(381,'16','class_report','Class Report','Informe de clase','à¦•à§à¦²à¦¾à¦¸ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(382,'16','merit_list_report','Merit List Report','Informe de la lista de mÃ©ritos','à¦®à§‡à¦§à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport de liste de mÃ©rite',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(383,'16','online_exam_report','Online Exam Report','Informe de examen en lÃ­nea','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport dexamen en ligne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(384,'16','mark_sheet_report','Mark Sheet Report','Informe de hoja de marcas','à¦®à¦¾à¦°à§à¦• à¦¶à§€à¦Ÿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de feuille de marque',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(385,'16','tabulation_sheet_report','Tabulation Sheet Report','Informe de hoja de tabulaciÃ³n','à¦Ÿà§à¦¯à¦¾à¦¬à§à¦²à§‡à¦¶à¦¨ à¦¶à§€à¦Ÿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de tabulation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(386,'16','student_fine_report','Student Fine Report','Informe de estudiante bien','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦° à¦«à¦¾à¦‡à¦¨ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de lÃ©tudiant bien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(387,'16','user_log','User Log','Registro de usuario','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦•à¦¾à¦°à§€ à¦²à¦—','Journal de lutilisateur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(388,'16','exam_routine','Exam Routine','Rutina de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦°à§à¦Ÿà¦¿à¦¨','Routine dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(389,'16','select_type','Select Type','Seleccione tipo','à¦ªà§à¦°à¦•à¦¾à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner le genre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(390,'16','select_gender','Select Gender','Seleccione gÃ©nero','à¦²à¦¿à¦‚à¦— à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨','SÃ©lectionnez le sexe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(391,'16','nid','NID','NID','à¦œà¦¾à¦¤à§€à¦¯à¦¼ à¦ªà¦°à¦¿à¦šà¦¯à¦¼à¦ªà¦¤à§à¦°','NID',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(392,'16','Birth_Certificate_Number','Birth Certificate Number','NÃºmero de Certificado de Nacimiento','à¦œà¦¨à§à¦® à¦¶à¦‚à¦¸à¦¾à¦ªà¦¤à§à¦° à¦¨à¦®à§à¦¬à¦°','NumÃ©ro Acte de Naissance',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(393,'16','select_admission_year','Select admission Year','Seleccione el aÃ±o de admisiÃ³n','à¦­à¦°à§à¦¤à¦¿ à¦¬à¦›à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez lannÃ©e dadmission',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(394,'16','start_end','Start-End','Inicio fin','à¦¶à§à¦°à§ à¦¶à§‡à¦·','DÃ©but Fin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(395,'16','student_login_info','Student Login Info','InformaciÃ³n de inicio de sesiÃ³n del estudiante','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦²à¦—à¦‡à¦¨ à¦¤à¦¥à§à¦¯','Informations de connexion des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(396,'16','login_info_report','Login Info Report','Informe de informaciÃ³n de inicio de sesiÃ³n','à¦²à¦—à¦‡à¦¨ à¦¤à¦¥à§à¦¯ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Login Info Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(397,'16','username','Username','Nombre de usuario','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦•à¦¾à¦°à§€à¦° à¦¨à¦¾à¦®','Nom dutilisateur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(398,'16','password','Password','ContraseÃ±a','à¦ªà¦¾à¦¸à¦“à¦¯à¦¼à¦¾à¦°à§à¦¡','Mot de passe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(399,'16','parent','Parent','Padre','à¦®à¦¾à¦¤à¦¾','Parent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(400,'16','reset','Reset','Reiniciar','à¦°à¦¿à¦¸à§‡à¦Ÿ','RÃ©initialiser',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(401,'16','due_date','Due Date','Fecha de vencimiento','à¦¨à¦¿à¦°à§à¦¦à¦¿à¦·à§à¦Ÿ à¦¤à¦¾à¦°à¦¿à¦–','Date dÃ©chÃ©ance',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(402,'16','partial','Partial','Parcial','à¦†à¦‚à¦¶à¦¿à¦•','Partiel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(403,'16','discount_of','Discount of','Descuento de','à¦›à¦¾à¦¡à¦¼','Remise de',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(404,'16','fees_report','Fees Report','Informe de tarifas','à¦«à¦¿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(405,'16','paid_fees','Paid Fees','Honorarios pagados','à¦ªà§à¦°à¦¦à¦¤à§à¦¤ à¦«à¦¿','Frais payÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(406,'16','fees_collection_details','Fees Collection Details','Detalles de la colecciÃ³n','à¦«à¦¿ à¦¸à¦‚à¦—à§à¦°à¦¹à§‡à¦° à¦¬à¦¿à¦¶à¦¦','Frais Collection DÃ©tails',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(407,'16','number_of_student','Number Of Student','Numero de estudiante','à¦›à¦¾à¦¤à§à¦° à¦¸à¦‚à¦–à§à¦¯à¦¾','Nombre dÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(408,'16','total_subjects_assigned','Total Subjects assigned','Total de asignaturas asignadas','à¦¬à¦°à¦¾à¦¦à§à¦¦à¦•à§ƒà¦¤ à¦®à§‹à¦Ÿ à¦¬à¦¿à¦·à¦¯à¦¼','Nombre total de sujets assignÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(409,'16','collection','Collection','ColecciÃ³n','à¦¸à¦‚à¦—à§à¦°à¦¹','Collection',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(410,'16','due','Due','Debido','à¦¬à¦¾à¦•à¦¿','DÃ»',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(411,'16','fees_details','Fees Details','Detalles de tarifas','à¦«à¦¿ à¦¬à¦¿à¦¬à¦°à¦£','DÃ©tails des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(412,'16','class_routine_report','Class Routine Report','Informe de rutina de la clase','à¦•à§à¦²à¦¾à¦¸ à¦°à§à¦Ÿà¦¿à¦¨ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de routine de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(413,'16','report','Report','Informe','à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','rapport',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(414,'16','teacher_class_routine_report','Teacher Class Routine Report','Informe de rutina para el maestro','à¦¶à¦¿à¦•à§à¦·à¦• à¦¶à§à¦°à§‡à¦£à¦¿à¦° à¦°à§à¦Ÿà¦¿à¦¨ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport de routine de classe denseignant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(415,'16','select_teacher','Select Teacher','Seleccionar profesor','à¦¶à¦¿à¦•à§à¦·à¦• à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un enseignant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(416,'16','school_management_system','School Management System','Sistema de gestiÃ³n escolar','à¦¸à§à¦•à§à¦² à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾ à¦¬à§à¦¯à¦¬à¦¸à§à¦¥à¦¾','SystÃ¨me de gestion scolaire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(417,'16','united_states_of_america','House 25, Road 27, Block B, 54th Floor, USA','House 25, Road 27, Block B, Nueva York, USA','à¦¬à¦¾à¦¡à¦¼à¦¿ 25, à¦°à§‹à¦¡ 27, à¦¬à§à¦²à¦• à¦¬à¦¿, 54 à¦¤à¦²à¦¾, à¦®à¦¾à¦°à§à¦•à¦¿à¦¨ à¦¯à§à¦•à§à¦¤à¦°à¦¾à¦·à§à¦Ÿà§à¦°','USA',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(418,'16','order_of_merit_list','Order of merit list','Lista de orden de mÃ©rito','à¦®à§‡à¦§à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾à¦° à¦…à¦°à§à¦¡à¦¾à¦°','Ordre de mÃ©rite',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(419,'16','position','Position','PosiciÃ³n','à¦…à¦¬à¦¸à§à¦¥à¦¾à¦¨','Position',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(420,'16','average','Average','Promedio','à¦—à¦¡à¦¼','Moyenne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(421,'16','obtained_marks','Obtained Marks','Marcas obtenidas','à¦ªà§à¦°à¦¾à¦ªà§à¦¤ à¦¨à¦®à§à¦¬à¦°','Obtenu Marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(422,'16','top_obtained_mark','Top Obtained Mark','Mejor marca obtenida','à¦¶à§€à¦°à§à¦· à¦ªà§à¦°à¦¾à¦ªà§à¦¤ à¦šà¦¿à¦¹à§à¦¨','Top obtenu la marque',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(423,'16','student_terminal_report','Student Terminal Report','Informe de terminal de estudiante','à¦›à¦¾à¦¤à§à¦° à¦Ÿà¦¾à¦°à§à¦®à¦¿à¦¨à¦¾à¦² à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de fin dÃ©tude',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(424,'16','progress_card_report','Progress card report','Informe de progreso','à¦…à¦—à§à¦°à¦—à¦¤à¦¿ à¦•à¦¾à¦°à§à¦¡ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de carte de progression',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(425,'16','position_in_class','Position in Class','PosiciÃ³n en clase','à¦•à§à¦²à¦¾à¦¸à§‡ à¦ªà¦œà¦¿à¦¶à¦¨','Position en classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(426,'16','class_test','Class Test','Prueba de clase','à¦•à§à¦²à¦¾à¦¸ à¦Ÿà§‡à¦¸à§à¦Ÿ','Test de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(427,'16','remarks','Remarks','Observaciones','à¦®à¦¨à§à¦¤à¦¬à§à¦¯','Remarques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(428,'16','user','User','Usuario','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦•à¦¾à¦°à§€','Utilisateur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(429,'16','ip','IP','IP','à¦†à¦‡à¦ªà¦¿','IP',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(430,'16','login_time','Login Time','Hora de inicio de sesiÃ³n','à¦²à¦—à¦‡à¦¨ à¦¸à¦®à¦¯à¦¼','Heure de connexion',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(431,'16','user_agent','User Agent','Agente de usuario','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦¿à¦• à¦¦à§‚à¦¤','Agent utilisateur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(432,'17','authentication','Authentication','AutenticaciÃ³n','à¦ªà§à¦°à¦®à¦¾à¦£à§€à¦•à¦°à¦£','Authentification',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(433,'17','token','Token','SimbÃ³lico','à¦Ÿà§‹à¦•à§‡à¦¨','Jeton',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(434,'17','registered_phone_number','Registered Phone Number','NÃºmero de telÃ©fono registrado','à¦¨à¦¿à¦¬à¦¨à§à¦§à¦¿à¦¤ à¦«à§‹à¦¨ à¦¨à¦®à§à¦¬à¦°','NumÃ©ro de tÃ©lÃ©phone enregistrÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(435,'17','authentication_key_SId','Authentication Key SId','Clave de autenticaciÃ³n SId','à¦ªà§à¦°à¦®à¦¾à¦£à§€à¦•à¦°à¦£ à¦•à§€ à¦à¦¸à¦†à¦‡à¦¡à¦¿','ClÃ© dauthentification SId',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(436,'17','sender','Sender','Remitente','à¦ªà§à¦°à§‡à¦°à¦•à§‡à¦°','ExpÃ©diteur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(437,'17','country_code','Country Code','CÃ³digo de paÃ­s','à¦•à¦¾à¦¨à§à¦Ÿà§à¦°à¦¿ à¦•à§‹à¦¡','Code postal',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(438,'17','select_serial','Select serial','Seleccione serial','à¦¸à¦¿à¦°à¦¿à¦¯à¦¼à¦¾à¦² à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez sÃ©rie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(439,'17','day_list','Day list','Lista de dÃ­as','à¦¦à¦¿à¦¨à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de jour',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(440,'17','serial','Serial','De serie','à¦•à§à¦°à¦®à¦¿à¦•','En sÃ©rie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(441,'17','upload_from_local_directory','Upload From Local Directory','Subir desde el directorio local','à¦¸à§à¦¥à¦¾à¦¨à§€à¦¯à¦¼ à¦¡à¦¿à¦°à§‡à¦•à§à¦Ÿà¦°à¦¿ à¦¥à§‡à¦•à§‡ à¦†à¦ªà¦²à§‹à¦¡ à¦•à¦°à§à¦¨','TÃ©lÃ©charger depuis le rÃ©pertoire local',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(442,'17','file','File','Expediente','à¦«à¦¾à¦‡à¦²','Fichier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(443,'17','cron_secret_key','Cron Secret Key','Clave secreta de Cron','à¦•à§à¦°à§‹à¦¨ à¦¸à¦¿à¦•à§à¦°à§‡à¦Ÿ à¦•à§€','Cron Secret Key',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(444,'17','generate_key','Generate key','Generar clave','à¦•à§€ à¦‰à¦¤à§à¦ªà¦¨à§à¦¨','GÃ©nÃ©rer une clÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(445,'17','database_backup_list','Database Backup List','Lista de respaldo de la base de datos','à¦¡à¦¾à¦Ÿà¦¾à¦¬à§‡à¦¸ à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de sauvegarde de la base de donnÃ©es',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(446,'17','backup','Backup','Apoyo','à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª','Sauvegarde',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(447,'17','created_date_time','Created Date Time','Fecha de creaciÃ³n','à¦¤à§ˆà¦°à¦¿ à¦¤à¦¾à¦°à¦¿à¦–à§‡à¦° à¦¸à¦®à¦¯à¦¼','Date de crÃ©ation heure',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(448,'17','backup_files','Backup Files','Archivos de respaldo','à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª à¦«à¦¾à¦‡à¦²','Fichiers de sauvegarde',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(449,'17','weekend','Weekend','Fin de semana','à¦¸à¦ªà§à¦¤à¦¾à¦¹à¦¾à¦¨à§à¦¤à¦¿à¦• à¦•à¦¾à¦²','Weekend',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(450,'17','restore','Restore','Restaurar','à¦ªà§à¦°à¦¤à§à¦¯à¦°à§à¦ªà¦£ à¦•à¦°à¦¾','Restaurer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(451,'17','default','Default','Defecto','à¦¡à¦¿à¦«à¦²à§à¦Ÿ','DÃ©faut',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(452,'17','module','Module','MÃ³dulo','à¦®à¦¡à¦¿à¦‰à¦²','Module',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(453,'17','module_link','Module Link','Enlace del mÃ³dulo','à¦®à¦¡à¦¿à¦‰à¦² à¦²à¦¿à¦™à§à¦•','Lien de module',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(454,'17','permission','Permission','Permiso','à¦…à¦¨à§à¦®à¦¤à¦¿','Autorisation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(455,'17','site_title','Site Title','TÃ­tulo del sitio','à¦¸à¦¾à¦‡à¦Ÿ à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre du site',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(456,'17','select_session','Select Intake','Seleccionar Academic Year','à¦¸à§‡à¦¶à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez une Academic Year',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(457,'17','select_date_format','Select Date Format','Seleccione el formato de fecha','à¦¤à¦¾à¦°à¦¿à¦– à¦«à¦°à§à¦®à§à¦¯à¦¾à¦Ÿ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez le format de date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(458,'17','select_currency','Select Currency','Seleccione el tipo de moneda','à¦•à¦¾à¦°à§‡à¦¨à§à¦¸à¦¿ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la devise',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(459,'17','currency_symbol','Currency Symbol','SÃ­mbolo de moneda','à¦®à§à¦¦à§à¦°à¦¾à¦° à¦ªà§à¦°à¦¤à§€à¦•','Symbole de la monnaie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(460,'17','school_address','School Address','DirecciÃ³n de Escuela','à¦¸à§à¦•à§à¦²à§‡à¦° à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse de lÃ©cole',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(461,'17','update_language','Update Language','Actualizar idioma','à¦­à¦¾à¦·à¦¾ à¦†à¦ªà¦¡à§‡à¦Ÿ à¦•à¦°à§à¦¨','Mise Ã  jour de la langue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(462,'17','language_setup','Language Setup','ConfiguraciÃ³n de idioma','à¦­à¦¾à¦·à¦¾ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration de la langue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(463,'17','starting','Starting','Starting','à¦¶à§à¦°à§ à¦¹à¦šà§à¦›à§‡','Starting',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(464,'17','term','Term','Term','à¦¶à¦¬à§à¦¦','Term',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(465,'17','optional_subject','Optional Subject','Optional Subject','à¦à¦šà§à¦›à¦¿à¦• à¦¬à¦¿à¦·à¦¯à¦¼','Optional Subject',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(466,'17','manage_currency','Manage Currency','Manage Currency','à¦®à§à¦¦à§à¦°à¦¾ à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾ à¦•à¦°à§à¦¨','Manage Currency',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(467,'17','send_through','Send Through','Send Through','à¦®à¦¾à¦§à§à¦¯à¦®à§‡ à¦ªà§à¦°à§‡à¦°à¦£ à¦•à¦°à§à¦¨','Send Through',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(468,'17','custom_progress_card_report','Custom Progress Card Report','Custom Progress Card Report','à¦•à¦¾à¦¸à§à¦Ÿà¦® à¦…à¦—à§à¦°à¦—à¦¤à¦¿ à¦•à¦¾à¦°à§à¦¡ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Custom Progress Card Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(469,'17','due_amount','Due Amount','Due Amount','à¦¬à¦¾à¦•à¦¿ à¦Ÿà¦¾à¦•à¦¾','Due Amount',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(470,'17','paid_amount','Paid Amount','Paid Amount','à¦¦à§‡à¦“à¦¯à¦¼à¦¾ à¦ªà¦°à¦¿à¦®à¦¾à¦£','Paid Amount',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(471,'17','expaire_date','Expaire Date','Expaire Date','à¦®à§‡à¦¯à¦¼à¦¾à¦¦ à¦‰à¦¤à§à¦¤à§€à¦°à§à¦£','Expaire Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(472,'17','purchase_date','Purchase Date','Purchase Date','à¦•à§à¦°à¦¯à¦¼ à¦¤à¦¾à¦°à¦¿à¦–','Purchase Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(473,'17','package','Package','Package','à¦ªà§à¦¯à¦¾à¦•à§‡à¦œ','Package',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(474,'17','sl','SL','SL','SL à¦¬à¦¿à¦­à¦¾à¦—:','SL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(475,'17','purchase_list','Purchase List','Purchase List','à¦•à§à¦°à¦¯à¦¼à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Purchase List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(476,'17','infix_clasified','Infix Clasified','Infix Clasified','à¦‡à¦¨à¦«à¦¿à¦•à§à¦¸ à¦¶à§à¦°à§‡à¦£à¦¿à¦¬à¦¦à§à¦§','Infix Clasified',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(477,'17','infix_edu','Infix Edu','Infix Edu','à¦‡à¦¨à¦«à¦¿à¦•à§à¦¸ à¦à¦¡à§','Infix Edu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(478,'17','select_package','Select Package','Select Package','à¦ªà§à¦¯à¦¾à¦•à§‡à¦œ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Select Package',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(479,'17','thanks','Thanks','Thanks','à¦§à¦¨à§à¦¯à¦¬à¦¾à¦¦','Thanks',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(480,'17','team','Team','Team','à¦Ÿà§€à¦®','Team',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(481,'17','select','Select','Select','à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à¦¾','Select',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(482,'17','mark','Mark','Mark','à¦›à¦¾à¦ª','Mark',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(483,'17','fees_groups_details','Fees groups Details','Fees groups Details','à¦«à¦¿ à¦—à§‹à¦·à§à¦ à§€ à¦¬à¦¿à¦¶à¦¦','Fees groups Details',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(484,'17','staff','Staff','Staff','à¦•à¦°à§à¦®à§€','Staff',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(485,'17','manage-currency','Manage Currency','Manage Currency','à¦®à§à¦¦à§à¦°à¦¾ à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾ à¦•à¦°à§à¦¨','Manage Currency',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(486,'17','wise','Wise','Wise','à¦œà§à¦žà¦¾à¦¨à§€','Wise',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(487,'17','system_settings','System Settings','Ajustes del sistema','à¦ªà¦¦à§à¦§à¦¤à¦¿ à¦¨à¦¿à¦°à§à¦§à¦¾à¦°à¦£','Les paramÃ¨tres du systÃ¨me',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(488,'17','general_settings','General Settings','ConfiguraciÃ³n general','à¦¸à¦¾à¦§à¦¾à¦°à¦£ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','rÃ©glages gÃ©nÃ©raux',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(489,'17','email_settings','Email Settings','Ajustes del correo electrÃ³nico','à¦‡à¦®à§‡à¦² à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','ParamÃ¨tres de messagerie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(490,'17','payment_method_settings','Payment Method Settings','ConfiguraciÃ³n del mÃ©todo de pago','à¦ªà§à¦°à¦¦à¦¾à¦¨à§‡à¦° à¦ªà¦¦à§à¦§à¦¤à¦¿ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','MÃ©thode de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(491,'17','role','Role','Papel','à¦­à§‚à¦®à¦¿à¦•à¦¾','RÃ´le',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(492,'17','base_group','Base Group','Grupo base','à¦¬à§‡à¦¸ à¦—à§à¦°à§à¦ª','Groupe de base',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(493,'17','base_setup','Base Setup','ConfiguraciÃ³n de la base','à¦¬à§‡à¦¸ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration de base',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(494,'17','academic_year','Academic Year','AÃ±o acadÃ©mico','à¦¶à¦¿à¦•à§à¦·à¦¾à¦¬à¦°à§à¦·','AnnÃ©e acadÃ©mique',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(495,'17','session','Academic Year','Academic Year','à¦¸à§‡à¦¶à¦¨','Academic Year',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(496,'17','holiday','Holiday','Vacaciones','à¦›à§à¦Ÿà¦¿à¦° à¦¦à¦¿à¦¨','Vacances',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(497,'17','sms_settings','Sms Settings','ConfiguraciÃ³n de SMS','à¦à¦¸à¦à¦®à¦à¦¸ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','ParamÃ¨tres Sms',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(498,'17','language_settings','Language Settings','Configuraciones de idioma','à¦­à¦¾à¦·à¦¾ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','ParamÃ¨tres de langue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(499,'17','backup_settings','Backup','Apoyo','à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª','Sauvegarde',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(500,'17','select_language','Select Language','Seleccione el idioma','à¦­à¦¾à¦·à¦¾ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°','Choisir la langue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(501,'17','native','Native','Nativo','à¦¸à§à¦¥à¦¾à¦¨à§€à¦¯à¦¼','Originaire de',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(502,'17','universal','Universal','Universal','à¦¸à¦¾à¦°à§à¦¬à¦œà¦¨à§€à¦¨','Universel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(503,'17','make_default','Make Default','Hacer por defecto','à¦¡à¦¿à¦«à¦²à§à¦Ÿ à¦•à¦°à¦¾','Faire dÃ©faut',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(504,'17','setup','Setup','Preparar','à¦¸à§‡à¦Ÿà¦†à¦ª','Installer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(505,'17','change_logo','Change Logo','Cambiar Logo','à¦²à§‹à¦—à§‹ à¦ªà¦°à¦¿à¦¬à¦°à§à¦¤à¦¨ à¦•à¦°à§à¦¨','Changer le logo',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(506,'17','change_fav','Change Favicon','Cambiar Favicon','à¦«à§à¦¯à¦¾à¦­à¦¿à¦•à¦¨ à¦ªà¦°à¦¿à¦¬à¦°à§à¦¤à¦¨ à¦•à¦°à§à¦¨','Changer de favicon',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(507,'17','upload','Upload','Subir','à¦†à¦ªà¦²à§‹à¦¡','TÃ©lÃ©charger',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(508,'17','school_name','School Name','Nombre de la escuela','à¦¸à§à¦•à§à¦²à§‡à¦° à¦¨à¦¾à¦®','Nom de lÃ©cole',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(509,'17','school_code','School Code','CÃ³digo escolar','à¦¸à§à¦•à§à¦² à¦•à§‹à¦¡','Code dÃ©tablissement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(510,'17','language','Language','Idioma','à¦­à¦¾à¦·à¦¾','La langue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(511,'17','date_format','Date Format','Formato de fecha','à¦¤à¦¾à¦°à¦¿à¦– à¦¬à¦¿à¦¨à§à¦¯à¦¾à¦¸','Format de date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(512,'17','currency','Currency','Moneda','à¦®à§à¦¦à§à¦°à¦¾','Devise',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(513,'17','symbol','Symbol','SÃ­mbolo','à¦ªà§à¦°à¦¤à§€à¦•','symbole',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(514,'17','sand','Sand','Arena','à¦¬à¦¾à¦²à¦¿','Le sable',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(515,'17','smtp','SMTP','SMTP','SMTP à¦à¦°','SMTP',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(516,'17','from_name','From Name','De Nombre','à¦¨à¦¾à¦® à¦¥à§‡à¦•à§‡','De nom',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(517,'17','from_email','From Email','Desde el e-mail','à¦‡à¦®à§‡à¦² à¦¥à§‡à¦•à§‡','De lemail',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(518,'17','server','Server','Servidor','à¦¸à¦¾à¦°à§à¦­à¦¾à¦°','Serveur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(519,'17','port','Port','Puerto','à¦¬à¦¨à§à¦¦à¦°','Port',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(520,'17','security','Security','Seguridad','à¦¨à¦¿à¦°à¦¾à¦ªà¦¤à§à¦¤à¦¾','SÃ©curitÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(521,'17','select_a_payment_gateway','Select a Payment Gateway','Seleccione una pasarela de pago','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦—à§‡à¦Ÿà¦“à¦¯à¦¼à§‡ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez une passerelle de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(522,'17','checked','Checked','Comprobado','à¦¸à¦‚à¦¯à¦¤','VÃ©rifiÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(523,'17','paypal','Paypal','Paypal','à¦ªà§‡à¦ªà§à¦¯à¦¾à¦²','Pay Pal',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(524,'17','stripe','Stripe','Raya','à¦¡à§‹à¦°à¦¾','Bande',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(525,'17','payUMoney','PayUMoney','PayUMoney','PayUMoney','PayUMoney',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(526,'17','signature','Signature','Firma','à¦¸à§à¦¬à¦¾à¦•à§à¦·à¦°','Signature',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(527,'17','client_id','Client ID','IdentificaciÃ³n del cliente','à¦•à§à¦²à¦¾à¦¯à¦¼à§‡à¦¨à§à¦Ÿ à¦†à¦‡à¦¡à¦¿','identitÃ© du client',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(528,'17','secret_id','Secret ID','ID secreta','à¦¸à¦¿à¦•à§à¦°à§‡à¦Ÿ à¦†à¦‡à¦¡à¦¿','ID secret',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(529,'17','stripe_api_secret_key','Stripe API Secret Key','Stripe API Secret Key','à¦¸à§à¦Ÿà§à¦°à¦¿à¦ª à¦à¦ªà¦¿à¦†à¦‡ à¦¸à¦¿à¦•à§à¦°à§‡à¦Ÿ à¦•à§€','ClÃ© secrÃ¨te de lAPI de bande',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(530,'17','stripe_publisher_key','Stripe Publishable Key','Stripe Publishable Key','à¦¸à§à¦Ÿà§à¦°à¦¾à¦‡à¦ª à¦ªà§à¦°à¦•à¦¾à¦¶à¦¯à§‹à¦—à§à¦¯ à¦•à§€','Raie ClÃ© Publiable',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(531,'17','pay_u_money_key','PayU Money Key','PayU Money Key','à¦ªà§‡à¦‰ à¦®à¦¾à¦¨à¦¿ à¦•à§€','ClÃ© PayU Money',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(532,'17','pay_u_money_salt','PayU Money Salt','PayU Money Salt','à¦ªà§‡à¦‡à¦‰ à¦®à¦¾à¦¨à¦¿ à¦²à¦¬à¦£','PayU Money Salt',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(533,'17','role_permission','Role Permission','Permiso de rol','à¦­à§‚à¦®à¦¿à¦•à¦¾ à¦…à¦¨à§à¦®à¦¤à¦¿','Permission de rÃ´le',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(534,'17','assign_permission','Assign Permission','Asignar permiso','à¦…à¦¨à§à¦®à¦¤à¦¿ à¦¬à¦°à¦¾à¦¦à§à¦¦ à¦•à¦°à§à¦¨','Attribuer une autorisation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(535,'17','label','Label','Etiqueta','à¦²à§‡à¦¬à§‡à¦²','Ã‰tiquette',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(536,'17','base','Base','Base','à¦­à¦¿à¦¤à§à¦¤à¦¿','Base',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(537,'17','year_title','Year Title','TÃ­tulo del aÃ±o','à¦¬à¦›à¦°à§‡à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre de lannÃ©e',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(538,'17','starting_date','Starting Date','Fecha de inicio','à¦¶à§à¦°à§ à¦¤à¦¾à¦°à¦¿à¦–','Date de dÃ©but',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(539,'17','ending_date','Ending Date','Fecha de finalizaciÃ³n','à¦¸à¦®à¦¾à¦ªà§à¦¤à¦¿à¦° à¦¤à¦¾à¦°à¦¿à¦–','Fin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(540,'17','select_a_SMS_service','Select a SMS Service','Seleccione un servicio de SMS','à¦à¦•à¦Ÿà¦¿ à¦à¦¸à¦à¦®à¦à¦¸ à¦ªà¦°à¦¿à¦·à§‡à¦¬à¦¾ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un service SMS',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(541,'17','clickatell','Clickatell','Clickatell','Clickatell','Clickatell',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(542,'17','settings','Settings','Ajustes','à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','RÃ©glages',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(543,'17','twilio','Twilio','Twilio','Twilio','Twilio',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(544,'17','api','API','API','à¦à¦ªà¦¿à¦†à¦‡','API',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(545,'17','sid','SID','SID','à¦œà¦¨à§à¦¯ SID','SID',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(546,'18','front_end_settings','Front End Settings','Configuraciones frontales','à¦¸à¦®à§à¦®à§à¦– à¦¸à¦®à¦¾à¦ªà§à¦¤à¦¿ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','ParamÃ¨tres frontaux',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(547,'18','add_news','Add News','AÃ±adir noticias','à¦¸à¦‚à¦¬à¦¾à¦¦ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter des nouvelles',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(548,'18','news','News','Noticias','à¦–à¦¬à¦°','Nouvelles',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(549,'18','news_list','News List','Lista de noticias','à¦¸à¦‚à¦¬à¦¾à¦¦ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de nouvelles',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(550,'18','image','Image','Imagen','à¦­à¦¾à¦¬à¦®à§‚à¦°à§à¦¤à¦¿','Image',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(551,'18','publication_date','Publication Date','Fecha de publicaciÃ³n','à¦ªà§à¦°à¦•à¦¾à¦¶à¦¨à¦¾à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date de publication',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(552,'18','add_testimonial','Add Testimonial','AÃ±adir Testimonial','à¦ªà§à¦°à¦¶à¦‚à¦¸à¦¾à¦ªà¦¤à§à¦° à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter un tÃ©moignage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(553,'18','testimonial','Testimonial','Testimonial','à¦à¦œà¦¾à¦¹à¦¾à¦°à¦¨à¦¾à¦®à¦¾','TÃ©moignage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(554,'18','institution_name','Institution Name','Nombre de la InstituciÃ³n','à¦ªà§à¦°à¦¤à¦¿à¦·à§à¦ à¦¾à¦¨à§‡à¦° à¦¨à¦¾à¦®','nom de linstitution',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(555,'18','location','Location','UbicaciÃ³n','à¦…à¦¬à¦¸à§à¦¥à¦¾à¦¨','Emplacement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(556,'18','front_settings','Front Settings','Ajustes frontales','à¦¸à¦¾à¦®à¦¨à§‡à¦° à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','ParamÃ¨tres avant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(557,'19','my_profile','My Profile','Mi perfil','à¦†à¦®à¦¾à¦° à¦ªà§à¦°à§‹à¦«à¦¾à¦‡à¦²','Mon profil',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(558,'19','fees','Fees','MatrÃ­cula','à¦«à¦¿','Honoraires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(559,'19','pay_fees','Pay Fees','Cuotas de pago','à¦«à¦¿ à¦ªà¦°à¦¿à¦¶à§‹à¦§','Payer les frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(560,'19','download_center','Download Center','Centro de descargas','à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡ à¦•à§‡à¦¨à§à¦¦à§à¦°','centre de tÃ©lÃ©chargement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(561,'19','student_study_material','Study Materials','Materiales de estudio','à¦…à¦§à§à¦¯à¦¯à¦¼à¦¨ à¦‰à¦ªà¦•à¦°à¦£','MatÃ©riel dÃ©tudes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(562,'19','examinations','Assignments','ExÃ¡menes','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦¯à¦¼','Examens',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(563,'19','result','result','resultado','à¦«à¦²à¦¾à¦«à¦²','rÃ©sultat',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(564,'19','active_exams','Active Exams','ExÃ¡menes activos','à¦¸à¦•à§à¦°à¦¿à¦¯à¦¼ à¦ªà¦°à§€à¦•à§à¦·à¦¾','Examens actifs',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(565,'19','book_issue','Book issued','Libro emitido','à¦¬à¦‡ à¦œà¦¾à¦°à¦¿','Livre publiÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(566,'19','my_children','My Children','Mis hijos','à¦†à¦®à¦¾à¦° à¦¶à¦¿à¦¶à§','Mes enfants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(567,'19','exam_result','Exam Result','Resultado del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦«à¦²à¦¾à¦«à¦²','RÃ©sultat dÃ©xamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(568,'19','teacher_list','Teacher list','Lista de profesores','à¦¶à¦¿à¦•à§à¦·à¦•à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des enseignants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(569,'19','inserted_message','Operation Successfully','Insertado con Ã©xito','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦…à¦ªà¦¾à¦°à§‡à¦¶à¦¨','InsÃ©rÃ© avec succÃ¨s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(570,'19','updated_message','Updated Successfully','Actualizado exitosamente','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦†à¦ªà¦¡à§‡à¦Ÿ à¦¹à¦¯à¦¼à§‡à¦›à§‡','Mis Ã  jour avec succÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(571,'19','deleted_message','Deleted Successfully','Borrado exitosamente','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦®à§‹à¦›à¦¾ à¦¹à¦¯à¦¼à§‡à¦›à§‡','SupprimÃ© avec succÃ¨s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(572,'19','inactive_message','Inactivated Successfully','Inactivado con Ã©xito','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦¨à¦¿à¦·à§à¦•à§à¦°à¦¿à¦¯à¦¼ à¦•à¦°à¦¾ à¦¹à¦¯à¦¼à§‡à¦›à§‡','InactivÃ© avec succÃ¨s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(573,'19','active_message','Activated Successfully','Activado con Ã©xito','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦¸à¦•à§à¦°à¦¿à¦¯à¦¼ à¦¹à¦¯à¦¼à§‡à¦›à§‡','ActivÃ© avec succÃ¨s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(574,'19','backup_message','Backup Successfully','Copia de seguridad con Ã©xito','à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡','Sauvegarde rÃ©ussie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(575,'19','restore_message','Restore Successfully','Restaurar con Ã©xito','à¦¸à¦«à¦²à¦­à¦¾à¦¬à§‡ à¦ªà§à¦¨à¦°à§à¦¦à§à¦§à¦¾à¦° à¦•à¦°à§à¦¨','Restaurer avec succÃ¨s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(576,'19','not_found_message','Ops! Data not Found','Ops! Datos no encontrados','à¦…à¦ªà¦¸! à¦¤à¦¥à§à¦¯ à¦ªà¦¾à¦“à¦¯à¦¼à¦¾ à¦¯à¦¾à¦¯à¦¼à¦¨à¦¿','Ops! DonnÃ©es non trouvÃ©es',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(577,'19','error_message','Ops! Something went wrong, please try again','Ops! Algo saliÃ³ mal. Por favor, vuelva a intentarlo','à¦…à¦ªà¦¸! à¦•à¦¿à¦›à§ à¦­à§à¦² à¦¹à¦¯à¦¼à§‡à¦›à§‡ à¦†à¦¬à¦¾à¦° à¦šà§‡à¦·à§à¦Ÿà¦¾ à¦•à¦°à§à¦¨','Ops! Une erreur sest produite. Veuillez rÃ©essayer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(578,'19','front_cms','Front cms','Frente cms','à¦¸à¦¾à¦®à¦¨à§‡à¦° à¦¸à§‡à¦®à¦¿','Cms avant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(579,'19','update_system','Update System','Sistema de actualizaciÃ³n','à¦†à¦ªà¦¡à§‡à¦Ÿ à¦¸à¦¿à¦¸à§à¦Ÿà§‡à¦®','SystÃ¨me de mise Ã  jour',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(580,'19','System_Status','System Status','Estado del sistema','à¦¸à¦¿à¦¸à§à¦Ÿà§‡à¦®à§‡à¦° à¦…à¦¬à¦¸à§à¦¥à¦¾','Ã‰tat du systÃ¨me',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(581,'19','Upgrade','Upgrade','Mejorar','à¦†à¦ªà¦—à§à¦°à§‡à¦¡ à¦•à¦°à§à¦¨','AmÃ©liorer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(582,'19','Version','Version','VersiÃ³n','à¦¸à¦‚à¦¸à§à¦•à¦°à¦£','Version',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(583,'19','Existing','Existing','Existente','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨','Existant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(584,'19','Available','Available','Disponible','à¦¸à¦¹à¦œà¦²à¦­à§à¦¯','Disponible',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(585,'19','Alert','Alert','Alerta','à¦¸à¦¤à¦°à§à¦•','Alerte',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(586,'19','New_Features','New Features','Nuevas caracterÃ­sticas','à¦¨à¦¤à§à¦¨ à¦¬à§ˆà¦¶à¦¿à¦·à§à¦Ÿ','Nouvelles fonctionnalitÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(587,'19','copyright_text','Copyright Text','Texto de copyright','à¦•à¦ªà¦¿à¦°à¦¾à¦‡à¦Ÿ à¦ªà¦¾à¦ à§à¦¯','Texte de copyright',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(588,'2','grade_point','Grade Point','Grade Point','à¦—à§à¦°à§‡à¦¡ à¦ªà¦¯à¦¼à§‡à¦¨à§à¦Ÿ','Grade Point',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(589,'2','without_additional','Without Additional','Without Additional','à¦…à¦¤à¦¿à¦°à¦¿à¦•à§à¦¤ à¦›à¦¾à¦¡à¦¼à¦¾','Without Additional',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(590,'2','additional_subject','Additional Subject','Additional Subject','à¦…à¦¤à¦¿à¦°à¦¿à¦•à§à¦¤ à¦¬à¦¿à¦·à¦¯à¦¼','Additional Subject',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(591,'2','gpa_above','GPA above','GPA above','à¦‰à¦ªà¦°à§‡ à¦œà¦¿à¦ªà¦¿à¦','GPA above',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(592,'2','date_of_publication_of_result','Date of Publication of Result','Date of Publication of Result','à¦«à¦²à¦¾à¦«à¦² à¦ªà§à¦°à¦•à¦¾à¦¶à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date of Publication of Result',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(593,'2','exam_controller','Exam Controller','Exam Controller','à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¨à¦¿à¦¯à¦¼à¦¾à¦®à¦•','Exam Controller',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(594,'2','class_report_for_class','Class Report for class','Class Report for class','à¦•à§à¦²à¦¾à¦¸à§‡à¦° à¦œà¦¨à§à¦¯ à¦•à§à¦²à¦¾à¦¸ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Class Report for class',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(595,'2','history','History','History','à¦‡à¦¤à¦¿à¦¹à¦¾à¦¸','History',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(596,'2','change_password','Change Password','Change Password','à¦ªà¦¾à¦¸à¦“à¦¯à¦¼à¦¾à¦°à§à¦¡ à¦ªà¦°à¦¿à¦¬à¦°à§à¦¤à¦¨ à¦•à¦°à§à¦¨','Change Password',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(597,'2','course_heading','Course Heading','Course Heading','à¦•à§‹à¦°à§à¦¸ à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Course Heading',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(598,'2','news_heading','News Heading','News Heading','à¦¸à¦‚à¦¬à¦¾à¦¦ à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','News Heading',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(599,'2','subject_attendance_report','Subject Attendance Report','Subject Attendance Report','à¦¬à¦¿à¦·à¦¯à¦¼ à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Subject Attendance Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(600,'2','ltl','LTL','LTL','LTL','LTL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(601,'2','rtl','RTL','RTL','à¦†à¦°à¦Ÿà¦¿à¦à¦²','RTL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(602,'2','alignment','Alignment','Alignment','à¦¶à§à¦°à§‡à¦£à§€à¦¬à¦¿à¦¨à§à¦¯à¦¾à¦¸','Alignment',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(603,'2','invoice','Invoice','Invoice','à¦šà¦¾à¦²à¦¾à¦¨','Invoice',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(604,'2','new_client_information','New Client Information','New Client Information','à¦¨à¦¤à§à¦¨ à¦•à§à¦²à¦¾à¦¯à¦¼à§‡à¦¨à§à¦Ÿ à¦¤à¦¥à§à¦¯','New Client Information',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(605,'2','made','Made','Made','à¦ªà§à¦°à¦£à§€à¦¤','Made',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(606,'2','exam','Assignment','Exam','à¦ªà¦°à§€à¦•à§à¦·à¦¾','Exam',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(607,'2','phone_number','Phone Number','Phone Number','à¦«à§‹à¦¨ à¦¨à¦®à§à¦¬à¦°','Phone Number',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(608,'2','transport_and_dormitory_details','Transport and Dormitory Details','Transport and Dormitory Details','à¦ªà¦°à¦¿à¦¬à¦¹à¦¨ à¦à¦¬à¦‚ à¦›à¦¾à¦¤à§à¦°à¦¾à¦¬à¦¾à¦¸à§‡à¦° à¦¬à¦¿à¦¶à¦¦','Transport and Dormitory Details',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(609,'2','driver_phone_number','Driver Phone Number','Driver Phone Number','à¦¡à§à¦°à¦¾à¦‡à¦­à¦¾à¦° à¦«à§‹à¦¨ à¦¨à¦®à§à¦¬à¦°','Driver Phone Number',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(610,'2','national_identification_number','National Identification Number','National Identification Number','à¦œà¦¾à¦¤à§€à¦¯à¦¼ à¦¸à¦¨à¦¾à¦•à§à¦¤à¦•à¦¾à¦°à§€ à¦¨à¦®à§à¦¬à¦°','National Identification Number',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(611,'2','local_identification_number','Local Identification Number','Local Identification Number','à¦¸à§à¦¥à¦¾à¦¨à§€à¦¯à¦¼ à¦ªà¦°à¦¿à¦šà¦¯à¦¼ à¦¨à¦®à§à¦¬à¦°','Local Identification Number',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(612,'2','UBC56987','UBC56987','UBC56987','UBC56987','UBC56987',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(613,'2','incompleted','Incompleted','Incompleted','Incompleted','Incompleted',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(614,'2','room_name','Room Name','Room Name','à¦°à§à¦®à§‡à¦° à¦¨à¦¾à¦®','Room Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(615,'2','class_period','Class Period','Class Period','à¦•à§à¦²à¦¾à¦¸à§‡à¦° à¦¸à¦®à¦¯à¦¼à¦¸à§€à¦®à¦¾','Class Period',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(616,'2','paystack','Paystack','Paystack','Paystack','Paystack',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(617,'2','update_news_heading_section','Update News Heading Section','Update News Heading Section','à¦†à¦ªà¦¡à§‡à¦Ÿ à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦® à¦¬à¦¿à¦­à¦¾à¦—','Update News Heading Section',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(618,'2','membership','Membership','Membership','à¦¸à¦¦à¦¸à§à¦¯à¦¤à¦¾','Membership',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(619,'2','purchase_receipt','Purchase Receipt','Purchase Receipt','à¦•à§‡à¦¨à¦¾à¦° à¦°à¦¶à¦¿à¦¦','Purchase Receipt',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(620,'2','bill_to','Bill To','Bill To','à¦¬à¦¿à¦² à¦Ÿà§','Bill To',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(621,'2','sell_receipt','Sell Receipt','Sell Receipt','à¦°à¦¸à¦¿à¦¦ à¦¬à¦¿à¦•à§à¦°à¦¿ à¦•à¦°à§à¦¨','Sell Receipt',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(622,'2','sale_to','Sale To','Sale To','à¦¬à¦¿à¦•à§à¦°à¦¯à¦¼','Sale To',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(623,'2','sell_date','Sell Date','Sell Date','à¦¤à¦¾à¦°à¦¿à¦– à¦¬à¦¿à¦•à§à¦°à¦¯à¦¼','Sell Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(624,'2','item_sale','Item Sale','Item Sale','à¦†à¦‡à¦Ÿà§‡à¦® à¦¬à¦¿à¦•à§à¦°à¦¯à¦¼','Item Sale',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(625,'2','sell_price','Sell Price','Sell Price','à¦¬à¦¿à¦•à§à¦°à¦¯à¦¼ à¦®à§‚à¦²à§à¦¯','Sell Price',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(626,'2','contarct_type','Contarct Type','Contarct Type','à¦¸à¦‚à¦¯à§à¦•à§à¦¤à¦¿ à¦ªà§à¦°à¦•à¦¾à¦°','Contarct Type',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(627,'2','work_experience','Work Experience','Work Experience','à¦•à¦°à§à¦®à¦¦à¦•à§à¦·à¦¤à¦¾','Work Experience',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(628,'2','mode_of_payment','Mode of Payment','Mode of Payment','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦®à§‹à¦¡','Mode of Payment',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(629,'2','no_payroll_data','No Payroll Data','No Payroll Data','à¦•à§‹à¦¨à¦“ à¦ªà§‡à¦“à¦°à§‹à¦² à¦¡à§‡à¦Ÿà¦¾ à¦¨à§‡à¦‡','No Payroll Data',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(630,'2','not_leaves_data','Not Leaves Data','Not Leaves Data','à¦ªà¦¾à¦¤à¦¾à¦—à§à¦²à¦¿ à¦¨à§‡à¦‡','Not Leaves Data',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(631,'2','joining_letter','Joining Letter','Joining Letter','à¦šà¦¿à¦ à¦¿ à¦¯à§‹à¦— à¦¦à¦¿à¦šà§à¦›à§‡à¦¨','Joining Letter',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(632,'2','student_information','Student Info','InformaciÃ³n del estudiante','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦¤à¦¥à§à¦¯','Info Ã©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(633,'2','student_admission','Student Admission','AdmisiÃ³n de estudiantes','à¦›à¦¾à¦¤à§à¦° à¦­à¦°à§à¦¤à¦¿','Admission des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(634,'2','student_import','Student Import','Estudiante de importaciÃ³n','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦†à¦®à¦¦à¦¾à¦¨à¦¿','Import Ã©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(635,'2','import','Import','Importar','à¦†à¦®à¦¦à¦¾à¦¨à¦¿','Importation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(636,'2','personal','Personal','Personal','à¦¬à§à¦¯à¦•à§à¦¤à¦¿à¦—à¦¤','Personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(637,'2','info','Info','InformaciÃ³n','à¦¤à¦¥à§à¦¯','Info',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(638,'2','roll','Roll','Rodar','à¦°à§‹à¦²','Rouleau',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(639,'2','first','First','primero','à¦ªà§à¦°à¦¥à¦®','Premier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(640,'2','last','Last','Ãšltimo','à¦—à¦¤','Dernier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(641,'2','religion','Religion','ReligiÃ³n','à¦§à¦°à§à¦®','Religion',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(642,'2','caste','Caste','Casta','à¦œà¦¾à¦¤','Caste',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(643,'2','category','Category','CategorÃ­a','à¦¬à¦¿à¦­à¦¾à¦—','CatÃ©gorie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(644,'2','height','Height','Altura','à¦‰à¦šà§à¦šà¦¤à¦¾','la taille',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(645,'2','Weight','Weight','Peso','à¦“à¦œà¦¨','Poids',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(646,'2','sibling','Sibling','Hermano','à¦¸à¦®à¦°à§‚à¦ª','Enfant de mÃªmes parents',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(647,'2','information','Information','InformaciÃ³n','à¦¤à¦¥à§à¦¯','Information',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(648,'2','guardian','Guardian','guardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•','Gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(649,'2','&','&','Y','&','Et',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(650,'2','occupation','Occupation','OcupaciÃ³n','à¦ªà§‡à¦¶à¦¾','Occupation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(651,'2','photo','Photo','Foto','à¦›à¦¬à¦¿','Photo',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(652,'2','Other','Others','Otros','à¦…à¦¨à§à¦¯à¦¾à¦¨à§à¦¯','Autres',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(653,'2','relation_with_guardian','Relation with Guardian','RelaciÃ³n con Guardian','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à§‡à¦° à¦¸à¦¾à¦¥à§‡ à¦¸à¦®à§à¦ªà¦°à§à¦•','Relation avec le gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(654,'2','current','Current','Corriente','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨','Actuel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(655,'2','permanent','Permanent','Permanente','à¦¸à§à¦¥à¦¾à¦¯à¦¼à§€','Permanent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(656,'2','route_list','Route List','Lista de rutas','à¦°à§à¦Ÿà§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des itinÃ©raires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(657,'2','driver','Driver','Conductor','à¦šà¦¾à¦²à¦•','Chauffeur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(658,'2','room','Room','HabitaciÃ³n','à¦˜à¦°','PiÃ¨ce',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(659,'2','national_iD_number','National ID Number','Numero de identificacion nacional','à¦†à¦®à¦¿ à¦¬à¦¸à¦¾ à¦›à¦¿à¦²','numÃ©ro national didentitÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(660,'2','local_Id_Number','Local Id Number','NÃºmero de identificaciÃ³n local','à¦²à§‹à¦•à¦¾à¦² à¦†à¦‡à¦¡à¦¿ à¦¨à¦®à§à¦¬à¦°','NumÃ©ro didentification local',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(661,'2','bank','Bank','Banco','à¦¬à§à¦¯à¦¾à¦‚à¦•','Banque',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(662,'2','previous_school_details','Previous School Details','Detalles de la escuela anterior','à¦ªà§‚à¦°à§à¦¬à¦¬à¦°à§à¦¤à§€ à¦¸à§à¦•à§à¦²à§‡à¦° à¦¬à¦¿à¦¬à¦°à¦£','DÃ©tails de lÃ©cole prÃ©cÃ©dente',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(663,'2','additional_notes','Additional Notes','Notas adicionales','à¦…à¦¤à¦¿à¦°à¦¿à¦•à§à¦¤ à¦¨à§‹à¦Ÿ','Notes complÃ©mentaires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(664,'2','parents_and_guardian_info','PARENTS & GUARDIAN INFO','INFORMACIÃ“N PARA LOS PADRES Y TUTORES','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦• à¦à¦¬à¦‚ à¦—à¦¾à¦°à§à¦¡à¦¿à¦¯à¦¼à¦¾à¦¨ à¦¤à¦¥à§à¦¯','INFO PARENTS ET GARDIENS',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(665,'2','transport_and_dormitory_info','Transport & Dormitory Info','InformaciÃ³n de transporte y dormitorio','à¦ªà¦°à¦¿à¦¬à¦¹à¦¨ à¦à¦¬à¦‚ à¦›à¦¾à¦¤à§à¦°à¦¾à¦¬à¦¾à¦¸à§‡à¦° à¦¤à¦¥à§à¦¯','Informations sur le transport et le dortoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(666,'2','document_info','Document Info','InformaciÃ³n del documento','à¦¨à¦¥à¦¿ à¦¤à¦¥à§à¦¯','Informations sur le document',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(667,'2','document_01_title','Document 01 Title','Documento 01 TÃ­tulo','à¦¨à¦¥à¦¿ 01 à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Document 01 Titre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(668,'2','document_02_title','Document 02 Title','Documento 02 Titulo','à¦¦à¦²à¦¿à¦² 02 à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Document 02 Titre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(669,'2','document_03_title','Document 03 Title','TÃ­tulo del documento 03','à¦¦à¦²à¦¿à¦² 03 à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Document 03 Titre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(670,'2','document_04_title','Document 04 Title','Documento 04 TÃ­tulo','à¦¨à¦¥à¦¿ 04 à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Document 04 Titre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(671,'2','student_details','Student Details','Detalles del estudiante','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦¬à¦¿à¦¬à¦°à¦£','DÃ©tails de lÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(672,'2','search_by_name','Search By Name','Buscar por nombre','à¦¨à¦¾à¦® à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨','Rechercher par nom',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(673,'2','search_by_roll_no','Search by Student ID','BÃºsqueda por rollo no','à¦°à§‹à¦² à¦¨à¦®à§à¦¬à¦° à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦•à¦°à§à¦¨','Recherche par roulement no',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(674,'2','father_name','Fathers Name','Nombre del Padre','à¦¬à¦¾à¦¬à¦¾à¦° à¦¨à¦¾à¦®','Le nom du pÃ¨re',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(675,'2','student_promote','Student Promote','Estudiante de promociÃ³n','à¦›à¦¾à¦¤à§à¦° à¦ªà§à¦°à¦šà¦¾à¦° à¦•à¦°à§à¦¨','Ã‰tudiant promouvoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(676,'2','select_current_session','Select Current Academic Year','Seleccionar Academic Year','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦¸à§‡à¦¶à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner Academic Year',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(677,'2','select_current_class','Select Current Program','Seleccione la clase actual','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦•à§à¦²à¦¾à¦¸ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la classe actuelle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(678,'2','select_current_section','Select Current section','Seleccione la secciÃ³n actual','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la section actuelle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(679,'2','promote_student_in_next_session','Promote Student In Next Academic Year','Promover estudiante en la prÃ³xima sesiÃ³n','à¦ªà¦°à§‡à¦° à¦¸à§‡à¦¶à¦¨à§‡ à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦ªà§à¦°à¦šà¦¾à¦° à¦•à¦°à§à¦¨','Promouvoir lÃ©tudiant Ã  la prochaine session',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(680,'2','view_academic_performance','View Academic Performance','Ver rendimiento acadÃ©mico','à¦à¦•à¦¾à¦¡à§‡à¦®à¦¿à¦• à¦ªà¦¾à¦°à¦«à¦°à¦®à§à¦¯à¦¾à¦¨à§à¦¸ à¦¦à§‡à¦–à§à¦¨','Voir la performance acadÃ©mique',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(681,'2','pass','Pass','Pasar','à¦ªà¦¾à¦¸','Passer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(682,'2','fail','Fail','Fallar','à¦¬à§à¦¯à¦°à§à¦¥','Ã‰chouer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(683,'2','select_promote_session','Select Promote Academic Year','Seleccione Promover Academic Year','à¦¸à§‡à¦¶à¦¨ à¦ªà§à¦°à¦šà¦¾à¦° à¦•à¦°à§à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la session de promotion',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(684,'2','select_promote_class','Select Promote Class','Seleccione Promover clase','à¦¶à§à¦°à§‡à¦£à§€ à¦ªà§à¦°à¦šà¦¾à¦° à¦•à¦°à§à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez Promouvoir la classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(685,'2','the_session_is_required','The session is required','La sesion es obligatoria','à¦…à¦§à¦¿à¦¬à§‡à¦¶à¦¨ à¦ªà§à¦°à¦¯à¦¼à§‹à¦œà¦¨','La session est obligatoire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(686,'2','the_class_is_required','The class is required','La clase es obligatoria','à¦•à§à¦²à¦¾à¦¸ à¦ªà§à¦°à¦¯à¦¼à§‹à¦œà¦¨','Le cours est obligatoire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(687,'2','the_section_is_required','The section is required','La secciÃ³n es obligatoria.','à¦¬à¦¿à¦­à¦¾à¦—à¦Ÿà¦¿ à¦ªà§à¦°à¦¯à¦¼à§‹à¦œà¦¨à§€à¦¯à¦¼','La section est obligatoire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(688,'2','select_promote_section','Select Promote Section','Seleccione la secciÃ³n de promociÃ³n','à¦¬à¦¿à¦­à¦¾à¦— à¦ªà§à¦°à¦šà¦¾à¦° à¦•à¦°à§à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez la section de promotion',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(689,'2','promote','Promote','Promover','à¦‰à¦¨à§à¦¨à§€à¦¤ à¦•à¦°à¦¾','Promouvoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(690,'2','student_attendance','Student Attendance','Asistencia de estudiantes','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿','AssiduitÃ© des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(691,'2','select_class','SELECT PROGRAM ','Seleccionar clase','à¦•à§à¦²à¦¾à¦¸ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez une classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(692,'2','attendance','Attendance','Asistencia','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿','PrÃ©sence',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(693,'2','attendance_already_submitted_as_holiday','Attendance Already Submitted As Holiday. You Can Edit Record','Asistencia ya enviada como festivo. Puede editar el registro','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦‡à¦¤à¦¿à¦®à¦§à§à¦¯à§‡ à¦›à§à¦Ÿà¦¿à¦° à¦¦à¦¿à¦¨ à¦¹à¦¿à¦¸à¦¾à¦¬à§‡ à¦œà¦®à¦¾ à¦¦à§‡à¦“à¦¯à¦¼à¦¾ à¦¹à¦¯à¦¼à§‡à¦›à§‡à¥¤ à¦†à¦ªà¦¨à¦¿ à¦°à§‡à¦•à¦°à§à¦¡ à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨à¦¾ à¦•à¦°à¦¤à§‡ à¦ªà¦¾à¦°à§‡à¦¨','PrÃ©sence dÃ©jÃ  soumise Ã  titre de vacances. Vous pouvez modifier lenregistrement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(694,'2','attendance_already_submitted','Attendance Already Submitted You Can Edit Record','La asistencia ya enviada Puede editar el registro','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦‡à¦¤à¦¿à¦®à¦§à§à¦¯à§‡ à¦œà¦®à¦¾ à¦¦à§‡à¦“à¦¯à¦¼à¦¾ à¦†à¦ªà¦¨à¦¿ à¦°à§‡à¦•à¦°à§à¦¡ à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨à¦¾ à¦•à¦°à¦¤à§‡ à¦ªà¦¾à¦°à§‡à¦¨','PrÃ©sence dÃ©jÃ  soumise Vous pouvez modifier la fiche',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(695,'2','mark_holiday','Mark Holiday','Mark Holiday','à¦®à¦¾à¦°à§à¦• à¦¹à¦²à¦¿à¦¡à§‡','Mark Holiday',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(696,'2','present','Present','Presente','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨','PrÃ©sent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(697,'2','late','Late','Tarde','à¦¬à¦¿à¦²à¦®à§à¦¬à§‡','En retard',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(698,'2','absent','Absent','Ausente','à¦…à¦¨à§à¦ªà¦¸à§à¦¥à¦¿à¦¤','Absent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(699,'2','half_day','Half Day','Medio dÃ­a','à¦…à¦°à§à¦§à§‡à¦• à¦¦à¦¿à¦¨','Demi-journÃ©e',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(700,'2','add_note_here','Add Note Here','AÃ±adir nota aquÃ­','à¦à¦–à¦¾à¦¨à§‡ à¦¨à§‹à¦Ÿ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter une note ici',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(701,'2','error','Error','Error','à¦¤à§à¦°à§à¦Ÿà¦¿','Erreur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(702,'2','student_attendance_report','Student Attendance Report','Informe de asistencia del estudiante','à¦›à¦¾à¦¤à§à¦° à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de prÃ©sence des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(703,'2','january','January','enero','à¦œà¦¾à¦¨à§à¦¯à¦¼à¦¾à¦°à§€','janvier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(704,'2','february','February','febrero','à¦«à§‡à¦¬à§à¦°à§à¦¯à¦¼à¦¾à¦°à¦¿','fÃ©vrier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(705,'2','march','March','marzo','à¦®à¦¾à¦°à§à¦š','Mars',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(706,'2','april','April','abril','à¦à¦ªà§à¦°à¦¿à¦²','avril',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(707,'2','may','May','Mayo','à¦®à§‡','Peut',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(708,'2','june','June','junio','à¦œà§à¦¨','juin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(709,'2','july','July','julio','à¦œà§à¦²à¦¾à¦‡','juillet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(710,'2','august','August','agosto','à¦…à¦—à¦¾à¦¸à§à¦Ÿ','aoÃ»t',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(711,'2','september','September','septiembre','à¦¸à§‡à¦ªà§à¦Ÿà§‡à¦®à§à¦¬à¦°','septembre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(712,'2','october','October','octubre','à¦…à¦•à§à¦Ÿà§‹à¦¬à¦°','octobre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(713,'2','november','November','noviembre','à¦¨à¦­à§‡à¦®à§à¦¬à¦°','novembre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(714,'2','december','December','diciembre','à¦¡à¦¿à¦¸à§‡à¦®à§à¦¬à¦°','dÃ©cembre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(715,'2','select_month','Select Month','Seleccione mes','à¦®à¦¾à¦¸ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un mois',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(716,'2','select_year','Select Year','Seleccione el aÃ±o','à¦¬à¦›à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez lannÃ©e',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(717,'2','student_category','Student Category','CategorÃ­a de estudiante','à¦›à¦¾à¦¤à§à¦° à¦¬à¦¿à¦­à¦¾à¦—','CatÃ©gorie dÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(718,'2','student_category_list','Student Category List','Lista de categorÃ­as de estudiantes','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦¬à¦¿à¦­à¦¾à¦— à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des catÃ©gories dÃ©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(719,'2','student_group','Student Group','Grupo de estudiantes','à¦›à¦¾à¦¤à§à¦° à¦¦à¦²','Groupe dÃ©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(720,'2','group','Group','Grupo','à¦—à§à¦°à§à¦ª','Groupe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(721,'2','disabled_student','Disabled Students','Estudiantes discapacitados','à¦ªà§à¦°à¦¤à¦¿à¦¬à¦¨à§à¦§à§€ à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦°à¦¾','Etudiants handicapÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(722,'2','student_list','Student List','Lista de estudiantes','à¦›à¦¾à¦¤à§à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(723,'2','birth_certificate','Birth Certificate','Certificado de nacimiento','à¦œà¦¨à§à¦® à¦¸à¦¨à¦¦','Certificat de naissance',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(724,'2','student_edit','Student Edit','Estudiante Editar','à¦›à¦¾à¦¤à§à¦° à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨à¦¾','Ã‰tudiant modifier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(725,'2','in','In','En','à¦­à¦¿à¦¤à¦°à§‡','Dans',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(726,'2','kg','KG','KG','à¦•à§‡à¦œà¦¿','KG',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(727,'2','add_parent','Add Parent','AÃ±adir padre','à¦ªà§à¦¯à¦¾à¦°à§‡à¦¨à§à¦Ÿ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter un parent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(728,'2','update_information','Update information','Actualizar informaciÃ³n','à¦¹à¦¾à¦²à¦¨à¦¾à¦—à¦¾à¦¦ à¦¤à¦¥à§à¦¯','Mettre Ã  jour les informations',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(729,'2','siblings','Siblings','Hermanos','à¦­à¦¾à¦‡à¦¬à§‹à¦¨','FrÃ¨res et sÅ“urs',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(730,'2','guardian_name','Guardians Name','Nombre del guardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à¦¦à§‡à¦° à¦¨à¦¾à¦®','Nom du gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(731,'2','guardian_email','Guardians Email','Email del guardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à¦°à¦¾ à¦‡à¦®à§‡à¦²','Email du gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(732,'2','guardian_phone','Guardians Phone','TelÃ©fono del guardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à¦°à¦¾ à¦«à§‹à¦¨','TÃ©lÃ©phone du gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(733,'2','guardian_occupation','Guardian Occupation','OcupaciÃ³n GuardiÃ¡n','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦• à¦ªà§‡à¦¶à¦¾','Profession de gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(734,'2','guardian_address','Guardian Address','DirecciÃ³n del tutor','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦• à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse du gardien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(735,'2','student_address_info','Student Address Info','InformaciÃ³n de la direcciÃ³n del estudiante','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦ à¦¿à¦•à¦¾à¦¨à¦¾ à¦¤à¦¥à§à¦¯','Adresse de l\'Ã©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(736,'2','current_address','Current Address','Direccion actual','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse actuelle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(737,'2','permanent_address','Permanent Address','direcciÃ³n permanente','à¦¸à§à¦¥à¦¾à¦¯à¦¼à§€ à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse permanente',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(738,'2','vehicle_number','Vehicle Number','NÃºmero de vehÃ­culo','à¦¯à¦¾à¦¨à¦¬à¦¾à¦¹à¦¨ à¦¨à¦®à§à¦¬à¦°','NumÃ©ro de vÃ©hicule',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(739,'2','driver_name','Driver Name','Nombre del conductor','à¦¡à§à¦°à¦¾à¦‡à¦­à¦¾à¦°à§‡à¦° à¦¨à¦¾à¦®','Nom du conducteur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(740,'2','bank_name','Bank Name','Nombre del banco','à¦¬à§à¦¯à¦¾à¦‚à¦•à§‡à¦° à¦¨à¦¾à¦®','Nom de banque',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(741,'2','update_student','update student','actualizar estudiante','à¦†à¦ªà¦¡à§‡à¦Ÿ à¦›à¦¾à¦¤à§à¦°','mise Ã  jour de lÃ©tudiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(742,'2','remove','Remove','retirar','à¦…à¦ªà¦¸à¦¾à¦°à¦£','Retirer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(743,'2','are_you','Are you sure to remove siblings?','Â¿EstÃ¡s seguro de eliminar a los hermanos?','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦­à¦¾à¦‡à¦¬à§‹à¦¨à¦¦à§‡à¦° à¦¸à¦°à¦¾à¦¨à§‹à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','ÃŠtes-vous sÃ»r de vouloir supprimer vos frÃ¨res et soeurs?',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(744,'2','download_sample_file','Download Sample File','Descargar archivo de muestra','à¦¨à¦®à§à¦¨à¦¾ à¦«à¦¾à¦‡à¦²à¦Ÿà¦¿ à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡ à¦•à¦°à§à¦¨','TÃ©lÃ©charger un exemple de fichier',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(745,'2','other_documents','Other Documents','Other Documents','à¦…à¦¨à§à¦¯à¦¾à¦¨à§à¦¯ à¦•à¦¾à¦—à¦œà¦ªà¦¤à§à¦°','Other Documents',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(746,'2','documents','Documents','Documents','à¦•à¦¾à¦—à¦œà¦ªà¦¤à§à¦°','Documents',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(747,'2','resume','Resume','Resume','à¦œà§€à¦¬à¦¨à¦¬à§ƒà¦¤à§à¦¤à¦¾à¦¨à§à¦¤','Resume',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(748,'2','summery','Summery','Summery','à¦—à§à¦°à§€à¦·à§à¦®à§‡à¦° à¦¬à§ˆà¦¶à¦¿à¦·à§à¦Ÿà§à¦¯à¦ªà§‚à¦°à§à¦£','Summery',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(749,'2','academic_records','Academic Records','Academic Records','à¦à¦•à¦¾à¦¡à§‡à¦®à¦¿à¦• à¦°à§‡à¦•à¦°à§à¦¡','Academic Records',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(750,'2','chairman_of_the_examination_board','Chairman of the Examination Board','Chairman of the Examination Board','à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¬à§‹à¦°à§à¦¡à§‡à¦° à¦šà§‡à¦¯à¦¼à¦¾à¦°à¦®à§à¦¯à¦¾à¦¨ à¦®à§‹','Chairman of the Examination Board',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(751,'2','head_of_students_affairs','Head of Students Affairs','Head of Students Affairs','à¦›à¦¾à¦¤à§à¦° à¦¬à¦¿à¦·à¦¯à¦¼à¦• à¦ªà§à¦°à¦§à¦¾à¦¨','Head of Students Affairs',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(752,'2','merit','Merit','Merit','à¦¯à§‹à¦—à§à¦¯à¦¤à¦¾','Merit',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(753,'2','merit_list','Merit List','Merit List','à¦®à§‡à¦§à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Merit List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(754,'2','academic','Academic','Academic','à¦à¦•à¦¾à¦¡à§‡à¦®à¦¿à¦•','Academic',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(755,'2','staring','Staring','Staring','à¦…à¦¨à¦¿à¦®à§‡à¦·à¦¨à§‡à¦¤à§à¦°à§‡','Staring',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(756,'2','ending','Ending','Ending','à¦¶à§‡à¦·','Ending',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(757,'2','evalution','Evalution','Evalution','Evalution','Evalution',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(758,'2','marks_sheet_of','Marks Sheet of','Marks Sheet of','à¦ªà¦¤à§à¦°à¦•à¦Ÿà¦¿ à¦šà¦¿à¦¹à§à¦¨à¦¿à¦¤ à¦•à¦°à§‡','Marks Sheet of',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(759,'2','highest_marks','Highest Marks','Highest Marks','à¦¸à¦°à§à¦¬à§‹à¦šà§à¦š à¦¨à¦®à§à¦¬à¦°','Highest Marks',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(760,'2','letter_grade','Letter Grade','Letter Grade','à¦²à§‡à¦Ÿà¦¾à¦° à¦—à§à¦°à§‡à¦¡','Letter Grade',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(761,'20','point1','Your CSV data should be in the format download file. The first line of your CSV file should be the column headers as in the table example. Also make sure that your file is UTF-8 to avoid unnecessary encoding problems.','Sus datos CSV deben estar en el archivo de descarga de formato. La primera lÃ­nea de su archivo CSV debe ser los encabezados de columna como en el ejemplo de la tabla. TambiÃ©n asegÃºrese de que su archivo sea UTF-8 para evitar problemas de codificaciÃ³n innecesarios.','Your CSV data should be in the format download file. The first line of your CSV file should be the column headers as in the table example. Also make sure that your file is UTF-8 to avoid unnecessary encoding problems.','Vos donnÃ©es CSV doivent Ãªtre dans le fichier de tÃ©lÃ©chargement au format. La premiÃ¨re ligne de votre fichier CSV doit correspondre aux en-tÃªtes de colonne, comme dans lexemple de tableau. Assurez-vous Ã©galement que votre fichier est au format UTF-8 afin dÃ©viter des problÃ¨mes de codage inutiles.',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(762,'20','point2','If the column you are trying to import is date make sure that is formatted in format Y-m-d (2018-06-06).','Si la columna que estÃ¡ intentando importar es fecha, asegÃºrese de que estÃ© formateada en el formato Y-m-d (2018-06-06).','If the column you are trying to import is date make sure that is formatted in format Y-m-d (2018-06-06).','Si la colonne que vous tentez dimporter est datÃ©e, assurez-vous quelle est formatÃ©e au format Y-m-d (2018-06-06).',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(763,'20','point3','Duplicate \"Roll Number\" (unique in section) rows will not be imported. Roll No used or not you can get from student report page search on class & section','Las filas duplicadas de \"NÃºmero de rollo\" (Ãºnico en la secciÃ³n) no se importarÃ¡n. Rollo No se utiliza o no se puede obtener de la pÃ¡gina de informe del alumno en clase y secciÃ³n','Duplicate \"Roll Number\" (unique in section) rows will not be imported. Roll No used or not you can get from student report page search on class & section','Les lignes en double \"NumÃ©ro de rouleau\" (uniques dans la section) ne seront pas importÃ©es. Pas de recherche doccasion ou non, vous pouvez obtenir une recherche de page de rapport dâ€™Ã©tudiant dans la classe et la section',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(764,'20','point4','Duplicate \"Guardian email & Guardian Phone\" rows will not be imported. Guardian email & Guardian Phone used or not you can get from student report page search on class & section','No se importarÃ¡n filas duplicadas de \"Guardian email & Guardian Phone\". El correo electrÃ³nico de Guardian & Guardian Phone utilizado o no se puede obtener de la pÃ¡gina de informe del alumno en la clase y secciÃ³n','Duplicate \"Guardian email & Guardian Phone\" rows will not be imported. Guardian email & Guardian Phone used or not you can get from student report page search on class & section','Les lignes dupliquÃ©es \"Email et tÃ©lÃ©phone Guardian\" ne seront pas importÃ©es. Guardian email & Guardian Phone utilisÃ© ou non, vous pouvez obtenir une recherche dans la page de rapport de lÃ©tudiant sur la classe et la section',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(765,'20','point5','For student Session use Id','Para el estudiante SesiÃ³n use Id','','Pour les Ã©tudiants \"Session\", utilisez lidentifiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(766,'20','point6','For student \"Gender\" use ID','Para el estudiante \"GÃ©nero\" usar ID','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦œà¦¨à§à¦¯ \"à¦²à¦¿à¦™à§à¦—\" à¦†à¦‡à¦¡à¦¿ à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦° à¦•à¦°à§à¦¨','Pour lÃ©tudiant \"Sexe\", utilisez lidentifiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(767,'20','point7','For student \"Blood Group\" use Id','Para el estudiante \"Grupo de sangre\" use ID','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦œà¦¨à§à¦¯ \"à¦¬à§à¦²à¦¾à¦¡ à¦—à§à¦°à§à¦ª\" à¦†à¦‡à¦¡à¦¿ à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦° à¦•à¦°à§à¦¨','Pour les Ã©tudiants Groupe sanguin, utilisez lId',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(768,'20','point8','For student \"Religion\" use ID','Para el estudiante \"ReligiÃ³n\" usar identificaciÃ³n','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦¦à§‡à¦° à¦œà¦¨à§à¦¯ \"à¦§à¦°à§à¦®\" à¦†à¦‡à¦¡à¦¿ à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦° à¦•à¦°à§à¦¨','Pour les Ã©tudiants Religion, utilisez votre identifiant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(769,'20','point9','For student \"Guardian Relation\" use capital O for Other, F for Father M for Mother.','Para el estudiante \"Guardian Relation\" use mayÃºscula O para Otro, F para el Padre M para la Madre.','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦° à¦œà¦¨à§à¦¯ \"à¦—à¦¾à¦°à§à¦¡à¦¿à¦¯à¦¼à¦¾à¦¨ à¦°à¦¿à¦²à§‡à¦¶à¦¨\" à¦…à¦¨à§à¦¯à§‡à¦° à¦œà¦¨à§à¦¯ à¦®à§‚à¦²à¦§à¦¨ à¦“ à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦° à¦•à¦°à§à¦¨, à¦®à¦¾à¦¯à¦¼à§‡à¦° à¦œà¦¨à§à¦¯ à¦à¦« à¦«à¦¾à¦¦à¦¾à¦° à¦à¦®à¥¤','Pour les Ã©tudiants \"Relation Gardien\", utilisez la majuscule O pour Autre, F pour PÃ¨re M pour MÃ¨re.',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(770,'20','save_bulk_students','save bulk students','guardar estudiantes a granel','à¦¬à¦¾à¦²à§à¦• à¦›à¦¾à¦¤à§à¦°à¦¦à§‡à¦° à¦¸à¦‚à¦°à¦•à§à¦·à¦£ à¦•à¦°à§à¦¨','sauver des Ã©tudiants en vrac',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(771,'20','bank_account_number','Bank Account Number','NÃºmero de cuenta bancaria','à¦¬à§à¦¯à¦¾à¦‚à¦• à¦à¦•à¦¾à¦‰à¦¨à§à¦Ÿ à¦¨à¦®à§à¦¬à¦°','NumÃ©ro de compte bancaire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(772,'20','IFSC_Code','IFSC Code','CÃ³digo IFSC','à¦†à¦‡à¦à¦«à¦à¦¸à¦¸à¦¿ à¦•à§‹à¦¡','Code IFSC',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(773,'20','payment_id','Payment Id','ID de pago','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦†à¦‡à¦¡à¦¿','ID de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(774,'20','passing_marks','Passing Marks','Marcas de paso','à¦ªà¦¾à¦¸à¦¿à¦‚ à¦®à¦¾à¦°à§à¦•à¦¸','Marques de passage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(775,'20','website','Website','Sitio web','à¦“à¦¯à¦¼à§‡à¦¬à¦¸à¦¾à¦‡à¦Ÿ','Site Internet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(776,'20','you_have','You have','Tienes','à¦¤à§‹à¦®à¦¾à¦° à¦†à¦›à§‡','Tu as',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(777,'20','new','new','nuevo','à¦¨à¦¤à§à¦¨','Nouveau',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(778,'20','notification','notification','notificaciÃ³n','à¦ªà§à¦°à¦œà§à¦žà¦¾à¦ªà¦¨','notification',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(779,'20','mark_all_as_read','Mark All As Read','Marcar todo como leido','à¦¸à¦¬à¦—à§à¦²à§‹ à¦ªà¦ à¦¿à¦¤ à¦¬à¦²à§‡ à¦¸à¦¨à¦¾à¦•à§à¦¤ à¦•à¦°','Tout marquer comme lu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(780,'20','view_profile','view profile','ver perfil','à¦ªà§à¦°à§‹à¦«à¦¾à¦‡à¦² à¦¦à§‡à¦–à§à¦¨','Voir le profil',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(781,'20','completed','Completed','Terminado','à¦¸à¦®à§à¦ªà¦¨à§à¦¨','TerminÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(782,'20','to_do_title','To Do Title','Para hacer titulo','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦® à¦•à¦°à¦¤à§‡','Titre Ã  faire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(783,'20','Designation_of_Signature_person','Designation of Signature person','DesignaciÃ³n de la persona de la firma','à¦¸à§à¦¬à¦¾à¦•à§à¦·à¦° à¦¬à§à¦¯à¦•à§à¦¤à¦¿à¦° à¦ªà¦¦à¦¬à¦¿','DÃ©signation de la personne signataire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(784,'20','student_wise','Student Wise','Estudiante sabio','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€ à¦¬à§à¦¦à§à¦§à¦¿à¦®à¦¾à¦¨','Ã‰tudiant sage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(785,'20','print','Print','impresiÃ³n','à¦›à¦¾à¦ªà¦¾','impression',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(786,'20','discount_of','Discount of','Descuento de','à¦›à¦¾à¦¡à¦¼','Remise de',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(787,'20','applied','Applied','Aplicado','à¦«à¦²à¦¿à¦¤','AppliquÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(788,'20','fees_assign','Fees Assign','Asignar cuotas','à¦«à¦¿ à¦¬à¦°à¦¾à¦¦à§à¦¦','Affectation des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(789,'20','invoice_print','Invoice print','Invoice print','à¦šà¦¾à¦²à¦¾à¦¨ à¦ªà§à¦°à¦¿à¦¨à§à¦Ÿ','Invoice print',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(790,'20','background','Background','Background','à¦ªà¦Ÿà¦­à§‚à¦®à¦¿','Background',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(791,'20','style','Style','Style','à¦¶à§ˆà¦²à§€','Style',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(792,'20','color','Color','Color','à¦°à¦™','Color',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(793,'20','select_position','Select Position','Select Position','à¦…à¦¬à¦¸à§à¦¥à¦¾à¦¨ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Select Position',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(794,'20','background_settings','Background Settings','Background Settings','à¦ªà¦Ÿà¦­à§‚à¦®à¦¿ à¦¸à§‡à¦Ÿà¦¿à¦‚à¦¸','Background Settings',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(795,'20','background_type','Background Type','Background Type','à¦ªà¦Ÿà¦­à§‚à¦®à¦¿ à¦ªà§à¦°à¦•à¦¾à¦°','Background Type',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(796,'20','course_list','Course List','Course List','à¦•à§‹à¦°à§à¦¸ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Course List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(797,'20','about_us','About Us','About Us','à¦†à¦®à¦¾à¦¦à§‡à¦° à¦¸à¦®à§à¦ªà¦°à§à¦•à§‡','About Us',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(798,'20','custom_links','Custom Links','Custom Links','à¦•à¦¾à¦¸à§à¦Ÿà¦® à¦²à¦¿à¦™à§à¦•à¦—à§à¦²à¦¿','Custom Links',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(799,'20','operation_success_message','Operation Successful','Operation Successful','à¦•à¦¾à¦œà¦Ÿà¦¿ à¦¸à¦«à¦² à¦¹à¦‡à¦¸à§‡','Operation Successful',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(800,'20','home_page','Home Page','Home Page','à¦¹à§‹à¦® à¦ªà§ƒà¦·à§à¦ à¦¾','Home Page',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(801,'20','payment_id','Payment ID','Payment ID','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦†à¦‡à¦¡à¦¿','Payment ID',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(802,'20','payment_ID','Payment ID','Payment ID','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦†à¦‡à¦¡à¦¿','Payment ID',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(803,'20','contact','Contact','Contact','à¦¯à§‹à¦—à¦¾à¦¯à§‹à¦—','Contact',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(804,'20','page','Page','Page','à¦ªà§ƒà¦·à§à¦ à¦¾','Page',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(805,'20','SampleDataEmpty','Sample Data','Sample Data','à¦¨à¦®à§à¦¨à¦¾ à¦¤à¦¥à§à¦¯','Sample Data',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(806,'20','authentication_key_SID','Authentication KEY SID','Authentication KEY SID','à¦ªà§à¦°à¦®à¦¾à¦£à§€à¦•à¦°à¦£ KEY SID','Authentication KEY SID',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(807,'20','validation_data','Data Validation','Data Validation','à¦¤à¦¥à§à¦¯ à¦¬à§ˆà¦§à¦¤à¦¾','Data Validation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(808,'20','login_permission','Login Permission','Login Permission','à¦²à¦—à¦‡à¦¨ à¦…à¦¨à§à¦®à¦¤à¦¿','Login Permission',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(809,'20','profile','Profile','Profile','à¦ªà§à¦°à§‹à¦«à¦¾à¦‡à¦²','Profile',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(810,'20','primary_color','Primary Color','Primary Color','à¦®à§Œà¦²à¦¿à¦• à¦°à¦™','Primary Color',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(811,'20','primary_color2','Primary Color 2','Primary Color 2','à¦ªà§à¦°à¦¾à¦¥à¦®à¦¿à¦• à¦°à¦™ 2','Primary Color 2',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(812,'20','primary_color3','Primary Color 3','Primary Color 3','à¦ªà§à¦°à¦¾à¦¥à¦®à¦¿à¦• à¦°à¦™ 3','Primary Color 3',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(813,'20','title_color','Title Color','Title Color','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®à§‡à¦° à¦°à¦™','Title Color',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(814,'20','text_color','Text Color','Text Color','à¦²à§‡à¦–à¦¾à¦° à¦°à¦™','Text Color',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(815,'20','sidebar_bg','Sidebar','Sidebar','à¦¸à¦¾à¦‡à¦¡à¦¬à¦¾à¦°','Sidebar',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(816,'3','change','Change','Change','à¦ªà¦°à¦¿à¦¬à¦°à§à¦¤à¦¨','Change',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(817,'3','confirm','Confirm','Confirm','à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤ à¦•à¦°à§à¦¨','Confirm',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(818,'3','restore_message','All sample data will restore in your database. Your existing data will be damage, so please take backup before restore.','All sample data will restore in your database. Your existing data will be damage, so please take backup before restore.','à¦¸à¦®à¦¸à§à¦¤ à¦¨à¦®à§à¦¨à¦¾ à¦¡à§‡à¦Ÿà¦¾ à¦†à¦ªà¦¨à¦¾à¦° à¦¡à¦¾à¦Ÿà¦¾à¦¬à§‡à¦¸à§‡ à¦ªà§à¦¨à¦°à§à¦¦à§à¦§à¦¾à¦° à¦•à¦°à¦¬à§‡à¥¤ à¦†à¦ªà¦¨à¦¾à¦° à¦¬à¦¿à¦¦à§à¦¯à¦®à¦¾à¦¨ à¦¡à§‡à¦Ÿà¦¾ à¦•à§à¦·à¦¤à¦¿ à¦¹à¦¯à¦¼à§‡ à¦¯à¦¾à¦¬à§‡, à¦¤à¦¾à¦‡ à¦ªà§à¦¨à¦°à§à¦¦à§à¦§à¦¾à¦° à¦•à¦°à¦¾à¦° à¦†à¦—à§‡ à¦¬à§à¦¯à¦¾à¦•à¦†à¦ª à¦¨à¦¿à¦¨ please','All sample data will restore in your database. Your existing data will be damage, so please take backup before restore.',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(819,'3','sample','Sample','Sample','à¦¨à¦®à§à¦¨à¦¾','Sample',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(820,'3','data','Data','Data','à¦‰à¦ªà¦¾à¦¤à§à¦¤','Data',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(821,'3','empty','Empty','Empty','à¦–à¦¾à¦²à¦¿','Empty',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(822,'3','database','Database','Database','à¦¤à¦¥à§à¦¯à¦¶à¦¾à¦²à¦¾','Database',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(823,'3','table','Table','Table','à¦Ÿà§‡à¦¬à¦¿à¦²','Table',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(824,'3','key','KEY','KEY','à¦®à§‚à¦²','KEY',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(825,'3','msg91','MSG91','MSG91','MSG91','MSG91',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(826,'3','system','System','System','à¦ªà¦¦à§à¦§à¦¤à¦¿','System',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(827,'3','home','Home','Home','à¦¬à¦¾à¦¡à¦¼à¦¿','Home',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(828,'3','front','Front','Front','à¦¸à¦¦à¦°','Front',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(829,'3','heading','Heading','Heading','à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Heading',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(830,'3','short','Short','Short','à¦¸à¦‚à¦•à§à¦·à¦¿à¦ªà§à¦¤','Short',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(831,'3','set_permission_in','Set permission in','Set permission in','à¦®à¦§à§à¦¯à§‡ à¦…à¦¨à§à¦®à¦¤à¦¿ à¦¸à§‡à¦Ÿ à¦•à¦°à§à¦¨','Set permission in',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(832,'3','home','HOME','HOME','à¦¬à¦¾à¦¡à¦¼à¦¿','HOME',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(833,'3','custom','Custom','Custom','à¦ªà§à¦°à¦¥à¦¾','Custom',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(834,'3','links','Links','Links','à¦²à¦¿à¦‚à¦•','Links',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(835,'3','link','Link','Link','à¦²à¦¿à¦‚à¦•','Link',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(836,'3','url','URL','URL','URL à¦Ÿà¦¿','URL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(837,'3','facebook','Facebook','Facebook','à¦«à§‡à¦¸à¦¬à§à¦•','Facebook',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(838,'3','behance','Behance','Behance','Behance à¦ªà§‡à¦¶à¦¾à¦—à¦¤à¦­à¦¾à¦¬à§‡','Behance',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(839,'3','dribbble','Dribbble','Dribbble','Dribbble','Dribbble',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(840,'3','twitter','Twitter','Twitter','à¦Ÿà§à¦‡à¦Ÿà¦¾à¦°','Twitter',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(841,'3','activated','Activated','Activated','à¦¸à¦•à§à¦°à¦¿à¦¯à¦¼','Activated',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(842,'3','make','Make','Make','à¦®à§‡à¦•','Make',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(843,'3','disable','Disable','Disable','à¦…à¦•à§à¦·à¦®','Disable',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(844,'3','admin_staff','Admin/Staff','Admin/Staff','à¦ªà§à¦°à¦¶à¦¾à¦¸à¦¨ à¦•à¦°à§à¦®à¦šà¦¾à¦°à§€à¦¬à§ƒà¦¨à§à¦¦','Admin/Staff',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(845,'3','access','Access','Access','à¦ªà§à¦°à¦¬à§‡à¦¶','Access',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(846,'3','enable','Enable','Enable','à¦¸à¦•à§à¦·à¦® à¦•à¦°à¦¾','Enable',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(847,'3','criteria','Criteria','Criteria','à¦¨à¦¿à¦°à§à¦£à¦¾à¦¯à¦¼à¦•','Criteria',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(848,'3','office','Office','Office','à¦¦à¦ªà§à¦¤à¦°','Office',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(849,'3','site','Site','Site','à¦¸à¦¾à¦‡à¦Ÿ','Site',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(850,'3','google','Google','Google','à¦—à§à¦—à¦²','Google',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(851,'3','ads','Ads','Ads','à¦¬à¦¿à¦œà§à¦žà¦¾à¦ªà¦¨','Ads',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(852,'3','campaign','Campaign','Campaign','à¦•à§à¦¯à¦¾à¦®à§à¦ªà§‡à¦‡à¦¨','Campaign',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(853,'3','advertisement','Advertisement','Advertisement','à¦¬à¦¿à¦œà§à¦žà¦¾à¦ªà¦¨','Advertisement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(854,'3','passive','Passive','Passive','à¦¨à¦¿à¦·à§à¦•à§à¦°à¦¿à¦¯à¦¼','Passive',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(855,'3','dead','Dead','Dead','à¦®à§ƒà¦¤','Dead',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(856,'3','won','Won','Won','à¦“à¦à¦¨','Won',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(857,'3','lost','Lost','Lost','à¦¨à¦¿à¦–à§‡à¦¾à¦à¦œ','Lost',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(858,'3','name','Name','Name','à¦¨à¦¾à¦®','Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(859,'3','salmon','Salmon','Salmon','à¦¸à§à¦¯à¦¾à¦²à¦®à¦¨ à¦®à¦¾à¦›','Salmon',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(860,'3','shashimi','Shashimi','Shashimi','Shashimi','Shashimi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(861,'3','shashimi','Shashimi','Shashimi','Shashimi','Shashimi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(862,'3','male','Male','Male','à¦ªà§à¦°à§à¦·','Male',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(863,'3','female','female','female','à¦®à¦¹à¦¿à¦²à¦¾','female',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(864,'3','add_fees','Add Fees','Add Fees','à¦«à¦¿ à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Add Fees',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(865,'3','pay_via_paystack','Pay via Paystack','Pay via Paystack','à¦ªà§‡à¦¸à§à¦Ÿà§à¦¯à¦¾à¦•à§‡à¦° à¦®à¦¾à¦§à§à¦¯à¦®à§‡ à¦ªà¦°à¦¿à¦¶à§‹à¦§ à¦•à¦°à§à¦¨','Pay via Paystack',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(866,'3','grand','Grand','Grand','à¦®à¦¹à¦¾à¦¨','Grand',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(867,'3','are_you_sure_to_detete_this_item','Are you sure to detete this item','Are you sure to detete this item','à¦†à¦ªà¦¨à¦¿ à¦•à¦¿ à¦à¦‡ à¦†à¦‡à¦Ÿà§‡à¦®à¦Ÿà¦¿ à¦¸à¦¨à¦¾à¦•à§à¦¤ à¦•à¦°à¦¾à¦° à¦¬à¦¿à¦·à¦¯à¦¼à§‡ à¦¨à¦¿à¦¶à§à¦šà¦¿à¦¤?','Are you sure to detete this item',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(868,'3','student_profile','Student Profile','Student Profile','à¦›à¦¾à¦¤à§à¦° à¦ªà§à¦°à§‹à¦«à¦¾à¦‡à¦²','Student Profile',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(869,'3','admission_number','Admission Nnumber','Admission Nnumber','à¦­à¦°à§à¦¤à¦¿ à¦¨à¦®à§à¦¬à¦°','Admission Nnumber',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(870,'3','sibling_snformation','Sibling Information','Sibling Information','à¦­à¦¾à¦‡à¦¬à§‹à¦¨ à¦¤à¦¥à§à¦¯','Sibling Information',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(871,'3','sibling_name','Sibling Name','Sibling Name','à¦¸à¦¹à§‹à¦¦à¦° à¦¨à¦¾à¦®','Sibling Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(872,'3','father_name','Fathers Name','Fatherâ€™s Name','à¦¬à¦¾à¦¬à¦¾à¦° à¦¨à¦¾à¦®','Fatherâ€™s Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(873,'3','mother_name','Mothers Name','Motherâ€™s Name','à¦®à¦¾à¦¯à¦¼à§‡à¦° à¦¨à¦¾à¦®','Motherâ€™s Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(874,'3','guardian_name','Guardianâ€™s Name','Guardianâ€™s Name','à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à§‡à¦° à¦¨à¦¾à¦®','Guardianâ€™s Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(875,'3','transport_and_dormitory_details','Transport and Dormitory Details','Transport and Dormitory Details','à¦ªà¦°à¦¿à¦¬à¦¹à¦¨ à¦à¦¬à¦‚ à¦›à¦¾à¦¤à§à¦°à¦¾à¦¬à¦¾à¦¸à§‡à¦° à¦¬à¦¿à¦¶à¦¦','Transport and Dormitory Details',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(876,'3','dormitory_name','Dormitory Name','Dormitory Name','à¦†à¦¸à§à¦¤à¦¾à¦¨à¦¾ à¦¨à¦¾à¦®','Dormitory Name',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(877,'3','other','Other','Other','à¦…à¦¨à§à¦¯à¦¾à¦¨à§à¦¯','Other',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(878,'3','upload_document','Upload Document','Upload Document','à¦¦à¦¸à§à¦¤à¦¾à¦¬à§‡à¦œ à¦†à¦ªà¦²à§‹à¦¡ à¦•à¦°à§à¦¨','Upload Document',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(879,'3','document_title','Document Title','Document Title','à¦¨à¦¥à¦¿à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Document Title',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(880,'3','others_download','Others Download','Others Download','à¦…à¦¨à§à¦¯à¦¦à§‡à¦° à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡','Others Download',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(881,'3','attendance_result','Attendance result','Attendance result','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦«à¦²à¦¾à¦«à¦²','Attendance result',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(882,'3','dormitory_room_list','Dormitory Room List','Dormitory Room List','à¦¡à¦°à¦®à§‡à¦Ÿà¦°à¦¿ à¦°à§à¦® à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Dormitory Room List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(883,'3','evaluation_date','Evaluation Date','Evaluation Date','à¦®à§‚à¦²à§à¦¯à¦¾à¦¯à¦¼à¦¨ à¦¤à¦¾à¦°à¦¿à¦–','Evaluation Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(884,'3','submission_date','Submission Date','Submission Date','à¦œà¦®à¦¾à¦¦à¦¾à¦¨à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Submission Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(885,'3','homework_date','Homework date','Homework date','à¦¹à§‹à¦® à¦“à¦¯à¦¼à¦¾à¦°à§à¦•à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Homework date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(886,'3','subject_list','Subject List','Subject List','à¦¬à¦¿à¦·à¦¯à¦¼ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Subject List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(887,'3','made','Made','Made','à¦ªà§à¦°à¦£à§€à¦¤','Made',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(888,'3','answer_script','Answer Script','Answer Script','à¦‰à¦¤à§à¦¤à¦° à¦¸à§à¦•à§à¦°à¦¿à¦ªà§à¦Ÿ','Answer Script',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(889,'3','student_book_issue','Student Book Issue','Student Book Issue','à¦›à¦¾à¦¤à§à¦° à¦¬à¦‡ à¦‡à¦¸à§à¦¯à§','Student Book Issue',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(890,'3','all_issued_book_list','All Issued Book List','All Issued Book List','à¦¸à¦®à¦¸à§à¦¤ à¦œà¦¾à¦°à¦¿ à¦¬à¦‡à¦¯à¦¼à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','All Issued Book List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(891,'3','sorry','Sorry','Sorry','à¦¦à§à¦ƒà¦–à¦¿à¦¤','Sorry',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(892,'3','there_is_no_notice_for_you','There is no notice for you','There is no notice for you','à¦†à¦ªà¦¨à¦¾à¦° à¦œà¦¨à§à¦¯ à¦•à§‹à¦¨à¦“ à¦¨à§‹à¦Ÿà¦¿à¦¶ à¦¨à§‡à¦‡','There is no notice for you',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(893,'3','available_for','Available For','Disponible para','à¦¸à¦¹à¦œà¦²à¦­à§à¦¯à§‡à¦° à¦œà¦¨à§à¦¯à§‡','Disponible pour',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(894,'3','take_online_exam','Take Online Exam','Take Online Exam','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¦à¦¿à¦¨','Take Online Exam',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(895,'3','select_subject','Select subject','Select subject','à¦¬à¦¿à¦·à¦¯à¦¼ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','Select subject',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(896,'3','mark_as_holiday','Mark as Holiday','Mark as Holiday','à¦›à§à¦Ÿà¦¿à¦° à¦¦à¦¿à¦¨ à¦¹à¦¿à¦¸à¦¾à¦¬à§‡ à¦šà¦¿à¦¹à§à¦¨à¦¿à¦¤ à¦•à¦°à§à¦¨','Mark as Holiday',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(897,'3','teacher','Teacher','Profesor','à¦¶à¦¿à¦•à§à¦·à¦•','Prof',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(898,'3','upload_content','Upload Content','Subir contenido','à¦¸à¦¾à¦®à¦—à§à¦°à§€ à¦†à¦ªà¦²à§‹à¦¡ à¦•à¦°à§à¦¨','TÃ©lÃ©charger du contenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(899,'3','assignment','Assignment','AsignaciÃ³n','à¦¨à¦¿à¦¯à¦¼à§‹à¦—','Affectation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(900,'3','content_title','Content Title','TÃ­tulo del contenido','à¦¸à¦¾à¦®à¦—à§à¦°à§€à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre du contenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(901,'3','study_material','Study Material','Material de estudio','à¦¶à¦¿à¦•à§à¦·à¦¾à¦¸à¦¾à¦®à¦—à§à¦°à§€','MatÃ©riel dÃ©tude',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(902,'3','syllabus','Syllabus','Silaba','à¦ªà¦¾à¦ à§à¦¯à¦¸à§‚à¦šà¦¿','Programme',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(903,'3','other_download','Other Downloads','Otras descargas','à¦…à¦¨à§à¦¯à¦¾à¦¨à§à¦¯ à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡','Autres tÃ©lÃ©chargements',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(904,'3','available_for','Available for','Disponible para','à¦¸à¦¹à¦œà¦²à¦­à§à¦¯à§‡à¦° à¦œà¦¨à§à¦¯à§‡','Disponible pour',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(905,'3','admin','Admin','AdministraciÃ³n','à¦…à§à¦¯à¦¾à¦¡à¦®à¦¿à¦¨','Admin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(906,'3','available_for_all_classes','Available for all programs','Disponible para todas las clases.','à¦¸à¦®à¦¸à§à¦¤ à¦¶à§à¦°à§‡à¦£à§€à¦° à¦œà¦¨à§à¦¯ à¦‰à¦ªà¦²à¦¬à§à¦§','Disponible pour toutes les classes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(907,'3','action','Action','AcciÃ³n','à¦•à¦°à§à¦®','action',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(908,'3','other_downloads_list','Other Downloads List','Lista de otras descargas','à¦…à¦¨à§à¦¯à¦¾à¦¨à§à¦¯ à¦¡à¦¾à¦‰à¦¨à¦²à§‹à¦¡à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Autres tÃ©lÃ©chargements',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(909,'4','payment','Payment','Pago','à¦ªà¦¾à¦°à¦¿à¦¶à§à¦°à¦®à¦¿à¦•','Paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(910,'4','payment_ID_Details','Payment ID Details','Detalles de ID de pago','à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ à¦†à¦‡à¦¡à¦¿ à¦¬à¦¿à¦¶à¦¦','ID de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(911,'4','mode','Mode','Modo','à¦®à§‹à¦¡','Mode',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(912,'4','amount','Amount','Cantidad','à¦ªà¦°à¦¿à¦®à¦¾à¦£','Montant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(913,'4','discount','Discount','Descuento','à¦¡à¦¿à¦¸à¦•à¦¾à¦‰à¦¨à§à¦Ÿ','Remise',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(914,'4','fine','Fine','Multa','à¦œà¦°à¦¿à¦®à¦¾à¦¨à¦¾','Bien',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(915,'4','fees_due_list','Fees Due List','Lista de cuotas','à¦«à¦¿ à¦¬à¦•à§‡à¦¯à¦¼à¦¾ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Frais Ã  payer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(916,'4','due_birth','Due Birth','Nacimiento debido','à¦œà¦¨à§à¦®à§‡à¦° à¦•à¦¾à¦°à¦£à§‡','Naissance due',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(917,'4','deposit','Deposit','Depositar','à¦†à¦®à¦¾à¦¨à¦¤','DÃ©pÃ´t',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(918,'4','balance','Balance','Equilibrar','à¦­à¦¾à¦°à¦¸à¦¾à¦®à§à¦¯','Ã‰quilibre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(919,'4','master','Master','Dominar','à¦®à¦¨à¦¿à¦¬','MaÃ®triser',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(920,'4','assign','Assign','Asignar','à¦¬à¦°à¦¾à¦¦à§à¦¦','Attribuer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(921,'4','item','Item','Ã­t','à¦ªà¦¦','Article',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(922,'4','content','content','contenido','à¦¸à¦¨à§à¦¤à§à¦·à§à¦Ÿ','contenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(923,'4','fees_code','Fees Code','CÃ³digo de Cuotas','à¦«à¦¿ à¦•à§‹à¦¡','Code des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(924,'4','code','Code','CÃ³digo','à¦•à§‹à¦¡','Code',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(925,'4','once','Once','Una vez','à¦à¦•à¦¦à¦¾','Une fois que',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(926,'4','year','Year','AÃ±o','à¦¬à¦›à¦°','AnnÃ©e',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(927,'4','previous_Session_Balance_Fees','Previous Session Balance Fees','Cuotas de balance de la sesiÃ³n anterior','à¦ªà§‚à¦°à§à¦¬à¦¬à¦°à§à¦¤à§€ à¦¸à§‡à¦¶à¦¨ à¦¬à§à¦¯à¦¾à¦²à§‡à¦¨à§à¦¸ à¦«à¦¿','Frais de solde de la session prÃ©cÃ©dente',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(928,'4','previous_balance_can_only_update_now.','Previous balance already forwarded, you can only update now.','El saldo anterior ya reenviado, solo se puede actualizar ahora.','à¦ªà§‚à¦°à§à¦¬à¦¬à¦°à§à¦¤à§€ à¦¬à§à¦¯à¦¾à¦²à§‡à¦¨à§à¦¸ à¦‡à¦¤à¦¿à¦®à¦§à§à¦¯à§‡ à¦«à¦°à¦“à¦¯à¦¼à¦¾à¦°à§à¦¡ à¦•à¦°à¦¾ à¦¹à¦¯à¦¼à§‡à¦›à§‡, à¦†à¦ªà¦¨à¦¿ à¦•à§‡à¦¬à¦²à¦®à¦¾à¦¤à§à¦° à¦à¦–à¦¨à¦‡ à¦†à¦ªà¦¡à§‡à¦Ÿ à¦•à¦°à¦¤à§‡ à¦ªà¦¾à¦°à¦¬à§‡à¦¨à¥¤','Le solde prÃ©cÃ©dent ayant dÃ©jÃ  Ã©tÃ© transfÃ©rÃ©, vous ne pouvez mettre Ã  jour que maintenant.',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(929,'4','fees_collection','Fees Collection','ColecciÃ³n de tarifas','à¦«à¦¿ à¦¸à¦‚à¦—à§à¦°à¦¹','Collection de frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(930,'4','collect_fees','Collect Fees','Cobrar honorarios','à¦«à¦¿ à¦¸à¦‚à¦—à§à¦°à¦¹ à¦•à¦°à§à¦¨','Recueillir les frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(931,'4','search_fees_payment','Search Fees Payment','Pago de tarifas de bÃºsqueda','à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨à§‡à¦° à¦ªà§‡à¦®à§‡à¦¨à§à¦Ÿ','Recherche des frais de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(932,'4','search_fees_due','Search Fees Due','Tarifas de bÃºsqueda vencidas','à¦ªà¦¾à¦°à¦¿à¦¶à§à¦°à¦®à¦¿à¦• à¦«à¦¿','Frais de recherche dus',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(933,'4','fees_master','Fees Master','Honorarios maestro','à¦«à¦¿ à¦®à¦¾à¦¸à§à¦Ÿà¦¾à¦°','Frais MaÃ®tre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(934,'4','fees_group','Fees Group','Grupo de tarifas','à¦«à¦¿ à¦—à§à¦°à§à¦ª','Groupe de frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(935,'4','fees_type','Fees Type','Tipo de Cuotas','à¦«à¦¿ à¦ªà§à¦°à¦•à¦¾à¦°','Type de frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(936,'4','fees_discount','Fees Discount','Tarifas de descuento','à¦«à¦¿ à¦›à¦¾à¦¡à¦¼','Remise des frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(937,'4','fees_forward','Fees Carry Forward','Cuotas de llevar adelante','à¦«à¦¿ à¦«à¦°à¦“à¦¯à¦¼à¦¾à¦°à§à¦¡ à¦¬à¦¹à¦¨','Frais reportÃ©s',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(938,'5','accounts','Accounts','Cuentas','à¦…à§à¦¯à¦¾à¦•à¦¾à¦‰à¦¨à§à¦Ÿà¦¸','Comptes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(939,'5','profit','Profit','Lucro','à¦®à§à¦¨à¦¾à¦«à¦¾','Profit',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(940,'5','income','Income','Ingresos','à¦†à¦¯à¦¼','le revenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(941,'5','expense','Expense','Gastos','à¦¬à§à¦¯à¦¯à¦¼','Frais',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(942,'5','chart_of_account','Chart Of Account','Plan de cuentas','à¦…à§à¦¯à¦¾à¦•à¦¾à¦‰à¦¨à§à¦Ÿ à¦šà¦¾à¦°à§à¦Ÿ','Charte dutilisation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(943,'5','payment_method','Payment Method','MÃ©todo de pago','à¦®à§‚à¦²à§à¦¯à¦ªà¦°à¦¿à¦¶à§‹à¦§ à¦ªà¦¦à§à¦§à¦¤à¦¿','Mode de paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(944,'5','bank_account','Bank Account','Cuenta bancaria','à¦¬à§à¦¯à¦¾à¦‚à¦• à¦¹à¦¿à¦¸à¦¾à¦¬','Compte bancaire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(945,'5','a_c_Head','A/C Head','A / C Head','à¦ / à¦¸à¦¿ à¦¹à§‡à¦¡','TÃªte A / C',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(946,'5','add_expense','Add Expense','AÃ±adir gastos','à¦¬à§à¦¯à¦¯à¦¼ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter une dÃ©pense',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(947,'5','search_income_expense','Search Income/Expense','Buscar ingresos / gastos','à¦‡à¦¨à¦•à¦¾à¦® / à¦¬à§à¦¯à¦¯à¦¼ à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦•à¦°à§à¦¨','Recherche revenu / dÃ©pense',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(948,'5','item_Receive','Item Receive','El artÃ­culo recibe','à¦†à¦‡à¦Ÿà§‡à¦® à¦°à¦¿à¦¸à¦¿à¦­','Point recevoir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(949,'5','income_head','Income Head','Jefe de ingresos','à¦‡à¦¨à¦•à¦¾à¦® à¦¹à§‡à¦¡','Chef de revenu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(950,'5','sells','Sells','Vende','à¦¬à¦¿à¦•à§à¦°à¦¿','Vend',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(951,'5','grand_total','Grand Total','Gran total','à¦¸à¦°à§à¦¬à¦®à§‹à¦Ÿ','somme finale',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(952,'5','expense_head','Expense Head','Cabeza de gastos','à¦¬à§à¦¯à¦¯à¦¼ à¦ªà§à¦°à¦§à¦¾à¦¨','Chef de dÃ©penses',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(953,'5','purchase','Purchase','Compra','à¦•à§à¦°à¦¯à¦¼','achat',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(954,'5','from','From','Desde','à¦¥à§‡à¦•à§‡','De',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(955,'5','head','Head','Cabeza','à¦®à¦¾à¦¥à¦¾','TÃªte',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(956,'5','method','Method','MÃ©todo','à¦ªà¦¦à§à¦§à¦¤à¦¿','MÃ©thode',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(957,'5','account_name','Account Name','Nombre de la cuenta','à¦¹à¦¿à¦¸à¦¾à¦¬à§‡à¦° à¦¨à¦¾à¦®','Nom du compte',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(958,'5','opening_balance','Opening Balance','Saldo de apertura','à¦–à§‹à¦²à¦¾à¦° à¦­à¦¾à¦°à¦¸à¦¾à¦®à§à¦¯','Solde douverture',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(959,'5','account','Account','Cuenta','à¦¹à¦¿à¦¸à¦¾à¦¬','Compte',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(960,'6','human_resource','Human resource','Recursos humanos','à¦®à¦¾à¦¨à¦¬ à¦¸à¦®à§à¦ªà¦¦','Ressource humaine',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(961,'6','staff_directory','Staff Directory','Directorio de Personal','à¦¸à§à¦Ÿà¦¾à¦« à¦¡à¦¿à¦°à§‡à¦•à§à¦Ÿà¦°à¦¿','RÃ©pertoire personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(962,'6','staff_attendance','Staff Attendance','Asistencia del personal','à¦•à¦°à§à¦®à§€à¦¦à§‡à¦° à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿','PrÃ©sence du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(963,'6','staff_attendance_report','Staff Attendance Report','Informe de asistencia del personal','à¦•à¦°à§à¦®à§€à¦¦à§‡à¦° à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦°à¦¿à¦ªà§‹à¦°à§à¦Ÿ','Rapport de prÃ©sence du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(964,'6','payroll','Payroll','NÃ³mina de sueldos','à¦¬à§‡à¦¤à¦¨à§‡à¦°','Paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(965,'6','payroll_report','Payroll Report','Informe de nÃ³mina','à¦¬à§‡à¦¤à¦¨ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Rapport de paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(966,'6','approve_leave_request','Approve Leave Request','Aprobar Solicitud de Licencia','à¦›à§à¦Ÿà¦¿à¦° à¦…à¦¨à§à¦°à§‹à¦§ à¦…à¦¨à§à¦®à§‹à¦¦à¦¨ à¦•à¦°à§à¦¨','Approuver la demande de congÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(967,'6','apply_leave','Apply Leave','Aplicar licencia','à¦›à§à¦Ÿà¦¿ à¦ªà§à¦°à¦¯à¦¼à§‹à¦— à¦•à¦°à§à¦¨','Appliquer congÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(968,'6','leave_type','Leave type','Dejar tipo','à¦ªà§à¦°à¦¸à§à¦¥à¦¾à¦¨ à¦ªà§à¦°à¦•à¦¾à¦°','Laisser type',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(969,'6','department','Department','Departamento','à¦¬à¦¿à¦­à¦¾à¦—','dÃ©partement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(970,'6','designation','Designation','Designacion','à¦‰à¦ªà¦¾à¦§à¦¿','La dÃ©signation',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(971,'6','staff_list','Staff List','Lista de personal','à¦¸à§à¦Ÿà¦¾à¦« à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(972,'6','add_staff','Add Staff','AÃ±adir personal','à¦¸à§à¦Ÿà¦¾à¦« à¦¯à§‹à¦— à¦•à¦°à§à¦¨','Ajouter du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(973,'6','search_by_staff_id','Search By Staff Id','BÃºsqueda por identificaciÃ³n del personal','à¦¸à§à¦Ÿà¦¾à¦« à¦†à¦‡à¦¡à¦¿ à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦…à¦¨à§à¦¸à¦¨à§à¦§à¦¾à¦¨ à¦•à¦°à§à¦¨','Rechercher par ID de personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(974,'6','staff','Staff','Personal','à¦•à¦°à§à¦®à§€','Personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(975,'6','select_role','Select Role','Seleccionar rol','à¦­à§‚à¦®à¦¿à¦•à¦¾ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un rÃ´le',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(976,'6','generate_payroll','Generate Payroll','Generar NÃ³mina','à¦ªà§‡-à¦°à§‹à¦² à¦‰à¦¤à§à¦ªà¦¨à§à¦¨ à¦•à¦°à§à¦¨','GÃ©nÃ©rer la paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(977,'6','generated','Generate','Generar','à¦œà§‡à¦¨à¦¾à¦°à§‡à¦Ÿ à¦•à¦°à§à¦¨','produire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(978,'6','paid','Paid','Pagado','à¦ªà§‡à¦‡à¦¡','PayÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(979,'6','not','Not','No','à¦¨à¦¾','ne pas',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(980,'6','proceed_to_pay','Proceed to Pay','Proceda a pagar','à¦ªà§à¦°à¦¦à¦¾à¦¨ à¦•à¦°à¦¤à§‡ à¦à¦—à¦¿à¦¯à¦¼à§‡ à¦¯à¦¾à¦¨','ProcÃ©der au paiement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(981,'6','view_payslip','View Payslip','Ver recibo de sueldo','à¦ªà§‡à¦‡à¦²à¦¿à¦ª à¦¦à§‡à¦–à§à¦¨','Voir fiche de paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(982,'6','month','Month','Mes','à¦®à¦¾à¦¸','Mois',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(983,'6','payslip','Payslip','Boleta de pago','à¦¸à§à¦²à¦¿à¦ªà§‡','Fiche de paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(984,'6','basic_salary','Basic Salary','Salario base','à¦®à§‚à¦² à¦¬à§‡à¦¤à¦¨','Salaire de base',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(985,'6','earnings','Earnings','Ganancias','à¦‰à¦ªà¦¾à¦°à§à¦œà¦¨','Gains',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(986,'6','deductions','Deductions','Deducciones','à¦•à¦°à§à¦¤à¦¨','DÃ©ductions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(987,'6','gross_salary','Gross Salary','Salario bruto','à¦®à§‹à¦Ÿ à¦¬à§‡à¦¤à¦¨','Salaire brut',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(988,'6','tax','Tax','Impuesto','à¦•à¦°','ImpÃ´t',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(989,'6','net_salary','Net Salary','Sueldo neto','à¦®à§‹à¦Ÿ à¦¬à§‡à¦¤à¦¨','Salaire net',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(990,'6','to','To','A','à¦ªà§à¦°à¦¤à¦¿','Ã€',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(991,'6','apply_date','Apply date','Fecha de aplicaciÃ³n','à¦†à¦¬à§‡à¦¦à¦¨à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date dapplication',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(992,'6','pending','Pending','Pendiente','à¦¬à¦¿à¦šà¦¾à¦°à¦¾à¦§à§€à¦¨','en attendant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(993,'6','approved','Approved','Aprobado','à¦…à¦¨à§à¦®à§‹à¦¦à¦¿à¦¤','ApprouvÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(994,'6','cancelled','Cancelled','Cancelado','à¦¬à¦¾à¦¤à¦¿à¦² à¦•à¦°à¦¾ à¦¹à¦¯à¦¼à§‡à¦›à§‡','AnnulÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(995,'6','leave_from','Leave From','Dejar de','à¦¥à§‡à¦•à§‡ à¦¤à§à¦¯à¦¾à¦—','Partir de',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(996,'6','leave_to','Leave to','Dejar','à¦›à§‡à¦¡à¦¼à§‡','Laisser Ã ',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(997,'6','reason','Reason','RazÃ³n','à¦•à¦¾à¦°à¦£','Raison',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(998,'6','leave','Leave','Salir','à¦›à§à¦Ÿà¦¿','Laisser',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(999,'6','type_name','Type Name','Escribe un nombre','à¦¨à¦¾à¦® à¦Ÿà¦¾à¦‡à¦ª à¦•à¦°à§à¦¨','Nom du type',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1000,'6','total_days','Total Days','DÃ­as totales','à¦®à§‹à¦Ÿ à¦¦à¦¿à¦¨','Nombre total de jours',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1001,'6','leave_type_list','Leave Type List','Deja la lista de tipos','à¦ªà§à¦°à¦•à¦¾à¦°à§‡à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾ à¦›à§‡à¦¡à¦¼à§‡ à¦¦à¦¿à¦¨','Quitter la liste des types',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1002,'6','departments','Departments','Departamentos','à¦¬à¦¿à¦­à¦¾à¦—','DÃ©partements',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1003,'6','department_name','Department Name','Nombre de Departamento','à¦¬à¦¿à¦­à¦¾à¦— à¦¨à¦¾à¦®','Nom du dÃ©partement',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1004,'6','designations','Designations','Designaciones','à¦ªà§à¦°à¦¶à¦¿à¦•à§à¦·à¦£à§‡','DÃ©signations',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1005,'6','staffs_payroll','Staffs Payroll','NÃ³mina de personal','à¦¸à§à¦Ÿà¦¾à¦«à¦¦à§‡à¦° à¦¬à§‡à¦¤à¦¨','Personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1006,'6','staff_no','Staff No','Personal No','à¦¸à§à¦Ÿà¦¾à¦« à¦¨à¦‚','NumÃ©ro du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1007,'6','date_of_joining','Date of Joining','Fecha de inscripciÃ³n','à¦¯à§‹à¦—à¦¦à¦¾à¦¨à§‡à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date dadhÃ©sion',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1008,'6','value','Value','Valor','à¦®à¦¾à¦¨','Valeur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1009,'6','payroll_summary','Payroll Summary','Resumen de nÃ³mina','à¦ªà§‡-à¦°à§‹à¦² à¦¸à¦‚à¦•à§à¦·à¦¿à¦ªà§à¦¤à¦¸à¦¾à¦°','RÃ©sumÃ© de la paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1010,'6','calculate','calculate','calcular','à¦•à§à¦¯à¦¾à¦²à¦•à§à¦²à§‡à¦Ÿ','calculer',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1011,'6','earning','Earning','Ganador','à¦°à§‹à¦œà¦—à¦¾à¦°','Revenus',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1012,'6','deduction','Deduction','DeducciÃ³n','à¦¸à¦¿à¦¦à§à¦§à¦¾à¦¨à§à¦¤à¦—à§à¦°à¦¹à¦£','DÃ©duction',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1013,'6','submit','Submit','Enviar','à¦œà¦®à¦¾ à¦¦à¦¿à¦¨','Soumettre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1014,'6','edit_staff','Edit Staff','Editar Personal','à¦•à¦°à§à¦®à§€à¦¦à§‡à¦° à¦¸à¦®à§à¦ªà¦¾à¦¦à¦¨à¦¾ à¦•à¦°à§à¦¨','Modifier le personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1015,'6','basic_info','Basic Info','InformaciÃ³n bÃ¡sica','à¦®à§Œà¦²à¦¿à¦• à¦¤à¦¥à§à¦¯','Informations de base',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1016,'6','staff_number','Staff Number','Numero de personal','à¦¸à§à¦Ÿà¦¾à¦« à¦¨à¦®à§à¦¬à¦°','NumÃ©ro du personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1017,'6','emergency_mobile','Emergency Mobile','MÃ³vil de emergencia','à¦œà¦°à§à¦°à§€ à¦®à§‹à¦¬à¦¾à¦‡à¦²','Mobile durgence',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1018,'6','current_address','Current Address','Direccion actual','à¦¬à¦°à§à¦¤à¦®à¦¾à¦¨ à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse actuelle',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1019,'6','permanent_address','Permanent Address','direcciÃ³n permanente','à¦¸à§à¦¥à¦¾à¦¯à¦¼à§€ à¦ à¦¿à¦•à¦¾à¦¨à¦¾','Adresse permanente',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1020,'6','qualifications','Qualifications','Calificaciones','à¦¯à§‹à¦—à§à¦¯à¦¤à¦¾','Qualifications',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1021,'6','experience','Experience','Experiencia','à¦…à¦­à¦¿à¦œà§à¦žà¦¤à¦¾','ExpÃ©rience',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1022,'6','payroll_details','Payroll Details','Detalles de la nÃ³mina','à¦¬à§‡à¦¤à¦¨à§‡à¦° à¦¬à¦¿à¦¶à¦¦','DÃ©tails de la paie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1023,'6','epf_no','EPF NO','EPF NO','à¦‡à¦ªà¦¿à¦à¦« à¦¨à¦‚','EPF NO',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1024,'6','bank_info_details','Bank Info Details','Detalles de la informaciÃ³n del banco','à¦¬à§à¦¯à¦¾à¦‚à¦• à¦¤à¦¥à§à¦¯ à¦¬à¦¿à¦¶à¦¦','Informations bancaires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1025,'6','bank_account_name','Bank Account Name','Nombre de la cuenta bancaria','à¦¬à§à¦¯à¦¾à¦‚à¦• à¦¹à¦¿à¦¸à¦¾à¦¬ à¦¨à¦¾à¦®','Nom du compte bancaire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1026,'6','branch_name','Branch Name','Nombre de la rama','à¦¶à¦¾à¦–à¦¾à¦° à¦¨à¦¾à¦®','Nom de la filiale',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1027,'6','social_links_details','Social Links Details','Detalles de enlaces sociales','à¦¸à¦¾à¦®à¦¾à¦œà¦¿à¦• à¦²à¦¿à¦™à§à¦•à§‡à¦° à¦¬à¦¿à¦¶à¦¦','Liens sociaux DÃ©tails',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1028,'6','facebook_url','Facebook Url','Facebook URL','à¦«à§‡à¦¸à¦¬à§à¦• à¦‡à¦‰à¦†à¦°','Ladresse URL de Facebook',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1029,'6','twitter_url','Twitter Url','URL de Twitter','à¦Ÿà§à¦‡à¦Ÿà¦¾à¦° à¦‡à¦‰à¦†à¦°à¦à¦²','URL de Twitter',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1030,'6','linkedin_url','Linkedin Url','Linkedin url','à¦²à¦¿à¦™à§à¦•à¦¡à¦¿à¦¨ à¦‰à¦°à¦²','URL de Linkedin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1031,'6','instragram_url','Instragram Url','Url de instagram','à¦‡à¦¨à¦¸à§à¦Ÿà§à¦°à¦—à§à¦°à¦¾à¦® à¦‡à¦‰à¦°à¦¾à¦²','URL Instragram',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1032,'6','update_staff','Update Staff','Personal de actualizaciÃ³n','à¦†à¦ªà¦¡à§‡à¦Ÿ à¦¸à§à¦Ÿà¦¾à¦«','Mettre Ã  jour le personnel',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1033,'6','pending_leave_request','Pending Leave','Pending Leave','à¦®à§à¦²à¦¤à§à¦¬à¦¿ à¦›à§à¦Ÿà¦¿','Pending Leave',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1034,'7','leave','Leave','Salir','à¦›à§à¦Ÿà¦¿','Laisser',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1035,'7','leave_define','Leave Define','Dejar definir','à¦›à§‡à¦¡à¦¼à§‡ à¦¦à¦¿à¦¨','Quitter DÃ©finir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1036,'7','my_remaining_leaves','My Remaining Leaves','Mis hojas restantes','à¦†à¦®à¦¾à¦° à¦¬à¦¾à¦•à§€ à¦ªà¦¾à¦¤à¦¾','Mes feuilles restantes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1037,'7','remaining_days','Remaining Days','DÃ­as restantes','à¦¬à¦¾à¦•à¦¿ à¦¦à¦¿à¦¨à¦—à§à¦²à§‹','Jours restants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1038,'7','extra_taken','Extra Taken','Extra Taken','à¦…à¦¤à¦¿à¦°à¦¿à¦•à§à¦¤ à¦¨à§‡à¦“à¦¯à¦¼à¦¾','Extra pris',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1039,'7','total_days','Total Days','DÃ­as totales','à¦®à§‹à¦Ÿ à¦¦à¦¿à¦¨','Nombre total de jours',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1040,'7','days','Days','Dias','à¦¦à¦¿à¦¨','JournÃ©es',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1041,'8','examination','Assignment','Examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾','Examen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1042,'8','exam','Assignment','Examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾','Examen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1043,'8','add_exam_type','Add Exam Type','AÃ±adir tipo de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦§à¦°à¦£ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter un type dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1044,'8','exam_schedule','Exam Schedule','Horario del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¸à¦®à¦¯à¦¼à¦¸à§‚à¦šà§€','Calendrier des examens',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1045,'8','marks_register','Marks Register','Registro de marcas','à¦šà¦¿à¦¹à§à¦¨ à¦¨à¦¿à¦¬à¦¨à§à¦§','Registre des marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1046,'8','final_result','Final Result','Final Result','à¦¸à¦°à§à¦¬à¦¶à§‡à¦· à¦«à¦²à¦¾à¦«à¦²','Final Result',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1047,'8','seat_plan','Seat Plan','Plan de asiento','à¦†à¦¸à¦¨ à¦ªà¦°à¦¿à¦•à¦²à§à¦ªà¦¨à¦¾','Plan de siÃ¨ge',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1048,'8','exam_attendance','Exam Attendance','Examen de asistencia','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿','PrÃ©sence Ã  lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1049,'8','with','With','With','à¦¸à¦™à§à¦—à§‡','With',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1050,'8','marks_grade','Marks Grade','Nota de calificaciones','à¦—à§à¦°à§‡à¦¡ à¦šà¦¿à¦¹à§à¦¨à¦¿à¦¤','Note de marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1051,'8','custom_result_setting','Custom Result Setting','Custom Result Setting','à¦•à¦¾à¦¸à§à¦Ÿà¦® à¦«à¦²à¦¾à¦«à¦² à¦¸à§‡à¦Ÿ','Custom Result Setting',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1052,'8','send_marks_by_sms','Send Marks By Sms','Enviar marcas por sms','à¦à¦¸à¦à¦®à¦à¦¸ à¦¦à§à¦¬à¦¾à¦°à¦¾ à¦šà¦¿à¦¹à§à¦¨ à¦ªà§à¦°à§‡à¦°à¦£ à¦•à¦°à§à¦¨','Envoyer des marques par sms',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1053,'8','percentage','Percentage','Percentage','à¦¶à¦¤à¦•à¦°à¦¾ à¦¹à¦¾à¦°','Percentage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1054,'8','question_group','Question Group','Grupo de preguntas','à¦ªà§à¦°à¦¶à§à¦¨ à¦—à§à¦°à§à¦ª','Groupe de questions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1055,'8','with_out','With out','With out','à¦¬à¦¿à¦¨à¦¾','With out',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1056,'8','question_bank','Question Bank','Banco de preguntas','à¦ªà§à¦°à¦¶à§à¦¨ à¦¬à§à¦¯à¦¾à¦‚à¦•','Banque de questions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1057,'8','online_exam','Online Exam','Examen en linea','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦ªà¦°à§€à¦•à§à¦·à¦¾','Examen en ligne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1058,'8','exam_type','Exam Type','Tipo de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦§à¦°à¦£','Type dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1059,'8','exam_setup','Exam Setup','ConfiguraciÃ³n del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1060,'8','exam_name','Exam Name','Nombre del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¨à¦¾à¦®','Nom de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1061,'8','sl','Sl','Sl','à¦•à§à¦°à¦®à¦¿à¦•','Sl',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1062,'8','select_subjects','Select Subjects','Temas seleccionados','à¦¬à¦¿à¦·à¦¯à¦¼ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner des sujets',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1063,'8','exam_mark','Exam Mark','Marca de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦šà¦¿à¦¹à§à¦¨','Marque dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1064,'8','add_mark_distributions','Add Mark Distributions','AÃ±adir Distribuciones de Marca','à¦šà¦¿à¦¹à§à¦¨ à¦¬à¦¿à¦¤à¦°à¦£ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','Ajouter des distributions de marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1065,'8','exam_title','Exam Title','TÃ­tulo del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¶à¦¿à¦°à§‹à¦¨à¦¾à¦®','Titre de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1066,'8','ct_AT_Exam','Name','Nombre','à¦¨à¦¾à¦®','prÃ©nom',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1067,'8','mark_distribution','Mark Distribution','DistribuciÃ³n de marcas','à¦šà¦¿à¦¹à§à¦¨ à¦¬à¦¿à¦¤à¦°à¦£','Distribution des marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1068,'8','subject','Unit','Tema','à¦¬à¦¿à¦·à¦¯à¦¼','Assujettir',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1069,'8','total_mark','Total Mark','Marca total','à¦®à§‹à¦Ÿ à¦šà¦¿à¦¹à§à¦¨','Total Mark',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1070,'8','view_status','View Status','Ver el estado de','à¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦¦à§‡à¦–à§à¦¨','Voir le statut',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1071,'8','copy','Copy','Dupdo','à¦•à¦ªà¦¿','Copie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1072,'8','add_exam_schedule','add Exam Schedule','aÃ±adir horario de exÃ¡menes','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¸à¦®à¦¯à¦¼à¦¸à§‚à¦šà§€ à¦¯à§à¦•à§à¦¤ à¦•à¦°à§à¦¨','ajouter un calendrier dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1073,'8','FALSE','FALSE','FALSE','à¦®à¦¿à¦¥à§à¦¯à¦¾','FALSE',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1074,'8','exam_list','Exam List','Lista de exÃ¡menes','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1075,'8','archive','Archive','Archive','à¦¸à¦‚à¦°à¦•à§à¦·à¦¾à¦£à¦¾à¦—à¦¾à¦°','Archive',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1076,'8','marks','Marks','Marcas','à¦šà¦¿à¦¹à§à¦¨','Des notes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1077,'8','official','Official','Official','à¦¦à¦¾à¦ªà§à¦¤à¦°à¦¿à¦•','Official',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1078,'8','select_exam','Select Assignment','Seleccionar examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez un examen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1079,'8','transcript','Transcript','Transcript','à¦ªà§à¦°à¦¤à¦¿à¦²à¦¿à¦ªà¦¿','Transcript',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1080,'8','percent','Percent','Por ciento','à¦¶à¦¤à¦¾à¦‚à¦¶','Pour cent',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1081,'8','previous','Previous','Previous','à¦†à¦—à§‡','Previous',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1082,'8','seat_plan_report','Seat Plan Report','Informe del plan de asiento','à¦†à¦¸à¦¨ à¦ªà¦°à¦¿à¦•à¦²à§à¦ªà¦¨à¦¾ à¦ªà§à¦°à¦¤à¦¿à¦¬à§‡à¦¦à¦¨','Rapport de plan de siÃ¨ge',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1083,'8','record','Record','Record','à¦¨à¦¥à¦¿','Record',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1084,'8','assign_students','Assign Students','Asignar estudiantes','à¦›à¦¾à¦¤à§à¦° à¦¨à¦¿à¦¯à¦¼à§‹à¦— à¦•à¦°à§à¦¨','Attribuer des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1085,'8','search_by_year','Year','Year','à¦¬à¦›à¦°','Year',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1086,'8','start_end_time','start-end time','hora de inicio y fin','à¦¶à§à¦°à§à¦° à¦¸à¦®à¦¯à¦¼','heure de dÃ©but',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1087,'8','button','Button','Button','à¦¬à§‹à¦¤à¦¾à¦®','Button',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1088,'8','total_students','Total Students','Total de estudiantes','à¦®à§‹à¦Ÿ à¦›à¦¾à¦¤à§à¦°','Total des Ã©tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1089,'8','exam_not_found','Exam schedule is not available.','Exam schedule is not available.','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¸à¦®à¦¯à¦¼à¦¸à§‚à¦šà§€ à¦ªà¦¾à¦“à¦¯à¦¼à¦¾ à¦¯à¦¾à¦¯à¦¼ à¦¨à¦¾à¥¤','Exam schedule is not available.',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1090,'8','attendance_create','Attendance Create','Asistencia Crear','à¦‰à¦ªà¦¸à§à¦¥à¦¿à¦¤à¦¿ à¦¤à§ˆà¦°à¦¿ à¦•à¦°à§à¦¨','PrÃ©sence CrÃ©er',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1091,'8','biometrics','Biometrics','Biometrics','à¦¬à¦¾à¦¯à¦¼à§‹à¦®à§‡à¦Ÿà§à¦°à¦¿à¦•à§à¦¸','Biometrics',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1092,'8','grade','Grade','Grado','à¦¶à§à¦°à§‡à¦£à§€','QualitÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1093,'8','consider_start_time','Consider Start Time','Consider Start Time','à¦¶à§à¦°à§à¦° à¦¸à¦®à¦¯à¦¼ à¦¬à¦¿à¦¬à§‡à¦šà¦¨à¦¾ à¦•à¦°à§à¦¨','Consider Start Time',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1094,'8','gpa','GPA','GPA','à¦œà¦¿à¦ªà¦¿à¦','GPA',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1095,'8','consider_end_time','Consider End Time','Consider End Time','à¦¸à¦®à¦¾à¦ªà§à¦¤à¦¿à¦° à¦¸à¦®à¦¯à¦¼ à¦¬à¦¿à¦¬à§‡à¦šà¦¨à¦¾ à¦•à¦°à§à¦¨','Consider End Time',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1096,'8','percent_from','Percent From','Porcentaje de','à¦¥à§‡à¦•à§‡ à¦¶à¦¤à¦¾à¦‚à¦¶','Pour cent de',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1097,'8','PDF','PDF','PDF','à¦ªà¦¿à¦¡à¦¿à¦à¦«','PDF',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1098,'8','percent_upto','Percent Upto','Por ciento hasta','à¦¶à¦¤à¦•à¦°à¦¾ à¦ªà¦°à§à¦¯à¦¨à§à¦¤','Pourcentage jusquÃ ',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1099,'8','evalution','Evalution','Evalution','Evalution','Evalution',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1100,'8','send_marks_via_SMS','Send Marks Via SMS','Enviar marcas a travÃ©s de SMS','à¦à¦¸à¦à¦®à¦à¦¸à§‡à¦° à¦®à¦¾à¦§à§à¦¯à¦®à§‡ à¦šà¦¿à¦¹à§à¦¨à¦—à§à¦²à¦¿ à¦ªà§à¦°à§‡à¦°à¦£ à¦•à¦°à§à¦¨','Envoyer des marques par SMS',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1101,'8','Ending','Ending','Ending','à¦¶à§‡à¦·','Ending',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1102,'8','select_receiver','Select Receiver','Seleccionar Receptor','à¦°à¦¿à¦¸à¦¿à¦­à¦¾à¦° à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez le destinataire',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1103,'8','final_result','Final Result','Final Result','à¦¸à¦°à§à¦¬à¦¶à§‡à¦· à¦«à¦²à¦¾à¦«à¦²','Final Result',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1104,'8','students','Students','Estudiantes','à¦¶à¦¿à¦•à§à¦·à¦¾à¦°à§à¦¥à§€à¦°à¦¾','Ã‰tudiants',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1105,'8','third_term','Third Term','Third Term','à¦¤à§ƒà¦¤à§€à¦¯à¦¼ à¦®à§‡à¦¯à¦¼à¦¾à¦¦','Third Term',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1106,'8','select_group','Select Group','Selecciona grupo','à¦—à§à¦°à§à¦ª à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionner un groupe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1107,'8','second_term','Second Term','Second Term','à¦¦à§à¦¬à¦¿à¦¤à§€à¦¯à¦¼ à¦®à§‡à¦¯à¦¼à¦¾à¦¦à§‡','Second Term',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1108,'8','question_type','Question Type','tipo de pregunta','à¦ªà§à¦°à¦¶à§à¦¨à§‡à¦° à¦§à¦°à¦¨','Type de question',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1109,'8','first_term','First term','First term','à¦ªà§à¦°à¦¥à¦® à¦ªà¦•à§à¦·','First term',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1110,'8','multiple_choice','Multiple Choice','OpciÃ³n multiple','à¦¬à¦¹à§ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨à§€','Choix multiple',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1111,'8','create_class_routine','Create class routine','Create class routine','à¦¶à§à¦°à§‡à¦£à§€à¦° à¦°à§à¦Ÿà¦¿à¦¨ à¦¤à§ˆà¦°à¦¿ à¦•à¦°à§à¦¨','Create class routine',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1112,'8','true_false','True False','Verdadero Falso','à¦¸à¦¤à§à¦¯ à¦®à¦¿à¦¥à§à¦¯à¦¾','Vrai faux',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1113,'8','optional','Optional','Optional','à¦à¦šà§à¦›à¦¿à¦•','Optional',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1114,'8','fill_in_the_blanks','Fill in the Blanks','Rellenar los espacios en blanco','à¦¶à§à¦¨à§à¦¯à¦¸à§à¦¤à¦¾à¦¨ à¦ªà§‚à¦°à¦£','Remplir les espaces vides',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1115,'8','question','Question','Pregunta','à¦ªà§à¦°à¦¶à§à¦¨','Question',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1116,'8','number_of_options','Number Of Options','NÃºmero de opciones','à¦¬à¦¿à¦•à¦²à§à¦ªà§‡à¦° à¦¸à¦‚à¦–à§à¦¯à¦¾','Nombre doptions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1117,'8','with','With','With','à¦¸à¦™à§à¦—à§‡','With',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1118,'8','create','Create','Crear','à¦¸à§ƒà¦·à§à¦Ÿà¦¿','CrÃ©er',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1119,'8','with_out','With out','With out','à¦¬à¦¿à¦¨à¦¾','With out',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1120,'8','option','option','opciÃ³n','à¦ªà¦›à¦¨à§à¦¦','option',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1121,'8','true','TRUE','CIERTO','à¦¸à¦¤à§à¦¯','VRAI',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1122,'8','false','FALSE','FALSO','à¦®à¦¿à¦¥à§à¦¯à¦¾','FAUX',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1123,'8','suitable_words','Suitable Words','Palabras adecuadas','à¦‰à¦ªà¦¯à§à¦•à§à¦¤ à¦¶à¦¬à§à¦¦','Mots convenables',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1124,'8','start_time','Start Time','Hora de inicio','à¦¸à¦®à¦¯à¦¼ à¦¶à§à¦°à§','Heure de dÃ©but',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1125,'8','end_time','End time','Hora de finalizaciÃ³n','à¦¶à§‡à¦· à¦¸à¦®à¦¯à¦¼','Heure de fin',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1126,'8','minimum_percentage','Minimum Percentage','Porcentaje mÃ­nimo','à¦¸à¦°à§à¦¬à¦¨à¦¿à¦®à§à¦¨ à¦¶à¦¤à¦¾à¦‚à¦¶','Pourcentage minimum',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1127,'8','instruction','Instruction','InstrucciÃ³n','à¦¨à¦¿à¦°à§à¦¦à§‡à¦¶','Instruction',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1128,'8','exam_date','Exam Date','Fecha de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¤à¦¾à¦°à¦¿à¦–','Date de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1129,'8','time','Time','Hora','à¦¸à¦®à¦¯à¦¼','Temps',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1130,'8','published','Published','Publicado','à¦ªà§à¦°à¦•à¦¾à¦¶à¦¿à¦¤','PubliÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1131,'8','manage_question','Manage Question','Gestionar pregunta','à¦ªà§à¦°à¦¶à§à¦¨ à¦ªà¦°à¦¿à¦šà¦¾à¦²à¦¨à¦¾ à¦•à¦°à§à¦¨','GÃ©rer la question',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1132,'8','published_now','Published Now','Publicado ahora','à¦à¦–à¦¨ à¦ªà§à¦°à¦•à¦¾à¦¶à¦¿à¦¤','PubliÃ© maintenant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1133,'8','view_result','View Result','Ver resultado','à¦«à¦²à¦¾à¦«à¦² à¦¦à§‡à¦–à§à¦¨','Voir rÃ©sultat',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1134,'8','monday','Monday','lunes','à¦¸à§‹à¦®à¦¬à¦¾à¦°','Lundi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1135,'8','tuesday','Tuesday','martes','à¦®à¦™à§à¦—à¦²à¦¬à¦¾à¦°','Mardi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1136,'8','wednesday','Wednesday','miÃ©rcoles','à¦¬à§à¦§à¦¬à¦¾à¦°','Mercredi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1137,'8','thursday','Thursday','jueves','à¦¬à§ƒà¦¹à¦¸à§à¦ªà¦¤à¦¿à¦¬à¦¾à¦°','Jeudi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1138,'8','friday','Friday','viernes','à¦¶à§à¦•à§à¦°à¦¬à¦¾à¦°','Vendredi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1139,'8','Saturday','Saturday','sÃ¡bado','à¦¶à¦¨à¦¿à¦¬à¦¾à¦°','samedi',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1140,'8','sunday','Sunday','domingo','à¦°à¦¬à¦¿à¦¬à¦¾à¦°','dimanche',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1141,'8','room_number','Room Number','NÃºmero de habitaciÃ³n','à¦°à§à¦® à¦¨à¦®à§à¦¬à¦°','NumÃ©ro de chambre',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1142,'8','not_scheduled','Not Scheduled','No programada','à¦¨à¦¿à¦°à§à¦§à¦¾à¦°à¦¿à¦¤ à¦¨à¦¾','Non prÃ©vu',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1143,'8','result_view','Result View','Vista de resultados','à¦«à¦²à¦¾à¦«à¦² à¦¦à§‡à¦–à§à¦¨','RÃ©sultat',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1144,'8','total_marks','Total Marks','Notas totales','à¦®à§‹à¦Ÿ à¦šà¦¿à¦¹à§à¦¨','Total des notes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1145,'8','obtained_marks','Obtained Marks','Marcas obtenidas','à¦ªà§à¦°à¦¾à¦ªà§à¦¤ à¦¨à¦®à§à¦¬à¦°','Obtenu Marques',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1146,'8','marking','Marking','CalificaciÃ³n','à¦…à¦¬à¦¸à§à¦¥à¦¾à¦¨à¦¸à§‚à¦šà¦•','Marquage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1147,'8','view_answer_marking','View answer & marking','Ver respuesta y marcado','à¦‰à¦¤à§à¦¤à¦° à¦“ à¦šà¦¿à¦¹à§à¦¨à¦¿à¦¤à¦•à¦°à¦£ à¦¦à§‡à¦–à§à¦¨','Voir la rÃ©ponse et le marquage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1148,'8','online_exam_question','Online Exam Question','Pregunta de examen en lÃ­nea','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦ªà§à¦°à¦¶à§à¦¨','Question dexamen en ligne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1149,'8','question_list','Question List','Lista de preguntas','à¦ªà§à¦°à¦¶à§à¦¨ à¦¤à¦¾à¦²à¦¿à¦•à¦¾','Liste de questions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1150,'8','questions','Questions','Preguntas','à¦ªà§à¦°à¦¶à§à¦¨à¦¾à¦¬à¦²à¦¿','Des questions',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1151,'8','exam_details','Exam Details','Detalles del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¬à¦¿à¦¬à¦°à¦£','DÃ©tails de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1152,'8','passing_percentage','Passing Percentage','Pasando el porcentaje','à¦ªà¦¾à¦¸à¦¿à¦‚ à¦ªà¦¾à¦°à§à¦¸à§‡à¦¨à§à¦Ÿà§‡à¦œ','Passage Pourcentage',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1153,'8','online_active_exams','Online Active Exams','ExÃ¡menes activos en lÃ­nea','à¦…à¦¨à¦²à¦¾à¦‡à¦¨ à¦…à§à¦¯à¦¾à¦•à§à¦Ÿà¦¿à¦­ à¦ªà¦°à§€à¦•à§à¦·à¦¾','Examens actifs en ligne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1154,'8','take_exam','Take Exam','Tomar examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾ à¦¦à¦¿à¦¨','Passer un examen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1155,'8','classes','Classes','Las clases','à¦•à§à¦²à¦¾à¦¸','Des classes',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1156,'8','exam_terms','Exam Terms','TÃ©rminos del examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¶à¦°à§à¦¤à¦¾à¦¦à¦¿','Termes de lexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1157,'8','document','document','document','à¦¦à¦²à¦¿à¦²','document',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1158,'8','timeline','Timeline','LÃ­nea de tiempo','à¦¸à¦®à¦¯à¦¼à¦°à§‡à¦–à¦¾','Chronologie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1159,'8','Parent_Guardian_Details','Parent / Guardian Details','Detalles de padres / tutores','à¦ªà¦¿à¦¤à¦¾à¦®à¦¾à¦¤à¦¾à¦° / à¦…à¦­à¦¿à¦­à¦¾à¦¬à¦•à§‡à¦° à¦¬à¦¿à¦¬à¦°à¦£','DÃ©tails sur le parent / tuteur',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1160,'8','full_marks','Full Marks','La mÃ¡xima puntuaciÃ³n','à¦ªà§à¦°à§‹ à¦šà¦¿à¦¹à§à¦¨','La totalitÃ© des points',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1161,'8','results','Results','Resultados','à¦«à¦²à¦¾à¦«à¦²','RÃ©sultats',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1162,'8','visible_to_this_person','Visible to this person','Visible para esta persona','à¦à¦‡ à¦¬à§à¦¯à¦•à§à¦¤à¦¿à¦° à¦•à¦¾à¦›à§‡ à¦¦à§ƒà¦¶à§à¦¯à¦®à¦¾à¦¨','Visible Ã  cette personne',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1163,'9','academics','Academics','AcadÃ©mica','à¦¶à¦¿à¦•à§à¦·à¦¾à¦¬à¦¿à¦¦à¦—à¦£','Les universitaires',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1164,'9','class_routine','Timetable','Rutina de clase','à¦•à§à¦²à¦¾à¦¸ à¦°à§à¦Ÿà¦¿à¦¨','Routine de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1165,'9','class_routine_create','Timetable Create','Rutina de clase Crear','à¦•à§à¦²à¦¾à¦¸ à¦°à§à¦Ÿà¦¿à¦¨ à¦¤à§ˆà¦°à¦¿ à¦•à¦°à§à¦¨','Classe Routine Create',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1166,'9','view_teacher_routine','View Class Routine(Teacher)','Ver la rutina de la clase (profesor)','à¦•à§à¦²à¦¾à¦¸à§‡à¦° à¦°à§à¦Ÿà¦¿à¦¨ (à¦¶à¦¿à¦•à§à¦·à¦•) à¦¦à§‡à¦–à§à¦¨','Voir la routine de classe (enseignant)',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1167,'9','assign_subject','Assign Unit','Asignar Asunto','à¦¸à¦¾à¦¬à¦œà§‡à¦•à§à¦Ÿ à¦¬à¦°à¦¾à¦¦à§à¦¦ à¦•à¦°à§à¦¨','Attribuer un sujet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1168,'9','assign_subject_create','Assign Unit Create','Asignar Asunto crear','à¦¸à¦¾à¦¬à¦œà§‡à¦•à§à¦Ÿ à¦¤à§ˆà¦°à¦¿ à¦¬à¦°à¦¾à¦¦à§à¦¦ à¦•à¦°à§à¦¨','Assigner le sujet crÃ©er',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1169,'9','assign_class_teacher','Assign Unit Teacher','Asignar profesor de clase','à¦¶à§à¦°à§‡à¦£à¦¿ à¦¶à¦¿à¦•à§à¦·à¦• à¦¨à¦¿à¦¯à¦¼à§‹à¦— à¦•à¦°à§à¦¨','Attribuer un enseignant de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1170,'9','subjects','Units','Asignaturas','à¦¬à¦¿à¦·à¦¯à¦¼','Sujets',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1171,'9','class','Program','Clase','à¦¶à§à¦°à§‡à¦£à§€','Classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1172,'9','section','Level','Seccion','à¦…à¦§à§à¦¯à¦¾à¦¯à¦¼','Section',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1173,'9','class_room','Class Room','SalÃ³n de clases','à¦•à§à¦²à¦¾à¦¸ à¦°à§à¦®','Salle de cours',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1174,'9','n_a','N/A','N / A','à¦à¦¨ / à¦','N / A',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1175,'9','class_teacher','Unit Teacher','Profesor de la clase','à¦¶à§à¦°à§‡à¦£à§€ à¦¶à¦¿à¦•à§à¦·à¦•','Professeur de classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1176,'9','assign_teacher','Assign teacher','Asignar maestro','à¦¶à¦¿à¦•à§à¦·à¦• à¦¨à¦¿à¦¯à¦¼à§‹à¦— à¦•à¦°à§à¦¨','Assigner un enseignant',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1177,'9','subject_name','Unit name','Nombre del tema','à¦¬à¦¿à¦·à¦¯à¦¼ à¦¨à¦¾à¦®','Nom du sujet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1178,'9','theory','Theory','TeorÃ­a','à¦¤à¦¤à§à¦¤à§à¦¬','ThÃ©orie',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1179,'9','practical','Practical','PrÃ¡ctico','à¦¬à§à¦¯à¦¬à¦¹à¦¾à¦°à¦¿à¦•','Pratique',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1180,'9','subject_code','Unit code','CÃ³digo del Asunto','à¦¬à¦¿à¦·à¦¯à¦¼ à¦•à§‹à¦¡','Code de sujet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1181,'9','subject_type','Unit type','Tipo de asunto','à¦¬à¦¿à¦·à¦¯à¦¼ à¦ªà§à¦°à¦•à¦¾à¦°','Type de sujet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1182,'9','capacity','Capacity','Capacidad','à¦§à¦¾à¦°à¦£à¦•à§à¦·à¦®à¦¤à¦¾','CapacitÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1183,'9','cl_ex_time_setup','Lesson Time setup','Cl / Ex ConfiguraciÃ³n de hora','à¦¸à¦¿à¦à¦² / à¦ªà§à¦°à¦¾à¦•à§à¦¤à¦¨ à¦¸à¦®à¦¯à¦¼ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration de lheure Cl / Ex',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1184,'9','class_exam_time_setup','Lesson Time setup','ConfiguraciÃ³n de clase y tiempo de examen','à¦•à§à¦²à¦¾à¦¸ à¦“ à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¸à¦®à¦¯à¦¼ à¦¸à§‡à¦Ÿà¦†à¦ª','Configuration du temps de cours et dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1185,'9','class_time','Regular Lesson','Hora de clase','à¦•à§à¦²à¦¾à¦¸ à¦Ÿà¦¾à¦‡à¦®','Le moment daller en classe',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1186,'9','time_type','Time Type','Tipo de tiempo','à¦¸à¦®à¦¯à¦¼à§‡à¦° à¦§à¦°à¦£','Type de temps',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1187,'9','exam_time','Guest Lecture','Tiempo de examen','à¦ªà¦°à§€à¦•à§à¦·à¦¾à¦° à¦¸à¦®à¦¯à¦¼','Temps dexamen',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1188,'9','period','Period','PerÃ­odo','à¦•à¦¾à¦²','PÃ©riode',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1189,'9','select_time','Select Time','Seleccione tiempo','à¦¸à¦®à¦¯à¦¼ à¦¨à¦¿à¦°à§à¦¬à¦¾à¦šà¦¨ à¦•à¦°à§à¦¨','SÃ©lectionnez lheure',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1190,'9','not_assigned_yet','Not assigned yet','AÃºn no asignado','à¦à¦–à¦¨à¦“ à¦¨à¦¿à¦¯à§à¦•à§à¦¤ à¦•à¦°à¦¾ à¦¹à¦¯à¦¼à¦¨à¦¿','Pas encore assignÃ©',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1191,'9','of','of','of','à¦à¦°','of',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1192,'9','about','About','About','About','About',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1193,'9','payable','Payable','Payable','Payable','Payable',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1194,'9','start','Start','Start','Start','Start',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1195,'9','end','End','End','End','End',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1196,'9','uqinue_fine_list','Uqinue fine list','Uqinue fine list','Uqinue fine list','Uqinue fine list',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1197,'9','days_after_date','Days After Due Date','Days After Due Date','Days After Due Date','Days After Due Date',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1198,'9','fixed','Fixed','Fixed','Fixed','Fixed',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1199,'9','ltl_rtl','LTL To RTL','LTL To RTL','LTL To RTL','LTL To RTL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1200,'9','testimonial_list','Testimonial List','Testimonial List','Testimonial List','Testimonial List',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1201,'9','assign_optional_subject','Assign Optional Subject','Assign Optional Subject','Assign Optional Subject','Assign Optional Subject',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1202,'9','term_wise_report','Term Wise Report','Term Wise Report','Term Wise Report','Term Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1203,'9','type_wise_report','Type Wise Report','Type Wise Report','Type Wise Report','Type Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1204,'9','due_wise_report','Due Wise Report','Due Wise Report','Due Wise Report','Due Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1205,'9','contract_type','Contract Type','Contract Type','Contract Type','Contract Type',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1206,'9','verify','Verify','Verify','Verify','Verify',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1207,'9','addOns','Add Ons','Add Ons','Add Ons','Add Ons',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1208,'9','adons','Add Ons','Add Ons','Add Ons','Add Ons',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1209,'9','due_wise_report','Due Wise Report','Due Wise Report','Due Wise Report','Due Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1210,'9','type_wise_report','Type Wise Report','Type Wise Report','Type Wise Report','Type Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1211,'9','term_wise_report','Term Wise Report','Term Wise Report','Term Wise Report','Term Wise Report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1212,'0','export','Export','Export','Export','Export',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1213,'0','PDF','PDF','PDF','PDF','PDF',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1214,'0','biometrics','Biometrics','Biometrics','Biometrics','Biometrics',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1215,'0','bio','Biometrics','Biometrics','Biometrics','Biometrics',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1216,'0','bio','Biometrics','Biometrics','Biometrics','Biometrics',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1217,'0','buy','Buy','Buy','Buy','Buy',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1218,'0','csu','Custom URL','Custom URL','Custom URL','Custom URL',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1219,'0','now','Now','Now','Now','Now',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1220,'19','social_media','Social Media','Now','Now','Now',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1221,'19','icon','Icon','Now','Now','Now',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1222,'3','student_delete_note','Note: if delete, then all related information will removed.','Now','Now','Now',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1223,'6','staff_delete_note','Note: if delete, then all related information will removed.','Now','Now','Now',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1224,'17','cumulative','Cumulative','cumulative','cumulative','cumulative',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1225,'17','sheet','Sheet','sheet','sheet','sheet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1226,'17','report','Report','report','report','report',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1227,'17','contonuous','Contonuous','contonuous','contonuous','contonuous',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1228,'17','assessment','Assessment','assessment','assessment','assessment',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1229,'17','termly','Termly','termly','termly','termly',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1230,'17','academic','Academic','academic','academic','academic',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1231,'17','performance','Performance','performance','performance','performance',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1232,'17','terminal','Terminal','terminal','terminal','terminal',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1233,'17','sheet','Sheet','sheet','sheet','sheet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1234,'17','continuous','Continuous','continuous','continuous','continuous',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1235,'17','assessment','Assessment','assessment','assessment','assessment',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1236,'17','version','Version','version','version','version',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1237,'17','institution','institution','institution','institution','institution',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1238,'17','one','one','one','one','one',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1239,'17','school','school','school','school','school',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1240,'17','opening','opening','opening','opening','opening',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1241,'17','confirm_password','confirm password','confirm password','confirm password','confirm password',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1242,'17','or','or','or','or','or',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1243,'17','routine','routine','routine','routine','routine',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1244,'17','ticket_comment','Ticke Comment','Ticke Comment','Ticke Comment','Ticke Comment',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1245,'17','manager','manager','manager','manager','manager',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1246,'17','registration','registration','registration','registration','registration',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1247,'17','after','after','after','after','after',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1248,'17','my','my','my','my','my',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1249,'17','ticket','ticket','ticket','ticket','ticket',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1250,'17','guardian_mobile','guardian mobile','guardian mobile','guardian mobile','guardian mobile',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1251,'17','is_approved','is approved','is approved','is approved','is approved',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1252,'17','is_enabled','Is Enabled','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1253,'17','ticket_list','ticket list','ticket list','ticket list','ticket list',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1254,'17','priority_list','priority list','priority list','priority list','priority list',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1255,'17','ticket_priority','ticket priority','ticket priority','ticket priority','ticket priority',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1256,'17','ticket_category','ticket category','ticket category','ticket category','ticket category',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1257,'17','category_list','category list','category list','category list','category list',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1258,'17','ticket_system','ticket system','ticket system','ticket system','ticket system',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1259,'17','delete_uploaded_content','delete uploaded content','delete uploaded content','delete uploaded content','delete uploaded content',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1260,'17','add_content','add content','add content','add content','add content',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1261,'18','download_uploaded_content','download uploaded content','download uploaded content','download uploaded content','download uploaded content',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1262,'18','password_reset_message','password reset message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1263,'18','student_login_credential_message','student login credential message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1264,'18','guardian_login_credential_message','guardian login credential message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1265,'18','staff_login_credential_message','staff login credential message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1266,'18','dues_payment_message','dues payment message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1267,'18','email_footer_text','email footer text','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1268,'18','registration','Registration','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1269,'18','after','After','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1270,'18','header','Header','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1271,'18','footer','Footer','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1272,'18','footer','Footer','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1273,'18','sec','Level','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1274,'18','guardian_mobile','Guardian Mobile','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1275,'18','are_you_sure_to_approve','Are you sure to approve this item?','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1276,'18','guardian_mobile','Guardian Mobile','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1277,'18','saas','SAAS','SAAS','SAAS','SAAS',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1278,'18','how_do_you_know_us','How do you know us','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1279,'18','recaptcha','Recaptcha','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1280,'18','nocaptcha_sitekey','noCaptcha Sitekey','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1281,'18','nocaptcha_secret','noCaptcha Secret','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1282,'18','guardian_relation','Guardian Relation','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1283,'18','relation','Relation','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1284,'18','promossion_without','Promotion Without','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1285,'18','promossion','Promotion','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1286,'18','administrator','Administrator','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1287,'18','age','Age','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1288,'18','note_for_multiple_child_registration','If you want to register your another child please contact with school.','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1289,'18','click_for_recaptcha_create','Click here for create Recaptcha (v2).','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1290,'18','textlocal','Textlocal','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1291,'18','sms_template','Sms Template','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1292,'18','zoom','Zoom','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1293,'18','virtual_class','Virtual Class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1294,'18','topic','Topic','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1295,'18','description','Description','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1296,'18','date_of_meeting','Date of Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1297,'18','time_of_meeting','Time of Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1298,'18','meeting_durration','Meetting Durration (Minutes)','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1299,'18','zoom_recurring','Recurring','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1300,'18','zoom_recurring_type','Recurrence Type','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1301,'18','zoom_recurring_daily','Daily','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1302,'18','zoom_recurring_weekly','Weekly','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1303,'18','zoom_recurring_monthly','Monthly','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1304,'18','zoom_recurring_repect','Repeat every','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1305,'18','zoom_recurring_end','End Recurrence','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1306,'18','join_before_host','Join before host','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1307,'18','host_video','Host Video','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1308,'18','participant_video','Participant Video','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1309,'18','mute_upon_entry','Participate mic mute','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1310,'18','watermark','Watermark','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1311,'18','waiting_room','Waiting Room','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1312,'18','auto_recording','Auto Recording','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1313,'18','audio_options','Audio Option','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1314,'18','meeting_approval','Meeting Join Approval','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1315,'18','meeting_id','Meeting ID','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1316,'18','zoom_start_join','Join/Start','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1317,'18','start','Start','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1318,'18','join','Join','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1319,'18','show','Show','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1320,'18','delete_meetings','Delete Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1321,'18','are_you_sure_delete','Are you sure to delete ?','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1322,'18','zoom_setting','Zoom Setting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1323,'18','for_paid_package','For Paid Package','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1324,'18','api_key','API Key','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1325,'18','serect_key','Secret Key','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1326,'18','pakage','Pakage','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1327,'18','join_meeting','Join Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1328,'18','attached_file','Attached File','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1329,'18','start_date_time','Start Date & Time','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1330,'18','not_yet_start','Not Yet Start','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1331,'18','closed','Closed','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1332,'18','host_id','Host ID','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1333,'18','timezone','Timezone','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1334,'18','created_at','Created At','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1335,'18','join_url','Join URL','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1336,'18','encrypted','Encrypted','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1337,'18','in_mettings','in Mettings','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1338,'18','cn_mettings','cn Mettings','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1339,'18','use_pmi','use pmi','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1340,'18','enforce_login','Enforce Login','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1341,'18','enforce_login_domains','Enforce Login Domains','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1342,'18','alternative_hosts','Alternative Hosts','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1343,'18','meeting_authentication','Meeting Authentication','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1344,'18','delete_virtual_meeting','Delete virtaul meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1345,'18','room','Room','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1346,'18','meeting','Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1347,'18','join_class','Join Class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1348,'18','participants','Participants','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1349,'18','meetings','Meetings','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1350,'18','select_member','Select Member','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1351,'18','change_default_settings','Change Default Settings','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1352,'18','virtual_class_meetting','Vitual Class/Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1353,'18','class_reports','Class Reports','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1354,'18','class_reports','Class Reports','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1355,'18','meeting_reports','Meeting Reports','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1356,'18','date_of_class','Date of class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1357,'18','time_of_class','Time of class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1358,'18','duration_of_class','Duration of class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1359,'18','virtual_class_id','VClass ID','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1360,'18','virtual_meeting','Virtual Meeting','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1361,'18','virtual_class','Virtual class','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1362,'18','dues_payment_message','dues payment message','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1363,'18','email_footer_text','email footer text','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1364,'18','registration','Registration','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1365,'18','after','After','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1366,'18','header','Header','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1367,'18','footer','Footer','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1368,'18','footer','Footer','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1369,'18','sec','Level','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1370,'18','guardian_mobile','Guardian Mobile','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1371,'18','are_you_sure_to_approve','Are you sure to approve this item?','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1372,'18','guardian_mobile','Guardian Mobile','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1373,'18','saas','SAAS','SAAS','SAAS','SAAS',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1374,'18','how_do_you_know_us','How do you know us','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1375,'18','recaptcha','Recaptcha','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1376,'18','nocaptcha_sitekey','noCaptcha Sitekey','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1377,'18','nocaptcha_secret','noCaptcha Secret','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1378,'18','guardian_relation','Guardian Relation','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1379,'18','relation','Relation','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1380,'18','promossion_without','Promotion Without','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1381,'18','promossion','Promotion','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1382,'18','administrator','Administrator','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1383,'18','age','Age','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1384,'18','note_for_multiple_child_registration','If you want to register your another child please contact with school.','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1385,'18','click_for_recaptcha_create','Click here for create Recaptcha (v2).','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1386,'18','textlocal','Textlocal','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1387,'18','attendance_this_month','Att. This Month','Att. This Month','Att. This Month','Att. This Month',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1388,'18','sms_template','Sms Template','','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1389,'18','liability','Liability','Liability','Liability','Liability',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1390,'18','asset','Asset','Asset','Asset','Asset',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1391,'18','label','Label','Label','Label','Label',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1392,'18','bank_details','Bank Details','Bank Details','Bank Details','Bank Details',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1393,'18','africatalking','Africatalking','Africatalking','Africatalking','Africatalking',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1394,'18','africatalking_api_key','Africatalking API Key','Africatalking API Key','Africatalking API Key','Africatalking API Key',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1395,'18','slip','Slip','Slip','','',1,'2020-08-10 05:58:20','2020-08-10 05:58:20'),(1396,'18','result_not_publish_yet','Result Not Publish Yet','Result Not Publish Yet','Result Not Publish Yet','Result Not Publish Yet',1,'2020-08-10 05:58:20','2020-08-10 05:58:20');
/*!40000 ALTER TABLE `sm_language_phrases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_languages`
--

DROP TABLE IF EXISTS `sm_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_languages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `language_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `native` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language_universal` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `lang_id` int(10) unsigned DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_languages_lang_id_foreign` (`lang_id`),
  KEY `sm_languages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_languages_lang_id_foreign` FOREIGN KEY (`lang_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_languages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_languages`
--

LOCK TABLES `sm_languages` WRITE;
/*!40000 ALTER TABLE `sm_languages` DISABLE KEYS */;
INSERT INTO `sm_languages` VALUES (1,'English','English','en',1,'2020-08-10 05:58:17','2020-09-10 19:56:20',19,1,1,1),(2,'Bengali','à¦¬à¦¾à¦‚à¦²à¦¾','bn',0,'2020-08-10 05:58:17','2020-09-10 19:56:13',9,1,1,1),(3,'Spanish','EspaÃ±ol','es',0,'2020-08-10 05:58:17','2020-09-10 19:56:20',20,1,1,1),(4,'French','FranÃ§ais','fr',0,'2020-08-10 05:58:17','2020-08-20 08:26:53',28,1,1,1);
/*!40000 ALTER TABLE `sm_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_leave_defines`
--

DROP TABLE IF EXISTS `sm_leave_defines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_leave_defines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `days` int(10) unsigned DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_leave_defines_role_id_foreign` (`role_id`),
  KEY `sm_leave_defines_type_id_foreign` (`type_id`),
  KEY `sm_leave_defines_school_id_foreign` (`school_id`),
  KEY `sm_leave_defines_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_leave_defines_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_defines_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_defines_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_defines_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `sm_leave_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_leave_defines`
--

LOCK TABLES `sm_leave_defines` WRITE;
/*!40000 ALTER TABLE `sm_leave_defines` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_leave_defines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_leave_requests`
--

DROP TABLE IF EXISTS `sm_leave_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_leave_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apply_date` date DEFAULT NULL,
  `leave_from` date DEFAULT NULL,
  `leave_to` date DEFAULT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci,
  `note` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approve_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'P for Pending, A for Approve, R for reject',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `leave_define_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_leave_requests_leave_define_id_foreign` (`leave_define_id`),
  KEY `sm_leave_requests_staff_id_foreign` (`staff_id`),
  KEY `sm_leave_requests_role_id_foreign` (`role_id`),
  KEY `sm_leave_requests_type_id_foreign` (`type_id`),
  KEY `sm_leave_requests_school_id_foreign` (`school_id`),
  KEY `sm_leave_requests_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_leave_requests_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_requests_leave_define_id_foreign` FOREIGN KEY (`leave_define_id`) REFERENCES `sm_leave_defines` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_requests_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_requests_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_requests_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_requests_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `sm_leave_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_leave_requests`
--

LOCK TABLES `sm_leave_requests` WRITE;
/*!40000 ALTER TABLE `sm_leave_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_leave_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_leave_types`
--

DROP TABLE IF EXISTS `sm_leave_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_leave_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_days` int(10) unsigned DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_leave_types_school_id_foreign` (`school_id`),
  KEY `sm_leave_types_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_leave_types_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_leave_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_leave_types`
--

LOCK TABLES `sm_leave_types` WRITE;
/*!40000 ALTER TABLE `sm_leave_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_leave_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_library_members`
--

DROP TABLE IF EXISTS `sm_library_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_library_members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member_ud_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `member_type` int(10) unsigned DEFAULT NULL,
  `student_staff_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_library_members_member_type_foreign` (`member_type`),
  KEY `sm_library_members_student_staff_id_foreign` (`student_staff_id`),
  KEY `sm_library_members_school_id_foreign` (`school_id`),
  KEY `sm_library_members_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_library_members_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_library_members_member_type_foreign` FOREIGN KEY (`member_type`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_library_members_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_library_members_student_staff_id_foreign` FOREIGN KEY (`student_staff_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_library_members`
--

LOCK TABLES `sm_library_members` WRITE;
/*!40000 ALTER TABLE `sm_library_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_library_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_mark_stores`
--

DROP TABLE IF EXISTS `sm_mark_stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_mark_stores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_roll_no` int(11) NOT NULL DEFAULT '1',
  `student_addmission_no` int(11) NOT NULL DEFAULT '1',
  `total_marks` double(8,2) NOT NULL DEFAULT '0.00',
  `is_absent` tinyint(4) NOT NULL DEFAULT '1',
  `teacher_remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `exam_term_id` int(10) unsigned DEFAULT NULL,
  `exam_setup_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_mark_stores_subject_id_foreign` (`subject_id`),
  KEY `sm_mark_stores_exam_term_id_foreign` (`exam_term_id`),
  KEY `sm_mark_stores_exam_setup_id_foreign` (`exam_setup_id`),
  KEY `sm_mark_stores_student_id_foreign` (`student_id`),
  KEY `sm_mark_stores_class_id_foreign` (`class_id`),
  KEY `sm_mark_stores_section_id_foreign` (`section_id`),
  KEY `sm_mark_stores_school_id_foreign` (`school_id`),
  KEY `sm_mark_stores_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_mark_stores_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_exam_setup_id_foreign` FOREIGN KEY (`exam_setup_id`) REFERENCES `sm_exam_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_exam_term_id_foreign` FOREIGN KEY (`exam_term_id`) REFERENCES `sm_exam_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_mark_stores_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_mark_stores`
--

LOCK TABLES `sm_mark_stores` WRITE;
/*!40000 ALTER TABLE `sm_mark_stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_mark_stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_marks_grades`
--

DROP TABLE IF EXISTS `sm_marks_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_marks_grades` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `grade_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpa` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from` double(8,2) DEFAULT NULL,
  `up` double(8,2) DEFAULT NULL,
  `percent_from` int(11) DEFAULT NULL,
  `percent_upto` int(11) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_marks_grades_school_id_foreign` (`school_id`),
  KEY `sm_marks_grades_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_marks_grades_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_grades_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_marks_grades`
--

LOCK TABLES `sm_marks_grades` WRITE;
/*!40000 ALTER TABLE `sm_marks_grades` DISABLE KEYS */;
INSERT INTO `sm_marks_grades` VALUES (1,'A+','5.00',5.00,5.99,80,100,'Outstanding !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(2,'A','4.00',4.00,4.99,70,79,'Very Good !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(3,'A-','3.50',3.50,3.99,60,69,'Good !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(4,'B','3.00',3.00,3.49,50,59,'Outstanding !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(5,'C','2.00',2.00,2.99,40,49,'Bad !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(6,'D','1.00',1.00,1.99,33,39,'Very Bad !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1),(7,'F','0.00',0.00,0.99,0,32,'Failed !',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1,1);
/*!40000 ALTER TABLE `sm_marks_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_marks_register_children`
--

DROP TABLE IF EXISTS `sm_marks_register_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_marks_register_children` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `marks` int(11) DEFAULT NULL,
  `abs` int(11) NOT NULL DEFAULT '0' COMMENT '1 for absent, 0 for present',
  `gpa_point` double(8,2) DEFAULT NULL,
  `gpa_grade` varchar(55) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `marks_register_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_marks_register_children_marks_register_id_foreign` (`marks_register_id`),
  KEY `sm_marks_register_children_subject_id_foreign` (`subject_id`),
  KEY `sm_marks_register_children_school_id_foreign` (`school_id`),
  KEY `sm_marks_register_children_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_marks_register_children_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_register_children_marks_register_id_foreign` FOREIGN KEY (`marks_register_id`) REFERENCES `sm_marks_registers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_register_children_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_register_children_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_marks_register_children`
--

LOCK TABLES `sm_marks_register_children` WRITE;
/*!40000 ALTER TABLE `sm_marks_register_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_marks_register_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_marks_registers`
--

DROP TABLE IF EXISTS `sm_marks_registers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_marks_registers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_marks_registers_student_id_foreign` (`student_id`),
  KEY `sm_marks_registers_exam_id_foreign` (`exam_id`),
  KEY `sm_marks_registers_class_id_foreign` (`class_id`),
  KEY `sm_marks_registers_section_id_foreign` (`section_id`),
  KEY `sm_marks_registers_school_id_foreign` (`school_id`),
  KEY `sm_marks_registers_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_marks_registers_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_registers_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_registers_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_registers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_registers_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_registers_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_marks_registers`
--

LOCK TABLES `sm_marks_registers` WRITE;
/*!40000 ALTER TABLE `sm_marks_registers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_marks_registers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_marks_send_sms`
--

DROP TABLE IF EXISTS `sm_marks_send_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_marks_send_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sms_send_status` tinyint(4) NOT NULL DEFAULT '1',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_marks_send_sms_exam_id_foreign` (`exam_id`),
  KEY `sm_marks_send_sms_student_id_foreign` (`student_id`),
  KEY `sm_marks_send_sms_school_id_foreign` (`school_id`),
  KEY `sm_marks_send_sms_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_marks_send_sms_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_send_sms_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_send_sms_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_marks_send_sms_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_marks_send_sms`
--

LOCK TABLES `sm_marks_send_sms` WRITE;
/*!40000 ALTER TABLE `sm_marks_send_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_marks_send_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_module_links`
--

DROP TABLE IF EXISTS `sm_module_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_module_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `route` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_module_links_module_id_foreign` (`module_id`),
  KEY `sm_module_links_created_by_foreign` (`created_by`),
  KEY `sm_module_links_updated_by_foreign` (`updated_by`),
  KEY `sm_module_links_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_module_links_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_module_links_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `sm_modules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_module_links_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_module_links_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_module_links`
--

LOCK TABLES `sm_module_links` WRITE;
/*!40000 ALTER TABLE `sm_module_links` DISABLE KEYS */;
INSERT INTO `sm_module_links` VALUES (1,1,'Dashboard Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(2,1,'âž¡ Number of Student','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(3,1,'âž¡ Number of Teacher','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(4,1,'âž¡ Number of Parents','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(5,1,'âž¡ Number of Staff','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(6,1,'âž¡ Current Month Income and Expense Chart','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(7,1,'âž¡ Current Year Income and Expense Chart','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(8,1,'âž¡ Notice Board','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(9,1,'âž¡ Calendar Section','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(10,1,'âž¡ To Do list','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(11,2,'Admin Section Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(12,2,'Admission Query menu','admission-query',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(13,2,'âž¡ Create Query Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(14,2,'âž¡ Create Query Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(15,2,'âž¡ Create Query Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(16,2,'Visitor Book Menu','visitor',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(17,2,'âž¡ Visitor  Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(18,2,'âž¡ Visitor Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(19,2,'âž¡ Visitor Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(20,2,'âž¡ Visitor Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(21,2,'Complaint Menu','complaint',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(22,2,'âž¡ Complaint Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(23,2,'âž¡ Complaint Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(24,2,'âž¡ Complaint Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(25,2,'âž¡ Complaint Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(26,2,'âž¡ Complaint View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(27,2,'Postal Receive Menu','postal-receive',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(28,2,'âž¡ Postal Receive Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(29,2,'âž¡ Postal Receive Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(30,2,'âž¡ Postal Receive Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(31,2,'âž¡ Postal Receive Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(32,2,'Postal Dispatch Menu','postal-dispatch',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(33,2,'âž¡ Postal Dispatch Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(34,2,'âž¡ Postal Dispatch Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(35,2,'âž¡ Postal Dispatch Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(36,2,'Phone Call Log Menu','phone-call',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(37,2,'âž¡ Phone Call Log Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(38,2,'âž¡ Phone Call Log Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(39,2,'âž¡ Phone Call Log Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(40,2,'âž¡ Phone Call Log Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(41,2,'Admin Setup Menu','setup-admin',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(42,2,'âž¡ Admin Setup Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(43,2,'âž¡ Admin Setup Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(44,2,'âž¡ Admin Setup Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(45,2,'Student ID Menu','student-id-card',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(46,2,'âž¡ Student ID Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(47,2,'âž¡ Student ID Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(48,2,'âž¡ Student ID Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(49,2,'Student Certificate Menu','student-certificate',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(50,2,'âž¡ Student Certificate Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(51,2,'âž¡ Student Certificate Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(52,2,'âž¡ Student Certificate Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(53,2,'Generate Certificate Menu','generate-certificate',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(54,2,'âž¡ Generate Certificate Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(55,2,'âž¡ Generate Certificate Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(56,2,'âž¡ Generate Certificate Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(57,2,'Generate ID Card Menu','generate-id-card',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(58,2,'âž¡ Generate ID Card Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(59,2,'âž¡ Generate ID Card Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(60,2,'âž¡ Generate ID Card Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(61,3,'Student Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(62,3,'Student Admission Menu','student-admission',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(63,3,'âž¡ Import Student','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(64,3,'Student List Menu','student-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(65,3,'âž¡ Student List Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(66,3,'âž¡ Student List Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(67,3,'âž¡ Student List Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(68,3,'Student Attendance Menu','student-attendance',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(69,3,'âž¡ Student Attendance Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(70,3,'Student Attendance Report Menu','student-attendance-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(71,3,'Student Category Menu','student-category',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(72,3,'âž¡ Student Category Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(73,3,'âž¡ Student Category Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(74,3,'âž¡ Student Category Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(75,3,'âž¡ Student Category Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(76,3,'Student Group Menu','student-group',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(77,3,'âž¡ Student Group Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(79,3,'âž¡ Student Group Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(80,3,'âž¡ Student Group Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(81,3,'Student Promote Menu','student-promote',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(82,3,'âž¡ Student Promote Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(83,3,'Disabled Students Menu','disabled-student',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(84,3,'âž¡ Disabled Students Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(85,3,'âž¡ Disabled Students Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(86,3,'âž¡ Disabled Students Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(87,4,'Teacher Section Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(88,4,'Upload Content Menu','upload-content',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(89,4,'âž¡ Create Content Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(90,4,'âž¡ Content Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(91,4,'âž¡ Content Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(92,4,'Assignment Menu','assignment-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(93,4,'âž¡ Create Assignment Add','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(94,4,'âž¡ Assignment Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(95,4,'âž¡ Assignment Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(96,4,'Study Material Menu','study-metarial-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(97,4,'âž¡ Create Study Material Add','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(98,4,'âž¡ Study Material Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(99,4,'âž¡ Study Material Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(100,4,'Syllabus Menu','syllabus-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(101,4,'âž¡ Create Study Syllabus Add','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(102,4,'âž¡ Study Syllabus Edit','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(103,4,'âž¡ Study Syllabus Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(104,4,'âž¡ Study Syllabus Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(105,4,'Other Downloads Menu','other-download-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(106,4,'âž¡ Other Downloads Download','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(107,4,'âž¡ Other Downloads Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(108,5,'Fees Collection Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(109,5,'Collect Fees Menu','collect-fees',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(110,5,'âž¡ Create Collect Fees','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(111,5,'âž¡ Collect Fees Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(112,5,'âž¡ Collect Fees Print','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(113,5,'Search Fees Payment Menu','search-fees-payment',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(114,5,'âž¡ Create Search Fees Payment Add','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(115,5,'âž¡ Search Fees Payment View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(116,5,'Search Fees Due Menu','search-fees-due',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(117,5,'âž¡ Search Fees Due View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(118,5,'Fees Master Menu','fees-master',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(119,5,'âž¡ Create Fees Master Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(120,5,'âž¡ Fees Master Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(121,5,'âž¡ Fees Master Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(122,5,'âž¡ Fees Master Assign','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(123,5,'Fees Group Menu','fees-group',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(124,5,'âž¡ Create Fees Group Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(125,5,'âž¡ Fees Group Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(126,5,'âž¡ Fees Group Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(127,5,'Fees Type Menu','fees-type',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(128,5,'âž¡ Create Fees Type Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(129,5,'âž¡ Fees Type Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(130,5,'âž¡ Fees Type Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(131,5,'Fees Discount Menu','fees-discount',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(132,5,'âž¡ Create Fees Discount Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(133,5,'âž¡ Fees Discount Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(134,5,'âž¡ Fees Discount Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(135,5,'âž¡ Fees Discount Assign','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(136,5,'Fees Carry Forward Menu','fees-forward',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(137,6,'Accounts Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(138,6,'Profit Menu','profit',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(139,6,'Income Menu','add-income',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(140,6,'âž¡ Create Income Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(141,6,'âž¡ Income Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(142,6,'âž¡ Income Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(143,6,'Expense Menu','add-expense',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(144,6,'âž¡ Create Expense Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(145,6,'âž¡ Expense Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(146,6,'âž¡ Expense Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(147,6,'Search Menu','search-account',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(148,6,'Chart of Account Menu','chart-of-account',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(149,6,'âž¡ Create Chart of Account Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(150,6,'âž¡ Chart of Account Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(151,6,'âž¡ Chart of Account Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(152,6,'Payment method Menu','payment-method',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(153,6,'âž¡ Create Payment method Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(154,6,'âž¡ Payment method Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(155,6,'âž¡ Payment method Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(156,6,'Bank Account Menu','bank-account',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(157,6,'âž¡ Create Bank Account Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(158,6,'âž¡ Bank Account Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(159,6,'âž¡ Bank Account Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(160,7,'Human Resource Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(161,7,'Staff Directory Menu','staff-directory',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(162,7,'âž¡ Staff Directory Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(163,7,'âž¡ Staff Directory Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(164,7,'âž¡ Staff Directory Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(165,7,'Staff Attendance Menu','staff-attendance',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(166,7,'âž¡ Staff Attendance Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(167,7,'âž¡ Staff Attendance Edit','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(168,7,'âž¡ Staff Attendance Delete','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(169,7,'Staff Attendance Report Menu','staff-attendance-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(170,7,'Payroll Menu','payroll',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(171,7,'âž¡ Payroll Edit','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(172,7,'âž¡ Payroll Delete','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(173,7,'âž¡ Payroll Search','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(174,7,'âž¡ Generate Payroll','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(175,7,'âž¡ Payroll Create','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(176,7,'âž¡ Payroll Proceed To Pay','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(177,7,'âž¡ View Payslip','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(178,7,'Payroll Report Menu','payroll-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(179,7,'âž¡ Payroll Report Search','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(180,7,'Designations Menu','designation',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(181,7,'âž¡ Designations Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(182,7,'âž¡ Designations Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(183,7,'âž¡ Designations Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(184,7,'Departments Menu','department',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(185,7,'âž¡ Departments Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(186,7,'âž¡ Departments Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(187,7,'âž¡ Departments Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(188,8,'Leave Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(189,8,'Approve Leave Menu','approve-leave',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(190,8,'âž¡ Approve Leave Add','',0,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(191,8,'âž¡ Approve Leave Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(192,8,'âž¡ Approve Leave Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(193,8,'Apply Leave Menu','apply-leave',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(194,8,'âž¡ Apply Leave View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(195,8,'âž¡ Apply Leave Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(196,8,'Pending Leave Menu','pending-leave',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(197,8,'âž¡ Pending Leave View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(198,8,'âž¡ Pending Leave Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(199,8,'Leave Define Menu','leave-define',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(200,8,'âž¡ Leave Define Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(201,8,'âž¡ Leave Define Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(202,8,'âž¡ Leave Define Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(203,8,'Leave Type Menu','leave-type',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(204,8,'âž¡ Leave Type Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(205,8,'âž¡ Leave Type Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(206,8,'âž¡ Leave Type Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(207,9,'Examination Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(208,9,'Add Exam Type Menu','exam-type',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(209,9,'âž¡ Add Exam Type Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(210,9,'âž¡ Add Exam Type Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(211,9,'âž¡ Add Exam Type Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(214,9,'Exam Setup Menu','exam',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(215,9,'âž¡ Exam Setup Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(216,9,'âž¡ Exam Setup Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(217,9,'Exam Schedule Menu','exam-schedule',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(218,9,'âž¡ Exam Schedule Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(219,9,'âž¡ Exam Schedule Create','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(220,9,'Exam Attendance Menu','exam-attendance',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(221,9,'âž¡ Exam Attendance Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(222,9,'Marks Register Menu','marks-register',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(223,9,'âž¡ Marks Register Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(224,9,'âž¡ Marks Register Create','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(225,9,'Marks Grade Menu','marks-grade',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(226,9,'âž¡ Marks Grade Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(227,9,'âž¡ Marks Grade Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(228,9,'âž¡ Marks Grade Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(229,9,'Send Marks By SMS Menu','send-marks-by-sms',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(230,9,'Question Group Menu','question-group',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(231,9,'âž¡ Question Group Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(232,9,'âž¡ Question Group Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(233,9,'âž¡ Question Group Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(234,9,'Question Bank Menu','question-bank',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(235,9,'âž¡ Question Bank Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(236,9,'âž¡ Question Bank Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(237,9,'âž¡ Question Bank Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(238,9,'Online Exam Menu','online-exam',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(239,9,'âž¡ Online Exam Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(240,9,'âž¡ Online Exam Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(241,9,'âž¡ Online Exam Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(242,9,'âž¡ Online Exam Manage Question','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(243,9,'âž¡ Online Exam Marks Register','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(244,9,'âž¡ Online Exam Result','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(245,10,'Academics Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(246,10,'Class Routine Menu','class-routine-new',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(247,10,'âž¡ Class Routine Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(248,10,'âž¡ Class Routine Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(249,10,'âž¡ Class Routine Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(250,10,'Assign Subject Menu','assign-subject',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(251,10,'âž¡ Assign Subject Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(252,10,'âž¡ Assign Subject Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(253,10,'Assign Class Teacher Menu','assign-class-teacher',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(254,10,'âž¡ Assign Class Teacher Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(255,10,'âž¡ Assign Class Teacher Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(256,10,'âž¡ Assign Class Teacher Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(257,10,'Subjects Menu','subject',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(258,10,'âž¡ Subjects Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(259,10,'âž¡ Subjects Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(260,10,'âž¡ Subjects Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(261,10,'Class Menu','class',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(262,10,'âž¡ Class Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(263,10,'âž¡ Class Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(264,10,'âž¡ Class Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(265,10,'Section Menu','section',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(266,10,'âž¡ Section Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(267,10,'âž¡ Section Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(268,10,'âž¡ Section Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(269,10,'Class Room Menu','class-room',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(270,10,'âž¡ Class Room Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(271,10,'âž¡ Class Room Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(272,10,'âž¡ Class Room Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(273,10,'CL/EX Time Setup Menu','class-time',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(274,10,'âž¡ CL/EX Time Setup Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(275,10,'âž¡ CL/EX Time Setup Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(276,10,'âž¡ CL/EX Time Setup Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(277,11,'Homework Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(278,11,'Add Homework Menu','add-homeworks',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(279,11,'âž¡ Create Homework Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(280,11,'Homework List Menu','homework-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(281,11,'âž¡ Homework List Evaluation','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(282,11,'âž¡ Homework List Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(283,11,'âž¡ Homework List Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(284,11,'Homework Evaluation Report Menu','evaluation-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(285,11,'âž¡ Homework Evaluation Report View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(286,12,'Communicate Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(287,12,'Notice Board Menu','notice-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(288,12,'âž¡ Create Notice Board Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(289,12,'âž¡ Create Notice Board Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(290,12,'âž¡ Create Notice Board Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(291,12,'Send Email / SMS  Menu','send-email-sms-view',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(292,12,'âž¡ Send Email / SMS  Send','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(293,12,'Email / SMS Log Menu','email-sms-log',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(294,12,'Event Menu','event',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(295,12,'âž¡ Event Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(296,12,'âž¡ Event Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(297,12,'âž¡ Event Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(298,13,'Library Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(299,13,'Add Book Menu','add-book',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(300,13,'âž¡ Create Add Book Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(301,13,'Book List  Menu','book-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(302,13,'âž¡ Create Book List Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(303,13,'âž¡ Create Book List Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(304,13,'Book Category Menu','book-category-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(305,13,'âž¡ Book Category Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(306,13,'âž¡ Book Category Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(307,13,'âž¡ Book Category Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(308,13,'Add Member Menu','library-member',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(309,13,'âž¡ Add Member Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(310,13,'âž¡ Add Member Cancel','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(311,13,'Issue/Return Book Menu','member-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(312,13,'âž¡ Issue/Return Book Issue','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(313,13,'âž¡ Issue/Return Book Return','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(314,13,'All Issued Book','all-issed-book',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(315,14,'Inventory Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(316,14,'Item Category Menu','item-category',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(317,14,'âž¡ Create Item Category Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(318,14,'âž¡ Create Item Category Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(319,14,'âž¡ Item Category Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(320,14,'Item List Menu','item-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(321,14,'âž¡ Create Item List Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(322,14,'âž¡ Item List Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(323,14,'âž¡ Item List Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(324,14,'Item Store Menu','item-store',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(325,14,'âž¡ Create Item Store Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(326,14,'âž¡ Item Store Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(327,14,'âž¡ Item Store Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(328,14,'Supplier Menu','suppliers',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(329,14,'âž¡ Create Supplier Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(330,14,'âž¡ Supplier Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(331,14,'âž¡ Supplier Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(332,14,'Item Receive Menu','item-receive',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(333,14,'âž¡ Create Item Receive Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(334,14,'Item Receive List Menu','item-receive-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(335,14,'âž¡ Create Item Receive List Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(336,14,'âž¡ Item Receive List Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(337,14,'âž¡ Item Receive List View','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(338,14,'âž¡ Item Receive List Cancel','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(339,14,'Item Sell Menu','item-sell-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(340,14,'âž¡ Create Item Sell Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(341,14,'âž¡ Item Sell Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(342,14,'âž¡ Item Sell Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(343,14,'âž¡ Add Payment','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(344,14,'âž¡ View Payment','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(345,14,'Item Issue Menu','item-issue',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(346,14,'âž¡ Create Item Issue Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(347,14,'âž¡ Item Issue Return','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(348,15,'Transport Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(349,15,'Routes Menu','transport-route',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(350,15,'âž¡ Create Routes Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(351,15,'âž¡ Create Routes Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(352,15,'âž¡ Create Routes Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(353,15,'Vehicle Menu','vehicle',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(354,15,'âž¡ Create Vehicle Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(355,15,'âž¡ Create Vehicle Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(356,15,'âž¡ Create Vehicle Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(357,15,'Assign Vehicle Menu','assign-vehicle',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(358,15,'âž¡ Create Assign Vehicle Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(359,15,'âž¡ Create Assign Vehicle Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(360,15,'âž¡ Create Assign Vehicle Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(361,15,'Student Transport Report Menu','student-transport-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(362,16,'Dormitory Menu','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(363,16,'Dormitory Rooms Menu','room-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(364,16,'âž¡ Create Dormitory Rooms Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(365,16,'âž¡ Create Dormitory Rooms Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(366,16,'âž¡ Create Dormitory Rooms Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(367,16,'Dormitory Menu','dormitory-list',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(368,16,'âž¡ Create Dormitory Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(369,16,'âž¡ Create Dormitory Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(370,16,'âž¡ Create Dormitory Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(371,16,'Room Type Menu','room-type',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(372,16,'âž¡ Create Room Type Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(373,16,'âž¡ Create Room Type Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(374,16,'âž¡ Create Room Type Delete','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(375,16,'Student Dormitory Report Menu','student-dormitory-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(376,17,'Reports Menu','student-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(377,17,'Guardian Report Menu','guardian-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(378,17,'Student History Menu','student-history',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(379,17,'Student Login Report','student-login-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(380,17,'âž¡ Student Login Report Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(381,17,'Fees Statement Menu','fees-statement',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(382,17,'Balance Fees Report Menu','balance-fees-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(383,17,'Transaction Report Menu','transaction-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(384,17,'Class Report Menu','class-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(385,17,'Class Routine Menu','class-routine-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(386,17,'Exam Routine Menu','exam-routine-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(387,17,'Teacher Class Routine Menu','teacher-class-routine-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(388,17,'Merit List Report Menu','merit-list-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(389,17,'Online Exam Report Menu','online-exam-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(390,17,'Mark Sheet Report Menu','mark-sheet-report-student',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(391,17,'Tabulation Sheet Report Menu','tabulation-sheet-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(392,17,'Progress Card Report Menu','progress-card-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(393,17,'Student Fine Report Menu','student-fine-report',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(394,17,'User Log Menu','user-log',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(395,8,'âž¡ Apply Leave Add','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(396,8,'âž¡ Apply Leave Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(397,9,'âž¡ Exam Setup Edit','',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22');
/*!40000 ALTER TABLE `sm_module_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_module_permission_assigns`
--

DROP TABLE IF EXISTS `sm_module_permission_assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_module_permission_assigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `module_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_module_permission_assigns_module_id_foreign` (`module_id`),
  KEY `sm_module_permission_assigns_role_id_foreign` (`role_id`),
  KEY `sm_module_permission_assigns_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_module_permission_assigns_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `sm_module_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_module_permission_assigns_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_module_permission_assigns_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_module_permission_assigns`
--

LOCK TABLES `sm_module_permission_assigns` WRITE;
/*!40000 ALTER TABLE `sm_module_permission_assigns` DISABLE KEYS */;
INSERT INTO `sm_module_permission_assigns` VALUES (1,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',1,1,1,1,1),(2,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',2,1,1,1,1),(3,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',3,1,1,1,1),(4,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',4,1,1,1,1),(5,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',5,1,1,1,1),(6,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',6,1,1,1,1),(7,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',7,1,1,1,1),(8,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',8,1,1,1,1),(9,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',9,1,1,1,1),(10,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',10,1,1,1,1),(11,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',11,1,1,1,1),(12,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',12,1,1,1,1),(13,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',13,1,1,1,1),(14,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',14,1,1,1,1),(15,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',15,1,1,1,1),(16,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',16,1,1,1,1),(17,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',17,1,1,1,1),(18,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',18,1,1,1,1),(19,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',19,1,1,1,1),(20,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',20,1,1,1,1),(21,1,'2019-11-18 03:14:09','2019-11-18 03:14:09',21,1,1,1,1),(127,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',22,2,1,1,1),(128,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',23,2,1,1,1),(129,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',24,2,1,1,1),(130,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',25,2,1,1,1),(131,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',26,2,1,1,1),(132,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',27,2,1,1,1),(133,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',28,2,1,1,1),(134,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',29,2,1,1,1),(135,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',30,2,1,1,1),(136,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',31,2,1,1,1),(137,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',32,2,1,1,1),(138,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',33,2,1,1,1),(139,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',34,2,1,1,1),(140,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',35,2,1,1,1),(141,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',36,3,1,1,1),(142,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',37,3,1,1,1),(143,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',38,3,1,1,1),(144,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',39,3,1,1,1),(145,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',40,3,1,1,1),(146,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',41,3,1,1,1),(147,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',42,3,1,1,1),(148,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',43,3,1,1,1),(149,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',44,3,1,1,1),(150,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',45,3,1,1,1),(151,1,'2019-11-18 03:14:10','2019-11-18 03:14:10',46,3,1,1,1),(167,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',2,5,1,1,1),(168,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',3,5,1,1,1),(169,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',4,5,1,1,1),(170,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',5,5,1,1,1),(171,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',6,5,1,1,1),(172,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',7,5,1,1,1),(173,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',8,5,1,1,1),(174,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',9,5,1,1,1),(175,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',10,5,1,1,1),(176,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',11,5,1,1,1),(177,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',12,5,1,1,1),(178,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',13,5,1,1,1),(179,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',14,5,1,1,1),(180,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',15,5,1,1,1),(181,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',16,5,1,1,1),(182,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',17,5,1,1,1),(183,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',19,5,1,1,1),(184,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',20,5,1,1,1),(185,1,'2019-12-03 05:55:49','2019-12-03 05:55:49',21,5,1,1,1),(197,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',3,4,1,1,1),(198,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',4,4,1,1,1),(199,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',8,4,1,1,1),(200,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',9,4,1,1,1),(201,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',10,4,1,1,1),(202,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',11,4,1,1,1),(203,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',17,4,1,1,1),(204,1,'2019-12-03 06:14:06','2019-12-03 06:14:06',19,4,1,1,1),(205,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',3,6,1,1,1),(206,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',5,6,1,1,1),(207,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',6,6,1,1,1),(208,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',7,6,1,1,1),(209,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',14,6,1,1,1),(210,1,'2019-12-03 06:16:38','2019-12-03 06:16:38',17,6,1,1,1),(211,1,'2019-12-03 06:17:09','2019-12-03 06:17:09',2,7,1,1,1),(212,1,'2019-12-03 06:17:09','2019-12-03 06:17:09',3,7,1,1,1),(213,1,'2019-12-03 06:17:09','2019-12-03 06:17:09',7,7,1,1,1),(214,1,'2019-12-03 06:17:30','2019-12-03 06:17:30',3,8,1,1,1),(215,1,'2019-12-03 06:17:30','2019-12-03 06:17:30',7,8,1,1,1),(216,1,'2019-12-03 06:17:30','2019-12-03 06:17:30',13,8,1,1,1);
/*!40000 ALTER TABLE `sm_module_permission_assigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_module_permissions`
--

DROP TABLE IF EXISTS `sm_module_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_module_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dashboard_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_module_permissions_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_module_permissions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_module_permissions`
--

LOCK TABLES `sm_module_permissions` WRITE;
/*!40000 ALTER TABLE `sm_module_permissions` DISABLE KEYS */;
INSERT INTO `sm_module_permissions` VALUES (1,1,'Dashboard',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(2,1,'Admin Section',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(3,1,'Student Information',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(4,1,'Teacher',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(5,1,'Fees Collection',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(6,1,'Accounts',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(7,1,'Human Resource',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(8,1,'Leave Application',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(9,1,'Examination',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(10,1,'Academics',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(11,1,'Homework',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(12,1,'Communicate',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(13,1,'Library',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(14,1,'Inventory',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(15,1,'Transport',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(16,1,'Dormitory',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(17,1,'Reports',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(18,1,'System Settings',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(19,1,'Style',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(20,1,'API Permission',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(21,1,'Front Settings',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(22,2,'My Profile',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(23,2,'Fees',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(24,2,'Class Routine',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(25,2,'Homework',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(26,2,'Download Center',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(27,2,'Attendance',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(28,2,'Examinations',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(29,2,'Online Exam',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(30,2,'Notice Board',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(31,2,'Subjects',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(32,2,'Teacher',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(33,2,'Library',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(34,2,'Transfort',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(35,2,'Dormitory',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(36,3,'My Children',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(37,3,'Fees',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(38,3,'Class Routine',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(39,3,'Homework',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(40,3,'Attendance',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(41,3,'Exam Result',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(42,3,'Notice Board',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(43,3,'Subjects',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(44,3,'Teacher',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(45,3,'Transfort',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22'),(46,3,'Dormitory',1,1,1,1,'2019-07-24 21:21:21','2019-07-24 23:24:22');
/*!40000 ALTER TABLE `sm_module_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_modules`
--

DROP TABLE IF EXISTS `sm_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_modules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_modules_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_modules_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_modules`
--

LOCK TABLES `sm_modules` WRITE;
/*!40000 ALTER TABLE `sm_modules` DISABLE KEYS */;
INSERT INTO `sm_modules` VALUES (1,'Dashboard',1,0,'2020-08-10 05:58:17',NULL,1,1,1),(2,'Admin Section',1,1,'2020-08-10 05:58:17',NULL,1,1,1),(3,'Student Information',1,2,'2020-08-10 05:58:17',NULL,1,1,1),(4,'Teacher',1,3,'2020-08-10 05:58:17',NULL,1,1,1),(5,'Fees Collection',1,4,'2020-08-10 05:58:17',NULL,1,1,1),(6,'Accounts',1,5,'2020-08-10 05:58:17',NULL,1,1,1),(7,'Human resource',1,6,'2020-08-10 05:58:17',NULL,1,1,1),(8,'Leave Application',1,7,'2020-08-10 05:58:17',NULL,1,1,1),(9,'Examination',1,8,'2020-08-10 05:58:17',NULL,1,1,1),(10,'Academics',1,9,'2020-08-10 05:58:17',NULL,1,1,1),(11,'HomeWork',1,10,'2020-08-10 05:58:17',NULL,1,1,1),(12,'Communicate',1,11,'2020-08-10 05:58:17',NULL,1,1,1),(13,'Library',1,12,'2020-08-10 05:58:17',NULL,1,1,1),(14,'Inventory',1,13,'2020-08-10 05:58:17',NULL,1,1,1),(15,'Transport',1,14,'2020-08-10 05:58:17',NULL,1,1,1),(16,'Dormitory',1,15,'2020-08-10 05:58:17',NULL,1,1,1),(17,'Reports',1,16,'2020-08-10 05:58:17',NULL,1,1,1),(18,'System Settings',1,17,'2020-08-10 05:58:17',NULL,1,1,1),(19,'Common',1,18,'2020-08-10 05:58:17',NULL,1,1,1);
/*!40000 ALTER TABLE `sm_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_news`
--

DROP TABLE IF EXISTS `sm_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_news` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `news_title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `view_count` int(11) DEFAULT NULL,
  `active_status` int(11) DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_thumb` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `news_body` text COLLATE utf8mb4_unicode_ci,
  `publish_date` date DEFAULT NULL,
  `order` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_news_category_id_foreign` (`category_id`),
  KEY `sm_news_school_id_foreign` (`school_id`),
  KEY `sm_news_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_news_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_news_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `sm_news_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_news_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_news`
--

LOCK TABLES `sm_news` WRITE;
/*!40000 ALTER TABLE `sm_news` DISABLE KEYS */;
INSERT INTO `sm_news` VALUES (1,'Harum ea nesciunt quos qui.',5,1,'public/uploads/news/news1.jpg',NULL,'Sapiente a quia assumenda voluptatem temporibus illum. Placeat minus eos nihil similique et non labore. Accusantium magni totam molestias iste. Non ab aut rerum id. Aliquam culpa unde facilis nihil ab. Aut perspiciatis veritatis ut sit temporibus nihil. Sapiente laudantium qui commodi autem. Vel quia aut aut incidunt quidem rerum nesciunt.','2019-06-02','1','2020-08-10 05:58:21',NULL,1,1,1,1,1),(2,'Cumque sunt nisi sapiente vero.',8,1,'public/uploads/news/news2.jpg',NULL,'Sapiente quia sunt dolorum similique. Exercitationem harum nemo quia ab. Alias harum vero et quia. Rerum harum culpa praesentium consectetur est. Consequatur harum voluptate possimus illo. Modi quisquam laboriosam adipisci quia fuga corporis. Ut optio officiis eius quisquam debitis. Repudiandae cupiditate recusandae est ratione sit et. Neque dolorum et voluptas veritatis debitis. Sed suscipit accusantium rerum sunt voluptatem non modi. Cum et natus quas.','2019-06-02','2','2020-08-10 05:58:21',NULL,1,1,1,1,1),(3,'Quam odio qui velit est similique.',3,1,'public/uploads/news/news3.jpg',NULL,'Aut debitis qui velit nostrum alias. Laboriosam architecto magni ut magni id minima cum. Maiores ipsa dolorem dignissimos optio velit. Et quo sed tenetur sequi pariatur. Qui facere qui sit doloribus id aperiam. Est deleniti illo voluptas quis nostrum. Et labore ut nesciunt et nisi consequatur saepe aliquid.','2019-06-02','3','2020-08-10 05:58:21',NULL,1,1,1,1,1),(4,'Odit fugit aut rerum ad.',8,1,'public/uploads/news/news4.jpg',NULL,'Fugit earum aut vero officia numquam. Maiores odio accusamus nobis quae. Quo sed cum distinctio error. Id tenetur omnis in culpa maxime quia. Et ea qui in tempora qui omnis dolor. Quod ratione ducimus ex ut enim dolor consequatur ex. Suscipit veritatis quae eum soluta optio ab placeat. Consequuntur quos velit dolorem commodi eum. Velit qui itaque et aut dolorem repellendus molestiae. Deserunt expedita qui aut. Praesentium numquam dolor eum.','2019-06-02','4','2020-08-10 05:58:21',NULL,1,1,1,1,1),(5,'Eaque et modi iste molestiae.',0,1,'public/uploads/news/news5.jpg',NULL,'Dolor ipsam veniam doloremque numquam voluptatibus quas error dolores. Et voluptate omnis repellendus vel sint quod eaque. Et necessitatibus omnis natus quae. Alias assumenda veritatis sit ut. Et minima fuga quo perferendis voluptas. Nesciunt rerum quo et quisquam est. Assumenda veritatis deserunt error error. Magni asperiores natus quis ratione sit velit.','2019-06-02','5','2020-08-10 05:58:21',NULL,2,1,1,1,1),(6,'Nulla omnis nulla dolor qui pariatur.',0,1,'public/uploads/news/news6.jpg',NULL,'Saepe dolorum saepe nesciunt rerum nihil aut. Tempora vel vero dolores velit voluptatem assumenda consequatur. A quas aut impedit nulla. Itaque aperiam nihil harum tempore. Ut est quia pariatur ratione. Dolorem labore laboriosam eum veniam id debitis accusamus. Omnis possimus dolorem qui voluptas impedit. Alias fugit dolorem necessitatibus aliquam enim dolorum.','2019-06-02','6','2020-08-10 05:58:21',NULL,2,1,1,1,1),(7,'Vitae labore illum unde eligendi.',8,1,'public/uploads/news/news7.jpg',NULL,'Quasi omnis voluptatem possimus voluptatem voluptas in. Dolores sint dolores eveniet quia. Et earum laboriosam ea reprehenderit porro enim. Minus et voluptatum esse vero id earum ut. Animi voluptas quasi enim corrupti. Laborum repudiandae id iste aut. Quam quo expedita dolores veritatis non. Architecto iusto itaque ea.','2019-06-02','7','2020-08-10 05:58:21',NULL,2,1,1,1,1),(8,'Iste et doloremque enim esse eum.',4,1,'public/uploads/news/news8.jpg',NULL,'Ut laborum sapiente rem ratione. Quaerat commodi cumque at blanditiis aut earum. Et quos et rem quae earum. Sed dolore beatae veniam reiciendis unde repudiandae. Molestiae pariatur totam placeat id suscipit dolore. Laborum aut nesciunt laboriosam qui qui nisi non. Iure ullam quia delectus. Fugit quo officiis ea quis.','2019-06-02','8','2020-08-10 05:58:21',NULL,2,1,1,1,1),(9,'Quo totam voluptatem fugit distinctio.',2,1,'public/uploads/news/news9.jpg',NULL,'Voluptas soluta esse ea deserunt. Sed quidem et consequatur atque non quaerat id. Rerum quisquam voluptas vel. Similique quia non deleniti aut. Occaecati eos est ea expedita sed. Esse dolorum mollitia sed culpa quo pariatur odit eos. Veniam nobis dolor cupiditate cumque assumenda. Est dolor nobis ut neque laboriosam illo et. Voluptatem maxime iste aut omnis ex laborum enim. Inventore autem qui id. Quo quo qui optio quaerat consectetur mollitia corrupti.','2019-06-02','9','2020-08-10 05:58:21',NULL,3,1,1,1,1),(10,'Sunt beatae quisquam in delectus.',7,1,'public/uploads/news/news10.jpg',NULL,'Aut quis fugit quis porro. Aut laboriosam rerum dicta sint. Ab quia dolor ut placeat qui quis dolorem. Corrupti sit aliquam deleniti eum. Eaque dolore rem aperiam sed sit. Consequuntur et earum necessitatibus aut iste reprehenderit. Consectetur nostrum repudiandae autem aut sint suscipit. Dolor dolor ducimus unde expedita repudiandae. Expedita saepe voluptates vitae asperiores. Quis necessitatibus labore qui blanditiis praesentium vitae vel.','2019-06-02','10','2020-08-10 05:58:21',NULL,3,1,1,1,1),(11,'Rerum inventore voluptas eaque.',1,1,'public/uploads/news/news11.jpg',NULL,'Repellendus iste veniam perferendis consequatur voluptatem. Eaque quo dolorem est id voluptatem. Delectus aut aut magni praesentium similique quis vel. Et illum distinctio ea. Consequuntur repellat et a non voluptas a. Molestias in distinctio eum minima eum adipisci est. Ut adipisci maiores quia voluptatibus sunt sint. Voluptatem reiciendis dolores animi ea nostrum excepturi ut accusamus. Cumque id qui dolor.','2019-06-02','11','2020-08-10 05:58:21',NULL,3,1,1,1,1),(12,'Sed consequatur voluptas repellat.',3,1,'public/uploads/news/news12.jpg',NULL,'Deleniti nemo autem porro quia est dolor. Molestiae dolores deserunt est consequuntur repudiandae. Et at voluptas aspernatur ea. Voluptas ut similique quo qui. Quam et nisi nam doloribus. Quas voluptatem velit quisquam tempora enim. Velit perspiciatis asperiores et aut velit fugiat ratione. Rerum reiciendis ea aut aut omnis. Quae quaerat voluptate porro et nulla placeat temporibus est. Delectus qui qui quaerat nisi aut minima. Nam qui optio quibusdam cumque.','2019-06-02','12','2020-08-10 05:58:21',NULL,3,1,1,1,1);
/*!40000 ALTER TABLE `sm_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_news_categories`
--

DROP TABLE IF EXISTS `sm_news_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_news_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_news_categories_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_news_categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_news_categories`
--

LOCK TABLES `sm_news_categories` WRITE;
/*!40000 ALTER TABLE `sm_news_categories` DISABLE KEYS */;
INSERT INTO `sm_news_categories` VALUES (1,'International',NULL,NULL,1),(2,'Our history',NULL,NULL,1),(3,'Our mission and vision',NULL,NULL,1),(4,'National',NULL,NULL,1),(5,'Sports',NULL,NULL,1);
/*!40000 ALTER TABLE `sm_news_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_news_pages`
--

DROP TABLE IF EXISTS `sm_news_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_news_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `main_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_news_pages_created_by_foreign` (`created_by`),
  KEY `sm_news_pages_updated_by_foreign` (`updated_by`),
  KEY `sm_news_pages_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_news_pages_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_news_pages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_news_pages_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_news_pages`
--

LOCK TABLES `sm_news_pages` WRITE;
/*!40000 ALTER TABLE `sm_news_pages` DISABLE KEYS */;
INSERT INTO `sm_news_pages` VALUES (1,NULL,NULL,'News Infix','Lisus consequat sapien metus dis urna, facilisi. Nonummy rutrum eu lacinia platea a, ipsum parturient, orci tristique. Nisi diam natoque.','Under Graduate Education','INFIX has all in one place. Youâ€™ll find everything what you are looking into education management system software. We care! User will never bothered in our real eye catchy user friendly UI & UX  Interface design. You know! Smart Idea always comes to well planners. And Our INFIX is Smart for its Well Documentation. Explore in new support world! Itâ€™s now faster & quicker. Youâ€™ll find us on Support Ticket, Email, Skype, WhatsApp.','public/uploads/about_page/about.jpg','public/uploads/about_page/about-img.jpg','Learn More News ','news-page',1,1,1,1);
/*!40000 ALTER TABLE `sm_news_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_notice_boards`
--

DROP TABLE IF EXISTS `sm_notice_boards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_notice_boards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notice_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notice_message` text COLLATE utf8mb4_unicode_ci,
  `notice_date` date DEFAULT NULL,
  `publish_on` date DEFAULT NULL,
  `inform_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Notice message sent to these roles',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `is_published` int(11) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_notice_boards_school_id_foreign` (`school_id`),
  KEY `sm_notice_boards_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_notice_boards_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_notice_boards_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_notice_boards`
--

LOCK TABLES `sm_notice_boards` WRITE;
/*!40000 ALTER TABLE `sm_notice_boards` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_notice_boards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_notifications`
--

DROP TABLE IF EXISTS `sm_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `message` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(4) NOT NULL DEFAULT '0',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT '1',
  `role_id` int(10) unsigned NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned NOT NULL DEFAULT '1',
  `updated_by` int(10) unsigned NOT NULL DEFAULT '1',
  `school_id` int(10) unsigned NOT NULL DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_notifications_school_id_foreign` (`school_id`),
  KEY `sm_notifications_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_notifications_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_notifications_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_notifications`
--

LOCK TABLES `sm_notifications` WRITE;
/*!40000 ALTER TABLE `sm_notifications` DISABLE KEYS */;
INSERT INTO `sm_notifications` VALUES (1,'2020-08-20','Syllabus updated','syllabus-list',1,1,'2020-08-20 10:55:40','2020-08-20 10:57:55',1,1,1,1,1,1);
/*!40000 ALTER TABLE `sm_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_online_exam_marks`
--

DROP TABLE IF EXISTS `sm_online_exam_marks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_online_exam_marks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `marks` int(11) DEFAULT NULL,
  `abs` int(11) NOT NULL DEFAULT '0',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_online_exam_marks_student_id_foreign` (`student_id`),
  KEY `sm_online_exam_marks_subject_id_foreign` (`subject_id`),
  KEY `sm_online_exam_marks_exam_id_foreign` (`exam_id`),
  KEY `sm_online_exam_marks_school_id_foreign` (`school_id`),
  KEY `sm_online_exam_marks_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_online_exam_marks_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_marks_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_marks_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_marks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_marks_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_online_exam_marks`
--

LOCK TABLES `sm_online_exam_marks` WRITE;
/*!40000 ALTER TABLE `sm_online_exam_marks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_online_exam_marks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_online_exam_question_assigns`
--

DROP TABLE IF EXISTS `sm_online_exam_question_assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_online_exam_question_assigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `online_exam_id` int(10) unsigned DEFAULT NULL,
  `question_bank_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_online_exam_question_assigns_online_exam_id_foreign` (`online_exam_id`),
  KEY `sm_online_exam_question_assigns_question_bank_id_foreign` (`question_bank_id`),
  KEY `sm_online_exam_question_assigns_school_id_foreign` (`school_id`),
  KEY `sm_online_exam_question_assigns_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_online_exam_question_assigns_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_question_assigns_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `sm_online_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_question_assigns_question_bank_id_foreign` FOREIGN KEY (`question_bank_id`) REFERENCES `sm_question_banks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_question_assigns_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_online_exam_question_assigns`
--

LOCK TABLES `sm_online_exam_question_assigns` WRITE;
/*!40000 ALTER TABLE `sm_online_exam_question_assigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_online_exam_question_assigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_online_exam_question_mu_options`
--

DROP TABLE IF EXISTS `sm_online_exam_question_mu_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_online_exam_question_mu_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 unchecked 1 checked',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `online_exam_question_id` int(10) unsigned DEFAULT NULL COMMENT 'here we use foreign key shorter name',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `on_ex_qu_id` (`online_exam_question_id`),
  KEY `sm_online_exam_question_mu_options_school_id_foreign` (`school_id`),
  KEY `sm_online_exam_question_mu_options_academic_id_foreign` (`academic_id`),
  CONSTRAINT `on_ex_qu_id` FOREIGN KEY (`online_exam_question_id`) REFERENCES `sm_online_exam_questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_question_mu_options_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_question_mu_options_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_online_exam_question_mu_options`
--

LOCK TABLES `sm_online_exam_question_mu_options` WRITE;
/*!40000 ALTER TABLE `sm_online_exam_question_mu_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_online_exam_question_mu_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_online_exam_questions`
--

DROP TABLE IF EXISTS `sm_online_exam_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_online_exam_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mark` int(11) DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_ci,
  `trueFalse` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'F = false, T = true ',
  `suitable_words` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `online_exam_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_online_exam_questions_online_exam_id_foreign` (`online_exam_id`),
  KEY `sm_online_exam_questions_school_id_foreign` (`school_id`),
  KEY `sm_online_exam_questions_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_online_exam_questions_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_questions_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `sm_online_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exam_questions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_online_exam_questions`
--

LOCK TABLES `sm_online_exam_questions` WRITE;
/*!40000 ALTER TABLE `sm_online_exam_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_online_exam_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_online_exams`
--

DROP TABLE IF EXISTS `sm_online_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_online_exams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_time` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_date_time` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `instruction` text COLLATE utf8mb4_unicode_ci,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 = Pending 1 Published',
  `is_taken` tinyint(4) DEFAULT '0',
  `is_closed` tinyint(4) DEFAULT '0',
  `is_waiting` tinyint(4) DEFAULT '0',
  `is_running` tinyint(4) DEFAULT '0',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_online_exams_class_id_foreign` (`class_id`),
  KEY `sm_online_exams_section_id_foreign` (`section_id`),
  KEY `sm_online_exams_subject_id_foreign` (`subject_id`),
  KEY `sm_online_exams_school_id_foreign` (`school_id`),
  KEY `sm_online_exams_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_online_exams_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exams_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exams_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_online_exams_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_online_exams`
--

LOCK TABLES `sm_online_exams` WRITE;
/*!40000 ALTER TABLE `sm_online_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_online_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_optional_subject_assigns`
--

DROP TABLE IF EXISTS `sm_optional_subject_assigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_optional_subject_assigns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `session_id` int(10) unsigned NOT NULL,
  `academic_id` int(10) unsigned DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_optional_subject_assigns_student_id_foreign` (`student_id`),
  KEY `sm_optional_subject_assigns_subject_id_foreign` (`subject_id`),
  KEY `sm_optional_subject_assigns_school_id_foreign` (`school_id`),
  KEY `sm_optional_subject_assigns_session_id_foreign` (`session_id`),
  KEY `sm_optional_subject_assigns_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_optional_subject_assigns_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_optional_subject_assigns_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_optional_subject_assigns_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_optional_subject_assigns_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_optional_subject_assigns_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_optional_subject_assigns`
--

LOCK TABLES `sm_optional_subject_assigns` WRITE;
/*!40000 ALTER TABLE `sm_optional_subject_assigns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_optional_subject_assigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_parents`
--

DROP TABLE IF EXISTS `sm_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_parents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fathers_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fathers_mobile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fathers_occupation` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fathers_photo` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mothers_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mothers_mobile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mothers_occupation` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mothers_photo` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `relation` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_mobile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_occupation` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_relation` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_photo` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardians_address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_guardian` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_parents_user_id_foreign` (`user_id`),
  KEY `sm_parents_school_id_foreign` (`school_id`),
  KEY `sm_parents_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_parents_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_parents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_parents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_parents`
--

LOCK TABLES `sm_parents` WRITE;
/*!40000 ALTER TABLE `sm_parents` DISABLE KEYS */;
INSERT INTO `sm_parents` VALUES (1,'','','',NULL,'','','',NULL,'O','','998934120958','someguardian@gmail.com','','Other',NULL,'',NULL,1,'2020-01-01 07:00:00','2020-08-10 08:54:41',3,1,1),(2,'','','',NULL,'','','',NULL,'O','','998934120958','someguardian1@gmail.com','','Other',NULL,'',NULL,1,'2020-01-01 07:00:00','2020-08-12 02:47:56',5,1,1),(3,'','','',NULL,'','','',NULL,'O','','+998915010099','murodjonkhalokov@gmail.com','','Other',NULL,'',NULL,1,'2020-01-01 07:00:00','2020-08-20 11:17:50',8,1,1),(4,'','','',NULL,'','','',NULL,'O','','123123123123','sdfadsf@dfsf.com','','Other',NULL,'',NULL,1,'2020-01-01 12:00:00','2020-09-05 13:56:45',28,1,1),(5,'','','',NULL,'','','',NULL,'O','','123123131312','asdasdasd@sadasd.com','','Other',NULL,'',NULL,1,'2020-01-01 12:00:00','2020-09-05 13:57:53',30,1,1),(6,'','','',NULL,'','','',NULL,NULL,NULL,'gpEWdbBDI4IgKIPBWEdoYRKas','GTkwxIMBltI3idBkjXplOGOyh',NULL,'Other',NULL,NULL,NULL,1,'2020-01-01 12:00:00','2020-09-06 06:59:12',34,1,1),(7,'','','',NULL,'','','',NULL,NULL,NULL,'kKNoG9g0igoOu2c559jYxs4tS','64ZEwpwPb5KqP8BRhMqSX041q',NULL,'Other',NULL,NULL,NULL,1,'2021-01-01 07:00:00','2020-09-10 20:52:28',36,1,1);
/*!40000 ALTER TABLE `sm_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_payment_gateway_settings`
--

DROP TABLE IF EXISTS `sm_payment_gateway_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_payment_gateway_settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_client_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_mode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_secret_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_secret_word` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_publisher_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_private_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bank_details` text COLLATE utf8mb4_unicode_ci,
  `cheque_details` text COLLATE utf8mb4_unicode_ci,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_payment_gateway_settings_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_payment_gateway_settings_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_payment_gateway_settings`
--

LOCK TABLES `sm_payment_gateway_settings` WRITE;
/*!40000 ALTER TABLE `sm_payment_gateway_settings` DISABLE KEYS */;
INSERT INTO `sm_payment_gateway_settings` VALUES (1,'Stripe','demo@strip.com','12334589',NULL,'',NULL,'AVZdghanegaOjiL6DPXd0XwjMGEQ2aXc58z1-isWmBFnw1h2j','AVZdghanegaOjiL6DPXd0XwjMGEQ2aXc58z1',NULL,NULL,0,'2020-08-10 05:58:15',NULL,NULL,NULL,1,1,1),(2,'Paystack','demo@gmail.com','12334589',NULL,'',NULL,'sk_live_2679322872013c265e161bc8ea11efc1e822bce1',NULL,'pk_live_e5738ce9aade963387204f1f19bee599176e7a71',NULL,0,'2020-08-10 05:58:15',NULL,NULL,NULL,1,1,1),(3,'Bank',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2020-08-10 05:58:15',NULL,NULL,NULL,1,1,1),(4,'Cheque',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2020-08-10 05:58:15',NULL,NULL,NULL,1,1,1);
/*!40000 ALTER TABLE `sm_payment_gateway_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_payment_methhods`
--

DROP TABLE IF EXISTS `sm_payment_methhods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_payment_methhods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `gateway_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_payment_methhods_gateway_id_foreign` (`gateway_id`),
  KEY `sm_payment_methhods_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_payment_methhods_gateway_id_foreign` FOREIGN KEY (`gateway_id`) REFERENCES `sm_payment_gateway_settings` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_payment_methhods_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_payment_methhods`
--

LOCK TABLES `sm_payment_methhods` WRITE;
/*!40000 ALTER TABLE `sm_payment_methhods` DISABLE KEYS */;
INSERT INTO `sm_payment_methhods` VALUES (1,'Cash','System',1,'2020-08-10 05:58:15','2020-09-13 09:52:03',NULL,1,1,1),(2,'Cheque','System',1,'2020-08-10 05:58:15','2020-09-13 09:52:03',NULL,1,1,1),(3,'Bank','System',1,'2020-08-10 05:58:15','2020-09-13 09:52:03',NULL,1,1,1),(4,'Stripe','System',0,'2020-08-10 05:58:15','2020-09-13 09:52:03',NULL,1,1,1),(5,'Paystack','System',0,'2020-08-10 05:58:15','2020-09-13 09:52:03',NULL,1,1,1);
/*!40000 ALTER TABLE `sm_payment_methhods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_phone_call_logs`
--

DROP TABLE IF EXISTS `sm_phone_call_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_phone_call_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `next_follow_up_date` date DEFAULT NULL,
  `call_duration` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `call_type` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_phone_call_logs_school_id_foreign` (`school_id`),
  KEY `sm_phone_call_logs_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_phone_call_logs_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_phone_call_logs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_phone_call_logs`
--

LOCK TABLES `sm_phone_call_logs` WRITE;
/*!40000 ALTER TABLE `sm_phone_call_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_phone_call_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_postal_dispatches`
--

DROP TABLE IF EXISTS `sm_postal_dispatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_postal_dispatches` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `to_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_postal_dispatches_school_id_foreign` (`school_id`),
  KEY `sm_postal_dispatches_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_postal_dispatches_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_postal_dispatches_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_postal_dispatches`
--

LOCK TABLES `sm_postal_dispatches` WRITE;
/*!40000 ALTER TABLE `sm_postal_dispatches` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_postal_dispatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_postal_receives`
--

DROP TABLE IF EXISTS `sm_postal_receives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_postal_receives` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `to_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_postal_receives_school_id_foreign` (`school_id`),
  KEY `sm_postal_receives_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_postal_receives_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_postal_receives_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_postal_receives`
--

LOCK TABLES `sm_postal_receives` WRITE;
/*!40000 ALTER TABLE `sm_postal_receives` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_postal_receives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_product_purchases`
--

DROP TABLE IF EXISTS `sm_product_purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_product_purchases` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `purchase_date` date NOT NULL,
  `expaire_date` date NOT NULL,
  `price` double(10,2) DEFAULT NULL,
  `paid_amount` double(10,2) DEFAULT NULL,
  `due_amount` double(10,2) DEFAULT NULL,
  `package` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_product_purchases_user_id_foreign` (`user_id`),
  KEY `sm_product_purchases_staff_id_foreign` (`staff_id`),
  KEY `sm_product_purchases_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_product_purchases_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_product_purchases_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_product_purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_product_purchases`
--

LOCK TABLES `sm_product_purchases` WRITE;
/*!40000 ALTER TABLE `sm_product_purchases` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_product_purchases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_question_bank_mu_options`
--

DROP TABLE IF EXISTS `sm_question_bank_mu_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_question_bank_mu_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 = false, 1 = correct',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `question_bank_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_question_bank_mu_options_question_bank_id_foreign` (`question_bank_id`),
  KEY `sm_question_bank_mu_options_school_id_foreign` (`school_id`),
  KEY `sm_question_bank_mu_options_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_question_bank_mu_options_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_bank_mu_options_question_bank_id_foreign` FOREIGN KEY (`question_bank_id`) REFERENCES `sm_question_banks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_bank_mu_options_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_question_bank_mu_options`
--

LOCK TABLES `sm_question_bank_mu_options` WRITE;
/*!40000 ALTER TABLE `sm_question_bank_mu_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_question_bank_mu_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_question_banks`
--

DROP TABLE IF EXISTS `sm_question_banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_question_banks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'M for multi ans, T for trueFalse, F for fill in the blanks',
  `question` text COLLATE utf8mb4_unicode_ci,
  `marks` int(11) DEFAULT NULL,
  `trueFalse` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'F = false, T = true ',
  `suitable_words` text COLLATE utf8mb4_unicode_ci,
  `number_of_option` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `q_group_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_question_banks_q_group_id_foreign` (`q_group_id`),
  KEY `sm_question_banks_class_id_foreign` (`class_id`),
  KEY `sm_question_banks_section_id_foreign` (`section_id`),
  KEY `sm_question_banks_school_id_foreign` (`school_id`),
  KEY `sm_question_banks_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_question_banks_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_banks_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_banks_q_group_id_foreign` FOREIGN KEY (`q_group_id`) REFERENCES `sm_question_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_banks_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_banks_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_question_banks`
--

LOCK TABLES `sm_question_banks` WRITE;
/*!40000 ALTER TABLE `sm_question_banks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_question_banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_question_groups`
--

DROP TABLE IF EXISTS `sm_question_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_question_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_question_groups_school_id_foreign` (`school_id`),
  KEY `sm_question_groups_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_question_groups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_question_groups`
--

LOCK TABLES `sm_question_groups` WRITE;
/*!40000 ALTER TABLE `sm_question_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_question_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_question_levels`
--

DROP TABLE IF EXISTS `sm_question_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_question_levels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `level` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_question_levels_school_id_foreign` (`school_id`),
  KEY `sm_question_levels_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_question_levels_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_question_levels_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_question_levels`
--

LOCK TABLES `sm_question_levels` WRITE;
/*!40000 ALTER TABLE `sm_question_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_question_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_result_stores`
--

DROP TABLE IF EXISTS `sm_result_stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_result_stores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `student_roll_no` int(11) NOT NULL DEFAULT '1',
  `student_addmission_no` int(11) NOT NULL DEFAULT '1',
  `is_absent` int(11) NOT NULL DEFAULT '0' COMMENT '1=Absent, 0=Present',
  `total_marks` double(8,2) NOT NULL DEFAULT '0.00',
  `total_gpa_point` double(8,2) DEFAULT NULL,
  `total_gpa_grade` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '0',
  `teacher_remarks` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_type_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `exam_setup_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_result_stores_exam_type_id_foreign` (`exam_type_id`),
  KEY `sm_result_stores_subject_id_foreign` (`subject_id`),
  KEY `sm_result_stores_exam_setup_id_foreign` (`exam_setup_id`),
  KEY `sm_result_stores_student_id_foreign` (`student_id`),
  KEY `sm_result_stores_class_id_foreign` (`class_id`),
  KEY `sm_result_stores_section_id_foreign` (`section_id`),
  KEY `sm_result_stores_school_id_foreign` (`school_id`),
  KEY `sm_result_stores_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_result_stores_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_exam_setup_id_foreign` FOREIGN KEY (`exam_setup_id`) REFERENCES `sm_exam_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_exam_type_id_foreign` FOREIGN KEY (`exam_type_id`) REFERENCES `sm_exam_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_result_stores_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_result_stores`
--

LOCK TABLES `sm_result_stores` WRITE;
/*!40000 ALTER TABLE `sm_result_stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_result_stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_role_permissions`
--

DROP TABLE IF EXISTS `sm_role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_role_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `module_link_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_role_permissions_module_link_id_foreign` (`module_link_id`),
  KEY `sm_role_permissions_role_id_foreign` (`role_id`),
  KEY `sm_role_permissions_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_role_permissions_module_link_id_foreign` FOREIGN KEY (`module_link_id`) REFERENCES `sm_module_links` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_role_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_role_permissions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7662 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_role_permissions`
--

LOCK TABLES `sm_role_permissions` WRITE;
/*!40000 ALTER TABLE `sm_role_permissions` DISABLE KEYS */;
INSERT INTO `sm_role_permissions` VALUES (1,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',1,1,1,1,1),(2,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',2,1,1,1,1),(3,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',3,1,1,1,1),(4,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',4,1,1,1,1),(5,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',5,1,1,1,1),(6,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',6,1,1,1,1),(7,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',7,1,1,1,1),(8,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',8,1,1,1,1),(9,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',9,1,1,1,1),(10,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',10,1,1,1,1),(11,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',11,1,1,1,1),(12,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',12,1,1,1,1),(13,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',13,1,1,1,1),(14,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',14,1,1,1,1),(15,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',15,1,1,1,1),(16,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',16,1,1,1,1),(17,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',17,1,1,1,1),(18,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',18,1,1,1,1),(19,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',19,1,1,1,1),(20,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',20,1,1,1,1),(21,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',21,1,1,1,1),(22,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',22,1,1,1,1),(23,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',23,1,1,1,1),(24,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',24,1,1,1,1),(25,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',25,1,1,1,1),(26,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',26,1,1,1,1),(27,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',27,1,1,1,1),(28,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',28,1,1,1,1),(29,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',29,1,1,1,1),(30,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',30,1,1,1,1),(31,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',31,1,1,1,1),(32,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',32,1,1,1,1),(33,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',33,1,1,1,1),(34,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',34,1,1,1,1),(35,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',35,1,1,1,1),(36,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',36,1,1,1,1),(37,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',37,1,1,1,1),(38,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',38,1,1,1,1),(39,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',39,1,1,1,1),(40,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',40,1,1,1,1),(41,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',41,1,1,1,1),(42,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',42,1,1,1,1),(43,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',43,1,1,1,1),(44,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',44,1,1,1,1),(45,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',45,1,1,1,1),(46,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',46,1,1,1,1),(47,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',47,1,1,1,1),(48,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',48,1,1,1,1),(49,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',49,1,1,1,1),(50,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',50,1,1,1,1),(51,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',51,1,1,1,1),(52,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',52,1,1,1,1),(53,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',53,1,1,1,1),(54,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',54,1,1,1,1),(55,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',55,1,1,1,1),(56,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',56,1,1,1,1),(57,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',57,1,1,1,1),(58,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',58,1,1,1,1),(59,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',59,1,1,1,1),(60,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',60,1,1,1,1),(61,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',61,1,1,1,1),(62,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',62,1,1,1,1),(63,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',63,1,1,1,1),(64,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',64,1,1,1,1),(65,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',65,1,1,1,1),(66,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',66,1,1,1,1),(67,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',67,1,1,1,1),(68,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',68,1,1,1,1),(69,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',69,1,1,1,1),(70,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',70,1,1,1,1),(71,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',71,1,1,1,1),(72,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',72,1,1,1,1),(73,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',73,1,1,1,1),(74,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',74,1,1,1,1),(75,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',75,1,1,1,1),(76,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',76,1,1,1,1),(77,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',77,1,1,1,1),(78,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',79,1,1,1,1),(79,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',80,1,1,1,1),(80,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',81,1,1,1,1),(81,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',82,1,1,1,1),(82,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',83,1,1,1,1),(83,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',84,1,1,1,1),(84,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',85,1,1,1,1),(85,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',86,1,1,1,1),(86,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',87,1,1,1,1),(87,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',88,1,1,1,1),(88,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',89,1,1,1,1),(89,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',90,1,1,1,1),(90,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',91,1,1,1,1),(91,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',92,1,1,1,1),(92,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',93,1,1,1,1),(93,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',94,1,1,1,1),(94,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',95,1,1,1,1),(95,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',96,1,1,1,1),(96,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',97,1,1,1,1),(97,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',98,1,1,1,1),(98,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',99,1,1,1,1),(99,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',100,1,1,1,1),(100,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',101,1,1,1,1),(101,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',102,1,1,1,1),(102,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',103,1,1,1,1),(103,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',104,1,1,1,1),(104,1,'2019-11-18 03:13:45','2019-11-18 03:13:45',105,1,1,1,1),(105,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',106,1,1,1,1),(106,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',107,1,1,1,1),(107,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',108,1,1,1,1),(108,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',109,1,1,1,1),(109,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',110,1,1,1,1),(110,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',111,1,1,1,1),(111,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',112,1,1,1,1),(112,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',113,1,1,1,1),(113,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',114,1,1,1,1),(114,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',115,1,1,1,1),(115,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',116,1,1,1,1),(116,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',117,1,1,1,1),(117,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',118,1,1,1,1),(118,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',119,1,1,1,1),(119,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',120,1,1,1,1),(120,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',121,1,1,1,1),(121,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',122,1,1,1,1),(122,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',123,1,1,1,1),(123,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',124,1,1,1,1),(124,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',125,1,1,1,1),(125,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',126,1,1,1,1),(126,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',127,1,1,1,1),(127,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',128,1,1,1,1),(128,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',129,1,1,1,1),(129,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',130,1,1,1,1),(130,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',131,1,1,1,1),(131,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',132,1,1,1,1),(132,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',133,1,1,1,1),(133,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',134,1,1,1,1),(134,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',135,1,1,1,1),(135,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',136,1,1,1,1),(136,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',137,1,1,1,1),(137,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',138,1,1,1,1),(138,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',139,1,1,1,1),(139,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',140,1,1,1,1),(140,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',141,1,1,1,1),(141,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',142,1,1,1,1),(142,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',143,1,1,1,1),(143,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',144,1,1,1,1),(144,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',145,1,1,1,1),(145,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',146,1,1,1,1),(146,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',147,1,1,1,1),(147,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',148,1,1,1,1),(148,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',149,1,1,1,1),(149,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',150,1,1,1,1),(150,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',151,1,1,1,1),(151,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',152,1,1,1,1),(152,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',153,1,1,1,1),(153,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',154,1,1,1,1),(154,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',155,1,1,1,1),(155,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',156,1,1,1,1),(156,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',157,1,1,1,1),(157,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',158,1,1,1,1),(158,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',159,1,1,1,1),(159,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',160,1,1,1,1),(160,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',161,1,1,1,1),(161,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',162,1,1,1,1),(162,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',163,1,1,1,1),(163,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',164,1,1,1,1),(164,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',165,1,1,1,1),(165,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',166,1,1,1,1),(166,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',167,1,1,1,1),(167,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',168,1,1,1,1),(168,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',169,1,1,1,1),(169,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',170,1,1,1,1),(170,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',171,1,1,1,1),(171,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',172,1,1,1,1),(172,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',173,1,1,1,1),(173,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',174,1,1,1,1),(174,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',175,1,1,1,1),(175,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',176,1,1,1,1),(176,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',177,1,1,1,1),(177,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',178,1,1,1,1),(178,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',179,1,1,1,1),(179,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',180,1,1,1,1),(180,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',181,1,1,1,1),(181,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',182,1,1,1,1),(182,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',183,1,1,1,1),(183,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',184,1,1,1,1),(184,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',185,1,1,1,1),(185,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',186,1,1,1,1),(186,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',187,1,1,1,1),(187,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',188,1,1,1,1),(188,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',189,1,1,1,1),(189,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',190,1,1,1,1),(190,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',191,1,1,1,1),(191,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',192,1,1,1,1),(192,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',193,1,1,1,1),(193,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',194,1,1,1,1),(194,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',195,1,1,1,1),(195,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',196,1,1,1,1),(196,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',197,1,1,1,1),(197,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',198,1,1,1,1),(198,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',199,1,1,1,1),(199,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',200,1,1,1,1),(200,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',201,1,1,1,1),(201,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',202,1,1,1,1),(202,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',203,1,1,1,1),(203,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',204,1,1,1,1),(204,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',205,1,1,1,1),(205,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',206,1,1,1,1),(206,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',207,1,1,1,1),(207,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',208,1,1,1,1),(208,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',209,1,1,1,1),(209,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',210,1,1,1,1),(210,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',211,1,1,1,1),(211,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',214,1,1,1,1),(212,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',215,1,1,1,1),(213,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',216,1,1,1,1),(214,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',217,1,1,1,1),(215,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',218,1,1,1,1),(216,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',219,1,1,1,1),(217,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',220,1,1,1,1),(218,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',221,1,1,1,1),(219,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',222,1,1,1,1),(220,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',223,1,1,1,1),(221,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',224,1,1,1,1),(222,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',225,1,1,1,1),(223,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',226,1,1,1,1),(224,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',227,1,1,1,1),(225,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',228,1,1,1,1),(226,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',229,1,1,1,1),(227,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',230,1,1,1,1),(228,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',231,1,1,1,1),(229,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',232,1,1,1,1),(230,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',233,1,1,1,1),(231,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',234,1,1,1,1),(232,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',235,1,1,1,1),(233,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',236,1,1,1,1),(234,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',237,1,1,1,1),(235,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',238,1,1,1,1),(236,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',239,1,1,1,1),(237,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',240,1,1,1,1),(238,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',241,1,1,1,1),(239,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',242,1,1,1,1),(240,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',243,1,1,1,1),(241,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',244,1,1,1,1),(242,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',245,1,1,1,1),(243,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',246,1,1,1,1),(244,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',247,1,1,1,1),(245,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',248,1,1,1,1),(246,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',249,1,1,1,1),(247,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',250,1,1,1,1),(248,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',251,1,1,1,1),(249,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',252,1,1,1,1),(250,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',253,1,1,1,1),(251,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',254,1,1,1,1),(252,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',255,1,1,1,1),(253,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',256,1,1,1,1),(254,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',257,1,1,1,1),(255,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',258,1,1,1,1),(256,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',259,1,1,1,1),(257,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',260,1,1,1,1),(258,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',261,1,1,1,1),(259,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',262,1,1,1,1),(260,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',263,1,1,1,1),(261,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',264,1,1,1,1),(262,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',265,1,1,1,1),(263,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',266,1,1,1,1),(264,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',267,1,1,1,1),(265,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',268,1,1,1,1),(266,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',269,1,1,1,1),(267,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',270,1,1,1,1),(268,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',271,1,1,1,1),(269,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',272,1,1,1,1),(270,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',273,1,1,1,1),(271,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',274,1,1,1,1),(272,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',275,1,1,1,1),(273,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',276,1,1,1,1),(274,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',277,1,1,1,1),(275,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',278,1,1,1,1),(276,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',279,1,1,1,1),(277,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',280,1,1,1,1),(278,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',281,1,1,1,1),(279,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',282,1,1,1,1),(280,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',283,1,1,1,1),(281,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',284,1,1,1,1),(282,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',285,1,1,1,1),(283,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',286,1,1,1,1),(284,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',287,1,1,1,1),(285,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',288,1,1,1,1),(286,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',289,1,1,1,1),(287,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',290,1,1,1,1),(288,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',291,1,1,1,1),(289,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',292,1,1,1,1),(290,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',293,1,1,1,1),(291,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',294,1,1,1,1),(292,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',295,1,1,1,1),(293,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',296,1,1,1,1),(294,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',297,1,1,1,1),(295,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',298,1,1,1,1),(296,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',299,1,1,1,1),(297,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',300,1,1,1,1),(298,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',301,1,1,1,1),(299,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',302,1,1,1,1),(300,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',303,1,1,1,1),(301,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',304,1,1,1,1),(302,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',305,1,1,1,1),(303,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',306,1,1,1,1),(304,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',307,1,1,1,1),(305,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',308,1,1,1,1),(306,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',309,1,1,1,1),(307,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',310,1,1,1,1),(308,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',311,1,1,1,1),(309,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',312,1,1,1,1),(310,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',313,1,1,1,1),(311,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',314,1,1,1,1),(312,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',315,1,1,1,1),(313,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',316,1,1,1,1),(314,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',317,1,1,1,1),(315,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',318,1,1,1,1),(316,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',319,1,1,1,1),(317,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',320,1,1,1,1),(318,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',321,1,1,1,1),(319,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',322,1,1,1,1),(320,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',323,1,1,1,1),(321,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',324,1,1,1,1),(322,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',325,1,1,1,1),(323,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',326,1,1,1,1),(324,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',327,1,1,1,1),(325,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',328,1,1,1,1),(326,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',329,1,1,1,1),(327,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',330,1,1,1,1),(328,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',331,1,1,1,1),(329,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',332,1,1,1,1),(330,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',333,1,1,1,1),(331,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',334,1,1,1,1),(332,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',335,1,1,1,1),(333,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',336,1,1,1,1),(334,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',337,1,1,1,1),(335,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',338,1,1,1,1),(336,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',339,1,1,1,1),(337,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',340,1,1,1,1),(338,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',341,1,1,1,1),(339,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',342,1,1,1,1),(340,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',343,1,1,1,1),(341,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',344,1,1,1,1),(342,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',345,1,1,1,1),(343,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',346,1,1,1,1),(344,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',347,1,1,1,1),(345,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',348,1,1,1,1),(346,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',349,1,1,1,1),(347,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',350,1,1,1,1),(348,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',351,1,1,1,1),(349,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',352,1,1,1,1),(350,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',353,1,1,1,1),(351,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',354,1,1,1,1),(352,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',355,1,1,1,1),(353,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',356,1,1,1,1),(354,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',357,1,1,1,1),(355,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',358,1,1,1,1),(356,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',359,1,1,1,1),(357,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',360,1,1,1,1),(358,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',361,1,1,1,1),(359,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',362,1,1,1,1),(360,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',363,1,1,1,1),(361,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',364,1,1,1,1),(362,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',365,1,1,1,1),(363,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',366,1,1,1,1),(364,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',367,1,1,1,1),(365,1,'2019-11-18 03:13:46','2019-11-18 03:13:46',368,1,1,1,1),(366,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',369,1,1,1,1),(367,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',370,1,1,1,1),(368,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',371,1,1,1,1),(369,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',372,1,1,1,1),(370,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',373,1,1,1,1),(371,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',374,1,1,1,1),(372,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',375,1,1,1,1),(373,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',376,1,1,1,1),(374,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',377,1,1,1,1),(375,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',378,1,1,1,1),(376,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',379,1,1,1,1),(377,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',380,1,1,1,1),(378,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',381,1,1,1,1),(379,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',382,1,1,1,1),(380,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',383,1,1,1,1),(381,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',384,1,1,1,1),(382,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',385,1,1,1,1),(383,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',386,1,1,1,1),(384,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',387,1,1,1,1),(385,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',388,1,1,1,1),(386,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',389,1,1,1,1),(387,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',390,1,1,1,1),(388,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',391,1,1,1,1),(389,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',392,1,1,1,1),(390,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',393,1,1,1,1),(391,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',394,1,1,1,1),(392,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',395,1,1,1,1),(393,1,'2019-11-18 03:13:47','2019-11-18 03:13:47',396,1,1,1,1),(787,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',1,5,1,1,1),(788,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',2,5,1,1,1),(789,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',3,5,1,1,1),(790,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',4,5,1,1,1),(791,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',5,5,1,1,1),(792,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',6,5,1,1,1),(793,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',7,5,1,1,1),(794,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',8,5,1,1,1),(795,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',9,5,1,1,1),(796,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',10,5,1,1,1),(797,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',11,5,1,1,1),(798,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',12,5,1,1,1),(799,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',13,5,1,1,1),(800,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',14,5,1,1,1),(801,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',15,5,1,1,1),(802,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',16,5,1,1,1),(803,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',17,5,1,1,1),(804,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',18,5,1,1,1),(805,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',19,5,1,1,1),(806,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',20,5,1,1,1),(807,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',21,5,1,1,1),(808,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',22,5,1,1,1),(809,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',23,5,1,1,1),(810,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',24,5,1,1,1),(811,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',25,5,1,1,1),(812,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',26,5,1,1,1),(813,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',27,5,1,1,1),(814,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',28,5,1,1,1),(815,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',29,5,1,1,1),(816,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',30,5,1,1,1),(817,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',31,5,1,1,1),(818,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',32,5,1,1,1),(819,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',33,5,1,1,1),(820,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',34,5,1,1,1),(821,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',35,5,1,1,1),(822,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',36,5,1,1,1),(823,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',37,5,1,1,1),(824,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',38,5,1,1,1),(825,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',39,5,1,1,1),(826,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',40,5,1,1,1),(827,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',41,5,1,1,1),(828,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',42,5,1,1,1),(829,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',43,5,1,1,1),(830,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',44,5,1,1,1),(831,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',45,5,1,1,1),(832,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',46,5,1,1,1),(833,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',47,5,1,1,1),(834,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',48,5,1,1,1),(835,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',49,5,1,1,1),(836,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',50,5,1,1,1),(837,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',51,5,1,1,1),(838,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',52,5,1,1,1),(839,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',53,5,1,1,1),(840,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',54,5,1,1,1),(841,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',55,5,1,1,1),(842,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',56,5,1,1,1),(843,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',57,5,1,1,1),(844,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',58,5,1,1,1),(845,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',59,5,1,1,1),(846,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',60,5,1,1,1),(847,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',61,5,1,1,1),(848,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',62,5,1,1,1),(849,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',63,5,1,1,1),(850,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',64,5,1,1,1),(851,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',65,5,1,1,1),(852,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',66,5,1,1,1),(853,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',67,5,1,1,1),(854,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',68,5,1,1,1),(855,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',69,5,1,1,1),(856,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',70,5,1,1,1),(857,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',71,5,1,1,1),(858,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',72,5,1,1,1),(859,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',73,5,1,1,1),(860,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',74,5,1,1,1),(861,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',75,5,1,1,1),(862,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',76,5,1,1,1),(863,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',77,5,1,1,1),(864,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',79,5,1,1,1),(865,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',80,5,1,1,1),(866,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',81,5,1,1,1),(867,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',82,5,1,1,1),(868,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',83,5,1,1,1),(869,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',84,5,1,1,1),(870,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',85,5,1,1,1),(871,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',86,5,1,1,1),(872,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',87,5,1,1,1),(873,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',88,5,1,1,1),(874,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',89,5,1,1,1),(875,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',90,5,1,1,1),(876,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',91,5,1,1,1),(877,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',92,5,1,1,1),(878,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',93,5,1,1,1),(879,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',94,5,1,1,1),(880,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',95,5,1,1,1),(881,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',96,5,1,1,1),(882,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',97,5,1,1,1),(883,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',98,5,1,1,1),(884,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',99,5,1,1,1),(885,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',100,5,1,1,1),(886,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',101,5,1,1,1),(887,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',102,5,1,1,1),(888,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',103,5,1,1,1),(889,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',104,5,1,1,1),(890,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',105,5,1,1,1),(891,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',106,5,1,1,1),(892,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',107,5,1,1,1),(893,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',108,5,1,1,1),(894,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',109,5,1,1,1),(895,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',110,5,1,1,1),(896,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',111,5,1,1,1),(897,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',112,5,1,1,1),(898,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',113,5,1,1,1),(899,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',114,5,1,1,1),(900,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',115,5,1,1,1),(901,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',116,5,1,1,1),(902,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',117,5,1,1,1),(903,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',118,5,1,1,1),(904,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',119,5,1,1,1),(905,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',120,5,1,1,1),(906,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',121,5,1,1,1),(907,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',122,5,1,1,1),(908,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',123,5,1,1,1),(909,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',124,5,1,1,1),(910,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',125,5,1,1,1),(911,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',126,5,1,1,1),(912,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',127,5,1,1,1),(913,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',128,5,1,1,1),(914,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',129,5,1,1,1),(915,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',130,5,1,1,1),(916,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',131,5,1,1,1),(917,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',132,5,1,1,1),(918,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',133,5,1,1,1),(919,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',134,5,1,1,1),(920,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',135,5,1,1,1),(921,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',136,5,1,1,1),(922,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',137,5,1,1,1),(923,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',138,5,1,1,1),(924,1,'2019-11-18 03:13:48','2019-11-18 03:13:48',139,5,1,1,1),(925,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',140,5,1,1,1),(926,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',141,5,1,1,1),(927,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',142,5,1,1,1),(928,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',143,5,1,1,1),(929,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',144,5,1,1,1),(930,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',145,5,1,1,1),(931,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',146,5,1,1,1),(932,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',147,5,1,1,1),(933,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',148,5,1,1,1),(934,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',149,5,1,1,1),(935,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',150,5,1,1,1),(936,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',151,5,1,1,1),(937,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',152,5,1,1,1),(938,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',153,5,1,1,1),(939,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',154,5,1,1,1),(940,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',155,5,1,1,1),(941,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',156,5,1,1,1),(942,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',157,5,1,1,1),(943,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',158,5,1,1,1),(944,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',159,5,1,1,1),(945,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',160,5,1,1,1),(946,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',161,5,1,1,1),(947,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',162,5,1,1,1),(948,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',163,5,1,1,1),(949,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',164,5,1,1,1),(950,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',165,5,1,1,1),(951,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',166,5,1,1,1),(952,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',167,5,1,1,1),(953,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',168,5,1,1,1),(954,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',169,5,1,1,1),(955,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',170,5,1,1,1),(956,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',171,5,1,1,1),(957,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',172,5,1,1,1),(958,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',173,5,1,1,1),(959,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',174,5,1,1,1),(960,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',175,5,1,1,1),(961,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',176,5,1,1,1),(962,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',177,5,1,1,1),(963,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',178,5,1,1,1),(964,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',179,5,1,1,1),(965,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',180,5,1,1,1),(966,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',181,5,1,1,1),(967,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',182,5,1,1,1),(968,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',183,5,1,1,1),(969,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',184,5,1,1,1),(970,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',185,5,1,1,1),(971,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',186,5,1,1,1),(972,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',187,5,1,1,1),(973,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',188,5,1,1,1),(974,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',189,5,1,1,1),(975,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',190,5,1,1,1),(976,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',191,5,1,1,1),(977,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',192,5,1,1,1),(978,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',193,5,1,1,1),(979,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',194,5,1,1,1),(980,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',195,5,1,1,1),(981,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',196,5,1,1,1),(982,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',197,5,1,1,1),(983,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',198,5,1,1,1),(984,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',199,5,1,1,1),(985,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',200,5,1,1,1),(986,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',201,5,1,1,1),(987,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',202,5,1,1,1),(988,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',203,5,1,1,1),(989,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',204,5,1,1,1),(990,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',205,5,1,1,1),(991,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',206,5,1,1,1),(992,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',207,5,1,1,1),(993,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',208,5,1,1,1),(994,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',209,5,1,1,1),(995,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',210,5,1,1,1),(996,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',211,5,1,1,1),(997,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',214,5,1,1,1),(998,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',215,5,1,1,1),(999,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',216,5,1,1,1),(1000,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',217,5,1,1,1),(1001,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',218,5,1,1,1),(1002,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',219,5,1,1,1),(1003,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',220,5,1,1,1),(1004,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',221,5,1,1,1),(1005,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',222,5,1,1,1),(1006,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',223,5,1,1,1),(1007,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',224,5,1,1,1),(1008,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',225,5,1,1,1),(1009,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',226,5,1,1,1),(1010,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',227,5,1,1,1),(1011,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',228,5,1,1,1),(1012,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',229,5,1,1,1),(1013,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',230,5,1,1,1),(1014,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',231,5,1,1,1),(1015,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',232,5,1,1,1),(1016,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',233,5,1,1,1),(1017,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',234,5,1,1,1),(1018,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',235,5,1,1,1),(1019,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',236,5,1,1,1),(1020,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',237,5,1,1,1),(1021,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',238,5,1,1,1),(1022,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',239,5,1,1,1),(1023,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',240,5,1,1,1),(1024,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',241,5,1,1,1),(1025,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',242,5,1,1,1),(1026,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',243,5,1,1,1),(1027,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',244,5,1,1,1),(1028,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',245,5,1,1,1),(1029,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',246,5,1,1,1),(1030,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',247,5,1,1,1),(1031,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',248,5,1,1,1),(1032,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',249,5,1,1,1),(1033,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',250,5,1,1,1),(1034,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',251,5,1,1,1),(1035,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',252,5,1,1,1),(1036,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',253,5,1,1,1),(1037,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',254,5,1,1,1),(1038,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',255,5,1,1,1),(1039,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',256,5,1,1,1),(1040,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',257,5,1,1,1),(1041,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',258,5,1,1,1),(1042,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',259,5,1,1,1),(1043,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',260,5,1,1,1),(1044,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',261,5,1,1,1),(1045,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',262,5,1,1,1),(1046,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',263,5,1,1,1),(1047,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',264,5,1,1,1),(1048,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',265,5,1,1,1),(1049,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',266,5,1,1,1),(1050,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',267,5,1,1,1),(1051,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',268,5,1,1,1),(1052,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',269,5,1,1,1),(1053,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',270,5,1,1,1),(1054,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',271,5,1,1,1),(1055,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',272,5,1,1,1),(1056,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',273,5,1,1,1),(1057,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',274,5,1,1,1),(1058,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',275,5,1,1,1),(1059,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',276,5,1,1,1),(1060,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',277,5,1,1,1),(1061,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',278,5,1,1,1),(1062,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',279,5,1,1,1),(1063,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',280,5,1,1,1),(1064,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',281,5,1,1,1),(1065,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',282,5,1,1,1),(1066,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',283,5,1,1,1),(1067,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',284,5,1,1,1),(1068,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',285,5,1,1,1),(1069,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',286,5,1,1,1),(1070,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',287,5,1,1,1),(1071,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',288,5,1,1,1),(1072,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',289,5,1,1,1),(1073,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',290,5,1,1,1),(1074,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',291,5,1,1,1),(1075,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',292,5,1,1,1),(1076,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',293,5,1,1,1),(1077,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',294,5,1,1,1),(1078,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',295,5,1,1,1),(1079,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',296,5,1,1,1),(1080,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',297,5,1,1,1),(1081,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',298,5,1,1,1),(1082,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',299,5,1,1,1),(1083,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',300,5,1,1,1),(1084,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',301,5,1,1,1),(1085,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',302,5,1,1,1),(1086,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',303,5,1,1,1),(1087,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',304,5,1,1,1),(1088,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',305,5,1,1,1),(1089,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',306,5,1,1,1),(1090,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',307,5,1,1,1),(1091,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',308,5,1,1,1),(1092,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',309,5,1,1,1),(1093,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',310,5,1,1,1),(1094,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',311,5,1,1,1),(1095,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',312,5,1,1,1),(1096,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',313,5,1,1,1),(1097,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',314,5,1,1,1),(1098,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',315,5,1,1,1),(1099,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',316,5,1,1,1),(1100,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',317,5,1,1,1),(1101,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',318,5,1,1,1),(1102,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',319,5,1,1,1),(1103,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',320,5,1,1,1),(1104,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',321,5,1,1,1),(1105,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',322,5,1,1,1),(1106,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',323,5,1,1,1),(1107,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',324,5,1,1,1),(1108,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',325,5,1,1,1),(1109,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',326,5,1,1,1),(1110,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',327,5,1,1,1),(1111,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',328,5,1,1,1),(1112,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',329,5,1,1,1),(1113,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',330,5,1,1,1),(1114,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',331,5,1,1,1),(1115,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',332,5,1,1,1),(1116,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',333,5,1,1,1),(1117,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',334,5,1,1,1),(1118,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',335,5,1,1,1),(1119,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',336,5,1,1,1),(1120,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',337,5,1,1,1),(1121,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',338,5,1,1,1),(1122,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',339,5,1,1,1),(1123,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',340,5,1,1,1),(1124,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',341,5,1,1,1),(1125,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',342,5,1,1,1),(1126,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',343,5,1,1,1),(1127,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',344,5,1,1,1),(1128,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',345,5,1,1,1),(1129,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',346,5,1,1,1),(1130,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',347,5,1,1,1),(1131,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',348,5,1,1,1),(1132,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',349,5,1,1,1),(1133,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',350,5,1,1,1),(1134,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',351,5,1,1,1),(1135,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',352,5,1,1,1),(1136,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',353,5,1,1,1),(1137,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',354,5,1,1,1),(1138,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',355,5,1,1,1),(1139,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',356,5,1,1,1),(1140,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',357,5,1,1,1),(1141,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',358,5,1,1,1),(1142,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',359,5,1,1,1),(1143,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',360,5,1,1,1),(1144,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',361,5,1,1,1),(1145,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',362,5,1,1,1),(1146,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',363,5,1,1,1),(1147,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',364,5,1,1,1),(1148,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',365,5,1,1,1),(1149,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',366,5,1,1,1),(1150,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',367,5,1,1,1),(1151,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',368,5,1,1,1),(1152,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',369,5,1,1,1),(1153,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',370,5,1,1,1),(1154,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',371,5,1,1,1),(1155,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',372,5,1,1,1),(1156,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',373,5,1,1,1),(1157,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',374,5,1,1,1),(1158,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',375,5,1,1,1),(1159,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',376,5,1,1,1),(1160,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',377,5,1,1,1),(1161,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',378,5,1,1,1),(1162,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',379,5,1,1,1),(1163,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',380,5,1,1,1),(1164,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',381,5,1,1,1),(1165,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',382,5,1,1,1),(1166,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',383,5,1,1,1),(1167,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',384,5,1,1,1),(1168,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',385,5,1,1,1),(1169,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',386,5,1,1,1),(1170,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',387,5,1,1,1),(1171,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',388,5,1,1,1),(1172,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',389,5,1,1,1),(1173,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',390,5,1,1,1),(1174,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',391,5,1,1,1),(1175,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',392,5,1,1,1),(1176,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',393,5,1,1,1),(1177,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',394,5,1,1,1),(1178,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',395,5,1,1,1),(1179,1,'2019-11-18 03:13:49','2019-11-18 03:13:49',396,5,1,1,1),(7213,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',1,4,1,1,1),(7214,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',2,4,1,1,1),(7215,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',3,4,1,1,1),(7216,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',4,4,1,1,1),(7217,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',5,4,1,1,1),(7218,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',6,4,1,1,1),(7219,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',7,4,1,1,1),(7220,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',8,4,1,1,1),(7221,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',9,4,1,1,1),(7222,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',10,4,1,1,1),(7223,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',61,4,1,1,1),(7224,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',62,4,1,1,1),(7225,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',63,4,1,1,1),(7226,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',64,4,1,1,1),(7227,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',65,4,1,1,1),(7228,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',66,4,1,1,1),(7229,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',67,4,1,1,1),(7230,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',68,4,1,1,1),(7231,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',69,4,1,1,1),(7232,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',70,4,1,1,1),(7233,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',71,4,1,1,1),(7234,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',72,4,1,1,1),(7235,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',73,4,1,1,1),(7236,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',74,4,1,1,1),(7237,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',75,4,1,1,1),(7238,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',76,4,1,1,1),(7239,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',77,4,1,1,1),(7240,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',79,4,1,1,1),(7241,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',80,4,1,1,1),(7242,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',81,4,1,1,1),(7243,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',82,4,1,1,1),(7244,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',83,4,1,1,1),(7245,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',84,4,1,1,1),(7246,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',85,4,1,1,1),(7247,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',86,4,1,1,1),(7248,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',87,4,1,1,1),(7249,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',88,4,1,1,1),(7250,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',89,4,1,1,1),(7251,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',90,4,1,1,1),(7252,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',91,4,1,1,1),(7253,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',92,4,1,1,1),(7254,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',93,4,1,1,1),(7255,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',94,4,1,1,1),(7256,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',95,4,1,1,1),(7257,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',96,4,1,1,1),(7258,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',97,4,1,1,1),(7259,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',98,4,1,1,1),(7260,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',99,4,1,1,1),(7261,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',100,4,1,1,1),(7262,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',101,4,1,1,1),(7263,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',102,4,1,1,1),(7264,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',103,4,1,1,1),(7265,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',104,4,1,1,1),(7266,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',105,4,1,1,1),(7267,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',106,4,1,1,1),(7268,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',107,4,1,1,1),(7269,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',188,4,1,1,1),(7270,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',193,4,1,1,1),(7271,1,'2019-12-03 06:27:28','2019-12-03 06:27:28',194,4,1,1,1),(7272,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',195,4,1,1,1),(7273,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',196,4,1,1,1),(7274,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',197,4,1,1,1),(7275,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',198,4,1,1,1),(7276,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',207,4,1,1,1),(7277,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',208,4,1,1,1),(7278,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',209,4,1,1,1),(7279,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',210,4,1,1,1),(7280,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',211,4,1,1,1),(7281,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',214,4,1,1,1),(7282,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',215,4,1,1,1),(7283,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',216,4,1,1,1),(7284,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',217,4,1,1,1),(7285,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',218,4,1,1,1),(7286,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',219,4,1,1,1),(7287,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',220,4,1,1,1),(7288,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',221,4,1,1,1),(7289,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',222,4,1,1,1),(7290,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',223,4,1,1,1),(7291,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',224,4,1,1,1),(7292,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',225,4,1,1,1),(7293,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',226,4,1,1,1),(7294,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',227,4,1,1,1),(7295,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',228,4,1,1,1),(7296,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',229,4,1,1,1),(7297,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',230,4,1,1,1),(7298,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',231,4,1,1,1),(7299,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',232,4,1,1,1),(7300,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',233,4,1,1,1),(7301,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',234,4,1,1,1),(7302,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',235,4,1,1,1),(7303,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',236,4,1,1,1),(7304,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',237,4,1,1,1),(7305,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',238,4,1,1,1),(7306,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',239,4,1,1,1),(7307,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',240,4,1,1,1),(7308,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',241,4,1,1,1),(7309,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',242,4,1,1,1),(7310,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',243,4,1,1,1),(7311,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',244,4,1,1,1),(7312,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',245,4,1,1,1),(7313,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',246,4,1,1,1),(7314,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',247,4,1,1,1),(7315,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',248,4,1,1,1),(7316,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',249,4,1,1,1),(7317,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',250,4,1,1,1),(7318,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',251,4,1,1,1),(7319,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',252,4,1,1,1),(7320,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',253,4,1,1,1),(7321,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',254,4,1,1,1),(7322,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',255,4,1,1,1),(7323,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',256,4,1,1,1),(7324,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',257,4,1,1,1),(7325,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',258,4,1,1,1),(7326,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',259,4,1,1,1),(7327,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',260,4,1,1,1),(7328,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',261,4,1,1,1),(7329,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',262,4,1,1,1),(7330,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',263,4,1,1,1),(7331,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',264,4,1,1,1),(7332,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',265,4,1,1,1),(7333,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',266,4,1,1,1),(7334,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',267,4,1,1,1),(7335,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',268,4,1,1,1),(7336,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',269,4,1,1,1),(7337,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',270,4,1,1,1),(7338,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',271,4,1,1,1),(7339,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',272,4,1,1,1),(7340,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',273,4,1,1,1),(7341,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',274,4,1,1,1),(7342,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',275,4,1,1,1),(7343,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',276,4,1,1,1),(7344,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',277,4,1,1,1),(7345,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',278,4,1,1,1),(7346,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',279,4,1,1,1),(7347,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',280,4,1,1,1),(7348,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',281,4,1,1,1),(7349,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',282,4,1,1,1),(7350,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',283,4,1,1,1),(7351,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',284,4,1,1,1),(7352,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',285,4,1,1,1),(7353,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',385,4,1,1,1),(7354,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',386,4,1,1,1),(7355,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',387,4,1,1,1),(7356,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',388,4,1,1,1),(7357,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',391,4,1,1,1),(7358,1,'2019-12-03 06:27:29','2019-12-03 06:27:29',392,4,1,1,1),(7359,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',1,6,1,1,1),(7360,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',2,6,1,1,1),(7361,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',3,6,1,1,1),(7362,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',4,6,1,1,1),(7363,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',5,6,1,1,1),(7364,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',6,6,1,1,1),(7365,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',7,6,1,1,1),(7366,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',8,6,1,1,1),(7367,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',9,6,1,1,1),(7368,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',10,6,1,1,1),(7369,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',61,6,1,1,1),(7370,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',64,6,1,1,1),(7371,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',108,6,1,1,1),(7372,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',109,6,1,1,1),(7373,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',110,6,1,1,1),(7374,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',111,6,1,1,1),(7375,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',112,6,1,1,1),(7376,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',113,6,1,1,1),(7377,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',114,6,1,1,1),(7378,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',115,6,1,1,1),(7379,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',116,6,1,1,1),(7380,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',117,6,1,1,1),(7381,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',118,6,1,1,1),(7382,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',119,6,1,1,1),(7383,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',120,6,1,1,1),(7384,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',121,6,1,1,1),(7385,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',122,6,1,1,1),(7386,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',123,6,1,1,1),(7387,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',124,6,1,1,1),(7388,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',125,6,1,1,1),(7389,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',126,6,1,1,1),(7390,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',127,6,1,1,1),(7391,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',128,6,1,1,1),(7392,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',129,6,1,1,1),(7393,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',130,6,1,1,1),(7394,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',131,6,1,1,1),(7395,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',132,6,1,1,1),(7396,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',133,6,1,1,1),(7397,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',134,6,1,1,1),(7398,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',135,6,1,1,1),(7399,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',136,6,1,1,1),(7400,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',137,6,1,1,1),(7401,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',138,6,1,1,1),(7402,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',139,6,1,1,1),(7403,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',140,6,1,1,1),(7404,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',141,6,1,1,1),(7405,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',142,6,1,1,1),(7406,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',143,6,1,1,1),(7407,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',144,6,1,1,1),(7408,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',145,6,1,1,1),(7409,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',146,6,1,1,1),(7410,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',147,6,1,1,1),(7411,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',148,6,1,1,1),(7412,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',149,6,1,1,1),(7413,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',150,6,1,1,1),(7414,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',151,6,1,1,1),(7415,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',152,6,1,1,1),(7416,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',153,6,1,1,1),(7417,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',154,6,1,1,1),(7418,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',155,6,1,1,1),(7419,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',156,6,1,1,1),(7420,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',157,6,1,1,1),(7421,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',158,6,1,1,1),(7422,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',159,6,1,1,1),(7423,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',160,6,1,1,1),(7424,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',161,6,1,1,1),(7425,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',310,6,1,1,1),(7426,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',315,6,1,1,1),(7427,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',316,6,1,1,1),(7428,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',317,6,1,1,1),(7429,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',318,6,1,1,1),(7430,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',319,6,1,1,1),(7431,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',320,6,1,1,1),(7432,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',321,6,1,1,1),(7433,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',322,6,1,1,1),(7434,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',323,6,1,1,1),(7435,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',324,6,1,1,1),(7436,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',325,6,1,1,1),(7437,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',326,6,1,1,1),(7438,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',327,6,1,1,1),(7439,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',328,6,1,1,1),(7440,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',329,6,1,1,1),(7441,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',330,6,1,1,1),(7442,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',331,6,1,1,1),(7443,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',332,6,1,1,1),(7444,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',333,6,1,1,1),(7445,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',334,6,1,1,1),(7446,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',335,6,1,1,1),(7447,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',336,6,1,1,1),(7448,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',337,6,1,1,1),(7449,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',338,6,1,1,1),(7450,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',339,6,1,1,1),(7451,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',340,6,1,1,1),(7452,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',341,6,1,1,1),(7453,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',342,6,1,1,1),(7454,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',343,6,1,1,1),(7455,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',344,6,1,1,1),(7456,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',345,6,1,1,1),(7457,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',346,6,1,1,1),(7458,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',347,6,1,1,1),(7459,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',381,6,1,1,1),(7460,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',382,6,1,1,1),(7461,1,'2019-12-03 06:33:41','2019-12-03 06:33:41',393,6,1,1,1),(7574,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',1,8,1,1,1),(7575,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',2,8,1,1,1),(7576,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',3,8,1,1,1),(7577,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',4,8,1,1,1),(7578,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',5,8,1,1,1),(7579,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',6,8,1,1,1),(7580,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',7,8,1,1,1),(7581,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',8,8,1,1,1),(7582,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',9,8,1,1,1),(7583,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',10,8,1,1,1),(7584,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',54,8,1,1,1),(7585,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',61,8,1,1,1),(7586,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',64,8,1,1,1),(7587,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',160,8,1,1,1),(7588,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',161,8,1,1,1),(7589,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',286,8,1,1,1),(7590,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',287,8,1,1,1),(7591,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',288,8,1,1,1),(7592,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',289,8,1,1,1),(7593,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',290,8,1,1,1),(7594,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',291,8,1,1,1),(7595,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',292,8,1,1,1),(7596,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',293,8,1,1,1),(7597,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',294,8,1,1,1),(7598,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',295,8,1,1,1),(7599,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',296,8,1,1,1),(7600,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',297,8,1,1,1),(7601,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',298,8,1,1,1),(7602,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',299,8,1,1,1),(7603,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',300,8,1,1,1),(7604,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',301,8,1,1,1),(7605,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',302,8,1,1,1),(7606,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',303,8,1,1,1),(7607,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',304,8,1,1,1),(7608,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',305,8,1,1,1),(7609,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',306,8,1,1,1),(7610,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',307,8,1,1,1),(7611,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',308,8,1,1,1),(7612,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',309,8,1,1,1),(7613,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',310,8,1,1,1),(7614,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',311,8,1,1,1),(7615,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',312,8,1,1,1),(7616,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',313,8,1,1,1),(7617,1,'2019-12-03 06:42:20','2019-12-03 06:42:20',314,8,1,1,1),(7618,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',1,7,1,1,1),(7619,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',2,7,1,1,1),(7620,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',3,7,1,1,1),(7621,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',4,7,1,1,1),(7622,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',5,7,1,1,1),(7623,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',6,7,1,1,1),(7624,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',7,7,1,1,1),(7625,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',8,7,1,1,1),(7626,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',9,7,1,1,1),(7627,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',10,7,1,1,1),(7628,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',11,7,1,1,1),(7629,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',12,7,1,1,1),(7630,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',13,7,1,1,1),(7631,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',14,7,1,1,1),(7632,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',15,7,1,1,1),(7633,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',16,7,1,1,1),(7634,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',17,7,1,1,1),(7635,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',18,7,1,1,1),(7636,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',19,7,1,1,1),(7637,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',20,7,1,1,1),(7638,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',21,7,1,1,1),(7639,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',22,7,1,1,1),(7640,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',23,7,1,1,1),(7641,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',24,7,1,1,1),(7642,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',25,7,1,1,1),(7643,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',26,7,1,1,1),(7644,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',27,7,1,1,1),(7645,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',28,7,1,1,1),(7646,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',29,7,1,1,1),(7647,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',30,7,1,1,1),(7648,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',31,7,1,1,1),(7649,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',32,7,1,1,1),(7650,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',33,7,1,1,1),(7651,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',34,7,1,1,1),(7652,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',35,7,1,1,1),(7653,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',36,7,1,1,1),(7654,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',37,7,1,1,1),(7655,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',38,7,1,1,1),(7656,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',39,7,1,1,1),(7657,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',40,7,1,1,1),(7658,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',61,7,1,1,1),(7659,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',64,7,1,1,1),(7660,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',160,7,1,1,1),(7661,1,'2019-12-03 06:48:21','2019-12-03 06:48:21',161,7,1,1,1);
/*!40000 ALTER TABLE `sm_role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_room_lists`
--

DROP TABLE IF EXISTS `sm_room_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_room_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_bed` int(11) NOT NULL,
  `cost_per_bed` double(16,2) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `dormitory_id` int(10) unsigned DEFAULT '1',
  `room_type_id` int(10) unsigned DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_room_lists_dormitory_id_foreign` (`dormitory_id`),
  KEY `sm_room_lists_room_type_id_foreign` (`room_type_id`),
  KEY `sm_room_lists_school_id_foreign` (`school_id`),
  KEY `sm_room_lists_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_room_lists_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_room_lists_dormitory_id_foreign` FOREIGN KEY (`dormitory_id`) REFERENCES `sm_dormitory_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_room_lists_room_type_id_foreign` FOREIGN KEY (`room_type_id`) REFERENCES `sm_room_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_room_lists_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_room_lists`
--

LOCK TABLES `sm_room_lists` WRITE;
/*!40000 ALTER TABLE `sm_room_lists` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_room_lists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_room_types`
--

DROP TABLE IF EXISTS `sm_room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_room_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_room_types_school_id_foreign` (`school_id`),
  KEY `sm_room_types_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_room_types_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_room_types_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_room_types`
--

LOCK TABLES `sm_room_types` WRITE;
/*!40000 ALTER TABLE `sm_room_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_routes`
--

DROP TABLE IF EXISTS `sm_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_routes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `far` double(10,2) NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_routes_school_id_foreign` (`school_id`),
  KEY `sm_routes_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_routes_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_routes_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_routes`
--

LOCK TABLES `sm_routes` WRITE;
/*!40000 ALTER TABLE `sm_routes` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_schools`
--

DROP TABLE IF EXISTS `sm_schools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_schools` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `school_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` tinyint(4) NOT NULL DEFAULT '1',
  `updated_by` tinyint(4) NOT NULL DEFAULT '1',
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_code` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `starting_date` date DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `package_id` int(11) DEFAULT NULL,
  `plan_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_type` enum('yearly','monthly','once') COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 approved, 0 pending',
  `is_enabled` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'yes' COMMENT 'yes=Login enable, no=Login disable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_schools`
--

LOCK TABLES `sm_schools` WRITE;
/*!40000 ALTER TABLE `sm_schools` DISABLE KEYS */;
INSERT INTO `sm_schools` VALUES (1,'Cambridgeic',1,1,'t.rakhmonov97@gmail.com',NULL,NULL,NULL,0,'2020-08-10',NULL,NULL,NULL,'yearly',1,'yes',NULL,'2020-08-10 05:58:22');
/*!40000 ALTER TABLE `sm_schools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_seat_plan_children`
--

DROP TABLE IF EXISTS `sm_seat_plan_children`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_seat_plan_children` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` tinyint(4) DEFAULT NULL,
  `assign_students` int(11) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `seat_plan_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_seat_plan_children_seat_plan_id_foreign` (`seat_plan_id`),
  KEY `sm_seat_plan_children_school_id_foreign` (`school_id`),
  KEY `sm_seat_plan_children_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_seat_plan_children_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plan_children_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plan_children_seat_plan_id_foreign` FOREIGN KEY (`seat_plan_id`) REFERENCES `sm_seat_plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_seat_plan_children`
--

LOCK TABLES `sm_seat_plan_children` WRITE;
/*!40000 ALTER TABLE `sm_seat_plan_children` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_seat_plan_children` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_seat_plans`
--

DROP TABLE IF EXISTS `sm_seat_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_seat_plans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_seat_plans_exam_id_foreign` (`exam_id`),
  KEY `sm_seat_plans_subject_id_foreign` (`subject_id`),
  KEY `sm_seat_plans_class_id_foreign` (`class_id`),
  KEY `sm_seat_plans_section_id_foreign` (`section_id`),
  KEY `sm_seat_plans_school_id_foreign` (`school_id`),
  KEY `sm_seat_plans_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_seat_plans_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plans_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plans_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plans_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plans_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_seat_plans_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_seat_plans`
--

LOCK TABLES `sm_seat_plans` WRITE;
/*!40000 ALTER TABLE `sm_seat_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_seat_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_sections`
--

DROP TABLE IF EXISTS `sm_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_sections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `section_name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_sections_school_id_foreign` (`school_id`),
  KEY `sm_sections_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_sections_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_sections_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_sections`
--

LOCK TABLES `sm_sections` WRITE;
/*!40000 ALTER TABLE `sm_sections` DISABLE KEYS */;
INSERT INTO `sm_sections` VALUES (1,'Information Technology Program',1,'2021-01-01 00:00:00','2021-01-01 00:00:00',1,1,1,1),(2,'Level 3 International Foundation',1,'2021-01-01 00:00:00','2021-01-01 00:00:00',1,1,1,1);
/*!40000 ALTER TABLE `sm_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_send_messages`
--

DROP TABLE IF EXISTS `sm_send_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_send_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message_des` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notice_date` date DEFAULT NULL,
  `publish_on` date DEFAULT NULL,
  `message_to` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'message sent to these roles',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_send_messages_school_id_foreign` (`school_id`),
  KEY `sm_send_messages_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_send_messages_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_send_messages_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_send_messages`
--

LOCK TABLES `sm_send_messages` WRITE;
/*!40000 ALTER TABLE `sm_send_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_send_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_sessions`
--

DROP TABLE IF EXISTS `sm_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_sessions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `session` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_sessions_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_sessions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_sessions`
--

LOCK TABLES `sm_sessions` WRITE;
/*!40000 ALTER TABLE `sm_sessions` DISABLE KEYS */;
INSERT INTO `sm_sessions` VALUES (1,'2020-2021',1,'2020-08-10 05:58:15','2020-08-10 05:58:15',1,1,1);
/*!40000 ALTER TABLE `sm_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_setup_admins`
--

DROP TABLE IF EXISTS `sm_setup_admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_setup_admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) DEFAULT NULL COMMENT '1 purpose, 2 complaint type, 3 source, 4 Reference',
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_setup_admins_school_id_foreign` (`school_id`),
  KEY `sm_setup_admins_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_setup_admins_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_setup_admins_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_setup_admins`
--

LOCK TABLES `sm_setup_admins` WRITE;
/*!40000 ALTER TABLE `sm_setup_admins` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_setup_admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_sms_gateways`
--

DROP TABLE IF EXISTS `sm_sms_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_sms_gateways` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `gateway_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clickatell_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clickatell_password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clickatell_api_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twilio_account_sid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twilio_authentication_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twilio_registered_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_authentication_key_sid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_sender_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg91_country_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `textlocal_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `textlocal_hash` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `textlocal_sender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `africatalking_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `africatalking_api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_sms_gateways_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_sms_gateways_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_sms_gateways`
--

LOCK TABLES `sm_sms_gateways` WRITE;
/*!40000 ALTER TABLE `sm_sms_gateways` DISABLE KEYS */;
INSERT INTO `sm_sms_gateways` VALUES (1,'Twilio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2020-08-10 05:58:18','2020-08-10 05:58:18',1,1,1),(2,'Msg91',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-08-10 05:58:18','2020-09-06 17:08:00',1,1,1),(3,'TextLocal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'TXTLCL',NULL,NULL,0,'2020-08-10 05:58:18','2020-08-10 05:58:18',1,1,1),(4,'AfricaTalking',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'sandbox',NULL,0,'2020-08-10 05:58:18','2020-09-06 17:07:59',1,1,1);
/*!40000 ALTER TABLE `sm_sms_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_social_media_icons`
--

DROP TABLE IF EXISTS `sm_social_media_icons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_social_media_icons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1 active, 0 inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_social_media_icons_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_social_media_icons_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_social_media_icons`
--

LOCK TABLES `sm_social_media_icons` WRITE;
/*!40000 ALTER TABLE `sm_social_media_icons` DISABLE KEYS */;
INSERT INTO `sm_social_media_icons` VALUES (1,'https://www.facebook.com/Spondonit/?epa=SEARCH_BOX','fa fa-facebook',1,NULL,NULL,1,1,1),(2,'https://www.facebook.com/Spondonit/?epa=SEARCH_BOX','fa fa-twitter',1,NULL,NULL,1,1,1),(3,'https://www.facebook.com/Spondonit/?epa=SEARCH_BOX','fa fa-dribbble',1,NULL,NULL,1,1,1),(4,'https://www.facebook.com/Spondonit/?epa=SEARCH_BOX','fa fa-linkedin',1,NULL,NULL,1,1,1);
/*!40000 ALTER TABLE `sm_social_media_icons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_staff_attendance_imports`
--

DROP TABLE IF EXISTS `sm_staff_attendance_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_staff_attendance_imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendence_date` date DEFAULT NULL,
  `in_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Present: P Late: L Absent: A Holiday: H Half Day: F',
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_staff_attendance_imports_staff_id_foreign` (`staff_id`),
  KEY `sm_staff_attendance_imports_school_id_foreign` (`school_id`),
  KEY `sm_staff_attendance_imports_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_staff_attendance_imports_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staff_attendance_imports_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staff_attendance_imports_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_staff_attendance_imports`
--

LOCK TABLES `sm_staff_attendance_imports` WRITE;
/*!40000 ALTER TABLE `sm_staff_attendance_imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_staff_attendance_imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_staff_attendences`
--

DROP TABLE IF EXISTS `sm_staff_attendences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_staff_attendences` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendence_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Present: P Late: L Absent: A Holiday: H Half Day: F',
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendence_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `staff_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_staff_attendences_staff_id_foreign` (`staff_id`),
  KEY `sm_staff_attendences_school_id_foreign` (`school_id`),
  KEY `sm_staff_attendences_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_staff_attendences_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staff_attendences_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staff_attendences_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `sm_staffs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_staff_attendences`
--

LOCK TABLES `sm_staff_attendences` WRITE;
/*!40000 ALTER TABLE `sm_staff_attendences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_staff_attendences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_staffs`
--

DROP TABLE IF EXISTS `sm_staffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_staffs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_no` int(11) DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fathers_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mothers_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT '2020-08-10',
  `date_of_joining` date DEFAULT '2020-08-10',
  `email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emergency_mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marital_status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merital_status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `staff_photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qualification` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `experience` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `epf_no` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `basic_salary` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contract_type` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `casual_leave` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `medical_leave` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `metarnity_leave` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_no` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_brach` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twiteer_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `linkedin_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instragram_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `joining_letter` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resume` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `other_document` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `driving_license` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driving_license_ex_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `designation_id` int(10) unsigned DEFAULT '1',
  `department_id` int(10) unsigned DEFAULT '1',
  `user_id` int(10) unsigned DEFAULT '1',
  `role_id` int(10) unsigned DEFAULT '1',
  `gender_id` int(10) unsigned DEFAULT '1',
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_staffs_designation_id_foreign` (`designation_id`),
  KEY `sm_staffs_department_id_foreign` (`department_id`),
  KEY `sm_staffs_user_id_foreign` (`user_id`),
  KEY `sm_staffs_role_id_foreign` (`role_id`),
  KEY `sm_staffs_gender_id_foreign` (`gender_id`),
  KEY `sm_staffs_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_staffs_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `sm_human_departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staffs_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `sm_designations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staffs_gender_id_foreign` FOREIGN KEY (`gender_id`) REFERENCES `sm_base_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staffs_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `infix_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staffs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_staffs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_staffs`
--

LOCK TABLES `sm_staffs` WRITE;
/*!40000 ALTER TABLE `sm_staffs` DISABLE KEYS */;
INSERT INTO `sm_staffs` VALUES (1,1,'System','Administrator','System Administrator',NULL,NULL,'2020-08-10','2020-08-10','t.rakhmonov97@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,'2020-08-10 05:58:15','2020-08-10 05:58:22',1,1,1,1,1,1,1,1),(2,2,'Azam','Djurabaev','Azam Djurabaev','Azam','','1970-01-01','2020-08-20','adjurabaev74@gmail.com','+998974804574','','married',NULL,'public/uploads/staff/56c41a6e1abc0b0706694c67ee5bdc5f.png','Tashkent','','','','','100','','',NULL,NULL,NULL,'','','','','','','','','','','',NULL,1,'',NULL,'2020-08-20 09:43:13','2020-08-20 09:43:13',3,2,6,4,1,1,1,1);
/*!40000 ALTER TABLE `sm_staffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_attendance_imports`
--

DROP TABLE IF EXISTS `sm_student_attendance_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_attendance_imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendance_date` date DEFAULT NULL,
  `in_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Present: P Late: L Absent: A Holiday: H Half Day: F',
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_attendance_imports_student_id_foreign` (`student_id`),
  KEY `sm_student_attendance_imports_school_id_foreign` (`school_id`),
  KEY `sm_student_attendance_imports_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_attendance_imports_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_attendance_imports_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_attendance_imports_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_attendance_imports`
--

LOCK TABLES `sm_student_attendance_imports` WRITE;
/*!40000 ALTER TABLE `sm_student_attendance_imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_attendance_imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_attendances`
--

DROP TABLE IF EXISTS `sm_student_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_attendances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendance_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Present: P Late: L Absent: A Holiday: H Half Day: F',
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_attendances_student_id_foreign` (`student_id`),
  KEY `sm_student_attendances_school_id_foreign` (`school_id`),
  KEY `sm_student_attendances_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_attendances_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_attendances_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_attendances`
--

LOCK TABLES `sm_student_attendances` WRITE;
/*!40000 ALTER TABLE `sm_student_attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_categories`
--

DROP TABLE IF EXISTS `sm_student_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_categories_school_id_foreign` (`school_id`),
  KEY `sm_student_categories_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_categories_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_categories_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_categories`
--

LOCK TABLES `sm_student_categories` WRITE;
/*!40000 ALTER TABLE `sm_student_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_certificates`
--

DROP TABLE IF EXISTS `sm_student_certificates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_certificates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `header_left_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `footer_left_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_center_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer_right_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_photo` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 = yes 0 no',
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_certificates_school_id_foreign` (`school_id`),
  KEY `sm_student_certificates_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_certificates_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_certificates_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_certificates`
--

LOCK TABLES `sm_student_certificates` WRITE;
/*!40000 ALTER TABLE `sm_student_certificates` DISABLE KEYS */;
INSERT INTO `sm_student_certificates` VALUES (1,'Certificate in Technical Communication (PCTC)','Since 2020','2020-05-17','Earning my UCR Extension professional certificate is one of the most beneficial things I\'ve done for my career. Before even completing the program, I was contacted twice by companies who were interested in hiring me as a technical writer. This program helped me reach my career goals in a very short time','Advisor Signature','Instructor Signature','Principale Signature',0,'public/uploads/certificate/c.jpg',1,'2020-08-10 05:58:19','2020-08-10 05:58:19',1,1,1,1);
/*!40000 ALTER TABLE `sm_student_certificates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_documents`
--

DROP TABLE IF EXISTS `sm_student_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_documents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_staff_id` int(11) DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stu=student,stf=staff',
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_documents_school_id_foreign` (`school_id`),
  KEY `sm_student_documents_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_documents_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_documents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_documents`
--

LOCK TABLES `sm_student_documents` WRITE;
/*!40000 ALTER TABLE `sm_student_documents` DISABLE KEYS */;
INSERT INTO `sm_student_documents` VALUES (1,'Freelance',1,'stu','public/uploads/student/document/stu-37f8602cc79a2408851b4635ebd1a33b.pdf',1,'2020-08-20 08:37:26','2020-08-20 08:37:26',1,1,1,1);
/*!40000 ALTER TABLE `sm_student_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_excel_formats`
--

DROP TABLE IF EXISTS `sm_student_excel_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_excel_formats` (
  `roll_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `caste` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_date` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `siblings_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_relation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_identification_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `local_identification_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_school_details` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  KEY `sm_student_excel_formats_school_id_foreign` (`school_id`),
  KEY `sm_student_excel_formats_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_excel_formats_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_excel_formats_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_excel_formats`
--

LOCK TABLES `sm_student_excel_formats` WRITE;
/*!40000 ALTER TABLE `sm_student_excel_formats` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_excel_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_groups`
--

DROP TABLE IF EXISTS `sm_student_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `section_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_student_groups_school_id_foreign` (`school_id`),
  KEY `sm_student_groups_academic_id_foreign` (`academic_id`),
  KEY `sm_student_groups_section_id_foreign` (`section_id`),
  KEY `sm_student_groups_class_id_foreign` (`class_id`),
  CONSTRAINT `sm_student_groups_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_groups_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_student_groups` (`id`),
  CONSTRAINT `sm_student_groups_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_groups_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_student_groups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_groups`
--

LOCK TABLES `sm_student_groups` WRITE;
/*!40000 ALTER TABLE `sm_student_groups` DISABLE KEYS */;
INSERT INTO `sm_student_groups` VALUES (1,'BUS 101',1,'2020-08-20 11:12:50','2020-08-20 11:12:50',1,1,1,1,2,NULL),(2,'BUS 102',1,'2020-08-20 11:13:02','2020-08-20 11:13:02',1,1,1,1,2,NULL),(3,'IT 101',1,'2020-08-20 11:13:13','2020-08-20 11:13:13',1,1,1,1,2,NULL),(4,'IT 102',1,'2020-08-20 11:13:18','2020-08-20 11:13:18',1,1,1,1,2,NULL),(5,'GRP 2',1,'2020-09-09 12:22:59','2020-09-09 12:22:59',1,1,1,1,2,NULL);
/*!40000 ALTER TABLE `sm_student_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_homeworks`
--

DROP TABLE IF EXISTS `sm_student_homeworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_homeworks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `homework_date` date DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `percentage` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `evaluated_by` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_homeworks_evaluated_by_foreign` (`evaluated_by`),
  KEY `sm_student_homeworks_student_id_foreign` (`student_id`),
  KEY `sm_student_homeworks_subject_id_foreign` (`subject_id`),
  KEY `sm_student_homeworks_school_id_foreign` (`school_id`),
  KEY `sm_student_homeworks_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_homeworks_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_homeworks_evaluated_by_foreign` FOREIGN KEY (`evaluated_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_homeworks_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_homeworks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_homeworks_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_homeworks`
--

LOCK TABLES `sm_student_homeworks` WRITE;
/*!40000 ALTER TABLE `sm_student_homeworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_homeworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_id_cards`
--

DROP TABLE IF EXISTS `sm_student_id_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_id_cards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `designation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `signature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `admission_no` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `student_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `class` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `father_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `mother_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `student_address` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `dob` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `blood` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '0 for no 1 for yes',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_id_cards_school_id_foreign` (`school_id`),
  KEY `sm_student_id_cards_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_id_cards_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_id_cards_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_id_cards`
--

LOCK TABLES `sm_student_id_cards` WRITE;
/*!40000 ALTER TABLE `sm_student_id_cards` DISABLE KEYS */;
INSERT INTO `sm_student_id_cards` VALUES (3,'CARD3','public/uploads/studentIdCard/logo-f6976b52e5baabb9658d1bc17161450b.jpg','asdasad','public/uploads/studentIdCard/signature-f6976b52e5baabb9658d1bc17161450b.jpg','asdsadada','1','1','1','','','MQQq19hOvP2lZ5KDIPhTyKE7WAUOu8','1','1','',1,'2020-09-09 14:02:08','2020-09-09 14:02:08',1,1,1,1);
/*!40000 ALTER TABLE `sm_student_id_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_promotions`
--

DROP TABLE IF EXISTS `sm_student_promotions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_promotions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `result_status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `previous_class_id` int(10) unsigned DEFAULT NULL,
  `current_class_id` int(10) unsigned DEFAULT NULL,
  `previous_section_id` int(10) unsigned DEFAULT NULL,
  `current_section_id` int(10) unsigned DEFAULT NULL,
  `previous_session_id` int(10) unsigned DEFAULT NULL,
  `current_session_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `admission_number` int(11) DEFAULT NULL,
  `student_info` longtext COLLATE utf8mb4_unicode_ci,
  `merit_student_info` longtext COLLATE utf8mb4_unicode_ci,
  `previous_roll_number` int(11) DEFAULT NULL,
  `current_roll_number` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_promotions_previous_class_id_foreign` (`previous_class_id`),
  KEY `sm_student_promotions_current_class_id_foreign` (`current_class_id`),
  KEY `sm_student_promotions_previous_section_id_foreign` (`previous_section_id`),
  KEY `sm_student_promotions_current_section_id_foreign` (`current_section_id`),
  KEY `sm_student_promotions_previous_session_id_foreign` (`previous_session_id`),
  KEY `sm_student_promotions_current_session_id_foreign` (`current_session_id`),
  KEY `sm_student_promotions_student_id_foreign` (`student_id`),
  KEY `sm_student_promotions_school_id_foreign` (`school_id`),
  KEY `sm_student_promotions_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_promotions_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_current_class_id_foreign` FOREIGN KEY (`current_class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_current_section_id_foreign` FOREIGN KEY (`current_section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_current_session_id_foreign` FOREIGN KEY (`current_session_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_previous_class_id_foreign` FOREIGN KEY (`previous_class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_previous_section_id_foreign` FOREIGN KEY (`previous_section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_previous_session_id_foreign` FOREIGN KEY (`previous_session_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_promotions_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_promotions`
--

LOCK TABLES `sm_student_promotions` WRITE;
/*!40000 ALTER TABLE `sm_student_promotions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_promotions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_take_online_exam_questions`
--

DROP TABLE IF EXISTS `sm_student_take_online_exam_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_take_online_exam_questions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `trueFalse` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'F = false, T = true ',
  `suitable_words` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `take_online_exam_id` int(10) unsigned DEFAULT NULL,
  `question_bank_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `t_on_ex_id` (`take_online_exam_id`),
  KEY `sm_student_take_online_exam_questions_question_bank_id_foreign` (`question_bank_id`),
  KEY `sm_student_take_online_exam_questions_school_id_foreign` (`school_id`),
  KEY `sm_student_take_online_exam_questions_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_take_online_exam_questions_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_online_exam_questions_question_bank_id_foreign` FOREIGN KEY (`question_bank_id`) REFERENCES `sm_question_banks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_online_exam_questions_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `t_on_ex_id` FOREIGN KEY (`take_online_exam_id`) REFERENCES `sm_student_take_online_exams` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_take_online_exam_questions`
--

LOCK TABLES `sm_student_take_online_exam_questions` WRITE;
/*!40000 ALTER TABLE `sm_student_take_online_exam_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_take_online_exam_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_take_online_exams`
--

DROP TABLE IF EXISTS `sm_student_take_online_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_take_online_exams` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=Not Yet, 1 = alreday submitted, 2 = got marks',
  `total_marks` int(11) DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `online_exam_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_take_online_exams_student_id_foreign` (`student_id`),
  KEY `sm_student_take_online_exams_online_exam_id_foreign` (`online_exam_id`),
  KEY `sm_student_take_online_exams_school_id_foreign` (`school_id`),
  KEY `sm_student_take_online_exams_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_take_online_exams_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_online_exams_online_exam_id_foreign` FOREIGN KEY (`online_exam_id`) REFERENCES `sm_online_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_online_exams_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_online_exams_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_take_online_exams`
--

LOCK TABLES `sm_student_take_online_exams` WRITE;
/*!40000 ALTER TABLE `sm_student_take_online_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_take_online_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_take_onln_ex_ques_options`
--

DROP TABLE IF EXISTS `sm_student_take_onln_ex_ques_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_take_onln_ex_ques_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL COMMENT '0 unchecked 1 checked',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `take_online_exam_question_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `t_on_ex_q_id` (`take_online_exam_question_id`),
  KEY `sm_student_take_onln_ex_ques_options_school_id_foreign` (`school_id`),
  KEY `sm_student_take_onln_ex_ques_options_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_take_onln_ex_ques_options_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_take_onln_ex_ques_options_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `t_on_ex_q_id` FOREIGN KEY (`take_online_exam_question_id`) REFERENCES `sm_student_take_online_exam_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_take_onln_ex_ques_options`
--

LOCK TABLES `sm_student_take_onln_ex_ques_options` WRITE;
/*!40000 ALTER TABLE `sm_student_take_onln_ex_ques_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_take_onln_ex_ques_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_student_timelines`
--

DROP TABLE IF EXISTS `sm_student_timelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_student_timelines` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `staff_student_id` int(11) NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `file` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stu=student,stf=staff',
  `visible_to_student` int(11) NOT NULL DEFAULT '0' COMMENT '0 = no, 1 = yes',
  `active_status` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_student_timelines_school_id_foreign` (`school_id`),
  KEY `sm_student_timelines_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_student_timelines_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_student_timelines_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_student_timelines`
--

LOCK TABLES `sm_student_timelines` WRITE;
/*!40000 ALTER TABLE `sm_student_timelines` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_student_timelines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_students`
--

DROP TABLE IF EXISTS `sm_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_students` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admission_no` int(11) DEFAULT NULL,
  `roll_no` int(11) DEFAULT NULL,
  `first_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `caste` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_date` date DEFAULT NULL,
  `student_photo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `driver_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_id_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `local_id_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_no` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_school_details` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `aditional_notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_title_1` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_file_1` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_title_2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_file_2` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_title_3` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_file_3` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_title_4` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `document_file_4` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bloodgroup_id` int(10) unsigned DEFAULT NULL,
  `religion_id` int(10) unsigned DEFAULT NULL,
  `route_list_id` int(10) unsigned DEFAULT NULL,
  `dormitory_id` int(10) unsigned DEFAULT NULL,
  `vechile_id` int(10) unsigned DEFAULT NULL,
  `room_id` int(10) unsigned DEFAULT NULL,
  `student_category_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned NOT NULL,
  `section_id` int(10) unsigned NOT NULL,
  `session_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned NOT NULL,
  `gender_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  `group_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sm_students_bloodgroup_id_foreign` (`bloodgroup_id`),
  KEY `sm_students_religion_id_foreign` (`religion_id`),
  KEY `sm_students_route_list_id_foreign` (`route_list_id`),
  KEY `sm_students_dormitory_id_foreign` (`dormitory_id`),
  KEY `sm_students_vechile_id_foreign` (`vechile_id`),
  KEY `sm_students_room_id_foreign` (`room_id`),
  KEY `sm_students_student_category_id_foreign` (`student_category_id`),
  KEY `sm_students_class_id_foreign` (`class_id`),
  KEY `sm_students_section_id_foreign` (`section_id`),
  KEY `sm_students_session_id_foreign` (`session_id`),
  KEY `sm_students_parent_id_foreign` (`parent_id`),
  KEY `sm_students_user_id_foreign` (`user_id`),
  KEY `sm_students_role_id_foreign` (`role_id`),
  KEY `sm_students_gender_id_foreign` (`gender_id`),
  KEY `sm_students_school_id_foreign` (`school_id`),
  KEY `sm_students_academic_id_foreign` (`academic_id`),
  KEY `sm_students_group_id_foreign` (`group_id`),
  CONSTRAINT `sm_students_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_bloodgroup_id_foreign` FOREIGN KEY (`bloodgroup_id`) REFERENCES `sm_base_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_dormitory_id_foreign` FOREIGN KEY (`dormitory_id`) REFERENCES `sm_dormitory_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_gender_id_foreign` FOREIGN KEY (`gender_id`) REFERENCES `sm_base_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `sm_student_groups` (`id`),
  CONSTRAINT `sm_students_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `sm_parents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_religion_id_foreign` FOREIGN KEY (`religion_id`) REFERENCES `sm_base_setups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `infix_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `sm_room_lists` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_route_list_id_foreign` FOREIGN KEY (`route_list_id`) REFERENCES `sm_routes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_student_category_id_foreign` FOREIGN KEY (`student_category_id`) REFERENCES `sm_student_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_students_vechile_id_foreign` FOREIGN KEY (`vechile_id`) REFERENCES `sm_vehicles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_students`
--

LOCK TABLES `sm_students` WRITE;
/*!40000 ALTER TABLE `sm_students` DISABLE KEYS */;
INSERT INTO `sm_students` VALUES (1,1,1,'Abbos Qosim','','Abbos Qosim ','1997-01-01','','abbosibnqosim@gmail.com','','2020-08-10',NULL,NULL,'','','','',NULL,'','','','','','','','','','','','','','',1,'2020-01-01 07:00:00','2020-08-12 02:49:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,2,2,1,1,1,1,1,NULL),(2,2,2,'Tolib Bro','Rakhmonov','Tolib Bro Rakhmonov','1997-01-01','','','','2020-08-12',NULL,NULL,'','','','',NULL,'','','','','','','','','','','','','','',1,'2020-01-01 07:00:00','2020-08-12 02:47:56',10,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,2,4,2,2,1,1,1,1,NULL),(3,3,1,'Murodjon','Khalikov','Murodjon Khalikov','1991-05-09','','murodjon@edu-action.uz','+998998558626','2020-09-15','public/uploads/student/5d1c0ce304d746b60fd5ad0cbd2b65c4.png',NULL,'','75','','',NULL,'','','','','','','','','','','','','','',1,'2020-01-01 07:00:00','2020-08-20 11:17:50',11,NULL,NULL,NULL,NULL,NULL,NULL,1,2,1,3,7,2,1,1,1,1,1,NULL),(4,4,2,'AAAAA','','AAAAA ','2020-09-08','','','','2020-09-05',NULL,NULL,'','','','',NULL,'','','','','','','','','','','','','','',1,'2020-01-01 12:00:00','2020-09-05 13:56:45',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,1,4,27,2,1,1,1,1,1,NULL),(5,5,3,'aaaaaasd','','aaaaaasd ','2020-09-29','','','','2020-09-05',NULL,NULL,'','','','',NULL,'','','','','','','','','','','','','','',1,'2020-01-01 12:00:00','2020-09-05 13:57:53',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,1,5,29,2,1,1,1,1,1,NULL),(6,6,4,'SDSDSDSAsa','','SDSDSDSAsa ','2020-09-29',NULL,'','','1970-01-01',NULL,NULL,NULL,NULL,'asasdasdasda','',NULL,'',NULL,NULL,NULL,NULL,NULL,'domestic_passport','','travel_passport','',NULL,'',NULL,'',1,'2020-01-01 12:00:00','2020-09-06 12:39:06',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,1,6,33,2,2,1,1,1,1,NULL),(7,7,5,'asdsa','','asdsa ','2020-09-30',NULL,'','','1970-01-01',NULL,NULL,NULL,NULL,'asdsad','',NULL,'',NULL,NULL,NULL,NULL,NULL,'domestic_passport','','travel_passport','',NULL,'',NULL,'',1,'2021-01-01 07:00:00','2020-09-10 20:52:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,2,1,7,35,2,1,1,1,1,1,3);
/*!40000 ALTER TABLE `sm_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_styles`
--

DROP TABLE IF EXISTS `sm_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_styles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `style_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path_main_style` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path_infix_style` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_color2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `white` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `black` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sidebar_bg` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barchart1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barchart2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcharttextcolor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcharttextfamily` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `areachartlinecolor1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `areachartlinecolor2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dashboardbackground` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `is_active` tinyint(4) NOT NULL DEFAULT '0',
  `is_default` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'if 1 then yes, if 0 then no',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_styles_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_styles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_styles`
--

LOCK TABLES `sm_styles` WRITE;
/*!40000 ALTER TABLE `sm_styles` DISABLE KEYS */;
INSERT INTO `sm_styles` VALUES (1,'Default','style.css','infix.css','#415094','#7c32ff','#222222','#828bb2','#ffffff','#000000','#e7ecff','#8a33f8','#f25278','#415094','\"poppins\", sans-serif','rgba(124, 50, 255, 0.5)','rgba(242, 82, 120, 0.5)','',1,1,0,'2020-08-10 05:58:21','2020-09-13 09:23:20',1,1,1),(2,'Lawn Green','lawngreen_version/style.css','lawngreen_version/infix.css','#415094','#03e396','#222222','#828bb2','#ffffff','#000000','#e7ecff','#415094','#03e396','#03e396','\"Cerebri Sans\", Helvetica, Arial, sans-serif','#415094','#03e396','#e7ecff',1,0,0,'2020-08-10 05:58:21','2020-09-13 09:23:19',1,1,1);
/*!40000 ALTER TABLE `sm_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_subject_attendances`
--

DROP TABLE IF EXISTS `sm_subject_attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_subject_attendances` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attendance_type` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Present: P Late: L Absent: A Holiday: H Half Day: F',
  `notes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
  `student_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_subject_attendances_subject_id_foreign` (`subject_id`),
  KEY `sm_subject_attendances_student_id_foreign` (`student_id`),
  KEY `sm_subject_attendances_school_id_foreign` (`school_id`),
  KEY `sm_subject_attendances_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_subject_attendances_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_subject_attendances_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_subject_attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_subject_attendances_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `sm_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_subject_attendances`
--

LOCK TABLES `sm_subject_attendances` WRITE;
/*!40000 ALTER TABLE `sm_subject_attendances` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_subject_attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_subjects`
--

DROP TABLE IF EXISTS `sm_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_subjects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_type` enum('T','P') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'T=Theory, P=Practical',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_subjects_school_id_foreign` (`school_id`),
  KEY `sm_subjects_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_subjects_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_subjects_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_subjects`
--

LOCK TABLES `sm_subjects` WRITE;
/*!40000 ALTER TABLE `sm_subjects` DISABLE KEYS */;
INSERT INTO `sm_subjects` VALUES (1,'Exploring Business','BUS-U1','P',1,'2020-08-20 09:26:28','2020-08-20 09:26:28',1,1,1,1),(2,'International Business','BUS-U5','P',1,'2020-08-20 09:27:16','2020-08-20 09:27:16',1,1,1,1),(3,'Research and Plan a Marketing Campaign','BUS-U2','P',1,'2020-08-20 09:28:12','2020-08-20 09:28:12',1,1,1,1),(4,'Business Finance','BUS-U3','P',1,'2020-08-20 09:29:22','2020-08-20 09:30:00',1,1,1,1),(5,'Business Decision Making','BUS-U7','P',1,'2020-08-20 09:29:46','2020-08-20 09:29:46',1,1,1,1),(6,'Digital Marketing','BUS-U17','P',1,'2020-08-20 09:30:23','2020-08-20 10:19:18',1,1,1,1),(7,'English Language','ENG-1','P',1,'2020-08-20 10:47:19','2020-08-20 10:47:19',1,1,1,1);
/*!40000 ALTER TABLE `sm_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_suppliers`
--

DROP TABLE IF EXISTS `sm_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_suppliers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cotact_person_address` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_suppliers_school_id_foreign` (`school_id`),
  KEY `sm_suppliers_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_suppliers_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_suppliers_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_suppliers`
--

LOCK TABLES `sm_suppliers` WRITE;
/*!40000 ALTER TABLE `sm_suppliers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_system_versions`
--

DROP TABLE IF EXISTS `sm_system_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_system_versions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `features` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_system_versions`
--

LOCK TABLES `sm_system_versions` WRITE;
/*!40000 ALTER TABLE `sm_system_versions` DISABLE KEYS */;
INSERT INTO `sm_system_versions` VALUES (1,'3.2','Upgrade System Integration','features 1, features 2','2020-08-10 05:58:21','2020-08-10 05:58:21');
/*!40000 ALTER TABLE `sm_system_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_teacher_upload_contents`
--

DROP TABLE IF EXISTS `sm_teacher_upload_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_teacher_upload_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'as assignment, st study material, sy sullabus, ot others download',
  `available_for_admin` int(11) NOT NULL DEFAULT '0',
  `available_for_all_classes` int(11) NOT NULL DEFAULT '0',
  `upload_date` date DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `class` int(10) unsigned DEFAULT NULL,
  `section` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_teacher_upload_contents_class_foreign` (`class`),
  KEY `sm_teacher_upload_contents_section_foreign` (`section`),
  KEY `sm_teacher_upload_contents_school_id_foreign` (`school_id`),
  KEY `sm_teacher_upload_contents_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_teacher_upload_contents_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_teacher_upload_contents_class_foreign` FOREIGN KEY (`class`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_teacher_upload_contents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_teacher_upload_contents_section_foreign` FOREIGN KEY (`section`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_teacher_upload_contents`
--

LOCK TABLES `sm_teacher_upload_contents` WRITE;
/*!40000 ALTER TABLE `sm_teacher_upload_contents` DISABLE KEYS */;
INSERT INTO `sm_teacher_upload_contents` VALUES (1,'Textbook','sy',1,0,'2020-08-20','Test sample','public/uploads/upload_contents/fca64fac280f5d57c72677deb565d11f.pdf',1,'2020-08-20 10:55:40','2020-08-20 10:55:40',1,2,1,1,1,1);
/*!40000 ALTER TABLE `sm_teacher_upload_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_temporary_meritlists`
--

DROP TABLE IF EXISTS `sm_temporary_meritlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_temporary_meritlists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iid` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_id` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `merit_order` int(11) DEFAULT NULL,
  `student_name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_no` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subjects_id_string` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subjects_string` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `marks_string` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_marks` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `average_mark` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gpa_point` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) unsigned DEFAULT NULL,
  `class_id` int(10) unsigned DEFAULT NULL,
  `section_id` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_temporary_meritlists_exam_id_foreign` (`exam_id`),
  KEY `sm_temporary_meritlists_class_id_foreign` (`class_id`),
  KEY `sm_temporary_meritlists_section_id_foreign` (`section_id`),
  KEY `sm_temporary_meritlists_school_id_foreign` (`school_id`),
  KEY `sm_temporary_meritlists_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_temporary_meritlists_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_temporary_meritlists_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `sm_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_temporary_meritlists_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `sm_exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_temporary_meritlists_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_temporary_meritlists_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sm_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_temporary_meritlists`
--

LOCK TABLES `sm_temporary_meritlists` WRITE;
/*!40000 ALTER TABLE `sm_temporary_meritlists` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_temporary_meritlists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_testimonials`
--

DROP TABLE IF EXISTS `sm_testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_testimonials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `institution_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_testimonials_school_id_foreign` (`school_id`),
  CONSTRAINT `sm_testimonials_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_testimonials`
--

LOCK TABLES `sm_testimonials` WRITE;
/*!40000 ALTER TABLE `sm_testimonials` DISABLE KEYS */;
INSERT INTO `sm_testimonials` VALUES (1,'Tristique euhen','CEO','Google','public/uploads/testimonial/testimonial_1.jpg','its vast! Infix has more additional feature that will expect in a complete solution.','2020-08-10 05:58:21',NULL,1),(2,'Malala euhen','Chairman','Linkdin','public/uploads/testimonial/testimonial_2.jpg','its vast! Infix has more additional feature that will expect in a complete solution.','2020-08-10 05:58:21',NULL,1);
/*!40000 ALTER TABLE `sm_testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_time_zones`
--

DROP TABLE IF EXISTS `sm_time_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_time_zones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_zone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_time_zones`
--

LOCK TABLES `sm_time_zones` WRITE;
/*!40000 ALTER TABLE `sm_time_zones` DISABLE KEYS */;
INSERT INTO `sm_time_zones` VALUES (1,'AD','Europe/Andorra','2020-08-10 05:58:21','2020-08-10 05:58:21'),(2,'AE','Asia/Dubai','2020-08-10 05:58:21','2020-08-10 05:58:21'),(3,'AF','Asia/Kabul','2020-08-10 05:58:21','2020-08-10 05:58:21'),(4,'AG','America/Antigua','2020-08-10 05:58:21','2020-08-10 05:58:21'),(5,'AI','America/Anguilla','2020-08-10 05:58:21','2020-08-10 05:58:21'),(6,'AL','Europe/Tirane','2020-08-10 05:58:21','2020-08-10 05:58:21'),(7,'AM','Asia/Yerevan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(8,'AO','Africa/Luanda','2020-08-10 05:58:21','2020-08-10 05:58:21'),(9,'AQ','Antarctica/McMurdo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(10,'AQ','Antarctica/Casey','2020-08-10 05:58:21','2020-08-10 05:58:21'),(11,'AQ','Antarctica/Davis','2020-08-10 05:58:21','2020-08-10 05:58:21'),(12,'AQ','Antarctica/DumontDUrville','2020-08-10 05:58:21','2020-08-10 05:58:21'),(13,'AQ','Antarctica/Mawson','2020-08-10 05:58:21','2020-08-10 05:58:21'),(14,'AQ','Antarctica/Palmer','2020-08-10 05:58:21','2020-08-10 05:58:21'),(15,'AQ','Antarctica/Rothera','2020-08-10 05:58:21','2020-08-10 05:58:21'),(16,'AQ','Antarctica/Syowa','2020-08-10 05:58:21','2020-08-10 05:58:21'),(17,'AQ','Antarctica/Troll','2020-08-10 05:58:21','2020-08-10 05:58:21'),(18,'AQ','Antarctica/Vostok','2020-08-10 05:58:21','2020-08-10 05:58:21'),(19,'AR','America/Argentina/Buenos_Aires','2020-08-10 05:58:21','2020-08-10 05:58:21'),(20,'AR','America/Argentina/Cordoba','2020-08-10 05:58:21','2020-08-10 05:58:21'),(21,'AR','America/Argentina/Salta','2020-08-10 05:58:21','2020-08-10 05:58:21'),(22,'AR','America/Argentina/Jujuy','2020-08-10 05:58:21','2020-08-10 05:58:21'),(23,'AR','America/Argentina/Tucuman','2020-08-10 05:58:21','2020-08-10 05:58:21'),(24,'AR','America/Argentina/Catamarca','2020-08-10 05:58:21','2020-08-10 05:58:21'),(25,'AR','America/Argentina/La_Rioja','2020-08-10 05:58:21','2020-08-10 05:58:21'),(26,'AR','America/Argentina/San_Juan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(27,'AR','America/Argentina/Mendoza','2020-08-10 05:58:21','2020-08-10 05:58:21'),(28,'AR','America/Argentina/San_Luis','2020-08-10 05:58:21','2020-08-10 05:58:21'),(29,'AR','America/Argentina/Rio_Gallegos','2020-08-10 05:58:21','2020-08-10 05:58:21'),(30,'AR','America/Argentina/Ushuaia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(31,'AS','Pacific/Pago_Pago','2020-08-10 05:58:21','2020-08-10 05:58:21'),(32,'AT','Europe/Vienna','2020-08-10 05:58:21','2020-08-10 05:58:21'),(33,'AU','Australia/Lord_Howe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(34,'AU','Antarctica/Macquarie','2020-08-10 05:58:21','2020-08-10 05:58:21'),(35,'AU','Australia/Hobart','2020-08-10 05:58:21','2020-08-10 05:58:21'),(36,'AU','Australia/Currie','2020-08-10 05:58:21','2020-08-10 05:58:21'),(37,'AU','Australia/Melbourne','2020-08-10 05:58:21','2020-08-10 05:58:21'),(38,'AU','Australia/Sydney','2020-08-10 05:58:21','2020-08-10 05:58:21'),(39,'AU','Australia/Broken_Hill','2020-08-10 05:58:21','2020-08-10 05:58:21'),(40,'AU','Australia/Brisbane','2020-08-10 05:58:21','2020-08-10 05:58:21'),(41,'AU','Australia/Lindeman','2020-08-10 05:58:21','2020-08-10 05:58:21'),(42,'AU','Australia/Adelaide','2020-08-10 05:58:21','2020-08-10 05:58:21'),(43,'AU','Australia/Darwin','2020-08-10 05:58:21','2020-08-10 05:58:21'),(44,'AU','Australia/Perth','2020-08-10 05:58:21','2020-08-10 05:58:21'),(45,'AU','Australia/Eucla','2020-08-10 05:58:21','2020-08-10 05:58:21'),(46,'AW','America/Aruba','2020-08-10 05:58:21','2020-08-10 05:58:21'),(47,'AX','Europe/Mariehamn','2020-08-10 05:58:21','2020-08-10 05:58:21'),(48,'AZ','Asia/Baku','2020-08-10 05:58:21','2020-08-10 05:58:21'),(49,'BA','Europe/Sarajevo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(50,'BB','America/Barbados','2020-08-10 05:58:21','2020-08-10 05:58:21'),(51,'BD','Asia/Dhaka','2020-08-10 05:58:21','2020-08-10 05:58:21'),(52,'BE','Europe/Brussels','2020-08-10 05:58:21','2020-08-10 05:58:21'),(53,'BF','Africa/Ouagadougou','2020-08-10 05:58:21','2020-08-10 05:58:21'),(54,'BG','Europe/Sofia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(55,'BH','Asia/Bahrain','2020-08-10 05:58:21','2020-08-10 05:58:21'),(56,'BI','Africa/Bujumbura','2020-08-10 05:58:21','2020-08-10 05:58:21'),(57,'BJ','Africa/Porto-Novo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(58,'BL','America/St_Barthelemy','2020-08-10 05:58:21','2020-08-10 05:58:21'),(59,'BM','Atlantic/Bermuda','2020-08-10 05:58:21','2020-08-10 05:58:21'),(60,'BN','Asia/Brunei','2020-08-10 05:58:21','2020-08-10 05:58:21'),(61,'BO','America/La_Paz','2020-08-10 05:58:21','2020-08-10 05:58:21'),(62,'BQ','America/Kralendijk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(63,'BR','America/Noronha','2020-08-10 05:58:21','2020-08-10 05:58:21'),(64,'BR','America/Belem','2020-08-10 05:58:21','2020-08-10 05:58:21'),(65,'BR','America/Fortaleza','2020-08-10 05:58:21','2020-08-10 05:58:21'),(66,'BR','America/Recife','2020-08-10 05:58:21','2020-08-10 05:58:21'),(67,'BR','America/Araguaina','2020-08-10 05:58:21','2020-08-10 05:58:21'),(68,'BR','America/Maceio','2020-08-10 05:58:21','2020-08-10 05:58:21'),(69,'BR','America/Bahia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(70,'BR','America/Sao_Paulo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(71,'BR','America/Campo_Grande','2020-08-10 05:58:21','2020-08-10 05:58:21'),(72,'BR','America/Cuiaba','2020-08-10 05:58:21','2020-08-10 05:58:21'),(73,'BR','America/Santarem','2020-08-10 05:58:21','2020-08-10 05:58:21'),(74,'BR','America/Porto_Velho','2020-08-10 05:58:21','2020-08-10 05:58:21'),(75,'BR','America/Boa_Vista','2020-08-10 05:58:21','2020-08-10 05:58:21'),(76,'BR','America/Manaus','2020-08-10 05:58:21','2020-08-10 05:58:21'),(77,'BR','America/Eirunepe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(78,'BR','America/Rio_Branco','2020-08-10 05:58:21','2020-08-10 05:58:21'),(79,'BS','America/Nassau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(80,'BT','Asia/Thimphu','2020-08-10 05:58:21','2020-08-10 05:58:21'),(81,'BW','Africa/Gaborone','2020-08-10 05:58:21','2020-08-10 05:58:21'),(82,'BY','Europe/Minsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(83,'BZ','America/Belize','2020-08-10 05:58:21','2020-08-10 05:58:21'),(84,'CA','America/St_Johns','2020-08-10 05:58:21','2020-08-10 05:58:21'),(85,'CA','America/Halifax','2020-08-10 05:58:21','2020-08-10 05:58:21'),(86,'CA','America/Glace_Bay','2020-08-10 05:58:21','2020-08-10 05:58:21'),(87,'CA','America/Moncton','2020-08-10 05:58:21','2020-08-10 05:58:21'),(88,'CA','America/Goose_Bay','2020-08-10 05:58:21','2020-08-10 05:58:21'),(89,'CA','America/Blanc-Sablon','2020-08-10 05:58:21','2020-08-10 05:58:21'),(90,'CA','America/Toronto','2020-08-10 05:58:21','2020-08-10 05:58:21'),(91,'CA','America/Nipigon','2020-08-10 05:58:21','2020-08-10 05:58:21'),(92,'CA','America/Thunder_Bay','2020-08-10 05:58:21','2020-08-10 05:58:21'),(93,'CA','America/Iqaluit','2020-08-10 05:58:21','2020-08-10 05:58:21'),(94,'CA','America/Pangnirtung','2020-08-10 05:58:21','2020-08-10 05:58:21'),(95,'CA','America/Atikokan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(96,'CA','America/Winnipeg','2020-08-10 05:58:21','2020-08-10 05:58:21'),(97,'CA','America/Rainy_River','2020-08-10 05:58:21','2020-08-10 05:58:21'),(98,'CA','America/Resolute','2020-08-10 05:58:21','2020-08-10 05:58:21'),(99,'CA','America/Rankin_Inlet','2020-08-10 05:58:21','2020-08-10 05:58:21'),(100,'CA','America/Regina','2020-08-10 05:58:21','2020-08-10 05:58:21'),(101,'CA','America/Swift_Current','2020-08-10 05:58:21','2020-08-10 05:58:21'),(102,'CA','America/Edmonton','2020-08-10 05:58:21','2020-08-10 05:58:21'),(103,'CA','America/Cambridge_Bay','2020-08-10 05:58:21','2020-08-10 05:58:21'),(104,'CA','America/Yellowknife','2020-08-10 05:58:21','2020-08-10 05:58:21'),(105,'CA','America/Inuvik','2020-08-10 05:58:21','2020-08-10 05:58:21'),(106,'CA','America/Creston','2020-08-10 05:58:21','2020-08-10 05:58:21'),(107,'CA','America/Dawson_Creek','2020-08-10 05:58:21','2020-08-10 05:58:21'),(108,'CA','America/Fort_Nelson','2020-08-10 05:58:21','2020-08-10 05:58:21'),(109,'CA','America/Vancouver','2020-08-10 05:58:21','2020-08-10 05:58:21'),(110,'CA','America/Whitehorse','2020-08-10 05:58:21','2020-08-10 05:58:21'),(111,'CA','America/Dawson','2020-08-10 05:58:21','2020-08-10 05:58:21'),(112,'CC','Indian/Cocos','2020-08-10 05:58:21','2020-08-10 05:58:21'),(113,'CD','Africa/Kinshasa','2020-08-10 05:58:21','2020-08-10 05:58:21'),(114,'CD','Africa/Lubumbashi','2020-08-10 05:58:21','2020-08-10 05:58:21'),(115,'CF','Africa/Bangui','2020-08-10 05:58:21','2020-08-10 05:58:21'),(116,'CG','Africa/Brazzaville','2020-08-10 05:58:21','2020-08-10 05:58:21'),(117,'CH','Europe/Zurich','2020-08-10 05:58:21','2020-08-10 05:58:21'),(118,'CI','Africa/Abidjan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(119,'CK','Pacific/Rarotonga','2020-08-10 05:58:21','2020-08-10 05:58:21'),(120,'CL','America/Santiago','2020-08-10 05:58:21','2020-08-10 05:58:21'),(121,'CL','America/Punta_Arenas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(122,'CL','Pacific/Easter','2020-08-10 05:58:21','2020-08-10 05:58:21'),(123,'CM','Africa/Douala','2020-08-10 05:58:21','2020-08-10 05:58:21'),(124,'CN','Asia/Shanghai','2020-08-10 05:58:21','2020-08-10 05:58:21'),(125,'CN','Asia/Urumqi','2020-08-10 05:58:21','2020-08-10 05:58:21'),(126,'CO','America/Bogota','2020-08-10 05:58:21','2020-08-10 05:58:21'),(127,'CR','America/Costa_Rica','2020-08-10 05:58:21','2020-08-10 05:58:21'),(128,'CU','America/Havana','2020-08-10 05:58:21','2020-08-10 05:58:21'),(129,'CV','Atlantic/Cape_Verde','2020-08-10 05:58:21','2020-08-10 05:58:21'),(130,'CW','America/Curacao','2020-08-10 05:58:21','2020-08-10 05:58:21'),(131,'CX','Indian/Christmas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(132,'CY','Asia/Nicosia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(133,'CY','Asia/Famagusta','2020-08-10 05:58:21','2020-08-10 05:58:21'),(134,'CZ','Europe/Prague','2020-08-10 05:58:21','2020-08-10 05:58:21'),(135,'DE','Europe/Berlin','2020-08-10 05:58:21','2020-08-10 05:58:21'),(136,'DE','Europe/Busingen','2020-08-10 05:58:21','2020-08-10 05:58:21'),(137,'DJ','Africa/Djibouti','2020-08-10 05:58:21','2020-08-10 05:58:21'),(138,'DK','Europe/Copenhagen','2020-08-10 05:58:21','2020-08-10 05:58:21'),(139,'DM','America/Dominica','2020-08-10 05:58:21','2020-08-10 05:58:21'),(140,'DO','America/Santo_Domingo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(141,'DZ','Africa/Algiers','2020-08-10 05:58:21','2020-08-10 05:58:21'),(142,'EC','America/Guayaquil','2020-08-10 05:58:21','2020-08-10 05:58:21'),(143,'EC','Pacific/Galapagos','2020-08-10 05:58:21','2020-08-10 05:58:21'),(144,'EE','Europe/Tallinn','2020-08-10 05:58:21','2020-08-10 05:58:21'),(145,'EG','Africa/Cairo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(146,'EH','Africa/El_Aaiun','2020-08-10 05:58:21','2020-08-10 05:58:21'),(147,'ER','Africa/Asmara','2020-08-10 05:58:21','2020-08-10 05:58:21'),(148,'ES','Europe/Madrid','2020-08-10 05:58:21','2020-08-10 05:58:21'),(149,'ES','Africa/Ceuta','2020-08-10 05:58:21','2020-08-10 05:58:21'),(150,'ES','Atlantic/Canary','2020-08-10 05:58:21','2020-08-10 05:58:21'),(151,'ET','Africa/Addis_Ababa','2020-08-10 05:58:21','2020-08-10 05:58:21'),(152,'FI','Europe/Helsinki','2020-08-10 05:58:21','2020-08-10 05:58:21'),(153,'FJ','Pacific/Fiji','2020-08-10 05:58:21','2020-08-10 05:58:21'),(154,'FK','Atlantic/Stanley','2020-08-10 05:58:21','2020-08-10 05:58:21'),(155,'FM','Pacific/Chuuk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(156,'FM','Pacific/Pohnpei','2020-08-10 05:58:21','2020-08-10 05:58:21'),(157,'FM','Pacific/Kosrae','2020-08-10 05:58:21','2020-08-10 05:58:21'),(158,'FO','Atlantic/Faroe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(159,'FR','Europe/Paris','2020-08-10 05:58:21','2020-08-10 05:58:21'),(160,'GA','Africa/Libreville','2020-08-10 05:58:21','2020-08-10 05:58:21'),(161,'GB','Europe/London','2020-08-10 05:58:21','2020-08-10 05:58:21'),(162,'GD','America/Grenada','2020-08-10 05:58:21','2020-08-10 05:58:21'),(163,'GE','Asia/Tbilisi','2020-08-10 05:58:21','2020-08-10 05:58:21'),(164,'GF','America/Cayenne','2020-08-10 05:58:21','2020-08-10 05:58:21'),(165,'GG','Europe/Guernsey','2020-08-10 05:58:21','2020-08-10 05:58:21'),(166,'GH','Africa/Accra','2020-08-10 05:58:21','2020-08-10 05:58:21'),(167,'GI','Europe/Gibraltar','2020-08-10 05:58:21','2020-08-10 05:58:21'),(168,'GL','America/Godthab','2020-08-10 05:58:21','2020-08-10 05:58:21'),(169,'GL','America/Danmarkshavn','2020-08-10 05:58:21','2020-08-10 05:58:21'),(170,'GL','America/Scoresbysund','2020-08-10 05:58:21','2020-08-10 05:58:21'),(171,'GL','America/Thule','2020-08-10 05:58:21','2020-08-10 05:58:21'),(172,'GM','Africa/Banjul','2020-08-10 05:58:21','2020-08-10 05:58:21'),(173,'GN','Africa/Conakry','2020-08-10 05:58:21','2020-08-10 05:58:21'),(174,'GP','America/Guadeloupe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(175,'GQ','Africa/Malabo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(176,'GR','Europe/Athens','2020-08-10 05:58:21','2020-08-10 05:58:21'),(177,'GS','Atlantic/South_Georgia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(178,'GT','America/Guatemala','2020-08-10 05:58:21','2020-08-10 05:58:21'),(179,'GU','Pacific/Guam','2020-08-10 05:58:21','2020-08-10 05:58:21'),(180,'GW','Africa/Bissau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(181,'GY','America/Guyana','2020-08-10 05:58:21','2020-08-10 05:58:21'),(182,'HK','Asia/Hong_Kong','2020-08-10 05:58:21','2020-08-10 05:58:21'),(183,'HN','America/Tegucigalpa','2020-08-10 05:58:21','2020-08-10 05:58:21'),(184,'HR','Europe/Zagreb','2020-08-10 05:58:21','2020-08-10 05:58:21'),(185,'HT','America/Port-au-Prince','2020-08-10 05:58:21','2020-08-10 05:58:21'),(186,'HU','Europe/Budapest','2020-08-10 05:58:21','2020-08-10 05:58:21'),(187,'ID','Asia/Jakarta','2020-08-10 05:58:21','2020-08-10 05:58:21'),(188,'ID','Asia/Pontianak','2020-08-10 05:58:21','2020-08-10 05:58:21'),(189,'ID','Asia/Makassar','2020-08-10 05:58:21','2020-08-10 05:58:21'),(190,'ID','Asia/Jayapura','2020-08-10 05:58:21','2020-08-10 05:58:21'),(191,'IE','Europe/Dublin','2020-08-10 05:58:21','2020-08-10 05:58:21'),(192,'IL','Asia/Jerusalem','2020-08-10 05:58:21','2020-08-10 05:58:21'),(193,'IM','Europe/Isle_of_Man','2020-08-10 05:58:21','2020-08-10 05:58:21'),(194,'IN','Asia/Kolkata','2020-08-10 05:58:21','2020-08-10 05:58:21'),(195,'IO','Indian/Chagos','2020-08-10 05:58:21','2020-08-10 05:58:21'),(196,'IQ','Asia/Baghdad','2020-08-10 05:58:21','2020-08-10 05:58:21'),(197,'IR','Asia/Tehran','2020-08-10 05:58:21','2020-08-10 05:58:21'),(198,'IS','Atlantic/Reykjavik','2020-08-10 05:58:21','2020-08-10 05:58:21'),(199,'IT','Europe/Rome','2020-08-10 05:58:21','2020-08-10 05:58:21'),(200,'JE','Europe/Jersey','2020-08-10 05:58:21','2020-08-10 05:58:21'),(201,'JM','America/Jamaica','2020-08-10 05:58:21','2020-08-10 05:58:21'),(202,'JO','Asia/Amman','2020-08-10 05:58:21','2020-08-10 05:58:21'),(203,'JP','Asia/Tokyo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(204,'KE','Africa/Nairobi','2020-08-10 05:58:21','2020-08-10 05:58:21'),(205,'KG','Asia/Bishkek','2020-08-10 05:58:21','2020-08-10 05:58:21'),(206,'KH','Asia/Phnom_Penh','2020-08-10 05:58:21','2020-08-10 05:58:21'),(207,'KI','Pacific/Tarawa','2020-08-10 05:58:21','2020-08-10 05:58:21'),(208,'KI','Pacific/Enderbury','2020-08-10 05:58:21','2020-08-10 05:58:21'),(209,'KI','Pacific/Kiritimati','2020-08-10 05:58:21','2020-08-10 05:58:21'),(210,'KM','Indian/Comoro','2020-08-10 05:58:21','2020-08-10 05:58:21'),(211,'KN','America/St_Kitts','2020-08-10 05:58:21','2020-08-10 05:58:21'),(212,'KP','Asia/Pyongyang','2020-08-10 05:58:21','2020-08-10 05:58:21'),(213,'KR','Asia/Seoul','2020-08-10 05:58:21','2020-08-10 05:58:21'),(214,'KW','Asia/Kuwait','2020-08-10 05:58:21','2020-08-10 05:58:21'),(215,'KY','America/Cayman','2020-08-10 05:58:21','2020-08-10 05:58:21'),(216,'KZ','Asia/Almaty','2020-08-10 05:58:21','2020-08-10 05:58:21'),(217,'KZ','Asia/Qyzylorda','2020-08-10 05:58:21','2020-08-10 05:58:21'),(218,'KZ','Asia/Aqtobe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(219,'KZ','Asia/Aqtau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(220,'KZ','Asia/Atyrau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(221,'KZ','Asia/Oral','2020-08-10 05:58:21','2020-08-10 05:58:21'),(222,'LA','Asia/Vientiane','2020-08-10 05:58:21','2020-08-10 05:58:21'),(223,'LB','Asia/Beirut','2020-08-10 05:58:21','2020-08-10 05:58:21'),(224,'LC','America/St_Lucia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(225,'LI','Europe/Vaduz','2020-08-10 05:58:21','2020-08-10 05:58:21'),(226,'LK','Asia/Colombo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(227,'LR','Africa/Monrovia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(228,'LS','Africa/Maseru','2020-08-10 05:58:21','2020-08-10 05:58:21'),(229,'LT','Europe/Vilnius','2020-08-10 05:58:21','2020-08-10 05:58:21'),(230,'LU','Europe/Luxembourg','2020-08-10 05:58:21','2020-08-10 05:58:21'),(231,'LV','Europe/Riga','2020-08-10 05:58:21','2020-08-10 05:58:21'),(232,'LY','Africa/Tripoli','2020-08-10 05:58:21','2020-08-10 05:58:21'),(233,'MA','Africa/Casablanca','2020-08-10 05:58:21','2020-08-10 05:58:21'),(234,'MC','Europe/Monaco','2020-08-10 05:58:21','2020-08-10 05:58:21'),(235,'MD','Europe/Chisinau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(236,'ME','Europe/Podgorica','2020-08-10 05:58:21','2020-08-10 05:58:21'),(237,'MF','America/Marigot','2020-08-10 05:58:21','2020-08-10 05:58:21'),(238,'MG','Indian/Antananarivo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(239,'MH','Pacific/Majuro','2020-08-10 05:58:21','2020-08-10 05:58:21'),(240,'MH','Pacific/Kwajalein','2020-08-10 05:58:21','2020-08-10 05:58:21'),(241,'MK','Europe/Skopje','2020-08-10 05:58:21','2020-08-10 05:58:21'),(242,'ML','Africa/Bamako','2020-08-10 05:58:21','2020-08-10 05:58:21'),(243,'MM','Asia/Yangon','2020-08-10 05:58:21','2020-08-10 05:58:21'),(244,'MN','Asia/Ulaanbaatar','2020-08-10 05:58:21','2020-08-10 05:58:21'),(245,'MN','Asia/Hovd','2020-08-10 05:58:21','2020-08-10 05:58:21'),(246,'MN','Asia/Choibalsan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(247,'MO','Asia/Macau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(248,'MP','Pacific/Saipan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(249,'MQ','America/Martinique','2020-08-10 05:58:21','2020-08-10 05:58:21'),(250,'MR','Africa/Nouakchott','2020-08-10 05:58:21','2020-08-10 05:58:21'),(251,'MS','America/Montserrat','2020-08-10 05:58:21','2020-08-10 05:58:21'),(252,'MT','Europe/Malta','2020-08-10 05:58:21','2020-08-10 05:58:21'),(253,'MU','Indian/Mauritius','2020-08-10 05:58:21','2020-08-10 05:58:21'),(254,'MV','Indian/Maldives','2020-08-10 05:58:21','2020-08-10 05:58:21'),(255,'MW','Africa/Blantyre','2020-08-10 05:58:21','2020-08-10 05:58:21'),(256,'MX','America/Mexico_City','2020-08-10 05:58:21','2020-08-10 05:58:21'),(257,'MX','America/Cancun','2020-08-10 05:58:21','2020-08-10 05:58:21'),(258,'MX','America/Merida','2020-08-10 05:58:21','2020-08-10 05:58:21'),(259,'MX','America/Monterrey','2020-08-10 05:58:21','2020-08-10 05:58:21'),(260,'MX','America/Matamoros','2020-08-10 05:58:21','2020-08-10 05:58:21'),(261,'MX','America/Mazatlan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(262,'MX','America/Chihuahua','2020-08-10 05:58:21','2020-08-10 05:58:21'),(263,'MX','America/Ojinaga','2020-08-10 05:58:21','2020-08-10 05:58:21'),(264,'MX','America/Hermosillo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(265,'MX','America/Tijuana','2020-08-10 05:58:21','2020-08-10 05:58:21'),(266,'MX','America/Bahia_Banderas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(267,'MY','Asia/Kuala_Lumpur','2020-08-10 05:58:21','2020-08-10 05:58:21'),(268,'MY','Asia/Kuching','2020-08-10 05:58:21','2020-08-10 05:58:21'),(269,'MZ','Africa/Maputo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(270,'NA','Africa/Windhoek','2020-08-10 05:58:21','2020-08-10 05:58:21'),(271,'NC','Pacific/Noumea','2020-08-10 05:58:21','2020-08-10 05:58:21'),(272,'NE','Africa/Niamey','2020-08-10 05:58:21','2020-08-10 05:58:21'),(273,'NF','Pacific/Norfolk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(274,'NG','Africa/Lagos','2020-08-10 05:58:21','2020-08-10 05:58:21'),(275,'NI','America/Managua','2020-08-10 05:58:21','2020-08-10 05:58:21'),(276,'NL','Europe/Amsterdam','2020-08-10 05:58:21','2020-08-10 05:58:21'),(277,'NO','Europe/Oslo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(278,'NP','Asia/Kathmandu','2020-08-10 05:58:21','2020-08-10 05:58:21'),(279,'NR','Pacific/Nauru','2020-08-10 05:58:21','2020-08-10 05:58:21'),(280,'NU','Pacific/Niue','2020-08-10 05:58:21','2020-08-10 05:58:21'),(281,'NZ','Pacific/Auckland','2020-08-10 05:58:21','2020-08-10 05:58:21'),(282,'NZ','Pacific/Chatham','2020-08-10 05:58:21','2020-08-10 05:58:21'),(283,'OM','Asia/Muscat','2020-08-10 05:58:21','2020-08-10 05:58:21'),(284,'PA','America/Panama','2020-08-10 05:58:21','2020-08-10 05:58:21'),(285,'PE','America/Lima','2020-08-10 05:58:21','2020-08-10 05:58:21'),(286,'PF','Pacific/Tahiti','2020-08-10 05:58:21','2020-08-10 05:58:21'),(287,'PF','Pacific/Marquesas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(288,'PF','Pacific/Gambier','2020-08-10 05:58:21','2020-08-10 05:58:21'),(289,'PG','Pacific/Port_Moresby','2020-08-10 05:58:21','2020-08-10 05:58:21'),(290,'PG','Pacific/Bougainville','2020-08-10 05:58:21','2020-08-10 05:58:21'),(291,'PH','Asia/Manila','2020-08-10 05:58:21','2020-08-10 05:58:21'),(292,'PK','Asia/Karachi','2020-08-10 05:58:21','2020-08-10 05:58:21'),(293,'PL','Europe/Warsaw','2020-08-10 05:58:21','2020-08-10 05:58:21'),(294,'PM','America/Miquelon','2020-08-10 05:58:21','2020-08-10 05:58:21'),(295,'PN','Pacific/Pitcairn','2020-08-10 05:58:21','2020-08-10 05:58:21'),(296,'PR','America/Puerto_Rico','2020-08-10 05:58:21','2020-08-10 05:58:21'),(297,'PS','Asia/Gaza','2020-08-10 05:58:21','2020-08-10 05:58:21'),(298,'PS','Asia/Hebron','2020-08-10 05:58:21','2020-08-10 05:58:21'),(299,'PT','Europe/Lisbon','2020-08-10 05:58:21','2020-08-10 05:58:21'),(300,'PT','Atlantic/Madeira','2020-08-10 05:58:21','2020-08-10 05:58:21'),(301,'PT','Atlantic/Azores','2020-08-10 05:58:21','2020-08-10 05:58:21'),(302,'PW','Pacific/Palau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(303,'PY','America/Asuncion','2020-08-10 05:58:21','2020-08-10 05:58:21'),(304,'QA','Asia/Qatar','2020-08-10 05:58:21','2020-08-10 05:58:21'),(305,'RE','Indian/Reunion','2020-08-10 05:58:21','2020-08-10 05:58:21'),(306,'RO','Europe/Bucharest','2020-08-10 05:58:21','2020-08-10 05:58:21'),(307,'RS','Europe/Belgrade','2020-08-10 05:58:21','2020-08-10 05:58:21'),(308,'RU','Europe/Kaliningrad','2020-08-10 05:58:21','2020-08-10 05:58:21'),(309,'RU','Europe/Moscow','2020-08-10 05:58:21','2020-08-10 05:58:21'),(310,'RU','Europe/Simferopol','2020-08-10 05:58:21','2020-08-10 05:58:21'),(311,'RU','Europe/Volgograd','2020-08-10 05:58:21','2020-08-10 05:58:21'),(312,'RU','Europe/Kirov','2020-08-10 05:58:21','2020-08-10 05:58:21'),(313,'RU','Europe/Astrakhan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(314,'RU','Europe/Saratov','2020-08-10 05:58:21','2020-08-10 05:58:21'),(315,'RU','Europe/Ulyanovsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(316,'RU','Europe/Samara','2020-08-10 05:58:21','2020-08-10 05:58:21'),(317,'RU','Asia/Yekaterinburg','2020-08-10 05:58:21','2020-08-10 05:58:21'),(318,'RU','Asia/Omsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(319,'RU','Asia/Novosibirsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(320,'RU','Asia/Barnaul','2020-08-10 05:58:21','2020-08-10 05:58:21'),(321,'RU','Asia/Tomsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(322,'RU','Asia/Novokuznetsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(323,'RU','Asia/Krasnoyarsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(324,'RU','Asia/Irkutsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(325,'RU','Asia/Chita','2020-08-10 05:58:21','2020-08-10 05:58:21'),(326,'RU','Asia/Yakutsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(327,'RU','Asia/Khandyga','2020-08-10 05:58:21','2020-08-10 05:58:21'),(328,'RU','Asia/Vladivostok','2020-08-10 05:58:21','2020-08-10 05:58:21'),(329,'RU','Asia/Ust-Nera','2020-08-10 05:58:21','2020-08-10 05:58:21'),(330,'RU','Asia/Magadan','2020-08-10 05:58:21','2020-08-10 05:58:21'),(331,'RU','Asia/Sakhalin','2020-08-10 05:58:21','2020-08-10 05:58:21'),(332,'RU','Asia/Srednekolymsk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(333,'RU','Asia/Kamchatka','2020-08-10 05:58:21','2020-08-10 05:58:21'),(334,'RU','Asia/Anadyr','2020-08-10 05:58:21','2020-08-10 05:58:21'),(335,'RW','Africa/Kigali','2020-08-10 05:58:21','2020-08-10 05:58:21'),(336,'SA','Asia/Riyadh','2020-08-10 05:58:21','2020-08-10 05:58:21'),(337,'SB','Pacific/Guadalcanal','2020-08-10 05:58:21','2020-08-10 05:58:21'),(338,'SC','Indian/Mahe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(339,'SD','Africa/Khartoum','2020-08-10 05:58:21','2020-08-10 05:58:21'),(340,'SE','Europe/Stockholm','2020-08-10 05:58:21','2020-08-10 05:58:21'),(341,'SG','Asia/Singapore','2020-08-10 05:58:21','2020-08-10 05:58:21'),(342,'SH','Atlantic/St_Helena','2020-08-10 05:58:21','2020-08-10 05:58:21'),(343,'SI','Europe/Ljubljana','2020-08-10 05:58:21','2020-08-10 05:58:21'),(344,'SJ','Arctic/Longyearbyen','2020-08-10 05:58:21','2020-08-10 05:58:21'),(345,'SK','Europe/Bratislava','2020-08-10 05:58:21','2020-08-10 05:58:21'),(346,'SL','Africa/Freetown','2020-08-10 05:58:21','2020-08-10 05:58:21'),(347,'SM','Europe/San_Marino','2020-08-10 05:58:21','2020-08-10 05:58:21'),(348,'SN','Africa/Dakar','2020-08-10 05:58:21','2020-08-10 05:58:21'),(349,'SO','Africa/Mogadishu','2020-08-10 05:58:21','2020-08-10 05:58:21'),(350,'SR','America/Paramaribo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(351,'SS','Africa/Juba','2020-08-10 05:58:21','2020-08-10 05:58:21'),(352,'ST','Africa/Sao_Tome','2020-08-10 05:58:21','2020-08-10 05:58:21'),(353,'SV','America/El_Salvador','2020-08-10 05:58:21','2020-08-10 05:58:21'),(354,'SX','America/Lower_Princes','2020-08-10 05:58:21','2020-08-10 05:58:21'),(355,'SY','Asia/Damascus','2020-08-10 05:58:21','2020-08-10 05:58:21'),(356,'SZ','Africa/Mbabane','2020-08-10 05:58:21','2020-08-10 05:58:21'),(357,'TC','America/Grand_Turk','2020-08-10 05:58:21','2020-08-10 05:58:21'),(358,'TD','Africa/Ndjamena','2020-08-10 05:58:21','2020-08-10 05:58:21'),(359,'TF','Indian/Kerguelen','2020-08-10 05:58:21','2020-08-10 05:58:21'),(360,'TG','Africa/Lome','2020-08-10 05:58:21','2020-08-10 05:58:21'),(361,'TH','Asia/Bangkok','2020-08-10 05:58:21','2020-08-10 05:58:21'),(362,'TJ','Asia/Dushanbe','2020-08-10 05:58:21','2020-08-10 05:58:21'),(363,'TK','Pacific/Fakaofo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(364,'TL','Asia/Dili','2020-08-10 05:58:21','2020-08-10 05:58:21'),(365,'TM','Asia/Ashgabat','2020-08-10 05:58:21','2020-08-10 05:58:21'),(366,'TN','Africa/Tunis','2020-08-10 05:58:21','2020-08-10 05:58:21'),(367,'TO','Pacific/Tongatapu','2020-08-10 05:58:21','2020-08-10 05:58:21'),(368,'TR','Europe/Istanbul','2020-08-10 05:58:21','2020-08-10 05:58:21'),(369,'TT','America/Port_of_Spain','2020-08-10 05:58:21','2020-08-10 05:58:21'),(370,'TV','Pacific/Funafuti','2020-08-10 05:58:21','2020-08-10 05:58:21'),(371,'TW','Asia/Taipei','2020-08-10 05:58:21','2020-08-10 05:58:21'),(372,'TZ','Africa/Dar_es_Salaam','2020-08-10 05:58:21','2020-08-10 05:58:21'),(373,'UA','Europe/Kiev','2020-08-10 05:58:21','2020-08-10 05:58:21'),(374,'UA','Europe/Uzhgorod','2020-08-10 05:58:21','2020-08-10 05:58:21'),(375,'UA','Europe/Zaporozhye','2020-08-10 05:58:21','2020-08-10 05:58:21'),(376,'UG','Africa/Kampala','2020-08-10 05:58:21','2020-08-10 05:58:21'),(377,'UM','Pacific/Midway','2020-08-10 05:58:21','2020-08-10 05:58:21'),(378,'UM','Pacific/Wake','2020-08-10 05:58:21','2020-08-10 05:58:21'),(379,'US','America/New_York','2020-08-10 05:58:21','2020-08-10 05:58:21'),(380,'US','America/Detroit','2020-08-10 05:58:21','2020-08-10 05:58:21'),(381,'US','America/Kentucky/Louisville','2020-08-10 05:58:21','2020-08-10 05:58:21'),(382,'US','America/Kentucky/Monticello','2020-08-10 05:58:21','2020-08-10 05:58:21'),(383,'US','America/Indiana/Indianapolis','2020-08-10 05:58:21','2020-08-10 05:58:21'),(384,'US','America/Indiana/Vincennes','2020-08-10 05:58:21','2020-08-10 05:58:21'),(385,'US','America/Indiana/Winamac','2020-08-10 05:58:21','2020-08-10 05:58:21'),(386,'US','America/Indiana/Marengo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(387,'US','America/Indiana/Petersburg','2020-08-10 05:58:21','2020-08-10 05:58:21'),(388,'US','America/Indiana/Vevay','2020-08-10 05:58:21','2020-08-10 05:58:21'),(389,'US','America/Chicago','2020-08-10 05:58:21','2020-08-10 05:58:21'),(390,'US','America/Indiana/Tell_City','2020-08-10 05:58:21','2020-08-10 05:58:21'),(391,'US','America/Indiana/Knox','2020-08-10 05:58:21','2020-08-10 05:58:21'),(392,'US','America/Menominee','2020-08-10 05:58:21','2020-08-10 05:58:21'),(393,'US','America/North_Dakota/Center','2020-08-10 05:58:21','2020-08-10 05:58:21'),(394,'US','America/North_Dakota/New_Salem','2020-08-10 05:58:21','2020-08-10 05:58:21'),(395,'US','America/North_Dakota/Beulah','2020-08-10 05:58:21','2020-08-10 05:58:21'),(396,'US','America/Denver','2020-08-10 05:58:21','2020-08-10 05:58:21'),(397,'US','America/Boise','2020-08-10 05:58:21','2020-08-10 05:58:21'),(398,'US','America/Phoenix','2020-08-10 05:58:21','2020-08-10 05:58:21'),(399,'US','America/Los_Angeles','2020-08-10 05:58:21','2020-08-10 05:58:21'),(400,'US','America/Anchorage','2020-08-10 05:58:21','2020-08-10 05:58:21'),(401,'US','America/Juneau','2020-08-10 05:58:21','2020-08-10 05:58:21'),(402,'US','America/Sitka','2020-08-10 05:58:21','2020-08-10 05:58:21'),(403,'US','America/Metlakatla','2020-08-10 05:58:21','2020-08-10 05:58:21'),(404,'US','America/Yakutat','2020-08-10 05:58:21','2020-08-10 05:58:21'),(405,'US','America/Nome','2020-08-10 05:58:21','2020-08-10 05:58:21'),(406,'US','America/Adak','2020-08-10 05:58:21','2020-08-10 05:58:21'),(407,'US','Pacific/Honolulu','2020-08-10 05:58:21','2020-08-10 05:58:21'),(408,'UY','America/Montevideo','2020-08-10 05:58:21','2020-08-10 05:58:21'),(409,'UZ','Asia/Samarkand','2020-08-10 05:58:21','2020-08-10 05:58:21'),(410,'UZ','Asia/Tashkent','2020-08-10 05:58:21','2020-08-10 05:58:21'),(411,'VA','Europe/Vatican','2020-08-10 05:58:21','2020-08-10 05:58:21'),(412,'VC','America/St_Vincent','2020-08-10 05:58:21','2020-08-10 05:58:21'),(413,'VE','America/Caracas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(414,'VG','America/Tortola','2020-08-10 05:58:21','2020-08-10 05:58:21'),(415,'VI','America/St_Thomas','2020-08-10 05:58:21','2020-08-10 05:58:21'),(416,'VN','Asia/Ho_Chi_Minh','2020-08-10 05:58:21','2020-08-10 05:58:21'),(417,'VU','Pacific/Efate','2020-08-10 05:58:21','2020-08-10 05:58:21'),(418,'WF','Pacific/Wallis','2020-08-10 05:58:21','2020-08-10 05:58:21'),(419,'WS','Pacific/Apia','2020-08-10 05:58:21','2020-08-10 05:58:21'),(420,'YE','Asia/Aden','2020-08-10 05:58:21','2020-08-10 05:58:21'),(421,'YT','Indian/Mayotte','2020-08-10 05:58:21','2020-08-10 05:58:21'),(422,'ZA','Africa/Johannesburg','2020-08-10 05:58:21','2020-08-10 05:58:21'),(423,'ZM','Africa/Lusaka','2020-08-10 05:58:21','2020-08-10 05:58:21'),(424,'ZW','Africa/Harare','2020-08-10 05:58:21','2020-08-10 05:58:21');
/*!40000 ALTER TABLE `sm_time_zones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_to_dos`
--

DROP TABLE IF EXISTS `sm_to_dos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_to_dos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `todo_title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `complete_status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT 'P' COMMENT 'C for complete, N for not Complete, P Pending',
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_to_dos_school_id_foreign` (`school_id`),
  KEY `sm_to_dos_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_to_dos_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_to_dos_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_to_dos`
--

LOCK TABLES `sm_to_dos` WRITE;
/*!40000 ALTER TABLE `sm_to_dos` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_to_dos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_upload_contents`
--

DROP TABLE IF EXISTS `sm_upload_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_upload_contents` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_type` int(11) DEFAULT NULL,
  `available_for_role` int(11) DEFAULT NULL,
  `available_for_class` int(11) DEFAULT NULL,
  `available_for_section` int(11) DEFAULT NULL,
  `upload_date` date DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_file` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_upload_contents_school_id_foreign` (`school_id`),
  KEY `sm_upload_contents_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_upload_contents_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_upload_contents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_upload_contents`
--

LOCK TABLES `sm_upload_contents` WRITE;
/*!40000 ALTER TABLE `sm_upload_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_upload_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_upload_homework_contents`
--

DROP TABLE IF EXISTS `sm_upload_homework_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_upload_homework_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` int(10) unsigned DEFAULT '1',
  `homework_id` int(10) unsigned DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `file` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_upload_homework_contents_student_id_foreign` (`student_id`),
  KEY `sm_upload_homework_contents_homework_id_foreign` (`homework_id`),
  KEY `sm_upload_homework_contents_school_id_foreign` (`school_id`),
  KEY `sm_upload_homework_contents_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_upload_homework_contents_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_upload_homework_contents_homework_id_foreign` FOREIGN KEY (`homework_id`) REFERENCES `sm_homeworks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_upload_homework_contents_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_upload_homework_contents_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `sm_students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_upload_homework_contents`
--

LOCK TABLES `sm_upload_homework_contents` WRITE;
/*!40000 ALTER TABLE `sm_upload_homework_contents` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_upload_homework_contents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_user_logs`
--

DROP TABLE IF EXISTS `sm_user_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_user_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `role_id` int(10) unsigned DEFAULT NULL,
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_user_logs_user_id_foreign` (`user_id`),
  KEY `sm_user_logs_role_id_foreign` (`role_id`),
  KEY `sm_user_logs_school_id_foreign` (`school_id`),
  KEY `sm_user_logs_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_user_logs_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_user_logs_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `infix_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_user_logs_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_user_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_user_logs`
--

LOCK TABLES `sm_user_logs` WRITE;
/*!40000 ALTER TABLE `sm_user_logs` DISABLE KEYS */;
INSERT INTO `sm_user_logs` VALUES (1,'185.211.131.2','Chrome, Windows','2020-08-10 05:59:15','2020-08-10 05:59:15',1,1,1,1),(2,'185.211.131.2','Chrome, Windows','2020-08-10 07:44:20','2020-08-10 07:44:20',1,1,1,1),(3,'185.211.131.2','Chrome, Windows','2020-08-10 08:29:48','2020-08-10 08:29:48',1,1,1,1),(4,'185.139.136.225','Safari, OS X','2020-08-10 08:35:53','2020-08-10 08:35:53',1,1,1,1),(5,'185.139.136.225','Safari, OS X','2020-08-10 09:15:44','2020-08-10 09:15:44',1,1,1,1),(6,'81.95.230.20','Chrome, Windows','2020-08-11 01:10:11','2020-08-11 01:10:11',1,1,1,1),(7,'185.139.136.225','Safari, OS X','2020-08-12 02:40:47','2020-08-12 02:40:47',1,1,1,1),(8,'185.139.136.225','Safari, OS X','2020-08-12 02:44:10','2020-08-12 02:44:10',3,3,1,1),(9,'185.139.136.225','Safari, OS X','2020-08-12 02:45:08','2020-08-12 02:45:08',1,1,1,1),(10,'185.139.136.225','Safari, OS X','2020-08-12 02:50:28','2020-08-12 02:50:28',2,2,1,1),(11,'185.139.136.225','Safari, OS X','2020-08-12 02:51:01','2020-08-12 02:51:01',1,1,1,1),(12,'109.207.255.29','Chrome, Windows','2020-08-14 04:52:05','2020-08-14 04:52:05',1,1,1,1),(13,'109.207.255.29','Chrome, Windows','2020-08-14 04:56:05','2020-08-14 04:56:05',1,1,1,1),(14,'92.38.29.251','Chrome, Windows','2020-08-16 06:13:18','2020-08-16 06:13:18',1,1,1,1),(15,'81.95.230.20','Chrome, Windows','2020-08-19 09:14:31','2020-08-19 09:14:31',1,1,1,1),(16,'185.211.131.2','Chrome, Windows','2020-08-20 00:21:25','2020-08-20 00:21:25',3,3,1,1),(17,'185.211.131.2','Chrome, Windows','2020-08-20 00:21:58','2020-08-20 00:21:58',2,2,1,1),(18,'185.211.131.2','Chrome, Windows','2020-08-20 00:25:35','2020-08-20 00:25:35',3,3,1,1),(19,'81.95.230.20','Opera, Windows','2020-08-20 08:12:32','2020-08-20 08:12:32',1,1,1,1),(20,'81.95.230.20','Chrome, Windows','2020-08-20 08:12:57','2020-08-20 08:12:57',1,1,1,1),(21,'81.95.230.20','Chrome, OS X','2020-08-20 08:12:57','2020-08-20 08:12:57',1,1,1,1),(22,'185.139.137.184','Chrome, Windows','2020-08-20 08:13:10','2020-08-20 08:13:10',1,1,1,1),(23,'81.95.230.20','Chrome, Windows','2020-08-20 08:13:25','2020-08-20 08:13:25',1,1,1,1),(24,'81.95.230.20','Opera, Windows','2020-08-20 08:13:45','2020-08-20 08:13:45',2,2,1,1),(25,'81.95.230.20','Chrome, OS X','2020-08-20 08:13:50','2020-08-20 08:13:50',2,2,1,1),(26,'81.95.230.20','Chrome, Windows','2020-08-20 08:13:58','2020-08-20 08:13:58',2,2,1,1),(27,'81.95.230.20','Chrome, Windows','2020-08-20 08:14:07','2020-08-20 08:14:07',2,2,1,1),(28,'81.95.230.20','Chrome, Windows','2020-08-20 08:16:29','2020-08-20 08:16:29',2,2,1,1),(29,'81.95.230.20','Chrome, Windows','2020-08-20 08:26:32','2020-08-20 08:26:32',1,1,1,1),(30,'81.95.230.20','Chrome, Windows','2020-08-20 09:08:55','2020-08-20 09:08:55',1,1,1,1),(31,'81.95.230.20','Chrome, Windows','2020-08-20 09:12:50','2020-08-20 09:12:50',1,1,1,1),(32,'81.95.230.20','Chrome, Windows','2020-08-25 00:22:58','2020-08-25 00:22:58',1,1,1,1),(33,'81.95.230.20','Chrome, Windows','2020-08-25 00:33:13','2020-08-25 00:33:13',2,2,1,1),(34,'185.211.131.2','Chrome, Windows','2020-08-25 08:46:58','2020-08-25 08:46:58',1,1,1,1),(35,'185.211.131.2','Chrome, Windows','2020-08-25 08:54:27','2020-08-25 08:54:27',2,2,1,1),(36,'185.139.136.246','Safari, OS X','2020-08-26 03:50:32','2020-08-26 03:50:32',1,1,1,1),(37,'213.230.72.166','Chrome, AndroidOS','2020-08-26 04:45:47','2020-08-26 04:45:47',1,1,1,1),(38,'80.80.212.170','Chrome, Windows','2020-08-27 01:15:15','2020-08-27 01:15:15',1,1,1,1),(39,'185.139.136.225','Safari, OS X','2020-08-27 02:15:35','2020-08-27 02:15:35',1,1,1,1),(40,'188.113.207.204','Chrome, Windows','2020-08-27 03:35:02','2020-08-27 03:35:02',1,1,1,1),(41,'185.139.136.225','Chrome, OS X','2020-08-27 03:55:18','2020-08-27 03:55:18',2,2,1,1),(42,'31.148.162.164','Chrome, Windows','2020-08-27 08:06:02','2020-08-27 08:06:02',1,1,1,1),(43,'31.148.162.164','Chrome, Windows','2020-08-27 08:06:34','2020-08-27 08:06:34',2,2,1,1),(44,'185.139.136.225','Safari, OS X','2020-08-27 12:17:45','2020-08-27 12:17:45',2,2,1,1),(45,'31.148.166.111','Chrome, Windows','2020-08-27 22:48:31','2020-08-27 22:48:31',2,2,1,1),(46,'31.148.166.111','Chrome, Windows','2020-08-27 22:55:23','2020-08-27 22:55:23',1,1,1,1),(47,'172.28.0.1','Firefox, Ubuntu','2020-08-29 06:07:27','2020-08-29 06:07:27',2,2,1,1),(48,'172.28.0.1','Firefox, Ubuntu','2020-08-29 06:17:44','2020-08-29 06:17:44',2,2,1,1),(49,'172.28.0.1','Firefox, Ubuntu','2020-08-29 09:56:33','2020-08-29 09:56:33',2,2,1,1),(50,'172.28.0.1','Firefox, Ubuntu','2020-08-29 16:41:37','2020-08-29 16:41:37',2,2,1,1),(51,'172.28.0.1','Firefox, Ubuntu','2020-08-29 16:43:23','2020-08-29 16:43:23',1,1,1,1),(52,'172.28.0.1','Firefox, Ubuntu','2020-08-30 05:58:49','2020-08-30 05:58:49',2,2,1,1),(53,'172.28.0.1','Firefox, Ubuntu','2020-09-02 16:35:10','2020-09-02 16:35:10',2,2,1,1),(54,'172.28.0.1','Firefox, Ubuntu','2020-09-02 17:10:11','2020-09-02 17:10:11',1,1,1,1),(55,'172.22.0.1','Firefox, Ubuntu','2020-09-04 02:26:04','2020-09-04 02:26:04',1,1,1,1),(56,'172.22.0.1','Firefox, Ubuntu','2020-09-04 02:46:17','2020-09-04 02:46:17',2,2,1,1),(57,'172.22.0.1','Firefox, Ubuntu','2020-09-05 05:45:43','2020-09-05 05:45:43',1,1,1,1),(58,'172.22.0.1','Firefox, Ubuntu','2020-09-05 11:21:53','2020-09-05 11:21:53',1,1,1,1),(59,'172.22.0.1','Firefox, Ubuntu','2020-09-06 06:28:25','2020-09-06 06:28:25',1,1,1,1),(60,'172.22.0.1','Firefox, Ubuntu','2020-09-06 12:29:46','2020-09-06 12:29:46',1,1,1,1),(61,'172.22.0.1','Firefox, Ubuntu','2020-09-06 22:36:02','2020-09-06 22:36:02',1,1,1,1),(62,'127.0.0.1','Safari, OS X','2020-09-09 12:20:03','2020-09-09 12:20:03',1,1,1,1),(63,'127.0.0.1','Chrome, OS X','2020-09-09 16:33:29','2020-09-09 16:33:29',1,1,1,1),(64,'127.0.0.1','Safari, OS X','2020-09-10 02:54:48','2020-09-10 02:54:48',1,1,1,1),(65,'127.0.0.1','Chrome, OS X','2020-09-10 02:57:56','2020-09-10 02:57:56',1,1,1,1),(66,'127.0.0.1','Safari, OS X','2020-09-10 11:08:07','2020-09-10 11:08:07',1,1,1,1),(67,'127.0.0.1','Chrome, OS X','2020-09-10 11:12:32','2020-09-10 11:12:32',1,1,1,1),(68,'127.0.0.1','Chrome, OS X','2020-09-10 19:12:17','2020-09-10 19:12:17',1,1,1,1),(69,'172.18.0.1','Chrome, Linux','2020-09-14 07:31:41','2020-09-14 07:31:41',1,1,1,1),(70,'172.18.0.1','Chrome, Linux','2020-09-14 17:16:34','2020-09-14 17:16:34',1,1,1,1),(71,'172.18.0.1','Chrome, Linux','2020-09-15 01:30:34','2020-09-15 01:30:34',1,1,1,1),(72,'172.18.0.1','Chrome, Linux','2020-09-15 04:08:18','2020-09-15 04:08:18',1,1,1,1),(73,'172.18.0.1','Chrome, Linux','2020-09-15 08:36:15','2020-09-15 08:36:15',2,2,1,1);
/*!40000 ALTER TABLE `sm_user_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_vehicles`
--

DROP TABLE IF EXISTS `sm_vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_vehicles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle_model` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `made_year` int(11) DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `driver_id` int(10) unsigned DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_vehicles_school_id_foreign` (`school_id`),
  KEY `sm_vehicles_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_vehicles_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_vehicles_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_vehicles`
--

LOCK TABLES `sm_vehicles` WRITE;
/*!40000 ALTER TABLE `sm_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_visitors`
--

DROP TABLE IF EXISTS `sm_visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_visitors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visitor_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_of_person` int(11) DEFAULT NULL,
  `purpose` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `in_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `out_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(10) unsigned DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_visitors_school_id_foreign` (`school_id`),
  KEY `sm_visitors_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_visitors_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_visitors_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_visitors`
--

LOCK TABLES `sm_visitors` WRITE;
/*!40000 ALTER TABLE `sm_visitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `sm_visitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sm_weekends`
--

DROP TABLE IF EXISTS `sm_weekends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sm_weekends` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `is_weekend` int(11) DEFAULT NULL,
  `active_status` int(11) NOT NULL DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `academic_id` int(10) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `sm_weekends_school_id_foreign` (`school_id`),
  KEY `sm_weekends_academic_id_foreign` (`academic_id`),
  CONSTRAINT `sm_weekends_academic_id_foreign` FOREIGN KEY (`academic_id`) REFERENCES `sm_academic_years` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sm_weekends_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sm_weekends`
--

LOCK TABLES `sm_weekends` WRITE;
/*!40000 ALTER TABLE `sm_weekends` DISABLE KEYS */;
INSERT INTO `sm_weekends` VALUES (1,'Saturday',1,1,1,1,'2020-08-10 10:58:19','2020-09-13 09:36:55',1),(2,'Sunday',2,1,1,1,'2020-08-10 10:58:19','2020-09-13 09:37:26',1),(3,'Monday',3,0,1,1,'2020-08-10 10:58:19','2020-08-10 10:58:19',1),(4,'Tuesday',4,0,1,1,'2020-08-10 10:58:19','2020-08-10 10:58:19',1),(5,'Wednesday',5,0,1,1,'2020-08-10 10:58:19','2020-08-10 10:58:19',1),(6,'Thursday',6,0,1,1,'2020-08-10 10:58:19','2020-08-10 10:58:19',1),(7,'Friday',7,0,1,1,'2020-08-10 10:58:19','2020-09-13 09:36:41',1);
/*!40000 ALTER TABLE `sm_weekends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_templates`
--

DROP TABLE IF EXISTS `sms_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admission_pro` longtext COLLATE utf8mb4_unicode_ci,
  `student_admit` longtext COLLATE utf8mb4_unicode_ci,
  `login_disable` longtext COLLATE utf8mb4_unicode_ci,
  `exam_schedule` longtext COLLATE utf8mb4_unicode_ci,
  `exam_publish` longtext COLLATE utf8mb4_unicode_ci,
  `due_fees` longtext COLLATE utf8mb4_unicode_ci,
  `collect_fees` longtext COLLATE utf8mb4_unicode_ci,
  `stu_promote` longtext COLLATE utf8mb4_unicode_ci,
  `attendance_sms` longtext COLLATE utf8mb4_unicode_ci,
  `absent` longtext COLLATE utf8mb4_unicode_ci,
  `late_sms` longtext COLLATE utf8mb4_unicode_ci,
  `er_checkout` longtext COLLATE utf8mb4_unicode_ci,
  `st_checkout` longtext COLLATE utf8mb4_unicode_ci,
  `st_credentials` longtext COLLATE utf8mb4_unicode_ci,
  `staff_credentials` longtext COLLATE utf8mb4_unicode_ci,
  `holiday` longtext COLLATE utf8mb4_unicode_ci,
  `leave_app` longtext COLLATE utf8mb4_unicode_ci,
  `approve_sms` longtext COLLATE utf8mb4_unicode_ci,
  `birth_st` longtext COLLATE utf8mb4_unicode_ci,
  `birth_staff` longtext COLLATE utf8mb4_unicode_ci,
  `cheque_bounce` longtext COLLATE utf8mb4_unicode_ci,
  `l_issue_b` longtext COLLATE utf8mb4_unicode_ci,
  `re_issue_book` longtext COLLATE utf8mb4_unicode_ci,
  `sms_text` longtext COLLATE utf8mb4_unicode_ci,
  `student_approve_message_sms` longtext COLLATE utf8mb4_unicode_ci,
  `student_approve_message_sms_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1 enable, 3 disable',
  `student_registration_message_sms` longtext COLLATE utf8mb4_unicode_ci,
  `student_registration_message_sms_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1 enable, 3 disable',
  `student_admission_message_sms` longtext COLLATE utf8mb4_unicode_ci,
  `student_admission_message_sms_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1 enable, 3 disable',
  `exam_schedule_message_sms` longtext COLLATE utf8mb4_unicode_ci,
  `exam_schedule_message_sms_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1 enable, 3 disable',
  `dues_fees_message_sms` longtext COLLATE utf8mb4_unicode_ci,
  `dues_fees_message_sms_status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1 enable, 3 disable',
  `password_reset_message` longtext COLLATE utf8mb4_unicode_ci,
  `student_login_credential_message` longtext COLLATE utf8mb4_unicode_ci,
  `guardian_login_credential_message` longtext COLLATE utf8mb4_unicode_ci,
  `student_registration_message` longtext COLLATE utf8mb4_unicode_ci,
  `guardian_registration_message` longtext COLLATE utf8mb4_unicode_ci,
  `staff_login_credential_message` longtext COLLATE utf8mb4_unicode_ci,
  `send_email_message` longtext COLLATE utf8mb4_unicode_ci,
  `dues_payment_message` longtext COLLATE utf8mb4_unicode_ci,
  `email_footer_text` longtext COLLATE utf8mb4_unicode_ci,
  `active_status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_templates`
--

LOCK TABLES `sms_templates` WRITE;
/*!40000 ALTER TABLE `sms_templates` DISABLE KEYS */;
INSERT INTO `sms_templates` VALUES (1,'Dear parent |ParentName|, your child |StudentName| admission is in process.','Dear parent |ParentName|, your child |StudentName| admission is completed You can login to your account using username:|Username| Password:|Password|','hello world','hello world','hello world','Fee Due Reminder for your child |StudentName|. \r\n                                Dear Parent |ParentName|, please find the below fee summary.\r\n                                Fee: Rs.|Fee|, Back dues \r\n                                Adjustment: Rs.|Adjustment|, \r\n                                Total: Rs.|Total|, \r\n                                Paid: Rs.|Paid|, \r\n                                Balance: Rs.|Balance|. \r\n                                Please ignore in case already paid.','Fee Due Reminder for your child |StudentName|. \r\n                                Dear Parent |ParentName|, please find the below fee summary.\r\n                                Fee: Rs.|Fee|, Back dues \r\n                                Adjustment: Rs.|Adjustment|, \r\n                                Total: Rs.|Total|, \r\n                                Paid: Rs.|Paid|, \r\n                                Balance: Rs.|Balance|. \r\n                                Please ignore in case already paid.','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have promoted in the next class.','Dear Parent |ParentName|, your child |StudentName| came to the school at |time|','Dear parent |ParentName|, your child |StudentName| is absent to the school on |AttendanceDate|','Dear parent |ParentName|, your child |StudentName| is late to the school on |AttendanceDate|','Dear parent |ParentName|, your child |StudentName| is checkout  at |time| to the school on |AttendanceDate|','Dear Parent |ParentName|, your child |StudentName| left the school at |time|','Dear parent |ParentName|, your child |StudentName| login details: username:|Username| Password:|Password|','Dear staff |StaffName| your login details: username:|Username| Password:|Password|','This is to update you that |HolidayDate| is holiday due to |HolidayName|','Dear staff |StaffName|, Thank you for your leave application. Please wait for approval. Thanks ','Dear staff |StaffName|, Thank you for your leave application. Your leave approved. Thanks ','Dear parent |ParentName|, Warm wishes to your child  |StudentName| on behalf of his/her birthday','Dear staff |StaffName|, Warm wishes to your birthday. Happy Birthday. Thanks','Dear parent |ParentName|, the Cheque with no :|ChequeNo| for Rs.|FeePaid| received towards fee payment for your child :|StudentName| with receipt number:|ReceiptNo| has been Bounced','Dear parent |ParentName|, Library book  is issued to your child |StudentName| studying in class: |ClassName| , section: |SectionName| with roll no:|RollNo| On |IssueDate| .Please find the details , Book Title: |BookTitle|, Book No: |BookNo|, Due Date: |DueDate|','Dear parent |ParentName|, Library book  is returned by your child |StudentName| studying in class: |ClassName| , section: |SectionName| with roll no:|RollNo| On |ReturnDate| .Please find the details , Book Title: |BookTitle|, Book No: |BookNo|, Issue Date: |IssueDate|, Due Date: |DueDate|','hello world','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','1','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','1','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','1','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','1','Hi [student_name], You fees due amount [dues_amount] for [fees_name] on [date]. Thanks','1','Hi [name], Tap the button below to reset your account password. If you didnt request a new password, you can safely delete this email.','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [father_name]  , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [student_name] , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [father_name]  , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [father_name]  , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [father_name]  , Welcome to [school_name]. Congratulations ! You have registered successfully. Please login using this username [username] and password [password]. Thanks.','Hi [student_name], You fees due amount [dues_amount] for [fees_name] on [date]. Thanks','Copyright &copy; 2020 All rights reserved | This template is made by Codethemes',1,NULL,NULL);
/*!40000 ALTER TABLE `sms_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_attendance_bulks`
--

DROP TABLE IF EXISTS `student_attendance_bulks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_attendance_bulks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `attendance_date` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attendance_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_attendance_bulks`
--

LOCK TABLES `student_attendance_bulks` WRITE;
/*!40000 ALTER TABLE `student_attendance_bulks` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_attendance_bulks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_bulk_temporaries`
--

DROP TABLE IF EXISTS `student_bulk_temporaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_bulk_temporaries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `admission_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roll_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `religion` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `caste` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admission_date` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_group` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `height` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weight` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `father_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mother_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_relation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_occupation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `guardian_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permanent_address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_identification_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `local_identification_no` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `previous_school_details` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_bulk_temporaries`
--

LOCK TABLES `student_bulk_temporaries` WRITE;
/*!40000 ALTER TABLE `student_bulk_temporaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_bulk_temporaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usertype` varchar(210) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(4) NOT NULL DEFAULT '1',
  `random_code` text COLLATE utf8mb4_unicode_ci,
  `notificationToken` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT '1',
  `updated_by` int(11) DEFAULT '1',
  `access_status` int(11) DEFAULT '1',
  `school_id` int(10) unsigned DEFAULT '1',
  `role_id` int(10) unsigned DEFAULT NULL,
  `is_administrator` enum('yes','no') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'no',
  `is_registered` tinyint(4) NOT NULL DEFAULT '0',
  `stripe_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `verified` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_school_id_foreign` (`school_id`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `infix_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_school_id_foreign` FOREIGN KEY (`school_id`) REFERENCES `sm_schools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'System Administrator','t.rakhmonov97@gmail.com','t.rakhmonov97@gmail.com','$2y$10$t7TsPb6ZxUtDqSZ4KmFg4u2Cj6VmfJouZlE1.w61GeD/C3MS17/Hq',NULL,1,NULL,NULL,NULL,'2020-08-10 05:58:14','2020-08-10 05:58:22',1,1,1,1,1,'yes',0,NULL,NULL,NULL,NULL,NULL),(2,'Abbos Qosim ','1','abbosibnqosim@gmail.com','$2y$10$sh5UL7m2wRVE00MKitATb.50Ya/A6ebLusKothT2/iF7VzNJ/WkhS',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-12 02:49:56',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(3,'','someguardian@gmail.com','someguardian@gmail.com','$2y$10$HOXVdHQud4KL9vNWs2tFFuIveLmRKgJ8mlj8dhvq8aDLltBCtV79.',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-12 02:49:56',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(4,'Tolib Bro Rakhmonov','2','','$2y$10$pGdv/MgUIxx9OUhhGa6Gluuy8fbJ7V0RqjaOqSyCCCM2pI1QGgOcS',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-12 02:47:56',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(5,'','someguardian1@gmail.com','someguardian1@gmail.com','$2y$10$VOO00UDEueHxlrZ8pPL5UuAe7eygkCHRrBtD9j0BNRbRFSemY3XOa',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-12 02:47:56',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(6,'Azam Djurabaev','adjurabaev74@gmail.com','adjurabaev74@gmail.com','$2y$10$.lyLvW195tBK4GOx4S0wie.XjCRyAgh3YYUDLha7QU7ndbnV3qhFu',NULL,1,NULL,NULL,NULL,'2020-08-20 09:43:13','2020-08-20 09:43:13',1,1,1,1,4,'no',0,NULL,NULL,NULL,NULL,NULL),(7,'Murodjon Khalikov','3','murodjon@edu-action.uz','$2y$10$yTVOAmSI1FnBF1KvsaF7kukdly2YMvwHk0mGoESVcUSBTE3o5N1ae',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-20 11:17:50',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(8,'','murodjonkhalokov@gmail.com','murodjonkhalokov@gmail.com','$2y$10$clT6aYO9TkjvRY9u4VeYYOn5bj1vOTVvMcueT2RkTuLkpOIkR9Q8G',NULL,1,NULL,NULL,NULL,'2020-01-01 07:00:00','2020-08-20 11:17:50',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(27,'AAAAA ','4','','$2y$10$MwvGB1DgZ/D4OFjck0tjT.84KUYuRhfw3bBG2bMh1tdMuWwc.6rQa',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-05 13:56:44',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(28,'','sdfadsf@dfsf.com','sdfadsf@dfsf.com','$2y$10$5TQS7rIGOjqm4V4E3/q8J.dRcNnJBCoRrWp6SovulQnM3HTMIzXjy',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-05 13:56:45',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(29,'aaaaaasd ','5','','$2y$10$6mPJGaYiAMHOITTS1mZCduO6W9E6/w9yBMYxMIlI.vbmclA2ci.hi',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-05 13:57:53',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(30,'','asdasdasd@sadasd.com','asdasdasd@sadasd.com','$2y$10$j7m4oeEY3f9322oSvSqukuDAhinHRFB0YflhRDsT7m5zbHHy1C22G',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-05 13:57:53',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(33,'SDSDSDS ','6','','$2y$10$pHBGTOcptEDluvBl9.U1yuKYlI7Ng.VS.9Z4vB7NkCOhuFL2zymMC',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-06 12:39:06',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(34,'','GTkwxIMBltI3idBkjXplOGOyh','GTkwxIMBltI3idBkjXplOGOyh','$2y$10$jy3rctF3aQaHtS3fjqL7UOfT.nbqO6be5EnLNaxXWtpUg39QoR7oS',NULL,1,NULL,NULL,NULL,'2020-01-01 12:00:00','2020-09-06 12:39:06',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL),(35,'asdsa ','7','','$2y$10$a.D.MVkIFLot26Y8.d4dCuxjdpQYEn2rvJpS3YI5UY4Luv2OWNIuK',NULL,1,NULL,NULL,NULL,'2021-01-01 07:00:00','2020-09-10 20:52:28',1,1,1,1,2,'no',0,NULL,NULL,NULL,NULL,NULL),(36,'','64ZEwpwPb5KqP8BRhMqSX041q','64ZEwpwPb5KqP8BRhMqSX041q','$2y$10$o98tLEwSTdv9kkm7znSO/uFMgz52DixZBjessJu7INXcsFKoqbIo6',NULL,1,NULL,NULL,NULL,'2021-01-01 07:00:00','2020-09-10 20:52:28',1,1,1,1,3,'no',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

