USE Pig_Racing;


INSERT INTO video (URL) VALUES
('https://www.youtube.com/watch?v=8jLNNMFur5A'),
('https://www.youtube.com/watch?v=bP8IPgD5FfI'),
('https://www.youtube.com/watch?v=4zBXSigFui4');

#Namen bei den schweinen stimmen Stats müssen noch angepasst werden
INSERT INTO Schweine (Name, Beschleunigung, Maximalgeschwindigkeit, Gelaende_faehigkeit, Handhabung, Sprungkraft) VALUES
('Ginger Hamilton', 8, 9, 6, 7, 5),
('Piggy Smalls', 9, 8, 7, 8, 6),
('Hoshi Oink', 6, 7, 10, 6, 4),
('Pepper Sanchez', 7, 6, 5, 7, 9),
('Bear Trotsky', 10, 10, 6, 9, 7);

# die rennen müssen an die videos angepasst werden
INSERT INTO Rennen (Beginnzeit, Endzeit, Gewinner) VALUES
(0.0, 12.5, 'Ginger Hamilton'),
(0.0, 11.8, 'Piggy Smalls'),
(0.0, 13.2, 'Hoshi Oink'),
(0.0, 10.9, 'Pepper Sanchez');