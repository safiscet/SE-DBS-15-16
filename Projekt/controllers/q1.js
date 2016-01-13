exports.loadQ1 = function (req, res) {

  var pg = require('pg');
  var db = require('./db');
  var results = [];
  var errorTable = [];
  var coalitions;
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
    var query = client.query("SELECT * FROM q1sitzverteilung" + year);

    query.on('error', function(error){
      done();
      errorTable.push(error);
      render();
    });

    // Stream results back one row at a time
    query.on('row', function(row) {
      results.push(row);
    });

    // After all data is returned, close connection and return results
    query.on('end', function() {
      done();
      coalitions = analyseCoalitions();
      render();
    });
  });

  function render(){
    res.render('q1',
    { title : 'Sitzverteilung',
    year : year,
    resTable : results,
    errorTable : errorTable,
    partyData : results,
    coalitions : coalitions });
  }

function analyseCoalitions(){
  var parties = [];
  var seats = 0;
  var cducsu = 0;
  for(var i = 0; i < results.length; i++){
    var v = results[i];
    seats += parseInt(v.seats);
    if(v.party == 'CDU'){
      cducsu += parseInt(v.seats);
    }
    else if(v.party == 'CSU'){
      cducsu += parseInt(v.seats);
    }
    else{
      parties.push(v);
    }
  }
  parties.unshift({party: "CDU/CSU", color: "black", seats: cducsu});
  var halfseats = parseInt(seats / 2);
  var coalitions = [];
  // überprüfe für jede Partei einzeln, ob sie schon die Mehrheit hat
  for(var i = 0; i < parties.length; i++){
    if(parties[i].seats > halfseats){
      var p = [parties[i]];
      coalitions.push({seats: parties[i].seats, name: getCoalitionName(p), parties: p});
    }
  }
  // Überprüfe alle 2er Gruppen
  //    gehe die Liste durch und überprüfe für den aktuellen Index alle j > Index
  for(var i = 0; i < parties.length; i++){
    for(var j = i + 1; j < parties.length; j++){
      var cseats = parseInt(parties[i].seats) + parseInt(parties[j].seats);
      if(cseats > halfseats){
        var p = [parties[i], parties[j]];
        coalitions.push({seats: cseats, name: getCoalitionName(p), parties: p});
      }
    }
  }
  // Überprüfe alle 3er Gruppen
  //    für jede Partei mit Index i > 0:
  //      für jede Partei mit Index j > i:
  //        überprüfe jeweils alle Parteien mit Index k > j
  for(var i = 0; i < parties.length; i++){
    for(var j = i + 1; j < parties.length; j++){
      for(var k = j + 1; k < parties.length; k++){
        var cseats = parseInt(parties[i].seats) + parseInt(parties[j].seats) + parseInt(parties[k].seats);
        if(cseats > halfseats){
          var p = [parties[i], parties[j], parties[k]];
          coalitions.push({seats : cseats, name: getCoalitionName(p), parties : p });
        }
      }
    }
  }
  // Sortiere Array: Zuerst möglichst wenige Parteien mit vielen Gesamtsitzen
  coalitions.sort(function(a,b) {
    if(a.parties.length == b.parties.length){
      return b.seats - a.seats;
    } else {
      return a.parties.length - b.parties.length;
    }
  });
  return coalitions;
}

function getCoalitionName(parties){
  text = "";
  for(var i = parties.length - 1; i >= 0; i--){
    text += parties[i].party + ", ";
  }
  return text;
}
};
