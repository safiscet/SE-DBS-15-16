CREATE OR REPLACE FUNCTION updateWahlbeteiligung() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    alter table wahlkreisInElection add wahlbeteiligung decimal(5,4);

    FOR r IN SELECT DISTINCT wahlkreis FROM wahlkreisinelection
    LOOP
	update wahlkreisInElection set wahlbeteiligung =
		(select cast(
			(select count(*) from vote v 
			join wahlkreis wks on v.wahlkreis = wks.id
			where v.wahlkreis = w.wahlkreis and v.year = 2013)/
			cast(w.residents as decimal(13,4)) 
			as decimal(5,4)) 
		from wahlkreisinelection w  
		where w.year = 2013 and w.wahlkreis = r)
	where year = 2013 and wahlkreis = r;

	update wahlkreisInElection set wahlbeteiligung =
		(select cast(
			(select count(*) from vote v 
			join wahlkreis wks on v.wahlkreis = wks.id
			where v.wahlkreis = w.wahlkreis and v.year = 2009)/
			cast(w.residents as decimal(13,4)) 
			as decimal(5,4)) 
		from wahlkreisinelection w  
		where w.year = 2009 and w.wahlkreis = r)
	where year = 2009 and wahlkreis = r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;



