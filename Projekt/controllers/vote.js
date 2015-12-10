/*

SELECT w.id, w.name, p.abkuerzung, r.federalland
FROM runsforelection r, wahlkreis w, party p
WHERE w.id = 1
AND r.federalland = w.federalland
AND r.year = 2013
AND p.id = r.party
AND p.abkuerzung <> 'PARTEILOSE'


SELECT c.name, p.name, p.abkuerzung,
FROM candidateInElection cie join candidate c ON cie.candidate = c.id
JOIN party p ON cie.party = p.id
WHERE cie.year = 2013
AND cie.wahlkreis = 1

*/
