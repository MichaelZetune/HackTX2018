var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
{
    createParent : function( req, res )
    {
        if ( sql )
        {
            var pid     = uuidv1() ; //parent id

            var uid     = req.body.uid ; //user id
            var balance = req.body.balance ;

            //Verify parameters
            if ( pid && uid && balance )
            {
                try
                {
                    sql.query( 'INSERT INTO parent (pid, uid, balance) VALUES (?, ?, ?);',
                        [ pid, uid, balance ],
                        function( err )
                        {
                            if ( err )
                                throw err ;

                            res.status( 200 ).send(
                                {
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