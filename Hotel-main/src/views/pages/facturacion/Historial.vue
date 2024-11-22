<script setup>
import { computed, ref } from 'vue';

const facturas = ref([]); // Lista vacía de facturas

const searchQuery = ref('');

const filteredFacturas = computed(() => {
    if (!searchQuery.value) {
        return facturas.value;
    }
    return facturas.value.filter(factura => 
        factura.rfc.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        factura.descripcionServicios.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
        factura.fechaFactura.includes(searchQuery.value)
    );
});

const eliminarFactura = (index) => {
    facturas.value.splice(index, 1);
};
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8);">
            <div class="font-semibold text-xl">Historial de Facturas</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar factura..." class="p-2 border border-gray-300 rounded"/>
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">Fecha de la Facturación</th>
                        <th class="px-4 py-2">Hora de la Facturación</th>
                        <th class="px-4 py-2">RFC</th>
                        <th class="px-4 py-2">Monto</th>
                        <th class="px-4 py-2">Descripción de Servicios</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(factura, index) in filteredFacturas" :key="index">
                        <td class="border px-4 py-2">{{ factura.fechaFactura }}</td>
                        <td class="border px-4 py-2">{{ factura.horaFactura }}</td>
                        <td class="border px-4 py-2">{{ factura.rfc }}</td>
                        <td class="border px-4 py-2">{{ factura.monto }}</td>
                        <td class="border px-4 py-2">{{ factura.descripcionServicios }}</td>
                        <td class="border px-4 py-2">
                            <Button icon="pi pi-trash" @click="eliminarFactura(index)" class="p-button-danger"></Button>
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
