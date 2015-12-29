exports.loadQ4 = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];
  var year = 2013;
  var paramYear = req.params.year;
  if(paramYear == 2009 || paramYear == 2013)
    year = paramYear;

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query = client.query("SELECT * FROM q4wahlkreissieger"+year);

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // After all data is returned, close connection and return results
    query.on('end', function() {
      done();
      res.render('q4',
      { title : 'Wahlkreissieger',
        year : year,
        resTable : results});
      });

    });
  };
