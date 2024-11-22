<template>
    <div class="layout-topbar">
        <div class="layout-topbar-logo-container">
            <button class="layout-menu-button layout-topbar-action" @click="onMenuToggle">
                <i class="pi pi-bars"></i>
            </button>
            <router-link to="/" class="layout-topbar-logo">
                <img src="@/assets/hotel-logo.png" alt="Hotel Logo" style="width: 150px; height: 60px" />
            </router-link>
        </div>

        <div class="layout-topbar-actions">
            <button type="button" class="layout-topbar-action">
                <i class="pi pi-user"></i>
            </button>
        </div>
    </div>
</template>

<style>
.layout-topbar {
    background-color: rgba(21, 20, 20, 0.8);
    border-radius: 5px; /* Radio del borde redondeado */
    padding: 16px; /* Espacio interno */
    width: 500px; /* Ancho del rectángulo */
    height: 200px; /* Altura del rectángulo */
}
</style>
