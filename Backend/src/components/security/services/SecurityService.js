const USER = require('../../user/models/User')
const SECURITY = require('../../../services/security/Security')

const Check = async (token) => {
    return await SECURITY.checkToken(token)
}

const Login = async (user) => {
    const searchedUser = await USER.findOne({ email: user.email }, 'admin password lock_until login login_attempts')
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

const Register = async (user) => {
    user.password = await SECURITY.encrypt(user.password)
    user.rol = "User"
    let response = await new USER(user).save()
    return { status: 201, data: SECURITY.createToken(response) }


}

module.exports = {
    Login,
    Register,
    Check
}