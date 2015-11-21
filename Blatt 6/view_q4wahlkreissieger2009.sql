-- View: q4wahlkreissieger2009

DROP VIEW IF EXISTS q4wahlkreissieger2009;

CREATE VIEW q4wahlkreissieger2009 AS (
 select wk.name as wahlkreis, p1.abkuerzung as winnerPartyErststimmen, 
 p2.abkuerzung as winnerPartyZweitstimmen
 from wahlkreis wk join wahlkreisinelection wie on wk.id = wie.wahlkreis
 join candidateInElection c on wie.winnercandidate = c.candidate
 join party p1 on p1.id = c.party
 join party p2 on p2.id = wie.winnerparty
 where wie.year = 2009
);
