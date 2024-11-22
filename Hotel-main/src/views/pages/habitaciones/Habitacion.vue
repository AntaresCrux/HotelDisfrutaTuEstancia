<script setup>
import { computed, ref } from 'vue';

const habitaciones = ref([]); // Lista vacía de habitaciones

const searchQuery = ref('');

const filteredHabitaciones = computed(() => {
    if (!searchQuery.value) {
        return habitaciones.value;
    }
    return habitaciones.value.filter(habitacion =>
        habitacion.numero.toString().includes(searchQuery.value) ||
        habitacion.estado.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

const cambiarEstado = (index) => {
    habitaciones.value[index].estado = habitaciones.value[index].estado === 'ocupada' ? 'disponible' : 'ocupada';
};
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Estado de Habitaciones</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar habitación..." class="p-2 border border-gray-300 rounded"/>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Número de Habitación</th>
                        <th class="px-4 py-2">Estado</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(habitacion, index) in filteredHabitaciones" :key="index">
                        <td class="border px-4 py-2">{{ habitacion.numero }}</td>
                        <td class="border px-4 py-2">{{ habitacion.estado }}</td>
                        <td class="border px-4 py-2">
                            <Button @click="cambiarEstado(index)" class="mr-2">{{ habitacion.estado === 'ocupada' ? 'Liberar' : 'Ocupar' }}</Button>
                        </td>
                    </tr>
                </tbody>
            </table>
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
</style>
