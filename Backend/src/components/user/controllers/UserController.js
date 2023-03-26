const SERVICE = require('../services/UserService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')

const GetById = (req, res) =>
{

}

const GetAll = (req, res) =>
{

}

const Create = async (req, res) =>
{
    const { body } = req
    await SERVICE.Create(body)
        .then((response) =>
        {
            response.status == 200 ? RESPONSE_MANAGER.RESPONSE_TOKEN(res, response) : RESPONSE_MANAGER.RESPONSE_401(res)
        })
        .catch(() =>
        {
            RESPONSE_MANAGER.RESPONSE_500(res)
        })
}


const Update = (req, res) =>
{

}

const Delete = (req, res) =>
{

}


module.exports = {
    GetById,
    GetAll,
    Create,
    Update,
    Delete
}