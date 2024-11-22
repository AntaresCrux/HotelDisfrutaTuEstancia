const pool = require('../config/dbConfig');

/**
 * Crear una reservación completa.
 * 
 * @param {Object} reservaData - Datos necesarios para crear la reservación.
 * @returns {Promise<Object>} - Promesa con los resultados de la operación.
 */
const registrarReservacionCompleta = async (reservaData) => {
    console.log("Datos recibidos en el servidor:", reservaData);
    const {
        p_nombre,
        p_ap_pat,
        p_ap_mat,
        p_telefono,
        p_email,
        p_rfc,
        p_direccion,
        p_fecha_llegada,
        p_fecha_salida,
        p_tipo_hab
    } = reservaData;

    try {
        const result = await pool.query(
            `CALL registrar_reservacion_completa(
                $1::VARCHAR, $2::VARCHAR, $3::VARCHAR, $4::VARCHAR, $5::VARCHAR, 
                $6::VARCHAR, $7::VARCHAR, $8::DATE, $9::DATE, $10::INTEGER
            )`,
            [
                p_nombre, p_ap_pat, p_ap_mat, p_telefono,
                p_email, p_rfc, p_direccion, p_fecha_llegada,
                p_fecha_salida, p_tipo_hab
            ]
        );

        return {
            success: true,
            message: 'Reservación creada exitosamente',
            data: result.rows // Dependiendo de lo que necesites retornar
        };
    } catch (error) {
        if (error.message.includes('No hay habitaciones disponibles')) {
            // Caso específico para la excepción de habitaciones no disponibles
            return {
                success: false,
                message: 'No hay habitaciones disponibles del tipo solicitado en las fechas seleccionadas.'
            };
        }

        console.error('Error al registrar la reservación:', error);
        throw new Error('No se pudo realizar la reservación.');
    }
};


/** 
 * Llama al procedimiento para obtener todas las reservaciones
 * 
 * @returns {Promise<Object>} 
 */
const obtenerReservaciones = async () => {
    try {
        const result = await pool.query('SELECT * FROM mostrar_todas_reservaciones()');
        return result.rows;
    } catch (error) {
        console.error('Error al obtener las reservaciones:', error);
        throw new Error('No se pudieron obtener las reservaciones.');
    }
};

/**
 * Llama al procedimiento para modificar una reservación.
 * 
 * @param {number} idReserva - ID de la reservación.
 * @param {string} fechaLlegada - Fecha de llegada (YYYY-MM-DD).
 * @param {string} fechaSalida - Fecha de salida (YYYY-MM-DD).
 * @param {number} tipoHab - ID del tipo de habitación.
 * @returns {Promise<void>}
 */
const modificarReservacion = async (idReserva, fechaLlegada, fechaSalida, tipoHab) => {
    try {
        await pool.query(
            `CALL modificar_reservacion($1, $2, $3, $4)`,
            [idReserva, fechaLlegada, fechaSalida, tipoHab]
        );
        return {
            success: true,
            message: `Reservación con ID ${idReserva} modificada exitosamente.`
        };
    } catch (error) {
        console.error('Error al modificar la reservación:', error);
        throw new Error('Error al modificar la reservación. ' + error.message);
    }
};

/**
 * Llama al procedimiento para cancelar una reservación.
 * 
 * @param {number} idReserva - ID de la reservación.
 * @param {string} rfc - RFC del cliente.
 * @param {string} motivo - Motivo de la cancelación.
 * @returns {Promise<Object>} - Promesa que resuelve en un objeto con el resultado.
 */
const cancelarReservacion = async (idReserva, rfc, motivo) => {
    try {
        await pool.query(
            `CALL cancelar_reservacion($1, $2, $3)`,
            [idReserva, rfc, motivo]
        );
        return {
            success: true,
            message: `Reservación con ID ${idReserva} cancelada exitosamente.`
        };
    } catch (error) {
        console.error('Error al cancelar la reservación:', error);
        throw new Error('Error al cancelar la reservación. ' + error.message);
    }
};

/**
 * Llama al procedimiento para obtener las reservaciones canceladas.
 * 
 * @returns {Promise<Object>} - Promesa que resuelve con los resultados de las cancelaciones.
 */
const mostrarCancelaciones = async () => {
    try {
        const result = await pool.query('SELECT * FROM mostrar_cancelaciones()');
        return {
            success: true,
            data: result.rows
        };
    } catch (error) {
        console.error('Error al obtener las cancelaciones:', error);
        throw new Error('Error al obtener las cancelaciones. ' + error.message);
    }
};
  
module.exports = {
    registrarReservacionCompleta,
    obtenerReservaciones,
    modificarReservacion,
    cancelarReservacion,
    mostrarCancelaciones
};
