# Wahlinformationssystem

## Setup
* Install node.js Version 4.2.2 (x86).
  * node package manger (npm) should be integrated in the installer.
* Navigate to the project directory (/Projekt) via command line.
* Execute `npm install`.
  * This will install all needed modules.
  * The modules are specified in the dependencies section in the package.json file.
* Execute `node server.js` or `npm start` to start the application server
* The site can be accessed via http://127.0.0.1:8080/ or http://localhost:8080/.
* All registered invocations will be logged to the console output (e.g. for debugging information).


## Dependencies
* [Express](http://expressjs.com/) (node.js web application framework)
* [Jade](http://jade-lang.com/) (Template Enginge)
* [Stylus](https://learnboost.github.io/stylus/) (CSS Preprocessor)
* [Nib](https://github.com/tj/nib) (Stylus mixins, utilities, ...)
* [morgan](https://www.npmjs.com/package/morgan) (Logging)
* [pg](https://github.com/brianc/node-postgres) (PostgreSQL client for node.js)
* [connect-timeout](https://github.com/expressjs/timeout) (timeouts in express)
* [body-parser](https://github.com/expressjs/body-parser) (body parsing middleware)
* [connect-flash](https://github.com/jaredhanson/connect-flash) (session messages)
* [cookie-parser](https://www.npmjs.com/package/cookie-parser) (cookie parsing with signatures)
* [express-session](https://github.com/expressjs/session) (session middleware for express)

## Useful Editor
* Atom (e.g. with the following packages)
  * color-picker
  * webbox-color
  * stylus-autocompile
  * Stylus
  * atom-jade
  * auto-indent
  * source-preview
  * source-preview-jade

## Miscellaneous
  * [Jade-Tutorial](http://webapplog.com/jade/)
