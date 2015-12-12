exports.loadVote = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];
  var erg = [];

  var wahlkreisId = req.params.wahlkreisId;
  //console.log(wahlkreisId);

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Select Data
    if(wahlkreisId != undefined){
      var query = client.query("WITH tmp as (select cie.wahlkreis, c.id as candidateID, c.name as candidate, p.abkuerzung as candidateparty FROM candidateInElection cie JOIN candidate c ON cie.candidate = c.id JOIN party p ON p.id = cie.party WHERE cie.year = 2013 AND cie.party = p.id AND cie.wahlkreis = "+wahlkreisId+") SELECT w.id as wahlkreisID, w.name as wahlkreis, r.federalland, p.abkuerzung, p.id as partyID, tmp.candidate as candidate, tmp.candidateID as candidateID, tmp.candidateparty as candidateparty, p.name as party FROM runsforelection r JOIN wahlkreis w ON r.federalland = w.federalland JOIN party p ON p.id = r.party LEFT JOIN tmp ON tmp.candidateparty = p.abkuerzung WHERE r.year = 2013 AND p.abkuerzung <> 'PARTEILOSE' AND w.id = "+wahlkreisId);
      //var query2 = client.query("SELECT c.name as candidate, p.name, p.abkuerzung FROM candidateInElection cie join candidate c ON cie.candidate = c.id JOIN party p ON cie.party = p.id WHERE cie.year = 2013 AND cie.wahlkreis = "+wahlkreisId);
    }

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // Stream results back one row at a time
    //query2.on('row', function(row) {
      //erg.push(row);
    //});

    client.on('drain', function() {
      done();

      res.render('vote',
      { title : 'Wählen',
        //ergTable : erg,
        resTable : results
      });
    });

  });
};

/*

SELECT w.id, w.name, p.abkuerzung, r.federalland
FROM runsforelection r, wahlkreis w, party p
WHERE w.id = 1
AND r.federalland = w.federalland
AND r.year = 2013
AND p.id = r.party
AND p.abkuerzung <> 'PARTEILOSE'


SELECT c.name, p.name, p.abkuerzung,
FROM candidateInElection cie join candidate c ON cie.candidate = c.id
JOIN party p ON cie.party = p.id
WHERE cie.year = 2013
AND cie.wahlkreis = 1

*/
