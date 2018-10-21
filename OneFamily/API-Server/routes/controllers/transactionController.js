let sql = require( '../../db' ) ;
let uuidv1 = require( 'uuid/v1' ) ;
let moment = require( 'moment' ) ;

module.exports =
{
    createTransaction : function( req, res )
    {
        if ( sql )
        {
            let tid                 = null ; //generate later

            let cid                 = req.body.cid ;
            let transactionType     = req.body.transactionType ;
            let transactionAmount   = req.body.transactionAmount ;
            let desc                = req.body.desc ;
            let transDate           = req.body.transDate ;

            let pending             = true ;

            //verify parameters
            if ( cid && transactionType && desc && transactionAmount && transDate )
            {
                //Generate TID
                tid = uuidv1() ;

                try
                {
                    sql.query( 'INSERT INTO transaction (tid, cid, transactionType, transactionAmount, desc, transDate, pending) VALUES (?, ?, ?, ?, ?, ?, ?)',
                        [ tid, cid, transactionType, transactionAmount, desc, transDate, pending ],
                        function ( err )
                        {
                            if ( err )
                                throw err ;

                            res.status( 200 ).send(
                            {
                                "msg": "Successfully inserted transaction into database."
                            } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    res.status( 500 ).send(
                    {
                         "msg": "Could not add pending transaction into database!"
                    } ) ;
                }
             }
        }
    },

    getTransactionsByDependent : function( req, res )
    {
        if ( sql )
        {
            let cid = req.body.cid ;

            if ( cid )
            {
                try
                {
                    sql.query( 'SELECT * FROM transaction WHERE cid = ?', [cid],
                        function( err, results )
                        {
                            res.status( 200 ).send(
                            {
                                "msg": "Successfully retrieved transaction via cid: " + cid,
                                "transactions": results
                            } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    res.status( 500 ).send(
                    {
                        "msg": "Could not retrieve transactions via cid: " + cid
                    } ) ;
                }
            }
        }
    },

    getTransactionsByDateRange : function( req, res )
    {
        if ( sql )
        {
            let cid         = req.body.cid ;
            let startDate   = moment( req.body.startDate ).format() ; //ISO 8601
            let endDate     = moment( req.body.endDate ).format() ; //ISO 8601

            if ( cid && startDate && endDate )
            {
                try
                {
                    sql.query( 'SELECT * FROM transaction WHERE cid = ?', [cid],
                        function( err, results )
                        {
                            let between = [] ;

                            for ( let i = 0 ; i < results.length ; i++ )
                            {
                                let date = moment( results[i].transDate ).format() ;

                                if ( date.isBetween( startDate, endDate ) )
                                    between.push( results[i] ) ;
                            }

                            res.status( 200 ).send(
                            {
                                "msg": "Successfully retrieved transactions by date range.",
                                "transactions": between
                            } ) ;
                        } ) ;
                }

                catch ( err )
                {
                    res.status( 500 ).send(
                    {
                        "msg": "Could not retrieve transactions by date range!"
                    } ) ;
                }
            }
        }
    }
} ;