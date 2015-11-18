DROP MATERIALIZED VIEW IF EXISTS Q10wahlkreisuebersicht2009 CASCADE;

CREATE MATERIALIZED VIEW Q10wahlkreisuebersicht2009 AS (
	select wk.name as wahlkreis, cast(
		(select count(*) from vote v 
		join wahlkreis wks on v.wahlkreis = wks.id
		where v.wahlkreis = w.wahlkreis and v.year = 2009)/
		cast(w.residents as decimal(13,4)) 
		as decimal(5,4)) as wahlbeteiligung,
	c.name as candidate
	from wahlkreisinelection w join wahlkreis wk on w.wahlkreis = wk.id 
	join candidate c on w.winnercandidate = c.id
	where w.year = 2009 and (
	wk.name = 'Schweinfurt' or wk.name = 'Ingolstadt'
	or wk.name = 'Traunstein' or wk.name = 'Muenchen-Ost'
	or wk.name = 'Augsburg-Stadt')
);