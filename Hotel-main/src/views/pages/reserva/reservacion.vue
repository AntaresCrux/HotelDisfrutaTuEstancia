<script>
import axios from 'axios';
import { onMounted, ref } from 'vue';

export default {
    setup() {
        const reservaHab = ref({
            /*nombreCliente: '',
            apellidoPaterno: '',
            apellidoMaterno: '',
            telefono: '',
            rfc: '',
            direccion: '',
            emailCliente: '',
            fechaLlegada: '',
            fechaSalida: '',
            tipoHabitacion: ''*/
            p_nombre: '', // Cambiado de nombreCliente a p_nombre
            p_ap_pat: '', // Cambiado de apellidoPaterno a p_ap_pat
            p_ap_mat: '', // Cambiado de apellidoMaterno a p_ap_mat
            p_telefono: '', // Cambiado de telefono a p_telefono
            p_rfc: '', // Cambiado de rfc a p_rfc
            p_direccion: '', // Cambiado de direccion a p_direccion
            p_email: '', // Cambiado de emailCliente a p_email
            p_fecha_llegada: '', // Cambiado de fechaLlegada a p_fecha_llegada
            p_fecha_salida: '', // Cambiado de fechaSalida a p_fecha_salida
            p_tipo_hab: '' // Cambiado de tipoHabitacion a p_tipo_hab
        });

        const tiposHabitacion = ref([]);

        const validarFechas = () => {
            if (new Date(reservaHab.value.fechaLlegada) >= new Date(reservaHab.value.fechaSalida)) {
                alert('La Fecha de Salida debe ser posterior a la Fecha de Llegada');
                reservaHab.value.fechaSalida = '';
            }
        };

        const fetchTiposHabitacion = async () => {
            try {
                const response = await axios.get('http://localhost:3000/api/habitacion-tipo');
                //const response = await axios.get('http://0.0.0.0:3000/api/habitacion-tipo');
                tiposHabitacion.value = response.data;
            } catch (error) {
                alert('Error al obtener los tipos de habitación');
            }
        };

        const registerReservaHab = async () => {
            try {
                const response = await axios.post('http://localhost:3000/api/reservacion-nueva', reservaHab.value);
                //const response = await axios.post('http://0.0.0.0:3000/api/reservacion-nueva', reservaHab.value); //API
                if (response.status === 200) {
                    alert('Registro de reserva de habitación exitoso');
                    limpiarFormulario();
                } else {
                    alert('Hubo un problema al registrar la reserva');
                }
            } catch (error) {
                alert('Error al conectar con el servidor');
            }
        };

        const limpiarFormulario = () => {
            reservaHab.value = {
                p_nombre: '', // Cambiado de nombreCliente a p_nombre
                p_ap_pat: '', // Cambiado de apellidoPaterno a p_ap_pat
                p_ap_mat: '', // Cambiado de apellidoMaterno a p_ap_mat
                p_telefono: '', // Cambiado de telefono a p_telefono
                p_rfc: '', // Cambiado de rfc a p_rfc
                p_direccion: '', // Cambiado de direccion a p_direccion
                p_email: '', // Cambiado de emailCliente a p_email
                p_fecha_llegada: '', // Cambiado de fechaLlegada a p_fecha_llegada
                p_fecha_salida: '', // Cambiado de fechaSalida a p_fecha_salida
                p_tipo_hab: '' // Cambiado de tipoHabitacion a p_tipo_hab
            };
        };

        /*
        const verificarCliente = async () => {
            try {
                const response = await axios.post('TU_ENDPOINT_API/verificarCliente', {
                    email: reservaHab.value.emailCliente,
                    rfc: reservaHab.value.rfc
                });
                if (response.data.exists) {
                    alert('Cliente ya existe en la base de datos');
                } else {
                    alert('Cliente no encontrado, se procederá a registrar uno nuevo');
                }
            } catch (error) {
                alert('Error al verificar el cliente');
            }
        };
        */
        onMounted(() => {
            fetchTiposHabitacion();
        });

        //return { reservaHab, tiposHabitacion, registerReservaHab, validarFechas, verificarCliente };
        return { reservaHab, tiposHabitacion, registerReservaHab, validarFechas };
    }
};
</script>

<template>
    <Fluid>
        <div class="flex justify-center items-center h-full">
            <div class="card flex flex-col gap-4 items-center w-full max-w-4xl" style="background-color: rgba(255, 255, 255, 0.8)">
                <div class="font-semibold text-xl text-center"><strong>Registro de Reserva de Habitación</strong></div>
                <div class="flex flex-wrap gap-4 justify-center">
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="nombreCliente">Nombre del Cliente</label>
                        <InputText id="nombreCliente" type="text" v-model="reservaHab.p_nombre" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="apellidoPaterno">Apellido Paterno</label>
                        <InputText id="apellidoPaterno" type="text" v-model="reservaHab.p_ap_pat" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="apellidoMaterno">Apellido Materno</label>
                        <InputText id="apellidoMaterno" type="text" v-model="reservaHab.p_ap_mat" class="w-full" />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="telefono">Teléfono</label>
                        <InputText id="telefono" type="text" v-model="reservaHab.p_telefono" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="rfc">RFC</label>
                        <InputText id="rfc" type="text" v-model="reservaHab.p_rfc" class="w-full" required @blur="verificarCliente" />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="direccion">Dirección</label>
                        <InputText id="direccion" type="text" v-model="reservaHab.p_direccion" class="w-full" required />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="emailCliente">Email del Cliente</label>
                        <InputText id="emailCliente" type="email" v-model="reservaHab.p_email" class="w-full" required @blur="verificarCliente" />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="fechaLlegada">Fecha de Llegada</label>
                        <InputText id="fechaLlegada" type="date" v-model="reservaHab.p_fecha_llegada" class="w-full" required @change="validarFechas" />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="fechaSalida">Fecha de Salida</label>
                        <InputText id="fechaSalida" type="date" v-model="reservaHab.p_fecha_salida" class="w-full" required @change="validarFechas" />
                    </div>
                    <div class="w-full md:w-1/2 lg:w-1/3">
                        <label for="tipoHabitacion">Tipo de Habitación Preferida</label>
                        <select id="tipoHabitacion" v-model="reservaHab.p_tipo_hab" class="w-full" required>
                            <option value="" disabled>Selecciona el tipo de habitación</option>
                            <option v-for="habitacion in tiposHabitacion" :key="habitacion.id_thab" :value="habitacion.id_thab">
                                {{ habitacion.desc_hab }}
                            </option>
                        </select>
                    </div>
                </div>
                <Button label="Registrar" @click="registerReservaHab" class="mt-4 register-button"> Registrar </Button>
            </div>
        </div>
    </Fluid>
</template>

<style scoped>
.register-button {
    background-color: cornflowerblue;
    color: white;
    font-weight: bold;
    padding: 10px 20px; /* Tamaño original de padding */
    border: none;
    border-radius: 5px;
    cursor: pointer;
    width: 150px; /* Ancho fijo para hacer el botón más pequeño de largo */
    text-align: center;
}

.register-button:active {
    background-color: #4d4d4d;
}
</style>
