<script setup>
import { io } from 'socket.io-client';
import { computed, onMounted, ref } from 'vue';

// Inicializar la conexión de Socket.IO
const socket = io('http://localhost:3001'); // Asegúrate de que la URL sea correcta

const habitaciones = ref([]);
const searchQuery = ref('');

// Función para manejar las habitaciones recibidas desde el servidor
const handleHabitaciones = (habitacionesData) => {
    habitaciones.value = habitacionesData.map((habitacion) => ({
        id: habitacion.id_hab,
        numero: habitacion.numerohab,
        tipo: habitacion.desc_hab,
        cantidadDeCamas: habitacion.cant_camas,
        precio: habitacion.precio_hab,
        estado: habitacion.estado
    }));
};

// Filtrar las habitaciones según la búsqueda
const filteredHabitaciones = computed(() => {
    if (!searchQuery.value) return habitaciones.value;
    return habitaciones.value.filter((habitacion) => habitacion.numero.toString().includes(searchQuery.value) || habitacion.estado.toLowerCase().includes(searchQuery.value.toLowerCase()));
});

// Conectar al servidor y solicitar las habitaciones al cargar el componente
onMounted(() => {
    socket.emit('requestHabitaciones'); // Solicita las habitaciones al servidor
    socket.on('habitaciones', handleHabitaciones); // Escucha las habitaciones cuando el servidor las envíe
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8)">
            <div class="font-semibold text-xl">Estado de Habitaciones</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar habitación..." class="p-2 border border-gray-300 rounded" />
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">ID</th>
                        <th class="px-4 py-2">Número</th>
                        <th class="px-4 py-2">Tipo</th>
                        <th class="px-4 py-2">Camas</th>
                        <th class="px-4 py-2">Precio</th>
                        <th class="px-4 py-2">Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="habitacion in filteredHabitaciones" :key="habitacion.id">
                        <td class="border px-4 py-2">{{ habitacion.id }}</td>
                        <td class="border px-4 py-2">{{ habitacion.numero }}</td>
                        <td class="border px-4 py-2">{{ habitacion.tipo }}</td>
                        <td class="border px-4 py-2">{{ habitacion.cantidadDeCamas }}</td>
                        <td class="border px-4 py-2">{{ habitacion.precio }}</td>
                        <td class="border px-4 py-2">{{ habitacion.estado }}</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </Fluid>
</template>
