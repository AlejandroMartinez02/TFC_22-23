const MONGOOSE = require('mongoose')

let dishSchema = new MONGOOSE.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
        unique: true
    },
    ingredients: {
        type: String,
        required: true,
    },
    category: {
        type: MONGOOSE.Schema.Types.ObjectId,
        ref: 'Category',
        required: true
    },
    cost: {
        type: Number,
        required: true,
    },
    photo: {
        type: String,
    },
    description: {
        type: String,
    }

})

let Dish = MONGOOSE.model('Dish', dishSchema)
module.exports = Dish