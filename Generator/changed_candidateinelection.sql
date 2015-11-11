/*
Updates für Kandidaten wegen "leeren" Wahlkreisen 2009

Candidate 5063 (Rusin, Hartmut) (Parteilos)
Wahlkreis 14 -> Wahlkreis 13
(ähnlicher Wahlkreis, gleiches Bundesland, tritt nur 2009 an)

neuer Candidate 6958 (Hassel-Reusing, Sarah Luzia) (ödp)
 -> Wahlkreis 13
(gab keinen möglichen Kandidaten zum Verschieben)

neuer Candidate 6959 (Reusing-Hassel, Luzia Sarah) (ödp)
 -> Wahlkreis 14
(gab keinen möglichen Kandidaten zum Verschieben)

neuer Candidate 6960 (Baden, Jürgen) (MLPD)
-> Wahlkreis 19
(gab keinem möglichen Kandidaten zum Verschieben)

neuer Candidate 6961 (Azami, Armin) (BüSo)
-> Walkreis 19
(gab keinem möglichen Kandidaten zum Verschieben)

neuer Candidate 6962 (Grube, Peter-Karl) (ödp)
-> Walkreis 19
(gab keinem möglichen Kandidaten zum Verschieben)

Candidate 3804 (Münz, Volkmar) (Parteilos)
Wahlkreis 18 -> Wahlkreis 19
(gleiches Bundesland, mehrere Candidates in 18)

neuer Candidate 6963 (Gruben, Hans) (ödp)
-> Walkreis 22
(gab keinem möglichen Kandidaten zum Verschieben)

neuer Candidate 6964 (Gruban, Hansel) (BüSo)
-> Walkreis 23
(gab keinem möglichen Kandidaten zum Verschieben)

neuer Candidate 6965 (Müller, Peter) (RRP)
-> Walkreis 27
(gab keinem möglichen Kandidaten zum Verschieben)

neuer Candidate 6966 (Müller, Thorben) (Parteilos)
-> Walkreis 29
(gab keinem möglichen Kandidaten zum Verschieben)
*/

UPDATE candidateinelection
SET wahlkreis = 13
WHERE candidate = 5063
AND year = 2009;

INSERT INTO candidate VALUES (6958, 'Hassel-Reusing, Sarah Luzia', 1961);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6958, 2009, 28, 13, 13);

INSERT INTO candidate VALUES (6959, 'Reusing-Hassel, Luzia Sarah', 1963);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6959, 2009, 28, 14, 13);

INSERT INTO candidate VALUES (6960, 'Baden, Jürgen', 1961);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6960, 2009, 24, 19, 2);

INSERT INTO candidate VALUES (6961, 'Azami, Armin', 1965);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6961, 2009, 8, 19, 2);

INSERT INTO candidate VALUES (6962, 'Grube, Peter-Karl', 1951);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6962, 2009, 28, 19, 2);

UPDATE candidateinelection
SET wahlkreis = 19
WHERE candidate = 3804
AND year = 2009;

INSERT INTO candidate VALUES (6963, 'Gruben, Hans', 1957);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6963, 2009, 28, 22, 2);

INSERT INTO candidate VALUES (6964, 'Gruban, Hansel', 1957);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6964, 2009, 8, 23, 2);

INSERT INTO candidate VALUES (6965, 'Müller, Peter', 1962);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6965, 2009, 7, 27, 3);

INSERT INTO candidate VALUES (6966, 'Müller, Thorben', 1962);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) 
VALUES (6966, 2009, 40, 29, 3);

/*
GENERIERT
*/

INSERT INTO candidate VALUES (6967, 'Montalban, Trent', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6967, 2009, 8, 30, 3);

INSERT INTO candidate VALUES (6968, 'Shuecraft, Filiberto', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6968, 2009, 7, 36, 3);

INSERT INTO candidate VALUES (6969, 'Ruberto, Gaylord', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6969, 2009, 40, 39, 3);

