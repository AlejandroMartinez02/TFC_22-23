const { check } = require('express-validator');
const DISH = require('../../components/dish/models/Dish')

const CRUD_DISH = () => {
    return [
        check('name')
            .trim()
            .notEmpty()
            .custom(async (name) => {
                if (await DISH.find({ name: name }).length == 0) throw new Error()
            }),

        check('ingredients')
            .notEmpty(),

        check('category')
            .notEmpty()
            .isMongoId(),

        check('cost')
            .notEmpty(),

        check('description')
            .notEmpty()
    ]
}



module.exports = CRUD_DISH

