CREATE OR REPLACE FUNCTION getFinalDivisorSmallerParty(secondsmallest NUMERIC, smallest NUMERIC, land INT) RETURNS void AS $$
DECLARE
    r integer;
BEGIN
 --FOR r IN SELECT federalland FROM firstseatsparty
   --LOOP
    IF secondsmallest-smallest >= 1000 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/500)*500 
        where federalland = land;
    ELSIF secondsmallest-smallest >= 500 and secondsmallest-smallest < 1000 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/250)*250
        where federalland = land;
    ELSIF secondsmallest-smallest >= 250 and secondsmallest-smallest < 500 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/125)*125
        where federalland = land;
    ELSIF secondsmallest-smallest >= 100 and secondsmallest-smallest < 200 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/50)*50
        where federalland = land;
    ELSIF secondsmallest-smallest >= 50 and secondsmallest-smallest < 100 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/25)*25
        where federalland = land;
    ELSIF secondsmallest-smallest >= 20 and secondsmallest-smallest < 50 THEN
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest/10)*10
        where federalland = land;
    ELSE 
	update changeDivisorParty set
        resultingdivisor = floor(secondsmallest)
        where federalland = land;
    END IF;
 -- END LOOP;
END;
$$ LANGUAGE plpgsql;