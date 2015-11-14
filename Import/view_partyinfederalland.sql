DROP MATERIALIZED VIEW IF EXISTS partyinfederalland;

CREATE MATERIALIZED VIEW partyinfederalland AS (

	WITH wahlfed AS (
		SELECT w.id AS wahlkreis, f.id AS federalland
		FROM wahlkreis w, federalland f
		WHERE w.federalland = f.id
	)

	SELECT p.party, p.year, w.federalland, SUM(p.erststimmen) AS erststimmen, SUM(p.zweitstimmen) AS zweitstimmen
	FROM partyinwahlkreis p, wahlfed w
	WHERE p.wahlkreis = w.wahlkreis
	GROUP BY p.party, p.year, w.federalland
	ORDER BY p.party, p.year, w.federalland
);