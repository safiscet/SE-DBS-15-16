CREATE OR REPLACE FUNCTION initializeFinalSeatsPerParty() RETURNS void AS $$
    
DECLARE
    r integer;
    s integer;
    t integer;
    u integer;
BEGIN
	-- compute beginDivisor for every party
	update firstseatspartyfinal2013 f
	set begindivisor = cast(
		(select zweitstimmen from partyinelection p where year = 2013 and  p.party = f.party) 
			as decimal(20, 6))/ old.seats
	from (
	select ch.party, ch.seats
	from changeDivisorRaiseParty2013 ch
	) old
	where f.party = old.party;

	-- compute and set ratioSeats
	update firstseatspartyfinal2013
	set ratioseats = round(zweitstimmen / begindivisor);

	-- compute and set kreisSeats
	update firstseatspartyfinal2013 f
	set kreisseats = t.wonDistricts
	from (
		select party, federalland, wonDistricts from partyinfederalland where year = 2013
	) t
	where t.party = f.party
	and t.federalland = f.federalland;

	-- set kreisSeats to 0 if null
	update firstseatspartyfinal2013
	set kreisseats = 0
	where kreisseats is null;

	-- set seats to the maximum of ratioSeats and kreisSeats 
	update firstseatspartyfinal2013
	set seats = greatest(ratioseats, kreisseats);
	
END;
$$ LANGUAGE plpgsql;