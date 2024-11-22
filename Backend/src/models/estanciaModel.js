const pool = require('../config/dbConfig'); // Asumiendo que 'db' exporta la instancia de conexión a la base de datos

const registrarCheckIn = async (idReserva, rfc, fechaLlegada, horaLlegada) => {
    try {
        const query = `
            CALL registrar_check_in($1, $2, $3, $4);
        `;
        const result = await pool.query(query, [idReserva, rfc, fechaLlegada, horaLlegada]);
        return result;
    } catch (error) {
        throw new Error(`Error al registrar el check-in: ${error.message}`);
    }
};

// Registro de servicio consumido
const registrarServicioConsumido = async (idEstancia, idServicio, hora, dia, monto) => {
    const query = `
        CALL registrar_servicio_consumido($1, $2, $3, $4, $5);
    `;
    try {
        await pool.query(query, [idEstancia, idServicio, hora, dia, monto]);
        return { success: true, message: 'Servicio consumido registrado con éxito' };
    } catch (error) {
        console.error('Error registrando servicio consumido:', error);
        throw error;
    }
};

// Registro de check-out
const registrarCheckOut = async (idReserva, fechaSalida, horaSalida) => {
    const query = `
        CALL registrar_check_out($1, $2, $3);
    `;
    try {
        await pool.query(query, [idReserva, fechaSalida, horaSalida]);
        return { success: true, message: 'Check-out registrado con éxito' };
    } catch (error) {
        console.error('Error registrando check-out:', error);
        throw error;
    }
};

module.exports = {
    registrarCheckIn,
    registrarServicioConsumido,
    registrarCheckOut
};