<script setup>
import { computed, ref } from 'vue';

const serviciosConsumidos = ref([]); // Lista vacía de servicios consumidos

const servicioMasConsumido = computed(() => {
    const conteoPorServicio = serviciosConsumidos.value.reduce((conteo, servicio) => {
        conteo[servicio.nombre] = (conteo[servicio.nombre] || 0) + 1;
        return conteo;
    }, {});

    return Object.keys(conteoPorServicio).reduce((a, b) => conteoPorServicio[a] > conteoPorServicio[b] ? a : b, '');
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Servicios Consumidos</div>
            <div class="mb-4">
                <p>El servicio más consumido: {{ servicioMasConsumido }}</p>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Nombre del Servicio</th>
                        <th class="px-4 py-2">Cantidad Consumida</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(servicio, index) in serviciosConsumidos" :key="index">
                        <td class="border px-4 py-2">{{ servicio.nombre }}</td>
                        <td class="border px-4 py-2">{{ servicio.cantidad }}</td>
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
