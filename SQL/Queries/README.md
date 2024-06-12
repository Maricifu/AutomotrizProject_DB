# Queries Automotriz DataBase
```mysql
+--------------------------+
| Tables_in_automotrizDB   |
+--------------------------+
| area_taller              |
| cargo                    |
| categoria_pieza          |
| citas                    |
| cliente                  |
| detalle_orden_compra     |
| empleados                |
| factura_detalles         |
| facturacion              |
| historial_reparacion_emp |
| inventarios              |
| marca_vehiculo           |
| ordenes_compra           |
| piezas                   |
| proveedor                |
| reparaciones             |
| repuestos_piezas         |
| servicio_reparacion      |
| servicios                |
| telefono                 |
| telefono_cliente         |
| telefono_empleado        |
| telefono_proveedor       |
| tipo_telefono            |
| vehiculo                 |
+--------------------------+

```


### Consultas requeridas
1. Obtener el historial de reparaciones de un vehículo específico

```sql
SELECT r.id_reparacion, r.id_vehiculo, rp.pieza, r.fecha_inicio, r.fecha_finalizacion
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.id_vehiculo = 'ABC123';

```
```mysql
+---------------+-------------+------------------+--------------+--------------------+
| id_reparacion | id_vehiculo | pieza            | fecha_inicio | fecha_finalizacion |
+---------------+-------------+------------------+--------------+--------------------+
|             1 | ABC123      | Filtro de Aceite | 2024-06-01   | 2024-06-01         |
+---------------+-------------+------------------+--------------+--------------------+

```


2. Calcular el costo total de todas las reparaciones realizadas por un empleado específico en un período de tiempo

```sql
SELECT e.id_empleado, e.nombre1, e.apellido1, SUM(s.costo) AS total_costo
FROM empleados e
JOIN historial_reparacion_emp hre ON e.id_empleado = hre.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
JOIN servicio_reparacion sr ON r.id_reparacion = sr.id_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE e.id_empleado = 1 -- Especifica el id del empleado
AND r.fecha_inicio BETWEEN '2024-01-01' AND '2024-12-31' -- Especifica el rango de fechas
GROUP BY e.id_empleado;
```
```mysql
+-------------+---------+-----------+-------------+
| id_empleado | nombre1 | apellido1 | total_costo |
+-------------+---------+-----------+-------------+
|           1 | Pedro   | López     |       50.00 |
+-------------+---------+-----------+-------------+

```
3. Listar todos los clientes y los vehículos que poseen

```sql
SELECT c.clienteID, c.nombre1, c.nombre2, c.apellido1, c.apellido2, c.email, c.direccion, c.NIT,
       v.placa, mv.marca, v.kilometraje
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN vehiculo v ON ci.id_vehiculo = v.placa
JOIN marca_vehiculo mv ON v.id_marca_vehiculo = mv.id_marca_vehiculo;
```
```mysql
+-----------+---------+----------+-----------+------------+---------------------------+-----------------------+------------+--------+-----------+-------------+
| clienteID | nombre1 | nombre2  | apellido1 | apellido2  | email                     | direccion             | NIT        | placa  | marca     | kilometraje |
+-----------+---------+----------+-----------+------------+---------------------------+-----------------------+------------+--------+-----------+-------------+
|         1 | Juan    | Carlos   | Pérez     | López      | juan.perez@example.com    | Av. Principal 123     | 12345678-9 | ABC123 | Toyota    |       75000 |
|         1 | Juan    | Carlos   | Pérez     | López      | juan.perez@example.com    | Av. Principal 123     | 12345678-9 | ABC123 | Toyota    |       75000 |
|         3 | Luis    | Fernando | Martínez  | Díaz       | luis.martinez@example.com | Av. Independencia 789 | 12312312-3 | JKL456 | Ford      |      120000 |
|         3 | Luis    | Fernando | Martínez  | Díaz       | luis.martinez@example.com | Av. Independencia 789 | 12312312-3 | JKL456 | Ford      |      120000 |
|         4 | Sofía   | Isabel   | Ramírez   | Hernández  | sofia.ramirez@example.com | Calle 8 # 10-12       | 32132132-4 | MNO321 | Chevrolet |       60000 |
|         5 | Carlos  | Eduardo  | García    | Sánchez    | carlos.garcia@example.com | Av. Bolívar 333       | 23123123-5 | PQR678 | Nissan    |       45000 |
|         2 | Ana     | María    | Gómez     | Rojas      | ana.gomez@example.com     | Calle Secundaria 456  | 98765432-1 | XYZ789 | Honda     |       50000 |
|         2 | Ana     | María    | Gómez     | Rojas      | ana.gomez@example.com     | Calle Secundaria 456  | 98765432-1 | XYZ789 | Honda     |       50000 |
+-----------+---------+----------+-----------+------------+---------------------------+-----------------------+------------+--------+-----------+-------------+
```
4. Obtener la cantidad de piezas en inventario para cada pieza

