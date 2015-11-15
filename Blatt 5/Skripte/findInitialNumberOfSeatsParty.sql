CREATE OR REPLACE FUNCTION findInitialNumberOfSeatsParty() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
    t integer;
BEGIN    
    FOR r IN SELECT DISTINCT federalland FROM partyinfederalland
    LOOP
	--insert federalland and parties, which have taken the five percent barrier 
	--and have zweitstimmen in this federalland
	insert into firstseatsparty2013 (federalland, party)(
		select pf.federalland, pf.party from partyinfederalland pf, partyinelection pie
		where pf.federalland = r and pf.year = 2013
		and pf.party = pie.party and pie.year = 2013 
		and pie.fivePercentTaken = true and pf.zweitstimmen > 0
	);
    END LOOP;
    
    FOR s IN SELECT DISTINCT federalland FROM partyinfederalland
    LOOP
	-- update the beginDivisor by dividing the zweitstimmen for this 
	-- federalland by the number of calculated seats for this federalland
	update firstseatsparty2013 set beginDivisor =
		(select sum(pf.zweitstimmen) 
		from partyinfederalland pf, partyinelection pie
		where pf.federalland = s and pf.year = 2013
		and pie.party = pf.party and pie.year = 2013 
		and pie.fivePercentTaken = true)
		/(select seats from changedivisorfederalland2013 
		where id = s)
	where federalland = s;
    END LOOP;

    FOR t IN SELECT DISTINCT federalland FROM partyinfederalland
    LOOP
	-- calculated with the beginDivisor the first number of seats for 
	-- each party in a federalland
	update firstseatsparty2013 fs set
	seats = (select sum(pf.zweitstimmen) 
		from partyinfederalland pf, partyinelection pie
		where pf.federalland = t and pf.party = fs.party 
		and pf.year = 2013 and pie.party = pf.party 
		and pie.year = 2013 and pie.fivePercentTaken = true)
		/fs.beginDivisor
	where federalland = t;
    END LOOP;
END;
$$ LANGUAGE plpgsql;