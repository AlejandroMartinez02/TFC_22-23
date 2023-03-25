const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const CONTROLLER = require('../dish/controllers/DishController')

ROUTER
    .get('/', CONTROLLER.GetById)
    .get('/all', CONTROLLER.GetAll)
    .post('/', CONTROLLER.Create)
    .patch('/', CONTROLLER.Update)
    .delete('/', CONTROLLER.Delete)

module.exports = ROUTER