```sql
SELECT p.pieza, i.stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza;
```
```mysql
+--------------------+-------+
| pieza              | stock |
+--------------------+-------+
| Filtro de Aceite   |   100 |
| Filtro de Aire     |   150 |
| Filtro de Aire     |    30 |
| Pastillas de Freno |   200 |
| Neumático          |    50 |
| Aceite de Motor    |   300 |
+--------------------+-------+

```
5. Obtener las citas programadas para un día específico

```sql
SELECT ci.id_cita, c.nombre1, c.apellido1, v.placa, s.servicio, ci.fecha
FROM citas ci
JOIN cliente c ON ci.id_cliente = c.clienteID
JOIN vehiculo v ON ci.id_vehiculo = v.placa
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha = '2024-06-01';

```
```mysql
+---------+---------+-----------+--------+------------------+------------+
| id_cita | nombre1 | apellido1 | placa  | servicio         | fecha      |
+---------+---------+-----------+--------+------------------+------------+
|       1 | Juan    | Pérez     | ABC123 | Cambio de Aceite | 2024-06-01 |
+---------+---------+-----------+--------+------------------+------------+

```
6. Generar una factura para un cliente específico en una fecha determinada

```sql
SELECT f.id_facturacion, f.fecha, f.total, c.nombre1, c.apellido1, s.servicio, s.costo
FROM facturacion f
JOIN cliente c ON f.id_cliente = c.clienteID
JOIN factura_detalles fd ON f.id_facturacion = fd.id_facturacion
JOIN servicio_reparacion sr ON fd.id_servicio_reparacion = sr.id_servicio_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE f.id_cliente = 1  -- Reemplazar por el ID del cliente específico
  AND f.fecha = '2024-06-01';  -- Reemplazar por la fecha específica
```
```mysql
+----------------+------------+-------+---------+-----------+------------------+-------+
| id_facturacion | fecha      | total | nombre1 | apellido1 | servicio         | costo |
+----------------+------------+-------+---------+-----------+------------------+-------+
|              1 | 2024-06-01 | 50.00 | Juan    | Pérez     | Cambio de Aceite | 50.00 |
+----------------+------------+-------+---------+-----------+------------------+-------+

```
7. Listar todas las órdenes de compra y sus detalles

```sql
SELECT oc.id_orden_compra, oc.fecha, oc.total, p.nombre, p.apellido, doc.cantidad, doc.precio, rp.pieza
FROM ordenes_compra oc
JOIN proveedor p ON oc.id_proveedor = p.id_proveedor
JOIN detalle_orden_compra doc ON oc.id_orden_compra = doc.id_orden_compra
JOIN repuestos_piezas rp ON doc.id_repuesto_pieza = rp.id_repuesto_pieza;
```
```mysql
+-----------------+------------+---------+--------+------------+----------+--------+--------------------+
| id_orden_compra | fecha      | total   | nombre | apellido   | cantidad | precio | pieza              |
+-----------------+------------+---------+--------+------------+----------+--------+--------------------+
|               1 | 2024-05-01 |  500.00 | Mario  | Gutiérrez  |       10 |  50.00 | Filtro de Aceite   |
|               2 | 2024-05-02 | 1000.00 | Laura  | Fernández  |       20 |  50.00 | Pastillas de Freno |
|               3 | 2024-05-03 | 1500.00 | Jorge  | Salinas    |       30 |  50.00 | Neumático          |
|               4 | 2024-05-04 | 2000.00 | Marta  | Pérez      |       40 |  50.00 | Aceite de Motor    |
|               5 | 2024-05-05 | 2500.00 | Diego  | Rodríguez  |       50 |  50.00 | Bujías             |
+-----------------+------------+---------+--------+------------+----------+--------+--------------------+

```
8. Obtener el costo total de piezas utilizadas en una reparación específica

