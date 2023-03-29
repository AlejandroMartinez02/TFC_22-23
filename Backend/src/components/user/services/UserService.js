const User = require('../models/User')
const SECURITY = require('../../../services/security/Security')


const GetOne = async (id) =>
{
    return await User.findById(id)
        .then((user) =>
        {
            user == null ? { status: 404 } : { status: 200, data: user }
        })
}

const GetAll = async () =>
{
    return await User.find()
}

const Create = async (user) =>
{
    user.password = await SECURITY.encrypt(user.password)
    return await new User(user).save()
        .then(async newUser =>
        {
            return user == null ? { status: 401 } : { status: 200, token: SECURITY.createToken(newUser) }
        })
}

const Update = async (userUpdate) =>
{
    return await User.findByIdAndUpdate(userUpdate.id, userUpdate)
}

const Delete = async () =>
{

}


module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}