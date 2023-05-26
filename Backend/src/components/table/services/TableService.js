const TABLE = require('../models/Table')
const socket = require('../../../services/sockets/Socket')

const GetAll = async () => {
    return await TABLE.find()
}

const Update = async (table) => {
    await TABLE.findByIdAndUpdate({ _id: table._id }, table)
    let tables = await TABLE.find()

    socket.UpdateTables(tables)
}

module.exports = {
    GetAll,
    Update
}