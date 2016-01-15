alter table party add color varchar(30);

update party set color = 'black' where abkuerzung = 'CDU';

update party set color = 'red' where abkuerzung = 'SPD';

update party set color = 'green' where abkuerzung = 'GRUENE';

update party set color = 'yellow' where abkuerzung = 'FDP';

update party set color = 'purple' where abkuerzung = 'DIE LINKE';

update party set color = 'blue' where abkuerzung = 'CSU';