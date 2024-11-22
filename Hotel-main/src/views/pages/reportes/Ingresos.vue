<script setup>
import { computed, ref } from 'vue';

const ingresos = ref([]); // Lista vacía de ingresos

const totalIngresosAnuales = computed(() => {
    return ingresos.value.reduce((total, ingreso) => {
        return total + ingreso.monto;
    }, 0);
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Ingresos</div>
            <div class="mb-4">
                <p>Total de ingresos anuales: {{ totalIngresosAnuales }}</p>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Fecha de Ingreso</th>
                        <th class="px-4 py-2">Monto</th>
                        <th class="px-4 py-2">Descripción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(ingreso, index) in ingresos" :key="index">
                        <td class="border px-4 py-2">{{ ingreso.fecha }}</td>
                        <td class="border px-4 py-2">{{ ingreso.monto }}</td>
                        <td class="border px-4 py-2">{{ ingreso.descripcion }}</td>
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
