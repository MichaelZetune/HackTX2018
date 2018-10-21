var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
{
    getAllowanceInfoForDependent: function ( req, res )
    {
        if ( sql )
        {
            var cid = req.body.cid ;

            if ( cid )
            {
                try
                {
                    sql.query( 'SELECT * FROM dependent WHERE cid = ?', [ cid ],
                        function( err, results )
                        {
                            if ( err )
                                throw err ;

                            else
                            {
                                if ( results.length === 1 )
                                {
                                    let dependent = results[0] ;

                                    res.status( 200 ).send(
                                        {
                                            "msg": "Successfully retrieved allowance info for dependent: " + cid,
                                            "allowanceInfo":
                                                {
                                                    "allowanceAmount":      dependent.allowanceAmount,
                                                    "allowanceActive":      dependent.allowanceActive,
                                                    "allowanceStartDate":   dependent.allowanceStartDate,
                                                    "allowanceType":        dependent.allowanceType
                                                }
                                        } ) ;
                                }

                                else
                                {
                                    res.status( 500 ).send(
                                    {
                                        "msg": "There is more than one dependent with cid: " + cid
                                    } ) ;
                                }
                            }
                        } ) ;
                }

                catch ( err )
                {
                }
            }
        }
    },

    createDependent: function ( req, res )
    {
        if ( sql )
        {
            var cid = uuidv1() ; //child id

            var pid                 = req.body.pid ; //parent id that dependent will be tied to
            var uid                 = req.body.uid ;
            var balance             = req.body.balance ;
            var allowanceAmount     = req.body.allowanceAmount ;
            var creationDate        = req.body.creationDate ;
            var allowanceActive     = req.body.allowanceActive ;
            var allowanceStartDate  = req.body.allowanceStateDate ;
            var allowanceType       = req.body.allowanceType ;
            var nowActive           = req.body.nowActive ;

            if ( cid && pid && uid && balance && allowanceAmount &&
                 creationDate && allowanceActive &&
                 allowanceStartDate && allowanceType && nowActive )
            {
                try
                {
                    sql.query( 'INSERT INTO dependent ( cid, pid, uid, balance, allowance_amount, creation_date,' +
                        'allowance_active, allowance_startdate, allowance_type, nowactive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                        [ cid, pid, uid, balance, allowanceAmount, creationDate, allowanceActive, allowanceStartDate, allowanceType, nowActive ],
                        function( err )
                        {
                            if ( err )
                                throw err ;

                            res.send(
                                {
                                    "code": 200,
                                    "msg": "Successfully inserted dependent into database."
                                } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    //Server error
                    res.status( 500 ).send(
                        {
                            "msg": "Could not add dependent into database!"
                        } ) ;
                }
            }
        }
    }
} ;