```sql
SELECT r.id_reparacion, SUM(doc.precio * doc.cantidad) AS costo_total
FROM reparaciones r
JOIN detalle_orden_compra doc ON r.id_repuesto_pieza = doc.id_repuesto_pieza
WHERE r.id_reparacion = 1  -- Reemplazar por el ID de la reparación específica
GROUP BY r.id_reparacion;
```
```mysql
+---------------+-------------+
| id_reparacion | costo_total |
+---------------+-------------+
|             1 |      500.00 |
+---------------+-------------+

```
9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad menor que un umbral)

```sql
SELECT p.pieza, i.stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza
WHERE i.stock < 50;
```
```mysql
+----------------+-------+
| pieza          | stock |
+----------------+-------+
| Filtro de Aire |    30 |
+----------------+-------+

```
10. Obtener la lista de servicios más solicitados en un período específico

```sql
SELECT s.servicio, COUNT(*) AS num_solicitudes
FROM citas ci
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha BETWEEN '2024-01-01' AND '2024-12-31'  -- Reemplazar las fechas por el período específico
GROUP BY s.servicio
ORDER BY num_solicitudes DESC;
```
```mysql
+------------------------+-----------------+
| servicio               | num_solicitudes |
+------------------------+-----------------+
| Cambio de Aceite       |               1 |
| Alineación y Balanceo  |               1 |
| Revisión de Frenos     |               1 |
| Cambio de Neumáticos   |               1 |
| Reparación de Motor    |               1 |
+------------------------+-----------------+
```
11. Obtener el costo total de reparaciones para cada cliente en un período específico

```sql
SELECT c.clienteID, c.nombre1, c.apellido1, SUM(s.costo) AS costo_total
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha BETWEEN '2024-01-01' AND '2024-12-31'  -- Reemplazar las fechas por el período específico
GROUP BY c.clienteID;

```
```mysql
+-----------+---------+-----------+-------------+
| clienteID | nombre1 | apellido1 | costo_total |
+-----------+---------+-----------+-------------+
|         1 | Juan    | Pérez     |       50.00 |
|         2 | Ana     | Gómez     |       80.00 |
|         3 | Luis    | Martínez  |       60.00 |
|         4 | Sofía   | Ramírez   |      100.00 |
|         5 | Carlos  | García    |      500.00 |
+-----------+---------+-----------+-------------+
```
12. Listar los empleados con mayor cantidad de reparaciones realizadas en un período específico

```sql
SELECT e.nombre1, e.apellido1, COUNT(*) AS num_reparaciones
FROM historial_reparacion_emp hre
JOIN empleados e ON hre.id_empleado = e.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
WHERE r.fecha_inicio BETWEEN '2024-01-01' AND '2024-12-31'  -- Reemplazar las fechas por el período específico
GROUP BY e.id_empleado
ORDER BY num_reparaciones DESC;
```
```mysql
+---------+-----------+------------------+
| nombre1 | apellido1 | num_reparaciones |
+---------+-----------+------------------+
| Pedro   | López     |                1 |
| Mónica  | González  |                1 |
| José    | Ramírez   |                1 |
| Lucía   | Morales   |                1 |
| Roberto | Méndez    |                1 |
+---------+-----------+------------------+
```
13. Obtener las piezas más utilizadas en reparaciones durante un período específico

```sql
SELECT rp.pieza, COUNT(*) AS num_usos
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.fecha_inicio BETWEEN '2024-01-01' AND '2024-12-31'  -- Reemplazar las fechas por el período específico
GROUP BY rp.pieza
ORDER BY num_usos DESC;

```
```mysql
+--------------------+----------+
| pieza              | num_usos |
+--------------------+----------+
| Filtro de Aceite   |        1 |
| Pastillas de Freno |        1 |
| Neumático          |        1 |
| Aceite de Motor    |        1 |
| Bujías             |        1 |
+--------------------+----------+
```
14. Calcular el promedio de costo de reparaciones por vehículo

```sql
SELECT v.placa, AVG(s.costo) AS promedio_costo
FROM vehiculo v
JOIN citas ci ON v.placa = ci.id_vehiculo
JOIN servicios s ON ci.id_servicio = s.id_servicio
GROUP BY v.placa;
```
```mysql
+--------+----------------+
| placa  | promedio_costo |
+--------+----------------+
| ABC123 |      50.000000 |
| JKL456 |      60.000000 |
| MNO321 |     100.000000 |
| PQR678 |     500.000000 |
| XYZ789 |      80.000000 |
+--------+----------------+
```
15. Obtener el inventario de piezas por proveedor

