<script setup>
import { computed, onMounted, ref } from 'vue';

const estancias = ref([]);

const estancia = ref({
    nombreCliente: '',
    numeroHabitacion: '',
    fechaLlegada: '',
    horaLlegada: '',
    serviciosConsumidos: [],
    diasEstancia: 0
});

const serviciosCatalogo = [
    'Llamadas',
    'Taxi',
    'Comida',
    'Servicio de Lavandería',
    'Tours',
    'Spa',
    'Gimnasio'
];

const searchQuery = ref('');
const selectedIndex = ref(null);

const filteredEstancias = computed(() => {
    if (!searchQuery.value) {
        return estancias.value;
    }
    return estancias.value.filter(estancia => 
        estancia.nombreCliente.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        estancia.numeroHabitacion.includes(searchQuery.value)
    );
});

const agregarServicio = (servicio) => {
    if (!estancia.value.serviciosConsumidos.includes(servicio)) {
        estancia.value.serviciosConsumidos.push(servicio);
    }
};

const eliminarServicio = (servicio) => {
    const index = estancia.value.serviciosConsumidos.indexOf(servicio);
    if (index > -1) {
        estancia.value.serviciosConsumidos.splice(index, 1);
    }
};

const registrarEstancia = () => {
    if (estancia.value.nombreCliente && estancia.value.numeroHabitacion) {
        if (selectedIndex.value === null) {
            estancias.value.push({ ...estancia.value });
        } else {
            estancias.value[selectedIndex.value] = { ...estancia.value };
            selectedIndex.value = null;
        }
        limpiarFormulario();
    } else {
        alert("Por favor, completa los campos requeridos.");
    }
};

const limpiarFormulario = () => {
    estancia.value = {
        nombreCliente: '',
        numeroHabitacion: '',
        fechaLlegada: '',
        horaLlegada: '',
        serviciosConsumidos: [],
        diasEstancia: 0
    };
};

const eliminarEstancia = (index) => {
    estancias.value.splice(index, 1);
};

const modificarEstancia = (index) => {
    estancia.value = { ...estancias.value[index] };
    selectedIndex.value = index;
};

onMounted(() => {
    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    estancia.value.horaLlegada = `${hours}:${minutes}`;
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Registro de Estancia</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar estancia..." class="p-2 border border-gray-300 rounded"/>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Nombre del Cliente</th>
                        <th class="px-4 py-2">Número de Habitación</th>
                        <th class="px-4 py-2">Fecha de Llegada</th>
                        <th class="px-4 py-2">Hora de Llegada</th>
                        <th class="px-4 py-2">Días de Estancia</th>
                        <th class="px-4 py-2">Servicios Consumidos</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(estancia, index) in filteredEstancias" :key="index">
                        <td class="border px-4 py-2">{{ estancia.nombreCliente }}</td>
                        <td class="border px-4 py-2">{{ estancia.numeroHabitacion }}</td>
                        <td class="border px-4 py-2">{{ estancia.fechaLlegada }}</td>
                        <td class="border px-4 py-2">{{ estancia.horaLlegada }}</td>
                        <td class="border px-4 py-2">{{ estancia.diasEstancia }}</td>
                        <td class="border px-4 py-2">
                            <ul>
                                <li v-for="(servicio, sIndex) in estancia.serviciosConsumidos" :key="sIndex">{{ servicio }}</li>
                            </ul>
                        </td>
                        <td class="border px-4 py-2 flex gap-2">
                            <Button icon="pi pi-pencil" @click="modificarEstancia(index)" class="p-button-warning"></Button>
                            <Button icon="pi pi-trash" @click="eliminarEstancia(index)" class="p-button-danger"></Button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="card flex flex-col gap-4 w-full mt-8" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl text-center"><strong>Registrar Estancia</strong></div>
            <div class="flex flex-wrap gap-4">
                <div class="w-full md:w-1/2 lg:w-1/3">
                    <label for="nombreCliente">Nombre del Cliente</label>
                    <InputText id="nombreCliente" type="text" v-model="estancia.nombreCliente" class="w-full"/>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3">
                    <label for="numeroHabitacion">Número de Habitación</label>
                    <InputText id="numeroHabitacion" type="text" v-model="estancia.numeroHabitacion" class="w-full"/>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3">
                    <label for="fechaLlegada">Fecha de Llegada</label>
                    <InputText id="fechaLlegada" type="date" v-model="estancia.fechaLlegada" class="w-full"/>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3">
                    <label for="horaLlegada">Hora de Llegada</label>
                    <InputText id="horaLlegada" type="time" v-model="estancia.horaLlegada" class="w-full"/>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3">
                    <label for="diasEstancia">Días de Estancia</label>
                    <InputText id="diasEstancia" type="number" v-model="estancia.diasEstancia" class="w-full"/>
                </div>
                <div class="w-full">
                    <label for="serviciosConsumidos">Servicios Consumidos</label>
                    <div v-for="servicio in serviciosCatalogo" :key="servicio">
                        <input type="checkbox" :id="servicio" :value="servicio" v-model="estancia.serviciosConsumidos">
                        <label :for="servicio">{{ servicio }}</label>
                    </div>
                </div>
            </div>
            <Button label="Registrar Estancia" @click="registrarEstancia" class="mt-4 register-button">
                {{ selectedIndex.value === null ? 'Registrar Estancia' : 'Modificar Estancia' }}
            </Button>
        </div>
    </Fluid>
</template>

<style scoped>
.card {
    padding: 2em;
    border-radius: 10px;
    background-color: rgba(255, 255, 255, 0.8);
}

label, input {
    margin: 0.5em 0;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th, td {
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

.register-button {
    background-color: #808080;
    border-radius: 15px;
    font-weight: bold;
    width: 50%;
    font-size: 1.2em;
    height: 50px;
    border: none;
    color: #fff;
    cursor: pointer;
    margin: 1em auto 0;
}
</style>
