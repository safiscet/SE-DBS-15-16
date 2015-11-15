CREATE OR REPLACE FUNCTION updateFinalSeatsParty() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
BEGIN
    FOR r IN SELECT federalland FROM changeDivisorParty2013
    LOOP
	FOR s IN SELECT party FROM changeDivisorParty2013
	LOOP
		update changeDivisorParty2013 set
		seats = ((select sum(zweitstimmen) from changeDivisorParty2013 
		where federalland = r)/(select resultingdivisor 
		from changedivisorParty2013 where federalland = r and party = s))
		where federalland = r and party = s;
	END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgsql;