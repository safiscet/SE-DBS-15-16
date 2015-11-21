-- view: q6tightestWinner2009

--DROP VIEW q6tightestWinner2009;

CREATE OR REPLACE VIEW q6tightestWinner2009 AS
-- differencePerWahlkreis shows the winner candidate for each wahlkreis
-- and his party plus the difference, with which he has won
with differencesPerWahlkreis as (
select pie.wahlkreis, 
(select p.abkuerzung from wahlkreisInElection wie
join candidateInElection cie on wie.winnercandidate = cie.candidate
join party p on p.id = cie.party
where wie.year = 2009
and cie.year = 2009
and wie.wahlkreis = pie.wahlkreis) as candidateParty,
(select c.name from wahlkreisInElection wie2
join candidate c on wie2.winnercandidate = c.id
where wie2.year = 2009 
and wie2.wahlkreis = pie.wahlkreis) as candidatename, 
max(pie.erststimmen) as first,
(select max(p1.erststimmen) from partyinwahlkreis p1 
where p1.year = 2009 
and p1.wahlkreis = pie.wahlkreis
and exists (select erststimmen from partyinwahlkreis p2
where p1.erststimmen < p2.erststimmen and 
p1.wahlkreis = p2.wahlkreis and p2.year = 2009)) as second,
(select max(pie.erststimmen)- (select max(p1.erststimmen) from partyinwahlkreis p1 
where p1.year = 2009 
and p1.wahlkreis = pie.wahlkreis
and exists (select erststimmen from partyinwahlkreis p2
where p1.erststimmen < p2.erststimmen and 
p1.wahlkreis = p2.wahlkreis and p2.year = 2009))) as difference
from partyinwahlkreis pie
where pie.year = 2009
group by pie.wahlkreis),
-- rankedDifferencesPerParty ranks the candidates per party beginning
-- with the smallest difference
rankedDifferencesPerParty as(
select *, rank() over (partition by candidateParty order by difference) 
from differencesPerWahlkreis),
-- candidatesWithoutWins shows the candidate, which party has not won a wahlkreis
-- and his party plus his own erststimmen and the erststimmen from the winnercandidate
-- of the wahlkreis
candidatesWithoutWins as (select p.abkuerzung as candidateparty, 
c.name as candidatename, cie.erststimmen as ownErststimmen,
(select cie3.erststimmen from candidateInElection cie2 
join wahlkreisInElection wie on cie2.wahlkreis = wie.wahlkreis
join candidateInElection cie3 on wie.winnerCandidate = cie3.candidate
where cie2.year = 2009 
and wie.year = 2009
and cie3.year = 2009
and cie2.candidate = cie.candidate) as bestErststimmen
from partyinelection pie join party p on pie.party = p.id
join candidateInElection cie on cie.party = p.id
join candidate c on cie.candidate = c.id
where pie.year = 2009
and cie.year = 2009
group by p.abkuerzung, c.name, cie.erststimmen, cie.candidate
having sum(pie.wondistricts) = 0
order by p.abkuerzung),
--candidatesWithoutWinsWithDifference has additionally the difference as a column
candidatesWithoutWinsWithDifference as (
select cww.candidateparty, cww.candidatename, 
cww.ownerststimmen, cww.besterststimmen,
candidatesWithDifference.diff as difference
from candidatesWithoutWins cww join (select candidatename, 
bestErststimmen - ownErststimmen as diff
from candidatesWithoutWins) as candidatesWithDifference 
on candidatesWithDifference.candidatename = cww.candidatename
where cww.bestErststimmen is not null
order by cww.candidateparty, difference
),
--rankedDifferencesPerPartyWithoutWins ranks the candidates per party beginning
-- with the smallest difference
rankedDifferencesPerPartyWithoutWins as(
select *, rank() over (partition by candidateparty order by difference) 
from candidatesWithoutWinsWithDifference)


-- the top 10 tightest winners for each party are selected
(select rank, candidateparty, candidatename, difference, true as winner
from rankedDifferencesPerParty
where rank <= 10)
union
-- the top 10 tightest looser for each party are selected
(select rank, candidateparty, candidatename, difference, false as winner
from rankedDifferencesPerPartyWithoutWins
where rank <= 10)
order by candidateparty, rank
