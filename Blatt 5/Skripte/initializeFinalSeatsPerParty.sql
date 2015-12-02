CREATE OR REPLACE FUNCTION initializeFinalSeatsPerParty(elecYear int) RETURNS void AS $$
    
DECLARE
    r integer;
    s integer;
    t integer;
    u integer;
BEGIN
	-- compute beginDivisor for every party
	update firstseatspartyfinal f
	set begindivisor = cast(
		(select zweitstimmen from partyinelection p where p.year = elecYear and  p.party = f.party) 
			as decimal(20, 6))/ old.seats
	from (
	select ch.party, ch.seats
	from changeDivisorRaiseParty ch
	) old
	where f.party = old.party;

	-- compute and set ratioSeats
	update firstseatspartyfinal
	set ratioseats = round(zweitstimmen / begindivisor);

	-- compute and set kreisSeats
	update firstseatspartyfinal f
	set kreisseats = t.wonDistricts
	from (
		select p.party, p.federalland, p.wonDistricts from partyinfederalland p where p.year = elecYear
	) t
	where t.party = f.party
	and t.federalland = f.federalland;

	-- set kreisSeats to 0 if null
	update firstseatspartyfinal
	set kreisseats = 0
	where kreisseats is null;

	-- set seats to the maximum of ratioSeats and kreisSeats 
	update firstseatspartyfinal
	set seats = greatest(ratioseats, kreisseats);
	
END;
$$ LANGUAGE plpgsql;