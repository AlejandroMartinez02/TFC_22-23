const SERVICE = require('../services/SecurityService')
const RESPONSE_MANAGER = require('../../../services/response/ResponseManager')


const Check = async (req, res) => {
    const token = req.headers.authorization.split(" ")[1];
    await SERVICE.Check(token)
        .then((response) => response ? RESPONSE_MANAGER.RESPONSE_200(res) : RESPONSE_MANAGER.RESPONSE_401(res))
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))

}

const Login = async (req, res) => {
    const user = {
        email: req.body.email,
        password: req.body.password
    }
    await SERVICE.Login(user)
        .then((data) => {
            if (data.status == 200) {
                RESPONSE_MANAGER.RESPONSE_TOKEN(res, data)
            } else if (data.status == 401) {
                RESPONSE_MANAGER.RESPONSE_401(res)
            } else {
                RESPONSE_MANAGER.RESPONSE_403(res)
            }
        })
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res)
        )
}

const WorkerLogin = async (req, res) => {
    const user = {
        email: req.body.email,
        password: req.body.password
    }

    await SERVICE.WorkerLogin(user)
        .then((data) => {
            RESPONSE_MANAGER.RESPONSE_LOGIN_WORKER(res, data)
        })
        .catch((error) => {
            console.log(error)
            RESPONSE_MANAGER.RESPONSE_500(res)
        }
        )
}


const Register = async (req, res) => {
    const { body } = req
    await SERVICE.Register(body)
        .then((response) => {
            response.status == 201 ? RESPONSE_MANAGER.RESPONSE_201(res, response.data) : RESPONSE_MANAGER.RESPONSE_404(res)
        })
        .catch(() => RESPONSE_MANAGER.RESPONSE_500(res))
}

const ChangePassword = async (req, res) => {
    const { oldPassword } = req.body
    const { sub } = req.user
    const { newPassword } = req.body

    await SERVICE.ChangePassword(sub, oldPassword, newPassword)
        .then((response) => response.status == 200 ? RESPONSE_MANAGER.RESPONSE_200(res) : RESPONSE_MANAGER.RESPONSE_401(res))
        .catch((error) => {
            console.log(error)
            RESPONSE_MANAGER.RESPONSE_500(res)
        })
}



module.exports = {
    Login,
    WorkerLogin,
    Register,
    Check,
    ChangePassword
}