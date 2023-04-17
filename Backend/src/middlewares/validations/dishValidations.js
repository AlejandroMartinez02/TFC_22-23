const { check } = require('express-validator');
const DISH = require('../../components/dish/models/Dish')

const CRUD_DISH = () =>
{
    return [
        check('name')
            .trim()
            .notEmpty()
            .isAlpha('es-ES', { ignore: ' ' })
            .custom(async (name) =>
            {
                if (await DISH.find({ name: name }).length == 0) throw new Error()
            }),

        check('ingredients')
            .notEmpty(),

        check('category')
            .notEmpty()
            .matches(/Entrantes|Para compartir|Bocatas|Hamburguesas|Postre|Bebida/g),

        check('cost')
            .notEmpty()
            .isNumeric()
            .isLength({ min: 2, max: 5 }),

        check('photo')
            .notEmpty(),

        check('description')
            .notEmpty()
    ]
}



module.exports = CRUD_DISH

