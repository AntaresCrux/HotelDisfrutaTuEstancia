<script setup>
import { computed, ref } from 'vue';

const habitaciones = ref([]); // Lista vacía de habitaciones

const camasOcupadas = computed(() => {
    return habitaciones.value.filter(habitacion => habitacion.estado === 'ocupada').length;
});

const camasLibres = computed(() => {
    return habitaciones.value.filter(habitacion => habitacion.estado === 'libre').length;
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Ocupación de Habitaciones</div>
            <div class="mb-4">
                <p>Total de camas ocupadas: {{ camasOcupadas }}</p>
                <p>Total de camas libres: {{ camasLibres }}</p>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Número de Habitación</th>
                        <th class="px-4 py-2">Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(habitacion, index) in habitaciones" :key="index">
                        <td class="border px-4 py-2">{{ habitacion.numero }}</td>
                        <td class="border px-4 py-2">{{ habitacion.estado }}</td>
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
</style>
