// Importar módulos necesarios
const express = require('express');
const cors = require('cors');                        // Asegúrate de haber importado 'cors'
const app = express();                               // Inicialización de 'app'
const totalRoutes = require('./routes/apiRutas');    //Importar rutas

// Usar CORS antes de las rutas
app.use(cors({
  //origin: 'http://192.168.1.115:5173/',                  // URL del frontend externo
  origin: 'http://localhost:5173',                    // URL del frontend
  methods: ['GET', 'POST', 'PUT', 'DELETE'],          // Métodos permitidos
  allowedHeaders: ['Content-Type', 'Authorization']   // Encabezados permitidos
}));

// Configuración de JSON
app.use(express.json());
//Archivo con todas las rutas
app.use('/api', totalRoutes);

// Crea el servidor HTTP
const http = require('http');
const server = http.createServer(app);

// Iniciar el servidor
server.listen(3000, () => {
  console.log('Servidor corriendo en http://localhost:3000');
});

/*
server.listen(3000, '0.0.0.0', () => {
  console.log('Servidor corriendo en http://0.0.0.0:3000');
});*/
