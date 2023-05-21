const SERVICE = require('../services/WorkerService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetById = async (req, res) => {
    let { sub } = req.user
    await SERVICE.GetById(sub)
        .then((response) => response.status == 201
            ? RESPONSE_MANAGER.RESPONSE_201(res, response.data)
            : RESPONSE_MANAGER.RESPONSE_404(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const GetAll = async (req, res) => {
    let { user } = req
    if (user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)

    await SERVICE.GetAll(user.sub)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Create = async (req, res) => {
    let { user } = req
    if (user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)

    let worker = req.body

    await SERVICE.Create(worker)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}


const Update = async (req, res) => {
    let { user } = req
    if (user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)

    let worker = req.body
    await SERVICE.Update(worker)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Delete = async (req, res) => {
    let { user } = req
    if (user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_401(res)

    let { _id } = req.body
    await SERVICE.Delete(_id)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}


module.exports = {
    GetById,
    GetAll,
    Create,
    Update,
    Delete
}