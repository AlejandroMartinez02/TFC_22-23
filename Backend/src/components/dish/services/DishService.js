const DISH = require('../models/Dish')

const GetOne = async (id) =>
{
    let dish = await DISH.findOne({ id: id })
    return dish != null ? { status: 201, data: dish } : { status: 404 }
}

const GetAll = async () =>
{
    return await DISH.find()
}

const Create = async (dish) =>
{
    await new DISH(dish).save()
}


const Update = async (dish) =>
{
    await DISH.findByIdAndUpdate(dish)
}

const Delete = async (id) =>
{
    await DISH.findByIdAndDelete(id)
}


module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}