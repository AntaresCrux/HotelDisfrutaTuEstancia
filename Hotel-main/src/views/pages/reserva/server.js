const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/reservas', { useNewUrlParser: true, useUnifiedTopology: true });

const reservaSchema = new mongoose.Schema({
    id: Number,
    nombre: String,
    apellidoPaterno: String,
    apellidoMaterno: String,
    telefono: String,
    correo: String,
    estadoReserva: String
});

const Reserva = mongoose.model('Reserva', reservaSchema);

app.get('/api/reservas', async (req, res) => {
    const reservas = await Reserva.find();
    res.json(reservas);
});

app.post('/api/reservas', async (req, res) => {
    const newReserva = new Reserva(req.body);
    await newReserva.save();
    res.json(newReserva);
});

app.delete('/api/reservas/:id', async (req, res) => {
    await Reserva.findByIdAndDelete(req.params.id);
    res.json({ message: 'Reserva eliminada' });
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
