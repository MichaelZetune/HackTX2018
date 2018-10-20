const express = require( 'express' ) ;
const bodyParser = require('body-parser');

const app = express() ;
const router = express.Router() ;
const port = 3000 ;

// parse application/x-www-form-urlencoded
app.use( bodyParser.urlencoded( { extended: false } ) ) ;

// parse application/json
app.use( bodyParser.json() ) ;

var routes = require( './routes/routes') ;
app.use( '/api', routes ) ;

//Start listening on port 3000

app.listen( port ) ;

console.log( "OneFamily API server started on port " + port ) ;