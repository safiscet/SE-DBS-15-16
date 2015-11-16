CREATE OR REPLACE FUNCTION updateFinalSeatsParty(federallandID INT) RETURNS void AS $$
DECLARE
    s integer;
BEGIN
	FOR s IN SELECT DISTINCT party FROM changeDivisorParty2013
	LOOP
		update changeDivisorParty2013 set
			seats = ((select zweitstimmen 
			from changeDivisorParty2013 
			where federalland = federallandID and party = s)/
			(select resultingdivisor 
			from changedivisorParty2013 
			where federalland = federallandID and party = s))
		where federalland = federallandID and party = s;
	END LOOP;
END;
$$ LANGUAGE plpgsql;