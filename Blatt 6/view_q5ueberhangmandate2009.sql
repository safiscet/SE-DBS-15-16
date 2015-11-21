DROP VIEW IF EXISTS q5ueberhangmandate2009;

CREATE VIEW q5ueberhangmandate2009 AS (
	select party, federalland, 
		(CASE WHEN maxfromseatsandwahlkreis <> seats THEN maxfromseatsandwahlkreis - seats ELSE 0 END) as ueberhangmandate
	from changedivisorparty2009
	order by party, federalland
);