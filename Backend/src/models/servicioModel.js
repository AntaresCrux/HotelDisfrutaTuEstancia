const pool = require('../config/dbConfig');

const obtenerServicios = async () => {
    const query = 'SELECT id_servicio, desc_servicio FROM servicios;';
    try {
        const result = await pool.query(query);
        return result.rows; // Devuelve todos los tipos de habitación
    } catch (error) {
        console.error('Error al obtener los id de servicio', error);
        throw error;
    }
};

const obtenerServicioDetalle = async () => {
    const query = 'SELECT * FROM servicios;';
    try {
        const result = await pool.query(query);
        return result.rows; // Devuelve todos los tipos de habitación
    } catch (error) {
        console.error('Error al obtener los servicios', error);
        throw error;
    }
};

module.exports = {
    obtenerServicios,
    obtenerServicioDetalle
};