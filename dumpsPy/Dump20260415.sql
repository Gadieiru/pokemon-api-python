-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: pokemon_database
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `location_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Pueblo Paleta'),(2,'Ciudad Verde'),(3,'Ruta 1'),(4,'Bosque Verde'),(5,'Ruta 2'),(6,'Ciudad Plateada'),(7,'Ruta 3'),(8,'Ruta 4'),(9,'Ciudad Celeste'),(10,'Ruta 24'),(11,'Ruta 25'),(12,'Ruta 5'),(13,'Ruta 6'),(14,'Ciudad Azafrán'),(15,'Ruta 7'),(16,'Ruta 8'),(17,'Ruta 9'),(18,'Ruta 10'),(19,'Ciudad Fucsia'),(20,'Ruta 11'),(21,'Ruta 12'),(22,'Ruta 13'),(23,'Ruta 14'),(24,'Ruta 15'),(25,'Ciudad Celeste - Gimnasio'),(26,'Ruta 16'),(27,'Ruta 17'),(28,'Ruta 18'),(29,'Ciudad Carmín'),(30,'Isla Canela'),(31,'Ruta 19'),(32,'Ruta 20'),(33,'Ruta 21'),(34,'Cueva Diglett'),(35,'Monte Moon'),(36,'Túnel Roca'),(37,'Cueva Celeste'),(38,'Senda Diglett'),(39,'Safari Zone'),(40,'Islas Espuma'),(41,'Cueva Azul'),(42,'Isla del Sur'),(43,'Isla 1'),(44,'Isla 2'),(45,'Isla 3'),(46,'Isla 4'),(47,'Solo se obtiene por medio de un glitch o evento'),(48,'No se puede obtener');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon`
--

