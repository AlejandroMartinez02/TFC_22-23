const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('./controllers/SecurityController')
const VALIDATIONS = require('../../middlewares/validations/userValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')


ROUTER
    .post('/login', CONTROLLER.Login)
    .post('/register', VALIDATIONS.SIGNUPCHECK(), CHECKERRORS, CONTROLLER.Register)


module.exports = ROUTER