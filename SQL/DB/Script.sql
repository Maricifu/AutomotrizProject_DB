CREATE DATABASE automotrizDB;
USE automotrizDB;


CREATE TABLE cargo (
    id_cargo INT(10) PRIMARY KEY,
    cargo VARCHAR(50) NOT NULL
);


CREATE TABLE empleados (
    id_empleado INT(10) PRIMARY KEY,
    nombre1 VARCHAR(50) NOT NULL,
    nombre2 VARCHAR(50),
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    email VARCHAR(100) NOT NULL,
    id_cargo INT(10) NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);



CREATE TABLE area_taller (
    id_area_taller INT(10) PRIMARY KEY,
    area VARCHAR(50) NOT NULL
);



CREATE TABLE tipo_telefono (
    id_tipo_telefono INT(10) PRIMARY KEY,
    tipo VARCHAR(20) NOT NULL
);



CREATE TABLE telefono (
    id_telefono INT(10) PRIMARY KEY,
    id_tipo_telefono INT(10) NOT NULL,
    telefono VARCHAR(20),
    FOREIGN KEY (id_tipo_telefono) REFERENCES tipo_telefono(id_tipo_telefono)
);




CREATE TABLE telefono_empleado (
    id_telefono INT(10),
    id_empleado INT(10),
    PRIMARY KEY (id_telefono, id_empleado),
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);



CREATE TABLE cliente (
    clienteID INT(10) PRIMARY KEY,
    nombre1 VARCHAR(50) NOT NULL,
    nombre2 VARCHAR(50),
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50),
    email VARCHAR(100) NOT NULL,
    direccion VARCHAR(200),
    NIT VARCHAR(20)
);



CREATE TABLE marca_vehiculo (
    id_marca_vehiculo INT(10) PRIMARY KEY,
    marca VARCHAR(50) NOT NULL
);



CREATE TABLE vehiculo (
    placa VARCHAR(10) PRIMARY KEY,
    id_marca_vehiculo INT(10) NOT NULL,
    FOREIGN KEY (id_marca_vehiculo) REFERENCES marca_vehiculo(id_marca_vehiculo)
);



CREATE TABLE categoria_pieza (
    id_categoria_pieza INT(10) PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL
);



CREATE TABLE repuestos_piezas (
    id_repuesto_pieza INT(10) PRIMARY KEY,
    id_categoria_pieza INT(10) NOT NULL,
    pieza VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_categoria_pieza) REFERENCES categoria_pieza(id_categoria_pieza)
);



CREATE TABLE piezas (
    id_pieza INT(10) PRIMARY KEY,
    pieza VARCHAR(50) NOT NULL
);



CREATE TABLE inventarios (
    id_inventarios INT(10) PRIMARY KEY,
    id_repuesto_pieza INT(10),
    id_pieza INT(10) NOT NULL,
    id_area_taller INT(10) NOT NULL,
    stock INT(225) NOT NULL,
    FOREIGN KEY (id_repuesto_pieza) REFERENCES repuestos_piezas(id_repuesto_pieza),
    FOREIGN KEY (id_pieza) REFERENCES piezas(id_pieza),
    FOREIGN KEY (id_area_taller) REFERENCES area_taller(id_area_taller)
);



CREATE TABLE servicios (
    id_servicio INT(10) PRIMARY KEY,
    id_area_taller INT(10) NOT NULL,
    servicio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    costo DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_area_taller) REFERENCES area_taller(id_area_taller)
);



CREATE TABLE citas (
    id_cita INT(10) PRIMARY KEY,
    id_cliente INT(10) NOT NULL,
    id_vehiculo VARCHAR(10) NOT NULL,
    id_servicio INT(10) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(clienteID),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(placa),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);



CREATE TABLE reparaciones (
    id_reparacion INT(10) PRIMARY KEY,
    id_vehiculo VARCHAR(10) NOT NULL,
    id_repuesto_pieza INT(10) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_finalizacion DATE NOT NULL,
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(placa),
    FOREIGN KEY (id_repuesto_pieza) REFERENCES repuestos_piezas(id_repuesto_pieza)
);



CREATE TABLE servicio_reparacion (
    id_servicio_reparacion INT(10) PRIMARY KEY,
    id_servicio INT(10) NOT NULL,
    id_reparacion INT(10) NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
    FOREIGN KEY (id_reparacion) REFERENCES reparaciones(id_reparacion)
);



CREATE TABLE historial_reparacion_emp (
    id_reparacion INT(10) NOT NULL,
    id_empleado INT(10) NOT NULL,
    PRIMARY KEY (id_reparacion, id_empleado),
    FOREIGN KEY (id_reparacion) REFERENCES reparaciones(id_reparacion),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);



CREATE TABLE proveedor (
    id_proveedor INT(10) PRIMARY KEY,
    id_pieza INT(10) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    contacto VARCHAR(100),
    NIT VARCHAR(20),
    FOREIGN KEY (id_pieza) REFERENCES piezas(id_pieza)
);



CREATE TABLE ordenes_compra (
    id_orden_compra INT(10) PRIMARY KEY,
    id_proveedor INT(10) NOT NULL,
    id_empleado INT(10) NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);



CREATE TABLE detalle_orden_compra (
    id_detalle_orden_compra INT(10) PRIMARY KEY,
    id_orden_compra INT(10) NOT NULL,
    id_repuesto_pieza INT(10) NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2),
    FOREIGN KEY (id_orden_compra) REFERENCES ordenes_compra(id_orden_compra),
    FOREIGN KEY (id_repuesto_pieza) REFERENCES repuestos_piezas(id_repuesto_pieza)
);



CREATE TABLE telefono_proveedor (
    id_telefono INT(10) NOT NULL,
    id_proveedor INT(10) NOT NULL,
    PRIMARY KEY (id_telefono, id_proveedor),
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);



CREATE TABLE facturacion (
    id_facturacion INT(10) PRIMARY KEY,
    id_cliente INT(10) NOT NULL,
    fecha DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(clienteID)
);



CREATE TABLE factura_detalles (
    id_facturacion INT(10) NOT NULL,
    id_servicio_reparacion INT(10) NOT NULL,
    PRIMARY KEY (id_facturacion, id_servicio_reparacion),
    FOREIGN KEY (id_facturacion) REFERENCES facturacion(id_facturacion),
    FOREIGN KEY (id_servicio_reparacion) REFERENCES servicio_reparacion(id_servicio_reparacion)
);



CREATE TABLE telefono_cliente (
    id_telefono INT(10) NOT NULL,
    id_cliente INT(10) NOT NULL,
    PRIMARY KEY (id_telefono, id_cliente),
    FOREIGN KEY (id_telefono) REFERENCES telefono(id_telefono),
    FOREIGN KEY (id_cliente) REFERENCES cliente(clienteID)
);
