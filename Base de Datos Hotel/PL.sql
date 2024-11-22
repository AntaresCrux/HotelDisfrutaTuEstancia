
----------------------------------------------RESERVACION MODULO---------------------------------------------
-----------------------------------------Registro de Reservacion con Cliente-----------------------------------------
CREATE OR REPLACE PROCEDURE registrar_reservacion_completa(
    p_nombre VARCHAR,
    p_ap_pat VARCHAR,
    p_ap_mat VARCHAR,
    p_telefono VARCHAR,
    p_email VARCHAR,
    p_rfc VARCHAR,
    p_direccion VARCHAR,
    p_fecha_llegada DATE,
    p_fecha_salida DATE,
    p_tipo_hab INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_cliente INTEGER;
    v_id_hab INTEGER;
    v_id_reserva INTEGER;
BEGIN
    -- Verificar si el cliente ya existe por su email o RFC
    SELECT id_cliente INTO v_id_cliente
    FROM clientes
    WHERE email = p_rfc IS NOT NULL AND rfc = p_rfc;

    -- Si el cliente no existe, insertarlo
    IF v_id_cliente IS NULL THEN
        INSERT INTO clientes (nombre, ap_pat, ap_mat, telefono, email, rfc, direccion)
        VALUES (p_nombre, p_ap_pat, p_ap_mat, p_telefono, p_email, p_rfc, p_direccion)
        RETURNING id_cliente INTO v_id_cliente;
    END IF;

    -- Buscar una habitación disponible del tipo solicitado
    SELECT id_hab INTO v_id_hab
    FROM habitacion
    WHERE id_thab = p_tipo_hab AND estado = 'LIBRE'
    LIMIT 1;

    -- Verificar si se encontró una habitación
    IF v_id_hab IS NULL THEN
        RAISE EXCEPTION 'No hay habitaciones disponibles del tipo solicitado en las fechas seleccionadas.';
    END IF;

    -- Insertar la reservación
    INSERT INTO reservacion (id_cliente, estado)
    VALUES (v_id_cliente, 'RESERVADA')
    RETURNING id_reserva INTO v_id_reserva;

    -- Insertar en la tabla de detalle de reserva
    INSERT INTO reserva_hab (id_reserva, id_hab, fecha_reserva, fecha_llegada, fecha_salida)
    VALUES (v_id_reserva, v_id_hab, CURRENT_DATE, p_fecha_llegada, p_fecha_salida);

    -- Actualizar el estado de la habitación a 'RESERVADA'
    UPDATE habitacion
    SET estado = 'RESERVADA'
    WHERE id_hab = v_id_hab;

    -- Mensaje de confirmación
    RAISE NOTICE 'Reservación creada exitosamente con ID: % para el cliente con ID: %', v_id_reserva, v_id_cliente;
END;
$$;

-- Ejemplo de uso
CALL registrar_reservacion_completa(
    'Luz', 
    'Torres', 
    'Lopez', 
    '1234567890', 
    'luz.lopez@email.com', 
    'RFC123456', 
    'Calle Ficticia 123', 
    '2024-11-15', 
    '2024-11-20', 
    5
);


---------------------------------------Consulta de Reservaciones Por Estus 'Reservada'---------------------------------------
CREATE OR REPLACE FUNCTION mostrar_todas_reservaciones()
RETURNS TABLE (
    id_reserva INTEGER,
    nombre VARCHAR,
    ap_pat VARCHAR,
    ap_mat VARCHAR,
    rfc VARCHAR,
    tipo_hab VARCHAR,
    numero_hab VARCHAR,
    estado VARCHAR,
    fecha_llegada DATE,
    fecha_salida DATE
) 
LANGUAGE plpgsql
AS $$
BEGIN
    -- Devolver los detalles de las reservaciones con estado 'RESERVADA' y las fechas de llegada y salida
    RETURN QUERY
        SELECT r.id_reserva,
               c.nombre,
               c.ap_pat,
               c.ap_mat,
               c.rfc,
               t.desc_hab AS tipo_hab,
               h.numeroHab AS numero_hab,
               r.estado,  -- Estado de la reservación
               rh.fecha_llegada,  -- Fecha de llegada desde reserva_hab
               rh.fecha_salida  -- Fecha de salida desde reserva_hab
        FROM reservacion r
        JOIN clientes c ON r.id_cliente = c.id_cliente
        JOIN reserva_hab rh ON r.id_reserva = rh.id_reserva
        JOIN habitacion h ON rh.id_hab = h.id_hab
        JOIN tipo_hab t ON h.id_thab = t.id_thab
        WHERE r.estado = 'RESERVADA';  -- Filtro para solo mostrar reservaciones 'RESERVADA'
END;
$$;

-- Ejemplo de uso
SELECT * FROM mostrar_todas_reservaciones();







---------------------------------------Modificacion de Reserva---------------------------------------
CREATE OR REPLACE PROCEDURE modificar_reservacion(
    p_id_reserva INTEGER,
    p_fecha_llegada DATE,
    p_fecha_salida DATE,
    p_tipo_hab INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_estado_reserva VARCHAR;
    v_id_cliente INTEGER;
    v_id_hab INTEGER;
    v_id_hab_actual INTEGER;
BEGIN
    -- Verificar el estado de la reservación
    SELECT estado INTO v_estado_reserva
    FROM reservacion
    WHERE id_reserva = p_id_reserva;

    IF v_estado_reserva NOT IN ('RESERVADA') THEN
        RAISE EXCEPTION 'No se puede modificar una reservación que no está en estado RESERVADA.';
    END IF;

    -- Obtener el id del cliente y la habitación actual
    SELECT id_cliente, id_hab INTO v_id_cliente, v_id_hab_actual
    FROM reservacion r
    JOIN reserva_hab rh ON r.id_reserva = rh.id_reserva
    WHERE r.id_reserva = p_id_reserva;

    -- Verificar la disponibilidad de la nueva habitación
    SELECT id_hab INTO v_id_hab
    FROM habitacion
    WHERE id_thab = p_tipo_hab AND estado = 'LIBRE'
    LIMIT 1;

    IF v_id_hab IS NULL THEN
        RAISE EXCEPTION 'No hay habitaciones disponibles del tipo solicitado.';
    END IF;

    -- Actualizar las fechas y la habitación en la reserva
    UPDATE reserva_hab
    SET fecha_llegada = p_fecha_llegada,
        fecha_salida = p_fecha_salida,
        id_hab = v_id_hab
    WHERE id_reserva = p_id_reserva;

    -- Liberar la habitación actual solo si es diferente a la nueva
    IF v_id_hab_actual != v_id_hab THEN
        UPDATE habitacion
        SET estado = 'LIBRE'
        WHERE id_hab = v_id_hab_actual;
    END IF;

    -- Actualizar el estado de la nueva habitación a 'RESERVADA'
    UPDATE habitacion
    SET estado = 'RESERVADA'
    WHERE id_hab = v_id_hab;

    -- Mensaje de confirmación
    RAISE NOTICE 'Reservación con ID % modificada exitosamente.', p_id_reserva;

END;
$$;

-- Ejemplo de uso
CALL modificar_reservacion(11, '2024-11-20', '2024-11-25', 4);





--hacer consulta para verificar el id de reserva o rfc existe, y devolver el nombre del cliente
---------------------------------------Cancelacion de Reserva---------------------------------------
CREATE OR REPLACE PROCEDURE cancelar_reservacion(
    p_id_reserva INTEGER,
    p_rfc VARCHAR,
    p_motivo VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_hab INTEGER;
    v_rfc_cliente VARCHAR;
BEGIN
    -- Verificar si la reserva existe y obtener el RFC del cliente asociado
    SELECT c.rfc INTO v_rfc_cliente
    FROM reservacion r
    JOIN clientes c ON r.id_cliente = c.id_cliente
    WHERE r.id_reserva = p_id_reserva;

    -- Si no se encuentra la reservación, lanzar una excepción
    IF NOT FOUND THEN
        RAISE EXCEPTION 'La reservación con ID % no existe.', p_id_reserva;
    END IF;

    -- Verificar si el RFC coincide con el proporcionado
    IF v_rfc_cliente != p_rfc THEN
        RAISE EXCEPTION 'El RFC proporcionado no coincide con el de la reservación.';
    END IF;

    -- Verificar si la reserva ya está cancelada
    IF EXISTS (SELECT 1 FROM cancelacion WHERE id_reserva = p_id_reserva) THEN
        RAISE EXCEPTION 'La reservación con ID % ya ha sido cancelada.', p_id_reserva;
    END IF;

    -- Insertar la cancelación
    INSERT INTO cancelacion (id_reserva, fecha_can, hora_can, motivo)
    VALUES (p_id_reserva, CURRENT_DATE, CURRENT_TIME, p_motivo);

    -- Actualizar el estado de la reservación a 'CANCELADA'
    UPDATE reservacion
    SET estado = 'CANCELADA'
    WHERE id_reserva = p_id_reserva;

    -- Obtener las habitaciones asociadas a la reservación cancelada
    FOR v_id_hab IN
        SELECT id_hab
        FROM reserva_hab
        WHERE id_reserva = p_id_reserva
    LOOP
        -- Liberar la habitación
        UPDATE habitacion
        SET estado = 'LIBRE'
        WHERE id_hab = v_id_hab;
    END LOOP;

    RAISE NOTICE 'Reservación con ID % cancelada exitosamente.', p_id_reserva;
END;
$$;

-- Ejemplo de uso
CALL cancelar_reservacion(12, 'JUAP850101HDFGRR02', 'Flojera');

---------------------------------------Consulta de Reservaciones Canceladas----------------------------------
CREATE OR REPLACE FUNCTION mostrar_cancelaciones()
RETURNS TABLE(
    id_cancelacion INT,         -- Identificador de la cancelación
    fecha_can DATE,             -- Fecha de la cancelación
    hora_can TIME,              -- Hora de la cancelación
    nombre_cliente VARCHAR(50), -- Nombre del cliente
    ap_pat_cliente VARCHAR(20), -- Apellido paterno del cliente
    ap_mat_cliente VARCHAR(20)  -- Apellido materno del cliente
) 
LANGUAGE plpgsql
AS $$
BEGIN
    -- Mostrar todos los datos de cancelación
    RETURN QUERY
    SELECT
        c.id_cancelacion,          -- Identificador de la cancelación
        c.fecha_can,                -- Fecha de la cancelación
        c.hora_can,                 -- Hora de la cancelación
        cl.nombre,                  -- Nombre del cliente
        cl.ap_pat,                  -- Apellido paterno del cliente
        cl.ap_mat                   -- Apellido materno del cliente
    FROM cancelacion c
    JOIN reservacion r ON c.id_reserva = r.id_reserva
    JOIN clientes cl ON r.id_cliente = cl.id_cliente;
END;
$$;

-- Ejemplo de uso
SELECT * FROM mostrar_cancelaciones();









----------------------------------------------ESTANCIA MODULO------------------------------------------------
---------------------------------------Registro de Check-In-------------------------------------------------
CREATE OR REPLACE PROCEDURE registrar_check_in(
    p_id_reserva INT,           -- ID de la reserva
    p_rfc VARCHAR,              -- RFC del cliente
    p_fecha_llegada DATE,       -- Fecha de llegada (check-in)
    p_hora_llegada TIME         -- Hora de llegada (check-in)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_cliente INT;           -- Variable para almacenar el ID del cliente
    v_estado_reserva VARCHAR;   -- Variable para almacenar el estado de la reserva
    v_fecha_llegada DATE;       -- Variable para almacenar la fecha de llegada de la reserva
    v_fecha_salida DATE;        -- Variable para almacenar la fecha de salida de la reserva
BEGIN
    -- Verificar si la reserva existe, obtener el ID del cliente por RFC, y obtener las fechas de la reserva
    SELECT r.id_cliente, r.estado, rh.fecha_llegada, rh.fecha_salida 
    INTO v_id_cliente, v_estado_reserva, v_fecha_llegada, v_fecha_salida
    FROM reserva_hab rh
    JOIN reservacion r ON rh.id_reserva = r.id_reserva
    JOIN clientes c ON r.id_cliente = c.id_cliente
    WHERE rh.id_reserva = p_id_reserva
    AND c.rfc = p_rfc;

    -- Si no se encuentra la reserva o el cliente, lanzar un error
    IF v_id_cliente IS NULL THEN
        RAISE EXCEPTION 'Reserva con ID % y RFC % no encontrada', p_id_reserva, p_rfc;
    END IF;

    -- Verificar si el estado de la reserva es 'RESERVADA'
    IF v_estado_reserva <> 'RESERVADA' THEN
        RAISE EXCEPTION 'La reserva con ID % no está en estado RESERVADA, no se puede realizar el check-in', p_id_reserva;
    END IF;

    -- Verificar que la fecha de check-in esté dentro del rango de fechas de la reserva
    IF p_fecha_llegada < v_fecha_llegada OR p_fecha_llegada > v_fecha_salida THEN
        RAISE EXCEPTION 'La fecha de llegada % no está dentro del rango de la reserva (de % a %)', p_fecha_llegada, v_fecha_llegada, v_fecha_salida;
    END IF;

    -- Insertar la estancia (registro de check-in)
    INSERT INTO estancia (
        fecha_llegada,
        hora_llegada,
        id_cliente,
        id_reserva
    ) VALUES (
        p_fecha_llegada,
        p_hora_llegada,
        v_id_cliente,
        p_id_reserva
    );

    -- Actualizar la reserva a un estado de "CHECK-IN"
    UPDATE reservacion
    SET estado = 'CHECK-IN'
    WHERE id_reserva = p_id_reserva;

    RAISE NOTICE 'Check-in registrado con éxito para la reserva ID: % con RFC: %', p_id_reserva, p_rfc;
END;
$$;

-- Ejemplo de uso
CALL registrar_check_in(17, 'JUAP890123HN0', '2024-11-15', '14:30:00');



--------------------------------Registro de Servicios Consumidos Durante la estancia------------------------
CREATE OR REPLACE PROCEDURE registrar_servicio_consumido(
    p_id_estancia INTEGER,
    p_id_servicio INTEGER,
    p_hora TIME,
    p_dia DATE,
    p_monto NUMERIC
)
LANGUAGE plpgsql AS $$
DECLARE
    v_fecha_llegada DATE;
    v_fecha_salida DATE;
BEGIN
    -- Verificamos que la estancia exista y obtenemos las fechas de llegada y salida
    SELECT fecha_llegada, fecha_salida
    INTO v_fecha_llegada, v_fecha_salida
    FROM estancia
    WHERE id_estancia = p_id_estancia;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La estancia con ID % no existe', p_id_estancia;
    END IF;

    -- Verificamos que el servicio exista
    IF NOT EXISTS (SELECT 1 FROM servicios WHERE id_servicio = p_id_servicio) THEN
        RAISE EXCEPTION 'El servicio con ID % no existe', p_id_servicio;
    END IF;

    -- Verificamos que el día esté dentro del rango de la estancia
    IF p_dia < v_fecha_llegada OR p_dia > v_fecha_salida THEN
        RAISE EXCEPTION 'La fecha % no está dentro del rango de la estancia (de % a %)', p_dia, v_fecha_llegada, v_fecha_salida;
    END IF;

    -- Insertamos el servicio consumido
    INSERT INTO servicios_cons (id_servicio, id_estancia, hora, dia, monto)
    VALUES (p_id_servicio, p_id_estancia, p_hora, p_dia, p_monto);
    
    -- Mensaje de confirmación
    RAISE NOTICE 'Servicio consumido registrado con éxito para la estancia ID: %, servicio ID: %, monto: %', p_id_estancia, p_id_servicio, p_monto;
END;
$$;

-- Ejemplo de uso
CALL registrar_servicio_consumido(8, 2, '14:30:00', '2024-11-15', 150.00);


---------------------------------------Registro de Check-Out------------------------------------------------
CREATE OR REPLACE PROCEDURE registrar_check_out(
    p_id_reserva INT,
    p_fecha_salida DATE,
    p_hora_salida TIME
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_estancia INT;
BEGIN
    -- Verificar que la reserva existe y está en estado 'CHECK-IN'
    SELECT id_estancia
    INTO v_id_estancia
    FROM estancia
    WHERE id_reserva = p_id_reserva AND estado_reserva = 'CHECK-IN';

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Reserva no encontrada o ya procesada.';
    END IF;

    -- Actualizar la estancia con la fecha y hora de salida
    UPDATE estancia
    SET fecha_salida = p_fecha_salida, hora_salida = p_hora_salida
    WHERE id_estancia = v_id_estancia;

    -- Cambiar el estado de la reserva a 'CHECK-OUT'
    UPDATE reserva
    SET estado_reserva = 'CHECK-OUT'
    WHERE id_reserva = p_id_reserva;

    -- Liberar la habitación asociada
    UPDATE habitacion
    SET estado_hab = 'LIBRE'
    WHERE id_hab = (SELECT id_hab FROM estancia WHERE id_estancia = v_id_estancia);

    RAISE NOTICE 'Check-out registrado para la reserva ID %.', p_id_reserva;
END;
$$;

-- Ejemplo de uso
CALL registrar_check_out(8, '2024-11-15', '11:00:00');






----------------------------------------------HABITACION MODULO------------------------------------------------
------------------------------------------CONSULTA DE HABITACIONES CON DETALLE------------------------------------------------

SELECT
    h.id_hab,
    h.numerohab,
    t.desc_hab,
    t.cant_camas,
    t.precio_hab,
    h.estado
FROM
    habitacion h
JOIN
    tipo_hab t ON h.id_thab = t.id_thab;

------------------------------------------CONSULTA DE TIPOS DE HABITACIONES------------------------------------------------
SELECT id_thab, desc_hab FROM tipo_hab;








------------------------------------------SERVICIOS MODULO------------------------------------------------
------------------------------------------CONSULTA DE SERVICIO PARA OBTENER ID Y DESCRIPCION--------------
SELECT id_servicio, desc_servicio FROM servicios;

------------------------------------------CONSULTA DE SERVICIOS TOTALES-----------------------------------
SELECT * from servicios;


------------------------------------------Grafica de habitaciones mas ocupadas-----------------------------------
CREATE OR REPLACE FUNCTION obtener_habitaciones_mas_ocupadas()
RETURNS TABLE(
    numero_hab VARCHAR,
    ocupaciones INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        h.numerohab AS numero_hab,
        COUNT(rh.id_reserva)::INT AS ocupaciones -- Convertir a INT
    FROM 
        habitacion h
    LEFT JOIN 
        reserva_hab rh ON h.id_hab = rh.id_hab
    GROUP BY 
        h.numerohab
    ORDER BY 
        ocupaciones DESC;
END;
$$ LANGUAGE plpgsql;

-- Ejemplo de uso
SELECT * from obtener_habitaciones_mas_ocupadas();


------------------------------------------Grafica de tipo de habitaciones mas ocupadas-----------------------------------
CREATE OR REPLACE FUNCTION obtener_reservas_por_tipo_hab()
RETURNS TABLE(tipo_habitacion VARCHAR, veces_reservada INT) AS
$$
BEGIN
    RETURN QUERY
    SELECT th.desc_hab AS tipo_habitacion, COUNT(rh.id_reserva)::INT AS veces_reservada
    FROM tipo_hab th
    JOIN habitacion h ON th.id_thab = h.id_thab
    JOIN reserva_hab rh ON h.id_hab = rh.id_hab
    GROUP BY th.desc_hab
    ORDER BY veces_reservada DESC;
END;
$$
LANGUAGE plpgsql;

-- Ejemplo de uso
SELECT * FROM obtener_reservas_por_tipo_hab();

