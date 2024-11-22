<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';

const reservas = ref([]);
const searchQuery = ref('');
const mensajeError = ref('');
const apiUrl = 'http://localhost:3000/api/reservacion-mostrar'; //-------- API ---------
const reservaEdit = ref({
    id: '',
    nombre: '',
    apellidoPaterno: '',
    apellidoMaterno: '',
    tipoHabitacion: '',
    numeroHabitacion: '',
    rfc: ''
});
const editFormVisible = ref(false);

const filteredReservas = computed(() => {
    if (!searchQuery.value) {
        return reservas.value.filter((reserva) => reserva.estadoReserva === 'RESERVADA');
    }
    return reservas.value.filter(
        (reserva) =>
            reserva.estadoReserva === 'RESERVADA' &&
            (reserva.id.toString().includes(searchQuery.value) ||
                reserva.nombre.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                reserva.apellidoPaterno.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                reserva.apellidoMaterno.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                reserva.tipoHabitacion.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                reserva.numeroHabitacion.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                reserva.rfc.toLowerCase().includes(searchQuery.value.toLowerCase()))
    );
});

// Obtener las reservas de la API
const fetchReservas = async () => {
    try {
        const response = await axios.get(apiUrl);
        // Mapear las propiedades de la API a las propiedades del componente
        reservas.value = response.data.data.map((reserva) => ({
            id: reserva.id_reserva,
            nombre: reserva.nombre,
            apellidoPaterno: reserva.ap_pat,
            apellidoMaterno: reserva.ap_mat,
            tipoHabitacion: reserva.tipo_hab,
            numeroHabitacion: reserva.numero_hab,
            rfc: reserva.rfc,
            estadoReserva: reserva.estado,
            fechaLlegada: reserva.fecha_llegada,
            fechaSalida: reserva.fecha_salida
        }));
    } catch (error) {
        console.error('Error al obtener reservas:', error);
        mensajeError.value = 'No se pudieron obtener las reservaciones';
    }
};

// Guardar o actualizar la reserva editada
const guardarReserva = async () => {
    if (!mensajeError.value) {
        try {
            await axios.put(`${apiUrl}/${reservaEdit.value.id}`, reservaEdit.value);
            // Actualizar la reserva en el arreglo después de la edición
            const index = reservas.value.findIndex((r) => r.id === reservaEdit.value.id);
            if (index !== -1) {
                reservas.value[index] = { ...reservaEdit.value };
                editFormVisible.value = false;
            }
        } catch (error) {
            console.error('Error al guardar la reserva:', error);
            mensajeError.value = 'Error al guardar la reserva';
        }
    }
};

// Mostrar el formulario de edición con los datos de la reserva seleccionada
const modificarReserva = (index) => {
    reservaEdit.value = { ...reservas.value[index] };
    editFormVisible.value = true;
};

// Obtener las reservas cuando el componente se monta
onMounted(() => {
    fetchReservas();
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full">
            <div class="font-semibold text-xl">Lista de Reservas Activas</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar reserva..." class="p-2 border border-gray-300 rounded" />
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">ID</th>
                        <th class="px-4 py-2">Nombre</th>
                        <th class="px-4 py-2">Apellido Paterno</th>
                        <th class="px-4 py-2">Apellido Materno</th>
                        <th class="px-4 py-2">RFC</th>
                        <th class="px-4 py-2">Tipo de Habitacion</th>
                        <th class="px-4 py-2">Numero de Habitacion</th>
                        <th class="px-4 py-2">Estado de la Reserva</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-if="filteredReservas.length === 0">
                        <td class="border px-4 py-2 text-center" colspan="9">No hay reservas activas disponibles.</td>
                    </tr>
                    <tr v-for="(reserva, index) in filteredReservas" :key="index">
                        <td class="border px-4 py-2">{{ reserva.id }}</td>
                        <td class="border px-4 py-2">{{ reserva.nombre }}</td>
                        <td class="border px-4 py-2">{{ reserva.apellidoPaterno }}</td>
                        <td class="border px-4 py-2">{{ reserva.apellidoMaterno }}</td>
                        <td class="border px-4 py-2">{{ reserva.rfc }}</td>
                        <td class="border px-4 py-2">{{ reserva.tipoHabitacion }}</td>
                        <td class="border px-4 py-2">{{ reserva.numeroHabitacion }}</td>
                        <td class="border px-4 py-2">{{ reserva.estadoReserva }}</td>
                        <td class="border px-4 py-2">
                            <Button icon="pi pi-pencil" @click="modificarReserva(index)" class="p-button-warning"></Button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Formulario de Edición -->
            <div v-if="editFormVisible" class="form-container">
                <div class="form-card">
                    <h3 class="text-center mb-4">Editar Reserva</h3>
                    <form @submit.prevent="guardarReserva">
                        <div class="mb-2">
                            <label for="id" class="block">ID</label>
                            <input type="text" v-model="reservaEdit.id" id="id" class="form-input" disabled />
                        </div>
                        <div class="mb-2">
                            <label for="nombre" class="block">Nombre</label>
                            <input type="text" v-model="reservaEdit.nombre" id="nombre" class="form-input" disabled />
                        </div>
                        <div class="mb-2">
                            <label for="apellidoPaterno" class="block">Apellido Paterno</label>
                            <input type="text" v-model="reservaEdit.apellidoPaterno" id="apellidoPaterno" class="form-input" disabled />
                        </div>
                        <div class="mb-2">
                            <label for="apellidoMaterno" class="block">Apellido Materno</label>
                            <input type="text" v-model="reservaEdit.apellidoMaterno" id="apellidoMaterno" class="form-input" disabled />
                        </div>
                        <div class="mb-2">
                            <label for="rfc" class="block">RFC</label>
                            <input type="text" v-model="reservaEdit.rfc" id="rfc" class="form-input" disabled />
                        </div>
                        <div class="mb-2">
                            <label for="tipoHabitacion" class="block">Tipo de Habitación</label>
                            <input type="text" v-model="reservaEdit.tipoHabitacion" id="tipoHabitacion" class="form-input" />
                        </div>
                        <div class="mb-2">
                            <label for="numeroHabitacion" class="block">Número de Habitación</label>
                            <input type="text" v-model="reservaEdit.numeroHabitacion" id="numeroHabitacion" class="form-input" />
                        </div>
                        <div class="text-center mt-4">
                            <button type="submit" class="save-button">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>

            <div v-if="mensajeError" class="text-red-500">{{ mensajeError }}</div>
        </div>
    </Fluid>
</template>

<style scoped>
.card {
    padding: 2em;
    border-radius: 10px;
    background-color: rgba(255, 255, 255, 0.8);
}

table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    text-align: left;
    padding: 8px;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

button {
    margin: 5px;
}

/* Estilos para el formulario */
.form-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
}

.form-card {
    background-color: white;
    padding: 2em;
    border-radius: 10px;
    width: 400px;
}

.form-input {
    width: 100%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.save-button {
    background-color: cornflowerblue;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.save-button:hover {
    background-color: deepskyblue;
}
</style>
