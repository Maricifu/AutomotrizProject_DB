# Queries Automotriz DataBase

### Consultas requeridas
1. Obtener el historial de reparaciones de un vehículo específico

```sql
SELECT r.id_reparacion, r.id_vehiculo, r.id_repuesto_pieza, rp.pieza, r.fecha_inicio, r.fecha_finalizacion
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.id_vehiculo = 'VEHICULO_ESPECIFICO';


```
```mysql

```


2. Calcular el costo total de todas las reparaciones realizadas por un empleado específico en un período de tiempo

```sql
SELECT SUM(s.costo) AS costo_total
FROM historial_reparacion_emp hre
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
JOIN servicio_reparacion sr ON sr.id_reparacion = r.id_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE hre.id_empleado = 'EMPLEADO_ESPECIFICO'
  AND r.fecha_inicio BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN';


```
```mysql

```
3. Listar todos los clientes y los vehículos que poseen

```sql
SELECT c.clienteID, c.nombre1, c.nombre2, c.apellido1, c.apellido2, v.placa, mv.marca
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN vehiculo v ON ci.id_vehiculo = v.placa
JOIN marca_vehiculo mv ON v.id_marca_vehiculo = mv.id_marca_vehiculo
GROUP BY c.clienteID, v.placa;


```
```mysql

```
4. Obtener la cantidad de piezas en inventario para cada pieza

```sql
SELECT p.id_pieza, p.pieza, i.stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza;


```
```mysql

```
5. Obtener las citas programadas para un día específico

```sql
SELECT ci.id_cita, ci.fecha, c.nombre1, c.nombre2, c.apellido1, c.apellido2, v.placa, s.servicio
FROM citas ci
JOIN cliente c ON ci.id_cliente = c.clienteID
JOIN vehiculo v ON ci.id_vehiculo = v.placa
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha = 'FECHA_ESPECIFICA';


```
```mysql

```
6. Generar una factura para un cliente específico en una fecha determinada

```sql
SELECT f.id_facturacion, f.fecha, c.nombre1, c.nombre2, c.apellido1, c.apellido2, sr.id_servicio, s.servicio, s.costo
FROM facturacion f
JOIN cliente c ON f.id_cliente = c.clienteID
JOIN factura_detalles fd ON f.id_facturacion = fd.id_facturacion
JOIN servicio_reparacion sr ON fd.id_servicio_reparacion = sr.id_servicio_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE f.id_cliente = 'CLIENTE_ESPECIFICO' AND f.fecha = 'FECHA_ESPECIFICA';


```
```mysql

```
7. Listar todas las órdenes de compra y sus detalles

```sql
SELECT oc.id_orden_compra, oc.fecha, oc.total, p.nombre, p.apellido, e.nombre1, e.apellido1, doc.id_detalle_orden_compra, rp.pieza, doc.cantidad, doc.precio
FROM ordenes_compra oc
JOIN proveedor p ON oc.id_proveedor = p.id_proveedor
JOIN empleados e ON oc.id_empleado = e.id_empleado
JOIN detalle_orden_compra doc ON oc.id_orden_compra = doc.id_orden_compra
JOIN repuestos_piezas rp ON doc.id_repuesto_pieza = rp.id_repuesto_pieza;


```
```mysql

```
8. Obtener el costo total de piezas utilizadas en una reparación específica

```sql
SELECT SUM(doc.precio * doc.cantidad) AS costo_total
FROM detalle_orden_compra doc
JOIN ordenes_compra oc ON doc.id_orden_compra = oc.id_orden_compra
JOIN proveedor p ON oc.id_proveedor = p.id_proveedor
JOIN repuestos_piezas rp ON doc.id_repuesto_pieza = rp.id_repuesto_pieza
JOIN reparaciones r ON rp.id_repuesto_pieza = r.id_repuesto_pieza
WHERE r.id_reparacion = 'REPARACION_ESPECIFICA';


```
```mysql

```
9. Obtener el inventario de piezas que necesitan ser reabastecidas (cantidad menor que un umbral)

```sql
SELECT p.id_pieza, p.pieza, i.stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza
WHERE i.stock < 'UMBRAL';


```
```mysql

```
10. Obtener la lista de servicios más solicitados en un período específico

```sql
SELECT s.servicio, COUNT(*) AS cantidad_solicitada
FROM citas ci
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY s.servicio
ORDER BY cantidad_solicitada DESC;


```
```mysql

```
11. Obtener el costo total de reparaciones para cada cliente en un período específico

```sql
SELECT c.clienteID, c.nombre1, c.nombre2, c.apellido1, c.apellido2, SUM(s.costo) AS costo_total
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY c.clienteID;


```
```mysql

```
12. Listar los empleados con mayor cantidad de reparaciones realizadas en un período específico

