const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('../dish/controllers/DishController')
const VALIDATOR = require('../../middlewares/validations/DishValidations')
const CHECKERRORS = require('../../middlewares/validations/CheckErrors')


ROUTER
    .get('/', AUTH, CONTROLLER.GetOne)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .get('/bycategory', AUTH, CONTROLLER.GetByCategory)
    .post('/', AUTH, VALIDATOR(), CHECKERRORS, CONTROLLER.Create)
    .patch('/', AUTH, VALIDATOR(), CHECKERRORS, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER