var express = require( 'express' ) ;

var router = express.Router() ;

//Controllers
var userController = require( './controllers/userController' ) ;

router.route( '/createUser' ).post( userController.createUser ) ;

router.route( '/' ).get( userController.checkStatus ) ;

module.exports = router ;