/*begin divisor: total residents divided by 598*/
with divisorBegin as (select sum(residents2013)/598.00 from federalland)


/* insert id, residents2013, first calculated seats */
insert into firstSeatsFederalLand (select id, residents2013, round(residents2013/(select * from divisorBegin)) as seats from federalland);
insert into changedivisorfederalland2013 (id, residents2013) (select id, residents2013 from firstSeatsFederalLand);


/* change the number of seats per federalland according to the number of calculated seats*/
select * from changeNumberOfSeats();

/*distribute the seats per federalland to the parties according to their zweitstimmen*/
