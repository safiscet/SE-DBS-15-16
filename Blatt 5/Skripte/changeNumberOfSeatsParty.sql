CREATE OR REPLACE FUNCTION changeNumberOfSeatsParty() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
    t integer;
    u integer;
BEGIN
    FOR r IN SELECT DISTINCT federalland FROM changedivisorParty
        LOOP
    /* if number of calculated seats is to low, the divisor has to be set down */
    IF (select sum(seats) from firstSeatsParty where federalland = r) < 
		(select seats from changedivisorfederalland where id = r) THEN
	perform updatehalfseatsUpParty(r);
	FOR t IN SELECT DISTINCT party FROM changedivisorparty
        LOOP
        update changeDivisorParty set
		divisorCandidate1 = cast((select zweitstimmen from changeDivisorParty 
		where federalland = r and party = t)
		/(select changeByHalfSeat from changeDivisorParty
		where federalland = r and party = t) as decimal(20, 6)),
		divisorCandidate2 = cast((select zweitstimmen from changeDivisorParty 
		where federalland = r and party = t)
		/(select changeByOneAndHalfSeat from changeDivisorParty
		where federalland = r and party = t) as decimal(20, 6))
	where federalland = r and party = t;
	END LOOP;
	/* the final divisor is picked between the second-biggest and the biggest divisor candidate*/
	perform getFinalDivisorBiggerParty (
	/*second-biggest divisor candidate*/
	/*nochmal anpassen*/
	(select max(div) from (select greatest(divisorcandidate1, divisorcandidate2) as div
	from changedivisorparty where federalland = r) as tmp, changedivisorparty 
	where exists (select divisorcandidate1, divisorcandidate2 from changedivisorparty
		where (div < divisorcandidate1 or div < divisorcandidate2)
		and federalland = r)),
	/*biggest divisor candidate*/
	(select max(greatest) from (select greatest(divisorcandidate1, divisorcandidate2) 
	from changedivisorparty where federalland = r) as tmp), r);
	/*update the final number of seats*/
	perform updateFinalSeatsParty(r);

    /* if number of calculated seats is to big, the divisor has to be set up */
    ELSIF (select sum(seats) from firstSeatsParty where federalland = r) > 
		(select seats from changedivisorfederalland where id = r) THEN
	perform updatehalfseatsDownParty(r);
	FOR u IN SELECT DISTINCT party FROM changedivisorparty
        LOOP
        update changeDivisorParty set
		divisorCandidate1 = cast((select zweitstimmen from changeDivisorParty 
		where federalland = r and party = u)
		/(select changeByHalfSeat from changeDivisorParty
		where federalland = r and party = u) as decimal(20, 6)),
		divisorCandidate2 = cast((select zweitstimmen from changeDivisorParty 
		where federalland = r and party = u)
		/(select changeByOneAndHalfSeat from changeDivisorParty
		where federalland = r and party = u) as decimal(20, 6))
	where federalland = r and party = u;
	END LOOP;
	/* the final divisor is picked between the second-smallest and the smallest divisor candidate*/
	perform getFinalDivisorSmallerParty(
	/*second-smallest divisor candidate*/
	(select min(div) from (select least(divisorcandidate1, divisorcandidate2) as div
	from changeDivisorParty
	where federalland = r) as tmp, changeDivisorParty 
	where exists (select divisorcandidate1, divisorcandidate2 
	from changeDivisorParty 
	where (div > divisorcandidate1 or div > divisorcandidate2)
	and federalland = r)),
	/*smallest divisor candidate*/
	(select min(least) from (select least(divisorcandidate1, divisorcandidate2) 
	from changeDivisorParty
	where federalland = r) as tmp), r);
	/*update the final number of seats*/
	perform updateFinalSeatsParty(r);

    /* if number of calculated seats is exactly 598, the number of seats is updated in changeDivisorParty */
    ELSIF (select sum(seats) from firstSeatsParty where federalland = r) = 
		(select seats from changedivisorfederalland where id = r) THEN
        FOR s IN SELECT DISTINCT party FROM changeDivisorParty
        LOOP
		update changeDivisorParty set
		seats = (select seats from firstSeatsParty f 
		where f.federalland = r and f.party = s)
		where party = s and federalland = r;
        END LOOP;        
    END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;