const { check } = require('express-validator')
const CATEGORY = require('../../components/category/models/Category')

const CreateCategory = () => {
    return [
        check('name')
            .trim()
            .notEmpty()
            .custom(async (name) => {
                if (await CATEGORY.find({ name: name }).length == 0) throw new Error()
            }),
        check('description')
            .notEmpty()
            .isLength({ max: 120 }),
        check('photo')
    ]
}

const UpdateCategory = () => {
    return [
        check('name')
            .trim()
            .notEmpty()
            .custom(async (name) => {
                if (await CATEGORY.find({ name: name }).length == 0) throw new Error()
            }),
        check('description')
            .notEmpty()
            .isLength({ max: 120 }),
    ]
}

module.exports = {
    CreateCategory,
    UpdateCategory,
}