```sql
SELECT p.nombre, p.apellido, pi.pieza, i.stock
FROM proveedor p
JOIN piezas pi ON p.id_pieza = pi.id_pieza
JOIN inventarios i ON pi.id_pieza = i.id_pieza;
```
```mysql
+--------+------------+--------------------+-------+
| nombre | apellido   | pieza              | stock |
+--------+------------+--------------------+-------+
| Mario  | Gutiérrez  | Filtro de Aceite   |   100 |
| Laura  | Fernández  | Filtro de Aire     |   150 |
| Laura  | Fernández  | Filtro de Aire     |    30 |
| Jorge  | Salinas    | Pastillas de Freno |   200 |
| Marta  | Pérez      | Neumático          |    50 |
| Diego  | Rodríguez  | Aceite de Motor    |   300 |
+--------+------------+--------------------+-------+
```
16. Listar los clientes que no han realizado reparaciones en el último año

```sql
SELECT c.clienteID, c.nombre1, c.apellido1
FROM cliente c
LEFT JOIN citas ci ON c.clienteID = ci.id_cliente
WHERE ci.fecha IS NULL
   OR ci.fecha < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
```
```mysql
+-----------+---------+-----------+
| clienteID | nombre1 | apellido1 |
+-----------+---------+-----------+
|         1 | Juan    | Pérez     |
+-----------+---------+-----------+
```
17. Obtener las ganancias totales del taller en un período específico

```sql
SELECT SUM(f.total) AS ganancias_totales
FROM facturacion f
WHERE f.fecha BETWEEN '2024-01-01' AND '2024-12-31';
```
```mysql
+-------------------+
| ganancias_totales |
+-------------------+
|            790.00 |
+-------------------+

```
18. Listar los empleados y el total de horas trabajadas en reparaciones en un período específico (asumiendo que se registra la duración de cada reparación)

```sql
SELECT e.id_empleado, e.nombre1, e.apellido1, SEC_TO_TIME(SUM(TIME_TO_SEC(r.duracion))) AS total_horas_trabajadas
FROM empleados e
LEFT JOIN historial_reparacion_emp hre ON e.id_empleado = hre.id_empleado
LEFT JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
WHERE r.fecha_inicio >= '2024-01-01' AND r.fecha_finalizacion <= '2024-06-01' -- Rango de fecha específico
GROUP BY e.id_empleado;
```
```mysql
+-------------+---------+-----------+------------------------+
| id_empleado | nombre1 | apellido1 | total_horas_trabajadas |
+-------------+---------+-----------+------------------------+
|           1 | Pedro   | López     | 02:00:00               |
+-------------+---------+-----------+------------------------+
```
19. Obtener el listado de servicios prestados por cada empleado en un período específico

```sql
SELECT e.nombre1, e.apellido1, s.servicio, COUNT(*) AS num_servicios
FROM empleados e
JOIN historial_reparacion_emp hre ON e.id_empleado = hre.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
JOIN servicio_reparacion sr ON r.id_reparacion = sr.id_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE r.fecha_inicio BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY e.id_empleado, s.servicio
ORDER BY e.nombre1, e.apellido1, s.servicio;
```
```mysql
+---------+-----------+------------------------+---------------+
| nombre1 | apellido1 | servicio               | num_servicios |
+---------+-----------+------------------------+---------------+
| José    | Ramírez   | Revisión de Frenos     |             1 |
| Lucía   | Morales   | Cambio de Neumáticos   |             1 |
| Mónica  | González  | Alineación y Balanceo  |             1 |
| Pedro   | López     | Cambio de Aceite       |             1 |
| Roberto | Méndez    | Reparación de Motor    |             1 |
+---------+-----------+------------------------+---------------+
```

### Subconsultas
1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

```sql
SELECT c.clienteID, c.nombre1, c.apellido1, SUM(s.costo) AS total_gasto
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY c.clienteID
ORDER BY total_gasto DESC
LIMIT 1;

```
```mysql
+-----------+---------+-----------+-------------+
| clienteID | nombre1 | apellido1 | total_gasto |
+-----------+---------+-----------+-------------+
|         5 | Carlos  | García    |      500.00 |
+-----------+---------+-----------+-------------+

```
2. Obtener la pieza más utilizada en reparaciones durante el último mes

