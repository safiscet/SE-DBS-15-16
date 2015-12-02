DROP VIEW IF EXISTS q5ueberhangmandate2013;

CREATE VIEW q5ueberhangmandate2013 AS (
	with mandate as (
	select p.abkuerzung as party, f.name as federalland, ch.ueberhangmandate
	from calculateResult(2013) ch, party p, federalland f
	where p.id = ch.party 
	and f.id = ch.federalland
	)

	select * from mandate
	where ueberhangmandate is not null
	order by party, federalland
);