CREATE OR REPLACE FUNCTION setWinnerParty() RETURNS void AS $$
DECLARE
    r integer;
    s integer;
BEGIN
    FOR r IN SELECT DISTINCT wahlkreis FROM partyinwahlkreis
    LOOP
	update wahlkreisinelection set winnerparty = (
			select p1.party from partyinwahlkreis p1
			where p1.wahlkreis = r and year = 2013
			and not exists (select p2.party from partyinwahlkreis p2
				where p1.wahlkreis = p2.wahlkreis
				and p1.zweitstimmen < p2.zweitstimmen
				and p2.year = 2013)
	)
	where year = 2013 and wahlkreis = r;
    END LOOP;
    FOR s IN SELECT DISTINCT wahlkreis FROM partyinwahlkreis
    LOOP
	update wahlkreisinelection set winnerparty = (
			select p1.party from partyinwahlkreis p1
			where p1.wahlkreis = s and year = 2009
			and not exists (select p2.party from partyinwahlkreis p2
				where p1.wahlkreis = p2.wahlkreis
				and p1.zweitstimmen < p2.zweitstimmen
				and p2.year = 2009)
	)
	where year = 2009 and wahlkreis = s;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
