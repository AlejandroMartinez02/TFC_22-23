const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/TableController')
const VALIDATOR = require('../../middlewares/validations/TableValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')

ROUTER
    .get('/', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, VALIDATOR(), CHECKERRORS, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATOR(), CHECKERRORS, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)


module.exports = ROUTER