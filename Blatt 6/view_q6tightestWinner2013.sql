-- view: q6tightestWinner2013

--DROP VIEW q6tightestWinner2013;

CREATE OR REPLACE VIEW q6tightestWinner2013 AS
-- differencePerWahlkreis shows the winner candidate for each wahlkreis
-- and his party plus the difference, with which he has won
with differencesPerWahlkreis as (
select pie.wahlkreis, 
(select p.abkuerzung from wahlkreisInElection wie
join candidateInElection cie on wie.winnercandidate = cie.candidate
join party p on p.id = cie.party
where wie.year = 2013
and cie.year = 2013
and wie.wahlkreis = pie.wahlkreis) as candidateParty,
(select c.name from wahlkreisInElection wie2
join candidate c on wie2.winnercandidate = c.id
where wie2.year = 2013 
and wie2.wahlkreis = pie.wahlkreis) as winnerCandidate, 
max(pie.erststimmen) as first,
(select max(p1.erststimmen) from partyinwahlkreis p1 
where p1.year = 2013 
and p1.wahlkreis = pie.wahlkreis
and exists (select erststimmen from partyinwahlkreis p2
where p1.erststimmen < p2.erststimmen and 
p1.wahlkreis = p2.wahlkreis and p2.year = 2013)) as second,
(select max(pie.erststimmen)- (select max(p1.erststimmen) from partyinwahlkreis p1 
where p1.year = 2013 
and p1.wahlkreis = pie.wahlkreis
and exists (select erststimmen from partyinwahlkreis p2
where p1.erststimmen < p2.erststimmen and 
p1.wahlkreis = p2.wahlkreis and p2.year = 2013))) as difference
from partyinwahlkreis pie
where pie.year = 2013
group by pie.wahlkreis),
-- rankedDifferencesPerParty ranks the candidates per party beginning
-- with the smallest difference
rankedDifferencesPerParty as(
select *, rank() over (partition by candidateParty order by difference) 
from differencesPerWahlkreis)

-- the top 10 tightest winners for each party are selected
select rank, candidateparty, winnercandidate
from rankedDifferencesPerParty
where rank <= 10
order by candidateparty, difference



