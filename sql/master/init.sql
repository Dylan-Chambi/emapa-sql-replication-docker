CREATE DATABASE IF NOT EXISTS emapa_ventas;

USE emapa_ventas;

CReATE TABLE IF NOT EXISTS categoria (
    id_categoria INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_categoria VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE IF NOT EXISTS marca (
    id_marca INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_marca VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_marca)
);

CREATE TABLE IF NOT EXISTS almacen (
    id_almacen INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_almacen VARCHAR(100) NOT NULL,
    lugar_almacen VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_almacen)
);

CREATE TABLE IF NOT EXISTS cliente (
    nit_ci BIGINT UNSIGNED NOT NULL UNIQUE,
    nombres_cliente VARCHAR(50) NOT NULL,
    apellido_paterno VARCHAR(50) NOT NULL,
    apellido_materno VARCHAR(50) NOT NULL,
    corre_cliente VARCHAR(30) NOT NULL,
    telefono_cliente VARCHAR(20) NOT NULL,
    extension_ci VARCHAR(5) NOT NULL,
    PRIMARY KEY (nit_ci)
);

CREATE TABLE IF NOT EXISTS empresa (
    id_empresa INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_empresa VARCHAR(100) NOT NULL,
    marca_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_empresa),
    FOREIGN KEY (marca_id) REFERENCES marca (id_marca)
);

CREATE TABLE IF NOT EXISTS proveedor (
    id_proveedor INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_proveedor VARCHAR(100) NOT NULL,
    empresa_id INT UNSIGNED NOT NULL,
    telefono_proveedor VARCHAR(20),
    encargado_proveedor VARCHAR(50),
    PRIMARY KEY (id_proveedor),
    FOREIGN KEY (empresa_id) REFERENCES empresa (id_empresa)
);

CREATE TABLE IF NOT EXISTS factura (
    nro_factura BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nro_autorizacion INT UNSIGNED NOT NULL,
    nit_empresa BIGINT UNSIGNED NOT NULL,
    fecha_emision DATE NOT NULL,
    nombre_o_razon_social VARCHAR(255) NOT NULL,
    cliente_nit_ci BIGINT UNSIGNED NOT NULL,
    detalle VARCHAR(255),
    subtotal DECIMAL(10, 2) NOT NULL,
    importe_total DECIMAL(10, 2) NOT NULL,
    codigo_control VARCHAR(255) NOT NULL,
    codigo_qr BLOB,
    fecha_limite_emision DATE NOT NULL,
    estado ENUM('ACTIVA', 'ANULADA', 'PENDIENTE') NOT NULL,
    PRIMARY KEY (nro_factura),
    FOREIGN KEY (cliente_nit_ci) references cliente (nit_ci)
) AUTO_INCREMENT = 10000000;

CREATE TABLE IF NOT EXISTS producto (
    id_producto INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    nombre_producto VARCHAR(100) NOT NULL,
    proveedor_id INT UNSIGNED NOT NULL,
    codigo_barras BIGINT UNSIGNED,
    precio_nacional DECIMAL(10, 2) NOT NULL,
    marca_id INT UNSIGNED NOT NULL,
    categoria_id INT UNSIGNED NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    estado_producto ENUM('HABILITADO', 'DESHABILITADO'),
    PRIMARY KEY (id_producto),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor (id_proveedor),
    FOREIGN KEY (marca_id) REFERENCES marca (id_marca),
    FOREIGN KEY (categoria_id) REFERENCES categoria (id_categoria)
);

CREATE TABLE IF NOT EXISTS compra (
    id_compra INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    fecha_compra DATE NOT NULL,
    proveedor_id INT UNSIGNED NOT NULL,
    total_compra DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_compra),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor (id_proveedor)
);

CREATE TABLE IF NOT EXISTS detalle_compra (
    id_detalle_compra INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    compra_id INT UNSIGNED NOT NULL,
    producto_id INT UNSIGNED NOT NULL,
    cantidad_producto MEDIUMINT NOT NULL,
    CHECK (cantidad_producto > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    total_detalle_compra DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_detalle_compra),
    FOREIGN KEY (compra_id) REFERENCES compra (id_compra),
    FOREIGN KEY (producto_id) REFERENCES producto (id_producto)
);

CREATE TABLE IF NOT EXISTS venta (
    id_venta INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    fecha_venta DATE NOT NULL,
    cliente_nit_ci BIGINT UNSIGNED NOT NULL,
    estado_venta ENUM('INMEDIATA', 'PENDIENTE', 'PAGADA'),
    factura_nro BIGINT UNSIGNED NOT NULL,
    total_venta DECIMAL(10, 2),
    PRIMARY KEY (id_venta),
    FOREIGN KEY (cliente_nit_ci) references cliente (nit_ci),
    FOREIGN KEY (factura_nro) references factura (nro_factura)
);

CREATE TABLE IF NOT EXISTS detalle_venta (
    id_detalle_venta INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    venta_id INT UNSIGNED NOT NULL,
    producto_id INT UNSIGNED NOT NULL,
    cantidad_producto MEDIUMINT NOT NULL,
    CHECK (cantidad_producto > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    total_detalle_compra DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_detalle_venta),
    FOREIGN KEY (venta_id) REFERENCES venta (id_venta),
    FOREIGN KEY (producto_id) REFERENCES producto (id_producto)
);

CREATE TABLE IF NOT EXISTS movimiento_producto (
    id_movimiento INT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE,
    producto_id INT UNSIGNED NOT NULL,
    almacen_origen_id INT UNSIGNED NOT NULL,
    almacen_destino_id INT UNSIGNED NOT NULL,
    fecha_movimiento DATE NOT NULL,
    PRIMARY KEY (id_movimiento),
    FOREIGN KEY (producto_id) REFERENCES producto (id_producto),
    FOREIGN KEY (almacen_origen_id) REFERENCES almacen (id_almacen),
    FOREIGN KEY (almacen_destino_id) REFERENCES almacen (id_almacen)
);