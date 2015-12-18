exports.loadQ3 = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];
  var erg = [];
  var wahlkreisForOption = [];
  var federallandForOption = [];

  var wahlkreisId = req.params.wahlkreisId;
  console.log(wahlkreisId);

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query3 = client.query("SELECT * FROM q3wahlkreisuebersicht2013");
    var query4 = client.query("SELECT DISTINCT f.id as nummer, f.name as name FROM q3wahlkreisuebersicht2013 q JOIN wahlkreis w ON q.nummer = w.id JOIN federalland f ON w.federalland = f.id order by f.id");

    if(wahlkreisId == undefined){
      //var query = client.query("SELECT * FROM q3wahlkreisuebersicht2013");
      //var query2 = client.query("SELECT q13.wahlkreis, q13.party, q13.zweitstimmenabsolute, q13.zweitstimmenpercent, q9.zweitstimmenabsolute2009, q9.zweitstimmenpercent2009 FROM q3wahlkreisparty2013 q13 JOIN q3wahlkreisparty2009 q9 ON q13.wahlkreis = q9.wahlkreis WHERE q13.party = q9.party");
    } else {
      var query = client.query("SELECT * FROM q3wahlkreisuebersicht2013 WHERE nummer = "+wahlkreisId);
      var query2 = client.query("SELECT q13.wahlkreis, q13.party, q13.zweitstimmenabsolute, q13.zweitstimmenpercent, q9.zweitstimmenabsolute2009, q9.zweitstimmenpercent2009 FROM q3wahlkreisparty2013 q13 JOIN q3wahlkreisparty2009 q9 ON q13.wahlkreis = q9.wahlkreis JOIN wahlkreis w ON w.name = q13.wahlkreis WHERE q13.party = q9.party AND w.id ="+wahlkreisId);

      // Stream results back one row at a time
      query.on('row', function(row) {
        results.push(row);
      });

      // Stream results back one row at a time
      query2.on('row', function(row) {
        erg.push(row);
      });
    }



    // Stream results back one row at a time
    query3.on('row', function(row) {
      wahlkreisForOption.push(row);
    });

    // Stream results back one row at a time
    query4.on('row', function(row) {
      federallandForOption.push(row);
    });


    client.on('drain', function() {
      done();

      res.render('q3',
      { title : 'Wahlkreisübersicht',
        optionTable : wahlkreisForOption,
        federallandOptionTable: federallandForOption,
        ergTable : erg,
        resTable : results
      });
    });

  });
};
