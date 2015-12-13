exports.loadSubmit = function (req, res) {

  var pg = require('pg');
  var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";
  var results = [];

  var erststimme = req.body.Erststimme;
  console.log("Erststimme: "+erststimme);
  var zweitstimme = req.body.Zweitstimme;
  var wahlkreisID = req.body.wahlkreisId;
  console.log("Wahlkreis: "+wahlkreisID);
  var electorID = req.body.elector;
  console.log("Elector: "+electorID);


  console.log("Wahlkreis: "+wahlkreisID+", Elector: "+electorID+", Erststimme: "+erststimme+", Zweitstimme: "+zweitstimme);

  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }

    // SQL Query > Insert Data
    if(erststimme == "noErststimme" && zweitstimme == "noZweitstimme" || erststimme == "noErststimme" && zweitstimme == null || erststimme == null && zweitstimme == "noZweitstimme"){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      console.log("ungültige Erst- und Zweitstimme");
    }
    else if(erststimme == "noErststimme" && zweitstimme != null){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      //client.query("INSERT INTO vote (year, zweitstimme, wahlkreis) VALUES (2017, "+zweitstimme+", "+wahlkreisID+")");
      console.log("ungültige Erststimme und gültige Zweitstimme");
    }
    else if(zweitstimme == "noZweitstimme" && erststimme != null){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      //client.query("INSERT INTO vote (year, erststimme, wahlkreis) VALUES (2017, "+erststimme+", "+wahlkreisID+")");
      console.log("gültige Erststimme und ungültige Zweitstimme");
    }
    else if(erststimme == null && zweitstimme != null){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      //client.query("INSERT INTO vote (year, zweitstimme, wahlkreis) VALUES (2017, "+zweitstimme+", "+wahlkreisID+")");
      console.log("ungültige Erststimme und gültige Zweitstimme")
    }
    else if(erststimme != null && zweitstimme == null){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      //client.query("INSERT INTO vote (year, erststimme, wahlkreis) VALUES (2017, "+erststimme+", "+wahlkreisID+")");
      console.log("gültige Erststimme und ungültige Zweitstimme");
    }
    else if(erststimme != null && zweitstimme != null){
      //client.query("UPDATE electors SET vote2017=true WHERE id="+electorID);
      //client.query("INSERT INTO vote (year, erststimme, zweitstimme, wahlkreis) VALUES (2017, "+erststimme+", "+zweitstimme+", "+wahlkreisID+")");
      console.log("gültige Erst- und Zweitstimme")
    }

    //window.alert("Ihre Stimme für die Wahl wurde erfolgreich abgeben");
    console.log("Ihre Stimme für die Wahl wurde erfolgreich abgeben");

  });



  res.redirect("/");

};