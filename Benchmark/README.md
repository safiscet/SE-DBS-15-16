# Benchmark client

* This benchmark client will generate a valid input file for JMeter
* Configuration with command-line parameters:
	* `-t` wait time in milliseconds
	* `-d` total duration of the test in seconds
	* `-w` workload mix, followed by 6 integer values for the percentage of the requests
	* `-n` number of terminals
	* `-p` path of the JMeter installation
	* `-f` file name for the generated test plan file
	* e.g. `-t 1200 -d 100 -n 15 -w 15 15 15 15 20 20`
* run Benchmark.java with all libraries in /libs added to the build path
