DROP VIEW IF EXISTS q1sitzverteilung2009;

CREATE VIEW q1sitzverteilung2009 AS (
select p.abkuerzung as party, sum(ch.seats) as seats
from calculateResult(2009) ch join party p on ch.party = p.id
group by p.id, p.abkuerzung
order by p.abkuerzung
);