const WORKER = require('../models/Worker')
const SERVICE = require('../../../services/security/Security')

const GetById = async (sub) => {
    let worker = await WORKER.findOne({ _id: sub })
    return worker == null ? { status: 404 } : { status: 201, data: worker }
}

const GetAll = async () => {
    return await WORKER.find()
}

const Create = async (worker) => {
    worker.password = await SERVICE.encrypt(worker.password)
    await new WORKER(worker).save()
}

const Update = async (worker) => {
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