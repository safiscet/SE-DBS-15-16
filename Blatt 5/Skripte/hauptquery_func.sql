CREATE OR REPLACE FUNCTION calculateResult(elecYear int) 
	RETURNS TABLE(party int, federalland int, kreisseats int, ratioseats int, seats int, ueberhangmandate int)
	AS $$
DECLARE
BEGIN
-- create temp tables
create temp table if not exists firstSeatsFederalLand (id int primary key, residents int, seats int);
create temp table if not exists changeDivisorFederalLand (id int primary key, residents int, 
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(12, 6), 
changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(12, 6), 
resultingDivisor decimal(12, 6), seats int);
create temp table if not exists firstSeatsParty (federalland int, party int, beginDivisor decimal(12,6), seats int, 
primary key(federalland, party));
create temp table if not exists changeDivisorParty (federalland int, party int, zweitstimmen int, 
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(20, 6), 
changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(20, 6), 
resultingDivisor decimal(20, 6), seats int, maxFromSeatsAndWahlkreis int, primary key(federalland, party));
create temp table if not exists changeDivisorRaiseParty (party int primary key, zweitstimmen int, 
minSeats int,
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(20, 6), 
changeResultingByHalfSeat decimal(5,1), divisorCandidate2 decimal(20, 6), 
resultingDivisor decimal(20, 6), seats int, ausgleichsmandate int);
create temp table if not exists firstSeatsPartyFinal (federalland smallint,party smallint,
	zweitstimmen int, begindivisor decimal(20, 6), ratioSeats int, kreisSeats int, seats int, primary key (federalland, party));
create temp table if not exists changeDivisorPartyFinal (party int, federalland int, zweitstimmen int, minSeats int, maxFromSeatsAndWahlkreis int, kreisseats int,prevseats int,
	changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(20, 6), changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(20, 6), 
	resultingDivisor decimal(20, 6), ratioseats int, seats int, primary key(federalland, party));

delete from firstSeatsFederalLand;
delete from changedivisorfederalland;
delete from firstSeatsParty;
delete from changedivisorparty;
delete from changedivisorraiseparty;
delete from firstSeatsPartyFinal;
delete from changeDivisorPartyFinal;

--begin divisor: total residents divided by 598
with divisorBegin as (select sum(f.residents)/598.00 
from federallandsresidents f where f.year = elecYear)


--insert id, residents, first calculated seats 
insert into firstSeatsFederalLand (select f.id, f.residents, round(f.residents/(select * from divisorBegin)) as seats 
from federallandsresidents f where f.year = elecYear);
insert into changedivisorfederalland (id, residents) 
(select id, residents from firstSeatsFederalLand);


--change the number of seats per federalland according to the number of calculated seats
perform changeNumberOfSeats();

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
insert into firstseatsparty (federalland, party)(
	select pf.federalland, pf.party 
	from partyinfederalland pf, partyinelection pie
	where pf.year = elecYear
	and pf.party = pie.party and pie.year = elecYear 
	and pie.fivePercentTaken = true and pf.zweitstimmen > 0);

-- update the beginDivisor by dividing the zweitstimmen for this 
-- federalland by the number of calculated seats for this federalland
update firstseatsparty fs set beginDivisor = p.sum / cdf.seats
     from  (
	(select pf.federalland, sum(pf.zweitstimmen) as sum
	from partyinfederalland pf, partyinelection pie
	where pf.year = elecYear
	and pie.party = pf.party and pie.year = elecYear 
	and pie.fivePercentTaken = true
	group by pf.federalland)
     ) p join 
	(select chd.id, chd.seats 
	from changedivisorfederalland chd) cdf
     on p.federalland = cdf.id
     where p.federalland = fs.federalland;

-- calculated with the beginDivisor the first number of seats for 
-- each party in a federalland
update firstseatsparty fs set seats = p.sum/fs.beginDivisor
     from (
	select pf.federalland, pie.party, sum(pf.zweitstimmen) as sum
	from partyinfederalland pf, partyinelection pie
	where pf.year = elecYear and pie.party = pf.party 
	and pie.year = elecYear and pie.fivePercentTaken = true
	group by pf.federalland, pie.party
     ) p
     where p.federalland = fs.federalland
     and p.party = fs.party ;

--update the number of wonDistricts and fivePercentTaken in the relation partyInElection
--select * from updateWonDistrictsAndFivePercent();

--insert federalland, party, zweitstimmen into changeDivisorParty
insert into changedivisorParty (federalland, party, zweitstimmen)
 (select pf.federalland, pf.party, pf.zweitstimmen 
 from partyinfederalland pf, partyinelection pie
 where pf.party = pie.party and pf.year = elecYear
 and pie.year = elecYear and pie.fivePercentTaken = true
 and pf.zweitstimmen > 0
 order by pf.federalland, pf.party);

--change the number of seats per party according to the number of calculated seats
perform changeNumberOfSeatsParty();

--insert the maximum of calculated seats and won wahlkreise for each party
update changeDivisorParty cdp set maxFromSeatsAndWahlkreis = g
     from (
	select c.federalland, c.party, greatest(c.seats,p.wondistricts) as g
	from changeDivisorParty c, partyInFederalland p
	where c.federalland = p.federalland 
	and c.party = p.party and p.year = elecYear
	group by c.federalland, c.party, p.wondistricts
     ) greatest
     where greatest.federalland = cdp.federalland
     and greatest.party = cdp.party;

--insert party, zweitstimmen into changedDivisorRaiseParty
insert into changedivisorraiseparty (party, zweitstimmen)
 (select pie.party, pie.zweitstimmen 
 from partyinelection pie
 where pie.year = elecYear and pie.fivePercentTaken = true
 and pie.zweitstimmen > 0
 order by party);

-- raise the number of seats for the parties
perform raiseNumberOfSeatsParty();

--insert party, federalland, zweitstimmen intro firstSeatsPartyFinal2013
insert into firstSeatsPartyFinal (federalland, party, zweitstimmen)
 (select pf.federalland, pf.party, pf.zweitstimmen 
 from partyinfederalland pf, partyinelection pie
 where pf.party = pie.party and pf.year = elecYear
 and pie.year = elecYear and pie.fivePercentTaken = true
 and pf.zweitstimmen > 0
 order by federalland, party);

-- initialize the final seat allocation per federal land of the parties (beginDivisor and maximum of ratio and wahlkreis seats)
perform initializeFinalSeatsPerParty(elecYear);

-- insert party, federalland, zweitstimmen, kreisseats into changeDivisorPartyFinal2013
insert into changeDivisorPartyFinal (party, federalland, zweitstimmen, minSeats, maxFromSeatsAndWahlkreis, kreisseats, prevseats)
(
	select f.party, f.federalland, f.zweitstimmen, ch.seats, ch.maxFromSeatsAndWahlkreis, f.kreisseats, f.seats
	from firstseatspartyfinal f, changeDivisorParty ch
	where f.party = ch.party
	and f.federalland = ch.federalland
	order by f.party, f.federalland
);

-- get the final number of seats per party
perform changeNumberOfSeatsPartyFinal();

return query 
	select ch.party, ch.federalland, ch.kreisseats, ch.ratioseats, ch.seats, 
	  (CASE WHEN ch.maxfromseatsandwahlkreis <> ch.minSeats THEN ch.maxfromseatsandwahlkreis - ch.minSeats ELSE null END) as ueberhangmandate
	from changeDivisorPartyFinal ch;

END;
$$ LANGUAGE plpgsql;