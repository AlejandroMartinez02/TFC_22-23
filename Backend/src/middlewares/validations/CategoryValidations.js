const { check } = require('express-validator')
const CATEGORY = require('../../components/category/models/Category')

const CategoryValidator = () => {
    return [
        check('name')
            .trim()
            .notEmpty()
            .custom(async (name) => {
                if (await CATEGORY.find({ name: name }).length == 0) throw new Error()
            }),
        check('description')
            .notEmpty()
            .isLength({ max: 120 })
    ]
}


module.exports = CategoryValidator
