const io = require('../../app')

const UpdateTables = (table) => {
    io.emit('UpdateTables', table)
}

const NewOrder = (order) => {
    io.emit('NewOrder', order)
}

const UpdateOrder = (id) => {
    io.emit(id)
}

module.exports = {
    UpdateTables,
    NewOrder,
    UpdateOrder
}

