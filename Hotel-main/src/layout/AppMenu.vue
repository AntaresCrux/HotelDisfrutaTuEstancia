<script setup>
import { ref } from 'vue';
import AppMenuItem from './AppMenuItem.vue';

const model = ref([
    {
        label: 'Home',
        items: [{ label: 'Habitaciones', icon: 'pi pi-fw pi-home', to: '/' }]
    },
    {
        // hotel disfruta tu estancia
        label: 'Opciones',
        items: [
            {
                label: 'Clientes',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Clientes',
                        icon: 'pi pi-fw pi-times-circle',
                        to: '/clientes/listac'
                    }
                ]
            },
            {
                label: 'Reservación',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Alta Reservación',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reserva/reservacion'
                    },
                    {
                        label: 'Lista Reservaciones',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reserva/listare'
                    },
                    {
                        label: 'Cancelación',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reserva/cancelacionre'
                    }
                ]
            },
            {
                label: 'Estancia',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Llegada',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/estancia/llegada'
                    },
                    {
                        label: 'Consumo',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/estancia/consumo'
                    },
                    {
                        label: 'Estancia',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/estancia/estancia'
                    }
                ]
            },
            {
                label: 'Facturación',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Generación de facturas',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/facturacion/facturas'
                    },
                    {
                        label: 'Historial',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/facturacion/historial'
                    }
                ]
            },
            {
                label: 'Habitaciones',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Registro Liberación',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/habitaciones/liberacion'
                    },
                    {
                        label: 'Habitaciones',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/habitaciones/habitacion'
                    }
                ]
            },
            {
                label: 'Reportes',
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Clientes',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/clientes'
                    },
                    {
                        label: 'Reservaciones',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/reservaciones'
                    },
                    {
                        label: 'Cancelaciones',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/cancelaciones'
                    },

                    {
                        label: 'Ingresos',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/ingresos'
                    },
                    {
                        label: 'Servicios',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/serviciosr'
                    },
                    {
                        label: 'Habitaciones',
                        icon: 'pi pi-fw pi-sign-in',
                        to: '/reportes/habitaciones'
                    }
                ]
            }
        ]
    },
    {
        label: 'Información',
        icon: 'pi pi-fw pi-briefcase',
        to: '/pages',
        items: [
            {
                label: 'Mas informacion',
                icon: 'pi pi-fw pi-circle-off',
                to: '/pages/empty'
            },
            {
                label: 'Graficas',
                icon: 'pi pi-fw pi-chart-bar',
                to: '/pages/grafica'
            }
        ]
    }
]);
</script>

<template>
    <ul class="layout-menu">
        <template v-for="(item, i) in model" :key="i">
            <app-menu-item v-if="!item.separator" :item="item" :index="i"></app-menu-item>
            <li v-if="item.separator" class="menu-separator"></li>
        </template>
    </ul>
</template>

<style lang="scss" scoped></style>
