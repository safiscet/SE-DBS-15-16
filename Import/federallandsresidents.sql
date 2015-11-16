create table federallandsresidents (
    id smallint references federalland(id),
    year smallint NOT NULL,
    residents int NOT NULL,
    primary key (id, year)
);
insert into federallandsresidents (id, year, residents)
values  (1,2013,2686085), -- Schleswig-Holstein 1
	(13,2013,1585032), -- Mecklenburg-Vorpommern 13
	(2,2013,1559655), -- Hamburg 2
	(3,2013,7354892), -- Niedersachsen 3
	(4,2013,575805), -- Bremen 4
	(12,2013,2418267), -- Brandenburg 12
	(15,2013,2247673), -- Sachsen-Anhalt 15
	(11,2013,3025288), -- Berlin 11
	(5,2013,15895182), -- NRW 5
	(14,2013,4005278), -- Sachsen 14
	(6,2013,5388350), -- Hessen 6
	(16,2013,2154202), -- Thüringen 16
	(7,2013,3672888), -- Rheinland-Pfalz 7
	(9,2013,11353264), -- Bayern 9
	(8,2013,9482902), -- BW 8
	(10,2013,919402); -- Saarland 10