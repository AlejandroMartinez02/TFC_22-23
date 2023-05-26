const ORDER = require('../models/Order')
const ORDER_LINE = require('../models/OrderLine')
const DISH = require('../../dish/models/Dish')
const TABLE_SERVICE = require('../../table/services/TableService')

const Get = async (id) => {
    let order = await ORDER.findById(id)
    return order != null ? { status: 200, data: order } : { status: 400 }
}

const GetAll = async (userId) => {
    return await ORDER.find({ userId: userId }).populate({ path: "order_lines", populate: { path: 'product' } })
}

const GetAllOrders = async () => {
    return await ORDER.find().populate({ path: "order_lines", populate: { path: 'product' } })
}

const LessSold = async (numOrders) => {
    return await GetAgregation(numOrders, 1)
}

const BestSelling = async (numOrders) => {
    return await GetAgregation(numOrders, -1)
}

const GetAgregation = async (numOrders, sort) => {
    let count = await ORDER.aggregate([
        {
            $sort: {
                'date': -1
            }
        },
        {
            $limit: numOrders
        },

        {
            $lookup: {
                from: 'orderlines',
                localField: 'order_lines',
                foreignField: '_id',
                as: 'order_lines'
            }
        },
        {
            $unwind: "$order_lines"
        },
        {
            $group: {
                _id: "$order_lines.product",
                count: { $sum: "$order_lines.count" }

            }
        },
        {
            $sort: {
                count: sort
            }
        },
        {
            $limit: 5
        }


    ])
    return await DISH.populate(count, {
        path: "_id", populate: {
            path: 'category'
        }
    })
}


const Create = async (order) => {
    if (order.date == null) order.date = Date.now()
    for (let i = 0; i < order.order_lines.length; i++) {
        let order_line = await new ORDER_LINE(order.order_lines[i]).save()
        order.order_lines[i] = order_line;
    }
    if (order.table != undefined) {
        await TABLE_SERVICE.Update(order.table)
    }
    return await new ORDER(order).save()
}

const Update = async (order) => {
    if (order.state == 'Finalizado') {
        TABLE_SERVICE.Update(order.table)
    }
    await ORDER.findByIdAndUpdate({ _id: order._id }, order)
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
    GetAllOrders,
    BestSelling,
    LessSold,
    Create,
    Update,
    Delete,
    DeleteByDish
}