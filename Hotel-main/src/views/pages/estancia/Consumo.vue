<script setup>
import { ref } from 'vue';

const servicio = ref({
    nombreCliente: '',
    servicio: '',
    cantidad: 0
});

const servicios = ref([]);

const registerServicio = () => {
    servicios.value.push({ ...servicio.value });
    alert('Servicio registrado exitosamente');
    limpiarFormulario();
};

const limpiarFormulario = () => {
    servicio.value = {
        nombreCliente: '',
        servicio: '',
        cantidad: 0
    };
};
</script>

<template>
    <Fluid>
        <div class="flex justify-center items-center h-full">
            <div class="card flex flex-col gap-4 w-full max-w-4xl" style="background-color: rgba(255, 255, 255, 0.8);">
                <div class="font-semibold text-xl text-center"><strong>Servicios Consumidos</strong></div>
                <div class="flex flex-wrap gap-4">
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="nombreCliente">Nombre del Cliente</label>
                        <InputText id="nombreCliente" type="text" v-model="servicio.nombreCliente" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="servicio">Servicio</label>
                        <InputText id="servicio" type="text" v-model="servicio.servicio" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="cantidad">Cantidad</label>
                        <InputText id="cantidad" type="number" v-model="servicio.cantidad" class="w-full" required />
                    </div>
                </div>
                <Button label="Registrar" @click="registerServicio" class="mt-4 register-button">
                    Registrar
                </Button>

                <div class="mt-8">
                    <div class="font-semibold text-lg text-center"><strong>Servicios Registrados</strong></div>
                    <table class="table-auto w-full mt-4">
                        <thead>
                            <tr>
                                <th class="px-4 py-2">Nombre del Cliente</th>
                                <th class="px-4 py-2">Servicio</th>
                                <th class="px-4 py-2">Cantidad</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(serv, index) in servicios" :key="index">
                                <td class="border px-4 py-2">{{ serv.nombreCliente }}</td>
                                <td class="border px-4 py-2">{{ serv.servicio }}</td>
                                <td class="border px-4 py-2">{{ serv.cantidad }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
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

label, input {
    margin: 0.5em 0;
}

.register-button {
    background-color: cornflowerblue;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
</style>
