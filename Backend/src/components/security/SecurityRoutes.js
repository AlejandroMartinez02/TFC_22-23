const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('./controllers/SecurityController')

ROUTER
    .post('/login', CONTROLLER.Login)
    .post('/register', CONTROLLER.Register)


module.exports = ROUTER