```sql
SELECT rp.pieza, COUNT(*) AS num_usos
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.fecha_inicio BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 MONTH) AND CURDATE()
GROUP BY rp.pieza
ORDER BY num_usos DESC
LIMIT 1;

```
```mysql
+------------------+----------+
| pieza            | num_usos |
+------------------+----------+
| Filtro de Aceite |        1 |
+------------------+----------+
```
3. Obtener los proveedores que suministran las piezas más caras

```sql
SELECT p.nombre, p.apellido, rp.pieza, MAX(doc.precio) AS max_precio
FROM proveedor p
JOIN ordenes_compra oc ON p.id_proveedor = oc.id_proveedor
JOIN detalle_orden_compra doc ON oc.id_orden_compra = doc.id_orden_compra
JOIN repuestos_piezas rp ON doc.id_repuesto_pieza = rp.id_repuesto_pieza
GROUP BY p.nombre, p.apellido, rp.pieza
ORDER BY max_precio DESC
LIMIT 10;

```
```mysql
+--------+------------+--------------------+------------+
| nombre | apellido   | pieza              | max_precio |
+--------+------------+--------------------+------------+
| Mario  | Gutiérrez  | Filtro de Aceite   |      50.00 |
| Laura  | Fernández  | Pastillas de Freno |      50.00 |
| Jorge  | Salinas    | Neumático          |      50.00 |
| Marta  | Pérez      | Aceite de Motor    |      50.00 |
| Diego  | Rodríguez  | Bujías             |      50.00 |
+--------+------------+--------------------+------------+
```

4. Listar las reparaciones que no utilizaron piezas específicas durante el último año

```sql
SELECT r.id_reparacion, r.fecha_inicio, r.fecha_finalizacion, rp.pieza
FROM reparaciones r
LEFT JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE rp.pieza IS NULL
   OR r.fecha_inicio BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE();
```
```mysql
+---------------+--------------+--------------------+--------------------+
| id_reparacion | fecha_inicio | fecha_finalizacion | pieza              |
+---------------+--------------+--------------------+--------------------+
|             1 | 2024-06-01   | 2024-06-01         | Filtro de Aceite   |
|             2 | 2024-06-02   | 2024-06-02         | Pastillas de Freno |
|             3 | 2024-06-03   | 2024-06-03         | Neumático          |
|             4 | 2024-06-04   | 2024-06-04         | Aceite de Motor    |
|             5 | 2024-06-05   | 2024-06-05         | Bujías             |
+---------------+--------------+--------------------+--------------------+

```
5. Obtener las piezas que están en inventario por debajo del 10% del stock inicial

```sql
SELECT p.pieza, i.stock, (0.1 * MAX(stock)) AS umbral_stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza
GROUP BY p.pieza, i.stock;

```
```mysql
+--------------------+-------+--------------+
| pieza              | stock | umbral_stock |
+--------------------+-------+--------------+
| Filtro de Aceite   |   100 |         10.0 |
| Filtro de Aire     |   150 |         15.0 |
| Filtro de Aire     |    30 |          3.0 |
| Pastillas de Freno |   200 |         20.0 |
| Neumático          |    50 |          5.0 |
| Aceite de Motor    |   300 |         30.0 |
+--------------------+-------+--------------+
```

### Procedimientos Almacenados
1. Crear un procedimiento almacenado para insertar una nueva reparación.

```sql
DELIMITER $$
CREATE PROCEDURE InsertarReparacion(
    IN p_id_vehiculo VARCHAR(10),
    IN p_id_repuesto_pieza INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_finalizacion DATE,
    IN p_duracion TIME
)
BEGIN
    INSERT INTO reparaciones (id_vehiculo, id_repuesto_pieza, fecha_inicio, fecha_finalizacion, duracion)
    VALUES (p_id_vehiculo, p_id_repuesto_pieza, p_fecha_inicio, p_fecha_finalizacion, p_duracion);
END$$
DELIMITER ;

```
```mysql

```

2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

```sql
DELIMITER $$
CREATE PROCEDURE ActualizarInventario(
    IN p_id_repuesto_pieza INT,
    IN p_id_area_taller INT,
    IN p_stock INT
)
BEGIN
    UPDATE inventarios
    SET stock = p_stock
    WHERE id_repuesto_pieza = p_id_repuesto_pieza AND id_area_taller = p_id_area_taller;
END$$
DELIMITER ;

```
```mysql

```

