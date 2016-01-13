exports.loadQ5 = function (req, res) {

  var pg = require('pg');
  var db = require('./db');
  var results = [];
  var errorTable = [];
  var year = 2013;
  var paramYear = req.params.year;
  if(paramYear == 2009 || paramYear == 2013)
    year = paramYear;

  pg.connect(db.connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query = client.query("SELECT * FROM q5ueberhangmandate"+year);

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    query.on('error', function(error){
      done();
      errorTable.push(error);
      render();
    });

    // After all data is returned, close connection and return results
    query.on('end', function() {
      done();
      render();
    });

  });

  function render() {
    res.render('q5',
    { title : 'Überhangmandate',
      year : year,
      errorTable : errorTable,
    resTable : results});
  }

};
