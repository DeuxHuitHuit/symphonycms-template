-- phpMyAdmin SQL Dump
-- version 4.0.8
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Version du serveur: 5.1.72-cll
-- Version de PHP: 5.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `dev_pm`
--

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_1`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_2`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_2` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_3`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_3` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `mimetype` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `file` (`file`),
  KEY `mimetype` (`mimetype`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_4`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_4` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_5`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_5` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_6`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_6` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_7`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_7` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_8`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_8` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_9`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_9` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_10`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_10` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_11`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_11` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_12`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_12` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_13`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_13` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_14`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_14` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_15`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_15` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` enum('yes','no') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_16`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_16` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `value` (`value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_17`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_17` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------


--
-- Structure de la table `sym_entries_data_18`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_18` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- Structure de la table `sym_entries_data_19`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_19` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-en` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-en` text COLLATE utf8_unicode_ci,
  `value_formatted-en` text COLLATE utf8_unicode_ci,
  `word_count-en` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-en` (`handle-en`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-en` (`value-en`),
  FULLTEXT KEY `value_formatted-en` (`value_formatted-en`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_20`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_20` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `page_id` int(11) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  KEY `page_id` (`page_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_21`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_21` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_22`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_22` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_23`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_23` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_24`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_24` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `value_formatted` text COLLATE utf8_unicode_ci,
  `word_count` int(11) unsigned DEFAULT NULL,
  `handle-fr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value-fr` text COLLATE utf8_unicode_ci,
  `value_formatted-fr` text COLLATE utf8_unicode_ci,
  `word_count-fr` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `handle-fr` (`handle-fr`),
  KEY `handle` (`handle`),
  FULLTEXT KEY `value-fr` (`value-fr`),
  FULLTEXT KEY `value_formatted-fr` (`value_formatted-fr`),
  FULLTEXT KEY `value` (`value`),
  FULLTEXT KEY `value_formatted` (`value_formatted`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Structure de la table `sym_entries_data_25`
--

CREATE TABLE IF NOT EXISTS `sym_entries_data_25` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `entry_id` int(11) unsigned NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `mimetype` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entry_id` (`entry_id`),
  KEY `file` (`file`),
  KEY `mimetype` (`mimetype`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- Contenu de la table `sym_fields`
--

INSERT INTO `sym_fields` (`id`, `label`, `element_name`, `type`, `parent_section`, `required`, `sortorder`, `location`, `show_column`) VALUES
(1, 'Site Web', 'site-web-tab', 'publish_tabs', 1, 'no', 0, 'main', 'no'),
(2, 'Site titre', 'site-titre', 'multilingual_textbox', 1, 'yes', 1, 'main', 'yes'),
(3, 'Image partage', 'image-partage', 'image_upload', 1, 'no', 2, 'sidebar', 'yes'),
(4, 'Description (Ce texte affichera pour les partages sur les médias sociaux et sur Google)', 'description', 'multilingual_textbox', 1, 'yes', 3, 'main', 'yes'),
(5, 'Twitter url', 'twitter-url', 'textbox', 1, 'no', 4, 'sidebar', 'no'),
(6, 'Twitter user', 'twitter-user', 'textbox', 1, 'no', 5, 'sidebar', 'no'),
(7, 'Twitter site domain', 'twitter-site-domain', 'textbox', 1, 'no', 6, 'sidebar', 'no'),
(8, 'Facebook url', 'facebook-url', 'textbox', 1, 'no', 7, 'sidebar', 'no'),
(9, 'Navigateurs non-supportés', 'navigateurs-non-supportes-tab', 'publish_tabs', 1, 'no', 10, 'main', 'no'),
(10, 'Navigateurs non-supportés: Titre', 'navigateurs-non-supportes-titre', 'multilingual_textbox', 1, 'yes', 11, 'main', 'no'),
(11, 'Navigateurs non-supportés: Texte', 'navigateurs-non-supportes-texte', 'multilingual_textbox', 1, 'yes', 12, 'main', 'no'),
(12, 'Navigateurs non-supportés: Poursuivre', 'navigateurs-non-supportes-poursuivre', 'multilingual_textbox', 1, 'yes', 13, 'sidebar', 'no'),
(13, 'Page', 'page', 'pages', 2, 'yes', 0, 'main', 'yes'),
(14, 'Titre', 'titre', 'multilingual_textbox', 2, 'yes', 1, 'main', 'yes'),
(15, 'Publié', 'publie', 'checkbox', 2, 'no', 2, 'sidebar', 'yes'),
(16, 'Ordre', 'ordre', 'order_entries', 2, 'no', 3, 'sidebar', 'yes'),
(17, 'Titre', 'titre', 'multilingual_textbox', 3, 'yes', 0, 'main', 'yes'),
(20, 'Page', 'page', 'pages', 3, 'yes', 1, 'sidebar', 'yes'),
(19, 'Texte', 'texte', 'multilingual_textbox', 3, 'no', 2, 'main', 'no'),
(21, 'Vimeo url', 'vimeo-url', 'textbox', 1, 'no', 8, 'sidebar', 'no'),
(22, 'Instagram url', 'instagram-url', 'textbox', 1, 'no', 9, 'sidebar', 'no'),
(23, 'Facebook page id', 'facebook-page-id', 'textbox', 1, 'no', 7, 'sidebar', 'no'),
(18, 'Page', 'page', 'pages', 4, 'yes', 0, 'main', 'yes'),
(24, 'Description', 'description', 'multilingual_textbox', 4, 'yes', 1, 'main', 'yes'),
(25, 'Image partage', 'image-partage', 'image_upload', 4, 'no', 2, 'sidebar', 'yes');

-- --------------------------------------------------------


--
-- Contenu de la table `sym_fields_checkbox`
--

INSERT INTO `sym_fields_checkbox` (`id`, `field_id`, `default_state`, `description`) VALUES
(1, 15, 'on', NULL);

-- --------------------------------------------------------


--
-- Contenu de la table `sym_fields_image_upload`
--

INSERT INTO `sym_fields_image_upload` (`id`, `field_id`, `destination`, `validator`, `unique`, `min_width`, `min_height`, `max_width`, `max_height`, `resize`) VALUES
(1, 3, '/workspace/uploads/config', '/\\.(?:jpe?g|png)$/i', 'yes', 300, 300, 1200, 1200, 'no'),
(2, 25, '/workspace/uploads/metas', '/\\.(?:jpe?g|png)$/i', 'yes', 300, 300, 1200, 1200, 'no');

-- --------------------------------------------------------

--
-- Contenu de la table `sym_fields_multilingual_textbox`
--

INSERT INTO `sym_fields_multilingual_textbox` (`id`, `field_id`, `column_length`, `text_size`, `text_formatter`, `text_validator`, `text_length`, `text_cdata`, `text_handle`, `default_main_lang`, `required_languages`) VALUES
(16, 2, 75, 'single', 'none', NULL, 0, 'no', 'yes', 'yes', 'all'),
(17, 4, 75, 'small', 'none', NULL, 0, 'no', 'no', 'yes', 'all'),
(18, 10, 75, 'single', 'none', NULL, 0, 'no', 'no', 'yes', 'all'),
(20, 12, 75, 'single', 'none', NULL, 0, 'no', 'no', 'yes', 'all'),
(19, 11, 75, 'medium', 'markdown', NULL, 0, 'no', 'no', 'yes', 'all'),
(11, 14, 75, 'single', 'none', NULL, 0, 'no', 'yes', 'no', 'all'),
(14, 17, 75, 'single', 'none', NULL, 0, 'no', 'yes', 'no', 'all'),
(15, 19, 75, 'medium', 'markdown', NULL, 0, 'no', 'no', 'yes', ''),
(21, 24, 75, 'small', 'none', NULL, 0, 'no', 'yes', 'no', 'all');

-- --------------------------------------------------------



INSERT INTO `sym_fields_order_entries` (`id`, `field_id`, `force_sort`, `hide`) VALUES
(1, 16, NULL, 'yes');

-- --------------------------------------------------------

--
-- Contenu de la table `sym_fields_pages`
--

INSERT INTO `sym_fields_pages` (`id`, `field_id`, `allow_multiple_selection`, `page_types`) VALUES
(1, 13, 'no', NULL),
(2, 20, 'no', '403, 404'),
(3, 18, 'no', 'f288-model-defaultPage, f288-model-index');

-- --------------------------------------------------------

--
-- Contenu de la table `sym_fields_publish_tabs`
--

INSERT INTO `sym_fields_publish_tabs` (`id`, `field_id`) VALUES
(5, 1),
(6, 9);

-- --------------------------------------------------------

--
-- Contenu de la table `sym_fields_textbox`
--

INSERT INTO `sym_fields_textbox` (`id`, `field_id`, `column_length`, `text_size`, `text_formatter`, `text_validator`, `text_length`, `text_cdata`, `text_handle`) VALUES
(10, 5, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(11, 6, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(12, 7, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(13, 8, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(14, 21, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(15, 22, 75, 'single', 'none', NULL, 0, 'no', 'no'),
(16, 23, 75, 'single', 'none', NULL, 0, 'no', 'no');

-- --------------------------------------------------------

--
-- Contenu de la table `sym_pages`
--

INSERT INTO `sym_pages` (`id`, `parent`, `title`, `handle`, `path`, `params`, `data_sources`, `events`, `sortorder`, `plh_t-en`, `plh_h-en`, `plh_t-fr`, `plh_h-fr`) VALUES
(1, NULL, 'Index', 'index', NULL, NULL,           'javascript,menu,package,pages,plh_page,site_config', 'flang_redirect,login', 1, 'Index', 'index', 'Index', 'index'),
(2, NULL, '403', '403', NULL, NULL,               'javascript,menu,package,pages,pages_erreurs,plh_page,site_config', 'flang_redirect,login', 2, '403', '403', '403', '403'),
(3, NULL, '404', '404', NULL, NULL,               'javascript,menu,package,pages,pages_erreurs,plh_page,site_config', 'flang_redirect,login', 3, '404', '404', '404', '404'),
(4, NULL, 'UI-toolkit', 'ui-toolkit', NULL, NULL, 'javascript,menu,package,pages,plh_page,site_config', 'flang_redirect,login', 4, 'UI-toolkit', 'ui-toolkit', 'UI-toolkit', 'ui-toolkit');

-- --------------------------------------------------------

--
-- Contenu de la table `sym_pages_types`
--

INSERT INTO `sym_pages_types` (`id`, `page_id`, `type`) VALUES
(12, 1, 'f288-model-defaultPage'),
(6, 2, '403'),
(9, 3, '404'),
(7, 2, 'f288-hidden'),
(8, 2, 'hidden'),
(10, 3, 'f288-hidden'),
(11, 3, 'hidden'),
(13, 1, 'index');

-- --------------------------------------------------------


--
-- Contenu de la table `sym_sections`
--

INSERT INTO `sym_sections` (`id`, `name`, `handle`, `sortorder`, `hidden`, `max_entries`, `navigation_group`) VALUES
(1, 'Configuration', 'configuration', 1, 'no', 1, 'Configuration'),
(2, 'Menu', 'menu', 2, 'no', 6, 'Configuration'),
(3, 'Pages d''erreurs', 'pages-derreurs', 3, 'no', 2, 'Configuration'),
(4, 'Pages Metas', 'pages-metas', 4, 'no', 0, 'yes', 'Configuration ');

-- --------------------------------------------------------

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
