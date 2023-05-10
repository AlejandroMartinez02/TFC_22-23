const ORDER = require('../models/Order')
const ORDER_LINE = require('../../order_line/models/OrderLine')

const Get = async (id) => {
    let order = await ORDER.findById(id)
    return order != null ? { status: 200, data: order } : { status: 400 }
}

const GetAll = async (userId) => {
    return await ORDER.find({ userId: userId }).populate({ path: "order_lines", populate: { path: 'product' } })
}

const Create = async (order) => {
    if (order.date == null) order.date = Date.now()
    for (let i = 0; i < order.order_lines.length; i++) {
        let order_line = await new ORDER_LINE(order.order_lines[i]).save()
        order.order_lines[i] = order_line;
    }
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