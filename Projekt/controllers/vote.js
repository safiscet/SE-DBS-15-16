exports.loadVote = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results2 = [];
  var errorTable = [];

  var wahlkreisId = req.params.wahlkreis;
  var kennung = req.flash('kennung')[0];
  var geburtsdatum = req.flash('geburtsdatum')[0];

  console.log(wahlkreisId);
  console.log(kennung);
  console.log(geburtsdatum);

  if(kennung == undefined || geburtsdatum == undefined){
    //- Wenn man die Seite aufruft, ohne sich einzuloggen, wird man auf "auth" zurück geleitet
    res.redirect('/auth');
  } else {
    loadData(req, res, pg, connectionString, parseInt(kennung), geburtsdatum);
  }

  function loadData(req, res, pg, connectionString, kennung, geburtsdatum) {
    var results = [];
    pg.connect(connectionString, function(err, client, done) {
      if(err) {
        done();
        console.log(err);
        return res.status(500).json({ success: false, data: err});
      }
      var birthday = geburtsdatum.toString().substr(0,2) + "-"+ geburtsdatum.toString().substr(2,2) + "-" + geburtsdatum.toString().substr(4,4);
      var query = client.query("SELECT id AS kennung, wahlkreis2013 AS wahlkreis, vote2017 AS voted FROM elector WHERE id = $1 AND birthday = $2", [kennung, birthday]);

      query.on('row', function(row) {
        results.push(row);
      });

      query.on('end', function() {
        done();
        checkData(req, res, results, kennung, geburtsdatum);
      });
    });
  }

  function checkData(req, res, results, kennung, geburtsdatum) {
    if(results == undefined || results.length != 1 || results[0].voted){
      render(res, ["Sie sind nicht eingeloggt"], kennung, geburtsdatum);
    }
    else {
      pg.connect(connectionString, function(err, client, done) {
        if(err) {
          done();
          console.log(err);
          return res.status(500).json({ success: false, data: err});
        }

        //- SQL Query > Select Data
        if(wahlkreisId != undefined){
          var query = client.query("WITH tmp as (select cie.wahlkreis, c.id as candidateID, c.name as candidate, p.abkuerzung as candidateparty FROM candidateInElection cie JOIN candidate c ON cie.candidate = c.id JOIN party p ON p.id = cie.party WHERE cie.year = 2013 AND cie.party = p.id AND cie.wahlkreis = "+wahlkreisId+") SELECT w.id as wahlkreisID, w.name as wahlkreis, r.federalland, p.abkuerzung, p.id as partyID, tmp.candidate as candidate, tmp.candidateID as candidateID, tmp.candidateparty as candidateparty, p.name as party FROM runsforelection r JOIN wahlkreis w ON r.federalland = w.federalland JOIN party p ON p.id = r.party LEFT JOIN tmp ON tmp.candidateparty = p.abkuerzung WHERE r.year = 2013 AND p.abkuerzung <> 'PARTEILOSE' AND w.id = "+wahlkreisId);
        }

        //- Stream results back one row at a time
        query.on('row', function(row) {
          results2.push(row);
        });

        client.on('drain', function() {
          done();

          //- Schicke Kennung, Wahlkreis und Geburtsdatum über Flash mit
          req.flash('kennung', kennung);
          req.flash('geburtsdatum', geburtsdatum);
          req.flash('wahlkreis', wahlkreisId)

          res.render('vote',
          { title : 'Wählen',
            resTable : results2,
            errorTable: errorTable
          });
        });

      });
    }
  }

  function render(res, errorTable, kennung, geburtsdatum) {
    res.render('vote',
    { title : 'Wählen',
    errorTable : errorTable,
    resTable : results2
    });
  }


};
