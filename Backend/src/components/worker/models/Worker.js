const MONGOOSE = require('mongoose')

const workerSchema = new MONGOOSE.Schema({
    name: {
        type: String,
        require: true,
        trim: true
    },
    lastname: {
        type: String,
        require: true,
        trim: true
    },
    email: {
        type: String,
        require: true,
        unique: true,
        trim: true
    },
    phone: {
        type: String,
        unique: true,
        require: true,
        trim: true
    },
    password: {
        type: String,
        require: true,
        trim: true,
        select: false
    },
    maritalStatus: {
        type: String,
        require: true,
        trim: true
    },
    salary: {
        type: Number,
        require: true,
    },
    age: {
        type: String,
        require: true,
    },
    role: {
        type: String,
        require: true,
        enum: ["Admin", "Waiter", "Chef"]
    },
    login_attempts: {
        type: Number,
        required: true,
        select: false,
        default: 0
    },
    lock_until: {
        type: Number,
        select: false,
    }
})
const Worker = MONGOOSE.model('Worker', workerSchema)

module.exports = Worker