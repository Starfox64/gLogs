-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 04 Juin 2015 à 00:09
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

--
-- Noms suceptibles de changer !
--
SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `glogs`
--
CREATE DATABASE IF NOT EXISTS `glogs` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE glogs;

-- --------------------------------------------------------

--
-- Structure de la table `logs_data`
--
-- Création :  Mer 03 Juin 2015 à 21:35
--

DROP TABLE IF EXISTS `logs_data`;
CREATE TABLE IF NOT EXISTS "logs_data" (
  "logs_id" int(255) NOT NULL,
  "logs_data" text CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY ("logs_id")
);

--
-- Vider la table avant d'insérer `logs_data`
--

TRUNCATE TABLE `logs_data`;
--
-- Contenu de la table `logs_data`
--

INSERT DELAYED IGNORE INTO `logs_data` (`logs_id`, `logs_data`) VALUES
(1, '[Logs]');

-- --------------------------------------------------------

--
-- Structure de la table `logs_params`
--
-- Création :  Mer 03 Juin 2015 à 21:40
--

DROP TABLE IF EXISTS `logs_params`;
CREATE TABLE IF NOT EXISTS "logs_params" (
  "logs_id" int(255) NOT NULL,
  "server_id" int(255) NOT NULL,
  "logs_gamemode" varchar(30) CHARACTER SET utf8 NOT NULL,
  "logs_exptime" varchar(10) CHARACTER SET utf8 NOT NULL DEFAULT '64000',
  PRIMARY KEY ("logs_id","server_id")
);

--
-- Vider la table avant d'insérer `logs_params`
--

TRUNCATE TABLE `logs_params`;
--
-- Contenu de la table `logs_params`
--

INSERT DELAYED IGNORE INTO `logs_params` (`logs_id`, `server_id`, `logs_gamemode`, `logs_exptime`) VALUES
(1, 1, 'ULX', '64000');

-- --------------------------------------------------------

--
-- Structure de la table `web_design`
--
-- Création :  Mer 03 Juin 2015 à 21:50
--

DROP TABLE IF EXISTS `web_design`;
CREATE TABLE IF NOT EXISTS "web_design" (
  "design_id" int(255) NOT NULL,
  "design_name" varchar(30) COLLATE utf8_bin NOT NULL,
  "design_isonline" varchar(1) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY ("design_id")
);

--
-- Vider la table avant d'insérer `web_design`
--

TRUNCATE TABLE `web_design`;
--
-- Contenu de la table `web_design`
--

INSERT DELAYED IGNORE INTO `web_design` (`design_id`, `design_name`, `design_isonline`) VALUES
(1, 'White', '1');

-- --------------------------------------------------------

--
-- Structure de la table `web_server`
--
-- Création :  Mer 03 Juin 2015 à 22:02
-- Dernière modification :  Mer 03 Juin 2015 à 22:03
--

DROP TABLE IF EXISTS `web_server`;
CREATE TABLE IF NOT EXISTS "web_server" (
  "server_id" int(255) NOT NULL,
  "server_name" varchar(30) NOT NULL DEFAULT 'Server',
  "server_ismaster" varchar(1) NOT NULL DEFAULT '0',
  "server_folder" varchar(30) NOT NULL,
  "server_ipv4" varchar(15) NOT NULL DEFAULT '127.0.0.1',
  "server_ipv6" varchar(29) NOT NULL DEFAULT '::1',
  "server_port" varchar(5) NOT NULL DEFAULT '8080',
  PRIMARY KEY ("server_id")
) AUTO_INCREMENT=2 ;

--
-- Vider la table avant d'insérer `web_server`
--

TRUNCATE TABLE `web_server`;
--
-- Contenu de la table `web_server`
--

INSERT DELAYED IGNORE INTO `web_server` (`server_id`, `server_name`, `server_ismaster`, `server_folder`, `server_ipv4`, `server_ipv6`, `server_port`) VALUES
(1, 'Starfox64', '1', 'toto/web', '127.0.0.1', '::1', '8080');

-- --------------------------------------------------------

--
-- Structure de la table `web_user`
--
-- Création :  Mer 03 Juin 2015 à 21:57
--

DROP TABLE IF EXISTS `web_user`;
CREATE TABLE IF NOT EXISTS "web_user" (
  "user_id" int(11) NOT NULL,
  "user_name" varchar(30) COLLATE utf8_bin NOT NULL,
  "user_mail" varchar(30) COLLATE utf8_bin NOT NULL,
  "user_pass" varchar(100) COLLATE utf8_bin NOT NULL,
  "user_rank" varchar(1) COLLATE utf8_bin NOT NULL,
  "user_isonline" varchar(1) COLLATE utf8_bin NOT NULL,
  "user_motto" varchar(30) COLLATE utf8_bin NOT NULL,
  "user_description" varchar(50) COLLATE utf8_bin NOT NULL,
  "user_picture" varchar(100) COLLATE utf8_bin NOT NULL,
  "user_background" varchar(100) COLLATE utf8_bin NOT NULL,
  "user_lastlogin" varchar(21) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY ("user_id")
);

--
-- Vider la table avant d'insérer `web_user`
--

TRUNCATE TABLE `web_user`;
--
-- Contenu de la table `web_user`
--

INSERT DELAYED IGNORE INTO `web_user` (`user_id`, `user_name`, `user_mail`, `user_pass`, `user_rank`, `user_isonline`, `user_motto`, `user_description`, `user_picture`, `user_background`, `user_lastlogin`) VALUES
(1, 'Admin', 'admin@test.fr', 'password', '1', '1', 'Die in Hell', 'I''m the Admin', 'http://toto.fr/picture.png', 'http://toto.fr/background.png', '2015/01/01 @ 17:04:30');
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
