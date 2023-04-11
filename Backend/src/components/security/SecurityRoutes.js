const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('./controllers/SecurityController')
const VALIDATIONS = require('../../middlewares/validations/userValidations')


ROUTER
    .post('/login', CONTROLLER.Login)
    .post('/register', VALIDATIONS.SIGNUPCHECK, CONTROLLER.Register)


module.exports = ROUTER