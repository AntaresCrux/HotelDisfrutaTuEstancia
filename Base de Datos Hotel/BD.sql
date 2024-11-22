create database hoteldisfrutatuestancia;
\c hoteldisfrutatuestancia

create table clientes(
    id_cliente serial NOT NULL,
    nombre varchar (50) not null,
    ap_pat varchar(20),
    ap_mat varchar(20),
    telefono varchar(15),
    rfc varchar,
    email varchar,
    direccion varchar(60),
    CONSTRAINT clientes_pkey PRIMARY KEY (id_cliente)
);

create table reservacion(
    id_reserva serial,
    estado varchar DEFAULT 'RESERVADA',
    id_cliente integer not null,
    CONSTRAINT reservacion_pkey PRIMARY KEY (id_reserva),
    CONSTRAINT reservacion_idcliente_fkey FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) MATCH SIMPLE ON UPDATE NO ACTION
);

create table cancelacion(
    id_cancelacion serial,
    fecha_can date, 
    hora_can time, 
    motivo varchar,
    id_reserva integer not null, 
    CONSTRAINT cancelacion_pkey PRIMARY KEY (id_cancelacion),
    CONSTRAINT cancelacion_idreserva_fkey FOREIGN KEY (id_reserva) REFERENCES reservacion (id_reserva) MATCH SIMPLE ON UPDATE NO ACTION
);

create table tipo_hab(
    id_thab serial,
    desc_hab varchar,
    cant_camas integer,
    cant_personas integer,
    precio_hab numeric(6,2),
    CONSTRAINT tipo_hab_pkey PRIMARY KEY(id_thab)
);

create table habitacion(
    id_hab serial,
    numeroHab varchar,
    id_thab integer, 
    estado varchar NOT NULL DEFAULT 'LIBRE',
    CONSTRAINT habitacion_pkey PRIMARY KEY (id_hab),
    CONSTRAINT habitacion_idthab_fkey FOREIGN KEY (id_thab) REFERENCES tipo_hab(id_thab) MATCH SIMPLE ON UPDATE NO ACTION
);


--tabla det de reserva
create table reserva_hab(
    cns_reserva serial,
    id_reserva integer not null,
    id_hab integer not null,
    fecha_reserva date DEFAULT CURRENT_DATE, 
    hora_reserva time DEFAULT CURRENT_TIME,
    fecha_llegada date CHECK (fecha_llegada>= CURRENT_DATE), 
    fecha_salida date CHECK (fecha_salida > fecha_llegada),
    CONSTRAINT reservacionhab_pkey PRIMARY KEY (cns_reserva, id_reserva),
    CONSTRAINT reservacionhab_idreserva_fkey FOREIGN KEY (id_reserva) REFERENCES reservacion (id_reserva) MATCH SIMPLE ON UPDATE NO ACTION,
    CONSTRAINT reservacionhab_idhab_fkey FOREIGN KEY (id_hab) REFERENCES habitacion(id_hab) MATCH SIMPLE ON UPDATE NO ACTION
);


create table estancia(
    id_estancia serial,
    dias integer, --este campo se llenara al finalizar la estancia.
    fecha_llegada date,
    hora_llegada time,
    fecha_salida date CHECK (fecha_salida >= fecha_llegada),
    hora_salida time CHECK (hora_salida > hora_llegada),
    id_cliente integer not null,
    id_reserva integer UNIQUE, --1:1 con RESERVACION!!!  
    CONSTRAINT estancia_idreserva_fkey FOREIGN KEY (id_reserva) REFERENCES reservacion (id_reserva) MATCH SIMPLE on update no ACTION,
    CONSTRAINT estancia_idcliente_fkey FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente) MATCH SIMPLE ON UPDATE NO ACTION,
    CONSTRAINT estancia_pkey PRIMARY KEY (id_estancia)
);

CREATE table facturacion (
    id_factura SERIAL ,
    fecha_fact date,
    monto numeric(10,2),
    id_estancia integer UNIQUE,
    CONSTRAINT facturacion_pkey PRIMARY KEY (id_factura), 
    CONSTRAINT facturacion_idestancia_fkey FOREIGN KEY (id_estancia) REFERENCES estancia (id_estancia) MATCH SIMPLE ON UPDATE NO ACTION
);

create table servicios(
    id_servicio serial,
    desc_servicio varchar (50) NOT NULL,
    precio_servicio decimal (6,2) NOT NULL,
    CONSTRAINT servicios_pkey PRIMARY KEY (id_servicio)
);

create table servicios_cons(
    id_servcons serial, 
    id_servicio integer not null,
    id_estancia integer not null, 
    hora time,
    dia date, 
    monto numeric(10,2),
    CONSTRAINT servcons_id_pkey PRIMARY KEY (id_servcons, id_estancia),
    CONSTRAINT servcons_idservicio_fkey FOREIGN KEY (id_servicio) REFERENCES servicios (id_servicio) MATCH SIMPLE ON UPDATE NO ACTION, 
    CONSTRAINT servcons_idestancia_fkey FOREIGN KEY (id_estancia) REFERENCES estancia (id_estancia) MATCH SIMPLE ON UPDATE NO ACTION 
);

--tabla de los empleados del hotel incluyendo al gerente
create table empleado(
    id_empleado serial PRIMARY KEY,
    nombre_em varchar(100),
    user_emp varchar(50),
    pass_emp varchar(50),
    cargo varchar(100)
);

--hoteldisfrutatuestancia=# ALTER TABLE habitacion
--hoteldisfrutatuestancia-# ADD COLUMN estado varchar NOT NULL DEFAULT 'LIBRE';