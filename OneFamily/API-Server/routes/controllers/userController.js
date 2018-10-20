var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
{
    checkStatus : function( req, res )
    {
        res.send( "Endpoint is good!" ) ;
    }

    createUser : function( req, res )
    {
        if ( sql )
        {
            var email           = req.body.email ;
            var passwordHash    = req.body.passwordHash ;
            var userType        = req.body.userType ;
            var uid             = null ; //Generate this later

            //Verify parameters
            if ( email && passwordHash && userType )
            {
                //Generate UID
                uid = uuidv1() ;

                sql.query( 'INSERT INTO user (email, passwordHash, userType, uid) VALUES (?, ?, ?, ?);',
                           [ email, passwordHash, userType, uid ],
                    function( err, results, fields )
                    {
                        if ( err )
                            throw err ;

                        res.send(
                        {

                        } ) ;

                        res.send( "Successfully inserted user into database." ) ;
                    } ) ;
            }
        }
    }
} ;