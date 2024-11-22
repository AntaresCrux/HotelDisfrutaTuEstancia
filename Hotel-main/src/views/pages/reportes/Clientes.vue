<script setup>
import { ref } from 'vue';

const clientes = ref([]); // Lista vacía de clientes
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Clientes</div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Nombre</th>
                        <th class="px-4 py-2">Apellido Paterno</th>
                        <th class="px-4 py-2">Apellido Materno</th>
                        <th class="px-4 py-2">Teléfono</th>
                        <th class="px-4 py-2">RFC</th>
                        <th class="px-4 py-2">Email</th>
                        <th class="px-4 py-2">Dirección</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(cliente, index) in clientes" :key="index">
                        <td class="border px-4 py-2">{{ cliente.nombre }}</td>
                        <td class="border px-4 py-2">{{ cliente.ap_pat }}</td>
                        <td class="border px-4 py-2">{{ cliente.ap_mat }}</td>
                        <td class="border px-4 py-2">{{ cliente.telefono }}</td>
                        <td class="border px-4 py-2">{{ cliente.rfc }}</td>
                        <td class="border px-4 py-2">{{ cliente.email }}</td>
                        <td class="border px-4 py-2">{{ cliente.direccion }}</td>
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
