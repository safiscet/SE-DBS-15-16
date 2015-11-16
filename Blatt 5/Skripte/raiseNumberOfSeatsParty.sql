﻿CREATE OR REPLACE FUNCTION raiseNumberOfSeatsParty() RETURNS void AS $$
    
DECLARE
    r integer;
    s integer;
    t integer;
    u integer;
BEGIN
    -- update minSeats column
    UPDATE changeDivisorRaiseParty2013 ch
    set minSeats = old.minSeats
    FROM (
	select mind.party, COALESCE(SUM(mind.seats),0) AS minSeats
	from changedivisorParty2013 mind
	group by mind.party
    ) old
    WHERE ch.party = old.party;

    -- compute the first divisor for every party
       update changeDivisorRaiseParty2013 ch
       set changeByHalfSeat = minSeats - 0.5;

       update changeDivisorRaiseParty2013 ch
       set divisorCandidate1 = cast(zweitstimmen
		/(changeByHalfSeat) as decimal(20, 6));
   

    -- compute the second divisor for every party
	update changeDivisorRaiseParty2013 ch
	set changeResultingByHalfSeat = (round(cast((ch.zweitstimmen / t.minDiv) as decimal(20, 6)))) + 0.5
	FROM (
	   select min(ch1.divisorCandidate1) AS minDiv
	   from changeDivisorRaiseParty2013 ch1
	) t;

	update changeDivisorRaiseParty2013 ch
	set divisorCandidate2 = cast(zweitstimmen
		/(changeResultingByHalfSeat) as decimal(20, 6));

    -- compute the resulting divisor: max(divisorCandidate2) < resulting divisor <= min(divisorCandidate)
    perform getFinalDivisorRaiseParty((select max(divisorCandidate2) from changeDivisorRaiseParty2013), (select min(divisorCandidate1) from changeDivisorRaiseParty2013));

    -- update the raised number of seats with the final divisor
	update changeDivisorRaiseParty2013
	set seats = round(zweitstimmen / resultingdivisor);

    -- compute the ausgleichsmandate
	update changeDivisorRaiseParty2013
	SEt ausgleichsmandate = seats - minSeats;
    
END;
$$ LANGUAGE plpgsql;