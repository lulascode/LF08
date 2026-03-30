CREATE Database Pig_Racing;

use Pig_Racing;

CREATE TABLE video (
	VideoID INT AUTO_INCREMENT PRIMARY KEY,
	URL VARCHAR(256) NOT NULL 
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Rennen (
	RennenID INT AUTO_INCREMENT PRIMARY KEY,
	Beginnzeit FLOAT NOT NULL,
	Endzeit FLOAT NOT NULL,
	Gewinner VARCHAR(128) NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE Schweine (
	PigID Int AUTO_INCREMENT PRIMARY KEY,
	Name Varchar(128) NOT NULL,
	Beschleunigung INT NOT NULL, 
	Maximalgeschwindigkeit INT NOT NULL, 
	Gelaende_faehigkeit INT NOT NULL,
	Handhabung INT NOT NULL,
	Sprungkraft INT NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
