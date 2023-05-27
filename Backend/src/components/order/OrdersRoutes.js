const EXPRESS = require('express')
const ROUTER = EXPRESS.Router()
const AUTH = require('../../middlewares/authentication/AuthenticationMiddleware')
const CONTROLLER = require('./controllers/OrderController')

ROUTER
    .get('/', AUTH, CONTROLLER.Get)
    .get('/all', AUTH, CONTROLLER.GetAll)
    .get('/allAdmin', AUTH, CONTROLLER.GetAllOrders)
    .get('/less-sold', AUTH, CONTROLLER.LessSold)
    .get('/best-selling', AUTH, CONTROLLER.BestSelling)
    .get('/inprocess', AUTH, CONTROLLER.InProcess)
    .post('/', AUTH, CONTROLLER.Create)
    .patch('/', AUTH, CONTROLLER.Update)
    .delete('/', AUTH, CONTROLLER.Delete)

module.exports = ROUTER