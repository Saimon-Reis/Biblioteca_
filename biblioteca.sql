CREATE DATABASE  IF NOT EXISTS `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `biblioteca`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `idautor` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `nacionalidade` varchar(45) NOT NULL,
  PRIMARY KEY (`idautor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Patrick Rothfuss','Estados Unidos'),(2,'Paul Hoffman','Estados Unidos'),(3,'Howard Phillips Lovecraft','Estados Unidos'),(4,'Robert Cecil Martin','Estados Unidos'),(5,'Michael Sipser','Estados Unidos');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bibliotecario`
--

DROP TABLE IF EXISTS `bibliotecario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bibliotecario` (
  `cpf` varchar(45) NOT NULL,
  `funcionario_idfuncionario` int NOT NULL,
  PRIMARY KEY (`funcionario_idfuncionario`),
  CONSTRAINT `fk_bibliotecario_funcionario1` FOREIGN KEY (`funcionario_idfuncionario`) REFERENCES `funcionario` (`idfuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bibliotecario`
--

LOCK TABLES `bibliotecario` WRITE;
/*!40000 ALTER TABLE `bibliotecario` DISABLE KEYS */;
INSERT INTO `bibliotecario` VALUES ('12345678911',1),('98765432198',2),('65432198765',3);
/*!40000 ALTER TABLE `bibliotecario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bolsista`
--

DROP TABLE IF EXISTS `bolsista`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bolsista` (
  `matricula` varchar(45) NOT NULL,
  `funcionario_idfuncionario` int NOT NULL,
  PRIMARY KEY (`funcionario_idfuncionario`),
  CONSTRAINT `fk_bolsista_funcionario1` FOREIGN KEY (`funcionario_idfuncionario`) REFERENCES `funcionario` (`idfuncionario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bolsista`
--

LOCK TABLES `bolsista` WRITE;
/*!40000 ALTER TABLE `bolsista` DISABLE KEYS */;
INSERT INTO `bolsista` VALUES ('12345',4),('53321',5);
/*!40000 ALTER TABLE `bolsista` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `matricula` varchar(45) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES ('17132','Aluno E','55385740956','alunoE@gmail.com'),('22105','Aluno D','55478509874','alunoD@gmail.com'),('25421','Aluno A','55674894634','alunoA@gmail.com'),('38157','Professor A','55108567459','professorA@gmail.com'),('62137','Professor B','55674520678','professorB@gmail.com');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editora`
--

DROP TABLE IF EXISTS `editora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editora` (
  `ideditora` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ideditora`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editora`
--

LOCK TABLES `editora` WRITE;
/*!40000 ALTER TABLE `editora` DISABLE KEYS */;
INSERT INTO `editora` VALUES (1,'Arqueiro',NULL,NULL),(2,'Suma',NULL,NULL),(3,'Pandorga',NULL,NULL),(4,'Alta Books',NULL,NULL),(5,'Cengage Learning',NULL,NULL),(6,'Pearson',NULL,NULL);
/*!40000 ALTER TABLE `editora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `idemprestimo` int NOT NULL AUTO_INCREMENT,
  `dataRetirada` date NOT NULL,
  `dataDevolucao` date NOT NULL,
  `livro_idlivro` int NOT NULL,
  `cliente_matricula` varchar(45) NOT NULL,
  `funcionario_idfuncionario` int NOT NULL,
  PRIMARY KEY (`idemprestimo`),
  KEY `fk_emprestimo_livro_idx` (`livro_idlivro`),
  KEY `fk_emprestimo_cliente1_idx` (`cliente_matricula`),
  KEY `fk_emprestimo_funcionario1_idx` (`funcionario_idfuncionario`),
  CONSTRAINT `fk_emprestimo_cliente1` FOREIGN KEY (`cliente_matricula`) REFERENCES `cliente` (`matricula`),
  CONSTRAINT `fk_emprestimo_funcionario1` FOREIGN KEY (`funcionario_idfuncionario`) REFERENCES `funcionario` (`idfuncionario`),
  CONSTRAINT `fk_emprestimo_livro` FOREIGN KEY (`livro_idlivro`) REFERENCES `livro` (`idlivro`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,'2023-04-01','2023-04-16',4,'17132',1),(2,'2023-04-10','2023-04-26',7,'25421',2),(3,'2023-07-20','2023-08-06',5,'17132',3),(4,'2023-05-05','2023-05-21',9,'22105',4),(5,'2023-08-15','2023-08-30',10,'25421',5),(6,'2023-12-01','2023-12-14',7,'17132',1);
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudante`
--

DROP TABLE IF EXISTS `estudante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudante` (
  `curso` varchar(100) NOT NULL,
  `cliente_matricula` varchar(45) NOT NULL,
  PRIMARY KEY (`cliente_matricula`),
  CONSTRAINT `fk_estudante_cliente1` FOREIGN KEY (`cliente_matricula`) REFERENCES `cliente` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudante`
--

LOCK TABLES `estudante` WRITE;
/*!40000 ALTER TABLE `estudante` DISABLE KEYS */;
INSERT INTO `estudante` VALUES ('Sistemas de Informação','17132'),('Sistemas de Informação','22105'),('Sistemas de Informação','25421');
/*!40000 ALTER TABLE `estudante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `idfuncionario` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `salario` float NOT NULL,
  `telefone` varchar(45) NOT NULL,
  `tipoFuncionario` int NOT NULL,
  PRIMARY KEY (`idfuncionario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,'Funcionário A',2000,'55912345678',1),(2,'Funcionário B',1500,'55947593847',1),(3,'Funcionário C',2000,'55951263746',1),(4,'Funcionário D',400,'55996583456',2),(5,'Funcionário E',400,'55976452861',2);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `idlivro` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `genero` varchar(45) NOT NULL,
  `dataPublicacao` date NOT NULL,
  `autor_idautor` int NOT NULL,
  `editora_ideditora` int NOT NULL,
  PRIMARY KEY (`idlivro`,`autor_idautor`,`editora_ideditora`),
  KEY `fk_livro_autor1_idx` (`autor_idautor`),
  KEY `fk_livro_editora1_idx` (`editora_ideditora`),
  CONSTRAINT `fk_livro_autor1` FOREIGN KEY (`autor_idautor`) REFERENCES `autor` (`idautor`),
  CONSTRAINT `fk_livro_editora1` FOREIGN KEY (`editora_ideditora`) REFERENCES `editora` (`ideditora`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` VALUES (1,'O nome do vento','Fantasia','2007-03-27',1,1),(2,'A mão esquerda de Deus','Fantasia','2010-01-07',2,2),(3,'A cor que caiu do céu','Terror','2018-01-01',3,3),(4,'Código limpo: habilidades práticas do Agile software','Tecnologia','2009-09-08',4,4),(5,' Uma introdução aprofundada à teoria da computação e à ciência da computação teórica','Tecnologia','2012-06-27',5,5),(6,'O temor do sábio','Fantasia','2011-03-01',1,1),(7,'Agile Principles, Patterns, and Practices in C#','Tecnologia','2006-07-20',4,4),(8,'A música do silêncio','Fantasia','2015-02-11',1,1),(9,'The Clean Coder: A Code of Conduct for Professional Programmers','Tecnologia','2011-05-13',4,6),(10,'Clean Architecture: A Craftsman\'s Guide to Software Structure and Design','Tecnologia','2017-09-10',4,6),(11,'Craftsmanship limpo: disciplinas, padrões e ética','Tecnologia','2023-01-15',4,4);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livrodigital`
--

DROP TABLE IF EXISTS `livrodigital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livrodigital` (
  `formatoArquivo` varchar(45) NOT NULL,
  `tamanho` varchar(45) NOT NULL,
  `livro_idlivro` int NOT NULL,
  `livro_autor_idautor` int NOT NULL,
  `livro_editora_ideditora` int NOT NULL,
  PRIMARY KEY (`formatoArquivo`,`livro_idlivro`,`livro_autor_idautor`,`livro_editora_ideditora`),
  KEY `fk_livroDigital_livro1_idx` (`livro_idlivro`,`livro_autor_idautor`,`livro_editora_ideditora`),
  CONSTRAINT `fk_livroDigital_livro1` FOREIGN KEY (`livro_idlivro`, `livro_autor_idautor`, `livro_editora_ideditora`) REFERENCES `livro` (`idlivro`, `autor_idautor`, `editora_ideditora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livrodigital`
--

LOCK TABLES `livrodigital` WRITE;
/*!40000 ALTER TABLE `livrodigital` DISABLE KEYS */;
INSERT INTO `livrodigital` VALUES ('pdf','3.6',1,1,1),('pdf','1.2',2,2,2),('pdf','3.6',3,3,3),('pdf','5.3',6,1,1),('pdf','4.5',8,1,1);
/*!40000 ALTER TABLE `livrodigital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livroimpresso`
--

DROP TABLE IF EXISTS `livroimpresso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livroimpresso` (
  `numeroPaginas` int NOT NULL,
  `livro_idlivro` int NOT NULL,
  `livro_autor_idautor` int NOT NULL,
  `livro_editora_ideditora` int NOT NULL,
  `qtdEmEstoque` int NOT NULL,
  PRIMARY KEY (`livro_idlivro`,`livro_autor_idautor`,`livro_editora_ideditora`),
  CONSTRAINT `fk_livroImpresso_livro1` FOREIGN KEY (`livro_idlivro`, `livro_autor_idautor`, `livro_editora_ideditora`) REFERENCES `livro` (`idlivro`, `autor_idautor`, `editora_ideditora`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livroimpresso`
--

LOCK TABLES `livroimpresso` WRITE;
/*!40000 ALTER TABLE `livroimpresso` DISABLE KEYS */;
INSERT INTO `livroimpresso` VALUES (425,4,4,4,1),(458,5,5,5,2),(768,7,4,4,3),(256,9,4,6,2),(432,10,4,6,3);
/*!40000 ALTER TABLE `livroimpresso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `idmulta` int NOT NULL AUTO_INCREMENT,
  `valor` float NOT NULL,
  `status` int NOT NULL,
  `cliente_matricula` varchar(45) NOT NULL,
  PRIMARY KEY (`idmulta`),
  KEY `fk_multa_cliente1_idx` (`cliente_matricula`),
  CONSTRAINT `fk_multa_cliente1` FOREIGN KEY (`cliente_matricula`) REFERENCES `cliente` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (1,5,0,'17132'),(2,3,1,'17132'),(3,4,1,'22105'),(4,10,0,'25421'),(5,1,1,'25421');
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `departamento` varchar(100) NOT NULL,
  `cliente_matricula` varchar(45) NOT NULL,
  PRIMARY KEY (`cliente_matricula`),
  CONSTRAINT `fk_professor_cliente1` FOREIGN KEY (`cliente_matricula`) REFERENCES `cliente` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('Tecnologia','38157'),('Tecnologia','62137');
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `idreserva` int NOT NULL AUTO_INCREMENT,
  `dataReserva` date NOT NULL,
  `cliente_matricula` varchar(45) NOT NULL,
  `livro_idlivro` int NOT NULL,
  `livro_autor_idautor` int NOT NULL,
  `livro_editora_ideditora` int NOT NULL,
  PRIMARY KEY (`idreserva`),
  KEY `fk_reserva_cliente1_idx` (`cliente_matricula`),
  KEY `fk_reserva_livro1_idx` (`livro_idlivro`,`livro_autor_idautor`,`livro_editora_ideditora`),
  CONSTRAINT `fk_reserva_cliente1` FOREIGN KEY (`cliente_matricula`) REFERENCES `cliente` (`matricula`),
  CONSTRAINT `fk_reserva_livro1` FOREIGN KEY (`livro_idlivro`, `livro_autor_idautor`, `livro_editora_ideditora`) REFERENCES `livro` (`idlivro`, `autor_idautor`, `editora_ideditora`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,'2023-07-11','17132',1,1,1),(2,'2023-05-15','22105',4,4,4),(3,'2023-09-25','25421',5,5,5),(4,'2023-04-04','38157',7,4,4),(5,'2023-10-10','62137',10,4,6);
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-08 17:08:32
