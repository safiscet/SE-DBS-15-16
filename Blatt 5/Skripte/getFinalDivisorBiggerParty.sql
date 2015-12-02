CREATE OR REPLACE FUNCTION getFinalDivisorBiggerParty(secondBiggest NUMERIC, biggest NUMERIC, land INT) RETURNS void AS $$
DECLARE
    r integer;
BEGIN
 --FOR r IN SELECT federalland FROM firstseatsparty
   --LOOP
    IF biggest-secondbiggest >= 1000 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/500)*500
        where federalland = land;
    ELSIF biggest-secondbiggest >= 500 and biggest-secondbiggest < 1000 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/250)*250
        where federalland = land;
    ELSIF biggest-secondbiggest >= 250 and biggest-secondbiggest < 500 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/125)*125
        where federalland = land;
    ELSIF biggest-secondbiggest >= 100 and biggest-secondbiggest < 200 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/50)*50
        where federalland = land;
    ELSIF biggest-secondbiggest >= 50 and biggest-secondbiggest < 100 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/25)*25
        where federalland = land;
    ELSIF biggest-secondbiggest >= 20 and biggest-secondbiggest < 50 THEN
	update changeDivisorParty set
        resultingdivisor = floor(biggest/10)*10
        where federalland = land;
    ELSE 
	update changeDivisorParty set
        resultingdivisor = floor(biggest)
        where federalland = land;
    END IF;
 --END LOOP;
END;
$$ LANGUAGE plpgsql;