const habitacionModel = require('../models/habitacionModel');

// Controlador para obtener los tipos de habitación
const getTiposHabitacion = async (req, res) => {
    try {
        const tipos = await habitacionModel.obtenerTiposHabitacion();  // Llamamos al modelo para obtener los datos
        res.status(200).json(tipos);  // Respondemos con los datos en formato JSON
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al obtener los tipos de habitación' });  // Error del servidor
    }
};

const getHabitacionInfo = async (req, res) => {
    try {
      const habitaciones = await habitacionModel.obtenerHabitacionInfo();
      res.json(habitaciones);
    } catch (err) {
      console.error('Error obteniendo habitaciones', err);
      res.status(500).json({ error: 'Error al obtener las habitaciones' });
    }
  };

module.exports = {
    getTiposHabitacion,
    getHabitacionInfo
};
