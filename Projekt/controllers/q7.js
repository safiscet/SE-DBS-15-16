exports.loadQ7 = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query = client.query("SELECT * FROM q7wahlkreisuebersicht2013 q1 JOIN q7wahlkreisparty2013 q2 ON q1.wahlkreis = q2.wahlkreis");

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // After all data is returned, close connection and return results
    query.on('end', function() {
      done();
      res.render('q7',
      { title : 'Wahlkreisübersicht (Einzelstimmen)',
        resTable : results});
    });

  });
};
