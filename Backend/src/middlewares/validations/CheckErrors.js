const { validationResult } = require('express-validator');
const RESPONSE_MANAGER = require('../../services/response/ResponseManager')

const checkErrors = (req, res, next) =>
{
    let errors = validationResult(req)
    if (!errors.isEmpty())
    {
        console.log(errors)
        return RESPONSE_MANAGER.RESPONSE_404(res)
    }
    return next();
}

module.exports = checkErrors