DROP TABLE IF EXISTS `pokemon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon` (
  `pokemon_id` int NOT NULL AUTO_INCREMENT,
  `pokemon_name` varchar(30) NOT NULL,
  `initial_happiness` int DEFAULT NULL,
  `capture_rate` int DEFAULT NULL,
  `description` text,
  `rarity_id` int DEFAULT NULL,
  `pokemon_img` varchar(200) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`pokemon_id`),
  KEY `rarity_id` (`rarity_id`),
  KEY `fk_pokemon_user` (`user_id`),
  CONSTRAINT `fk_pokemon_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pokemon_ibfk_1` FOREIGN KEY (`rarity_id`) REFERENCES `rarity` (`rarity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon`
--

LOCK TABLES `pokemon` WRITE;
/*!40000 ALTER TABLE `pokemon` DISABLE KEYS */;
INSERT INTO `pokemon` VALUES (1,'Bulbasaur',70,45,'Pokémon inicial de tipo Planta, disponible solo al inicio del juego',1,'/pokemons/1768419960346.png',NULL),(2,'Ivysaur',70,45,'Evolución de Bulbasaur, se obtiene por nivel, no aparece salvaje',1,'pokemons/002.png',NULL),(3,'Venusaur',70,45,'Última evolución de Bulbasaur, fuerte y confiable',1,'pokemons/003.png',NULL),(4,'Charmander',70,45,'Pokémon inicial de tipo Fuego, disponible solo al inicio del juego',1,'pokemons/004.png',NULL),(5,'Charmeleon',70,45,'Evolución de Charmander, no se encuentra salvaje',1,'pokemons/005.png',NULL),(6,'Charizard',70,45,'Última evolución de Charmander, muy popular entre jugadores',1,'pokemons/006.png',NULL),(7,'Squirtle',70,45,'Pokémon inicial de tipo Agua, disponible solo al inicio del juego',1,'pokemons/007.png',NULL),(8,'Wartortle',70,45,'Evolución de Squirtle, no aparece salvaje',1,'pokemons/008.png',NULL),(9,'Blastoise',70,45,'Última evolución de Squirtle, poderoso tipo Agua',1,'pokemons/009.png',NULL),(10,'Caterpie',70,255,'Pokémon bicho muy común en rutas tempranas',1,'pokemons/010.png',NULL),(11,'Metapod',70,120,'Evolución de Caterpie, se encuentra en bosques',1,'pokemons/011.png',NULL),(12,'Butterfree',70,45,'Evolución final de Caterpie, tipo Bicho/Volador',1,'pokemons/012.png',NULL),(13,'Weedle',70,255,'Pokémon bicho común en bosques iniciales',1,'pokemons/013.png',NULL),(14,'Kakuna',70,120,'Evolución de Weedle, fácil de encontrar en bosques',1,'pokemons/014.png',NULL),(15,'Beedrill',70,45,'Evolución final de Weedle, tipo Bicho/Veneno',1,'pokemons/015.png',NULL),(16,'Pidgey',70,255,'Pokémon volador muy común en rutas tempranas',1,'pokemons/016.png',NULL),(17,'Pidgeotto',70,120,'Evolución de Pidgey, encontrado en rutas intermedias',1,'pokemons/017.png',NULL),(18,'Pidgeot',70,45,'Evolución final de Pidgey, rápido y confiable',1,'pokemons/018.png',NULL),(19,'Rattata',70,255,'Pokémon normal común en casi todas las rutas',1,'pokemons/019.png',NULL),(20,'Raticate',70,127,'Evolución de Rattata, frecuente en zonas urbanas',1,'pokemons/020.png',NULL),(21,'Spearow',70,255,'Pokémon volador común en rutas abiertas',1,'pokemons/021.png',NULL),(22,'Fearow',70,90,'Evolución de Spearow, más rara pero frecuente',1,'pokemons/022.png',NULL),(23,'Ekans',70,255,'Pokémon tipo Veneno, común en algunas versiones',1,'pokemons/023.png',NULL),(24,'Arbok',70,90,'Evolución de Ekans, más difícil de hallar salvaje',1,'pokemons/024.png',NULL),(25,'Pikachu',70,190,'Pokémon eléctrico muy popular, aparece en bosques',1,'pokemons/025.png',NULL),(26,'Raichu',70,75,'Evolución de Pikachu mediante piedra Trueno',1,'pokemons/026.png',NULL),(27,'Sandshrew',70,255,'Pokémon de tipo Tierra, común en zonas áridas',1,'pokemons/027.png',NULL),(28,'Sandslash',70,90,'Evolución de Sandshrew, aparece en zonas desérticas',1,'pokemons/028.png',NULL),(29,'Nidoran♀',70,235,'Pokémon base de línea venenosa, común en rutas iniciales',1,'pokemons/029.png',NULL),(30,'Nidorina',70,120,'Evolución de Nidoran♀, más fuerte pero accesible',1,'pokemons/030.png',NULL),(31,'Nidoqueen',70,45,'Evolución final de Nidoran♀, resistente y poderosa',1,'pokemons/031.png',NULL),(32,'Nidoran♂',70,235,'Pokémon común en rutas iniciales',1,'pokemons/032.png',NULL),(33,'Nidorino',70,120,'Evolución de Nidoran♂, más agresivo y frecuente',1,'pokemons/033.png',NULL),(34,'Nidoking',70,45,'Evolución final de Nidoran♂, poderoso y popular',1,'pokemons/034.png',NULL),(35,'Clefairy',140,150,'Pokémon de tipo Hada, asociado a la luna',2,'pokemons/035.png',NULL),(36,'Clefable',140,25,'Evolución de Clefairy, difícil de encontrar salvaje',2,'pokemons/036.png',NULL),(37,'Vulpix',70,190,'Pokémon de tipo Fuego, común en ciertas rutas',1,'pokemons/037.png',NULL),(38,'Ninetales',70,75,'Evolución de Vulpix con piedra Fuego, elegante y misterioso',3,'pokemons/038.png',NULL),(39,'Jigglypuff',130,170,'Pokémon conocido por su canto somnífero',2,'pokemons/039.png',NULL),(40,'Wigglytuff',130,50,'Evolución de Jigglypuff, amable pero fuerte',2,'pokemons/040.png',NULL),(41,'Zubat',70,255,'Pokémon muy común en cuevas',1,'pokemons/041.png',NULL),(42,'Golbat',70,90,'Evolución de Zubat, frecuente en cuevas profundas',1,'pokemons/042.png',NULL),(43,'Oddish',70,255,'Pokémon de tipo Planta/Veneno, común de noche',1,'pokemons/043.png',NULL),(44,'Gloom',70,120,'Evolución de Oddish, encontrado en bosques',1,'pokemons/044.png',NULL),(45,'Vileplume',70,45,'Evolución final de Oddish, tipo Planta/Veneno',1,'pokemons/045.png',NULL),(46,'Paras',70,190,'Pokémon tipo Bicho/Planta, vive en cuevas y bosques',1,'pokemons/046.png',NULL),(47,'Parasect',70,75,'Evolución de Paras, con hongo parasitario distintivo',1,'pokemons/047.png',NULL),(48,'Venonat',70,190,'Pokémon bicho común en zonas boscosas',1,'pokemons/048.png',NULL),(49,'Venomoth',70,75,'Evolución de Venonat, activa de noche',1,'pokemons/049.png',NULL),(50,'Diglett',70,255,'Pokémon tipo Tierra, común en túneles y cuevas',1,'pokemons/050.png',NULL),(51,'Dugtrio',70,50,'Evolución de Diglett, vive en túneles profundos',1,'pokemons/051.png',NULL),(52,'Meowth',70,255,'Pokémon normal, aparece en zonas urbanas y rutas intermedias',1,'pokemons/052.png',NULL),(53,'Persian',70,90,'Evolución de Meowth, ágil y elegante',1,'pokemons/053.png',NULL),(54,'Psyduck',70,190,'Pokémon de tipo Agua, común en lagos y ríos',1,'pokemons/054.png',NULL),(55,'Golduck',70,75,'Evolución de Psyduck, más fuerte y confiado',1,'pokemons/055.png',NULL),(56,'Mankey',70,190,'Pokémon de tipo Lucha, común en montañas',1,'pokemons/056.png',NULL),(57,'Primeape',70,75,'Evolución de Mankey, agresivo y poderoso',1,'pokemons/057.png',NULL),(58,'Growlithe',70,190,'Pokémon de tipo Fuego, común en rutas calurosas',1,'pokemons/058.png',NULL),(59,'Arcanine',70,75,'Evolución de Growlithe mediante piedra Fuego, noble y fuerte',3,'pokemons/059.png',NULL),(60,'Poliwag',70,255,'Pokémon de tipo Agua, muy común en estanques',1,'pokemons/060.png',NULL),(61,'Poliwhirl',70,120,'Evolución de Poliwag, aparece en cuerpos de agua',1,'pokemons/061.png',NULL),(62,'Poliwrath',70,45,'Evolución final de Poliwag, tipo Agua/Lucha',1,'pokemons/062.png',NULL),(63,'Abra',70,200,'Pokémon psíquico común en rutas tempranas',1,'pokemons/063.png',NULL),(64,'Kadabra',70,100,'Evolución de Abra, más poderoso y confiable',1,'pokemons/064.png',NULL),(65,'Alakazam',70,50,'Evolución final de Abra, muy poderoso en combate',3,'pokemons/065.png',NULL),(66,'Machop',70,180,'Pokémon de tipo Lucha, común en cuevas',1,'pokemons/066.png',NULL),(67,'Machoke',70,90,'Evolución de Machop, aparece en áreas montañosas',1,'pokemons/067.png',NULL),(68,'Machamp',70,45,'Evolución final de Machop, fuerte y musculoso',1,'pokemons/068.png',NULL),(69,'Bellsprout',70,255,'Pokémon tipo Planta/Veneno, común en rutas templadas',1,'pokemons/069.png',NULL),(70,'Weepinbell',70,120,'Evolución de Bellsprout, más agresivo',1,'pokemons/070.png',NULL),(71,'Victreebel',70,45,'Evolución final de Bellsprout, depredador vegetal',1,'pokemons/071.png',NULL),(72,'Tentacool',70,190,'Pokémon tipo Agua/Veneno, común en mares',1,'pokemons/072.png',NULL),(73,'Tentacruel',70,60,'Evolución de Tentacool, más raro pero frecuente en el océano',1,'pokemons/073.png',NULL),(74,'Geodude',70,255,'Pokémon tipo Roca/Tierra, muy común en cuevas',1,'pokemons/074.png',NULL),(75,'Graveler',70,120,'Evolución de Geodude, fuerte y resistente',1,'pokemons/075.png',NULL),(76,'Golem',70,45,'Evolución final de Geodude, sólido y poderoso',1,'pokemons/076.png',NULL),(77,'Ponyta',70,190,'Pokémon de tipo Fuego, común en llanuras',1,'pokemons/077.png',NULL),(78,'Rapidash',70,60,'Evolución de Ponyta, veloz y elegante',1,'pokemons/078.png',NULL),(79,'Slowpoke',70,190,'Pokémon de tipo Agua/Psíquico, lento y relajado',1,'pokemons/079.png',NULL),(80,'Slowbro',70,75,'Evolución de Slowpoke, más inteligente y fuerte',1,'pokemons/080.png',NULL),(81,'Magnemite',70,190,'Pokémon tipo Eléctrico/Acero, común en centrales eléctricas',1,'pokemons/081.png',NULL),(82,'Magneton',70,60,'Evolución de Magnemite, más potente',1,'pokemons/082.png',NULL),(83,'Farfetch’d',70,45,'Pokémon con un puerro, poco común y tradicional',2,'pokemons/083.png',NULL),(84,'Doduo',70,190,'Pokémon volador de dos cabezas, aparece en rutas abiertas',1,'pokemons/084.png',NULL),(85,'Dodrio',70,45,'Evolución de Doduo, más rápido y raro',1,'pokemons/085.png',NULL),(86,'Seel',70,190,'Pokémon tipo Agua/Hielo, común en mares fríos',1,'pokemons/086.png',NULL),(87,'Dewgong',70,75,'Evolución de Seel, más fuerte y adaptable',1,'pokemons/087.png',NULL),(88,'Grimer',70,190,'Pokémon tipo Veneno, común en zonas industriales',1,'pokemons/088.png',NULL),(89,'Muk',70,75,'Evolución de Grimer, grande y contaminante',1,'pokemons/089.png',NULL),(90,'Shellder',70,190,'Pokémon tipo Agua, común en mares',1,'pokemons/090.png',NULL),(91,'Cloyster',70,60,'Evolución de Shellder mediante piedra Agua',1,'pokemons/091.png',NULL),(92,'Gastly',70,190,'Pokémon tipo Fantasma/Veneno, aparece en torres',1,'pokemons/092.png',NULL),(93,'Haunter',70,90,'Evolución de Gastly, más poderoso y temible',1,'pokemons/093.png',NULL),(94,'Gengar',70,45,'Evolución final de Gastly, fuerte y popular en combate',3,'pokemons/094.png',NULL),(95,'Onix',70,45,'Pokémon tipo Roca/Tierra, muy resistente en cuevas',1,'pokemons/095.png',NULL),(96,'Drowzee',70,190,'Pokémon tipo Psíquico, común cerca de ciudades',1,'pokemons/096.png',NULL),(97,'Hypno',70,75,'Evolución de Drowzee, más poderoso mentalmente',1,'pokemons/097.png',NULL),(98,'Krabby',70,225,'Pokémon tipo Agua, común en playas y ríos',1,'pokemons/098.png',NULL),(99,'Kingler',70,60,'Evolución de Krabby, más fuerte y territorial',1,'pokemons/099.png',NULL),(100,'Voltorb',70,190,'Pokémon tipo Eléctrico, común en centrales y plantas de energía',1,'pokemons/100.png',NULL),(101,'Electrode',70,60,'Evolución de Voltorb, más veloz y difícil de atrapar',1,'pokemons/101.png',NULL),(102,'Exeggcute',70,90,'Pokémon tipo Planta, se encuentra en bosques y jardines',1,'pokemons/102.png',NULL),(103,'Exeggutor',70,45,'Evolución de Exeggcute, tipo Planta/Psíquico',1,'pokemons/103.png',NULL),(104,'Cubone',70,190,'Pokémon tipo Tierra, frecuente cerca de cuevas y montañas',4,'pokemons/104.png',NULL),(105,'Marowak',70,75,'Evolución de Cubone, más fuerte y resistente',4,'pokemons/105.png',NULL),(106,'Hitmonlee',70,45,'Pokémon tipo Lucha, rápido y ágil en combate',5,'pokemons/106.png',NULL),(107,'Hitmonchan',70,45,'Evolución de Hitmonlee, especializado en patadas',5,'pokemons/107.png',NULL),(108,'Lickitung',70,90,'Pokémon raro, con lengua larga y ataque inusual',6,'pokemons/108.png',NULL),(109,'Koffing',70,190,'Pokémon tipo Veneno, común en áreas industriales',7,'pokemons/109.png',NULL),(110,'Weezing',70,60,'Evolución de Koffing, más peligroso por gases tóxicos',7,'pokemons/110.png',NULL),(111,'Rhyhorn',70,120,'Pokémon tipo Roca/Tierra, resistente y agresivo',8,'pokemons/111.png',NULL),(112,'Rhydon',70,60,'Evolución de Rhyhorn, muy fuerte y grande',8,'pokemons/112.png',NULL),(113,'Chansey',140,30,'Pokémon de tipo Normal, enorme y pacífico',2,'pokemons/113.png',NULL),(114,'Tangela',70,45,'Pokémon tipo Planta, trepador y encontrado en hierbas',1,'pokemons/114.png',NULL),(115,'Kangaskhan',70,45,'Pokémon tipo Normal, fuerte y común en rutas',1,'pokemons/115.png',NULL),(116,'Horsea',70,225,'Pokémon de tipo Agua, común en mares y ríos',1,'pokemons/116.png',NULL),(117,'Seadra',70,75,'Evolución de Horsea, más difícil de atrapar',1,'pokemons/117.png',NULL),(118,'Goldeen',70,225,'Pokémon tipo Agua, común en lagos y ríos',1,'pokemons/118.png',NULL),(119,'Seaking',70,60,'Evolución de Goldeen, elegante y rápido',1,'pokemons/119.png',NULL),(120,'Staryu',70,225,'Pokémon tipo Agua, encontrado en mares y océanos',1,'pokemons/120.png',NULL),(121,'Starmie',70,60,'Evolución de Staryu, más raro y poderoso',1,'pokemons/121.png',NULL),(122,'Mr. Mime',70,45,'Pokémon psíquico raro, interactúa con humanos',2,'pokemons/122.png',NULL),(123,'Scyther',70,45,'Pokémon tipo Bicho/Volador, fuerte y competitivo',9,'pokemons/123.png',NULL),(124,'Jynx',70,45,'Pokémon de hielo/psíquico, difícil de atrapar',13,'pokemons/124.png',NULL),(125,'Electabuzz',70,45,'Pokémon eléctrico raro, poderoso en combate',12,'pokemons/125.png',NULL),(126,'Magmar',70,45,'Pokémon tipo fuego, potente y agresivo',12,'pokemons/126.png',NULL),(127,'Pinsir',70,45,'Pokémon tipo Bicho, fuerte y rápido',9,'pokemons/127.png',NULL),(128,'Tauros',70,45,'Pokémon normal salvaje, rápido y peligroso',10,'pokemons/128.png',NULL),(129,'Magikarp',70,255,'Pokémon de agua muy débil al inicio, común en ríos',1,'pokemons/129.png',NULL),(130,'Gyarados',70,45,'Evolución de Magikarp, grande y devastador',10,'pokemons/130.png',NULL),(131,'Lapras',70,45,'Pokémon tipo Agua/Hielo, muy amigable y confiable',2,'pokemons/131.png',NULL),(132,'Ditto',70,35,'Pokémon capaz de transformarse en cualquier otro',13,'pokemons/132.png',NULL),(133,'Eevee',70,45,'Pokémon tipo Normal, base para evoluciones',1,'pokemons/133.png',NULL),(134,'Vaporeon',70,45,'Evolución de Eevee, de tipo Agua, adaptable y confiable',2,'pokemons/134.png',NULL),(135,'Jolteon',70,45,'Evolución de Eevee, tipo Eléctrico, rápida y poderosa',12,'pokemons/135.png',NULL),(136,'Flareon',70,45,'Evolución de Eevee, tipo Fuego, confiable en combate',11,'pokemons/136.png',NULL),(137,'Porygon',70,45,'Pokémon artificial, difícil de obtener',13,'pokemons/137.png',NULL),(138,'Omanyte',70,45,'Pokémon prehistórico, encontrado en fósiles',8,'pokemons/138.png',NULL),(139,'Omastar',70,45,'Evolución de Omanyte, fuerte y resistente',8,'pokemons/139.png',NULL),(140,'Kabuto',70,45,'Pokémon prehistórico, rápido y agresivo',8,'pokemons/140.png',NULL),(141,'Kabutops',70,45,'Evolución de Kabuto, poderoso y resistente',8,'pokemons/141.png',NULL),(142,'Aerodactyl',70,45,'Pokémon prehistórico volador, muy fuerte en combate',10,'pokemons/142.png',NULL),(143,'Snorlax',70,25,'Pokémon grande y pacífico, famoso por dormir',2,'pokemons/143.png',NULL),(144,'Articuno',0,3,'Pokémon legendario de hielo, difícil de atrapar',14,'pokemons/144.png',NULL),(145,'Zapdos',0,3,'Pokémon legendario eléctrico, muy raro',14,'pokemons/145.png',NULL),(146,'Moltres',0,3,'Pokémon legendario de fuego, extremadamente raro',14,'pokemons/146.png',NULL),(147,'Dratini',70,45,'Pokémon dragón raro, aparece en cuerpos de agua',13,'pokemons/147.png',NULL),(148,'Dragonair',70,45,'Evolución de Dratini, elegante y poderoso',13,'pokemons/148.png',NULL),(149,'Dragonite',70,45,'Última evolución de Dratini, muy fuerte y veloz',10,'pokemons/149.png',NULL),(150,'Mewtwo',0,3,'Pokémon psíquico legendario, extremadamente raro',14,'pokemons/150.png',NULL),(151,'Mew',100,45,'Pokémon mítico, único y muy difícil de conseguir',13,'pokemons/151.png',NULL);
/*!40000 ALTER TABLE `pokemon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_location`
--

DROP TABLE IF EXISTS `pokemon_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_location` (
  `pokemon_id` int NOT NULL,
  `location_id` int NOT NULL,
  PRIMARY KEY (`pokemon_id`,`location_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `pokemon_location_ibfk_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`pokemon_id`),
  CONSTRAINT `pokemon_location_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_location`
--

LOCK TABLES `pokemon_location` WRITE;
/*!40000 ALTER TABLE `pokemon_location` DISABLE KEYS */;
INSERT INTO `pokemon_location` VALUES (1,1),(4,1),(7,1),(16,3),(17,3),(19,3),(20,3),(21,3),(29,3),(30,3),(32,3),(33,3),(10,4),(11,4),(13,4),(16,4),(17,4),(19,4),(20,4),(23,4),(25,4),(26,4),(39,4),(40,4),(43,4),(44,4),(45,4),(46,4),(47,4),(48,4),(49,4),(103,4),(114,4),(123,4),(127,4),(10,5),(13,5),(21,5),(22,5),(24,5),(27,5),(28,5),(31,5),(34,5),(37,5),(38,5),(52,5),(53,5),(107,6),(133,6),(137,6),(56,7),(57,7),(102,8),(54,10),(60,10),(63,10),(64,10),(65,10),(72,10),(129,10),(130,10),(12,11),(14,11),(15,11),(55,11),(61,11),(62,11),(73,11),(79,11),(69,12),(70,12),(71,12),(58,15),(59,15),(77,15),(78,15),(83,15),(88,16),(89,16),(108,16),(109,16),(110,16),(115,16),(81,18),(82,18),(100,18),(101,18),(111,18),(124,18),(125,18),(134,18),(135,18),(136,18),(80,19),(96,20),(128,20),(97,21),(122,21),(126,21),(132,21),(143,21),(84,26),(85,27),(87,30),(91,30),(99,30),(117,30),(119,30),(121,30),(131,30),(146,30),(86,31),(90,31),(116,31),(98,33),(118,33),(120,33),(41,34),(42,34),(50,34),(51,34),(104,34),(105,34),(35,35),(36,35),(41,35),(42,35),(66,35),(67,35),(68,35),(74,35),(75,35),(76,35),(95,35),(106,35),(112,35),(142,35),(92,37),(93,37),(94,37),(150,37),(113,39),(147,39),(148,39),(149,39),(144,40),(145,41),(138,42),(139,42),(140,42),(141,42),(151,47),(2,48),(3,48),(5,48),(6,48),(8,48),(9,48),(18,48);
/*!40000 ALTER TABLE `pokemon_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pokemon_types`
--

DROP TABLE IF EXISTS `pokemon_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pokemon_types` (
  `pokemon_id` int NOT NULL,
  `types_id` int NOT NULL,
  PRIMARY KEY (`pokemon_id`,`types_id`),
  KEY `types_id` (`types_id`),
  CONSTRAINT `pokemon_types_ibfk_1` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`pokemon_id`),
  CONSTRAINT `pokemon_types_ibfk_2` FOREIGN KEY (`types_id`) REFERENCES `types` (`types_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokemon_types`
--

LOCK TABLES `pokemon_types` WRITE;
/*!40000 ALTER TABLE `pokemon_types` DISABLE KEYS */;
INSERT INTO `pokemon_types` VALUES (16,1),(17,1),(18,1),(19,1),(20,1),(52,1),(53,1),(83,1),(108,1),(113,1),(115,1),(128,1),(132,1),(133,1),(137,1),(143,1),(151,1),(4,2),(5,2),(6,2),(37,2),(38,2),(58,2),(59,2),(77,2),(78,2),(126,2),(136,2),(146,2),(7,3),(8,3),(9,3),(54,3),(55,3),(60,3),(61,3),(62,3),(72,3),(73,3),(79,3),(80,3),(86,3),(87,3),(90,3),(91,3),(98,3),(99,3),(116,3),(117,3),(118,3),(119,3),(120,3),(121,3),(129,3),(130,3),(131,3),(134,3),(138,3),(139,3),(140,3),(141,3),(142,3),(1,4),(2,4),(3,4),(43,4),(44,4),(45,4),(46,4),(47,4),(69,4),(70,4),(71,4),(102,4),(103,4),(114,4),(25,5),(26,5),(81,5),(82,5),(100,5),(101,5),(125,5),(135,5),(145,5),(124,6),(131,6),(144,6),(56,7),(57,7),(62,7),(66,7),(67,7),(68,7),(106,7),(107,7),(23,8),(24,8),(29,8),(30,8),(31,8),(32,8),(33,8),(34,8),(41,8),(42,8),(69,8),(70,8),(71,8),(72,8),(73,8),(88,8),(89,8),(92,8),(93,8),(94,8),(109,8),(110,8),(27,9),(28,9),(50,9),(51,9),(74,9),(75,9),(76,9),(95,9),(104,9),(105,9),(111,9),(112,9),(6,10),(21,10),(22,10),(84,10),(85,10),(123,10),(130,10),(144,10),(145,10),(146,10),(149,10),(63,11),(64,11),(65,11),(79,11),(80,11),(96,11),(97,11),(102,11),(103,11),(122,11),(124,11),(150,11),(10,12),(11,12),(12,12),(13,12),(14,12),(15,12),(46,12),(47,12),(48,12),(49,12),(123,12),(127,12),(74,13),(75,13),(76,13),(81,13),(82,13),(95,13),(111,13),(112,13),(138,13),(139,13),(140,13),(141,13),(142,13),(92,14),(93,14),(94,14),(147,15),(148,15),(149,15),(35,16),(36,16),(39,16),(40,16);
/*!40000 ALTER TABLE `pokemon_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rarity`
--

DROP TABLE IF EXISTS `rarity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rarity` (
  `rarity_id` int NOT NULL AUTO_INCREMENT,
  `rarity_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`rarity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rarity`
--

LOCK TABLES `rarity` WRITE;
/*!40000 ALTER TABLE `rarity` DISABLE KEYS */;
INSERT INTO `rarity` VALUES (1,'Común'),(2,'Amistosa'),(3,'Mística'),(4,'Melancólica'),(5,'Fuerte'),(6,'Excéntrica'),(7,'Tóxica'),(8,'Ruda'),(9,'Agresiva'),(10,'Feroz'),(11,'Leal'),(12,'Explosiva'),(13,'Misteriosa'),(14,'Legendaria');
/*!40000 ALTER TABLE `rarity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `types_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(30) NOT NULL,
  PRIMARY KEY (`types_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'Normal'),(2,'Fuego'),(3,'Agua'),(4,'Planta'),(5,'Eléctrico'),(6,'Hielo'),(7,'Lucha'),(8,'Veneno'),(9,'Tierra'),(10,'Volador'),(11,'Psíquico'),(12,'Bicho'),(13,'Roca'),(14,'Fantasma'),(15,'Dragón'),(16,'Hada');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Romeo','Santos','RomeoSantos55.t@gmail.com','$2b$10$MkQSJL/7FpUBwRm4l9dHzed4b7NDcvWdr3LueRynbserEY1NLAsK6','2025-12-17 20:20:13'),(2,'root','root88','rooter@gmail.com','$2b$10$3ARGjZeIvs0CS/zFJnbqx.Am4iauCsxTxKgd4NE2gB.vEN6z.3an2','2025-12-17 20:23:56'),(3,'Persona','Fuentes','Fuentes@gmail.com','$2b$10$9a6YiAY/8l2p84h2zej7AeR0SXoFNMAlxY7WuMmssf83WbAySUetO','2026-01-05 22:00:03'),(4,'Gadiel','Romero','diosesmiluz53@gmail.com','scrypt:32768:8:1$mLByA0HGAe2sQG1c$99a16676adabe104e162a3db22faa6fe6168695f6e99b6d099026772353bc5967de674e61b3ce789b8c39cc03c2ae66021980a1f2c0dce0f7b9c851992035bb9','2026-03-30 20:55:29'),(5,'Ramiro','Ramirez','RamiroRamirez@gmail.com','scrypt:32768:8:1$s3zMrzs6TKBRGDk9$f40662096691090b0e9cceb6017070ddde624378ac0d95c86c50afc4f40749678898d3a35d62ca3e9d33aff6d0bf8ed4e1bdb1edc31ec49751d594bdaac51013','2026-04-01 19:09:27');
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

-- Dump completed on 2026-04-15 15:27:22
