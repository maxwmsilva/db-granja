CREATE DATABASE  IF NOT EXISTS `granja` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `granja`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: granja
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `cliente_has_vendas`
--

DROP TABLE IF EXISTS `cliente_has_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_has_vendas` (
  `cliente_id` int NOT NULL,
  `vendas_id` int NOT NULL,
  `quantidade` int DEFAULT NULL,
  PRIMARY KEY (`cliente_id`,`vendas_id`),
  KEY `vendas_id` (`vendas_id`),
  CONSTRAINT `cliente_has_vendas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `cliente_has_vendas_ibfk_2` FOREIGN KEY (`vendas_id`) REFERENCES `vendas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_has_vendas`
--

LOCK TABLES `cliente_has_vendas` WRITE;
/*!40000 ALTER TABLE `cliente_has_vendas` DISABLE KEYS */;
INSERT INTO `cliente_has_vendas` VALUES (1,1,100),(1,2,50),(2,1,60),(2,2,120),(3,1,110),(3,2,80);
/*!40000 ALTER TABLE `cliente_has_vendas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `atualiza_estoque_venda` AFTER INSERT ON `cliente_has_vendas` FOR EACH ROW BEGIN
    DECLARE estoque_id INT;

    -- Armazena o ID do estoque correspondente em uma variável
    SELECT id INTO estoque_id
    FROM estoque
    WHERE tipo = 'Tipo desejado'
    LIMIT 1;

    -- Atualiza o estoque usando a variável
    IF estoque_id IS NOT NULL THEN
        UPDATE estoque
        SET quantidade = quantidade - NEW.quantidade
        WHERE id = estoque_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `contato` varchar(45) DEFAULT NULL,
  `endereco` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Maria Silva','11987654321','Rua A, 123','2024-12-04 12:57:30','2024-12-04 12:57:30'),(2,'João Oliveira','21987654321','Rua B, 456','2024-12-04 12:57:30','2024-12-04 12:57:30'),(4,'Maria Silva','11987654321','Rua A, 123','2024-12-04 12:53:28','2024-12-04 12:53:28'),(5,'João Oliveira','21987654321','Rua B, 456','2024-12-04 12:53:28','2024-12-04 12:53:28'),(6,'Ana Souza','31987654321','Rua C, 789','2024-12-04 12:53:28','2024-12-04 12:53:28'),(7,'Maria Silva','11987654321','Rua A, 123','2024-12-04 13:01:51','2024-12-04 13:01:51'),(8,'João Oliveira','21987654321','Rua B, 456','2024-12-04 13:01:51','2024-12-04 13:01:51'),(9,'Ana Souza','31987654321','Rua C, 789','2024-12-04 13:01:51','2024-12-04 13:01:51');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `data_producao` date DEFAULT NULL,
  `funcionarios_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `produtos_id` int NOT NULL,
  `ovos_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `funcionarios_id` (`funcionarios_id`),
  KEY `fk_estoque_produtos1_idx` (`produtos_id`),
  KEY `fk_estoque_ovos1_idx` (`ovos_id`),
  CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`),
  CONSTRAINT `fk_estoque_funcionarios` FOREIGN KEY (`funcionarios_id`) REFERENCES `funcionarios` (`id`),
  CONSTRAINT `fk_estoque_ovos1` FOREIGN KEY (`ovos_id`) REFERENCES `ovos` (`id`),
  CONSTRAINT `fk_estoque_produtos1` FOREIGN KEY (`produtos_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,'produto',50,'2024-12-01',1,'2024-12-04 13:05:59','2024-12-04 13:05:59',1,1),(2,'ovo',200,'2024-12-01',2,'2024-12-04 13:05:59','2024-12-04 13:05:59',1,1);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `contato` varchar(45) DEFAULT NULL,
  `endereco` text,
  `tipo_produto` enum('ração','medicamento','outros') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES (1,'Fornecedor A','62987654321','Estrada D, 101','ração','2024-12-04 13:06:45','2024-12-04 13:06:45'),(2,'Fornecedor B','72987654321','Estrada E, 202','medicamento','2024-12-04 13:06:45','2024-12-04 13:06:45');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores_has_produtos`
--

DROP TABLE IF EXISTS `fornecedores_has_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores_has_produtos` (
  `fornecedores_id` int NOT NULL,
  `produtos_id` int NOT NULL,
  PRIMARY KEY (`fornecedores_id`,`produtos_id`),
  KEY `fk_fornecedores_has_produtos_produtos1_idx` (`produtos_id`),
  KEY `fk_fornecedores_has_produtos_fornecedores1_idx` (`fornecedores_id`),
  CONSTRAINT `fk_fornecedores_has_produtos_fornecedores1` FOREIGN KEY (`fornecedores_id`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `fk_fornecedores_has_produtos_produtos1` FOREIGN KEY (`produtos_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores_has_produtos`
--

LOCK TABLES `fornecedores_has_produtos` WRITE;
/*!40000 ALTER TABLE `fornecedores_has_produtos` DISABLE KEYS */;
INSERT INTO `fornecedores_has_produtos` VALUES (1,1);
/*!40000 ALTER TABLE `fornecedores_has_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionarios`
--

DROP TABLE IF EXISTS `funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `contato` varchar(45) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionarios`
--

LOCK TABLES `funcionarios` WRITE;
/*!40000 ALTER TABLE `funcionarios` DISABLE KEYS */;
INSERT INTO `funcionarios` VALUES (1,'Carlos Lima','Gerente','42987654321','2024-12-04 13:02:49','2024-12-04 13:02:49'),(2,'Paula Ramos','Produtora','51987654321','2024-12-04 13:02:49','2024-12-04 13:02:49');
/*!40000 ALTER TABLE `funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galinhas`
--

DROP TABLE IF EXISTS `galinhas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `galinhas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `status` enum('ativa','inativa') DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galinhas`
--

