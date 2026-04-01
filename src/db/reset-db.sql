DROP DATABASE IF EXISTS Pig_Racing;
CREATE DATABASE Pig_Racing;

USE Pig_Racing;

-- 1. Videos (nur ID + Link)
CREATE TABLE video (
    VideoID INT AUTO_INCREMENT PRIMARY KEY,
    URL VARCHAR(256) NOT NULL
);

-- 2. Rennen (mehrere pro Video, über VideoID + Zeitstempel)
CREATE TABLE race (
    RaceID INT AUTO_INCREMENT PRIMARY KEY,

    -- Referenz auf Video (1 Video -> mehrere Rennen)
    VideoID INT NOT NULL,
    StartTime INT NOT NULL, -- In Sekunden, direkt aus Youtube-Video -> Share -> im link am ende: https://youtu.be/a142...&t=309 -> 5:09 = 309 Sekunden
    EndTime INT NOT NULL,   -- In Sekunden

    FOREIGN KEY (VideoID) REFERENCES video(VideoID)
        ON DELETE CASCADE
);

-- 3. Schweine (Stammdaten / "Datenbank" der Schweine)
CREATE TABLE pig (
    PigID INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(128) NOT NULL,
    lastName VARCHAR(128) NOT NULL,
    displayName VARCHAR(128) NOT NULL,
    acceleration INT NOT NULL, 
	topspeed INT NOT NULL, 
	offroad INT NOT NULL,
	handling INT NOT NULL,
	jump INT NOT NULL
);

-- 4. Verbindung Race <-> Schweine
-- Hier wird gespeichert:
-- welches Schwein nimmt teil und ob es gewonnen hat
CREATE TABLE race_pig (
    RaceID INT,
    PigID INT,

    -- Platzierung im Rennen (1 = Gewinner, 2 = Zweiter, usw.)
    Position INT NOT NULL,

    -- verhindert doppelte Einträge (ein Schwein nur einmal pro Rennen)
    PRIMARY KEY (RaceID, PigID),

    FOREIGN KEY (RaceID) REFERENCES race(RaceID)
        ON DELETE CASCADE,

    FOREIGN KEY (PigID) REFERENCES pig(PigID)
        ON DELETE CASCADE
);