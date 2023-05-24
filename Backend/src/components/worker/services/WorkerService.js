const WORKER = require('../models/Worker')
const SERVICE = require('../../../services/security/Security')

const GetById = async (sub) => {
    let worker = await WORKER.findOne({ _id: sub })
    return worker == null ? { status: 404 } : { status: 201, data: worker }
}

const GetAll = async (id) => {
    return await WORKER.find({ _id: { $ne: id } })
}

const Create = async (worker) => {
    delete worker._id
    worker.password = await SERVICE.encrypt(worker.password)
    return await new WORKER(worker).save()
}

const Update = async (worker) => {
    if (worker.password == '') worker.password = await SERVICE.encrypt(worker.password)
    else delete worker.password
    await WORKER.findByIdAndUpdate(worker._id, worker)
}

const Delete = async (id) => {
    await WORKER.findByIdAndDelete({ _id: id })
}


module.exports = {
    GetById,
    GetAll,
    Create,
    Update,
    Delete
}