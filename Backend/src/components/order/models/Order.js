const MONGOOSE = require('mongoose')

let orderSchema = new MONGOOSE.Schema({
    date: {
        type: Date,
        required: true,
        default: Date.now()
    },
    total_cost: {
        type: Number,
        required: true,
    },
    userId: {
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    order_lines: [{
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'OrderLine'
    }],
    state: {
        type: String,
        enum: ['En espera', 'En proceso', 'Entregando', 'Finalizado'],
        default: 'En espera'
    }
})

let Order = MONGOOSE.model('Order', orderSchema)

module.exports = Order