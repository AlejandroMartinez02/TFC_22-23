const User = require('../../user/models/User')
const SECURITY = require('../../../services/security/Security')

const Login = async (user) =>
{
    console.log(user.email)
    return await User.findOne({ "email": user.email })
        .then(async (userDB) =>
        {
            if (userDB == null) { return { status: 401 } }
            if (await SECURITY.comparePassword(user.password, userDB.password)) { return { status: 200, token: SECURITY.createToken(userDB) } }
            return { status: 403 }
        })
}

const Register = () =>
{

}

module.exports = {
    Login,
    Register
}