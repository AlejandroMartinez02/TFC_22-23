const SERVICE = require('../services/TableService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetAll = async (req, res) => {
    if (req.user.rol == undefined) return RESPONSE_MANAGER.RESPONSE_401(res)
    await SERVICE.GetAll()
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

module.exports = GetAll