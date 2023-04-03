const MONGOOSE = require('mongoose')

let dishSchema = new MONGOOSE.Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    ingredients: {
        type: String,
        required: true,
    },
    category: {
        type: String,
        enum: ['Starter', 'Main', 'Dessert', 'Drink'],
        required: true
    },
    cost: {
        type: Number,
        required: true,
    },
    photo: {
        type: String,
        required: true,
    },
    description: {
        type: String,

    }

})

let Dish = MONGOOSE.model('Dish', dishSchema)
module.exports = Dish