-- MySQL dump 10.13  Distrib 5.7.16, for Linux (i686)
--
-- Host: localhost    Database: data_dev
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu0.16.04.1

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('db134460d0d4');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) DEFAULT NULL,
  `uploadperson` int(11) DEFAULT NULL,
  `uploadtime` datetime DEFAULT NULL,
  `brief` text,
  `about` varchar(128) DEFAULT NULL,
  `target` varchar(8) DEFAULT NULL,
  `link` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_article_title` (`title`),
  KEY `uploadperson` (`uploadperson`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`uploadperson`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (16,'热带病原学基础研究概述.pdf',28,'2016-11-27 15:38:16','开展对疟原虫、恙虫立克次体等的病原分子医学研究。','以疟原虫为主的热带病原学基础研究','1','http://www.ncbi.nlm.nih.gov/pubmed/18660804'),(17,'热带病疫苗的开发与研制.pdf',36,'2016-11-27 15:40:39','热带病病原对治疗药物耐药和虫媒载体对各种杀虫剂耐药是导致疟疾等热带病难以控制的另一主要因素。','热带病病原和虫媒载体耐药机理研究','1','http://www.ncbi.nlm.nih.gov/pubmed/23874975'),(18,'The genome of the blood fluke Schistosoma mansoni.pdf',36,'2016-11-27 15:42:04','热带病病原对治疗药物耐药和虫媒载体对各种杀虫剂耐药是导致疟疾等热带病难以控制的另一主要因素。','热带病病原和虫媒载体耐药机理研究','1','http://www.ncbi.nlm.nih.gov/pubmed/19606141'),(19,'Genome sequence of the nematode C. elegans: a platform for investigating biology.pdf',35,'2016-11-27 20:04:41','热带病(原学)重点实验室将从分子、细胞生物学的角度重点寻找海洋生物及热带病原宿主体内分泌的活性多肽,争取发现数个具有防治热带病活性的多肽物质,进而探讨这些多肽在热带病发病和转归中的作用机理,为热带病的防治寻找新的方法和策略。','热带病诊断和病原鉴别技术的开发及应用研究','1','http://www.ncbi.nlm.nih.gov/pubmed/9851916');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference`
--

DROP TABLE IF EXISTS `conference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conference` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `spot` varchar(128) DEFAULT NULL,
  `link` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_conference_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference`
--

LOCK TABLES `conference` WRITE;
/*!40000 ALTER TABLE `conference` DISABLE KEYS */;
INSERT INTO `conference` VALUES (8,'第十届国际热带病会议在马尼拉召开','2016-11-09 00:00:00','2016-11-15 00:00:00','第23届国际热带病与疟疾会议于2016年11月9日至15日在马尼拉国际会议中心召开','http://xueshu.baidu.com'),(9,'中药青蒿素对世界疟疾控制的贡献与展望','2016-11-02 00:00:00','2016-11-05 00:00:00','青蒿素由中药青蒿提取而得,青蒿素类药物是目前抗疟药物中最速效和较低毒的一类药,本文对青蒿素的药理研究、临床应用研究进行了综述.','http://xueshu.baidu.com'),(10,'第12届国际热带病和疟疾会议见闻','2008-01-01 00:00:00','2008-01-05 00:00:00','1988年9月15日至30日我有幸赴荷兰参加第12届国际热带病和疟疾会议。会址设在荷兰阿姆斯特丹市的国际会议中心(RAI)。','http://xueshu.baidu.com'),(11,'第四次全国艾滋病、病毒性丙型肝炎暨全国热带病学术会议纪要','2015-01-01 00:00:00','2015-01-03 00:00:00','由中华医学会感染病学分会艾滋病学组与中华医学会热带病与寄生虫分会共同举办来自全国各地的200余名代表参加了大会.大会邀请了ll位国内从事相关领域的知名专家进行专题报 告,从收到的178篇论文中选出25篇进行了大会交流.','http://xueshu.baidu.com'),(12,'第九届国际热带病和疟疾会议上血吸虫病论文摘要综述','2014-02-01 00:00:00','2014-02-05 00:00:00','使读者得睹会议(有关血吸虫病部份)全貌,以之衡量国外血防科研水平,批判地吸取对我国可能有用的经验。','http://www.cnki.com.cn/Article/CJFDTotal-GWJC197504000.htm');
/*!40000 ALTER TABLE `conference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `content` text,
  `connect` varchar(128) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_news_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (8,'专家研讨全球公共卫生视角下中国热带病防治策略','新华网上海 4 月 25 日电(仇逸、严晓慧)由中华医学会主办 ,复旦大学附属上海市公共卫生临床中心承办的“2016 年中华医学会热带病与寄生虫学分会年会”23 日召开。我国传染病领域专家汇聚,共同探讨全球传染病预防机制与救治进展,合力应对中国热带病防治重任。',NULL,'2016-11-27 07:29:32'),(9,'DNDi:打破受忽视疾病新药开发的窘境','近日《自然》杂志报道了 DNDi(Drugs for neglected disease initiatives)的一个开发新药的新模式。DNDi 只用 10 年多一点的时间、2.9 亿美元就上市了 6 个新药,还有 26个在临床研究。',NULL,'2016-11-27 07:29:59'),(10,'新突破!咔唑源先导药物治疗人类非洲锥虫病','非洲人类锥虫病,或 HAT,是一种在撒哈拉以南非洲的一些农村社区的热带病。一种媒介传播的寄生虫病,现有的诊断和治疗方案是复杂的,特别是在一些世界上最贫困的地区具有挑战性。',NULL,'2016-11-27 07:30:44');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `content` text,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_notice_title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
