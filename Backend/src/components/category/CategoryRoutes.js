const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('../category/controllers/CategoryController')
const VALIDATION = require('../../middlewares/validations/CategoryValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')

ROUTER
    .get('/', AUTH, CONTROLLER.GetOne)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', VALIDATION(), CHECKERRORS, AUTH, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATION(), CHECKERRORS, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)


module.exports = ROUTER