const io = require('../../app')
const AUTH = require('../security/Security')

io.on('connection', client => {
    let { valid, uid } = AUTH.checkToken(client.handshake.headers['authorization'])

    if (valid) return client.disconnect()

})

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

