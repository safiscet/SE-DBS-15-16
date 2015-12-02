CREATE INDEX ON candidateinelection (party);
CREATE INDEX ON candidateinelection (wahlkreis);
CREATE INDEX ON candidateinelection (federalland);

CREATE INDEX ON vote (year);
CREATE INDEX ON vote (wahlkreis);

CREATE INDEX ON wahlkreisinelection (winnerparty);
CREATE INDEX ON wahlkreisinelection (winnercandidate);

-- Sinnvoll? CREATE INDEX ON vote (erststimme);
-- Sinnvoll? CREATE INDEX ON vote (zweitstimme);
