const RESPONSE_500 = (res) =>
{
    res.status(500).send({ "status": 500, "data": "An internal error has ocurred" })
}

const RESPONSE_401 = (res) =>
{
    res.status(401).send({ "status": 401, "data": "Unauthorized" })
}

const RESPONSE_200 = (res) =>
{
    res.status(200).send({ "status": 200, "data": "OK" })
}

const RESPONSE_TOKEN = (res, data) =>
{
    res.status(200).send({ status: data.status, data: data.token })
}





module.exports = {
    RESPONSE_500,
    RESPONSE_401,
    RESPONSE_200,
    RESPONSE_TOKEN
}