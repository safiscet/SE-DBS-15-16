exports.loadQ3 = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];
  var results2 = [];

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query = client.query("SELECT * FROM q3wahlkreisuebersicht2013");
    var query2 = client.query("SELECT * FROM q3wahlkreisparty2013");

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // Stream results back one row at a time
    query2.on('row', function(row) {
      results2.push(row);
    });

    // After all data is returned, close connection and return results
    //query.on('end', function() {
      //done();
      //res.render('q3',
      //{ title : 'Wahlkreisübersicht',
        //resTable : results});
    //});
    client.on('drain', function() {
      //done();
      res.render('q3',
      { title : 'Wahlkreisübersicht',
        restable : results
        resTable1 : results,
        resTable2 : reuslts2
      });
      //console.log("drained");
    });

  });
};
