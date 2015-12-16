/*
* Module dependencies
*/
var express = require('express'),
stylus = require('stylus'),
morgan = require('morgan'),
nib = require('nib'),
timeout = require('connect-timeout');
bodyParser = require('body-parser');
flash = require('connect-flash');
cookieParser = require('cookie-parser');
session = require('express-session');

var pg = require('pg');
var connectionString = "postgres://postgres:admin@localhost:5432/bundestagswahlergebnisse";

// local dependencies
var q1 = require("./controllers/q1"),
q2 = require("./controllers/q2"),
q3 = require("./controllers/q3"),
q4 = require("./controllers/q4"),
q5 = require("./controllers/q5"),
q6 = require("./controllers/q6"),
q7 = require("./controllers/q7");
auth = require("./controllers/auth")
vote = require("./controllers/vote"),
submit = require("./controllers/submit");

// set app and exports for routing
var app = express();
module.exports = app;
// add nib to stylus compilation
function compile(str, path) {
  return stylus(str)
  .set('filename', path)
  .use(nib())
}
// set path to views
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');
// configure logging of morgan
app.use(morgan('dev'));
// configure path of compiled css files
app.use(stylus.middleware(
  { src: __dirname + '/public'
  , compile: compile
}
))
// configure path for static files
app.use(express.static(__dirname + '/public'));
// configure body-parser
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
//configure flash
app.use(cookieParser('keyboard cat'));
app.use(session({ cookie: {maxAge: 60000}, resave: false, saveUninitialized: false, secret: 'secret'}));
app.use(flash());

app.use(function(req,res,next){
  var _send = res.send;
  var sent = false;
  res.send = function(data){
    if(sent) return;
    _send.bind(res)(data);
    sent = true;
  };
  next();
});

app.use(timeout(180000));
// Routes
// Home
app.get('/', function (req, res) {
  res.render('index',
  { title : 'Home' }
)
});
//Login
app.get('/auth', auth.loadAuth);
app.post('/auth', auth.loadAuth);

//Stimmzettel generieren
app.get('/vote/(:wahlkreis)?', vote.loadVote);
app.post('/vote/(:wahlkreis)?', vote.loadVote);

// Stimme abgeben
app.get('/submit/', submit.loadSubmit);
app.post('/submit/', submit.loadSubmit);

//Stimmabgabe erfolgreich
app.get('/success', function (req, res) {
  res.render('submittedVote',
    { title : 'Stimmeabgabe erfolgreich' }
  )
});

// Q1 - Sitzverteilung
app.get('/q1/', q1.loadQ1);
// Q2 - Mitglieder des Bundestags
app.get('/q2/', q2.loadQ2);
// Q3 - Wahlkreisübersicht
app.get('/q3/(:wahlkreisId)?', q3.loadQ3);
// Q4 - Wahlkreissieger
app.get('/q4/', q4.loadQ4);
// Q5 - Überhangmandate
app.get('/q5/', q5.loadQ5);
// Q6 - Knappste Sieger
app.get('/q6/(:party)?', q6.loadQ6);
// Q7 - Einzelstimmen (Wahlkreisübersicht)
app.get('/q7/(:wahlkreisId)?', q7.loadQ7);

// listen and start application
app.listen(8080);
console.log("Application started. Listening on port 8080");
