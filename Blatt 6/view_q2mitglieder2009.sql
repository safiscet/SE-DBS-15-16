DROP VIEW IF EXISTS q2mitglieder2009;

CREATE VIEW q2mitglieder2009 AS (
-- all candidates that were the winner of a wahlkreis
with kreisWinner as (
select w.winnercandidate as candidate, c.party, c.federalland
from wahlkreisinelection w join candidateinelection c on w.winnercandidate = c.candidate
where w.year = 2009 and c.year = 2009
),


-- all candidates in the landeslisten without winners of a wahlkreis and a new ascending rank per party and federalland
noWinner as (
select c.candidate, c.party, c.federalland, rank() over (partition by c.party, c.federalland order by c.rank )
from candidateinelection c
where c.year = 2009 
and rank is not null
and c.candidate not in (
	select w.winnercandidate
	from wahlkreisinelection w
	where w.year = 2009
	)
)

-- get all winners of a wahlkreis and the remaining number of candidates from landeslisten per party
(select c.candidate, c.party, c.federalland
from changeDivisorPartyFinal2009 ch, noWinner c
where ch.party = c.party
and ch.federalland = c.federalland
and c.rank <= (ch.seats - ch.kreisseats)
group by c.party, c.federalland, c.candidate

union

select * from kreisWinner) order by party, federalland, candidate
);