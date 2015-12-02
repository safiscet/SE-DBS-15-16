CREATE OR REPLACE FUNCTION changeNumberOfSeatsPartyFinal() RETURNS void AS $$
DECLARE
    r integer;
    i integer;
    t1 numeric(5,1);
    t2 numeric(5,1);
BEGIN
FOR r IN SELECT DISTINCT party FROM changeDivisorPartyFinal
LOOP
  -- while the number of calculated seats is not exactly the amount of the previous phase, the number of seats is iteratively updated 
  WHILE (select sum(prevseats) from changeDivisorPartyFinal where party = r) <> 
		(select seats from changedivisorraiseparty where party = r)
  --FOR i IN 1..50
  LOOP
  
    -- if the number of calculated seats is too low, the divisor has to be set down
    IF (select sum(prevseats) from changeDivisorPartyFinal where party = r) < 
		(select seats from changedivisorraiseparty where party = r) THEN
	-- update changebyhalfseat and changebyoneandhalfseat
	update changeDivisorPartyFinal
	set changebyhalfseat = (CASE WHEN (prevseats + 0.5 > 0 AND prevseats + 0.5 > kreisseats) THEN prevseats + 0.5 
				ELSE null 
				END),
	changebyoneandhalfseat = (CASE WHEN (prevseats + 1.5 > 0 AND prevseats + 1.5 > kreisseats) THEN prevseats + 1.5 
				ELSE null 
				END)
	where party = r;
	-- get divisorcandidate 1 and 2 for every row
	update changeDivisorPartyFinal
	set divisorcandidate1 = cast(zweitstimmen as decimal(20, 6))/ changebyhalfseat,
	divisorcandidate2 = cast(zweitstimmen as decimal(20, 6))/ changebyoneandhalfseat
	where party = r;
	-- get resulting divisor with second-biggest candidate < resulting divisor <= biggest candidate
	-- all divisors
	create temporary table alldivs as (
		(select divisorcandidate1 as div from changeDivisorPartyFinal where party = r) 
		union 
		(select divisorcandidate2 as div from changeDivisorPartyFinal where party = r)
	);	
	perform getFinalDivisorBiggerPartyFinal(
	-- second-biggest divisor candidate
	(select max(a.div) from alldivs a where a.div < (select max(b.div) from alldivs b)),
	-- biggest divisor candidate
	(select max(div) from alldivs),
	r);
	drop table alldivs;
	-- update ratioseats
	update changeDivisorPartyFinal
	set ratioseats = cast(zweitstimmen as decimal(20,6)) / resultingdivisor
	where party = r;
	-- copy the maximum of ratioseats and kreisseats to prevseats for the next iteration
	update changeDivisorPartyFinal
	set prevseats = greatest(ratioseats, kreisseats)
	where party = r;

    -- if the number of calculated seats is too big, the divisor has to be set up
    ELSIF (select sum(prevseats) from changeDivisorPartyFinal where party = r) > 
		(select seats from changedivisorraiseparty where party = r) THEN
	-- update changebyhalfseat and changebyoneandhalfseat
	update changeDivisorPartyFinal
	set changebyhalfseat = (CASE WHEN (prevseats - 0.5 > 0 AND prevseats - 0.5 > kreisseats) THEN prevseats - 0.5 
				ELSE null 
				END),
	changebyoneandhalfseat = (CASE WHEN (prevseats - 1.5 > 0 AND prevseats - 1.5 > kreisseats) THEN prevseats - 1.5 
				ELSE null 
				END)
	where party = r;
	-- get divisorcandidate 1 and 2 for every row
	update changeDivisorPartyFinal
	set divisorcandidate1 = cast(zweitstimmen as decimal(20, 6))/ changebyhalfseat,
	divisorcandidate2 = cast(zweitstimmen as decimal(20, 6))/ changebyoneandhalfseat
	where party = r;
	-- get resulting divisor with smallest candidate < resulting divisor <= second-smallest candidate
	-- all divisors
	create temporary table alldivs on commit drop as (
		(select divisorcandidate1 as div from changeDivisorPartyFinal where party = r) 
		union 
		(select divisorcandidate2 as div from changeDivisorPartyFinal where party = r)
	);
	perform getFinalDivisorSmallerPartyFinal(
	-- second-smallest divisor candidate
	(select min(a.div) from alldivs a where a.div > (select min(b.div) from alldivs b)),
	-- smallest divisor candidate
	(select min(div) from alldivs),
	r);
	drop table alldivs;
	-- update ratioseats
	update changeDivisorPartyFinal
	set ratioseats = cast(zweitstimmen as decimal(20,6)) / resultingdivisor
	where party = r;
	-- copy the maximum of ratioseats and kreisseats to prevseats for the next iteration
	update changeDivisorPartyFinal
	set prevseats = greatest(ratioseats, kreisseats)
	where party = r;
      END IF;
    END LOOP;
    
    -- copy the final number of seats to the seats column
    update changeDivisorPartyFinal
    set seats = prevseats
    where party = r;  
END LOOP;
END;
$$ LANGUAGE plpgsql;