-- View: q3wahlkreisparty2009

DROP VIEW IF EXISTS q3wahlkreisparty2009;

CREATE VIEW q3wahlkreisparty2009 AS (

 WITH zweitstimmenGesamt as (SELECT wahlkreis, sum(zweitstimmen) AS sum
      FROM partyinwahlkreis 
      WHERE year = 2009
      GROUP BY wahlkreis)
      
 SELECT wk.name AS wahlkreis, 
    p.abkuerzung as party,
    piw.zweitstimmen as zweitstimmenAbsolute2009,
    cast(cast(piw.zweitstimmen as decimal (14, 4))/
    zsg.sum as decimal (14, 4)) as zweitstimmenPercent2009
 FROM partyInWahlkreis piw
    JOIN wahlkreis wk ON piw.wahlkreis = wk.id
    JOIN party p ON piw.party = p.id
    JOIN zweitstimmenGesamt zsg on zsg.wahlkreis = piw.wahlkreis
 WHERE piw.year = 2009
 ORDER BY wk.id, p.abkuerzung
);