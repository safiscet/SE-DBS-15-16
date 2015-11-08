/* SPD 33 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.spd as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 33
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* CDU 34 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.cdu as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 34
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* FDP 35 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.fdp as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 35
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* LINKE 36 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.linke as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 36
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* GRÜNE 37 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.gruene as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 37
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* CSU 38 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.csu as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 38
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* NPD 39 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.npd as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 39
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* REP 40 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.rep as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 40
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* FAMILIE 41 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.familie as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 41
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* TIERSCHUTZ 42 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.tier as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 42
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* PBC 43 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.pbc as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 43
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* MLPD 44 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.mlpd as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 44
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* BÜSO 45 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.bueso as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 45
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* BP 46 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.bp as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 46
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* PSG 47 */
/* keine Erststimmen */

/* VOLKSABSTIMMUNG 48 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.volks as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 48
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* ZENTRUM 49 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.zentrum as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 49
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* ADM 50 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.adm as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 50
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* CM 51 */
/* keine Erststimmen */

/* DKP 52 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.dkp as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 52
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* DVU 53 */
/* keine Erststimmen */

/* DIE VIOLETTEN 54 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.violett as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 54
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* FWD 55 */
/* keine Erststimmen */

/* ÖDP 56 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.oedp as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 56
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* PIRATEN 57 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.piraten as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 57
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* RRP 58 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.rrp as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 58
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* RENTNER 59 */
/* keine Erststimmen */

/* FREIE UNION 60 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.freie as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 60
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* PARTEILOSE 61 */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.parteilos as erststimmen
    FROM candidate c, ersttmp2 e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 61
    AND c.year = 2013) tmp
WHERE 
    candidate.id = tmp.id;

/* Null zu 0 bei vorhandenem Wahlkreis */
UPDATE candidate
SET erststimmen = 0
WHERE erststimmen IS NULL
AND wahlkreis IS NOT NULL;