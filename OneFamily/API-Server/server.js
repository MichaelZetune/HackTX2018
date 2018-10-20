const express = require( 'express' ) ;
const mysql = require( 'mysql2' ) ;

const app = express() ;
const router = express.Router() ;
const port = 3000 ;

router.get( '/', function( req, res, next )
{
    res.send( 'Root route for OneFamily' ) ;
} ) ;

routes( app ) ;

app.listen( port ) ;

console.log( "OneFamily API server started on port " + port ) ;

/*app.use( function( req, res, next )
    {
        var config =
            {
                host: 'onefamilydb.mysql.database.azure.com',
                user: 'onefamilydb',
                password: 'besthacktx2018!',
                database: 'onefamilydb',
                port: 3306,
                ssl: true
            } ;

        res.locals.connection = new mysql.createConnection( config ) ;

        res.locals.connect(
            {
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
            } ) ;

        next() ;


    } ) ;*/