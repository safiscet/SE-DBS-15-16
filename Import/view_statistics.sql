DROP MATERIALIZED VIEW IF EXISTS statistics;

CREATE MATERIALIZED VIEW statistics AS (

	WITH jahre AS (
		SELECT * FROM (VALUES(2009), (2013)) AS j (year)
	),

	wahlberechtigt AS (
		SELECT SUM(residents2009) AS res2009, SUM(residents2013) AS res2013
		FROM federalland
	),

	fedYear AS (
		SELECT year, res2009 AS res
		FROM jahre, wahlberechtigt
		WHERE year = 2009
		UNION
		SELECT year, res2013 AS res
		FROM jahre, wahlberechtigt
		WHERE year = 2013
	),

	stat AS (
		SELECT v.year, COUNT(v.id) AS anzahlWaehler, COUNT(v.erststimme) AS validErststimmen, COUNT(v.zweitstimme) AS validZweitstimmen
		FROM vote v
		GROUP BY v.year
	)

	SELECT f.year, f.res AS anzahlWahlberechtigte, s.anzahlWaehler, s.validErststimmen, s.validZweitstimmen
	FROM fedYear f, stat s
	WHERE f.year = s.year
)