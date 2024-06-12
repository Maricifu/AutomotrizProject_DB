USE automotrizDB;

INSERT INTO cargo (id_cargo, cargo)
VALUES 
(1, 'Mecánico'),
(2, 'Administrador'),
(3, 'Asistente'),
(4, 'Recepcionista'),
(5, 'Jefe de Taller');

INSERT INTO empleados (id_empleado, nombre1, nombre2, apellido1, apellido2, email, id_cargo)
VALUES 
(1, 'Pedro', NULL, 'López', NULL, 'pedro.lopez@example.com', 1),
(2, 'Mónica', NULL, 'González', NULL, 'monica.gonzalez@example.com', 2),
(3, 'José', NULL, 'Ramírez', NULL, 'jose.ramirez@example.com', 3),
(4, 'Lucía', NULL, 'Morales', NULL, 'lucia.morales@example.com', 4),
(5, 'Roberto', NULL, 'Méndez', NULL, 'roberto.mendez@example.com', 5);

INSERT INTO area_taller (id_area_taller, area)
VALUES 
(1, 'Motor'),
(2, 'Transmisión'),
(3, 'Frenos'),
(4, 'Suspensión'),
(5, 'Eléctrica');

INSERT INTO tipo_telefono (id_tipo_telefono, tipo)
VALUES 
(1, 'Móvil'),
(2, 'Fijo'),
(3, 'Trabajo'),
(4, 'Casa');

INSERT INTO telefono (id_telefono, id_tipo_telefono, telefono)
VALUES 
(1, 1, '1234567890'),
(2, 2, '0987654321'),
(3, 3, '1122334455'),
(4, 4, '5566778899'),
(5, 1, '6677889900');

INSERT INTO telefono_empleado (id_telefono, id_empleado)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO cliente (clienteID, nombre1, nombre2, apellido1, apellido2, email, direccion, NIT)
VALUES 
(1, 'Juan', 'Carlos', 'Pérez', 'López', 'juan.perez@example.com', 'Av. Principal 123', '12345678-9'),
(2, 'Ana', 'María', 'Gómez', 'Rojas', 'ana.gomez@example.com', 'Calle Secundaria 456', '98765432-1'),
(3, 'Luis', 'Fernando', 'Martínez', 'Díaz', 'luis.martinez@example.com', 'Av. Independencia 789', '12312312-3'),
(4, 'Sofía', 'Isabel', 'Ramírez', 'Hernández', 'sofia.ramirez@example.com', 'Calle 8 # 10-12', '32132132-4'),
(5, 'Carlos', 'Eduardo', 'García', 'Sánchez', 'carlos.garcia@example.com', 'Av. Bolívar 333', '23123123-5');

INSERT INTO marca_vehiculo (id_marca_vehiculo, marca)
VALUES 
(1, 'Toyota'),
(2, 'Honda'),
(3, 'Ford'),
(4, 'Chevrolet'),
(5, 'Nissan');

INSERT INTO vehiculo (placa, id_marca_vehiculo, kilometraje)
VALUES 
('ABC123', 1, 75000),
('XYZ789', 2, 50000),
('JKL456', 3, 120000),
('MNO321', 4, 60000),
('PQR678', 5, 45000);

INSERT INTO categoria_pieza (id_categoria_pieza, categoria)
VALUES 
(1, 'Filtros'),
(2, 'Frenos'),
(3, 'Neumáticos'),
(4, 'Aceites y Lubricantes'),
(5, 'Componentes del Motor');

INSERT INTO repuestos_piezas (id_repuesto_pieza, id_categoria_pieza, pieza)
VALUES 
(1, 1, 'Filtro de Aceite'),
(2, 2, 'Pastillas de Freno'),
(3, 3, 'Neumático'),
(4, 4, 'Aceite de Motor'),
(5, 5, 'Bujías');

INSERT INTO piezas (id_pieza, pieza)
VALUES 
(1, 'Filtro de Aceite'),
(2, 'Filtro de Aire'),
(3, 'Pastillas de Freno'),
(4, 'Neumático'),
(5, 'Aceite de Motor');