3. Crear un procedimiento almacenado para eliminar una cita

```sql
DELIMITER $$
CREATE PROCEDURE EliminarCita(
    IN p_id_cita INT
)
BEGIN
    DELETE FROM citas WHERE id_cita = p_id_cita;
END$$
DELIMITER ;

```
```mysql

```

4. Crear un procedimiento almacenado para generar una factura

```sql
DELIMITER $$
CREATE PROCEDURE GenerarFactura(
    IN p_id_cliente INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10, 2)
)
BEGIN
    INSERT INTO facturacion (id_cliente, fecha, total)
    VALUES (p_id_cliente, p_fecha, p_total);
END$$
DELIMITER ;

```
```mysql

```

5. Crear un procedimiento almacenado para obtener el historial de reparaciones de un vehículo

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerHistorialReparaciones(
    IN p_id_vehiculo VARCHAR(10)
)
BEGIN
    SELECT *
    FROM reparaciones
    WHERE id_vehiculo = p_id_vehiculo;
END$$
DELIMITER ;

```
```mysql

```

6. Crear un procedimiento almacenado para calcular el costo total de reparaciones de un cliente en un período

```sql
DELIMITER $$
CREATE PROCEDURE CalcularCostoReparacionesCliente(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    OUT p_costo_total DECIMAL(10, 2)
)
BEGIN
    SELECT SUM(servicios.costo) INTO p_costo_total
    FROM facturacion
    INNER JOIN factura_detalles ON facturacion.id_facturacion = factura_detalles.id_facturacion
    INNER JOIN servicio_reparacion ON factura_detalles.id_servicio_reparacion = servicio_reparacion.id_servicio_reparacion
    INNER JOIN servicios ON servicio_reparacion.id_servicio = servicios.id_servicio
    INNER JOIN reparaciones ON servicio_reparacion.id_reparacion = reparaciones.id_reparacion
    WHERE facturacion.id_cliente = p_id_cliente
    AND facturacion.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END$$
DELIMITER ;

```
```mysql

```

7. Crear un procedimiento almacenado para obtener la lista de vehículos que requieren mantenimiento basado en el kilometraje.

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerVehiculosMantenimiento(
    IN p_kilometraje_limite INT
)
BEGIN
    SELECT *
    FROM vehiculo
    WHERE kilometraje >= p_kilometraje_limite;
END$$
DELIMITER ;
```
```mysql

```

8. Crear un procedimiento almacenado para insertar una nueva orden de compra

```sql
DELIMITER $$
CREATE PROCEDURE InsertarOrdenCompra(
    IN p_id_proveedor INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10, 2)
)
BEGIN
    INSERT INTO ordenes_compra (id_proveedor, id_empleado, fecha, total)
    VALUES (p_id_proveedor, p_id_empleado, p_fecha, p_total);
END$$
DELIMITER ;
```
```mysql

```

9. Crear un procedimiento almacenado para actualizar los datos de un cliente

```sql
DELIMITER $$
CREATE PROCEDURE ActualizarCliente(
    IN p_id_cliente INT,
    IN p_nombre1 VARCHAR(50),
    IN p_nombre2 VARCHAR(50),
    IN p_apellido1 VARCHAR(50),
    IN p_apellido2 VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_NIT VARCHAR(20)
)
BEGIN
    UPDATE cliente
    SET nombre1 = p_nombre1,
        nombre2 = p_nombre2,
        apellido1 = p_apellido1,
        apellido2 = p_apellido2,
        email = p_email,
        direccion = p_direccion,
        NIT = p_NIT
    WHERE clienteID = p_id_cliente;
END$$
DELIMITER ;

```
```mysql

```

10. Crear un procedimiento almacenado para obtener los servicios más solicitados en un período

```sql
DELIMITER $$
CREATE PROCEDURE ObtenerServiciosMasSolicitados(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT servicios.servicio, COUNT(*) AS total_solicitudes
    FROM citas
    INNER JOIN servicios ON citas.id_servicio = servicios.id_servicio
    WHERE citas.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY servicios.servicio
    ORDER BY total_solicitudes DESC;
END$$
DELIMITER ;
```
```mysql

```