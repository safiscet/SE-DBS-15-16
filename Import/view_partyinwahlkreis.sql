DROP MATERIALIZED VIEW IF EXISTS partyinwahlkreis;

CREATE MATERIALIZED VIEW partyinwahlkreis AS (
	WITH canErst AS (
		SELECT c.candidate, c.erststimmen, c.wahlkreis, c.party, c.year
		FROM candidateinelection c
		WHERE wahlkreis IS NOT NULL
	),

	partyWahl AS (
		SELECT p.party, p.year, w.id AS wahlkreis
		FROM partyinelection p, wahlkreis w
	),

	partyErst AS (
	SELECT p.party, p.year, p.wahlkreis, COALESCE(SUM(c.erststimmen),0) AS erststimmen
	FROM partyWahl p LEFT OUTER JOIN canErst c
	ON p.party = c.party
	AND p.year = c.year
	AND p.wahlkreis = c.wahlkreis
	GROUP BY p.party, p.year, p.wahlkreis
	),

	partyZweit AS (
	SELECT p.party, p.year, v.wahlkreis, COUNT(v.id) AS zweitstimmen
			FROM partyinelection p, vote v
			WHERE p.party = v.zweitstimme
			AND p.year = v.year
			GROUP BY p.party, v.wahlkreis, p.year
	),

	result AS (
		SELECT erst.party, erst.year, erst.wahlkreis, erst.erststimmen, COALESCE(zweit.zweitstimmen,0) AS zweitstimmen
		FROM partyErst erst LEFT OUTER JOIN partyZweit zweit
		ON erst.party = zweit.party
		AND erst.year = zweit.year
		AND erst.wahlkreis = zweit.wahlkreis
		ORDER BY erst.party, erst.year, erst.wahlkreis
	)

	SELECT r.party, r.year, r.wahlkreis, r.erststimmen, r.zweitstimmen, (r.party = c.party) AS won
	FROM result r, wahlkreisinelection w, candidateinelection c
	WHERE r.wahlkreis = w.wahlkreis
	AND w.year = c.year
	AND w.winnercandidate = c.candidate
	AND r.year = w.year
);