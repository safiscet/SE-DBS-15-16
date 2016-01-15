# Generator for electors and votes

*	Execute changed_candidateinelection in PostgreSQL in /Generator to insert generated candidates that are missing in the kerg files
*	Setup the java project in /Generator with all libraries in /libs
*	Execute ElectorGenerator.java to generate and import all electors for both elections. This could take a while (up to multiple hours)
*	Execute VoteGenerator.java to generate csv files containing vote data for both elections. This process should not take more than 5 minutes.
	* First just run the file to generate vote data for 2009
  * Then change the year in the java file to 2013 and run it again
*	Execute copy_generated_votes_2009 and copy_generated_votes_2013 in PostgreSQL to import the generated data. This process could take up to 1 hour
