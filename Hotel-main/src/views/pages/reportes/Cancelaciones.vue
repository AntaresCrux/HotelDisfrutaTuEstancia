<script setup>
import { ref } from 'vue';

const cancelaciones = ref([]); // Lista vacía de cancelaciones
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Cancelaciones</div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Fecha de Cancelación</th>
                        <th class="px-4 py-2">Hora de Cancelación</th>
                        <th class="px-4 py-2">Nombre del Cliente</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(cancelacion, index) in cancelaciones" :key="index">
                        <td class="border px-4 py-2">{{ cancelacion.fechaCancelacion }}</td>
                        <td class="border px-4 py-2">{{ cancelacion.horaCancelacion }}</td>
                        <td class="border px-4 py-2">{{ cancelacion.nombreCliente }}</td>
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
