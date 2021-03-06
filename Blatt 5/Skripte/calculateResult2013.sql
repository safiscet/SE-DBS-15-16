﻿CREATE OR REPLACE FUNCTION calculateResult2013() RETURNS void AS $$
BEGIN

delete from firstSeatsFederalLand;
delete from changedivisorfederalland2013;
delete from firstSeatsParty2013;
delete from changedivisorparty2013;
delete from changedivisorraiseparty2013;
delete from firstSeatsPartyFinal2013;
delete from changeDivisorPartyFinal2013;

--begin divisor: total residents divided by 598
with divisorBegin as (select sum(residents)/598.00 
from federallandsresidents where year = 2013)


--insert id, residents, first calculated seats 
insert into firstSeatsFederalLand (select id, residents, round(residents/(select * from divisorBegin)) as seats 
from federallandsresidents where year = 2013);
insert into changedivisorfederalland2013 (id, residents2013) 
(select id, residents2013 from firstSeatsFederalLand);


--change the number of seats per federalland according to the number of calculated seats
select * from changeNumberOfSeats();

--set the winner party for each wahlkreis in the relation wahlkreisinelection
select * from setWinnerParty();

--distribute the seats per federalland to the parties according to their zweitstimmen
select * from findInitialNumberOfSeatsParty();

--update the number of wonDistricts and fivePercentTaken in the relation partyInElection
--select * from updateWonDistrictsAndFivePercent();

--insert federalland, party, zweitstimmen
insert into changedivisorParty2013 (federalland, party, zweitstimmen)
 (select pf.federalland, pf.party, pf.zweitstimmen 
 from partyinfederalland pf, partyinelection pie
 where pf.party = pie.party and pf.year = 2013
 and pie.year = 2013 and pie.fivePercentTaken = true
 and pf.zweitstimmen > 0
 order by federalland, party);

--change the number of seats per party according to the number of calculated seats
select * from changeNumberOfSeatsParty();

--insert the maximum of calculated seats and won wahlkreise for each party
select * from maxFromSeatsAndWahlkreis();

--insert party, zweitstimmen into changedDivisorRaiseParty2013
insert into changedivisorraiseparty2013 (party, zweitstimmen)
 (select pie.party, pie.zweitstimmen 
 from partyinelection pie
 where pie.year = 2013 and pie.fivePercentTaken = true
 and pie.zweitstimmen > 0
 order by party);

-- raise the number of seats for the parties
select * from raiseNumberOfSeatsParty();

--insert party, federalland, zweitstimmen intro firstSeatsPartyFinal2013
insert into firstSeatsPartyFinal2013 (federalland, party, zweitstimmen)
 (select pf.federalland, pf.party, pf.zweitstimmen 
 from partyinfederalland pf, partyinelection pie
 where pf.party = pie.party and pf.year = 2013
 and pie.year = 2013 and pie.fivePercentTaken = true
 and pf.zweitstimmen > 0
 order by federalland, party);

-- initialize the final seat allocation per federal land of the parties (beginDivisor and maximum of ratio and wahlkreis seats)
select * from initializeFinalSeatsPerParty();

-- insert party, federalland, zweitstimmen, kreisseats into changeDivisorPartyFinal2013
insert into changeDivisorPartyFinal2013 (party, federalland, zweitstimmen, kreisseats, prevseats)
(
	select party, federalland, zweitstimmen, kreisseats, seats
	from firstseatspartyfinal2013
	order by party, federalland
);

-- get the final number of seats per party
select * from changeNumberOfSeatsPartyFinal();

END;
$$ LANGUAGE plpgsql;