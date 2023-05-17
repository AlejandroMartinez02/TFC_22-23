const { io } = require('../../app')

io.on('connection', client => {
    console.log('cliente conectado')
    client.on('connect', () => { console.log('conectado') })
    client.on('disconnect', () => { console.log('disconnect') })
    client.on('usuarios', (payload) => {
        io.emit('mensaje-nuevo', 'recibido y enviado')
        console.log("RECIBIOOO")
    })

})


