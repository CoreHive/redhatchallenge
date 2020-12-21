const odbc = require('odbc');

var pool;

module.exports = {
    connect: async function(connString) {
        pool = await odbc.pool(connString);
    },

    executeStatement: async function (statement, bindings) {
        return await pool.query(statement, bindings);
    }
}