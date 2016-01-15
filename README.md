# SE-DBS-15-16

Project of the lecture 'Datenbanksysteme' (SE).

PostgreSQL: Version 9.4.5 Win (32)

Node.js: Version 4.2.2 Win (32)

## Structure:
* Abgabe: all important documents in the most recent versions
* Benchmark Ergebnisse: our results of the benchmark
* Benchmark: the benchmark client that generates an input file for JMeter
* Blatt X: the x-th Exercise.
* Generator:
  * a generator for inserting electors in the database (ElectorGenerator)
  * a generator for creating insert statements for all missing candidates (parties that got "erststimmen" in a "wahlkreis" without having a candidate in that "wahlkreis")
    * the missing candidates can be imported by executing changed_candidateinelection.sql
  * a generator for creating csv-files containing all votes for the election
    * the votes can be imported by executing copy_generated_votes_20XX.sql
* Import:
  * csv files for every table with matching columns
  * copy files for importing the data
  * the source files ("Rohdaten")
* Projekt: all files of the website
