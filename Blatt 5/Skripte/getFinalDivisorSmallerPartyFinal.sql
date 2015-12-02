CREATE OR REPLACE FUNCTION getFinalDivisorSmallerPartyFinal(secondsmallest NUMERIC, smallest NUMERIC, partyId INT) RETURNS void AS $$
BEGIN
    IF secondsmallest-smallest >= 1000 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/500)*500
        where party = partyId;
    ELSIF secondsmallest-smallest >= 500 and secondsmallest-smallest < 1000 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/250)*250
        where party = partyId;
    ELSIF secondsmallest-smallest >= 250 and secondsmallest-smallest < 500 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/125)*125
        where party = partyId;
    ELSIF secondsmallest-smallest >= 100 and secondsmallest-smallest < 200 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/50)*50
        where party = partyId;
    ELSIF secondsmallest-smallest >= 50 and secondsmallest-smallest < 100 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/25)*25
        where party = partyId;
    ELSIF secondsmallest-smallest >= 20 and secondsmallest-smallest < 50 THEN
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest/10)*10
        where party = partyId;
    ELSE 
	update changeDivisorPartyFinal set
        resultingdivisor = floor(secondsmallest)
        where party = partyId;
    END IF;
END;
$$ LANGUAGE plpgsql;