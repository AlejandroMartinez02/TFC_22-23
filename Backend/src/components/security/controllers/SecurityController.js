const SERVICE = require('../services/SecurityService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')


const Login = (req, res) =>
{
    const user = {
        email: req.body.email,
        password: req.body.password
    }

    SERVICE.Login(user)
        .then((data) =>
        {
            if (data.status == 200)
            {
                RESPONSE_MANAGER.RESPONSE_TOKEN(res, data)
            } else
            {
                RESPONSE_MANAGER.RESPONSE_401(res)
            }
        })
        .catch((error) =>
        {
            console.log(error)
            RESPONSE_MANAGER.RESPONSE_500(res)
        })
}


const Register = (req, res) =>
{

}



module.exports = {
    Login,
    Register
}