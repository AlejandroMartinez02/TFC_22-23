const SERVICE = require('../../services/security/Security')
const RESPONSE_MANAGER = require('../../services/response/ResponseManager')

function isAuth(req, res, next) {
    if (!req.headers.authorization) {
        return RESPONSE_MANAGER.RESPONSE_401(res)
    }
    const token = req.headers.authorization.split(" ")[1]
    SERVICE.decodeToken(token)
        .then(response => {
            req.user = response;
            next();
        })
        .catch(() => RESPONSE_MANAGER.RESPONSE_401(res))
}

module.exports = isAuth