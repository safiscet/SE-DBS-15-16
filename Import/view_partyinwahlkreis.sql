-- Zweitstimmen fehlen noch
-- auch "leere" Wahlkreise mit reinnehmen?
DROP MATERIALIZED VIEW IF EXISTS partyinwahlkreis;

CREATE MATERIALIZED VIEW partyinwahlkreis AS (
	SELECT p.party, v.wahlkreis, p.year, COALESCE(COUNT(v.id),0) AS zweitstimmen
	FROM partyinelection p, vote v 
	WHERE p.party = v.zweitstimme
	AND p.year = v.year
	GROUP BY p.party, v.wahlkreis, p.year
	ORDER BY p.party, v.wahlkreis, p.year
);