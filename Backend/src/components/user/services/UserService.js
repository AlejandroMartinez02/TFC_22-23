const User = require('../models/User')
const SECURITY = require('../../../services/security/Security')

const Create = async (user) =>
{
    user.password = await SECURITY.encrypt(user.password)
    return await new User(user).save()
        .then(async newUser =>
        {
            return user == null ? { status: 401 } : { status: 200, token: SECURITY.createToken(newUser) }
        })
}



module.exports = {
    Create
}