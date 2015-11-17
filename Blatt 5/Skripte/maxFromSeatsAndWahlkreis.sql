CREATE OR REPLACE FUNCTION maxFromSeatsAndWahlkreis() RETURNS void AS $$
DECLARE
    s integer;
    t integer;
BEGIN
	FOR s IN SELECT DISTINCT federalland FROM changeDivisorParty2013
	LOOP
	    FOR t IN SELECT DISTINCT party FROM changeDivisorParty2013
	    LOOP
		update changeDivisorParty2013 set
			maxFromSeatsAndWahlkreis = (
			select greatest(c.seats,p.wondistricts)
			from changeDivisorParty2013 c, partyInFederalland p
			where c.federalland = p.federalland and c.federalland = s
			and c.party = p.party and c.party = t
			and p.year = 2013)	
		where federalland = s and party = t;
	    END LOOP;
	END LOOP;
END;
$$ LANGUAGE plpgsql;
