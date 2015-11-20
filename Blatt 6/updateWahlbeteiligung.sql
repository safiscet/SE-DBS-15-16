CREATE OR REPLACE FUNCTION updateWahlbeteiligung() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    alter table wahlkreisInElection add wahlbeteiligung decimal(5,4);
	
	update wahlkreisInElection wks
	set wahlbeteiligung =  cast( wv.votes / cast(wks.residents as decimal(13,4)) as decimal(5,4))
	from (
		select w.wahlkreis, w.year, count(v.id) as votes
		from vote v join wahlkreisinelection w on v.wahlkreis = w.wahlkreis and v.year = w.year
		group by w.wahlkreis, w.year 
		) wv
	where wks.year = wv.year
	and wks.wahlkreis = wv.wahlkreis;

END;
$$ LANGUAGE plpgsql;



