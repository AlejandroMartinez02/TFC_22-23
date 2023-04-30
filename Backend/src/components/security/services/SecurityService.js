const User = require('../../user/models/User')
const SECURITY = require('../../../services/security/Security')

const Check = async (token) => {
    return await SECURITY.checkToken(token)
}

const Login = async (user) => {
    return await User.findOne({ "email": user.email })
        .then(async (userDB) => {
            if (userDB == null) { return { status: 401 } }
            if (await SECURITY.comparePassword(user.password, userDB.password)) { return { status: 200, token: SECURITY.createToken(userDB) } }
            return { status: 403 }
        })
}

const Register = async (user) => {
    user.password = await SECURITY.encrypt(user.password)
    user.rol = "User"
    let response = await new User(user).save()
    return { status: 201, data: SECURITY.createToken(response) }
}

module.exports = {
    Login,
    Register,
    Check
}