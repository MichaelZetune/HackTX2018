var express = require( 'express' ) ;

var router = express.Router() ;

//Controllers
var userController = require( './controllers/userController' ) ;

router.route( '/' ).get( userController.checkStatus ) ;

router.route( '/createUser' ).post( userController.createUser ) ;
router.route( '/login' ).post( userController.login ) ;

module.exports = router ;