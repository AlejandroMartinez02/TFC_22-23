const { check } = require('express-validator');
const USER = require('../../components/user/models/User')

const SIGNUPCHECK = () =>
{
    return [
        check('name')
            .trim()
            .notEmpty()
            .isAlpha('es-ES', { ignore: ' ' }),

        check('lastname')
            .notEmpty()
            .isAlpha('es-ES', { ignore: ' ' }),

        check('email')
            .trim()
            .notEmpty()
            .isEmail()
            .custom(async (email) =>
            {
                const searchedEmail = await USER.find({ email: email });
                if (searchedEmail.length > 0)
                    throw new Error("This email is already in use")
            }),

        check('address')
            .trim()
            .isAlphanumeric('es-ES', { ignore: ' ' }),

        check('phone_number')
            .isMobilePhone('es-ES')
            .custom(async (phone) =>
            {
                const searchedPhone = await USER.find({ phone_number: phone })
                if (searchedPhone.length > 0)
                    throw new Error('This phone number is already in use')
            }),

        check('rol')
            .notEmpty()
            .matches(/User|Admin|Chef|Waiter/g),

        check('password')
            .trim()
            .notEmpty()
            .isStrongPassword()
    ]
}

const UPDATEUSERCHECK = () =>
{
    return [
        check('name')
            .trim()
            .notEmpty()
            .isAlpha('es-ES', { ignore: ' ' }),

        check('lastname')
            .notEmpty()
            .isAlpha('es-ES', { ignore: ' ' }),

        check('email')
            .trim()
            .isEmail()
            .notEmpty()
            .custom(async (email) =>
            {
                const searchedEmail = await USER.find({ email: email });
                if (searchedEmail.length > 0)
                    throw new Error("This email is already in use")
            }),

        check('address')
            .trim()
            .notEmpty()
            .isAlphanumeric('es-ES', { ignore: ' ' }),

        check('phone_number')
            .isMobilePhone('es-ES')
            .notEmpty()
            .custom(async (phone) =>
            {
                const searchedPhone = await USER.find({ phone_number: phone })
                if (searchedPhone.length > 0)
                    throw new Error('This phone number is already in use')
            }),

        check('rol')
            .notEmpty()
            .matches(/User|Admin|Chef|Waiter/g),
    ]
}

module.exports = {
    SIGNUPCHECK,
    UPDATEUSERCHECK
}