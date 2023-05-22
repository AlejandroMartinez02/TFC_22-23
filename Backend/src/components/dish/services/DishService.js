const DISH = require('../models/Dish')
const ORDER_SERVICE = require('../../order/services/OrderService')

const GetOne = async (id) => {
    let dish = await DISH.findOne({ _id: id }).populate("category")

    return dish != null ? { status: 201, data: dish } : { status: 404 }
}

const GetAll = async () => {
    return await DISH.find().populate("category")
}

const GetByCategory = async (category) => {
    return (await DISH.find().populate({ path: "category", match: { name: category } })).filter((product) => {
        if (product.category == null) return;
        if (product.category.name.toLowerCase == category.toLowerCase) return product
    })
}

const Create = async (dish) => {
    await new DISH(dish).save()
}


const Update = async (dish) => {
    if (await DISH.findOne({ _id: dish._id }) == null) throw new Error()
    await DISH.findByIdAndUpdate({ _id: dish._id }, dish)
}

const Delete = async (id) => {
    if (await DISH.findOne({ _id: id }) == null) throw new Error()
    await DISH.findByIdAndDelete(id)
}

const DeleteByCategory = async (id) => {
    let dishes = await DISH.find({ category: { _id: id } })

    for (let i = 0; i < dishes.length; i++) {
        await ORDER_SERVICE.DeleteByDish(dishes[i]._id)
        await DISH.findByIdAndDelete(dishes[i]._id)
    }
}


module.exports = {
    GetOne,
    GetAll,
    GetByCategory,
    Create,
    Update,
    Delete,
    DeleteByCategory
}