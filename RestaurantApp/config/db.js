const mysql = require('mysql2');
require('dotenv').config();

const conexiune = mysql.createPool({
  host:     process.env.DB_HOST,
  user:     process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit:    10,
});

// Testare conexiune la pornirea serverului
conexiune.getConnection((err, conn) => {
  if (err) {
    console.error('❌ Eroare conexiune MySQL:', err.message);
    return;
  }
  console.log('✅ Conectat la baza de date MySQL!');
  conn.release();
});

module.exports = conexiune.promise();

