-- View: q3wahlkreisparty2013

DROP VIEW IF EXISTS q3wahlkreisparty2013;

CREATE VIEW q3wahlkreisparty2013 AS (
 
 WITH zweitstimmenGesamt as (SELECT wahlkreis, sum(zweitstimmen) AS sum
      FROM partyinwahlkreis 
      WHERE year = 2013
      GROUP BY wahlkreis)
      
 SELECT wk.name AS wahlkreis, 
    p.abkuerzung as party,
    piw.zweitstimmen as zweitstimmenAbsolute,
    cast(cast(piw.zweitstimmen as decimal (14, 4))/
    zsg.sum as decimal (14, 4)) as zweitstimmenPercent
 FROM partyInWahlkreis piw
    JOIN wahlkreis wk ON piw.wahlkreis = wk.id
    JOIN party p ON piw.party = p.id
    JOIN zweitstimmenGesamt zsg on zsg.wahlkreis = piw.wahlkreis
 WHERE piw.year = 2013
 ORDER BY wk.name, p.abkuerzung
);