INSERT INTO inventarios (id_inventarios, id_repuesto_pieza, id_pieza, id_area_taller, stock)
VALUES 
(1, 1, 1, 1, 100),
(2, 2, 3, 3, 200),
(3, 3, 4, 4, 50),
(4, 4, 5, 1, 300),
(5, 5, 2, 2, 150),
(6, 2, 2, 1, 30);

INSERT INTO servicios (id_servicio, id_area_taller, servicio, descripcion, costo)
VALUES 
(1, 1, 'Cambio de Aceite', NULL, 50.00),
(2, 2, 'Alineación y Balanceo', NULL, 80.00),
(3, 3, 'Revisión de Frenos', NULL, 60.00),
(4, 4, 'Cambio de Neumáticos', NULL, 100.00),
(5, 5, 'Reparación de Motor', NULL, 500.00);

INSERT INTO citas (id_cita, fecha, id_cliente, id_vehiculo, id_servicio)
VALUES 
(1, '2024-06-01', 1, 'ABC123', 1),
(2, '2024-06-02', 2, 'XYZ789', 2),
(3, '2024-06-03', 3, 'JKL456', 3),
(4, '2024-06-04', 4, 'MNO321', 4),
(5, '2024-06-05', 5, 'PQR678', 5),
(6, '2022-06-11', 1, 'ABC123', 1),
(7, '2023-06-12', 2, 'XYZ789', 2),
(8, '2023-06-13', 3, 'JKL456', 3);

INSERT INTO reparaciones (id_reparacion, id_vehiculo, id_repuesto_pieza, fecha_inicio, fecha_finalizacion, duracion)
VALUES 
(1, 'ABC123', 1, '2024-06-01', '2024-06-01', '02:00:00'),
(2, 'XYZ789', 2, '2024-06-02', '2024-06-02', '02:30:00'),
(3, 'JKL456', 3, '2024-06-03', '2024-06-03', '01:45:00'),
(4, 'MNO321', 4, '2024-06-04', '2024-06-04', '03:15:00'),
(5, 'PQR678', 5, '2024-06-05', '2024-06-05', '04:00:00');


INSERT INTO servicio_reparacion (id_servicio_reparacion, id_servicio, id_reparacion)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO historial_reparacion_emp (id_reparacion, id_empleado)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO proveedor (id_proveedor, id_pieza, nombre, apellido, contacto, NIT)
VALUES 
(1, 1, 'Mario', 'Gutiérrez', 'mario.gutierrez@autopartes.com', '12345678-9'),
(2, 2, 'Laura', 'Fernández', 'laura.fernandez@repauto.com', '98765432-1'),
(3, 3, 'Jorge', 'Salinas', 'jorge.salinas@repdelnorte.com', '45678912-3'),
(4, 4, 'Marta', 'Pérez', 'marta.perez@distperez.com', '32165498-7'),
(5, 5, 'Diego', 'Rodríguez', 'diego.rodriguez@pyp.com', '65412398-7');

INSERT INTO ordenes_compra (id_orden_compra, id_proveedor, id_empleado, fecha, total)
VALUES 
(1, 1, 1, '2024-05-01', 500.00),
(2, 2, 2, '2024-05-02', 1000.00),
(3, 3, 3, '2024-05-03', 1500.00),
(4, 4, 4, '2024-05-04', 2000.00),
(5, 5, 5, '2024-05-05', 2500.00);

INSERT INTO detalle_orden_compra (id_detalle_orden_compra, id_orden_compra, id_repuesto_pieza, cantidad, precio)
VALUES 
(1, 1, 1, 10, 50.00),
(2, 2, 2, 20, 50.00),
(3, 3, 3, 30, 50.00),
(4, 4, 4, 40, 50.00),
(5, 5, 5, 50, 50.00);

INSERT INTO telefono_proveedor (id_telefono, id_proveedor)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO facturacion (id_facturacion, id_cliente, fecha, total)
VALUES 
(1, 1, '2024-06-01', 50.00),
(2, 2, '2024-06-02', 80.00),
(3, 3, '2024-06-03', 60.00),
(4, 4, '2024-06-04', 100.00),
(5, 5, '2024-06-05', 500.00);

INSERT INTO factura_detalles (id_facturacion, id_servicio_reparacion)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO telefono_cliente (id_telefono, id_cliente)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
