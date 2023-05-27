const EXPRESS = require('express')
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('../worker/controllers/WorkerController')
const VALIDATOR = require('../../middlewares/validations/WorkerValidation')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')

ROUTER
    .get('/', AUTH, CONTROLLER.GetById)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, VALIDATOR.CREATE_WORKER(), CHECKERRORS, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATOR.UPDATE_WORKER(), CHECKERRORS, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER