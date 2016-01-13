exports.loadQ3 = function (req, res) {

  var pg = require('pg');
  var db = require('./db');
  var results = [];
  var erg = [];
  var wahlkreisForOption = [];
  var federallandForOption = [];
  var errorTable = [];

  var year = 2013;
  var paramYear = req.params.year;
  if(paramYear == 2009 || paramYear == 2013)
    year = paramYear;

  var wahlkreisId = req.params.wahlkreisId;
  console.log(wahlkreisId);

  pg.connect(db.connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    var query3 = client.query("SELECT * FROM q3wahlkreisuebersicht" + year);
    var query4 = client.query("SELECT DISTINCT f.id as nummer, f.name as name FROM q3wahlkreisuebersicht"+year+" q JOIN wahlkreis w ON q.nummer = w.id JOIN federalland f ON w.federalland = f.id order by f.id");

    if(wahlkreisId == undefined){
      //var query = client.query("SELECT * FROM q3wahlkreisuebersicht2013");
      //var query2 = client.query("SELECT q13.wahlkreis, q13.party, q13.zweitstimmenabsolute, q13.zweitstimmenpercent, q9.zweitstimmenabsolute2009, q9.zweitstimmenpercent2009 FROM q3wahlkreisparty2013 q13 JOIN q3wahlkreisparty2009 q9 ON q13.wahlkreis = q9.wahlkreis WHERE q13.party = q9.party");
    } else {
      var wahlkreisInt = parseInt(wahlkreisId);
      console.log(wahlkreisInt);
      if(isNaN(wahlkreisInt) || wahlkreisInt < 1 || wahlkreisInt > 299){
        wahlkreisInt = 1;
        errorTable.push("Der gewählte Wahlkreis existiert nicht. Es werden Beispiel-Ergebnisse für Flensburg - Schleswig angezeigt.");
      }
      var query = client.query("SELECT * FROM q3wahlkreisuebersicht"+year+" WHERE nummer = $1", [wahlkreisInt]);
      var query2 = client.query("SELECT q13.wahlkreis, q13.party, q13.zweitstimmenabsolute, q13.zweitstimmenpercent, q9.zweitstimmenabsolute2009, q9.zweitstimmenpercent2009 FROM q3wahlkreisparty2013 q13 JOIN q3wahlkreisparty2009 q9 ON q13.wahlkreis = q9.wahlkreis JOIN wahlkreis w ON w.name = q13.wahlkreis WHERE q13.party = q9.party AND w.id = $1", [wahlkreisInt]);

      // Stream results back one row at a time
      query.on('row', function(row) {
        results.push(row);
      });

      query.on('error', function(error){
        errorTable.push(error);
      });

      // Stream results back one row at a time
      query2.on('row', function(row) {
        erg.push(row);
      });

      query2.on('error', function(error){
        errorTable.push(error);
      });
    }



    // Stream results back one row at a time
    query3.on('row', function(row) {
      wahlkreisForOption.push(row);
    });

    query3.on('error', function(error){
      errorTable.push(error);
    });

    // Stream results back one row at a time
    query4.on('row', function(row) {
      federallandForOption.push(row);
    });

    query4.on('error', function(error){
      errorTable.push(error);
    });


    client.on('drain', function() {
      done();

      res.render('q3',
      { title : 'Wahlkreisübersicht',
        year : year,
        optionTable : wahlkreisForOption,
        errorTable : errorTable,
        federallandOptionTable: federallandForOption,
        ergTable : erg,
        resTable : results
      });
    });

  });
};
