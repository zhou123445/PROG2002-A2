const mysql = require('mysql2');
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: "Yiyi0307",
    database: 'charityevents_db',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit:0
});
module.exports = pool.promise();