INSERT INTO candidate VALUES (6970, 'Dohse, Linwood', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6970, 2009, 24, 41, 3);

INSERT INTO candidate VALUES (6971, 'Mcclaney, Kirby', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6971, 2009, 7, 41, 3);

INSERT INTO candidate VALUES (6972, 'Stedronsky, Bernie', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6972, 2009, 40, 42, 3);

INSERT INTO candidate VALUES (6973, 'Yablonsky, Robbie', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6973, 2009, 7, 44, 3);

INSERT INTO candidate VALUES (6974, 'Hisle, Herschel', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6974, 2009, 30, 45, 3);

INSERT INTO candidate VALUES (6975, 'Heuwinkel, Jake', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6975, 2009, 40, 45, 3);

INSERT INTO candidate VALUES (6976, 'Beldin, Denny', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6976, 2009, 7, 47, 3);

INSERT INTO candidate VALUES (6977, 'Bezio, Lou', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6977, 2009, 40, 47, 3);

INSERT INTO candidate VALUES (6978, 'Yacoub, Eduardo', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6978, 2009, 24, 50, 3);

INSERT INTO candidate VALUES (6979, 'Montoure, Salvador', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6979, 2009, 31, 50, 3);

INSERT INTO candidate VALUES (6980, 'Dilcher, Cletus', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6980, 2009, 40, 50, 3);

INSERT INTO candidate VALUES (6981, 'Jahaly, Sal', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6981, 2009, 30, 51, 3);

INSERT INTO candidate VALUES (6982, 'Bourgoyne, Wade', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6982, 2009, 7, 51, 3);

INSERT INTO candidate VALUES (6983, 'Shryack, Brady', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6983, 2009, 40, 53, 3);

INSERT INTO candidate VALUES (6984, 'Koger, Seth', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6984, 2009, 24, 54, 4);

INSERT INTO candidate VALUES (6985, 'Wason, Dylan', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6985, 2009, 7, 55, 4);

INSERT INTO candidate VALUES (6986, 'Reams, Gordon', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6986, 2009, 40, 57, 12);

INSERT INTO candidate VALUES (6987, 'Jakob, Derick', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6987, 2009, 40, 64, 12);

INSERT INTO candidate VALUES (6988, 'Lamoureaux, Manual', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6988, 2009, 21, 65, 12);

INSERT INTO candidate VALUES (6989, 'Luttmer, Huey', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6989, 2009, 24, 68, 15);

INSERT INTO candidate VALUES (6990, 'Liddiard, Man', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6990, 2009, 24, 69, 15);

INSERT INTO candidate VALUES (6991, 'Mccaskey, Sung', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6991, 2009, 40, 69, 15);

INSERT INTO candidate VALUES (6992, 'Rois, Emmett', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6992, 2009, 40, 73, 15);

INSERT INTO candidate VALUES (6993, 'Guiski, Dewayne', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6993, 2009, 8, 75, 11);

INSERT INTO candidate VALUES (6994, 'Freda, Garth', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6994, 2009, 40, 75, 11);

INSERT INTO candidate VALUES (6995, 'Sojka, Alec', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6995, 2009, 24, 78, 11);

INSERT INTO candidate VALUES (6996, 'Marriot, Harland', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6996, 2009, 19, 79, 11);

INSERT INTO candidate VALUES (6997, 'Westerfeld, Son', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6997, 2009, 16, 79, 11);

INSERT INTO candidate VALUES (6998, 'Hamiton, Harry', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6998, 2009, 24, 82, 11);

