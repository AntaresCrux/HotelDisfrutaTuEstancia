const pool = require('../config/dbConfig'); // Asegúrate de importar tu configuración de base de datos

/**
 * Obtiene las habitaciones más ocupadas.
 * 
 * @returns {Promise<Array>} - Lista de habitaciones más ocupadas con su número y cantidad de ocupaciones.
 */
const obtenerHabitacionesMasOcupadas = async () => {
    try {
        const result = await pool.query('SELECT * FROM obtener_habitaciones_mas_ocupadas()');
        return result.rows;
    } catch (error) {
        console.error('Error al obtener las habitaciones más ocupadas:', error);
        throw new Error('Error al obtener las habitaciones más ocupadas.');
    }
};

/**
 * Obtiene el tipo de habitación y la cantidad de veces que ha sido reservada.
 * 
 * @returns {Promise<Array>} - Lista con el tipo de habitación y el número de reservas.
 */
const obtenerReservasPorTipoHabitacion = async () => {
    try {
        const result = await pool.query('SELECT * FROM obtener_reservas_por_tipo_hab()');
        return result.rows;
    } catch (error) {
        console.error('Error al obtener las reservas por tipo de habitación:', error);
        throw new Error('Error al obtener las reservas por tipo de habitación.');
    }
};

module.exports = { 
    obtenerHabitacionesMasOcupadas,
    obtenerReservasPorTipoHabitacion
 };