```sql
SELECT e.id_empleado, e.nombre1, e.apellido1, COUNT(*) AS cantidad_reparaciones
FROM historial_reparacion_emp hre
JOIN empleados e ON hre.id_empleado = e.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
WHERE r.fecha_inicio BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY e.id_empleado
ORDER BY cantidad_reparaciones DESC;


```
```mysql

```
13. Obtener las piezas más utilizadas en reparaciones durante un período específico

```sql
SELECT rp.pieza, COUNT(*) AS cantidad_utilizada
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.fecha_inicio BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY rp.pieza
ORDER BY cantidad_utilizada DESC;


```
```mysql

```
14. Calcular el promedio de costo de reparaciones por vehículo

```sql
SELECT v.placa, AVG(s.costo) AS costo_promedio
FROM citas ci
JOIN vehiculo v ON ci.id_vehiculo = v.placa
JOIN servicios s ON ci.id_servicio = s.id_servicio
GROUP BY v.placa;


```
```mysql

```
15. Obtener el inventario de piezas por proveedor

```sql
SELECT p.id_proveedor, p.nombre, p.apellido, pi.id_pieza, pi.pieza, i.stock
FROM proveedor p
JOIN piezas pi ON p.id_pieza = pi.id_pieza
JOIN inventarios i ON pi.id_pieza = i.id_pieza;


```
```mysql

```
16. Listar los clientes que no han realizado reparaciones en el último año

```sql
SELECT c.clienteID, c.nombre1, c.nombre2, c.apellido1, c.apellido2, c.email
FROM cliente c
LEFT JOIN citas ci ON c.clienteID = ci.id_cliente
WHERE ci.id_cliente IS NULL OR ci.fecha < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);


```
```mysql

```
17. Obtener las ganancias totales del taller en un período específico

```sql
SELECT SUM(f.total) AS ganancias_totales
FROM facturacion f
WHERE f.fecha BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN';


```
```mysql

```
18. Listar los empleados y el total de horas trabajadas en reparaciones en un período específico (asumiendo que se registra la duración de cada reparación)

```sql
SELECT e.id_empleado, e.nombre1, e.apellido1, SUM(TIMESTAMPDIFF(HOUR, r.fecha_inicio, r.fecha_finalizacion)) AS horas_trabajadas
FROM historial_reparacion_emp hre
JOIN empleados e ON hre.id_empleado = e.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
WHERE r.fecha_inicio BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY e.id_empleado;


```
```mysql

```
19. Obtener el listado de servicios prestados por cada empleado en un período específico

```sql
SELECT e.id_empleado, e.nombre1, e.apellido1, s.servicio, COUNT(*) AS cantidad_servicios
FROM historial_reparacion_emp hre
JOIN empleados e ON hre.id_empleado = e.id_empleado
JOIN reparaciones r ON hre.id_reparacion = r.id_reparacion
JOIN servicio_reparacion sr ON r.id_reparacion = sr.id_reparacion
JOIN servicios s ON sr.id_servicio = s.id_servicio
WHERE r.fecha_inicio BETWEEN 'FECHA_INICIO' AND 'FECHA_FIN'
GROUP BY e.id_empleado, s.servicio;


```
```mysql

```

### Subconsultas
1. Obtener el cliente que ha gastado más en reparaciones durante el último año.

```sql
SELECT c.clienteID, c.nombre1, c.nombre2, c.apellido1, c.apellido2, SUM(s.costo) AS total_gastado
FROM cliente c
JOIN citas ci ON c.clienteID = ci.id_cliente
JOIN servicios s ON ci.id_servicio = s.id_servicio
WHERE ci.fecha > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.clienteID
ORDER BY total_gastado DESC
LIMIT 1;


```
```mysql

```
2. Obtener la pieza más utilizada en reparaciones durante el último mes

```sql
SELECT rp.pieza, COUNT(*) AS cantidad_utilizada
FROM reparaciones r
JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
WHERE r.fecha_inicio > DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY rp.pieza
ORDER BY cantidad_utilizada DESC
LIMIT 1;


```
```mysql

```
3. Obtener los proveedores que suministran las piezas más caras

```sql
SELECT p.id_proveedor, p.nombre, p.apellido, MAX(doc.precio) AS precio_max
FROM proveedor p
JOIN detalle_orden_compra doc ON p.id_pieza = doc.id_repuesto_pieza
GROUP BY p.id_proveedor
ORDER BY precio_max DESC;


```
```mysql

```

4. Listar las reparaciones que no utilizaron piezas específicas durante el último año

```sql
SELECT r.id_reparacion, r.id_vehiculo, r.fecha_inicio, r.fecha_finalizacion
FROM reparaciones r
WHERE r.id_repuesto_pieza NOT IN (
    SELECT id_repuesto_pieza
    FROM repuestos_piezas
    WHERE fecha_inicio > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);


```
```mysql

```
5. Obtener las piezas que están en inventario por debajo del 10% del stock inicial

```sql
SELECT p.id_pieza, p.pieza, i.stock
FROM piezas p
JOIN inventarios i ON p.id_pieza = i.id_pieza
WHERE i.stock < (SELECT 0.1 * MAX(stock) FROM inventarios);


```
```mysql

```

