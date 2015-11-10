create table Elector (
	id 		serial		primary key,
	name		varchar(60),	
	sex		char(1)		check (sex = 'm' or sex = 'f'),
	birthday	date		not null,	
	wahlkreis	smallint	references Wahlkreis(id));

create table Vote (
	id		serial		primary key,
	year		smallint	not null,
	erststimme	smallint	references Candidate(id),
	zweitstimme	smallint	references Party(id),
	wahlkreis	smallint	references Wahlkreis(id));

create table Party (
	id		smallint	primary key,
	name		varchar(100)	not null,
	abkuerzung	varchar(30)	not null
);

create table PartyInElection (
	party			integer		references Party(id),
	year			smallint	not null,			
	erststimmen		integer,
	zweitstimmen		integer,
	wonDistricts		smallint,
	fiverPercentTaken	boolean,
	primary key (party, year)
);
	
create table FederalLand (
	id		smallint	primary key,
	name		varchar(25)	not null,
	residents2009	integer		not null check (residents2009 >= 0),
	residents2013	integer		not null check (residents2013 >= 0)
);

create table Wahlkreis (
	id		smallint	primary key,
	name		varchar(90)	not null,
	federalLand	smallint	references FederalLand(id)
);

create table WahlkreisInElection (
	wahlkreis	smallint	references Wahlkreis(id),
	year		smallint	not null,
	residents	integer		not null,
	winnerParty	smallint	references Party(id),
	winnerCandidate	smallint	references Candidate(id),
	primary key (wahlkreis, year)
);
	
create table Candidate (
	id		integer		primary key,
	name		varchar(80)	not null,
	jahrgang	smallint	not null 
);
	
create table CandidateInElection (
	candidate	integer		references Candidate(id),
	year		smallint	not null,
	erststimmen	integer,
	rank		smallint,
	party		smallint	references Party(id),
	wahlkreis	smallint	references Wahlkreis(id),
	federalLand 	smallint 	references federalland(id),
	primary key (candidate, year) 
);
	
create table RunsForElection (
	federalLand	smallint	references FederalLand(id),
	party		smallint	references Party(id),
	year		smallint	not null,
	primary key (federalLand, party, year) 
);
