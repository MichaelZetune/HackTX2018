const mysql = require( 'mysql2' ) ;

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

module.exports = connection ;