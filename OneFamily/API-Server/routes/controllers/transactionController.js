var sql = require( '../../db' ) ;

const uuidv1 = require( 'uuid/v1' ) ;

module.exports =
    {

        checkStatus : function( req, res )
        {
            res.send( "Endpoint is good!" ) ;
        },

        createTransaction : function( req, res )
        {
            if ( sql ) 
            {
                var tid                 = null; //generate later
                var cid                 = req.body.uid ;
                var transaction_type;   = req.body.transaction_type ;
                var transaction_amount  = req.body.transaction_amount ;
                var desc                = req.body.desc ;
                var trans_date          = req.body.trans_date ; //may need to eventually call the system date just depends on how we wanna go about it 
                var approved            = null;
                //verify parameters
                if ( cid && transaction_type && desc && transaction_amount && trans_date)
                {
                    //Generate TID
                    tid = uuidv1() ;

                    try
                    {
                        //probably will not work because of approved
                        sql.query( 'INSERT INTO transaction (tid, cid, transaction_type, transaction_amount, desc, trans_date, approved) VALUES (?, ?, ?, ?, ?, ?, ?);',
                            [tid, cid, transaction_type, transaction_amount, desc, trans_date, approved],

                            function( err,return,fields )
                            {
                                if( err )
                                    throw err;

                                res.send(
                                {
                                    "code":200,
                                    "msg":"Sucessfully inserted transaction into database." 
                                    
                                } ) ;
                            } ) ;
                    }

                    catch (err)
                    {

                        res.status(500).send(
                        {
                             "msg": "Could not add user into database!"
                        }

                            ) ;
                    }
                 }
            }
        },

        getTransactionsByDependent: function( req, res)
        {
            if ( sql )
            {
                var cid = req.body.cid ;

                if ( cid )
                {
                    try 
                    {
                        sql.query ( )

                    }
                }




            }

        },

        getTransactionsByDateRange: function (req, res)
        {

            var cid = req.body.cid ;
            var start_date =req.body.start_date;
            var end_date = req.body.end_date;

        }

    } ;