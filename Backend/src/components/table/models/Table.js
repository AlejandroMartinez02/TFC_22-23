const MONGOOSE = require('mongoose')

let tableSchema = new MONGOOSE.Schema({
    tableNumber: {
        type: Number,
        required: true
    },
    isInUse: {
        type: Boolean,
        required: true
    }
})

let Table = MONGOOSE.model('Table', tableSchema)

module.exports = Table