### Procedimientos Almacenados
1. Crear un procedimiento almacenado para insertar una nueva reparación.

```sql
CREATE PROCEDURE InsertarReparacion(
    IN p_id_vehiculo VARCHAR(10),
    IN p_id_repuesto_pieza INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_finalizacion DATE
)
BEGIN
    INSERT INTO reparaciones (id_vehiculo, id_repuesto_pieza, fecha_inicio, fecha_finalizacion)
    VALUES (p_id_vehiculo, p_id_repuesto_pieza, p_fecha_inicio, p_fecha_finalizacion);
END;


```
```mysql

```

2. Crear un procedimiento almacenado para actualizar el inventario de una pieza.

```sql
CREATE PROCEDURE ActualizarInventario(
    IN p_id_pieza INT,
    IN p_nuevo_stock INT
)
BEGIN
    UPDATE inventarios
    SET stock = p_nuevo_stock
    WHERE id_pieza = p_id_pieza;
END;


```
```mysql

```

3. Crear un procedimiento almacenado para eliminar una cita

```sql
CREATE PROCEDURE EliminarCita(
    IN p_id_cita INT
)
BEGIN
    DELETE FROM citas
    WHERE id_cita = p_id_cita;
END;


```
```mysql

```

4. Crear un procedimiento almacenado para generar una factura

```sql
CREATE PROCEDURE GenerarFactura(
    IN p_id_cliente INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO facturacion (id_cliente, fecha, total)
    VALUES (p_id_cliente, p_fecha, p_total);
END;


```
```mysql

```

5. Crear un procedimiento almacenado para obtener el historial de reparaciones de un vehículo

```sql
CREATE PROCEDURE ObtenerHistorialReparacionesVehiculo(
    IN p_id_vehiculo VARCHAR(10)
)
BEGIN
    SELECT r.id_reparacion, r.id_vehiculo, r.id_repuesto_pieza, rp.pieza, r.fecha_inicio, r.fecha_finalizacion
    FROM reparaciones r
    JOIN repuestos_piezas rp ON r.id_repuesto_pieza = rp.id_repuesto_pieza
    WHERE r.id_vehiculo = p_id_vehiculo;
END;


```
```mysql

```

6. Crear un procedimiento almacenado para calcular el costo total de reparaciones de un cliente en un período

```sql
CREATE PROCEDURE CalcularCostoTotalReparacionesCliente(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT SUM(s.costo) AS costo_total
    FROM citas ci
    JOIN servicios s ON ci.id_servicio = s.id_servicio
    WHERE ci.id_cliente = p_id_cliente
      AND ci.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END;


```
```mysql

```

7. Crear un procedimiento almacenado para obtener la lista de vehículos que requieren mantenimiento basado en el kilometraje.

```sql
-- Suponiendo que la tabla `vehiculo` tiene un campo `kilometraje`
CREATE PROCEDURE ObtenerVehiculosRequierenMantenimiento(
    IN p_kilometraje_umbral INT
)
BEGIN
    SELECT v.placa, v.kilometraje, mv.marca
    FROM vehiculo v
    JOIN marca_vehiculo mv ON v.id_marca_vehiculo = mv.id_marca_vehiculo
    WHERE v.kilometraje >= p_kilometraje_umbral;
END;


```
```mysql

```

8. Crear un procedimiento almacenado para insertar una nueva orden de compra

```sql
CREATE PROCEDURE InsertarOrdenCompra(
    IN p_id_proveedor INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_total DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes_compra (id_proveedor, id_empleado, fecha, total)
    VALUES (p_id_proveedor, p_id_empleado, p_fecha, p_total);
END;


```
```mysql

```

9. Crear un procedimiento almacenado para actualizar los datos de un cliente

```sql
CREATE PROCEDURE ActualizarDatosCliente(
    IN p_id_cliente INT,
    IN p_nombre1 VARCHAR(50),
    IN p_nombre2 VARCHAR(50),
    IN p_apellido1 VARCHAR(50),
    IN p_apellido2 VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_nit VARCHAR(20)
)
BEGIN
    UPDATE cliente
    SET nombre1 = p_nombre1, nombre2 = p_nombre2, apellido1 = p_apellido1, apellido2 = p_apellido2,
        email = p_email, direccion = p_direccion, NIT = p_nit
    WHERE clienteID = p_id_cliente;
END;


```
```mysql

```

10. Crear un procedimiento almacenado para obtener los servicios más solicitados en un período

```sql
CREATE PROCEDURE ObtenerServiciosMasSolicitados(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT s.servicio, COUNT(*) AS cantidad_solicitada
    FROM citas ci
    JOIN servicios s ON ci.id_servicio = s.id_servicio
    WHERE ci.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY s.servicio
    ORDER BY cantidad_solicitada DESC;
END;


```
```mysql

```