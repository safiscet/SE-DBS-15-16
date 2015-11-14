WITH partyWinCount AS (
	SELECT p.party, p.year, COUNT(w.winnerparty)
	FROM partyinelection p, wahlkreisinelection w
	WHERE p.party = w.winnerparty
	AND w.year = p.year
	GROUP BY p.party, p.year
),

partyFive AS (
	SELECT p.party, p.year, (p.zweitstimmen::decimal / s.validzweitstimmen::decimal)::decimal(5,4) AS ratio
	FROM partyinelection p, statistics s
	WHERE p.year = s.year
	
),

partyComp AS (
	SELECT f.party, f.year, (f.ratio > 0.0500 OR COALESCE(p.count,0) >= 3) AS fivePercent, COALESCE(p.count,0) AS won
	FROM partyFive f LEFT OUTER JOIN partyWinCount p
	ON p.year = f.year
	AND p.party = f.party
)

UPDATE partyinelection p
SET fivepercenttaken = c.fivepercent,
wondistricts = c.won
FROM partyComp c
WHERE p.party = c.party
AND p.year = c.year