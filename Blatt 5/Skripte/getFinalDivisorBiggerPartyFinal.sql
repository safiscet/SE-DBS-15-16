CREATE OR REPLACE FUNCTION getFinalDivisorBiggerPartyFinal(secondBiggest NUMERIC, biggest NUMERIC, partyId INT) RETURNS void AS $$
BEGIN
    IF biggest-secondbiggest >= 1000 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/500)*500
        where party = partyId;
    ELSIF biggest-secondbiggest >= 500 and biggest-secondbiggest < 1000 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/250)*250
        where party = partyId;
    ELSIF biggest-secondbiggest >= 250 and biggest-secondbiggest < 500 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/125)*125
        where party = partyId;
    ELSIF biggest-secondbiggest >= 100 and biggest-secondbiggest < 200 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/50)*50
        where party = partyId;
    ELSIF biggest-secondbiggest >= 50 and biggest-secondbiggest < 100 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/25)*25
        where party = partyId;
    ELSIF biggest-secondbiggest >= 20 and biggest-secondbiggest < 50 THEN
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest/10)*10
        where party = partyId;
    ELSE 
	update changeDivisorPartyFinal2013 set
        resultingdivisor = floor(biggest)
        where party = partyId;
    END IF;
END;
$$ LANGUAGE plpgsql;