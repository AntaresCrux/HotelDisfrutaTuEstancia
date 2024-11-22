const empleadoModel = require('../models/empleado');
const bcrypt = require('bcrypt'); // Asegúrate de tener bcrypt instalado
const jwt = require('jsonwebtoken'); // Asegúrate de tener jsonwebtoken instalado

const iniciarSesion = async (req, res) => {
    try {
        const { user_emp, pass_emp } = req.body;

        // Verificar si el empleado existe en la base de datos
        const empleado = await empleadoModel.obtenerEmpleadoPorUsuario(user_emp);
        if (!empleado) {
            return res.status(401).json({ error: 'Usuario o contraseña incorrectos' });
        }

        // Verificar la contraseña ingresada con la de la base de datos
        const esValido = await bcrypt.compare(pass_emp, empleado.pass_emp);
        if (!esValido) {
            return res.status(401).json({ error: 'Usuario o contraseña incorrectos' });
        }

        // Generar un token JWT para el empleado
        const token = jwt.sign(
            { id_empleado: empleado.id_empleado, user_emp: empleado.user_emp },
            'tu_secreto_jwt', // Cambia esto por una clave segura y utiliza variables de entorno en producción
            { expiresIn: '1h' }
        );

        res.status(200).json({ message: 'Inicio de sesión exitoso', token });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Error al iniciar sesión' });
    }
};

module.exports = {
    iniciarSesion
};
