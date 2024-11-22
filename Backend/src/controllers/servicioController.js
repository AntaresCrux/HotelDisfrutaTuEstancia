const servicioModel = require('../models/servicioModel');

// Controlador para obtener servicios
const getServicios = async (req, res) => {
    try {
        const serv = await servicioModel.obtenerServicios();  // Llamamos al modelo para obtener los datos
        res.status(200).json(serv);  // Respondemos con los datos en formato JSON
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener los servicios' });  // Error del servidor
    }
};

// Controlador para obtener servicios con detalle
const getServicioDetalle = async (req, res) => {
    try {
        const serv = await servicioModel.obtenerServicioDetalle;  // Llamamos al modelo para obtener los datos
        res.status(200).json(serv);  // Respondemos con los datos en formato JSON
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener los servicios con detalle' });  // Error del servidor
    }
};

module.exports = {
    getServicios,
    getServicioDetalle
};