const { Server } = require('socket.io');    // Permite crear un servidor de WebSocket
const express = require('express');         // Framework minimalista para crear servidores web
const http = require('http');               // Crear el servidor HTTP
const pool = require('../config/dbConfig'); // Pool de conexiones a la base de datos

// Configura el servidor Express y Socket.IO
const app = express();
const server = http.createServer(app);

// Configura el servidor de Socket.IO, pasando la instancia de servidor HTTP
// Establece las opciones CORS para permitir la conexión desde el frontend
const io = new Server(server, {
  cors: {
    origin: 'http://localhost:5173',  // Origen de tu frontend
    methods: ['GET'],                 // Métodos permitidos
    allowedHeaders: ['Content-Type'], // Encabezados permitidos
  }
});

// Evento 'connection', que es escuchado cuando un cliente se conecta al servidor de WebSocket
io.on('connection', (socket) => {
  // Muestra un mensaje en consola cuando un cliente se conecta  
  console.log('Un cliente se ha conectado');

  // Evento que se dispara cuando el cliente solicita obtener las habitaciones
  socket.on('requestHabitaciones', async () => {
    try {
      const result = await pool.query(`
        SELECT
          h.id_hab,
          h.numerohab,
          t.desc_hab,
          t.cant_camas,
          t.precio_hab,
          h.estado
        FROM
          habitacion h
        JOIN
          tipo_hab t ON h.id_thab = t.id_thab;
      `);

      //Emite el evento 'habitaciones' al cliente con la lista de habitaciones obtenidas de la base de datos
      socket.emit('habitaciones', result.rows);
      // Imprime un mensaje en consola de que se están mostrando las habitaciones
      console.log('Mostrando habitaciones');
    } catch (error) {
      // Si ocurre un error durante la consulta a la base de datos, lo captura y lo imprime en consola  
      console.error('Error al obtener las habitaciones:', error);
      console.log('No se puede mostrar la habitacion');
    }
  });

  // Desconectar al cliente
  socket.on('disconnect', () => {
    //Mensaje en consola de verificacion
    console.log('Cliente desconectado');
  });
});

// Inicia el servidor en el puerto 3001 para escuchar las conexiones de clientes
server.listen(3001, () => {
  console.log('Servidor Socket.IO corriendo en puerto 3001');
});
