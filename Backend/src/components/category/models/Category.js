const MONGOOSE = require('mongoose')

const CategorySchema = new MONGOOSE.Schema({
    name: {
        type: String,
        trim: true,
        required: true,
        unique: true,
    },
    description: {
        type: String,
        length: 120,
        required: true
    },
    photo: String
})

const CATEGORY = MONGOOSE.model('Categories', CategorySchema)

module.exports = CATEGORY
