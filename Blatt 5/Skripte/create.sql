--each federalland with residents and calculated seats with the begin divisor
create table firstSeatsFederalLand (id int primary key, residents2013 int, seats int);

--table for increase or decrease of divisor and resulting number of seats
create table changeDivisorFederalLand2013 (id int primary key, residents2013 int, 
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(12, 6), 
changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(12, 6), 
resultingDivisor decimal(12, 6), seats int);

--each federalland with parties and calculated seats with the begin divisor
create table firstSeatsParty2013 (federalland int, party int, beginDivisor decimal(12,6), seats int, 
primary key(federalland, party));

--table for increase or decrease of divisor and resulting number of seats for the parties
create table changeDivisorParty2013 (federalland int, party int, zweitstimmen int, 
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(20, 6), 
changeByOneAndHalfSeat decimal(5,1), divisorCandidate2 decimal(20, 6), 
resultingDivisor decimal(20, 6), seats int, maxFromSeatsAndWahlkreis int, primary key(federalland, party));

--table for raising the number of seats for the parties
create table changeDivisorRaiseParty2013 (party int primary key, zweitstimmen int, 
minSeats int,
changeByHalfSeat decimal(5,1), divisorCandidate1 decimal(20, 6), 
changeResultingByHalfSeat decimal(5,1), divisorCandidate2 decimal(20, 6), 
resultingDivisor decimal(20, 6), seats int, ausgleichsmandate int);

--table with begin divisor and resulting seats per party and federalland
create table firstSeatsPartyFinal2013 (
	federalland smallint references federalland(id),
	party smallint references party(id),
	zweitstimmen int,
	begindivisor decimal(12, 6),
	ratioSeats int,
	kreisSeats int,
	seats int,
	primary key (federalland, party)
);

--table for final increase or decrease of divisor and resulting final number of seats for the parties
create table changeDivisorPartyFinal2013 (
	party int, 
	federalland int, 
	zweitstimmen int, 
	kreisseats int,
	prevseats int,
	changeByHalfSeat decimal(5,1), 
	divisorCandidate1 decimal(20, 6), 
	changeByOneAndHalfSeat decimal(5,1), 
	divisorCandidate2 decimal(20, 6), 
	resultingDivisor decimal(20, 6), 
	ratioseats int, 
	seats int,
	primary key(federalland, party)
)