INSERT INTO `notice` VALUES (5,'世卫组织总干事陈冯富珍出席世界卫生组织热带病合作中心 揭牌仪式','2016 年 12 月 17 日上午,世界卫生组织热带病合作中心揭牌仪式在上海举行,世卫组织总干事陈冯富珍、国家卫生计生委副主任马晓伟、上海市副市长翁铁慧等出席,为合作中心揭牌并致辞。','2016-11-27 15:31:40'),(6,'关于做好2016年12月研究审查工作的通知','做好2016年12月毕业资格审查工作','2016-11-27 15:33:52'),(7,'构建公共卫生安全防控屏障','“十三五”时期,应进一步突出预防为主、防治结合和全程管理的指导思想,积极预防可控的危险因素,降低感染性疾病危害,遏止并扭转慢性非传染性疾病的蔓延,切实维护好人民健康。','2016-11-27 15:34:43'),(8,'专家研讨全球公共卫生视角下中国热带病防治策略','新华网上海 4 月 25 日电(仇逸、严晓慧)由中华医学会主办 ,复旦大学附属上海市公共卫生临床中心承办的“2016 年中华医学会热带病与寄生虫学分会年会”23 日召开。','2016-11-27 20:09:04');
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `authorization` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `tel` varchar(11) DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `password_hash` varchar(128) DEFAULT NULL,
  `introduction` text,
  `target` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_person_email` (`email`),
  UNIQUE KEY `ix_person_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (21,'root','root@qq.com','superad',NULL,NULL,NULL,'pbkdf2:sha1:1000$09DknvLB$57675def7eef5237cc24bf9290502dd7cf5b7ce1',NULL,NULL),(27,'admin','admin@qq.com','generalad',NULL,NULL,NULL,'pbkdf2:sha1:1000$cbZDnGpv$f66a27d653f4a6102d1b91cd7f65369a021a21d1',NULL,NULL),(28,'fulinchun','fulinchun@qq.com','labuser','符林春','13811111111','man','pbkdf2:sha1:1000$ZTSI6gQv$aaa12e66b9c48363d34dee8ac022ceaa7689311d','研究员,博士生导师,广州中医药大学热带医学研所所长,广东省卫生系统“五个一工程”学术和技术带头人,国家中医药管理局中医药防治艾滋病咨询专家,中华中医药学会防治艾滋病分会副主任委员,广东省热带医学会副主任委员,中华医学会热带病和寄生虫分会委员,享受国务院政府特殊津贴专家。',NULL),(29,'chenpeiquan','chenpeiquan@qq.com','labuser','陈沛泉','13822222222','man','pbkdf2:sha1:1000$9TGgA6Kh$6814eb115555e2ffd2e2a806ee41317c32f23b9c','广东省罗定市人,1949 年 9 月出生。现任广州中医药大学研究员,中医临床基础学科温病学(热带病)专业博士生导师,中华医学会热带病与寄生虫学学会会员,广东省热带医学学会常委,国家自然科学基金评审专家库专家,广东省自然科学基金评审专家库专家。',NULL),(30,'lichangqing','lichangqing@qq.com','labuser','李常青','13833333333','man','pbkdf2:sha1:1000$btrpzgCO$543a9d09a5916bd7c40792f7f6b0fda7044b9bac','1965 年 9 月生,湖南华容人,研究员,中医临床基础专业导师。学术特长:中医药治疗慢性乙型肝炎、肝纤维化、肝硬化和脂肪肝的临床医疗实验研究工作。',NULL),(31,'zengqingping','zengqingping@qq.com','labuser','曾庆平','13844444444','man','pbkdf2:sha1:1000$lvGm7BrQ$ddd889fcdf0ac6899667a6826da600d0797dcdc3','湖南常德人,1961 年 4 月出生。理学硕士、工学博士,研究员。中国生物化学与分子生物学学会、中华医学会传染病与寄生虫病学分会、中国性病艾滋病防治协会和广东省热带病学会会员,受聘为国家药品食品监督管理局、国家自然科学基金、广东省自然科学基金、广州市生物医药评审专家库专家,现任广州中医药大学热带医学研究所生物技术研究室主任,曾先后主持和参加国家自然科学基金项目(青蒿素生物合成途径的局部重建及青蒿素前体的生物转化、关木通中马兜铃酸合成代谢基因敲除的研究、DNA 疫苗联用转基因中草药防治艾滋病的研究、转人α-干扰素基因苦瓜的抗病毒实验研究)、国家中医药管理局项目(面向高产青蒿素的代谢途径工程育种研究)、省自然科学基金项目(鲨烯合酶基因敲除与转基因青蒿素高产植株的培育、中药复方配合 DNA 疫苗防治猴艾滋病的研究)、省科技计划项目(转基因青蒿氧化胁迫诱导及青蒿素前体大规模转化)、省教育厅项目(集成化艾滋病、乙型肝炎和 STD 基因诊断用反义探针微球的研制)及多项横向合作项目(高效低价疟疾检测试剂盒的研制等)\r\n,在国内外发表论文数十篇,专著 4 本。曾作为国家公派访问学者赴芬兰赫尔辛基大学生物工程研究所工作,并参访了英国牛津大学和剑桥大学、德国 Max-Plank 研究所、荷兰雷登大学和瑞士联邦技术研究所等著名学府及科研院所。曾获邀参加美国著名的 Gordon 科学会议(GRC)的植物代谢工程专题研讨会,并进行论文展示及\r\n开展学术交流,还与欧美多所大学及研究所建立了合作关系。',NULL),(32,'yuandongsheng','yuandongsheng@qq.com','labuser','袁冬生','13855555555','man','pbkdf2:sha1:1000$SzsMZGT0$7cac4b53ff830fcc904f9e8d299cbbafbdbce9ec','江西乐安县人,1964 年 10 月出生,医学博士,研究员,中医临床基础专业硕士生导师,广东省肝脏病学会理事,广州市科技评审专家。现主要从事中医药抗乙肝病毒、抗肝纤维化以及中医药治疗酒精性和非酒精性脂肪肝的基础和临床研究。长期坚持消化内科、肝炎专科临床,积累了丰富的中西医治疗慢性乙型肝炎、肝硬化、脂肪肝的临床经验。发表相关论文 20 多篇,主持国家级课题 1 项,主持省级课题 2 项,参与省级课题 3 项。参编《中医临床基础》教材(高等教育出版社)副主编《中医学基础》教材(科学出版社)。先后指导硕士研究生 4 名。',NULL),(33,'yangruiyi','yangruiyi@qq.com','labuser','杨瑞仪','13866666666','woman','pbkdf2:sha1:1000$q80N79ZA$2f1d0661ea483ced8ff55c6e9e2453fb26844999','广东大埔县人,1972 年 5 月出生,1998 年暨南大学免疫遗传专业硕士研究生毕业,广州中医药大学热带医学研究所副研究员,中医临床基础硕士生导师,中华医学会传染病与寄生虫病学会会员。曾先后主持或参加国家自然科学基金、国家中医药管理局、广东省自然科学基金、广东省教育厅、广东省卫生厅、广东省中医药管理局等科研项目 20余项。在国内有影响的核心期刊发表论文数十篇,参编著作 3 部。现专业技术领域为医药生物工程,主要研究方向为中药生物工程(包括转基因中药、中药活性成分的合成代谢研究、中药活性成分基因工程研究等)及中药对肿瘤的免疫调控研究。',NULL),(34,'zhangfengxue','zhangfengxue@qq.com','labuser','张奉学','13877777777','man','pbkdf2:sha1:1000$JplvzJE7$20c2167fc4166a7841023e88636cf5a46340eb46','安徽省人,1962 年出生。广州中医药大学中西医结合基础专业博士生导师。热带医学研究所病毒学研究室主任,世界中医药学会联合会肝病专业委员会常务理事,广东省热带医学学会常务理事、副秘书长,是广东省“千百十人才工程”培养对象,中国科学院“西部之光”人才培养计划“联合学者”。《生物技术通讯》 理事,广州中医药大学学报 编委。',NULL),(35,'huyingjie','huyingjie@qq.com','labuser','胡英杰','13888888888','man','pbkdf2:sha1:1000$mVJDBoaa$bdf397504f059945d5411cf7ed5e94ea50b34031','1962 年生,祖籍湖南。广州中医药大学热带医学研究所副所长兼药学研究室主任,博士研究生导师,广东省新药审评专家库专家,广东省、广州市科技项目评审专家。1983 年毕业于上海第一医学院药物化学专业(学士);1988 年毕业于中国科学院昆明植物研究所植物化学专业(硕士);2005 年毕业于广州中医药大学(博士)。',NULL),(36,'huangling','huangling@qq.com','labuser','黄玲','13899999999','woman','pbkdf2:sha1:1000$jY11jIxm$90467004042664169baca41b5494478a40ce5498','1963 年 11 月生,江西省赣州市人,副研究员。主要研究方向:中药药理与毒理,中药对免疫性疾病的药效学和安全性评价及机制研究。',NULL),(37,'zhangsan','zhangsan@qq.com','registeruser',NULL,NULL,NULL,'pbkdf2:sha1:1000$Uwpku03Y$b915967535b2c580b185e3ede72c268dffff974a',NULL,NULL),(38,'wangwu','wangwu@qq.com','labuser',NULL,NULL,NULL,'pbkdf2:sha1:1000$FTIFfsQo$86be32a0aded90b4dc5bd0211ec486fa8a416001',NULL,''),(39,'zhaoliu','zhaoliu@qq.com','registeruser',NULL,NULL,NULL,'pbkdf2:sha1:1000$UtdpMEO2$704a5b9e2c83537974c74ab55a0ddfa248ad7b12',NULL,''),(40,'admin2','admin2@qq.com','generalad',NULL,NULL,NULL,'pbkdf2:sha1:1000$WurKWVm9$172f6615a984957b448673e1d9863ee3dcc433e2',NULL,NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `introduction` text,
  `major` varchar(64) DEFAULT NULL,
  `progress` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_project_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES (3,'以疟原虫为主的热带病原学基础研究','2016-02-01 00:00:00','2017-02-01 00:00:00','开展对疟原虫、恙虫立克次体等的病原分子医学研究。其主要任务是利用 Genbank 中已知的基因序列和生物信息学手段,筛选可能的靶基因并鉴定其功能,掌握病原体在环境和药物选择压力下的基因的变异规律,病原体与宿主(人和储蓄宿主)相互作用的分子机制(致病和免疫的分子机制),为研制新的治疗药物、诊断试剂和基因疫苗的开发与研制奠定坚实的基础。','疟原虫研究团队','采用新的构建和制备疫苗技术和策略重点开发疟疾、登革热、立克次体等热带病防治疫苗。'),(4,'热带病诊断和病原鉴别技术的开发及应用研究','2016-04-01 00:00:00','2017-04-01 00:00:00','热带病诊断和病原鉴别技术是热带病防治的基础技术,在临床诊断、疗效判定和流行病学调查中均具有重要的作用。热带病(原学)重点实验室除了要充分掌握和利用现有成熟的热带病基本诊断和病原鉴别技术外,还要不断地跟踪国内外的研究进展,不断地将新技术移植应用于基础研究的同时,积极探讨其临床实际应用的可行性。重点利用分子生物学、基因组学、蛋白质组学、免疫学、细胞生物学和现代组织(免疫)病理技术的方法和手段寻找\r\n热带病诊断和治疗的新的靶点,争取研究开发出具有自主知识产权的热带病诊断和病原鉴别技术,并将这些技术应用于临床和流行病学研究。努力争取将实验室建设成为具有发现、诊断和鉴定新的热带病病原能力的国内权威实验室。','热带病诊断研究团队','开展热带病原的对外检测服务,并提供专业性治疗建议。对省内各人群上述各种人体寄生虫和其他传染性疾病的流行病学调查,填补省内的有关方面资料空白,为有关机构提供准确的流行病学数据。同时开展预防与控制的相关研究。开展艾滋病和结核病的预防与控制措施和策略研究,重点研究艾滋病和结核病的诊断与筛查,预防与教育与干预方法等应用研究。'),(5,'热带病病原和虫媒载体耐药机理研究','2016-01-01 00:00:00','2017-01-01 00:00:00','热带病病原对治疗药物耐药和虫媒载体对各种杀虫剂耐药是导致疟疾等热带病难以控制的另一主要因素。在这一研究领域,实验室将主要应用分子生物学、基因组学、分子免疫学的方法和手段,从分子水平研究热带病病原和虫媒载体的耐药机理,进而寻找治疗和干预热带病病原和虫媒载体耐药的新方法。','热带病病原研究团队','发现数个具有防治热带病活性的多肽物质,进而探讨这些多肽在热带病发病和转归中的作用机理,为热带病的防治寻找新的方法和策略。'),(6,'热带病病理学及诊断技术及防治措施的研究','2016-11-01 00:00:00','2016-11-30 00:00:00','热带病是以生物性致病因子为主引起的疾病,是热带地区的多发病和特有疾病。2003年在广东地区出现并迅速漫延至全国、全球的传染性非典型肺炎(SARS),以及 2004 年初全球范围内禽流感的流行,给我国和世界人民造成巨大的灾难,这些疾病的爆发给广大科研工作者敲响了警钟:必须高度重视传染性疾病的防治研究工作。','热带病病理学研究团队',NULL);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relation`
--

DROP TABLE IF EXISTS `relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relation` (
  `person_id` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  KEY `person_id` (`person_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `relation_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `relation_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relation`
--

LOCK TABLES `relation` WRITE;
/*!40000 ALTER TABLE `relation` DISABLE KEYS */;
INSERT INTO `relation` VALUES (28,10),(31,10),(34,10),(29,11),(35,11),(30,12),(33,12),(36,12),(28,13),(30,13),(31,13),(33,13),(30,11),(31,11);
/*!40000 ALTER TABLE `relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relation_project`
--

DROP TABLE IF EXISTS `relation_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relation_project` (
  `team_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  KEY `project_id` (`project_id`),
  KEY `team_id` (`team_id`),
  CONSTRAINT `relation_project_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`),
  CONSTRAINT `relation_project_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relation_project`
