const DISH = require('../models/Dish')
const CATEGORY = require('../../category/models/Category')

const GetOne = async (id) => {
    let dish = await DISH.findOne({ _id: id })

    return dish != null ? { status: 201, data: dish } : { status: 404 }
}

const GetAll = async () => {
    return await DISH.find().populate("category")
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


module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}