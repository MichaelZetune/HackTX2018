var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
{
    checkStatus : function( req, res )
    {
        res.send( "Endpoint is good!" ) ;
    },

    createParent : function( req, res )
    {
        if ( sql )
        {
            var balance = req.body.balance;
            var uid = req.body.uid;
            var pid     = uuidv1() ;

            //Verify parameters
            if ( balance && uid && pid )
            {
                try
                {
                    sql.query( 'INSERT INTO parent (pid, uid, balance) VALUES (?, ?, ?);',
                        [ pid, uid, balance ],
                        function( err, results, fields )
                        {
                            if ( err )
                                throw err ;

                            res.send(
                                {
                                    "code": 200,
                                    "msg": "Successfully inserted parent into database."
                                } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    //Server error
                    res.status( 500 ).send(
                        {
                            "msg": "Could not add parent into database!"
                        } ) ;
                }
            }
        }
    },

} ;