INSERT INTO candidate VALUES (6999, 'Jabs, Theodore', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (6999, 2009, 17, 82, 11);

INSERT INTO candidate VALUES (7000, 'Urrabazo, Arnold', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7000, 2009, 24, 84, 11);

INSERT INTO candidate VALUES (7001, 'Iurato, Wilfred', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7001, 2009, 8, 84, 11);

INSERT INTO candidate VALUES (7002, 'Dubois, Tommy', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7002, 2009, 40, 91, 5);

INSERT INTO candidate VALUES (7003, 'Primavera, Chauncey', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7003, 2009, 24, 94, 5);

INSERT INTO candidate VALUES (7004, 'Parthemore, Lyman', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7004, 2009, 8, 96, 5);

INSERT INTO candidate VALUES (7005, 'Tolosa, Francesco', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7005, 2009, 16, 96, 5);

INSERT INTO candidate VALUES (7006, 'Corf, Tim', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7006, 2009, 38, 97, 5);

INSERT INTO candidate VALUES (7007, 'Byerley, Alberto', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7007, 2009, 40, 97, 5);

INSERT INTO candidate VALUES (7008, 'Rupe, Lamont', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7008, 2009, 28, 99, 5);

INSERT INTO candidate VALUES (7009, 'Calvin, Reyes', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7009, 2009, 40, 99, 5);

INSERT INTO candidate VALUES (7010, 'Schiedler, Shon', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7010, 2009, 24, 101, 5);

INSERT INTO candidate VALUES (7011, 'Lick, Sherwood', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7011, 2009, 24, 106, 5);

INSERT INTO candidate VALUES (7012, 'Borowicz, Mohammad', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7012, 2009, 40, 109, 5);

INSERT INTO candidate VALUES (7013, 'Frase, Weldon', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7013, 2009, 19, 110, 5);

INSERT INTO candidate VALUES (7014, 'Schatzel, Vincenzo', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7014, 2009, 27, 113, 5);

INSERT INTO candidate VALUES (7015, 'Pennello, Brooks', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7015, 2009, 19, 113, 5);

INSERT INTO candidate VALUES (7016, 'Jenne, Corey', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7016, 2009, 24, 114, 5);

INSERT INTO candidate VALUES (7017, 'Warters, Antione', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7017, 2009, 40, 115, 5);

INSERT INTO candidate VALUES (7018, 'Beek, Burton', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7018, 2009, 24, 116, 5);

INSERT INTO candidate VALUES (7019, 'Poellinetz, Elden', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7019, 2009, 24, 119, 5);

INSERT INTO candidate VALUES (7020, 'Rattigan, Renaldo', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7020, 2009, 8, 119, 5);

INSERT INTO candidate VALUES (7021, 'Sienko, Werner', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7021, 2009, 40, 121, 5);

INSERT INTO candidate VALUES (7022, 'Raulino, Tyler', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7022, 2009, 24, 122, 5);

INSERT INTO candidate VALUES (7023, 'Laborin, Wilson', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7023, 2009, 13, 124, 5);

INSERT INTO candidate VALUES (7024, 'Bardwell, Harry', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7024, 2009, 24, 125, 5);

INSERT INTO candidate VALUES (7025, 'Vanlandingham, Elias', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7025, 2009, 28, 125, 5);

INSERT INTO candidate VALUES (7026, 'Klimek, Martin', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7026, 2009, 23, 129, 5);

INSERT INTO candidate VALUES (7027, 'Montemayor, Ollie', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7027, 2009, 40, 129, 5);

INSERT INTO candidate VALUES (7028, 'Tencer, Johnson', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7028, 2009, 23, 131, 5);

INSERT INTO candidate VALUES (7029, 'Bonadonna, Kent', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7029, 2009, 28, 131, 5);

INSERT INTO candidate VALUES (7030, 'Derhammer, Elliot', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7030, 2009, 40, 131, 5);

INSERT INTO candidate VALUES (7031, 'Wintermute, Alec', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7031, 2009, 27, 132, 5);

INSERT INTO candidate VALUES (7032, 'Cadoy, Hilton', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7032, 2009, 8, 132, 5);

INSERT INTO candidate VALUES (7033, 'Eyestone, Lino', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7033, 2009, 27, 136, 5);

INSERT INTO candidate VALUES (7034, 'Khalaf, Jarrett', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7034, 2009, 19, 136, 5);

INSERT INTO candidate VALUES (7035, 'Funderburg, Nathanael', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7035, 2009, 28, 136, 5);

INSERT INTO candidate VALUES (7036, 'Larrea, Levi', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7036, 2009, 24, 139, 5);

INSERT INTO candidate VALUES (7037, 'Odegard, Val', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7037, 2009, 40, 139, 5);

INSERT INTO candidate VALUES (7038, 'Schiefen, Malik', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7038, 2009, 8, 140, 5);

INSERT INTO candidate VALUES (7039, 'Pollock, Gilberto', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7039, 2009, 35, 141, 5);

INSERT INTO candidate VALUES (7040, 'Fortmann, Jere', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7040, 2009, 13, 142, 5);

INSERT INTO candidate VALUES (7041, 'Ilg, Morton', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7041, 2009, 8, 142, 5);

INSERT INTO candidate VALUES (7042, 'Hojeij, Mckinley', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7042, 2009, 40, 143, 5);

INSERT INTO candidate VALUES (7043, 'Gratz, Ambrose', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7043, 2009, 23, 149, 5);

INSERT INTO candidate VALUES (7044, 'Goldbaum, Guillermo', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7044, 2009, 37, 150, 5);

INSERT INTO candidate VALUES (7045, 'Winsman, Herman', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7045, 2009, 8, 152, 14);

INSERT INTO candidate VALUES (7046, 'Seraiva, Stephen', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7046, 2009, 40, 154, 14);

INSERT INTO candidate VALUES (7047, 'Tolosky, Nickolas', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7047, 2009, 8, 157, 14);

INSERT INTO candidate VALUES (7048, 'Fugate, Quintin', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7048, 2009, 40, 159, 14);

INSERT INTO candidate VALUES (7049, 'Revak, Mac', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7049, 2009, 24, 160, 14);

INSERT INTO candidate VALUES (7050, 'Lavelle, Sandy', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7050, 2009, 40, 164, 14);

INSERT INTO candidate VALUES (7051, 'Miville, Reuben', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7051, 2009, 8, 165, 14);

INSERT INTO candidate VALUES (7052, 'Birdow, Nick', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7052, 2009, 30, 166, 14);

INSERT INTO candidate VALUES (7053, 'Gaibler, Alec', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7053, 2009, 40, 167, 6);

INSERT INTO candidate VALUES (7054, 'Drennen, Doug', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7054, 2009, 24, 168, 6);

INSERT INTO candidate VALUES (7055, 'Backfisch, Rudolph', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7055, 2009, 40, 173, 6);

INSERT INTO candidate VALUES (7056, 'Carrington, Foster', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7056, 2009, 35, 175, 6);

INSERT INTO candidate VALUES (7057, 'Vanderschel, Ervin', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7057, 2009, 37, 175, 6);

INSERT INTO candidate VALUES (7058, 'Dusett, Dane', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7058, 2009, 40, 175, 6);

INSERT INTO candidate VALUES (7059, 'Marsh, Van', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7059, 2009, 8, 215, 9);

INSERT INTO candidate VALUES (7060, 'Matlow, Darryl', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7060, 2009, 6, 215, 9);

INSERT INTO candidate VALUES (7061, 'Hemond, Kareem', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7061, 2009, 28, 215, 9);

INSERT INTO candidate VALUES (7062, 'Hallstead, Morris', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7062, 2009, 40, 215, 9);

INSERT INTO candidate VALUES (7063, 'Cheatwood, Philip', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7063, 2009, 19, 224, 9);

INSERT INTO candidate VALUES (7064, 'Navanjo, Ronald', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7064, 2009, 28, 224, 9);

INSERT INTO candidate VALUES (7065, 'Beal, Trent', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7065, 2009, 7, 224, 9);

INSERT INTO candidate VALUES (7066, 'Closey, Ryan', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7066, 2009, 21, 224, 9);

INSERT INTO candidate VALUES (7067, 'Schop, Felton', 1960);
INSERT INTO candidateinelection (candidate, year, party, wahlkreis, federalland) VALUES (7067, 2013, 40, 247, 9);