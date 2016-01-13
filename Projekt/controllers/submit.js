exports.loadSubmit = function (req, res) {

  var pg = require('pg');
  var db = require('./db');
  var results = [];

  var erststimme = req.body.Erststimme;
  var zweitstimme = req.body.Zweitstimme;
  var wahlkreisID = req.flash('wahlkreis')[0];
  var electorID = req.flash('kennung')[0];

  var errorTable = [];

  console.log("Wahlkreis: "+wahlkreisID+", Elector: "+electorID+", Erststimme: "+erststimme+", Zweitstimme: "+zweitstimme);

  if(wahlkreisID == undefined || electorID == undefined){
    errorTable.push("Sie sind nicht korrekt angemeldet. Bitte versuchen Sie es erneut.");
    renderErrorMessage();
  } else {

    pg.connect(db.connectionString, function(err, client, done) {
      if(err) {
        done();
        console.log(err);
        return res.status(500).json({ success: false, data: err});
      }

      // check vote data with query
      // Hat der Wähler der Kennung schon gewählt?
      // Befindet sich der Wähler im übergebenen Wahlkreis?
      // Ist die Erststimme möglich? Tritt der Kandidat in dem Wahlkreis an?
      // Ist die Zweitstimme möglich? Tritt die Partei in dem Wahlkreis/Bundesland an?
      var query;

      if(erststimme == "noErststimme" && zweitstimme == "noZweitstimme" || erststimme == "noErststimme" && zweitstimme == null || erststimme == null && zweitstimme == "noZweitstimme"){
        query = client.query("SELECT e.id AS elector FROM elector e WHERE e.id = $1 AND NOT e.vote2017 AND e.wahlkreis2013 = $2", [electorID, wahlkreisID]);
      }
      else if(erststimme == "noErststimme" && zweitstimme != null){
        query = client.query("SELECT e.id AS elector, r.party FROM elector e, runsforelection r, wahlkreis w WHERE e.id = $1 AND NOT e.vote2017 AND e.wahlkreis2013 = $2 AND w.id = $2 AND w.federalland = r.federalland AND r.year = 2013 AND r.party = $3", [electorID, wahlkreisID, zweitstimme]);
      }
      else if(zweitstimme == "noZweitstimme" && erststimme != null){
        query =client.query("SELECT e.id AS elector, c.candidate FROM elector e, candidateinelection c WHERE e.id = $1 AND NOT e.vote2017 AND e.wahlkreis2013 = $2 AND c.candidate = $3 AND c.year = 2013 AND c.wahlkreis = $2", [electorID, wahlkreisID, erststimme]);
      }
      else if(erststimme != null && zweitstimme != null){
        query = client.query("SELECT e.id AS elector, c.candidate, r.party FROM elector e, candidateinelection c, runsforelection r WHERE e.id = $1 AND NOT e.vote2017 AND e.wahlkreis2013 = $2 AND c.candidate = $3 AND c.year = 2013 AND c.wahlkreis = $2 AND c.federalland = r.federalland AND r.year = 2013 AND r.party = $4", [electorID, wahlkreisID, erststimme, zweitstimme]);
      }

      query.on('error', function(error){
        done();
        errorTable.push(error);
        renderErrorMessage();
      });

      query.on('end', function(result){
        done();
        if(result.rowCount == 0){
          // election invalid/impossible so push an error message
          errorTable.push("Stimmabgabe nicht erfolgreich. Bitte versuchen Sie es erneut.");
        }
        if(errorTable.length > 0) {
          // there were errors in the process, abort and display the messages
          renderErrorMessage();
        } else {
          // everything okay, submit the vote
          submitVote();
        }
      });

    });
  }

  function renderErrorMessage(){
    res.render('submitError',
    { title : 'Stimmabgabe',
    errorTable : errorTable });
  }

  function submitVote() {

    pg.connect(db.connectionString, function(err, client, done) {
      if(err) {
        done();
        console.log(err);
        return res.status(500).json({ success: false, data: err});
      }

      var rollback = function(client, error) {
        client.query('ROLLBACK', function() {
          client.end();
          errorTable.push(error);
          renderErrorMessage();
        });
      };

      // SQL Query > Insert Data

      if(erststimme == "noErststimme" && zweitstimme == "noZweitstimme" || erststimme == "noErststimme" && zweitstimme == null || erststimme == null && zweitstimme == "noZweitstimme"){
        client.query("BEGIN", function(err, result){
          if(err) return rollback(client, err);
          client.query("UPDATE elector SET vote2017=true WHERE id = $1", [electorID], function(err, result){
            if(err) return rollback(client, err);
            console.log("ungültige Erst- und Zweitstimme");
            client.query("COMMIT", function(err, result){
              if(err) return rollback(client, err);
            });
          });
        })
      }
      else if(erststimme == "noErststimme" && zweitstimme != null){
        client.query("BEGIN", function(err, result){
          if(err) return rollback(client, err);
          client.query("UPDATE elector SET vote2017=true WHERE id = $1", [electorID], function(err, result){
            if(err) return rollback(client, err);
            client.query("INSERT INTO vote (year, zweitstimme, wahlkreis) VALUES (2017, "+zweitstimme+", "+wahlkreisID+")", function(err, result){
              if(err) return rollback(client, err);
              console.log("ungültige Erststimme und gültige Zweitstimme");
              client.query("COMMIT", function(err, result){
                if(err) return rollback(client, err);
              });
            });
          });
        });
      }
      else if(zweitstimme == "noZweitstimme" && erststimme != null){
        client.query("BEGIN", function(err, result){
          if(err) return rollback(client, err);
          client.query("UPDATE elector SET vote2017=true WHERE id = $1", [electorID], function(err, result){
            if(err) return rollback(client, err);
            client.query("INSERT INTO vote (year, erststimme, wahlkreis) VALUES (2017, "+erststimme+", "+wahlkreisID+")", function(err, result){
              if(err) return rollback(client, err);
              console.log("gültige Erststimme und ungültige Zweitstimme");
              client.query("COMMIT", function(err, result){
                if(err) return rollback(client, err);
              });
            });
          });
        });
      }
      else if(erststimme != null && zweitstimme != null){
        client.query("BEGIN", function(err, result){
          if(err) return rollback(client, err);
          client.query("UPDATE elector SET vote2017=true WHERE id = $1", [electorID], function(err, result){
            if(err) return rollback(client, err);
            client.query("INSERT INTO vote (year, erststimme, zweitstimme, wahlkreis) VALUES (2017, "+erststimme+", "+zweitstimme+", "+wahlkreisID+")", function(err, result){
              if(err) return rollback(client, err);
              console.log("gültige Erst- und Zweitstimme");
              client.query("COMMIT", function(err, result){
                if(err) return rollback(client, err);
              });
            });
          });
        });
      }

      console.log("Ihre Stimme für die Wahl wurde erfolgreich abgeben");

      client.on('drain', function() {
        done();
        res.redirect("/success");
      });
    });
  }
};
