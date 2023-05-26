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

const GetAllOrders = async (req, res) => {
    if (req.user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_403(res)
    await SERVICE.GetAllOrders()
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch((error) => {
            console.log(error)
            RESPONSE_MANAGER.RESPONSE_500(res)
        })
}

const LessSold = async (req, res) => {
    let numOrders = parseInt(req.headers.numorders)

    await SERVICE.LessSold(numOrders)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(error)
        })
}

const BestSelling = async (req, res) => {
    let numOrders = parseInt(req.headers.numorders)
    if (req.user.rol != 'Admin') return RESPONSE_MANAGER.RESPONSE_403(res)
    await SERVICE.BestSelling(numOrders)
        .then((response) => RESPONSE_MANAGER.RESPONSE_201(res, response))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(error)
        })
}

const Create = async (req, res) => {
    let { body } = req
    console.log(req.user)
    if (req.user.rol != undefined) {
        body.workerId = req.user.sub
        delete body.userId
    } else {
        body.userId = req.user.sub
    }
    if (body.table == null) delete body.table

    console.log(body)

    await SERVICE.Create(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch((error) => {
            RESPONSE_MANAGER.RESPONSE_500(res)
            console.log(error);
        })
}

const Update = async (req, res) => {
    let { body } = req
    await SERVICE.Update(body)
        .then(() => RESPONSE_MANAGER.RESPONSE_200(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res)
        )
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
    GetAllOrders,
    LessSold,
    BestSelling,
    Create,
    Update,
    Delete,
}