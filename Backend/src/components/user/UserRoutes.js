const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/UserController')
const VALIDATIONS = require('../../middlewares/validations/UserValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')


ROUTER
    .get('/', AUTH, CONTROLLER.GetOne)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, VALIDATIONS.SIGNUPCHECK(), CHECKERRORS, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATIONS.UPDATEUSERCHECK(), CHECKERRORS, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER