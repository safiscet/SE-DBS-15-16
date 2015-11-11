COPY vote (year, erststimme, zweitstimme, wahlkreis) FROM 'C:/DBS-Projekt/Generator/generatedVotes2013.csv'
 DELIMITERS ';' CSV ;