--

LOCK TABLES `relation_project` WRITE;
/*!40000 ALTER TABLE `relation_project` DISABLE KEYS */;
INSERT INTO `relation_project` VALUES (11,3),(12,3),(10,3),(10,4),(11,4),(10,5),(11,5),(12,5),(13,4),(10,6),(11,6),(12,6),(13,6);
/*!40000 ALTER TABLE `relation_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `brief` text,
  `task` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_team_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (10,'疟原虫研究团队','开展对疟原虫、恙虫立克次体等的病原分子医学研究。','用 Genbank 中已知的基因序列和生物信息学手段,筛选可能的靶基因并鉴定其功能,掌握病原体在环境和药物选择压力下的基因的变异规律,病原体与宿主(人和储蓄宿主)相互作用的分子机制(致病和免疫的分子机制),为研制新的治疗药物、诊断试剂和基因疫苗的开发与研制奠定坚实的基础。'),(11,'热带病诊断研究团队','主要负责热带病诊断和病原鉴别技术的开发及应用研究','热带病诊断和病原鉴别技术是热带病防治的基础技术,在临床诊断、疗效判定和流行病学调查中均具有重要的作用。热带病(原学)重点实验室除了要充分掌握和利用现有成熟的热带病基本诊断和病原鉴别技术外,还要不断地跟踪国内外的研究进展,不断地将新技术移植应用于基础研究的同时,积极探讨其临床实际应用的可行性。重点利用分子生物学、基因组学、蛋白质组学、免疫学、细胞生物学和现代组织(免疫)病理技术的方法和手段寻找热带病诊断和治疗的新的靶点,争取研究开发出具有自主知识产权的热带病诊断和病原鉴别技术,并将这些技术应用于临床和流行病学研究。努力争取将实验室建设成为具有发现、诊断和鉴定新的热带病病原能力的国内权威实验室。'),(12,'热带病病原研究团队','主要从事热带病病原和虫媒载体耐药机理研究','在这一研究领域,实验室将主要应用分子生物学、基因组学、分子免疫学的方法和手段,从分子水平研究热带病病原和虫媒载体的耐药机理,进而寻找治疗和干预热带病病原和虫媒载体耐药的新方法。'),(13,'热带病病理学研究团队','主要从事热带病病理学及诊断技术及防治措施的研究','在病原分子医学研究的基础上,进行病毒感染的分子生物学诊断、细胞模型、抗病毒治疗及疗效评价的研究;对已知病原体如\r\n疟原虫、乙型肝炎病毒、恙虫病立克次体、粪类园线虫、猪囊尾蚴、曼氏裂头蚴、肝吸虫、弓形虫、肺孢子虫、隐孢子虫、艾滋病毒、冠状病毒等建立或引进简便、快速、敏感、特异的免疫检测和基因检测新技术,建立技术标准、研发商品化检测试剂盒,建立常见热带病诊断方法及防治措施,研究开发基因疫苗。');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-27 20:29:38
