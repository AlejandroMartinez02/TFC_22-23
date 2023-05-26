const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/TableController')

ROUTER
    .get('/', AUTH, CONTROLLER)


module.exports = ROUTER