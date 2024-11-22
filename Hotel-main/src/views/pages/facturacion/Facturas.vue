<script setup>
import axios from 'axios';
import { ref } from 'vue';

const factura = ref({
    fechaFactura: '',
    horaFactura: '',
    rfc: '',
    monto: '',
    descripcionServicios: ''
});

const generarFactura = async () => {
    try {
        const response = await axios.post('/api/facturas', factura.value);
        alert('Factura generada exitosamente');
        limpiarFormulario();
    } catch (error) {
        console.error('Error al generar la factura:', error);
    }
};

const limpiarFormulario = () => {
    factura.value = {
        fechaFactura: '',
        horaFactura: '',
        rfc: '',
        monto: '',
        descripcionServicios: ''
    };
};
</script>

<template>
    <Fluid>
        <div class="flex justify-center items-center h-full">
            <div class="card flex flex-col gap-4 w-full max-w-4xl" style="background-color: rgba(255, 255, 255, 0.8);">
                <div class="font-semibold text-xl text-center"><strong>Generación de Facturas</strong></div>
                <div class="flex flex-wrap gap-4">
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="fechaFactura">Fecha de la Facturación</label>
                        <InputText id="fechaFactura" type="date" v-model="factura.fechaFactura" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="horaFactura">Hora de la Facturación</label>
                        <InputText id="horaFactura" type="time" v-model="factura.horaFactura" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="rfc">RFC</label>
                        <InputText id="rfc" type="text" v-model="factura.rfc" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="monto">Monto</label>
                        <InputText id="monto" type="number" v-model="factura.monto" class="w-full" required />
                    </div>
                    <div class="w-full">
                        <label for="descripcionServicios">Descripción de Servicios Consumidos</label>
                        <Textarea id="descripcionServicios" rows="2" v-model="factura.descripcionServicios" class="w-full"/>
                    </div>
                </div>
                <Button label="Registrar Factura" @click="generarFactura" class="mt-4 register-button">
                    Registrar Factura
                </Button>
            </div>
        </div>
    </Fluid>
</template>

<style scoped>
.card {
    padding: 2em;
    border-radius: 10px;
    background-color: rgba(255, 255, 255, 0.8);
    width: 100%;
}

label, input, textarea {
    margin: 0.5em 0;
}

.register-button {
    background-color: grey;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
</style>
