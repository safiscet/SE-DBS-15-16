DROP MATERIALIZED VIEW IF EXISTS partyingermany;

CREATE MATERIALIZED VIEW partyingermany AS (

	select party, year, sum(erststimmen) as erststimmen, sum(zweitstimmen)as zweitstimmen
	from partyinfederalland
	group by party, year
	order by party
);