const CATEGORY = require('../models/Category')
const DISH_SERVICE = require('../../dish/services/DishService')


const GetOne = async (id) => {
    let category = await CATEGORY.findOne({ _id: id })
    return category != null ? { status: 201, data: category } : { status: 404 }
}

const GetAll = async () => {
    return await CATEGORY.find()
}

const Create = async (category) => {
    return await new CATEGORY(category).save()
}

const Update = async (category) => {
    if (await CATEGORY.findOne({ _id: category._id }) == null) throw new Error()
    await CATEGORY.updateOne({ _id: category._id }, category)
}

const Delete = async (id) => {
    if (await CATEGORY.findOne({ _id: id }) == null) throw new Error()
    await DISH_SERVICE.DeleteByCategory(id)
    await CATEGORY.deleteOne({ _id: id })

}

module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}