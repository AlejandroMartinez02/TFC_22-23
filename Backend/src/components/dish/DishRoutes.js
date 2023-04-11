const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('../dish/controllers/DishController')
const VALIDATOR = require('../../middlewares/validations/dishValidations')

ROUTER
    .get('/', AUTH, CONTROLLER.GetOne)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .post('/', AUTH, VALIDATOR, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATOR, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER