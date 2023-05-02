const MONGOOSE = require('mongoose')

let OrderLineSchema = new MONGOOSE.Schema({
    product: {
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'Dish',
        required: true
    },

    count: {
        type: Number,
        required: true
    },
    cost: {
        type: Number,
        required: true
    },
})

let OrderLine = MONGOOSE.model('OrderLine', OrderLineSchema)

module.exports = OrderLine;