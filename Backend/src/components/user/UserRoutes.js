const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/UserController')

ROUTER
    .get('/GetOne', AUTH, CONTROLLER.GetById)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, CONTROLLER.Create)
    .patch('/', AUTH, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER