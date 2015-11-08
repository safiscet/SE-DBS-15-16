/* SPD */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.spd as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 1
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* CDU */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.cdu as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 2
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* CSU */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.csu as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 3
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* GRÜNE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.gruene as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 4
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* FDP */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.fdp as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 5
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* LINKE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.linke as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 6
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* OFFENSIVE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.offensive as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 7
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* REP */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.rep as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 8
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* NPD */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.npd as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 9
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* TIERSCHUTZ */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.tier as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 10
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* GRAUE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.graue as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 11
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* PBC */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.pbc as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 12
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* FRAUEN */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.frauen as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 13
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* FAMILIE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.familie as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 14
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* BÜSO */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.bueso as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 15
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* BP */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.bp as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 16
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* ZENTRUM */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.zentrum as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 17
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* DEUTSCHLAND */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.deutsch as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 18
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* AGFG */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.agfg as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 19
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* APPD */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.appd as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 20
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* 50PLUS */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.plus as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 21
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* MLPD */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.mlpd as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 22
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* DIE PARTEI */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.partei as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 23
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* PSG */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.psg as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 24
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* PRO DM */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.prodm as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 25
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* CM */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.cm as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 26
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* DSU */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.dsu as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 27
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* HP */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.hp as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 28
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* HUMANWIRTSCHAFT */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.human as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 29
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* STATT */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.statt as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 30
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* UNABHÄNGIGE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.unabh as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 31
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;

/* PARTEILOSE */
UPDATE candidate 
SET erststimmen = tmp.erststimmen
FROM (
    SELECT c.id, e.parteilos as erststimmen
    FROM candidate c, ersttmp e, wahlkreis w
    WHERE w.id = e.id
    AND c.wahlkreis = w.id
    AND c.party = 32
    AND c.year = 2009) tmp
WHERE 
    candidate.id = tmp.id;