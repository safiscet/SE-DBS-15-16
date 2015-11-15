CREATE OR REPLACE FUNCTION updateWonDistrictsAndFivePercent() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
BEGIN
    FOR r IN SELECT DISTINCT party FROM partyinelection
    LOOP
	--update number of won districts in partyInElection for year 2013
	update partyinelection set
        wonDistricts = (select count(winnerparty) 
		from wahlkreisinelection where winnerparty = r and year = 2013)
	where party = r and year = 2013;
	--update number of won districts in partyInElection for year 2009
	update partyinelection set
        wonDistricts = (select count(winnerparty) 
		from wahlkreisinelection where winnerparty = r and year = 2009)
	where party = r and year = 2009;
    END LOOP;

    FOR s IN SELECT DISTINCT party FROM partyinelection
    LOOP
	-- if the party has more zweitstimmen then 5 % of all zweitstimmen in the year 2013
	-- the attribut fivePercentTaken can be set true
	IF (select zweitstimmen from partyingermany where party = s and year = 2013)>
	(select sum(zweitstimmen)*0.05 from partyingermany where year = 2013) THEN
		update partyinelection set
		fivepercenttaken = true
		where party = s and year = 2013;
	-- otherwise the attribute can also be set true if the party has won 3 or more districts
	ELSIF (select count(winnerParty) from wahlkreisinelection where winnerparty = s and year = 2013)
		>= 3 THEN
		update partyinelection set
		fivepercenttaken = true
		where party = s and year = 2013;
	-- if the party has not reached 5% and has not won 3 districts fivePercentTaken is set to false
	ELSE 
		update partyinelection set
		fivepercenttaken = false
		where party = s and year = 2013;
	END IF;

	-- if the party has more zweitstimmen then 5 % of all zweitstimmen in the year 2009
	-- the attribut fivePercentTaken can be set true
	IF (select zweitstimmen from partyingermany where party = s and year = 2009)>
	(select sum(zweitstimmen)*0.05 from partyingermany where year = 2009) THEN
		update partyinelection set
		fivepercenttaken = true
		where party = s and year = 2009;
	-- otherwise the attribute can also be set true if the party has won 3 or more districts
	ELSIF (select count(winnerParty) from wahlkreisinelection where winnerparty = s and year = 2009)
		>= 3 THEN
		update partyinelection set
		fivepercenttaken = true
		where party = s and year = 2009;
	-- if the party has not reached 5% and has not won 3 districts fivePercentTaken is set to false
	ELSE 
		update partyinelection set
		fivepercenttaken = false
		where party = s and year = 2009;
	END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;