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

        }
    } ;