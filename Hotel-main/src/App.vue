<script>
export default {
    name: 'App'
};
</script>

<template>
    <div id="app" class="background">
        <router-view />
    </div>
</template>

<style>
.background {
    background-image: url('@/assets/inicio.jpg');
    background-size: 100% 100%; /* Ajusta el tamaño de la imagen a 100% del ancho y 100% de la altura */
    background-position: center; /* Centra la imagen de fondo */
    background-repeat: no-repeat; /* Evita que la imagen se repita */
    min-height: 100vh; /* Asegúrate de que el fondo cubra toda la altura de la ventana */
}
</style>
