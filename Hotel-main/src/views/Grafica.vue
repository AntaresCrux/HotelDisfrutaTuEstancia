<script setup>
import axios from 'axios';
import { onMounted, ref } from 'vue';

const barData = ref(null);
const barOptions = ref(null);

onMounted(async () => {
    await fetchDataFromAPI();
    setColorOptions();
});

// Función para obtener los datos de la API
async function fetchDataFromAPI() {
    try {
        // Aquí llamamos a la API que devuelve los tipos de habitaciones más solicitadas
        const response = await axios.get('http://localhost:3000/api/tipo-mas-ocupada'); // Cambia por tu endpoint
        const data = response.data;

        // Procesamos los datos para la gráfica
        const labels = data.map((habitacion) => habitacion.tipo_habitacion);
        const counts = data.map((habitacion) => habitacion.veces_reservada);

        // Configuración de los datos de la gráfica
        barData.value = {
            labels: labels,
            datasets: [
                {
                    label: 'Veces Reservada',
                    backgroundColor: 'rgba(75, 192, 192, 0.8)', // Verde
                    borderColor: 'rgba(75, 192, 192, 1)',
                    data: counts
                }
            ]
        };
    } catch (error) {
        console.error('Error al obtener datos de la API:', error);
    }
}

// Configuración de las opciones de la gráfica
function setColorOptions() {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');

    barOptions.value = {
        plugins: {
            legend: {
                labels: {
                    fontColor: textColor
                }
            },
            title: {
                display: true,
                text: 'Habitaciones más solicitadas por tipo',
                color: textColor,
                font: {
                    size: 20
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: textColorSecondary,
                    font: {
                        weight: 500
                    }
                },
                grid: {
                    display: false,
                    drawBorder: false
                }
            },
            y: {
                ticks: {
                    color: textColorSecondary
                },
                grid: {
                    color: surfaceBorder,
                    drawBorder: false
                }
            }
        }
    };
}
</script>

<template>
    <Fluid class="grid grid-cols-12 gap-8">
        <div class="col-span-12">
            <div class="card w-full h-full flex justify-center items-center">
                <Chart type="bar" :data="barData" :options="barOptions" class="w-full"></Chart>
            </div>
        </div>
    </Fluid>
</template>
