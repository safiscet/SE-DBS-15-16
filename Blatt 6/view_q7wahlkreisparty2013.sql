-- View: q7wahlkreisparty2013

DROP VIEW q7wahlkreisparty2013;

CREATE VIEW q7wahlkreisparty2013 AS (

 WITH zweitstimmenAbsolute as (select v.wahlkreis, v.zweitstimme, count(*) as absolute
    from vote v join wahlkreis wk on v.wahlkreis = wk.id
    where v.year = 2013 and (
    wk.name = 'Schweinfurt' or wk.name = 'Ingolstadt'
    or wk.name = 'Traunstein' or wk.name = 'Muenchen-Ost'
    or wk.name = 'Augsburg-Stadt')
    group by v.wahlkreis, v.zweitstimme)

 SELECT wk.name AS wahlkreis, p.abkuerzung as party,
    (select absolute from zweitstimmenAbsolute za
    where za.wahlkreis = piw.wahlkreis
    and za.zweitstimme = piw.party) as zweitstimmenAbsolute,
    cast(cast((select absolute from zweitstimmenAbsolute za
    where za.wahlkreis = piw.wahlkreis
    and za.zweitstimme = piw.party)
    as decimal (14, 4))/(select sum(absolute) 
    from zweitstimmenAbsolute za2 
    where za2.wahlkreis = wk.id 
    and zweitstimme > 0) as decimal (14, 4)) as zweitstimmenPercent
 FROM partyInWahlkreis piw
     JOIN wahlkreis wk ON piw.wahlkreis = wk.id
     JOIN party p ON piw.party = p.id
 WHERE piw.year = 2013 and (
	wk.name = 'Schweinfurt' or wk.name = 'Ingolstadt'
	or wk.name = 'Traunstein' or wk.name = 'Muenchen-Ost'
	or wk.name = 'Augsburg-Stadt')
 ORDER BY wk.name, p.abkuerzung
);