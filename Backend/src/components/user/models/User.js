const mongoose = require('mongoose')

const UserSchema = new mongoose.Schema({
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
        trim: true,
        length: 80
    },
    phone_number: {
        type: String,
        require: true,
        trim: true
    },
    rol: {
        type: String,
        require: true,
        enum: ['User', 'Admin', 'Chef', 'Waiter']
    },
    paymentCard: {
        type: mongoose.Schema.ObjectId,
        ref: "PaymentCard"
    },
    password: {
        type: String,
        require: true
    }
})

const User = mongoose.model('Users', UserSchema)

module.exports = User