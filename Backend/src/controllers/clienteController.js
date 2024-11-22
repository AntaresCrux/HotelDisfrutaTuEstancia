const clienteModel = require('../models/clienteModel');

// Controlador para obtener servicios con detalle
const getCliente = async (req, res) => {
    try {
        const serv = await clienteModel.obtenerClientes();  // Llamamos al modelo para obtener los datos
        res.status(200).json(serv);  // Respondemos con los datos en formato JSON
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener los clientes con detalle' });  // Error del servidor
    }
};

module.exports = {
    getCliente
};