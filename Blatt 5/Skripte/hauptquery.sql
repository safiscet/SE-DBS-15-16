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
--for the year 2013 and the year 2009
update wahlkreisinelection set winnerparty = p.party
    from (
	select p1.wahlkreis, p1.party from partyinwahlkreis p1
	where year = 2013
	and not exists (select p2.party from partyinwahlkreis p2
		where p1.wahlkreis = p2.wahlkreis
		and p1.zweitstimmen < p2.zweitstimmen
		and p2.year = 2013)
    ) p
    where wahlkreisinelection.year = 2013 
    and wahlkreisinelection.wahlkreis = p.wahlkreis;

update wahlkreisinelection set winnerparty = p.party
    from (
	select p1.wahlkreis, p1.party from partyinwahlkreis p1
	where year = 2009
	and not exists (select p2.party from partyinwahlkreis p2
		where p1.wahlkreis = p2.wahlkreis
		and p1.zweitstimmen < p2.zweitstimmen
		and p2.year = 2009)
    ) p
    where wahlkreisinelection.year = 2009
    and wahlkreisinelection.wahlkreis = p.wahlkreis;

--distribute the seats per federalland to the parties according to their zweitstimmen

--insert federalland and parties, which have taken the five percent barrier 
--and have zweitstimmen in this federalland
insert into firstseatsparty2013 (federalland, party)(
	select pf.federalland, pf.party 
	from partyinfederalland pf, partyinelection pie
	where pf.year = 2013
	and pf.party = pie.party and pie.year = 2013 
	and pie.fivePercentTaken = true and pf.zweitstimmen > 0);

-- update the beginDivisor by dividing the zweitstimmen for this 
-- federalland by the number of calculated seats for this federalland
update firstseatsparty2013 fs set beginDivisor = p.sum / cdf.seats
     from  (
	(select federalland, sum(pf.zweitstimmen) as sum
	from partyinfederalland pf, partyinelection pie
	where pf.year = 2013
	and pie.party = pf.party and pie.year = 2013 
	and pie.fivePercentTaken = true
	group by federalland)
     ) p join 
	(select id, seats 
	from changedivisorfederalland2013) cdf
     on p.federalland = cdf.id
     where p.federalland = fs.federalland;

-- calculated with the beginDivisor the first number of seats for 
-- each party in a federalland
update firstseatsparty2013 fs set seats = p.sum/fs.beginDivisor
     from (
	select pf.federalland, pie.party, sum(pf.zweitstimmen) as sum
	from partyinfederalland pf, partyinelection pie
	where pf.year = 2013 and pie.party = pf.party 
	and pie.year = 2013 and pie.fivePercentTaken = true
	group by pf.federalland, pie.party
     ) p
     where p.federalland = fs.federalland
     and p.party = fs.party ;

--update the number of wonDistricts and fivePercentTaken in the relation partyInElection
--select * from updateWonDistrictsAndFivePercent();

--insert federalland, party, zweitstimmen into changeDivisorParty2013
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
update changeDivisorParty2013 cdp set maxFromSeatsAndWahlkreis = g
     from (
	select c.federalland, c.party, greatest(c.seats,p.wondistricts) as g
	from changeDivisorParty2013 c, partyInFederalland p
	where c.federalland = p.federalland 
	and c.party = p.party and p.year = 2013
	group by c.federalland, c.party, p.wondistricts
     ) greatest
     where greatest.federalland = cdp.federalland
     and greatest.party = cdp.party;

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
