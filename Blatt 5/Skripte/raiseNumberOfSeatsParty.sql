CREATE OR REPLACE FUNCTION raiseNumberOfSeatsParty() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
    t integer;
    u integer;
BEGIN
    FOR r IN SELECT DISTINCT party FROM changeDivisorRaiseParty2013
    -- compute the first divisor for every party
        LOOP
       update changeDivisorRaiseParty2013 ch
       set changeByHalfSeat = (old.minSeats - 0.5)
       from (
	  select mind.party, COALESCE(SUM(mind.seats),0) AS minSeats
	  from changedivisorParty2013 mind
	  group by mind.party
       ) old
       where ch.party = old.party
       and r = ch.party;

       update changeDivisorRaiseParty2013 ch
       set divisorCandidate1 = cast(zweitstimmen
		/(changeByHalfSeat) as decimal(20, 6))
	where party = r;
   
    END LOOP;

    -- compute the second divisor for every party
    FOR r IN SELECT DISTINCT party FROM changeDivisorRaiseParty2013
	LOOP
	update changeDivisorRaiseParty2013 ch
	set changeResultingByHalfSeat = t.seats + 0.5
	FROM (
	   select ch1.party, round(cast((zweitstimmen / (select min(ch.divisorCandidate1) from changeDivisorRaiseParty2013 ch2)) as decimal(20, 6))) AS seats
	   from changeDivisorRaiseParty2013 ch1
	) t
	where r = t.party;

	update changeDivisorRaiseParty2013 ch
	set divisorCandidate2 = cast(zweitstimmen
		/(changeResultingByHalfSeat) as decimal(20, 6))
	where party = r;
    END LOOP;

    -- compute the resulting divisor: max(divisorCandidate2) < resulting divisor <= min(divisorCandidate)
    
END;
$$ LANGUAGE plpgsql;