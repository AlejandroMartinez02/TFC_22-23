const { check } = require('express-validator');
const WORKER = require('../../components/worker/models/Worker')

const CREATE_WORKER = () => {
    return [
        check('name')
            .trim()
            .notEmpty(),

        check('lastname')
            .notEmpty(),

        check('email')
            .notEmpty()
            .custom(async (email) => {
                let worker = await WORKER.find({ email: email })
                if (worker.length > 0)
                    throw new Error("This email is already in use")
            }),

        check('phone')
            .isMobilePhone('es-ES')
            .custom(async (phone) => {
                const searchedPhone = await USER.find({ phone_number: phone })
                if (searchedPhone.length > 0)
                    throw new Error('This phone number is already in use')
            }),

        check('password')
            .notEmpty(),

        check('maritalStatus')
            .notEmpty()
            .matches(/Soltero|Casado|Emparejado|Otro/g),

        check('salary')
            .isNumeric(),

        check('age')
            .notEmpty(),

        check('role')
            .notEmpty()
            .matches(/Admin|Waiter|Chef/g)
    ]
}


const UPDATE_WORKER = () => {
    return [
        check('name')
            .trim()
            .notEmpty(),

        check('lastname')
            .notEmpty(),

        check('email')
            .notEmpty(),

        check('phone')
            .isMobilePhone('es-ES')
            .custom(async (phone) => {
                const searchedPhone = await WORKER.find({ phone: phone })
                if (searchedPhone.length > 0)
                    throw new Error('This phone number is already in use')
            }),

        check('maritalStatus')
            .notEmpty()
            .matches(/Soltero|Casado|Emparejado|Otro/g),

        check('salary')
            .isNumeric(),

        check('age')
            .notEmpty(),

        check('role')
            .notEmpty()
            .matches(/Admin|Waiter|Chef/g)
    ]
}




module.exports = {
    CREATE_WORKER,
    UPDATE_WORKER
}

