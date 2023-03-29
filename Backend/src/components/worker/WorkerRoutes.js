const EXPRESS = require('express')
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('../worker/controllers/WorkerController')

ROUTER
    .get('/', AUTH, CONTROLLER.GetById)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, CONTROLLER.Create)
    .patch('/', AUTH, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER