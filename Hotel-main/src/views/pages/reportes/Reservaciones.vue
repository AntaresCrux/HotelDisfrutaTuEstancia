<script setup>
import { computed, ref } from 'vue';

const reservaciones = ref([]); // Lista vacía de reservaciones

const mesMasReservaciones = computed(() => {
    const conteoPorMes = reservaciones.value.reduce((conteo, reserva) => {
        const mes = new Date(reserva.fechaReserva).getMonth() + 1; // Obtener el mes (1-12)
        conteo[mes] = (conteo[mes] || 0) + 1;
        return conteo;
    }, {});

    const mesConMasReservas = Object.keys(conteoPorMes).reduce((a, b) => conteoPorMes[a] > conteoPorMes[b] ? a : b, 0);
    return mesConMasReservas;
});

const mesSeleccionado = ref('');
const reservacionesDelMes = computed(() => {
    return reservaciones.value.filter(reserva => {
        const mes = new Date(reserva.fechaReserva).getMonth() + 1;
        return mes == mesSeleccionado.value;
    });
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Reporte de Reservaciones</div>
            <div class="mb-4">
                <p>El mes con más reservaciones: {{ mesMasReservaciones }}</p>
                <label for="mes">Seleccione un mes:</label>
                <select v-model="mesSeleccionado" id="mes" class="p-2 border border-gray-300 rounded">
                    <option value="">Selecciona un mes</option>
                    <option v-for="mes in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]" :key="mes" :value="mes">{{ mes }}</option>
                </select>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Fecha de Reserva</th>
                        <th class="px-4 py-2">Nombre del Cliente</th>
                        <th class="px-4 py-2">Tipo de Habitación</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(reserva, index) in reservacionesDelMes" :key="index">
                        <td class="border px-4 py-2">{{ reserva.fechaReserva }}</td>
                        <td class="border px-4 py-2">{{ reserva.nombreCliente }}</td>
                        <td class="border px-4 py-2">{{ reserva.tipoHabitacion }}</td>
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
