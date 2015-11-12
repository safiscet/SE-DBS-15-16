﻿CREATE OR REPLACE FUNCTION updateHalfSeatsDown() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    FOR r IN SELECT id FROM changeDivisorFederalLand2013
    LOOP
	update changeDivisorFederalLand2013 set
        changebyhalfseat = (select f.seats -0.5 from firstSeatsFederalLand f where f.id = r),
	changebyoneandhalfseat = (select f.seats -1.5 from firstSeatsFederalLand f where f.id = r)
	where id = r;
    END LOOP;
END;
$$ LANGUAGE plpgsql;