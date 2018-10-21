var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
    {
        checkStatus : function( req, res )
        {
            res.send( "Endpoint is good!" ) ;
        },

        getAllowanceInfoForDependent: function (req, res)
        {

        },

        createDependent: function (req, res)
        {
            if ( sql )
            {
                var cid = uuidv1();
                var pid = req.body.pid;
                var uid = req.body.uid;
                var balance = req.body.balance;
                var allowanceAmount = req.body.allowanceAmount;
                var creationDate = req.body.creationDate;
                var allowanceActive = req.body.allowanceActive;
                var allowanceStartDate = req.body.allowanceStateDate;
                var allowanceType = req.body.allowanceType;
                var nowActive = req.body.nowActive;



                // just verifying one parameter here
                if ( pid )
                {
                    try
                    {
                        sql.query( 'INSERT INTO dependent (cid, pid, uid, balance, allowance_amount, creation_date,' +
                            'allowance_active, allowance_startdate, allowance_type, nowactive) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);',
                            [ cid, pid, uid, balance, allowanceAmount, creationDate, allowanceActive, allowanceStartDate, allowanceType, nowActive ],
                            function( err, results, fields )
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