const TABLE = require('../models/Table')
const socket = require('../../../services/sockets/Socket')

const GetAll = async () => {
    return await TABLE.find()
}

const Create = async (body) => {
    return await new TABLE(body).save()
}

const Update = async (table) => {
    await TABLE.findByIdAndUpdate({ _id: table._id }, table)
    let tables = await TABLE.find()

    socket.UpdateTables(tables)
}

const Delete = async (id) => {
    console.log(id)
    if (await TABLE.findOne({ _id: id }) == null) throw new Error()
    await TABLE.findByIdAndDelete(id)
}

module.exports = {
    GetAll,
    Create,
    Update,
    Delete
}