LOCK TABLES `galinhas` WRITE;
/*!40000 ALTER TABLE `galinhas` DISABLE KEYS */;
INSERT INTO `galinhas` VALUES (1,'Poedeira','2023-01-01','ativa','2024-12-04 13:03:02','2024-12-04 13:03:02'),(2,'Caipira','2023-06-15','ativa','2024-12-04 13:03:02','2024-12-04 13:03:02');
/*!40000 ALTER TABLE `galinhas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovos`
--

DROP TABLE IF EXISTS `ovos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ovos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  `data_producao` date DEFAULT NULL,
  `galinha_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `galinha_id` (`galinha_id`),
  CONSTRAINT `ovos_ibfk_1` FOREIGN KEY (`galinha_id`) REFERENCES `galinhas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovos`
--

LOCK TABLES `ovos` WRITE;
/*!40000 ALTER TABLE `ovos` DISABLE KEYS */;
INSERT INTO `ovos` VALUES (1,'Grande','2024-12-01',1,'2024-12-04 13:03:13','2024-12-04 13:03:13'),(2,'Médio','2024-12-02',2,'2024-12-04 13:03:13','2024-12-04 13:03:13');
/*!40000 ALTER TABLE `ovos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ovos_has_vendas`
--

DROP TABLE IF EXISTS `ovos_has_vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ovos_has_vendas` (
  `ovos_id` int NOT NULL,
  `vendas_id` int NOT NULL,
  PRIMARY KEY (`ovos_id`,`vendas_id`),
  KEY `fk_ovos_has_vendas_vendas1_idx` (`vendas_id`),
  KEY `fk_ovos_has_vendas_ovos1_idx` (`ovos_id`),
  CONSTRAINT `fk_ovos_has_vendas_ovos1` FOREIGN KEY (`ovos_id`) REFERENCES `ovos` (`id`),
  CONSTRAINT `fk_ovos_has_vendas_vendas1` FOREIGN KEY (`vendas_id`) REFERENCES `vendas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ovos_has_vendas`
--

LOCK TABLES `ovos_has_vendas` WRITE;
/*!40000 ALTER TABLE `ovos_has_vendas` DISABLE KEYS */;
INSERT INTO `ovos_has_vendas` VALUES (1,1);
/*!40000 ALTER TABLE `ovos_has_vendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `descricao` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'Ração Premium','Ração de alta qualidade para galinhas.','2024-12-04 13:03:21','2024-12-04 13:03:21'),(2,'Vacina para aves','Proteção contra doenças aviárias.','2024-12-04 13:03:21','2024-12-04 13:03:21');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `relatorio_vendas`
--

DROP TABLE IF EXISTS `relatorio_vendas`;
/*!50001 DROP VIEW IF EXISTS `relatorio_vendas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `relatorio_vendas` AS SELECT 
 1 AS `data_venda`,
 1 AS `cliente`,
 1 AS `valor_total`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `vendas`
--

DROP TABLE IF EXISTS `vendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_venda` date DEFAULT NULL,
  `valor_total` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendas`
--

LOCK TABLES `vendas` WRITE;
/*!40000 ALTER TABLE `vendas` DISABLE KEYS */;
INSERT INTO `vendas` VALUES (1,'2024-12-01',150.50,'2024-12-04 13:01:17','2024-12-04 13:01:17'),(2,'2024-12-02',200.75,'2024-12-04 13:01:17','2024-12-04 13:01:17'),(3,'2024-12-03',100.25,'2024-12-04 13:01:17','2024-12-04 13:01:17'),(6,'2024-12-03',150.00,'2024-12-04 12:55:19','2024-12-04 12:55:19'),(7,'2024-12-04',200.00,'2024-12-04 12:55:19','2024-12-04 12:55:19');
/*!40000 ALTER TABLE `vendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'granja'
--

--
-- Dumping routines for database 'granja'
--

--
-- Final view structure for view `relatorio_vendas`
--

/*!50001 DROP VIEW IF EXISTS `relatorio_vendas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `relatorio_vendas` AS select `v`.`data_venda` AS `data_venda`,`c`.`nome` AS `cliente`,`v`.`valor_total` AS `valor_total`,`chv`.`quantidade` AS `quantidade` from ((`vendas` `v` join `cliente_has_vendas` `chv` on((`v`.`id` = `chv`.`vendas_id`))) join `clientes` `c` on((`chv`.`cliente_id` = `c`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-04 11:26:38
