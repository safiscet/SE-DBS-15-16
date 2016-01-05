exports.loadQ6 = function (req, res) {
  var pg = require('pg');
  var db = require('./db');
  var results = [];
  var parties = [];
  var partySelected = false;

  var partyId = req.params.party;

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
    var query2 = client.query("SELECT p.id, p.abkuerzung as party FROM partyinelection e, party p WHERE e.party = p.id AND e.year = "+year+" AND erststimmen > 0 ORDER BY p.abkuerzung");
    var partyInt = parseInt(partyId);
    if(partyId != undefined && !isNaN(partyInt) && partyInt >= 1 && partyInt <= 40){
      var query = client.query("SELECT * FROM q6tightestwinner"+year+" q, party p WHERE q.candidateparty = p.abkuerzung AND p.id ="+partyId);
      partySelected = true;
      // Stream results back one row at a time
      query.on('row', function(row) {
        results.push(row);
      });
    }

    query2.on('row', function(row) {
      parties.push(row);
    });

    // After all data is returned, close connection and return results
    client.on('drain', function() {
      done();
      var errorTable = [];
      if(results.length == 0 && partySelected)
        errorTable.push("Die gewählte Partei ist in diesem Jahr nicht angetreten oder existiert nicht.");
      res.render('q6',
        { title : 'Knappste Sieger',
          year : year,
          errorTable : errorTable,
          parties : parties,
          resTable : results});
    });


  });
};
