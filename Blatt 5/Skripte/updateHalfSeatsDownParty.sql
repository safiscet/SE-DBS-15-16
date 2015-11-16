CREATE OR REPLACE FUNCTION updateHalfSeatsDownParty(federallandID INT) RETURNS void AS $$
DECLARE
    s integer;
BEGIN
	FOR s IN SELECT DISTINCT party FROM changeDivisorParty2013
	LOOP
		IF (select f.seats -0.5 from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s) >= 0 THEN
		update changeDivisorParty2013 set
			changebyhalfseat = (select f.seats -0.5 
			from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s)
		where federalland = federallandID and party = s;
		END IF;

		IF (select f.seats -1.5 from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s) >= 0 THEN
		update changeDivisorParty2013 set
			changebyoneandhalfseat = (select f.seats -1.5 
			from firstSeatsParty2013 f
			where f.federalland = federallandID and f.party = s)
		where federalland = federallandID and party = s;
		END IF;
	END LOOP;
END;
$$ LANGUAGE plpgsql;