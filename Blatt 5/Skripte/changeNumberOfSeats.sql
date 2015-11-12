CREATE OR REPLACE FUNCTION changeNumberOfSeats() RETURNS void AS $$
DECLARE
    r integer;
BEGIN
    /* if number of calculated seats is to low, the divisor has to be set down */
    IF (select sum(seats) from firstSeatsFederalLand) <598 THEN
	perform updatehalfseatsUp();
	update changeDivisorFederalLand2013 set
	divisorCandidate1 = cast(residents2013/changeByHalfSeat as decimal(12, 6)),
	divisorCandidate2 = cast(residents2013/changeByOneAndHalfSeat as decimal(12, 6));
	/* the final divisor is picked between the second-biggest and the biggest divisor candidate*/
	perform getFinalDivisorBigger (
	/*second-biggest divisor candidate*/
	/*nochmal anpassen*/
	(select max(div) from (select greatest(divisorcandidate1, divisorcandidate2) as div
	from changedivisorfederalland2013) as tmp, changedivisorfederalland2013 
	where exists (select divisorcandidate1, divisorcandidate2 from changedivisorfederalland2013 where div < divisorcandidate1 or div < divisorcandidate2)),
	/*biggest divisor candidate*/
	(select max(greatest) from (select greatest(divisorcandidate1, divisorcandidate2) from changedivisorfederalland2013) as tmp));
	/*update the final number of seats*/
	perform updateFinalSeats();

    /* if number of calculated seats is to big, the divisor has to be set up */
    ELSIF (select sum(seats) from firstSeatsFederalLand) > 598 THEN
	perform updatehalfseatsDown();
	update changeDivisorFederalLand2013 set
	divisorCandidate1 = cast(residents2013/changeByHalfSeat as decimal(12, 6)),
	divisorCandidate2 = cast(residents2013/changeByOneAndHalfSeat as decimal(12, 6));
	/* the final divisor is picked between the second-smallest and the smallest divisor candidate*/
	perform getFinalDivisorSmaller(
	/*second-smallest divisor candidate*/
	(select min(div) from (select least(divisorcandidate1, divisorcandidate2) as div
	from changedivisorfederalland2013) as tmp, changedivisorfederalland2013 
	where exists (select divisorcandidate1, divisorcandidate2 from changedivisorfederalland2013 where div > divisorcandidate1 or div > divisorcandidate2)),
	/*smallest divisor candidate*/
	(select min(least) from (select least(divisorcandidate1, divisorcandidate2) from changedivisorfederalland2013) as tmp));
	/*update the final number of seats*/
	perform updateFinalSeats();

    /* if number of calculated seats is exactly 598, the number of seats is updated in changeDivisorFederalLand2013 */
    ELSE 
        FOR r IN SELECT id FROM changeDivisorFederalLand2013
        LOOP
		update changeDivisorFederalLand2013 set
		seats = (select seats from firstSeatsFederalLand f where f.id = r)
		where id = r;
        END LOOP;
    END IF;
END;
$$ LANGUAGE plpgsql;