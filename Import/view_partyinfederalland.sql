DROP MATERIALIZED VIEW IF EXISTS partyinfederalland;

CREATE MATERIALIZED VIEW partyinfederalland (party, year, federalland, erststimmen, zweitstimmen) AS (

	WITH wahlfed AS (
		SELECT w.id AS wahlkreis, f.id AS federalland
		FROM wahlkreis w, federalland f
		WHERE w.federalland = f.id
	),

	wonDistricts AS (
		SELECT p.party, w.federalland, p.year, COUNT(p.won) AS wonDistricts
		FROM partyinwahlkreis p, wahlfed w
		WHERE p.wahlkreis = w.wahlkreis
		AND p.won = TRUE
		GROUP BY p.party, w.federalland, p.year
	)

	SELECT p.party, p.year, w.federalland, CAST(SUM(p.erststimmen) AS bigint) AS erststimmen, 
		CAST(SUM(p.zweitstimmen) AS bigint) AS zweitstimmen, d.wonDistricts
	FROM partyinwahlkreis p, wahlfed w, wonDistricts d
	WHERE p.wahlkreis = w.wahlkreis
	AND p.party = d.party
	AND w.federalland = d.federalland
	AND p.year = d.year
	GROUP BY p.party, p.year, w.federalland, d.wonDistricts
	ORDER BY p.party, p.year, w.federalland
);