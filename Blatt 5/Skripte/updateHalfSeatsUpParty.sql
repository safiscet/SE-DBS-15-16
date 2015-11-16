CREATE OR REPLACE FUNCTION updateHalfSeatsUpParty(federallandID INT) RETURNS void AS $$
DECLARE
    s integer;
BEGIN
	FOR s IN SELECT DISTINCT party FROM changeDivisorParty2013
	LOOP
		update changeDivisorParty2013 set
			changebyhalfseat = (select f.seats +0.5 
			from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s),
			
			changebyoneandhalfseat = (select f.seats +1.5 
			from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s)
		where federalland = federallandID and party = s;
	END LOOP;
END;
$$ LANGUAGE plpgsql;