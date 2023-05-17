const SERVICE = require('../services/OrderService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const Get = async (req, res) => {
    let { id } = req.headers
    await SERVICE.Get(id)
        .then((response) => response.status == 200
            ? RESPONSE_MANAGER.RESPONSE_201(res, response)
            : RESPONSE_MANAGER.RESPONSE_404(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const GetAll = async (req, res) => {
    let userId = req.user.sub
    await SERVICE.GetAll(userId)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Create = async (req, res) => {
    let { body } = req
    body.userId = req.user.sub

    await SERVICE.Create(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Update = async (req, res) => {

}

const Delete = async (req, res) => {
    let { _id } = req.body
    await SERVICE.Delete(_id)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}


module.exports = {
    Get,
    GetAll,
    Create,
    Update,
    Delete,
}