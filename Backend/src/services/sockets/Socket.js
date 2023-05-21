const { io } = require('../../app')
const AUTH = require('../security/Security')

io.on('connection', client => {
    let { valid, uid } = AUTH.checkToken(client.handshake.headers['authorization'])

    if (valid) return client.disconnect()

    //ORDERS
    client.join(uid)
    client.to(uid).emit()


    client.on('connect', () => {
        console.log('conectadoaaa')

    })


    client.on('disconnect', () => { console.log('disconnect') })
    client.on('usuarios', (payload) => {
        io.emit('mensaje-nuevo', 'recibido y enviado')
        console.log("RECIBIOOO")
    })

})


