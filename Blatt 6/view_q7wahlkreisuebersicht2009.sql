-- View: Q7wahlkreisuebersicht2009

DROP VIEW IF EXISTS Q7wahlkreisuebersicht2009 CASCADE;

CREATE OR REPLACE VIEW Q7wahlkreisuebersicht2009 AS (
	WITH wahlbet AS (
		select v.wahlkreis, count(*) as all 
		from vote v 
		join wahlkreis wks on v.wahlkreis = wks.id
		where v.year = 2009 and (
		wks.name = 'Schweinfurt' or wks.name = 'Ingolstadt'
		or wks.name = 'Traunstein' or wks.name = 'Muenchen-Ost'
		or wks.name = 'Augsburg-Stadt')
		group by wahlkreis
	)
		
	select wk.id as nummer,
		wk.name as wahlkreis, 
		cast(wb.all / cast(w.residents as decimal(13,4)) 
		as decimal(5,4)) as wahlbeteiligung,
		c.name as candidate
	from wahlkreisinelection w 
	join wahlkreis wk on w.wahlkreis = wk.id 
	join candidate c on w.winnercandidate = c.id
	join wahlbet wb on wb.wahlkreis = w.wahlkreis
	where w.year = 2009 and (
	wk.name = 'Schweinfurt' or wk.name = 'Ingolstadt'
	or wk.name = 'Traunstein' or wk.name = 'Muenchen-Ost'
	or wk.name = 'Augsburg-Stadt')
	order by wk.name
);