-- Llenado de la tabla clientes
INSERT INTO clientes (nombre, ap_pat, ap_mat, telefono, rfc, email, direccion) VALUES
('Juan', 'Pérez', 'López', '5551234567', 'JPLX890101ABC', 'juan.perez@mail.com', 'Calle 123, CDMX'),
('María', 'García', 'Ramírez', '5559876543', 'MGRX921213DEF', 'maria.garcia@mail.com', 'Av. Siempre Viva, Puebla'),
('Luis', 'Hernández', 'Gómez', '5557654321', 'LHGX870505GHI', 'luis.hernandez@mail.com', 'Blvd. Principal, Monterrey'),
('Ana', 'Martínez', 'Sánchez', '5558765432', 'AMSX920920JKL', 'ana.martinez@mail.com', 'Col. Centro, Guadalajara'),
('Pedro', 'Ramos', 'Luna', '5552345678', 'PRLX910715MNO', 'pedro.ramos@mail.com', 'Zona Sur, Mérida'),
('Laura', 'Ruiz', 'Díaz', '5553456789', 'LRDX940101PQR', 'laura.ruiz@mail.com', 'Residencial Norte, León'),
('Carmen', 'Fernández', 'Torres', '5554567890', 'CFTX950202STU', 'carmen.fernandez@mail.com', 'Av. del Sol, Cancún'),
('Andrés', 'Gómez', 'Pérez', '5555678901', 'AGPX880812VWX', 'andres.gomez@mail.com', 'Col. Roma, CDMX'),
('Sofía', 'López', 'Martínez', '5556789012', 'SLMX890918XYZ', 'sofia.lopez@mail.com', 'Centro Histórico, Oaxaca'),
('Diego', 'Mendoza', 'Rivera', '5557890123', 'DMRX860303ABC', 'diego.mendoza@mail.com', 'Calle 45, Querétaro'),
('Fernanda', 'García', 'Hernández', '5558901234', 'FGHX970707DEF', 'fernanda.garcia@mail.com', 'Av. Universidad, CDMX'),
('Ricardo', 'Sánchez', 'Guzmán', '5559012345', 'RSGX850909GHI', 'ricardo.sanchez@mail.com', 'Fracc. San Pedro, Toluca'),
('Daniela', 'Navarro', 'Cruz', '5550123456', 'DNCX920305JKL', 'daniela.navarro@mail.com', 'Col. Las Palmas, Puebla'),
('Miguel', 'Torres', 'Castillo', '5555432109', 'MTCX890605MNO', 'miguel.torres@mail.com', 'Zona Industrial, León'),
('Lucía', 'Ramos', 'Santos', '5556543210', 'LRSX870710PQR', 'lucia.ramos@mail.com', 'Residencial Oriente, Guadalajara'),
('Paola', 'Hernández', 'Jiménez', '5557654322', 'PHJX880220STU', 'paola.hernandez@mail.com', 'Col. Reforma, CDMX'),
('Jorge', 'Gómez', 'Pérez', '5558765433', 'JGPX870420VWX', 'jorge.gomez@mail.com', 'Av. Hidalgo, Monterrey'),
('Valeria', 'López', 'Ortiz', '5559876544', 'VLOX890101XYZ', 'valeria.lopez@mail.com', 'Centro Comercial, Querétaro'),
('Oscar', 'Martínez', 'Ríos', '5550987654', 'OMRX910515ABC', 'oscar.martinez@mail.com', 'Col. Juárez, CDMX'),
('Gabriela', 'Ruiz', 'Duarte', '5552109876', 'GRDX940625DEF', 'gabriela.ruiz@mail.com', 'Fracc. Santa Fe, Cancún');

-- Llenado de la tabla tipo_hab
INSERT INTO tipo_hab (desc_hab, cant_camas, cant_personas, precio_hab) VALUES
('Sencilla', 1, 1, 500.00),
('Doble', 2, 2, 750.00),
('Familiar', 3, 4, 1200.00),
('Suite', 2, 4, 2500.00),
('Premium', 1, 2, 1800.00);

