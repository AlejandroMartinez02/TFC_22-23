const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/UserController')
const VALIDATIONS = require('../../middlewares/validations/userValidations')

ROUTER
    .get('/', AUTH, CONTROLLER.GetById)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, VALIDATIONS.SIGNUPCHECK, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATIONS.UPDATEUSERCHECK, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER