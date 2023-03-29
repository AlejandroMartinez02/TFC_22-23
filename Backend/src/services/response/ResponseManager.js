const RESPONSE_500 = (res) => res.status(500).send({ "status": 500, "data": "An internal error has ocurred" })

const RESPONSE_401 = (res) => res.status(401).send({ "status": 401, "data": "Unauthorized" })

const RESPONSE_403 = (res) => res.status(403).send({ "status": 403, "data": "Forbidden" })

const RESPONSE_404 = (res) => res.status(404).send({ "status": 404, "data": "Not Found" })

const RESPONSE_200 = (res) => res.status(200).send({ "status": 200, "data": "OK" })

const RESPONSE_201 = (res, data) => res.status(201).send({ "status": 201, "data": data })

const RESPONSE_TOKEN = (res, data) => res.status(200).send({ status: data.status, data: data.token })

module.exports = {
    RESPONSE_500,
    RESPONSE_401,
    RESPONSE_403,
    RESPONSE_404,
    RESPONSE_200,
    RESPONSE_201,
    RESPONSE_TOKEN
}