-- Llenado de la tabla habitacion
INSERT INTO habitacion (numeroHab, id_thab, estado) VALUES
('101', 1, 'LIBRE'),
('102', 2, 'RESERVADA'),
('103', 3, 'LIBRE'),
('104', 1, 'RESERVADA'),
('105', 4, 'LIBRE'),
('106', 5, 'LIBRE'),
('107', 2, 'RESERVADA'),
('108', 3, 'LIBRE'),
('109', 1, 'LIBRE'),
('110', 4, 'RESERVADA'),
('111', 5, 'LIBRE'),
('112', 2, 'LIBRE'),
('113', 3, 'RESERVADA'),
('114', 1, 'LIBRE'),
('115', 4, 'RESERVADA');

-- Llenado de la tabla reservacion
INSERT INTO reservacion (estado, id_cliente) VALUES
--('RESERVADA', 1),
('CHECK-IN', 2),
('CHECK-IN', 3),
('RESERVADA', 4),
('CHECK-IN', 5),
('CANCELADA', 6),
('RESERVADA', 7),
('CHECK-IN', 8),
('RESERVADA', 9),
('CANCELADA', 10);

-- Llenado de la tabla cancelacion
INSERT INTO cancelacion (fecha_can, hora_can, motivo, id_reserva) VALUES
('2024-11-20', '15:00:00', 'Cambio de planes', 15),
('2024-11-22', '10:30:00', 'Problemas personales', 19);

-- Llenado de la tabla reserva_hab con fechas posteriores al 22 de noviembre, utilizando los id_reserva correctos
INSERT INTO reserva_hab (id_reserva, id_hab, fecha_reserva, hora_reserva, fecha_llegada, fecha_salida) VALUES
(11, 1, '2024-11-23', '12:00:00', '2024-11-24', '2024-11-29'),
(12, 3, '2024-11-23', '14:00:00', '2024-11-24', '2024-11-27'),
(13, 5, '2024-11-24', '15:30:00', '2024-11-25', '2024-11-28'),
(14, 6, '2024-11-25', '10:00:00', '2024-11-26', '2024-11-29'),
(17, 8, '2024-11-26', '09:00:00', '2024-11-27', '2024-11-29'),
(18, 9, '2024-11-27', '08:00:00', '2024-11-28', '2024-11-30'),
(17, 11, '2024-11-28', '13:00:00', '2024-11-29', '2024-12-02'),
(16, 12, '2024-11-29', '11:00:00', '2024-11-30', '2024-12-03'),
(18, 14, '2024-11-30', '14:00:00', '2024-12-01', '2024-12-04'),
(11, 13, '2024-12-01', '16:00:00', '2024-12-02', '2024-12-05');

-- Llenado de la tabla estancia con fechas posteriores al 22 de noviembre
INSERT INTO estancia (dias, fecha_llegada, hora_llegada, fecha_salida, hora_salida, id_cliente, id_reserva) VALUES
(5, '2024-11-24', '14:00:00', '2024-11-29', '15:00:00', 2, 11),  -- hora_salida > hora_llegada
(3, '2024-11-25', '16:00:00', '2024-11-28', '17:00:00', 3, 12);  -- hora_salida > hora_llegada

-- Llenado de la tabla facturacion con fechas posteriores al 22 de noviembre
INSERT INTO facturacion (fecha_fact, monto, id_estancia) VALUES
('2024-11-29', 2500.00, 2),
('2024-11-30', 3600.00, 3);

-- Llenado de la tabla servicios
INSERT INTO servicios (desc_servicio, precio_servicio) VALUES
('Spa', 300.00),
('Restaurante', 500.00),
('Piscina', 200.00),
('Lavandería', 150.00),
('Gimnasio', 100.00);

-- Llenado de la tabla servicios_cons con fechas posteriores al 22 de noviembre
INSERT INTO servicios_cons (id_servicio, id_estancia, hora, dia, monto) VALUES
(1, 1, '16:00:00', '2024-11-24', 300.00),
(2, 1, '18:00:00', '2024-11-25', 500.00),
(3, 2, '14:00:00', '2024-11-26', 200.00),
(4, 2, '10:00:00', '2024-11-27', 150.00),
(5, 2, '08:00:00', '2024-11-28', 100.00);

-- Llenado de la tabla empleado
INSERT INTO empleado (nombre_em, user_emp, pass_emp, cargo) VALUES
('Carlos Ruiz', 'cruiz', 'password123', 'Gerente'),
('Ana Flores', 'aflores', 'password123', 'Recepcionista'),
('Jorge Pérez', 'jperez', 'password123', 'Mantenimiento'),
('Laura Gómez', 'lgomez', 'password123', 'Camarista'),
('Mario Torres', 'mtorres', 'password123', 'Botones');


