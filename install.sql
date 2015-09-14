CREATE TABLE IF NOT EXISTS `oc_modification_files` (
  `modification_id` int(11) NOT NULL,
  `files` text NOT NULL,
  `newfiles` text NOT NULL,
  `install_sql` mediumtext NOT NULL,
  `install_php` mediumtext NOT NULL,
  PRIMARY KEY (`modification_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE  `oc_modification` MODIFY `xml` MEDIUMTEXT;