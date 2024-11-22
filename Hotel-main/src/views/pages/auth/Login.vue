<script setup>
import axios from 'axios'; // Importa axios para llamadas a la API
import { ref } from 'vue';

const email = ref('');
const password = ref('');
const loginMessage = ref('');  // Mensaje para mostrar al usuario

const login = async () => {
    try {
        const response = await axios.post('/api/login', {
            email: email.value,
            password: password.value
        });
        if (response.data.success) {
            loginMessage.value = 'Inicio de sesión exitoso';
        } else if (response.data.error) {
            loginMessage.value = 'Usuario no registrado o credenciales incorrectas';
        }
    } catch (error) {
        loginMessage.value = 'Error al intentar iniciar sesión';
        console.error('Error al iniciar sesión:', error);
    }
};
</script>

<template>
    <div class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden">
        <div class="flex flex-col items-center justify-center">
            <div style="border-radius: 56px; padding: 0.3rem; background: linear-gradient(180deg, grey 10%, rgba(33, 150, 243, 0) 30%)">
                <div class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20" style="border-radius: 53px">
                    <div class="text-center mb-8">
                        <img src="@/assets/hotel-logo.png" alt="Hotel Logo" class="mb-8 w-48 shrink-0 mx-auto" />
                        <div class="text-surface-900 dark:text-surface-0 text-3xl font-medium mb-4"><strong>Iniciar Sesión</strong></div>
                    </div>

                    <div>
                        <label for="email1" class="block text-surface-900 dark:text-surface-0 text-xl font-medium mb-2">Email</label>
                        <InputText id="email1" type="text" placeholder="Dirección de correo" class="w-full md:w-[30rem] mb-8" v-model="email" />

                        <label for="password1" class="block text-surface-900 dark:text-surface-0 font-medium text-xl mb-2">Contraseña</label>
                        <Password id="password1" v-model="password" placeholder="Contraseña" :toggleMask="true" class="mb-4" fluid :feedback="false"></Password>
                        
                        <button class="login-button" @click="login">Ingresar</button>
                        <p class="mt-4">{{ loginMessage }}</p>  <!-- Mensaje para el usuario -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.pi-eye {
    transform: scale(1.6);
    margin-right: 1rem;
}

.pi-eye-slash {
    transform: scale(1.6);
    margin-right: 1rem;
}

.login-button {
    background-color: grey;
    color: white;
    font-weight: bold;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    width: 100%;
}
</style>
