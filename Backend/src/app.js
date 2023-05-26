const mongoose = require('mongoose')
const express = require('express')
const bodyParser = require('body-parser')
const dotenv = require('dotenv')
dotenv.config()

var app = express()
const server = require('http').createServer(app)
module.exports = require('socket.io')(server)
server.listen(3000)

require('../src/services/sockets/Socket')

let userRouter = require('./components/user/UserRoutes')
let workersRoutes = require('./components/worker/WorkerRoutes')
let dishesRoutes = require('./components/dish/DishRoutes')
let categoryRoutes = require('./components/category/CategoryRoutes')
let securityRoutes = require('./components/security/SecurityRoutes')
let orderRoutes = require('./components/order/OrdersRoutes')
let tableRoutes = require('./components/table/TableRouter')

mongoose.set('strictQuery', true)
mongoose.connect(process.env.MONGO_URI)
    .then(() => console.log("contected to mongodb"))
    .catch(() => console.log("Error connecting"))


app.use(bodyParser.json({ limit: '50mb' }))
app.use(bodyParser.urlencoded({
    limit: '500mb',
    extended: true,
}))

app.use('/api/users', userRouter)
    .use('/api/workers', workersRoutes)
    .use('/api/dishes', dishesRoutes)
    .use('/api/categories', categoryRoutes)
    .use('/api/orders', orderRoutes)
    .use('/api/', securityRoutes)
    .use('/api/tables', tableRoutes)


app.listen(process.env.PORT, function () {
    console.log('Http server running on port ' + process.env.PORT)
})

