DROP VIEW IF EXISTS q5ueberhangmandate2009;

CREATE VIEW q5ueberhangmandate2009 AS (
	with mandate as (
	select p.abkuerzung as party, f.name as federalland, 
		(CASE WHEN ch.maxfromseatsandwahlkreis <> ch.seats THEN ch.maxfromseatsandwahlkreis - ch.seats ELSE null END) as ueberhangmandate
	from changedivisorparty2009 ch, party p, federalland f
	where p.id = ch.party 
	and f.id = ch.federalland
	)

	select * from mandate
	where ueberhangmandate is not null
	order by party, federalland
);