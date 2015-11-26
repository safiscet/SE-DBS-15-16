DROP VIEW IF EXISTS Q3wahlkreisuebersicht2009 CASCADE;

CREATE VIEW Q3wahlkreisuebersicht2009 AS (
	select wk.id as nummer, wk.name as wahlkreis, w.wahlbeteiligung as wahlbeteiligung,
	c.name as candidate
	from wahlkreisinelection w join wahlkreis wk on w.wahlkreis = wk.id 
	join candidate c on w.winnercandidate = c.id
	where w.year = 2009 
	order by wk.id
);