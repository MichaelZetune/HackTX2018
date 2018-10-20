var sql = require( '../../server' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

verifyUniqueUID = function( uid )
{
    //Check to make sure this UID is unique
    sql.query( 'SELECT * FROM user WHERE uid=\'' + uid + '\'',
        function( err, results, fields )
        {
            if ( err )
                throw err ;

            return results.length === 0 ;
        } ) ;
} ;

module.exports =
{
    createUser : function( req, res )
    {
        if ( sql )
        {
            console.log( sql ) ;

            var email           = req.body.email ;
            var passwordHash    = req.body.passwordHash ;
            var userType        = req.body.userType ;
            var uid             = null ; //Generate this later

            //Verify parameters
            if ( email && passwordHash && userType )
            {
                console.log( "yo 2" ) ;

                //Generate UID
                uid = uuidv1() ;

                while ( !verifyUniqueUID( uid ) )
                {
                    uid = uuidv1() ;
                }

                sql.query( 'INSERT INTO user (email, passwordHash, userType, uid) VALUES (?, ?, ?, ?);',
                           [ email, passwordHash, userType, uid ],
                    function( err, results, fields )
                    {
                        if ( err )
                            throw err ;

                        res.send( "Successfully inserted user into database." ) ;
                    } ) ;
            }
        }
    }
} ;