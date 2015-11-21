DROP VIEW IF EXISTS q5ueberhangmandate2013;

CREATE VIEW q5ueberhangmandate2013 AS (
	select party, federalland, 
		(CASE WHEN maxfromseatsandwahlkreis <> seats THEN maxfromseatsandwahlkreis - seats ELSE 0 END) as ueberhangmandate
	from changedivisorparty2013
	order by party, federalland
);