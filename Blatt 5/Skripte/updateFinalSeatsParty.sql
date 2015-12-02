CREATE OR REPLACE FUNCTION updateFinalSeatsParty(federallandID INT) RETURNS void AS $$
DECLARE
    s integer;
BEGIN
	FOR s IN SELECT DISTINCT party FROM changeDivisorParty
	LOOP
		update changeDivisorParty set
			seats = ((select zweitstimmen 
			from changeDivisorParty 
			where federalland = federallandID and party = s)/
			(select resultingdivisor 
			from changedivisorParty 
			where federalland = federallandID and party = s))
		where federalland = federallandID and party = s;
	END LOOP;
END;
$$ LANGUAGE plpgsql;