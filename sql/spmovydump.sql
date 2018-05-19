CREATE DATABASE  IF NOT EXISTS `spmovy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `spmovy`;
-- MySQL dump 10.13  Distrib 5.7.22, for Win64 (x86_64)
--
-- Host: 52.74.214.114    Database: spmovy
-- ------------------------------------------------------
-- Server version 5.7.22-0ubuntu0.16.04.1

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
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
INSERT INTO `MovieActor` VALUES (1,1),(1,2),(4,2),(2,3),(1,4),(3,7),(467,255),(467,256),(467,257),(483,267);
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
INSERT INTO `MovieGenre` VALUES (1,1),(2,1),(3,1),(4,1),(467,3),(483,3),(467,5),(483,6),(1,7);
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
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actor`
--

LOCK TABLES `actor` WRITE;
/*!40000 ALTER TABLE `actor` DISABLE KEYS */;
INSERT INTO `actor` VALUES (1,'Robert Downey Jr.','Robert Downey Jr. has evolved into one of the most respected actors in Hollywood. With an amazing list of credits to his name, he has managed to stay new and fresh even after over four decades in the business.'),(2,'Chris Pratt','Christopher Michael Pratt is an American film and television actor. He came to prominence from his television roles and is well known for being the main character in  the sci-fi thriller Jurassic World (2015).'),(3,'Dwayne Johnson','Dwayne Douglas Johnson is an American actor, producer, singer, musician, and semi-retired professional wrestler. Johnson\'s first leading film role was in The Scorpion King in 2002. For this, he was paid US$5.5 million, a world record for an actor in his first starring role. One of his more prominent roles is Luke Hobbs in The Fast and the Furious franchise.'),(4,'Chris Evans','Christopher Robert Evans is an American actor. Evans is known for his superhero roles as the Marvel Comics characters Captain America in the Marvel Cinematic Universe and Human Torch in Fantastic Four (2005) and its 2007 sequel.'),(5,'Chris Hemsworth','Christopher Hemsworth (born 11 August 1983) is an Australian actor. He is known for playing Kim Hyde in the Australian TV series Home and Away (2004–07) and Thor in the Marvel Cinematic Universe since 2011. '),(7,'Ryan Reynolds','Ryan Rodney Reynolds (born October 23, 1976) is a Canadian actor, film producer, and screenwriter. Some of his most prominent roles are Billy Simpson in the YTV Canadian teen soap opera Hillside (1991), Michael Bergen on the ABC sitcom Two Guys and a Girl (1998–2001), and various comic book characters including Marvel Comics superheroes Hannibal King in Blade: Trinity (2004), and Wade Wilson / Deadpool in X-Men Origins: Wolverine (2009), and Deadpool (2016); the latter role earned him a Golden Globe Award nomination.'),(255,'Zoe Saldana','Zoe Saldana-Perego, known professionally as Zoe Saldana or ZoÃ« Saldana, is an American actress and dancer. Following her performances with the theater group Faces, Saldana made her screen debut in an episode of Law & Order.'),(256,'Madison Wolfe','Madison Wolfe is an American actress. She made her film debut in the adventure drama On the Road and her television debut in the HBO series True Detective. She starred in the horror film The Conjuring 2.'),(257,'Imogen Poots','Imogen Poots (born 3 June 1989) is an English actress. She played Tammy in the post-apocalyptic science fiction horror film 28 Weeks Later (2007), Linda Keith in the Jimi Hendrix biopic Jimi: All Is by My Side (2013), Debbie Raymond in the Paul Raymond biopic The Look of Love (2013), and Julia Maddon in the American action movie Need For Speed (2014). In 2016 she starred as Kelly Ann in the Showtime series Roadies.'),(264,'Crystal Reed','Crystal Marie Reed (born February 6, 1985) is an American actress and model. She is best known for her roles as Allison Argent in the 2011 MTV show Teen Wolf and Sofia Falcone on Gotham. She also starred in the 2013 direct-to-video film Crush.'),(267,'John Krasinski','John Burke Krasinski is an American actor, screenwriter, producer, and director. He is most widely known for his role as Jim Halpert on the NBC sitcom The Office, for which he received critical acclaim and won a number of awards.');
/*!40000 ALTER TABLE `actor` ENABLE KEYS */;
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
  `synopsis` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `imagepath` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=584 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,'Marvel Studio\'s Avengers: Infinity War','2018-04-24','The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.',150,'https://cdn.spmovy.xyz/upload_330829be6a8471015eefee4d22f0e594.png','Now Showing'),(2,'Rampage','2018-04-12','Primatologist Davis Okoye (Johnson), a man who keeps people at a distance, shares an unshakable bond with George, the extraordinarily intelligent, silverback gorilla who has been in his care since birth. But a rogue genetic experiment gone awry mutates this gentle ape into a raging creature of enormous size. To make matters worse, it’s soon discovered there are other similarly altered animals. As these newly created alpha predators tear across North America, destroying everything in their path, Okoye teams with a discredited genetic engineer to secure an antidote, fighting his way through an ever-changing battlefield, not only to halt a global catastrophe but to save the fearsome creature that was once his friend.',107,'https://cdn.spmovy.xyz/upload_af7bdddaebfcee497813b670dedfacf6.png','Now Showing'),(3,'Deadpool 2','2018-05-17','After surviving a near fatal bovine attack, a disfigured cafeteria chef (Wade Wilson) struggles to fulfill his dream of becoming Mayberry\'s hottest bartender while also learning to cope with his lost sense of taste. Searching to regain his spice for life, as well as a flux capacitor, Wade must battle ninjas, the yakuza, and a pack of sexually aggressive canines, as he journeys around the world to discover the importance of family, friendship, and flavor - finding a new taste for adventure and earning the coveted coffee mug title of World\'s Best Lover.\r\n',110,'https://cdn.spmovy.xyz/upload_8a231c079f52e168f05961583bf17868.png','Now Showing'),(4,'Jurassic World: Fallen Kingdom','2018-06-07','It’s been four years since theme park and luxury resort Jurassic World was destroyed by dinosaurs out of containment. Isla Nublar now sits abandoned by humans while the surviving dinosaurs fend for themselves in the jungles.When the island’s dormant volcano begins roaring to life, Owen (Chris Pratt) and Claire (Bryce Dallas Howard) mount a campaign to rescue the remaining dinosaurs from this extinction-level event. Owen is driven to find Blue, his lead raptor who’s still missing in the wild, and Claire has grown a respect for these creatures she now makes her mission. Arriving on the unstable island as lava begins raining down, their expedition uncovers a conspiracy that could return our entire planet to a perilous order not seen since prehistoric times.',120,'https://cdn.spmovy.xyz/upload_582b1f9ddebadbe86c09c9954f7f5c70.png','Coming Soon'),(467,'I Kill Giants','2018-05-10','Barbara Thorson (Madison Wolfe) is a teenage girl who escapes the realities of school and a troubled family life by retreating into her magical world of fighting evil giants. With the help of her new friend Sophia (Sydney Wade) and her school counselor (Zoe Saldana), Barbara learns to face her fears and battle the giants that threaten her world.',101,'https://cdn.spmovy.xyz/upload_cd9936ba9a697d9f3d787781d131eba6.jpg','Now Showing'),(483,'A Quiet Place','2018-04-05','In the modern horror thriller A QUIET PLACE, a family of four must navigate their lives in silence after mysterious creatures that hunt by sound threaten their survival. If they hear you, they hunt you.',90,'https://cdn.spmovy.xyz/upload_cb6c267712f8bd7191cd60c5f69a1059.jpg','Now Showing');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
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
  `reviewSentence` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int(11) NOT NULL,
  `createdat` datetime NOT NULL,
  `ip` varchar(39) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`reviewID`,`movieID`),
  KEY `movieID` (`movieID`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`movieID`) REFERENCES `movie` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (3,1,'v good movie, wld watch 100000 times.','Javier',4,'2018-05-13 11:18:25','0:0:0:0:0:0:0:1'),(4,2,'sorry but i dont know who the actor is 1/5','Javier',1,'2018-05-14 13:06:11','0:0:0:0:0:0:0:1'),(9,1,'nub\r\n','ray',1,'2018-05-17 11:45:21','0:0:0:0:0:0:0:1'),(114,2,'Size is not everything','Movie Critic',2,'2018-05-17 18:12:15','127.0.0.1'),(191,483,'Was on the edge of the seat for most of the movie!','John Appleseed',5,'2018-05-19 12:59:47','172.17.0.1'),(198,3,'ð???ð???ð???','James',5,'2018-05-19 13:12:18','172.17.0.1'),(199,3,'hello','MylÃ¨ne Farmer',3,'2018-05-19 13:13:32','172.17.0.1'),(200,3,'ð???ð???ð???','MylÃ¨ne Farmer',5,'2018-05-19 13:17:43','172.17.0.1');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
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
INSERT INTO `timeslot` VALUES ('00:00:00','2018-05-09',1),('00:00:00','2018-05-17',1),('00:30:00','2018-05-03',1),('01:30:00','2018-05-03',1),('02:30:00','2018-05-03',1),('00:00:00','2018-05-31',2),('08:00:00','2018-05-01',2),('00:10:00','2018-05-23',3),('08:00:00','2018-05-22',467),('08:00:00','2018-05-22',483),('10:00:00','2018-05-22',483),('12:00:00','2018-05-22',483);
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
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
  PRIMARY KEY (`ID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$12$wskSEkdrPtlD78jLGiI/6e1MMqOTvWZGT/aTwcxP4MqD8o32Mwdjy','admin');
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

-- Dump completed on 2018-05-19 21:31:53
