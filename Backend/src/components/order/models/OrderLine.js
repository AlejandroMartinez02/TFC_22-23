const MONGOOSE = require('mongoose')

let orderLineSchema = MONGOOSE.Schema({
    cost: {
        type: Number,
        required: true
    },
    count: {
        type: Number,
        required: true
    },
    product: {
        type: MONGOOSE.Types.ObjectId,
        ref: 'Product',
        required: true
    }
})
let OrderLine = new MONGOOSE.model('OrderLine', orderLineSchema)

module.exports = OrderLine