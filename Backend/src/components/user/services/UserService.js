const User = require('../models/User')
const SECURITY = require('../../../services/security/Security')


const GetOne = async (id) =>
{
    let user = await User.findById(id)
    return user == null ? { status: 404 } : { status: 200, data: user }

}

const GetAll = async () =>
{
    return await User.find()
}

const Create = async (user) =>
{
    user.password = await SECURITY.encrypt(user.password)
    await new User(user).save()
}

const Update = async (userUpdate) =>
{
    return await User.findByIdAndUpdate(userUpdate.id, userUpdate)
}

const Delete = async () =>
{
    return await User.findByIdAndDelete(id)
}


module.exports = {
    GetOne,
    GetAll,
    Create,
    Update,
    Delete
}