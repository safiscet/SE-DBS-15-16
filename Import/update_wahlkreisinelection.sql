WITH maxErst AS (
	SELECT w.wahlkreis, w.year, MAX(c.erststimmen) AS anzahl
	FROM wahlkreisinelection w, candidateinelection c
	WHERE w.wahlkreis = c.wahlkreis
	AND w.year = c.year
	GROUP BY w.wahlkreis, w.year
),

wahlkreisWinner AS (
SELECT m.wahlkreis, m.year, c.candidate, c.party
FROM maxErst m, candidateinelection c
WHERE m.wahlkreis = c.wahlkreis
AND c.erststimmen = m.anzahl
AND m.year = c.year
)

UPDATE wahlkreisinelection w
SET winnercandidate = win.candidate
-- alt: winnerparty = win.party,
FROM wahlkreisWinner win
WHERE w.wahlkreis = win.wahlkreis
AND w.year = win.year