CREATE INDEX ON candidateinelection (party);
CREATE INDEX ON candidateinelection (wahlkreis);
CREATE INDEX ON candidateinelection (federalland);

CREATE INDEX ON vote (year);
CREATE INDEX ON vote (wahlkreis);

CREATE INDEX ON wahlkreisinelection (wahlkreis);
CREATE INDEX ON wahlkreisinelection (winnerparty);
CREATE INDEX ON wahlkreisinelection (winnercandidate);

CREATE INDEX ON partyinelection (party);

CREATE INDEX ON partyinwahlkreis (wahlkreis);
CREATE INDEX ON partyinwahlkreis (party);

-- Sinnvoll? CREATE INDEX ON vote (erststimme);
-- Sinnvoll? CREATE INDEX ON vote (zweitstimme);
