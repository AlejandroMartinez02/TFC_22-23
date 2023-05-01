const mongoose = require('mongoose')
const express = require('express')
const bodyParser = require('body-parser')
const dotenv = require('dotenv')
dotenv.config()

var app = express()


const server = require('http').createServer(app)
const io = require('socket.io')(server)
io.on('connection', client => {
    client.on('event', data => { })
    client.on('disconnect', () => { })
})
server.listen(3000)

let userRouter = require('./components/user/UserRoutes')
let workersRoutes = require('./components/worker/WorkerRoutes')
let dishesRoutes = require('./components/dish/DishRoutes')
let categoryRoutes = require('./components/category/CategoryRoutes')
let securityRoutes = require('./components/security/SecurityRoutes')

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
app.use('/api/workers', workersRoutes)
app.use('/api/dishes', dishesRoutes)
app.use('/api/categories', categoryRoutes)
app.use('/api/', securityRoutes)


app.listen(process.env.PORT, function () {
    console.log('Http server running on port ' + process.env.PORT)
})

