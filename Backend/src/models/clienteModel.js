const pool = require('../config/dbConfig');

const obtenerClientes = async () => {
    const query = 'SELECT * FROM clientes';
    try {
        const result = await pool.query(query);
        return result.rows; //
    } catch (error) {
        console.error('Error al obtener los clientes', error);
        throw error;
    }
};

module.exports = {
    obtenerClientes
};