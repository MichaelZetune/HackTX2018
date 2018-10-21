var express = require( 'express' ) ;

var router = express.Router() ;

//Controllers
var userController          = require( './controllers/userController' ) ;
var parentController        = require( './controllers/parentController' ) ;
var dependentController     = require( './controllers/dependentController' ) ;
var transactionController   = require( './controllers/transactionController' ) ;

//User controller
router.route( '/user/create' ).post( userController.createUser ) ;
router.route( '/user/login' ).post( userController.login ) ;

//Parent controller
router.route( '/parent/create' ).post( parentController.createParent ) ;

//Dependent controller
router.route( '/dependent/create' ).post( dependentController.createDependent ) ;
router.route( '/dependent/allowanceInfo' ).get( dependentController.getAllowanceInfoForDependent ) ;

//Transaction controller
router.route( '/transaction/create' ).post( transactionController.createTransaction ) ;
router.route( '/transaction/transactionsByDependent' ).get( transactionController.getTransactionsByDependent ) ;
router.route( '/transaction/transactionsByDateRange' ).get( transactionController.getTransactionsByDateRange ) ;

module.exports = router ;