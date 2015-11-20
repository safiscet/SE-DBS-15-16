-- View: q3wahlkreisparty2013

DROP VIEW IF EXISTS q3wahlkreisparty2013;

CREATE VIEW q3wahlkreisparty2013 AS (
 SELECT wk.name AS wahlkreis, p.abkuerzung as party,
    piw.zweitstimmen as zweitstimmenAbsolute,
    cast(cast(piw.zweitstimmen as decimal (14, 4))/(select sum(p2.zweitstimmen) 
    from partyinwahlkreis p2 where p2.wahlkreis = piw.wahlkreis
    and p2.year = 2013) as decimal (14, 4)) as zweitstimmenPercent
 FROM partyInWahlkreis piw
     JOIN wahlkreis wk ON piw.wahlkreis = wk.id
     JOIN party p ON piw.party = p.id
 WHERE piw.year = 2013
 ORDER BY wk.name, p.abkuerzung
);