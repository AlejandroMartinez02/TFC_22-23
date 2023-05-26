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
    },
    workerId: {
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'Worker',
    },
    order_lines: [{
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'OrderLine'
    }],
    state: {
        type: String,
        enum: ['En cocina', 'Entregando', 'Finalizado'],
        default: 'En espera'
    },
    table: {
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'Table'
    }
})

let Order = MONGOOSE.model('Order', orderSchema)

module.exports = Order