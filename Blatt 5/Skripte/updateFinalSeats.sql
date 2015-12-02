CREATE OR REPLACE FUNCTION updateFinalSeats() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    FOR r IN SELECT id FROM changeDivisorFederalLand
    LOOP
	update changeDivisorFederalLand set
	seats = (select residents/resultingdivisor from changedivisorfederalland where id = r)
	where id = r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;