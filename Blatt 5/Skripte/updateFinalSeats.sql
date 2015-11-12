CREATE OR REPLACE FUNCTION updateFinalSeats() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    FOR r IN SELECT id FROM changeDivisorFederalLand2013
    LOOP
	update changeDivisorFederalLand2013 set
	seats = (select residents2013/resultingdivisor from changedivisorfederalland2013 where id = r)
	where id = r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;