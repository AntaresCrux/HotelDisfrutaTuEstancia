<script setup>
import axios from 'axios';
import { computed, onMounted, ref } from 'vue';

const clientes = ref([]);

const searchQuery = ref('');
//Api
const apiUrl = 'http://localhost:3000/api/cliente-mostrar';
const clienteEdit = ref({
    id_cliente: '',
    nombre: '',
    ap_pat: '',
    ap_mat: '',
    telefono: '',
    rfc: '',
    email: '',
    direccion: ''
});
const showModal = ref(false);

const filteredClientes = computed(() => {
    if (!searchQuery.value) {
        return clientes.value;
    }
    return clientes.value.filter(
        (cliente) =>
            cliente.id_cliente.toString().includes(searchQuery.value) ||
            cliente.nombre.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
            cliente.ap_pat.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
            cliente.ap_mat.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
            cliente.telefono.includes(searchQuery.value) ||
            cliente.email.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
});

const eliminarCliente = (index) => {
    clientes.value.splice(index, 1);
};

const modificarCliente = (index) => {
    clienteEdit.value = { ...clientes.value[index], index };
    showModal.value = true;
};

const fetchClientes = async () => {
    try {
        const response = await axios.get(apiUrl);
        //api
        clientes.value = response.data.map((cliente) => ({
            id_cliente: cliente.id_cliente,
            nombre: cliente.nombre,
            ap_pat: cliente.ap_pat,
            ap_mat: cliente.ap_mat,
            telefono: cliente.telefono,
            rfc: cliente.rfc,
            email: cliente.email,
            direccion: cliente.direccion
        }));
    } catch (error) {
        console.error('Error al obtener clientes:', error);
    }
};

const guardarCliente = () => {
    const { index, ...clienteModificado } = clienteEdit.value;
    clientes.value[index] = clienteModificado;
    cancelarEdicion();
};

const cancelarEdicion = () => {
    clienteEdit.value = { id_cliente: '', nombre: '', ap_pat: '', ap_mat: '', telefono: '', rfc: '', email: '', direccion: '' };
    showModal.value = false;
};

onMounted(() => {
    fetchClientes();
});
</script>

<template>
    <Fluid>
        <div class="mt-8 card flex flex-col gap-4 w-full" style="background-color: rgba(255, 255, 255, 0.8)">
            <div class="font-semibold text-xl">Lista de Clientes</div>
            <div class="flex flex-col gap-2">
                <input type="text" v-model="searchQuery" placeholder="Buscar cliente..." class="p-2 border border-gray-300 rounded" />
            </div>
            <table class="table-auto w-full">
                <thead>
                    <tr>
                        <th class="px-4 py-2">ID Cliente</th>
                        <th class="px-4 py-2">Nombre</th>
                        <th class="px-4 py-2">Apellido Paterno</th>
                        <th class="px-4 py-2">Apellido Materno</th>
                        <th class="px-4 py-2">Teléfono</th>
                        <th class="px-4 py-2">RFC</th>
                        <th class="px-4 py-2">Email</th>
                        <th class="px-4 py-2">Dirección</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-if="filteredClientes.length === 0">
                        <td class="border px-4 py-2 text-center" colspan="9">No hay clientes disponibles.</td>
                    </tr>
                    <tr v-for="(cliente, index) in filteredClientes" :key="index">
                        <td class="border px-4 py-2">{{ cliente.id_cliente }}</td>
                        <td class="border px-4 py-2">{{ cliente.nombre }}</td>
                        <td class="border px-4 py-2">{{ cliente.ap_pat }}</td>
                        <td class="border px-4 py-2">{{ cliente.ap_mat }}</td>
                        <td class="border px-4 py-2">{{ cliente.telefono }}</td>
                        <td class="border px-4 py-2">{{ cliente.rfc }}</td>
                        <td class="border px-4 py-2">{{ cliente.email }}</td>
                        <td class="border px-4 py-2">{{ cliente.direccion }}</td>
                        <td class="border px-4 py-2 flex gap-2">
                            <Button icon="pi pi-pencil" @click="modificarCliente(index)" class="p-button-warning"></Button>
                            <Button icon="pi pi-trash" @click="eliminarCliente(index)" class="p-button-danger"></Button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Modal -->
        <div v-if="showModal" class="fixed inset-0 flex items-center justify-center bg-gray-800 bg-opacity-75">
            <div class="bg-white p-4 rounded-lg w-1/3">
                <div class="font-semibold text-xl">Modificar Cliente</div>
                <div class="flex flex-col gap-1 mt-4">
                    <label>ID Cliente</label>
                    <input type="text" v-model="clienteEdit.id_cliente" class="p-1 border border-gray-300 rounded" readonly />

                    <label>Nombre</label>
                    <input type="text" v-model="clienteEdit.nombre" class="p-1 border border-gray-300 rounded" />

                    <label>Apellido Paterno</label>
                    <input type="text" v-model="clienteEdit.ap_pat" class="p-1 border border-gray-300 rounded" />

                    <label>Apellido Materno</label>
                    <input type="text" v-model="clienteEdit.ap_mat" class="p-1 border border-gray-300 rounded" />

                    <label>Teléfono</label>
                    <input type="text" v-model="clienteEdit.telefono" class="p-1 border border-gray-300 rounded" />

                    <label>RFC</label>
                    <input type="text" v-model="clienteEdit.rfc" class="p-1 border border-gray-300 rounded" readonly />

                    <label>Email</label>
                    <input type="text" v-model="clienteEdit.email" class="p-1 border border-gray-300 rounded" />

                    <label>Dirección</label>
                    <input type="text" v-model="clienteEdit.direccion" class="p-1 border border-gray-300 rounded" />
                    <div class="flex justify-end gap-1 mt-2">
                        <Button label="Guardar" @click="guardarCliente" class="p-button" :style="{ backgroundColor: 'cornflowerblue', borderColor: 'cornflowerblue' }"></Button>
                        <Button label="Cancelar" @click="cancelarEdicion" class="p-button" :style="{ backgroundColor: 'red', borderColor: 'red' }"></Button>
                    </div>
                </div>
            </div>
        </div>
    </Fluid>
</template>

<style scoped>
/* Estilos */
.card {
    padding: 2em;
    border-radius: 10px;
    background-color: rgba(255, 255, 255, 0.8);
}
table {
    width: 100%;
    border-collapse: collapse;
}
th,
td {
    text-align: left;
    padding: 8px;
    border-bottom: 1px solid #ddd;
}
th {
    background-color: #f2f2f2;
    font-weight: bold;
}
</style>
