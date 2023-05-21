const SERVICE = require('../services/DishService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetOne = async (req, res) => {
    const { id } = req.headers
    await SERVICE.GetOne(id)
        .then(response => response.status == 201
            ? RESPONSE_MANAGER.RESPONSE_201(res, response.data)
            : RESPONSE_MANAGER.RESPONSE_404(res)
        )
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const GetAll = async (req, res) => {
    await SERVICE.GetAll()
        .then(response => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res)
        )
}

const GetByCategory = async (req, res) => {
    let { category } = req.headers

    await SERVICE.GetByCategory(category)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const Create = async (req, res) => {
    if (req.user.rol != "Admin") return RESPONSE_MANAGER.RESPONSE_403(res)

    const { body } = req
    delete body._id
    console.log(body)
    await SERVICE.Create(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(error)
        })
}


const Update = async (req, res) => {

    if (req.user.rol != "Admin") return RESPONSE_MANAGER.RESPONSE_403(res)
    const { body } = req
    await SERVICE.Update(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_404(res)
            console.log(error)
        })
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
    GetByCategory,
    Create,
    Update,
    Delete
}