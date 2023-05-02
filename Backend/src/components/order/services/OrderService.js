const ORDER = require('../models/Order')

const Get = async (id) => {
    let order = await ORDER.findById(id)
    return order != null ? { status: 200, data: order } : { status: 400 }
}

const GetAll = async (userId) => {
    return await ORDER.find({ userId: userId })
}

const Create = async (order) => {
    return await new ORDER(order).save()
}

const Update = async () => {

}

const Delete = async () => {

}


module.exports = {
    Get,
    GetAll,
    Create,
    Update,
    Delete,
}