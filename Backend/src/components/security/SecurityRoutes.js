const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('./controllers/SecurityController')
const VALIDATIONS = require('../../middlewares/validations/UserValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')


ROUTER
    .get('/checktoken', CONTROLLER.Check)
    .post('/login', CONTROLLER.Login)
    .post('/workerlogin', CONTROLLER.WorkerLogin)
    .post('/register', VALIDATIONS.SIGNUPCHECK(), CHECKERRORS, CONTROLLER.Register)
    .patch('/changepassword', AUTH, CONTROLLER.ChangePassword)


module.exports = ROUTER