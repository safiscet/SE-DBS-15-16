exports.loadQ7 = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];
  var erg = [];
  var wahlkreisForOption = [];

  var wahlkreisId = req.params.wahlkreisId;
  console.log(wahlkreisId);

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }
    // SQL Query > Select Data
    var query3 = client.query("SELECT * FROM q7wahlkreisuebersicht2013");

    if(wahlkreisId == undefined){
      var query = client.query("SELECT * FROM q7wahlkreisuebersicht2013");
      var query2 = client.query("SELECT * FROM q7wahlkreisparty2013");
    } else {
      var query = client.query("SELECT * FROM q7wahlkreisuebersicht2013 wkp JOIN wahlkreis w ON w.name = wkp.wahlkreis where w.id ="+wahlkreisId);
      var query2 = client.query("SELECT * FROM q7wahlkreisparty2013 wkp JOIN wahlkreis w ON w.name = wkp.wahlkreis where w.id ="+wahlkreisId);
    }

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // Stream results back one row at a time
    query2.on('row', function(row) {
      erg.push(row);
    });

    // Stream results back one row at a time
    query3.on('row', function(row) {
      wahlkreisForOption.push(row);
    });

    client.on('drain', function() {
      done();

      res.render('q3',
      {
        title : 'Wahlkreisübersicht',
        optionTable : wahlkreisForOption,
        ergTable : erg,
        resTable : results
      });
    });

  });
};
