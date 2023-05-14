const USER = require('../../user/models/User')
const WORKER = require('../../worker/models/Worker')
const SECURITY = require('../../../services/security/Security')

const Check = async (token) => {
    return await SECURITY.checkToken(token)
}

const Login = async (user) => {
    const searchedUser = await USER.findOne({ email: user.email }, 'password lock_until login_attempts')
    if (searchedUser == null) return { status: 401 }
    const MAX_LOGIN_ATTEMPS = 5
    const LOCK_TIME = 4 * 60 * 1000
    let now = Date.now();
    let isLocked = false;
    let hasLockExpired = false
    isLocked = searchedUser.lock_until > now;
    hasLockExpired = searchedUser.lock_until < now;

    if (isLocked) {
        return { status: 403 }
    }

    if (hasLockExpired) {
        searchedUser.lock_until = undefined;
        searchedUser.login_attempts = 0;
        await searchedUser.save();
    }

    return await SECURITY.comparePassword(user.password, searchedUser.password)
        .then(async isMatch => {
            if (isMatch) {
                if (searchedUser.login_attempts > 0)
                    await searchedUser.updateOne({ $set: { login_attempts: 0 }, $unset: { lock_until: 1 } })
                return { status: 200, token: SECURITY.createToken(searchedUser) }
            } else {
                let updates = { $inc: { login_attempts: 1 } }
                if (searchedUser.login_attempts + 1 >= MAX_LOGIN_ATTEMPS)
                    updates.$set = { lock_until: now + LOCK_TIME }
                await searchedUser.updateOne(updates)
                return { status: 401 }
            }
        })

}

const WorkerLogin = async (user) => {
    const searchedUser = await WORKER.findOne({ email: user.email }, 'role password lock_until login_attempts')
    if (searchedUser == null) return { status: 401 }
    const MAX_LOGIN_ATTEMPS = 5
    const LOCK_TIME = 4 * 60 * 1000
    let now = Date.now();
    let isLocked = false;
    let hasLockExpired = false
    isLocked = searchedUser.lock_until > now;
    hasLockExpired = searchedUser.lock_until < now;

    if (isLocked) {
        return { status: 403 }
    }

    if (hasLockExpired) {
        searchedUser.lock_until = undefined;
        searchedUser.login_attempts = 0;
        await searchedUser.save();
    }

    return await SECURITY.comparePassword(user.password, searchedUser.password)
        .then(async isMatch => {
            if (isMatch) {
                if (searchedUser.login_attempts > 0)
                    await searchedUser.updateOne({ $set: { login_attempts: 0 }, $unset: { lock_until: 1 } })
                let worker = await WORKER.findById(searchedUser._id)
                return { status: 200, token: SECURITY.createTokenWorker(searchedUser), worker: worker }
            } else {
                let updates = { $inc: { login_attempts: 1 } }
                if (searchedUser.login_attempts + 1 >= MAX_LOGIN_ATTEMPS)
                    updates.$set = { lock_until: now + LOCK_TIME }
                await searchedUser.updateOne(updates)
                return { status: 401 }
            }
        })
}

const Register = async (user) => {
    user.password = await SECURITY.encrypt(user.password)
    let response = await new USER(user).save()
    return { status: 201, data: SECURITY.createToken(response) }
}

const ChangePassword = async (id, oldPassword, newPassword) => {
    let user = await USER.findOne({ _id: id }, 'password')
    let response
    await SECURITY.comparePassword(oldPassword, user.password)
        .then(async (isEqual) => {
            if (isEqual) {
                await USER.findByIdAndUpdate(id, { password: await SECURITY.encrypt(newPassword) })
                response = { status: 200 }
            } else {
                response = { status: 401 }
            }
        })
    return response;
}

module.exports = {
    Login,
    WorkerLogin,
    Register,
    Check,
    ChangePassword,
}