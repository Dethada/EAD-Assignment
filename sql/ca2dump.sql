CREATE DATABASE  IF NOT EXISTS `spmovy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `spmovy`;
-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: spmovy.c1epxanowzie.ap-southeast-1.rds.amazonaws.com    Database: spmovy
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `Genre`
--

DROP TABLE IF EXISTS `Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Genre` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genre`
--

LOCK TABLES `Genre` WRITE;
/*!40000 ALTER TABLE `Genre` DISABLE KEYS */;
INSERT INTO `Genre` VALUES (1,'Action','Action film is a film genre in which the protagonist or protagonists are thrust into a series of challenges.'),(2,'Romance','Romance films are romantic love stories that focus on passion, emotion, and the affectionate romantic involvement.'),(3,'Thriller','hrillers are characterized and defined by the moods they elicit, giving viewers heightened feelings of suspense, excitement, surprise, anticipation and anxiety.'),(4,'Comedy','Comedy is a genre of film in which the main emphasis is on humor. These films are designed to make the audience laugh through amusement.'),(5,'Drama','Drama film is a genre that relies on the emotional and relational development of realistic characters. Often, these dramatic themes are taken from intense, real life issues.'),(6,'Horror','A horror film is a film that seeks to elicit a physiological reaction, such as an elevated heartbeat, through the use of fear and shocking one’s audiences.'),(7,'Adventure','Adventure fiction is fiction that usually presents danger, or gives the reader a sense of excitement.');
/*!40000 ALTER TABLE `Genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieActor`
--

DROP TABLE IF EXISTS `MovieActor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MovieActor` (
  `movieID` int(11) NOT NULL,
  `actorID` int(11) NOT NULL,
  PRIMARY KEY (`movieID`,`actorID`),
  KEY `actorID` (`actorID`),
  CONSTRAINT `MovieActor_ibfk_1` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MovieActor_ibfk_2` FOREIGN KEY (`actorID`) REFERENCES `actor` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieActor`
--

LOCK TABLES `MovieActor` WRITE;
/*!40000 ALTER TABLE `MovieActor` DISABLE KEYS */;
INSERT INTO `MovieActor` VALUES (986,3),(687,611),(985,774),(988,776),(988,777),(1000,785);
/*!40000 ALTER TABLE `MovieActor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MovieGenre`
--

DROP TABLE IF EXISTS `MovieGenre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MovieGenre` (
  `movieID` int(11) NOT NULL,
  `genreID` int(11) NOT NULL,
  PRIMARY KEY (`movieID`,`genreID`),
  KEY `genreID` (`genreID`),
  CONSTRAINT `MovieGenre_ibfk_1` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MovieGenre_ibfk_2` FOREIGN KEY (`genreID`) REFERENCES `Genre` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MovieGenre`
--

LOCK TABLES `MovieGenre` WRITE;
/*!40000 ALTER TABLE `MovieGenre` DISABLE KEYS */;
INSERT INTO `MovieGenre` VALUES (687,1),(985,1),(986,1),(988,3),(987,4),(1000,4),(986,7);
/*!40000 ALTER TABLE `MovieGenre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actor`
--

DROP TABLE IF EXISTS `actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actor` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=786 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'Robert Downey Jr.','Robert Downey Jr. has evolved into one of the most respected actors in Hollywood. With an amazing list of credits to his name, he has managed to stay new and fresh even after over four decades in the business.'),(3,'Dwayne Johnson','Dwayne Douglas Johnson is an American actor, producer, singer, musician, and semi-retired professional wrestler. Johnson\'s first leading film role was in The Scorpion King in 2002. For this, he was paid US$5.5 million, a world record for an actor in his first starring role. One of his more prominent roles is Luke Hobbs in The Fast and the Furious franchise.'),(4,'Chris Evans','Christopher Robert Evans is an American actor. Evans is known for his superhero roles as the Marvel Comics characters Captain America in the Marvel Cinematic Universe and Human Torch in Fantastic Four (2005) and its 2007 sequel.'),(5,'Chris Hemsworth','Christopher Hemsworth (born 11 August 1983) is an Australian actor. He is known for playing Kim Hyde in the Australian TV series Home and Away (2004–07) and Thor in the Marvel Cinematic Universe since 2011. '),(6,'Ryan Reynolds','Ryan Rodney Reynolds (born October 23, 1976) is a Canadian actor, film producer, and screenwriter. Some of his most prominent roles are Billy Simpson in the YTV Canadian teen soap opera Hillside (1991), Michael Bergen on the ABC sitcom Two Guys and a Girl (1998–2001), and various comic book characters including Marvel Comics superheroes Hannibal King in Blade: Trinity (2004), and Wade Wilson / Deadpool in X-Men Origins: Wolverine (2009), and Deadpool (2016); the latter role earned him a Golden Globe Award nomination.'),(7,'Zoe Saldana','Zoe Saldana-Perego, known professionally as Zoe Saldana or ZoÃ« Saldana, is an American actress and dancer. Following her performances with the theater group Faces, Saldana made her screen debut in an episode of Law & Order.'),(8,'Madison Wolfe','Madison Wolfe is an American actress. She made her film debut in the adventure drama On the Road and her television debut in the HBO series True Detective. She starred in the horror film The Conjuring 2.'),(9,'Imogen Poots','Imogen Poots (born 3 June 1989) is an English actress. She played Tammy in the post-apocalyptic science fiction horror film 28 Weeks Later (2007), Linda Keith in the Jimi Hendrix biopic Jimi: All Is by My Side (2013), Debbie Raymond in the Paul Raymond biopic The Look of Love (2013), and Julia Maddon in the American action movie Need For Speed (2014). In 2016 she starred as Kelly Ann in the Showtime series Roadies.'),(10,'Crystal Reed','Crystal Marie Reed (born February 6, 1985) is an American actress and model. She is best known for her roles as Allison Argent in the 2011 MTV show Teen Wolf and Sofia Falcone on Gotham. She also starred in the 2013 direct-to-video film Crush.'),(267,'John Krasinski','John Burke Krasinski is an American actor, screenwriter, producer, and director. He is most widely known for his role as Jim Halpert on the NBC sitcom The Office, for which he received critical acclaim and won a number of awards.'),(316,'Chris Pratt','Christopher Michael Pratt (born June 21, 1979) is an American actor. Pratt came to prominence with his television roles, particularly for his role as Andy Dwyer in the NBC sitcom Parks and Recreation (2009–2015), for which he received critical acclaim and was nominated for the Critics\' Choice Television Award for Best Supporting Actor in a Comedy Series in 2013. He also starred earlier in his career as Bright Abbott in The WB drama series Everwood (2002–2006).'),(611,'Michael Douglas','Michael Kirk Douglas is an American actor and producer. Douglas\'s career includes a diverse range of films in the independent and blockbuster genres, for which he has received a number of accolades, both competitive and honorary.'),(774,'Tom Cruise','Thomas Cruise Mapother IV (born July 3, 1962) is an American actor and producer. He started his career at age 19 in the film Endless Love (1981), before making his breakthrough in the comedy Risky Business (1983) and receiving widespread attention for starring in the action drama Top Gun (1986) as Lieutenant Pete \"Maverick\" Mitchell. After starring in The Color of Money (1986) and Cocktail (1988), Cruise starred opposite Dustin Hoffman in the Academy Award for Best Picture-winning drama Rain Man. For his role as anti-war activist Ron Kovic in the drama Born on the Fourth of July (1989), Cruise received the Golden Globe Award for Best Actor – Motion Picture Drama and his first Academy Award for Best Actor nomination. '),(775,'  Ewan McGregor','Ewan Gordon McGregor OBE (born 31 March 1971)[1] is a Scottish actor, known internationally for his various film roles, including independent dramas, science-fiction epics, and musicals.'),(776,'Amandla Stenberg','Amandla Stenberg (born October 23, 1998) is an American actress and singer. She portrayed Rue in The Hunger Games and Madeline Whittier in Everything, Everything. '),(777,'Mandy Moore','Amanda Leigh Moore (born April 10, 1984) is an American singer-songwriter and actress. After coming to fame in 1999 with her debut single \"Candy\", which peaked at number 41 on the Billboard Hot 100, Moore signed with Epic Records. Her debut studio album, So Real (1999), went on to receive a platinum certification from the RIAA. The title single from her second studio album, I Wanna Be With You (2000), became Moore\'s first top 30 song in the U.S., peaking at number 24 on the Hot 100. As of 2009, Billboard reported that Moore has sold more than ten million albums worldwide.'),(781,'  Mila Kunis','Milena Markovna \"Mila\" Kunis born August 14, 1983) is an American actress. In 1991, at the age of seven, she moved from Soviet Ukraine to the United States with her family. After being enrolled in acting classes as an after-school activity, she was soon discovered by an agent. She appeared in several television series and commercials, before acquiring her first significant role at age 14, playing Jackie Burkhart on the television series That \'70s Show (1998–2006). Since 1999, she has voiced Meg Griffin on the animated series Family Guy. '),(785,'Kate McKinnon','Kathryn McKinnon Berthold (born January 6, 1984) is an American actress and comedian. She is widely known as a regular cast member on The Big Gay Sketch Show (2007–2010) and Saturday Night Live (2012–present). She is also known for her film roles as Dr. Jillian Holtzmann in the supernatural comedy Ghostbusters (2016), Mary Winetoss in the comedy Office Christmas Party (2016), Pippa in the comedy Rough Night (2017), and Morgan in the action comedy The Spy Who Dumped Me (2018). ');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookseats`
--

DROP TABLE IF EXISTS `bookseats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookseats` (
  `price` decimal(5,2) NOT NULL,
  `ticketID` char(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hall_column` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hall_row` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transactionID` char(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `movietime` time NOT NULL,
  `moviedate` date NOT NULL,
  `movieID` int(11) NOT NULL,
  `salt` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`hall_row`,`hall_column`,`transactionID`,`moviedate`,`movietime`,`movieID`),
  KEY `transactionID` (`transactionID`),
  KEY `movieID` (`movieID`,`movietime`,`moviedate`),
  KEY `movietime` (`movietime`,`moviedate`),
  CONSTRAINT `bookseats_ibfk_1` FOREIGN KEY (`transactionID`) REFERENCES `transaction` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bookseats_ibfk_4` FOREIGN KEY (`movietime`, `moviedate`) REFERENCES `timeslot` (`movietime`, `moviedate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bookseats_ibfk_5` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookseats`
--

LOCK TABLES `bookseats` WRITE;
/*!40000 ALTER TABLE `bookseats` DISABLE KEYS */;
INSERT INTO `bookseats` VALUES (8.50,'i13a51c24136f189afec773c86d4f86f745c2923b965c5c11b66dcd4363bdb768','12','D','t572ec27fa93fd8dc518c22a0616dbe122e9356556ac674c0f654cc4a64743baf','10:00:00','2018-08-06',687,'9fde609d9fed2a65c13eb28f57bd809c'),(8.50,'if72f768d429a1180e92e1dbd2bcb1fbd8d01a13b1aaf76908a655cbd40ba2487','13','D','t572ec27fa93fd8dc518c22a0616dbe122e9356556ac674c0f654cc4a64743baf','10:00:00','2018-08-06',687,'9fde609d9fed2a65c13eb28f57bd809c'),(13.00,'i3007905ca3dfad8916f27d1283dc3001df34fc1e42bb26d2df898155b354b500','7','D','t658a722cccbb5320139fcb29156fdedfbf49a789be2f787d54af86e97604ec66','10:00:00','2018-08-11',987,'caab7bdae21e325ebfb19744f0a5a612'),(13.00,'i8d0257f431403ff68a8664d87f6484210ff62e417b345172f2e40106722e262c','8','D','t658a722cccbb5320139fcb29156fdedfbf49a789be2f787d54af86e97604ec66','10:00:00','2018-08-11',987,'caab7bdae21e325ebfb19744f0a5a612'),(8.50,'i624501cb4056a8b549f426a1bb02788cdf4ed650db957aaccbf8222439b7b92e','10','E','t0f8693f4ea54d675043d9933692b40644fd4e1b70866b8032bf742b3f649f34f','14:00:00','2018-08-13',1000,'1e8c1a7f89db347746a72b8538b16773'),(8.50,'i697043d8368018cda6b1427e13ce4060e3d778fb49e518a785b37809a711ed97','10','E','t4652803cce21f626166a6c41a0b2b09d98a9ac187dadd75a7f4c81e2536fcce4','00:00:00','2018-08-09',986,'e514d0955f6e69dd6c0a0db019ed72f7'),(8.50,'i68a0da2dc67b32ac3551ef2d16b981a066be2674f111dd7aca46036788073607','11','E','t0f8693f4ea54d675043d9933692b40644fd4e1b70866b8032bf742b3f649f34f','14:00:00','2018-08-13',1000,'1e8c1a7f89db347746a72b8538b16773'),(8.50,'i04069f5c4c3d21fb79bd8efd7573175eb0081567245fd502bd9f39546c1c6ef1','11','E','t4652803cce21f626166a6c41a0b2b09d98a9ac187dadd75a7f4c81e2536fcce4','00:00:00','2018-08-09',986,'e514d0955f6e69dd6c0a0db019ed72f7'),(8.50,'i25be6089bf84588f9be600991683df189274ee16e849a0b918be041acfc56a64','12','E','t0f8693f4ea54d675043d9933692b40644fd4e1b70866b8032bf742b3f649f34f','14:00:00','2018-08-13',1000,'1e8c1a7f89db347746a72b8538b16773'),(8.50,'i1ad11abee1b9da3f3f4a53098b030f595fa05d310bfb10050a12e17aaafeb4a8','13','E','t0f8693f4ea54d675043d9933692b40644fd4e1b70866b8032bf742b3f649f34f','14:00:00','2018-08-13',1000,'1e8c1a7f89db347746a72b8538b16773'),(8.50,'i31a44b2641ab1424ca834aa70181fa8f752f929bd172257281ad6cfbed9ddcc9','9','E','t4652803cce21f626166a6c41a0b2b09d98a9ac187dadd75a7f4c81e2536fcce4','00:00:00','2018-08-09',986,'e514d0955f6e69dd6c0a0db019ed72f7'),(8.50,'if0e67264391a938206ef28b0af659e5deb2bce5bf5deeb6405fb0e5a37540205','10','F','t7a6123bb0c7fb08cdf61875ea9f6ec66df183a8413189eedf102bdd7633f0909','10:00:00','2018-08-06',687,'d1db252957a822d6959463a7dd6434e3'),(13.00,'if8dfaa930a760e60526dbf9a6655c03f983e117d5027536998022c72e35f8da6','10','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(8.50,'i0ecc0b29da1b51ca0ca1d1e25f9f2da418272795ccbf1c02a54295e12ed6c32c','11','F','t7a6123bb0c7fb08cdf61875ea9f6ec66df183a8413189eedf102bdd7633f0909','10:00:00','2018-08-06',687,'d1db252957a822d6959463a7dd6434e3'),(13.00,'i1a370489c335f730e3a7e109e30ca0af9325818eb834f6764842de259c550a7b','11','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(13.00,'i3937330b878dbdd6d98245edd813758c6f2d0994f05828626f42eca855d43a0b','12','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(13.00,'i125462b1b53f648dec13aeb4f04730f594a1a42de794f1b46a12081fbcf449d8','13','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(13.00,'i2066dc043c4ce77a861c41fc637f430b0623811c20cf00ee960724b1a7c3daa9','14','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(8.50,'i2184459e973cb61d6dc41865fa88e68397de9b1b002d0d0b2596b443b20693a2','8','F','t37c6a92cfdbf8d33c752af463816345e2d2e30c030693d4971234a4ba0cd1fab','16:00:00','2018-08-12',988,'e281da7fb883a652ca736cda4051a610'),(8.50,'if5dd054472d16b71730c4070a6c4dc9480d9853497e4f689e66f6b0fe27765d2','8','F','t7a6123bb0c7fb08cdf61875ea9f6ec66df183a8413189eedf102bdd7633f0909','10:00:00','2018-08-06',687,'d1db252957a822d6959463a7dd6434e3'),(8.50,'i3528b6a0c848f2594afdf197d46ba800b9ed5f4d346d384227774fb34aa2aa65','8','F','tda54ffeb661f93a7730c40294d19b3975766936a6b491ae29d1e92c58a1e0695','12:00:00','2018-08-07',985,'bdccaa3177aa5135fd0c0d6e787de5a5'),(8.50,'i5f5faf172ca2f5a44005cc597239683f0be5f94098cf88714d3191b15e130c07','9','F','t7a6123bb0c7fb08cdf61875ea9f6ec66df183a8413189eedf102bdd7633f0909','10:00:00','2018-08-06',687,'d1db252957a822d6959463a7dd6434e3'),(8.50,'ibd4543491d01a982e47193e27532677849c822ef488ff35cdf8902e88fdc4ca7','9','F','tda54ffeb661f93a7730c40294d19b3975766936a6b491ae29d1e92c58a1e0695','12:00:00','2018-08-07',985,'bdccaa3177aa5135fd0c0d6e787de5a5'),(13.00,'i97405c668acb0821e32ea7430c1d3f067d48766c05c6384ff85446f5995ad499','9','F','tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','19:00:00','2018-08-10',987,'221084ef4a180a95519ceb20b9401532'),(8.50,'i518498eadef62a6ae7113d316942964706a6c4d12cafbec6dfcacad68a91d391','10','G','t0e6d622d7c8a20645b3695bafd231655d1233bda12e0ed5ab1c2b2bf99d54eed','14:00:00','2018-08-13',1000,'84c795eb2c531a49c9d089323a900cf8'),(8.50,'i3c0c454cfb0994a137809ad2ea23341d26527be8c540ac51772687747501ec73','10','G','t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','18:00:00','2018-08-08',985,'eeea6bf0c19c7aee48265ddeb5153df9'),(8.50,'i03ec97b1716a8a961c5b9f6ce7d30c9efaaaa08153c5cc72e3355d70d738cd41','11','G','t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','18:00:00','2018-08-08',985,'eeea6bf0c19c7aee48265ddeb5153df9'),(8.50,'i4714dc4e2bc78e8b9cfa8088c85299d39c5596d6a425bc1858b01329fdf37a44','7','G','t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','18:00:00','2018-08-08',985,'eeea6bf0c19c7aee48265ddeb5153df9'),(8.50,'i7154a1dd14167a88751d32655c39a31683afe842972206b68ee3e0df040e0ef7','8','G','t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','18:00:00','2018-08-08',985,'eeea6bf0c19c7aee48265ddeb5153df9'),(8.50,'i8cfc6c30e98b536a8da354cf51118a44f242721b1a749677c9c3cd613ff49594','9','G','t0e6d622d7c8a20645b3695bafd231655d1233bda12e0ed5ab1c2b2bf99d54eed','14:00:00','2018-08-13',1000,'84c795eb2c531a49c9d089323a900cf8'),(8.50,'ida6c690a947dc611a3d52636e97572b63c3dc2e68d8ae1972c30738eb6215f8d','9','G','t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','18:00:00','2018-08-08',985,'eeea6bf0c19c7aee48265ddeb5153df9'),(8.50,'idb0c25f1b0498a24edf89037fe019eba3af95db4504dc0fa3df68d8ec82719a6','10','H','tdeafe79c06dec0b2ce85dcec2525fbf2448ad010f385282f31ec412a955f5e38','12:00:00','2018-08-07',985,'b0974ac5bce164f0e887107ecfd32f87'),(8.50,'i40fbf92bc86cc83ff43ea56a175a1110ea8ef10efd5a0d20d1d2ec8e6b479ed4','8','H','tdeafe79c06dec0b2ce85dcec2525fbf2448ad010f385282f31ec412a955f5e38','12:00:00','2018-08-07',985,'b0974ac5bce164f0e887107ecfd32f87'),(8.50,'ib01ce7383538c21e6ed7c81240707e9467f81009baf2c1225462a762e6837845','9','H','tdeafe79c06dec0b2ce85dcec2525fbf2448ad010f385282f31ec412a955f5e38','12:00:00','2018-08-07',985,'b0974ac5bce164f0e887107ecfd32f87');
/*!40000 ALTER TABLE `bookseats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `movie` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `releasedate` date NOT NULL,
  `synopsis` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `imagepath` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (687,'Marvel Studios\' Ant-Man and The Wasp','2018-07-04','From the Marvel Cinematic Universe comes Ant-Man and The Wasp, a new chapter featuring heroes with the astonishing ability to shrink. In the aftermath of Captain America: Civil War, Scott Lang grapples with the consequences of his choices as both a super hero and a father. As he struggles to rebalance his life with his responsibilities as Ant-Man, he’s confronted by Hope van Dyne and Dr. Hank Pym with an urgent new mission. Scott must once again put on the suit and learn to fight alongside the Wasp as the team works together to uncover secrets from the past.',118,'https://cdn.spmovy.xyz/upload_401f32bc0badd0db0a7f7f941c434850.jpg','Now Showing'),(985,'Mission: Impossible - Fallout','2018-07-27','The best intentions often come back to haunt you. MISSION: IMPOSSIBLE - FALLOUT finds Ethan Hunt (Tom Cruise) and his IMF team (Alec Baldwin, Simon Pegg, Ving Rhames) along with some familiar allies (Rebecca Ferguson, Michelle Monaghan) in a race against time after a mission gone wrong. Henry Cavill, Angela Bassett, and Vanessa Kirby also join the dynamic cast with filmmaker Chris McQuarrie returning to the helm. ',147,'https://cdn.spmovy.xyz/upload_d1afe1cf57483cf389955931f59e2a88.jpg','Now Showing'),(986,'Skyscraper','2018-07-12','Global icon Dwayne Johnson leads the cast of Legendary\'s Skyscraper as former FBI Hostage Rescue Team leader and U.S. war veteran Will Sawyer, who now assesses security for skyscrapers. On assignment in China he finds the tallest, safest building in the world suddenly ablaze, and he\'s been framed for it. A wanted man on the run, Will must find those responsible, clear his name and somehow rescue his family who is trapped inside the building...above the fire line.',103,'https://cdn.spmovy.xyz/upload_e695dc94448f2d8daca74e585c6e7740.jpg','Now Showing'),(987,'Disney\'s Christopher Robin','2018-08-02','Disney\'s CHRISTOPHER ROBIN is directed by Marc Forster from a screenplay by Alex Ross Perry and Allison Schroeder and a story by Perry based on characters created by A.A. Milne. The producers are Brigham Taylor and Kristin Burr with Renee Wolfe and Jeremy Johns serving as executive producers. The film stars Ewan McGregor as Christopher Robin; Hayley Atwell as his wife Evelyn; Bronte Carmichael as his daughter Madeline; and Mark Gatiss as Keith Winslow, Robin\'s boss. The film also features the voices of: Jim Cummings as Winnie the Pooh; Chris O\'Dowd as Tigger; Brad Garrett as Eeyore; Toby Jones as Owl; Nick Mohammed as Piglet; Peter Capaldi as Rabbit; and Sophie Okonedo as Kanga. ',104,'https://cdn.spmovy.xyz/upload_7ded30c49fd2b625890b8fe573e9bc4d.jpg','Now Showing'),(988,'The Darkest Minds','2018-08-02','When teens mysteriously develop powerful new abilities, they are declared a threat by the government and detained. Sixteen-year-old Ruby, one of the most powerful young people anyone has encountered, escapes her camp and joins a group of runaway teens seeking safe haven. Soon this newfound family realizes that, in a world in which the adults in power have betrayed them, running is not enough and they must wage a resistance, using their collective power to take back control of their future. ',92,'https://cdn.spmovy.xyz/upload_e059b52abb10044d39a45a5c6a691082.jpg','Now Showing'),(1000,'The Spy Who Dumped Me','2018-08-02','Audrey (Mila Kunis) and Morgan (Kate McKinnon), two thirty-year-old best friends in Los Angeles, are thrust unexpectedly into an international conspiracy when Audrey’s ex-boyfriend shows up at their apartment with a team of deadly assassins on his trail. Surprising even themselves, the duo jump into action, on the run throughout Europe from assassins and a suspicious-but-charming British agent, as they hatch a plan to save the world.',117,'https://cdn.spmovy.xyz/upload_e3c389e27717dac0806b0eb16ead7b37.jpg','Now Showing');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `price` (
  `day` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  PRIMARY KEY (`day`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES ('weekday',8.50),('weekend',13.00);
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `reviewID` int(11) NOT NULL AUTO_INCREMENT,
  `movieID` int(11) NOT NULL,
  `reviewSentence` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL,
  `createdat` datetime NOT NULL,
  `ip` varchar(39) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`reviewID`,`movieID`),
  KEY `movieID` (`movieID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (313,987,'? nice, really like Disney movies','John',5,'2018-08-05 13:24:51','0:0:0:0:0:0:0:1'),(314,985,'Great Action, maybe the best action movie of the year. Will keep you on the edge of your seats at all time. Tom Cruise can still run fast! A must see for action lovers. Probably the best installment in the series.','John',5,'2018-08-05 13:49:08','0:0:0:0:0:0:0:1'),(315,986,'Boring plot!','John',2,'2018-08-05 13:50:15','0:0:0:0:0:0:0:1'),(316,687,'Funny and entertaining, as good as the first Ant Man Movie. Wasp action scenes are good!','John',4,'2018-08-05 22:02:04','0:0:0:0:0:0:0:1'),(317,988,'Don\'t really understand the plot','John',3,'2018-08-05 22:07:10','0:0:0:0:0:0:0:1');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seats`
--

DROP TABLE IF EXISTS `seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seats` (
  `hall_column` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hall_row` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`hall_row`,`hall_column`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seats`
--

LOCK TABLES `seats` WRITE;
/*!40000 ALTER TABLE `seats` DISABLE KEYS */;
INSERT INTO `seats` VALUES ('1','A'),('10','A'),('11','A'),('12','A'),('13','A'),('14','A'),('15','A'),('16','A'),('17','A'),('18','A'),('19','A'),('2','A'),('20','A'),('3','A'),('4','A'),('5','A'),('6','A'),('7','A'),('8','A'),('9','A'),('1','B'),('10','B'),('11','B'),('12','B'),('13','B'),('14','B'),('15','B'),('16','B'),('17','B'),('18','B'),('19','B'),('2','B'),('20','B'),('3','B'),('4','B'),('5','B'),('6','B'),('7','B'),('8','B'),('9','B'),('1','C'),('10','C'),('11','C'),('12','C'),('13','C'),('14','C'),('15','C'),('16','C'),('17','C'),('18','C'),('19','C'),('2','C'),('20','C'),('3','C'),('4','C'),('5','C'),('6','C'),('7','C'),('8','C'),('9','C'),('1','D'),('10','D'),('11','D'),('12','D'),('13','D'),('14','D'),('15','D'),('16','D'),('17','D'),('18','D'),('19','D'),('2','D'),('20','D'),('3','D'),('4','D'),('5','D'),('6','D'),('7','D'),('8','D'),('9','D'),('1','E'),('10','E'),('11','E'),('12','E'),('13','E'),('14','E'),('15','E'),('16','E'),('17','E'),('18','E'),('19','E'),('2','E'),('20','E'),('3','E'),('4','E'),('5','E'),('6','E'),('7','E'),('8','E'),('9','E'),('1','F'),('10','F'),('11','F'),('12','F'),('13','F'),('14','F'),('15','F'),('16','F'),('17','F'),('18','F'),('19','F'),('2','F'),('20','F'),('3','F'),('4','F'),('5','F'),('6','F'),('7','F'),('8','F'),('9','F'),('1','G'),('10','G'),('11','G'),('12','G'),('13','G'),('14','G'),('15','G'),('16','G'),('17','G'),('18','G'),('19','G'),('2','G'),('20','G'),('3','G'),('4','G'),('5','G'),('6','G'),('7','G'),('8','G'),('9','G'),('1','H'),('10','H'),('11','H'),('12','H'),('13','H'),('14','H'),('15','H'),('16','H'),('17','H'),('18','H'),('19','H'),('2','H'),('20','H'),('3','H'),('4','H'),('5','H'),('6','H'),('7','H'),('8','H'),('9','H'),('1','I'),('10','I'),('11','I'),('12','I'),('13','I'),('14','I'),('15','I'),('16','I'),('17','I'),('18','I'),('19','I'),('2','I'),('20','I'),('3','I'),('4','I'),('5','I'),('6','I'),('7','I'),('8','I'),('9','I'),('1','J'),('10','J'),('11','J'),('12','J'),('13','J'),('14','J'),('15','J'),('16','J'),('17','J'),('18','J'),('19','J'),('2','J'),('20','J'),('3','J'),('4','J'),('5','J'),('6','J'),('7','J'),('8','J'),('9','J');
/*!40000 ALTER TABLE `seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslot`
--

DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslot` (
  `movietime` time NOT NULL,
  `moviedate` date NOT NULL,
  `movieID` int(11) NOT NULL,
  PRIMARY KEY (`movietime`,`moviedate`,`movieID`),
  KEY `movieID` (`movieID`),
  CONSTRAINT `timeslot_ibfk_1` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot`
--

LOCK TABLES `timeslot` WRITE;
/*!40000 ALTER TABLE `timeslot` DISABLE KEYS */;
INSERT INTO `timeslot` VALUES ('10:00:00','2018-08-06',687),('12:00:00','2018-08-07',985),('15:00:00','2018-08-07',985),('18:00:00','2018-08-08',985),('00:00:00','2018-08-09',986),('14:00:00','2018-08-11',986),('10:00:00','2018-08-11',987),('19:00:00','2018-08-10',987),('12:00:00','2018-08-12',988),('16:00:00','2018-08-12',988),('14:00:00','2018-08-13',1000),('22:00:00','2018-08-13',1000);
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `ID` char(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `at` datetime NOT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `userid` (`userid`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES ('t0e6d622d7c8a20645b3695bafd231655d1233bda12e0ed5ab1c2b2bf99d54eed','2018-08-06 00:08:10',12),('t0f8693f4ea54d675043d9933692b40644fd4e1b70866b8032bf742b3f649f34f','2018-08-06 00:03:14',10),('t37c6a92cfdbf8d33c752af463816345e2d2e30c030693d4971234a4ba0cd1fab','2018-08-05 23:59:51',11),('t4652803cce21f626166a6c41a0b2b09d98a9ac187dadd75a7f4c81e2536fcce4','2018-08-06 00:07:51',12),('t5274af1d11c2ac67bded7b63f727d09a5f92d6c8d88d62156db5a0537967161f','2018-08-06 00:00:14',11),('t572ec27fa93fd8dc518c22a0616dbe122e9356556ac674c0f654cc4a64743baf','2018-08-05 22:04:56',2),('t658a722cccbb5320139fcb29156fdedfbf49a789be2f787d54af86e97604ec66','2018-08-05 23:59:34',11),('t7a6123bb0c7fb08cdf61875ea9f6ec66df183a8413189eedf102bdd7633f0909','2018-08-06 00:12:26',10),('tda54ffeb661f93a7730c40294d19b3975766936a6b491ae29d1e92c58a1e0695','2018-08-06 00:04:00',10),('tdeafe79c06dec0b2ce85dcec2525fbf2448ad010f385282f31ec412a955f5e38','2018-08-06 00:09:02',12),('tff22105bc295b451c0d43e2134e1b385621cfaab063e616bb2e6eea0e4c89bfe','2018-08-06 00:08:43',12);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` char(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact` char(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `creditcard` varchar(19) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cvv` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exp` char(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cardname` varchar(26) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`,`contact`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `contact` (`contact`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$12$sgKpKftg3KciZSkTQ1crw.9yeC1wiVvofvLyRkCoBEDhsHnA4HPMm','admin','admin','admin@spmovy.xyz','98765432','0000000000000000','000','00/00','admin'),(2,'test','$2a$12$9J3q2wxO1J7nlhz6zBkqoO.q5I57iptw19rAITdleuUmsE3mZQok.','member','test','test@test.com','99998888','1234432112344321','123','09/24','TESTer'),(10,'john23','$2a$12$ftMjkcHE498IXewq1mNdue991NFVzBNw5IXbROXhfsMGvRLXQvs/u','member','John','john@test.com','91239123','7502386046077072','666','05/22','John Doe'),(11,'trevor123','$2a$12$42cfmmThdMIKLKuU67IkUuvwuJc6DnY65u9f7Dg1UHPFvrxCwfQkK','member','Trevor','trevor@test.com','98768765','8191111509205740','242','09/20','Trevor Ong'),(12,'elliot','$2a$12$35JWAO.9uCDAbSx881LRN.SrEMQ2hDLZU6wO7RTGc3tT/CBajKTPS','member','Elliot','elliot@test.com','95434321','8886791745521978','286','11/20','Elliot Anderson');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'spmovy'
--

--
-- Dumping routines for database 'spmovy'
--
/*!50003 DROP PROCEDURE IF EXISTS `deleteProcedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`StandardEye`@`%` PROCEDURE `deleteProcedure`(IN tab_name VARCHAR(100), IN id INT)
BEGIN
        SET @t1 =CONCAT('DELETE FROM ', tab_name, ' WHERE ID=', id);
        PREPARE stmt3 FROM @t1;
        EXECUTE stmt3;
        DEALLOCATE PREPARE stmt3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-06  0:42:17
