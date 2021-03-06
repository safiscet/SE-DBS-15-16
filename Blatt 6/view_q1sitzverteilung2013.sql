﻿DROP VIEW IF EXISTS q1sitzverteilung2013;

CREATE VIEW q1sitzverteilung2013 AS (
select p.abkuerzung as party, p.color as color, sum(ch.seats) as seats
from calculateResult(2013) ch join party p on ch.party = p.id
group by p.id, p.abkuerzung, p.color
order by p.abkuerzung
);