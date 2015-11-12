/* each federalland with residents and calculated seats with the begin divisor*/
create table firstSeatsFederalLand (id int primary key, residents2013 int, seats int);

/*table for increase or decrease of divisor and resulting number of seats*/
create table changeDivisorFederalLand2013 (id int primary key, residents2013 int, 
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(12, 6), 
changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(12, 6), 
resultingDivisor decimal(12, 6), seats int);