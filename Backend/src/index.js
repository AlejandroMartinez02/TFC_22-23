const path = require('path');
const mongoose = require('mongoose');
const express = require('express');
const fs = require('fs');
const bodyParser = require('body-parser');
const dotenv = require('dotenv');
dotenv.config();

let userRouter = require('./components/user/UserRoutes');
let workersRoutes = require('./components/worker/WorkerRoutes');
let dishesRoutes = require('./components/dish/DishRoutes.js');

mongoose.set('strictQuery', true);
mongoose.connect(process.env.MONGO_URI)

var app = express();
app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({
    limit: '500mb',
    extended: true,
}));

app.use('/api/users', userRouter);
app.use('/api/workers', workersRoutes);
app.use('/api/dishes', dishesRoutes);


app.listen(8080, function ()
{
    console.log('Http server running on port 8080');
});
