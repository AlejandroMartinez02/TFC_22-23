const SERVICE = require('../services/UserService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetOne = async (req, res) => {
    let id = req.headers.id == undefined ? req.user.sub : req.headers.id

    await SERVICE.GetOne(id)
        .then((response) => {
            response.status == 200 ? RESPONSE_MANAGER.RESPONSE_201(res, response.data) : RESPONSE_MANAGER.RESPONSE_404(res)
        })
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const GetAll = async (req, res) => {
    const { user } = req

    if (user.rol != "Admin") return RESPONSE_MANAGER.RESPONSE_403(res)

    await SERVICE.GetAll().
        then(users => {
            users.length != 0 ? RESPONSE_MANAGER.RESPONSE_201(res, users) : RESPONSE_MANAGER.RESPONSE_404(res)
        })
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Create = async (req, res) => {
    if (user.rol != "Admin") return RESPONSE_MANAGER.RESPONSE_403(res)

    const { body } = req
    await SERVICE.Create(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}


const Update = async (req, res) => {
    const { body } = req
    console.log(body)
    console.log(req.user)
    if (req.user.sub == body._id || req.user.rol == 'Admin') {
        await SERVICE.Update(body)
            .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
            .catch(() => RESPONSE_MANAGER.RESPONSE_404(res))
    } else {
        return RESPONSE_MANAGER.RESPONSE_403(res)
    }

}


const Delete = async (req, res) => {
    if (req.user.rol != "Admin") return RESPONSE_MANAGER.RESPONSE_403(res)

    const { _id } = req.body
    await SERVICE.Delete(_id)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_404(res))

}


module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}