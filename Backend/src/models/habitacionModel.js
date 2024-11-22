const pool = require('../config/dbConfig');

const obtenerTiposHabitacion = async () => {
    const query = 'SELECT id_thab, desc_hab FROM tipo_hab;';
    try {
        const result = await pool.query(query);
        return result.rows; // Devuelve todos los tipos de habitación
    } catch (error) {
        console.error('Error al obtener los tipos de habitación', error);
        throw error;
    }
};

const obtenerHabitacionInfo = async () => {
    const result = await pool.query(`
      SELECT
        h.id_hab,
        h.numerohab,
        t.desc_hab,
        t.cant_camas,
        t.precio_hab,
        h.estado
      FROM
        habitacion h
      JOIN
        tipo_hab t ON h.id_thab = t.id_thab;
    `);
    return result.rows;
};

module.exports = {
    obtenerTiposHabitacion,
    obtenerHabitacionInfo
};