CREATE OR REPLACE FUNCTION getFinalDivisorRaiseParty(secondBiggest NUMERIC, biggest NUMERIC) RETURNS void AS $$
BEGIN
    IF biggest-secondbiggest >= 1000 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/500)*500;
    ELSIF biggest-secondbiggest >= 500 and biggest-secondbiggest < 1000 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/250)*250;
    ELSIF biggest-secondbiggest >= 250 and biggest-secondbiggest < 500 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/125)*125;
    ELSIF biggest-secondbiggest >= 100 and biggest-secondbiggest < 200 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/50)*50;
    ELSIF biggest-secondbiggest >= 50 and biggest-secondbiggest < 100 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/25)*25;
    ELSIF biggest-secondbiggest >= 20 and biggest-secondbiggest < 50 THEN
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest/10)*10;
    ELSE 
	update changeDivisorRaiseParty2013 set
        resultingdivisor = floor(biggest);
    END IF;
END;
$$ LANGUAGE plpgsql;