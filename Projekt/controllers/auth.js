exports.loadAuth = function (req, res) {

  var pg = require('pg');
  var db = require('./db');

  var kenString = req.body.kennung;
  var gebString = req.body.geburtsdatum;
  var errorTable = [];

  if(kenString == undefined && gebString == undefined){
    // Es wurde noch nichts eingegeben
    render(res, errorTable);
  }
  else {
    // Login wurde versucht
    var kennung = parseInt(kenString);
    var geburtsdatum = parseInt(gebString);

    if(isNaN(kennung)){
      errorTable.push("Die eingegebene Kennung war keine Zahl.");
    }
    if(isNaN(geburtsdatum)){
      errorTable.push("Das eingegebene Geburtsdatum war keine Zahl.");
    }

    if(!checkBirthday(gebString)){
      errorTable.push("Das eingegebene Geburtsdatum hatte ein inkorrektes Format.");
    }

    if(errorTable.length == 0){
      // Bisher keine Fehler, überprüfe die Einträge in der Datenbank
      loadData(req, res, pg, db.connectionString, kennung, gebString);
    } else {
      // Es gibt schon Fehler, zeige diese an und verlange neue Eingabe
      render(res, errorTable, kenString, gebString);
    }
  }
}

function loadData(req, res, pg, connectionString, id, birthday) {
  var results = [];
  pg.connect(connectionString, function(err, client, done) {
    if(err) {
      done();
      console.log(err);
      return res.status(500).json({ success: false, data: err});
    }
    var qbirthday = birthday.toString().substr(0,2) + "-"+ birthday.toString().substr(2,2) + "-" + birthday.toString().substr(4,4);
    var query = client.query("SELECT id AS kennung, wahlkreis2013 AS wahlkreis, vote2017 AS voted FROM elector WHERE id = $1 AND birthday = $2", [id, qbirthday]);

    query.on('row', function(row) {
      results.push(row);
    });

    query.on('end', function() {
      done();
      checkData(req, res, results, id, birthday);
    });
  });
}

function checkBirthday(gebString){
  var format = true;
  if(gebString.length != 8){
    format = false;
  }
  else if(gebString.substr(0,2) < 1 || gebString.substr(0,2) > 31){
    format = false;
  }
  else if(gebString.substr(2,2) < 1 || gebString.substr(2,2) > 12){
    format = false;
  }
  else if(gebString.substr(4,4) < 1900 || gebString.substr(4,4) > 2100) {
    format = false;
  }
  return format;
}

function checkData(req, res, results, id, birthday) {
  if(results == undefined || results.length != 1){
    render(res, ["Die eingegebenen Daten passen nicht zueinander."], id, birthday);
  } else if(results[0].voted){
    render(res, ["Sie haben bereits gewählt."], id, birthday);
  }
  else {
    // Schicke Kennung und Geburtsdatum über Flash mit
    req.flash('kennung', id);
    req.flash('geburtsdatum', birthday);
    req.flash('wahlkreis', results[0].wahlkreis);
    res.redirect("/vote/"+results[0].wahlkreis);
    // in vote dann auslesen über req.flash('kennung')
  }
}

function render(res, errorTable, kennung, geb) {
  res.render('auth',
  { title : 'Stimme abgeben' ,
  errorTable : errorTable,
  gebVal : geb,
  kenVal : kennung });
}
