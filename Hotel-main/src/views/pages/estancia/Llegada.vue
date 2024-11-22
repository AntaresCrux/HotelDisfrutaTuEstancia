<script setup>
import { ref } from 'vue';

const llegada = ref({
    nombreCliente: '',
    numHabitacion: '',
    fechaLlegada: '',
    horaLlegada: ''
});

const registerLlegada = () => {
    alert('Registro de llegada exitoso');
    limpiarFormulario();
};

const limpiarFormulario = () => {
    llegada.value = {
        nombreCliente: '',
        numHabitacion: '',
        fechaLlegada: '',
        horaLlegada: ''
    };
};
</script>

<template>
    <Fluid>
        <div class="flex justify-center items-center h-full">
            <div class="card flex flex-col gap-4 w-full max-w-4xl" style="background-color: rgba(255, 255, 255, 0.8);">
                <div class="font-semibold text-xl text-center"><strong>Registro de Llegada</strong></div>
                <div class="flex flex-wrap gap-4">
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="nombreCliente">Nombre del Cliente</label>
                        <InputText id="nombreCliente" type="text" v-model="llegada.nombreCliente" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="numHabitacion">Número de Habitación</label>
                        <InputText id="numHabitacion" type="text" v-model="llegada.numHabitacion" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="fechaLlegada">Fecha de Llegada</label>
                        <InputText id="fechaLlegada" type="date" v-model="llegada.fechaLlegada" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="horaLlegada">Hora de Llegada</label>
                        <InputText id="horaLlegada" type="time" v-model="llegada.horaLlegada" class="w-full" required />
                    </div>
                </div>
                <Button label="Registrar" @click="registerLlegada" class="mt-4 register-button">
                    Registrar
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
