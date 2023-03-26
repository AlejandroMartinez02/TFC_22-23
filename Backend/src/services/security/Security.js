const jwt = require('jwt-simple')
const moment = require('moment')
const bcrypt = require('bcrypt')

function createToken(user)
{
    const payload = {
        sub: user._id,
        rol: user.rol,
        iat: moment().unix(),
        exp: moment().add(8, 'hours').unix()
    }
    return jwt.encode(payload, process.env.SECRET_TOKEN)
}

function decodeToken(token)
{
    const decoded = new Promise((resolve, reject) =>
    {
        try
        {
            const payload = jwt.decode(token, process.env.SECRET_TOKEN)
            resolve(payload)
        } catch (error)
        {
            reject({ status: 500, "data": "Expirated token or invalid token" })
        }
    })

    return decoded;
}

async function encrypt(password)
{
    return await bcrypt.hash(password, 10);
}

async function comparePassword(userPassword, dbPassword)
{
    return await bcrypt.compare(userPassword, dbPassword)
}

module.exports = {
    createToken,
    decodeToken,
    encrypt,
    comparePassword
}