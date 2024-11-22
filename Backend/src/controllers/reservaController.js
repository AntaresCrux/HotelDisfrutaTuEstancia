const reservaModel = require('../models/reservaModel');

/**
 * Crear una reservación completa
 * @param {Object} req - La solicitud HTTP.
 * @param {Object} res - La respuesta HTTP.
 */
const crearReservacion = async (req, res) => {
    try {
        const reservaData = req.body; // Recibe los datos de la solicitud
        const result = await reservaModel.registrarReservacionCompleta(reservaData); // Llama al modelo
        
        if (result.success) {
            res.status(200).json({
                message: result.message, // Mensaje de éxito desde el modelo
                data: result.data // Los datos devueltos por el modelo si es necesario
            });
        } else {
            res.status(400).json({
                message: result.message // Mensaje de error específico desde el modelo
            });
        }
    } catch (error) {
        res.status(500).json({
            message: 'Error al crear la reservación.',
            error: error.message
        });
    }
};

/**
 * Controlador para obtener todas las reservaciones
 */
const obtenerReservaciones = async (req, res) => {
    try {
        const reservaciones = await reservaModel.obtenerReservaciones();
        res.status(200).json({
            success: true,
            message: 'Reservaciones obtenidas exitosamente',
            data: reservaciones
        });
    } catch (error) {
        res.status(500).json({
            success: false,
            message: 'Error al obtener las reservaciones.'
        });
    }
};

/**
 * Controlador para modificar una reservación.
 */
const modificarReservacionController = async (req, res) => {
    const { idReserva, fechaLlegada, fechaSalida, tipoHab } = req.body;

    try {
        const result = await reservaModel.modificarReservacion(idReserva, fechaLlegada, fechaSalida, tipoHab);
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

/**
 * Controlador para cancelar una reservación.
 */
const cancelarReservacionController = async (req, res) => {
    const { idReserva, rfc, motivo } = req.body;

    try {
        const result = await reservaModel.cancelarReservacion(idReserva, rfc, motivo);
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

/**
 * Controlador para obtener todas las cancelaciones.
 */
const obtenerCancelacionesController = async (req, res) => {
    try {
        const result = await reservaModel.mostrarCancelaciones();
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

module.exports = {
    crearReservacion,
    obtenerReservaciones,
    modificarReservacionController,
    cancelarReservacionController,
    obtenerCancelacionesController
};
