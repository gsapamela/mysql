CREATE DATABASE  IF NOT EXISTS `logexpress` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `logexpress`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: logexpress
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `centros_de_distribuicoes`
--

DROP TABLE IF EXISTS `centros_de_distribuicoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centros_de_distribuicoes` (
  `id_centro_distribuicao` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL,
  `contato` varchar(255) NOT NULL,
  PRIMARY KEY (`id_centro_distribuicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centros_de_distribuicoes`
--

LOCK TABLES `centros_de_distribuicoes` WRITE;
/*!40000 ALTER TABLE `centros_de_distribuicoes` DISABLE KEYS */;
INSERT INTO `centros_de_distribuicoes` VALUES ('CD001','Centro de Distribuição Mogi das Cruzes','Av. Francisco Rodrigues Filho, 1000','Mogi das Cruzes','SP','1140011001'),('CD002','Centro de Distribuição São Paulo','Av. das Nações Unidas, 2500','São Paulo','SP','1140022002'),('CD003','Centro de Distribuição Campinas','Av. John Boyd Dunlop, 1500','Campinas','SP','1940033003'),('CD004','Centro de Distribuição Santos','Av. Ana Costa, 800','Santos','SP','1340044004'),('CD005','Centro de Distribuição São José dos Campos','Av. Cassiano Ricardo, 1200','São José dos Campos','SP','1240055005');
/*!40000 ALTER TABLE `centros_de_distribuicoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cpf_cnpj` varchar(20) NOT NULL,
  `contato` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf_cnpj` (`cpf_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES ('CLI001','Maria Oliveira','12345678901','11999999999','maria@gmail.com'),('CLI002','Industria comunicacao ltda','60815026000145','11985251478','ind_com@hotmail.com'),('CLI003','Robert Vinicius','56258718805','11952149875','robinho@hotmail.com'),('CLI004','GM COMERCIO LTDA','0152506000166','11988559977','gm@hotmail.com'),('CLI005','Vivian Mari','05808925518','11977551144','vivi@hotmail.com'),('CLI006','Fred Oliver','12827815406','11988552244','fred@email.com');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encomenda_rota`
--

DROP TABLE IF EXISTS `encomenda_rota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encomenda_rota` (
  `id_encomenda` varchar(255) NOT NULL,
  `id_rota_viagem` varchar(255) NOT NULL,
  PRIMARY KEY (`id_encomenda`,`id_rota_viagem`),
  KEY `fk_encomenda_rota_viagens` (`id_rota_viagem`),
  CONSTRAINT `fk_encomenda_rota_encomendas` FOREIGN KEY (`id_encomenda`) REFERENCES `encomendas` (`id_encomenda`),
  CONSTRAINT `fk_encomenda_rota_viagens` FOREIGN KEY (`id_rota_viagem`) REFERENCES `rota_viagens` (`id_rota_viagem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encomenda_rota`
--

LOCK TABLES `encomenda_rota` WRITE;
/*!40000 ALTER TABLE `encomenda_rota` DISABLE KEYS */;
INSERT INTO `encomenda_rota` VALUES ('ENC001','ROT001'),('ENC002','ROT001'),('ENC003','ROT002'),('ENC004','ROT003'),('ENC005','ROT004');
/*!40000 ALTER TABLE `encomenda_rota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encomendas`
--

DROP TABLE IF EXISTS `encomendas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encomendas` (
  `id_encomenda` varchar(255) NOT NULL,
  `id_cliente` varchar(255) NOT NULL,
  `codigo_rastreamento` varchar(255) NOT NULL,
  `data_postagem` date NOT NULL,
  `status_encomenda` varchar(255) NOT NULL DEFAULT 'POSTADA',
  `endereco_origem` varchar(255) NOT NULL,
  `endereco_destino` varchar(255) NOT NULL,
  PRIMARY KEY (`id_encomenda`),
  UNIQUE KEY `codigo_rastreamento` (`codigo_rastreamento`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `encomendas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encomendas`
--

LOCK TABLES `encomendas` WRITE;
/*!40000 ALTER TABLE `encomendas` DISABLE KEYS */;
INSERT INTO `encomendas` VALUES ('ENC001','CLI001','LOG20260001','2026-10-20','Postada','Mogi das Cruzes - SP','São Paulo - SP'),('ENC002','CLI002','LOG20260002','2026-10-20','Em transporte','São Paulo - SP','Campinas - SP'),('ENC003','CLI003','LOG20260003','2026-10-20','Em separação','Campinas - SP','Santos - SP'),('ENC004','CLI004','LOG20260004','2026-10-20','Aguardando transporte','Santos - SP','São José dos Campos - SP'),('ENC005','CLI005','LOG20260005','2026-10-20','Postada','São José dos Campos - SP','Mogi das Cruzes - SP');
/*!40000 ALTER TABLE `encomendas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_rastreamento`
--

DROP TABLE IF EXISTS `historico_rastreamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico_rastreamento` (
  `id_historico_rastreamento` varchar(255) NOT NULL,
  `data_hora` datetime NOT NULL,
  `status_encomenda` varchar(255) NOT NULL,
  `id_centro_distribuicao` varchar(255) NOT NULL,
  `id_encomenda` varchar(255) NOT NULL,
  PRIMARY KEY (`id_historico_rastreamento`),
  KEY `id_centro_distribuicao` (`id_centro_distribuicao`),
  KEY `id_encomenda` (`id_encomenda`),
  CONSTRAINT `historico_rastreamento_ibfk_1` FOREIGN KEY (`id_centro_distribuicao`) REFERENCES `centros_de_distribuicoes` (`id_centro_distribuicao`),
  CONSTRAINT `historico_rastreamento_ibfk_2` FOREIGN KEY (`id_encomenda`) REFERENCES `encomendas` (`id_encomenda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_rastreamento`
--

LOCK TABLES `historico_rastreamento` WRITE;
/*!40000 ALTER TABLE `historico_rastreamento` DISABLE KEYS */;
INSERT INTO `historico_rastreamento` VALUES ('HIS001','2026-10-20 08:30:00','Postada','CD001','ENC001'),('HIS002','2026-10-20 10:15:00','Em transporte','CD002','ENC002'),('HIS003','2026-10-20 11:45:00','Em separação','CD003','ENC003'),('HIS004','2026-10-20 14:20:00','Aguardando transporte','CD004','ENC004'),('HIS005','2026-10-20 16:00:00','Recebida no centro','CD005','ENC005');
/*!40000 ALTER TABLE `historico_rastreamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `motoristas`
--

DROP TABLE IF EXISTS `motoristas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motoristas` (
  `id_motorista` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `numero_cnh` varchar(255) NOT NULL,
  `contato` varchar(255) NOT NULL,
  `observacao` varchar(255) NOT NULL,
  PRIMARY KEY (`id_motorista`),
  UNIQUE KEY `numero_cnh` (`numero_cnh`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `motoristas`
--

LOCK TABLES `motoristas` WRITE;
/*!40000 ALTER TABLE `motoristas` DISABLE KEYS */;
INSERT INTO `motoristas` VALUES ('MOT001','Carlos Henrique Silva','12345678901','11987654321','Disponível para viagens'),('MOT002','Roberto Almeida Santos','23456789012','11976543210','Disponível para viagens'),('MOT003','Fernanda Oliveira Costa','34567890123','11965432109','Motorista em viagem'),('MOT004','Marcos Pereira Lima','45678901234','11954321098','Disponível para viagens'),('MOT005','Juliana Ferreira Souza','56789012345','11943210987','Motorista em férias');
/*!40000 ALTER TABLE `motoristas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rota_viagens`
--

DROP TABLE IF EXISTS `rota_viagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rota_viagens` (
  `id_rota_viagem` varchar(255) NOT NULL,
  `data_prevista_chegada` datetime NOT NULL,
  `data_saida` datetime NOT NULL,
  `status_rota` varchar(255) NOT NULL,
  `id_veiculo` varchar(255) NOT NULL,
  `id_motorista` varchar(255) NOT NULL,
  `id_origem` varchar(255) NOT NULL,
  `id_destino` varchar(255) NOT NULL,
  PRIMARY KEY (`id_rota_viagem`),
  KEY `id_veiculo` (`id_veiculo`),
  KEY `id_motorista` (`id_motorista`),
  KEY `id_origem` (`id_origem`),
  KEY `id_destino` (`id_destino`),
  CONSTRAINT `rota_viagens_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`),
  CONSTRAINT `rota_viagens_ibfk_2` FOREIGN KEY (`id_motorista`) REFERENCES `motoristas` (`id_motorista`),
  CONSTRAINT `rota_viagens_ibfk_3` FOREIGN KEY (`id_origem`) REFERENCES `centros_de_distribuicoes` (`id_centro_distribuicao`),
  CONSTRAINT `rota_viagens_ibfk_4` FOREIGN KEY (`id_destino`) REFERENCES `centros_de_distribuicoes` (`id_centro_distribuicao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rota_viagens`
--

LOCK TABLES `rota_viagens` WRITE;
/*!40000 ALTER TABLE `rota_viagens` DISABLE KEYS */;
INSERT INTO `rota_viagens` VALUES ('ROT001','2026-10-21 18:00:00','2026-10-20 08:00:00','Em andamento','VEI002','MOT003','CD001','CD002'),('ROT002','2026-10-22 00:00:00','2026-10-21 00:00:00','Planejada','VEI001','MOT001','CD002','CD003'),('ROT003','2026-10-23 00:00:00','2026-10-22 00:00:00','Planejada','VEI003','MOT002','CD003','CD004'),('ROT004','2026-10-24 00:00:00','2026-10-23 00:00:00','Planejada','VEI005','MOT004','CD004','CD005'),('ROT005','2026-10-25 00:00:00','2026-10-24 00:00:00','Planejada','VEI001','MOT001','CD005','CD001');
/*!40000 ALTER TABLE `rota_viagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculos`
--

DROP TABLE IF EXISTS `veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculos` (
  `id_veiculo` varchar(255) NOT NULL,
  `placa` varchar(255) NOT NULL,
  `status_veiculo` varchar(255) NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE KEY `placa` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculos`
--

LOCK TABLES `veiculos` WRITE;
/*!40000 ALTER TABLE `veiculos` DISABLE KEYS */;
INSERT INTO `veiculos` VALUES ('VEI001','ABC1D23','Disponível'),('VEI002','DEF2G34','Em viagem'),('VEI003','GHI3J45','Disponível'),('VEI004','JKL4M56','Em manutenção'),('VEI005','NOP5Q67','Disponível');
/*!40000 ALTER TABLE `veiculos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_dashboard_logistico`
--

DROP TABLE IF EXISTS `vw_dashboard_logistico`;
/*!50001 DROP VIEW IF EXISTS `vw_dashboard_logistico`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_dashboard_logistico` AS SELECT 
 1 AS `id_encomenda`,
 1 AS `codigo_rastreamento`,
 1 AS `nome_cliente`,
 1 AS `data_postagem`,
 1 AS `status_encomenda`,
 1 AS `endereco_origem`,
 1 AS `endereco_destino`,
 1 AS `total_movimentacoes`,
 1 AS `ultima_movimentacao`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_dashboard_logistico`
--

/*!50001 DROP VIEW IF EXISTS `vw_dashboard_logistico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_dashboard_logistico` AS select `e`.`id_encomenda` AS `id_encomenda`,`e`.`codigo_rastreamento` AS `codigo_rastreamento`,`c`.`nome` AS `nome_cliente`,`e`.`data_postagem` AS `data_postagem`,`e`.`status_encomenda` AS `status_encomenda`,`e`.`endereco_origem` AS `endereco_origem`,`e`.`endereco_destino` AS `endereco_destino`,count(`h`.`id_historico_rastreamento`) AS `total_movimentacoes`,max(`h`.`data_hora`) AS `ultima_movimentacao` from ((`encomendas` `e` join `clientes` `c` on((`e`.`id_cliente` = `c`.`id_cliente`))) left join `historico_rastreamento` `h` on((`e`.`id_encomenda` = `h`.`id_encomenda`))) group by `e`.`id_encomenda`,`e`.`codigo_rastreamento`,`c`.`nome`,`e`.`data_postagem`,`e`.`status_encomenda`,`e`.`endereco_origem`,`e`.`endereco_destino` */;
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

-- Dump completed on 2026-10-24 16:12:38
