const estanciaModel = require('../models/estanciaModel');

const registrarCheckIn = async (req, res) => {
    const { idReserva, rfc, fechaLlegada, horaLlegada } = req.body;

    try {
        const result = await estanciaModel.registrarCheckIn(idReserva, rfc, fechaLlegada, horaLlegada);
        res.status(200).json({
            message: 'Check-in registrado con éxito',
            data: result
        });
    } catch (error) {
        res.status(500).json({
            message: error.message
        });
    }
};

// Controlador para registrar servicio consumido
const registrarServicioConsumido = async (req, res) => {
    const { idEstancia, idServicio, hora, dia, monto } = req.body;
    try {
        const result = await serviciosModel.registrarServicioConsumido(idEstancia, idServicio, hora, dia, monto);
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

// Controlador para registrar check-out
const registrarCheckOut = async (req, res) => {
    const { idReserva, fechaSalida, horaSalida } = req.body;
    try {
        const result = await serviciosModel.registrarCheckOut(idReserva, fechaSalida, horaSalida);
        res.status(200).json(result);
    } catch (error) {
        res.status(500).json({ success: false, message: error.message });
    }
};

module.exports = {
    registrarCheckIn,
    registrarServicioConsumido,
    registrarCheckOut
};