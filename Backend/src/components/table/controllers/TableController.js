const SERVICE = require('../services/TableService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetAll = async (req, res) => {
    if (req.user.rol == undefined) return RESPONSE_MANAGER.RESPONSE_401(res)
    await SERVICE.GetAll()
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Create = async (req, res) => {
    if (req.user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)
    let { body } = req
    delete body._id
    await SERVICE.Create(body)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(error)
        })
}

const Update = async (req, res) => {
    if (req.user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)
    let { body } = req
    await SERVICE.Update(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Delete = async (req, res) => {
    if (req.user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_403(res)

    let { _id } = req.body
    await SERVICE.Delete(_id)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch((response) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(response)
        })
}

module.exports = {
    GetAll,
    Create,
    Update,
    Delete
}