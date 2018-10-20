const express = require( 'express' ) ;
const mysql = require( 'mysql2' ) ;
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

//Database initialization/connection

var config =
    {
        host: 'onefamilyserver2.mysql.database.azure.com',
        user: 'onefamilyadmin@onefamilyserver2',
        password: 'besthacktx2018!',
        database: 'onefamilydb2',
        port: 3306,
        ssl: true
    } ;

var connection = new mysql.createConnection( config ) ;

connection.connect(
    function( err )
    {
        if ( err )
        {
            console.log( "Error: could not create connection to MySQL database." ) ;
            console.log( err ) ;
        }

        else
        {
            console.log( "Successfully connected to MySQL database." ) ;
        }
    }
) ;

function getConnection()
{
    return connection ;
}

module.exports = getConnection ;

//Start listening on port 3000

app.listen( port ) ;

console.log( "OneFamily API server started on port " + port ) ;