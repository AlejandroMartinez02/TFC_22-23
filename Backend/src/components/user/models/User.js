const MONGOOSE = require('mongoose')

const UserSchema = new MONGOOSE.Schema({
    name: {
        type: String,
        require: true,
        length: 30,
        trim: true
    },
    lastname: {
        type: String,
        require: true,
        length: 60,
        trim: true
    },
    email: {
        type: String,
        require: true,
        trim: true,
        unique: true
    },
    address: {
        type: String,
        require: true,
        trim: true,
        length: 80
    },
    phone_number: {
        type: String,
        require: true,
        trim: true
    },
    password: {
        type: String,
        require: true,
        select: false,
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

const User = MONGOOSE.model('Users', UserSchema)

module.exports = User