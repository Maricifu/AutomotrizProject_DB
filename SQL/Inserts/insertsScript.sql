USE automotrizDB;

INSERT INTO marca_vehiculo (id_marca_vehiculo, marca)
VALUES 
(1, 'Toyota'),
(2, 'Honda'),
(3, 'Ford'),
(4, 'Chevrolet'),
(5, 'Nissan');

INSERT INTO vehiculo (placa, id_marca_vehiculo, modelo, kilometraje, color)
VALUES 
('ABC123', 1, 'Corolla', 75000, 'Rojo'),
('XYZ789', 2, 'Civic', 50000, 'Azul'),
('JKL456', 3, 'F-150', 120000, 'Negro'),
('MNO321', 4, 'Malibu', 60000, 'Blanco'),
('PQR678', 5, 'Altima', 45000, 'Gris');

INSERT INTO cliente (clienteID, nombre1, nombre2, apellido1, apellido2, email, direccion, NIT)
VALUES 
(1, 'Juan', 'Carlos', 'Pérez', 'López', 'juan.perez@example.com', 'Av. Principal 123', '12345678-9'),
(2, 'Ana', 'María', 'Gómez', 'Rojas', 'ana.gomez@example.com', 'Calle Secundaria 456', '98765432-1'),
(3, 'Luis', 'Fernando', 'Martínez', 'Díaz', 'luis.martinez@example.com', 'Av. Independencia 789', '12312312-3'),
(4, 'Sofía', 'Isabel', 'Ramírez', 'Hernández', 'sofia.ramirez@example.com', 'Calle 8 # 10-12', '32132132-4'),
(5, 'Carlos', 'Eduardo', 'García', 'Sánchez', 'carlos.garcia@example.com', 'Av. Bolívar 333', '23123123-5');

INSERT INTO proveedor (id_proveedor, nombre, apellido, empresa, telefono, email, direccion)
VALUES 
(1, 'Mario', 'Gutiérrez', 'AutoPartes S.A.', '123456789', 'mario.gutierrez@autopartes.com', 'Calle Comercio 123'),
(2, 'Laura', 'Fernández', 'RepAuto Ltda.', '987654321', 'laura.fernandez@repauto.com', 'Av. Industrial 456'),
(3, 'Jorge', 'Salinas', 'Repuestos del Norte', '456789123', 'jorge.salinas@repdelnorte.com', 'Calle Norte 789'),
(4, 'Marta', 'Pérez', 'Distribuidora Pérez', '321654987', 'marta.perez@distperez.com', 'Av. Central 10-20'),
(5, 'Diego', 'Rodríguez', 'Partes y Piezas', '654123987', 'diego.rodriguez@pyp.com', 'Calle Sur 3-4');

INSERT INTO empleados (id_empleado, nombre1, apellido1, telefono, email, direccion)
VALUES 
(1, 'Pedro', 'López', '111222333', 'pedro.lopez@example.com', 'Av. Obrera 321'),
(2, 'Mónica', 'González', '444555666', 'monica.gonzalez@example.com', 'Calle Obrera 654'),
(3, 'José', 'Ramírez', '777888999', 'jose.ramirez@example.com', 'Av. Obrera 987'),
(4, 'Lucía', 'Morales', '222333444', 'lucia.morales@example.com', 'Calle Obrera 321'),
(5, 'Roberto', 'Méndez', '555666777', 'roberto.mendez@example.com', 'Av. Obrera 654');

INSERT INTO servicios (id_servicio, servicio, costo)
VALUES 
(1, 'Cambio de Aceite', 50.00),
(2, 'Alineación y Balanceo', 80.00),
(3, 'Revisión de Frenos', 60.00),
(4, 'Cambio de Neumáticos', 100.00),
(5, 'Reparación de Motor', 500.00);

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
(5, 5, 2, 2, 150);

INSERT INTO citas (id_cita, fecha, id_cliente, id_vehiculo, id_servicio)
VALUES 
(1, '2024-06-01', 1, 'ABC123', 1),
(2, '2024-06-02', 2, 'XYZ789', 2),
(3, '2024-06-03', 3, 'JKL456', 3),
(4, '2024-06-04', 4, 'MNO321', 4),
(5, '2024-06-05', 5, 'PQR678', 5);

INSERT INTO reparaciones (id_reparacion, id_vehiculo, id_repuesto_pieza, fecha_inicio, fecha_finalizacion)
VALUES 
(1, 'ABC123', 1, '2024-06-01', '2024-06-01'),
(2, 'XYZ789', 2, '2024-06-02', '2024-06-02'),
(3, 'JKL456', 3, '2024-06-03', '2024-06-03'),
(4, 'MNO321', 4, '2024-06-04', '2024-06-04'),
(5, 'PQR678', 5, '2024-06-05', '2024-06-05');

INSERT INTO historial_reparacion_emp (id_empleado, id_reparacion)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

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

INSERT INTO facturacion (id_facturacion, id_cliente, fecha, total)
VALUES 
(1, 1, '2024-06-01', 50.00),
(2, 2, '2024-06-02', 80.00),
(3, 3, '2024-06-03', 60.00),
(4, 4, '2024-06-04', 100.00),
(5, 5, '2024-06-05', 500.00);

INSERT INTO cargo (id_cargo, cargo)
VALUES 
(1, 'Mecánico'),
(2, 'Administrador'),
(3, 'Asistente'),
(4, 'Recepcionista'),
(5, 'Jefe de Taller');

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


INSERT INTO servicio_reparacion (id_servicio_reparacion, id_servicio, id_reparacion)
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO telefono_cliente (id_telefono, id_cliente)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO telefono_proveedor (id_telefono, id_proveedor)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO factura_detalles (id_facturacion, id_servicio_reparacion)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
