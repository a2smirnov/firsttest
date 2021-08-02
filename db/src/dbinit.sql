CREATE DATABASE api_db;
USE api_db;
CREATE TABLE `covidcounter` (
    id integer NOT NULL AUTO_INCREMENT,
    `date_value` date NOT NULL,
    `country_code` char(3) NOT NULL,
    `confirmed` integer NOT NULL,
    `deaths` integer NOT NULL,
    `stringency_actual` float,
    `stringency` float,    
    `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX stat_by_country (date_value,country_code)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;
