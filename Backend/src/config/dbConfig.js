//require('dotenv').config(); // Para cargar las variables de entorno
require('dotenv').config({ path: './.env' });
const { Pool } = require('pg'); // Importa la biblioteca pg

// Configuración de la conexión
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME
});

// Probar la conexión
pool.connect((err, client, release) => {
  if (err) {
    //console.error('Error al conectar a la base de datos:', err.stack);
    console.error('Detalles del error de conexión:', {
      message: err.message,
      stack: err.stack
    });
  } else {
    console.log('Conexión exitosa a la base de datos');
  }
  release(); // Libera el cliente
});

module.exports = pool; // Exporta el pool de conexiones para usarlo en otros módulos
