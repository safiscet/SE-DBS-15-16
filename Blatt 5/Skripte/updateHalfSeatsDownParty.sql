CREATE OR REPLACE FUNCTION updateHalfSeatsDownParty() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    FOR r IN SELECT federalland FROM changeDivisorParty2013
    LOOP
	update changeDivisorParty2013 c set
        changebyhalfseat = (select f.seats -0.5 from firstSeatsParty2013 f 
        where f.federalland = r and f.party = c.party),
	changebyoneandhalfseat = (select f.seats -1.5 from firstSeatsParty2013 f 
	where f.federalland = r and f.party = c.party)
	where c.federalland = r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;