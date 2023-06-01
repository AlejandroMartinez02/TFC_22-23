const { check } = require('express-validator');
const TABLE = require('../../components/table/models/Table')

const CRUD_TABLE = () => {
    return [
        check('tableNumber')
            .isNumeric()
            .notEmpty()
            .custom(async (tableNumber) => {
                if (await TABLE.find({ tableNumber: tableNumber }).length == 0) throw new Error()
            }),

        check('isInUse')
            .notEmpty(),

    ]
}



module.exports = CRUD_TABLE

