<script setup>
import { ref } from 'vue';

const liberacion = ref({
    fechaLiberacion: '',
    horaLiberacion: '',
    numeroHabitacion: ''
});

const registrarLiberacion = () => {
    alert('Liberación de habitación registrada exitosamente');
    limpiarFormulario();
};

const limpiarFormulario = () => {
    liberacion.value = {
        fechaLiberacion: '',
        horaLiberacion: '',
        numeroHabitacion: ''
    };
};
</script>

<template>
    <Fluid>
        <div class="flex justify-center items-center h-full">
            <div class="card flex flex-col gap-4 w-full max-w-4xl" style="background-color: rgba(255, 255, 255, 0.8);">
                <div class="font-semibold text-xl text-center"><strong>Registro de Liberación</strong></div>
                <div class="flex flex-wrap gap-4">
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="fechaLiberacion">Fecha de la Liberación</label>
                        <InputText id="fechaLiberacion" type="date" v-model="liberacion.fechaLiberacion" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="horaLiberacion">Hora de la Liberación</label>
                        <InputText id="horaLiberacion" type="time" v-model="liberacion.horaLiberacion" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="numeroHabitacion">Número de Habitación</label>
                        <InputText id="numeroHabitacion" type="text" v-model="liberacion.numeroHabitacion" class="w-full" required />
                    </div>
                </div>
                <Button label="Registrar Liberación" @click="registrarLiberacion" class="mt-4 register-button">
                    Registrar Liberación
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
    background-color: grey;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
</style>
