DROP DATABASE IF EXISTS Pig_Racing;
CREATE Database Pig_Racing;

use Pig_Racing;

CREATE TABLE video (
	VideoID INT AUTO_INCREMENT PRIMARY KEY,
	URL VARCHAR(256) NOT NULL 
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rennen (
	RennenID INT AUTO_INCREMENT PRIMARY KEY,
	VideoID Int Not Null,
	Beginnzeit FLOAT NOT NULL,
	Endzeit FLOAT NOT NULL,
	FOREIGN KEY (VideoID) REFERENCES video(VideoID) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE schweine (
	PigID Int AUTO_INCREMENT PRIMARY KEY,
	Name Varchar(128) NOT NULL,
	Beschleunigung INT NOT NULL, 
	Maximalgeschwindigkeit INT NOT NULL, 
	Gelaende_faehigkeit INT NOT NULL,
	Handhabung INT NOT NULL,
	Sprungkraft INT NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

create table rennen_schweine (
	RennenID INT,
	PigID INT,
	Wertung INT NOT NULL, 
	PRIMARY KEY (RennenID, PigID),
	FOREIGN KEY (RennenID) REFERENCES rennen(RennenID) ON DELETE CASCADE, 
	FOREIGN KEY (PigID) REFERENCES schweine(PigID) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;