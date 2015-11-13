-- Berechne und update Erststimmen pro Kandidat 2009
UPDATE candidateinelection c
SET erststimmen = sub.summe
FROM (
SELECT c2.candidate, COUNT(v.id) AS summe
FROM candidateinelection c2 JOIN vote v on c2.candidate = v.erststimme
WHERE c2.year = 2009
AND v.year = 2009
GROUP BY c2.candidate, c2.wahlkreis
) sub
WHERE c.candidate = sub.candidate
AND c.year = 2009;

-- Berechne und update Erststimmen pro Kandidat 2013
UPDATE candidateinelection c
SET erststimmen = sub.summe
FROM (
SELECT c2.candidate, COUNT(v.id) AS summe
FROM candidateinelection c2 JOIN vote v on c2.candidate = v.erststimme
WHERE c2.year = 2013
AND v.year = 2013
GROUP BY c2.candidate, c2.wahlkreis
) sub
WHERE c.candidate = sub.candidate
AND c.year = 2013;

-- Ersetze NULL durch 0 in Erststimmen
UPDATE candidateinelection
SET erststimmen = 0
WHERE erststimmen IS NULL;