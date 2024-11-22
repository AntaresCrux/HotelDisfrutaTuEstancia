const express = require('express');
//Importamos controladores de cada modulo
const reservaController = require('../controllers/reservaController');
const habitacionController = require('../controllers/habitacionController');
const estanciaController = require('../controllers/estanciaController');
const servicioController = require('../controllers/servicioController');
const clienteController = require('../controllers/clienteController');
const graficaController  = require('../controllers/graficaController');

const router = express.Router();

//----------------------------------------Rutas para modulo Reservación----------------------------------//
// Ruta para registrar una nueva reservación
router.post('/reservacion-nueva', reservaController.crearReservacion);
// Ruta para obtener todas las reservaciones
router.get('/reservacion-mostrar', reservaController.obtenerReservaciones);
// Ruta para modificar una reservación
router.post('/reservacion-modificar', reservaController.modificarReservacionController);
// Ruta para cancelar una reservación
router.post('/reservacion-cancelar', reservaController.cancelarReservacionController);
// Ruta para obtener todas las cancelaciones
router.get('/reservacion-cancelar-mostrar', reservaController.obtenerCancelacionesController);


//----------------------------------------Rutas para modulo Estancia-------------------------------------//
// Ruta para registrar el check-in
router.post('/checkin', estanciaController.registrarCheckIn);
// Ruta para registrar servicio consumido
router.post('/registrar-servicio', estanciaController.registrarServicioConsumido);
// Ruta para registrar check-out
router.post('/registrar-check-out', estanciaController.registrarCheckOut);

//--------------------------------------Rutas para modulo Habitacion-------------------------------------//
// Ruta para obtener los tipos de habitación
router.get('/habitacion-tipo', habitacionController.getTiposHabitacion);
// Ruta para obtener para obtener las habitaciones con informacion
router.get('/habitaciones', habitacionController.getHabitacionInfo);



//--------------------------------------Rutas para modulo Servicios-------------------------------------//
// Ruta para obtener los tipos de servicios
router.get('/servicio-describe', servicioController.getServicios);
// Ruta para obtener los servicios con detalle
router.get('/servicio-total', servicioController.getServicioDetalle);


//--------------------------------------Rutas para modulo Clientes-------------------------------------//
// Ruta para obtener los clientes
router.get('/cliente-mostrar', clienteController.getCliente);

//--------------------------------------Rutas para modulo Graficas-------------------------------------//
router.get('/habitaciones-mas-ocupadas', graficaController.getHabitacionesMasOcupadas);
router.get('/tipo-mas-ocupada', graficaController.getReservasPorTipoHabitacion);
module.exports = router;