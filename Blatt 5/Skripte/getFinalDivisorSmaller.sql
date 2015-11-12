CREATE OR REPLACE FUNCTION getFinalDivisorSmaller(secondsmallest NUMERIC, smallest NUMERIC) RETURNS void AS $$
BEGIN
    IF secondsmallest-smallest >= 1000 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/500)*500;
    ELSIF secondsmallest-smallest >= 500 and secondsmallest-smallest < 1000 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/250)*250;
    ELSIF secondsmallest-smallest >= 250 and secondsmallest-smallest < 500 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/125)*125;
    ELSIF secondsmallest-smallest >= 100 and secondsmallest-smallest < 200 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/50)*50;
    ELSIF secondsmallest-smallest >= 50 and secondsmallest-smallest < 100 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/25)*25;
    ELSIF secondsmallest-smallest >= 20 and secondsmallest-smallest < 50 THEN
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest/10)*10;
    ELSE 
	update changeDivisorFederalLand2013 set
        resultingdivisor = floor(secondsmallest);
    END IF;
END;
$$ LANGUAGE plpgsql;