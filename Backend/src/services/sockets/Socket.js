const io = require('../../app')
const AUTH = require('../security/Security')

io.on('connection', client => {
    let { valid, uid } = AUTH.checkToken(client.handshake.headers['authorization'])

    if (valid) return client.disconnect()

    //ORDERS
    client.to(uid).emit()

    client.on('CreateOrder', async (payload) => {
        //Añadir order a la base de datos

        client.emit('GetOrders', /*VARIABLE CON LA NUEVA ORDEN*/)

    })

    client.on('connect', () => {
        console.log('conectadoaaa')

    })

    client.on('disconnect', () => { console.log('disconnect') })

})

const UpdateTables = (table) => {
    io.emit('UpdateTables', table)
}

module.exports = { UpdateTables }

