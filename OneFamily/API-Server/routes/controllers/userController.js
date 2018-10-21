var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
{
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

                try
                {
                    sql.query( 'INSERT INTO user (email, passwordHash, userType, uid) VALUES (?, ?, ?, ?);',
                        [ email, passwordHash, userType, uid ],
                        function( err )
                        {
                            if ( err )
                                throw err ;

                            res.status( 200 ).send(
                                {
                                    "msg": "Successfully inserted user into database."
                                } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    //Server error
                    res.status( 500 ).send(
                        {
                            "msg": "Could not add user into database!"
                        } ) ;
                }
            }
        }
    },

    login : function( req, res )
    {
        if ( sql )
        {
            var email           = req.body.email ;
            var passwordHash    = req.body.passwordHash ;

            if ( email && passwordHash )
            {
                try
                {
                    sql.query( 'SELECT * FROM user WHERE email = ?',
                        [ email ],
                        function( err, results )
                        {
                            if ( err )
                                throw err ;

                            else
                            {
                                if ( results.length === 1 )
                                {
                                    if ( results[0].passwordHash === passwordHash )
                                    {
                                        res.status( 200 ).send(
                                            {
                                                "msg": "Successfully logged in as " + email
                                            } ) ;
                                    }

                                    else
                                    {
                                        res.status( 500 ).send(
                                            {
                                                "msg": "Password hashes do not match."
                                            } ) ;
                                    }
                                }

                                else
                                {
                                    res.status( 500 ).send(
                                        {
                                            "msg": "There is more than 1 user with email " + email
                                        } ) ;
                                }
                            }
                        } );
                }

                catch ( err )
                {
                    res.status( 500 ).send(
                        {
                            "msg": "Could not login: " + err
                        } ) ;
                }
            }
        }
    }
} ;