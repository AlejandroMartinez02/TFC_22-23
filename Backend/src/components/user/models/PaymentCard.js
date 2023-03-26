const mongoose = require('mongoose')

paymentCardSchema = new mongoose.Schema({
    number: {
        type: String,
        required: true,
        length: 19
    },
    cvv: {
        type: Number,
        length: 4,
        required: true,
        trim: true
    },
    expiration_date: {
        type: String,
        required: true,
        length: 5,
        trim: true,
    },
    name: {
        type: String,
        length: 80,
        required: true,
    }
})

const PaymentCard = mongoose.model('PaymentCard', paymentCardSchema)

module.exports = PaymentCard