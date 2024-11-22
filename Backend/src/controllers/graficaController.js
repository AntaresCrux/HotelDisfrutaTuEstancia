const { obtenerHabitacionesMasOcupadas, obtenerReservasPorTipoHabitacion } = require('../models/graficaModel');

/**
 * Controlador para obtener las habitaciones más ocupadas.
 * 
 * @param {Object} req - Objeto de solicitud.
 * @param {Object} res - Objeto de respuesta.
 */
const getHabitacionesMasOcupadas = async (req, res) => {
    try {
        const habitaciones = await obtenerHabitacionesMasOcupadas();
        res.status(200).json(habitaciones);
    } catch (error) {
        console.error('Error en el controlador de habitaciones:', error.message);
        res.status(500).json({ error: 'Error al obtener las habitaciones más ocupadas.' });
    }
};

/**
 * Controlador para obtener las reservas por tipo de habitación.
 * 
 * @param {Object} req - Solicitud HTTP.
 * @param {Object} res - Respuesta HTTP.
 */
const getReservasPorTipoHabitacion = async (req, res) => {
    try {
        const datos = await obtenerReservasPorTipoHabitacion();
        res.status(200).json(datos);
    } catch (error) {
        console.error('Error en el controlador de reservas por tipo de habitación:', error.message);
        res.status(500).json({ error: 'Hubo un problema al obtener los datos.' });
    }
};

module.exports = { 
    getHabitacionesMasOcupadas,
    getReservasPorTipoHabitacion
 };
