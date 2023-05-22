const ORDER = require('../models/Order')
const ORDER_LINE = require('../models/OrderLine')

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

const Update = async (order) => {
    await ORDER.updateOne(order)
}

const Delete = async (id) => {
    let order = await ORDER.findById(id)
    for (let i = 0; i < order.order_lines.length; i++) {
        await ORDER_LINE.findByIdAndDelete(order.order_lines[i]._id)
    }
    await ORDER.findByIdAndDelete(id)
}

const DeleteByDish = async (id) => {
    await ORDER_LINE.deleteOne({ product: { _id: id } })
}


module.exports = {
    Get,
    GetAll,
    Create,
    Update,
    Delete,
    DeleteByDish
}