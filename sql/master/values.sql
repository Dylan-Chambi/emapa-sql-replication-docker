USE emapa_productos;

INSERT INTO categoria (id_categoria, nombre_categoria) VALUES
    (1, 'Frutas'),
    (2, 'Carnes'),
    (3, 'Lácteos'),
    (4, 'Panadería'),
    (5, 'Bebidas'),
    (6, 'Salsas y condimentos'),
    (7, 'Dulces y chocolates');

INSERT INTO empresa (id_empresa, nombre_empresa) VALUES
    (1, 'Delizia'),
    (2, 'Pil Andina S.A.'),
    (3, 'Nestlé'),
    (4, 'Industrias Venado S.A.'),
    (5, 'Arcor');

INSERT INTO almacen (id_almacen, nombre_almacen, lugar_almacen) VALUES
    (1, 'Almacén La Paz', 'La Paz, Bolivia - Av. Arce #256'),
    (2, 'Almacén Santa Cruz', 'Santa Cruz, Bolivia - Av. San Martin  #120'),
    (3, 'Almacén Cochabamba', 'Cochabamba, Bolivia - Av. Blanco Galindo $45'),
    (4, 'Almacén Sucre', 'Sucre, Bolivia - Av. Cumana #2001'),
    (5, 'Almacén Oruro', 'Oruro, Bolivia - Av. Civica #373');

INSERT INTO cliente (nit_ci, nombres_cliente, apellido_paterno, apellido_materno, corre_cliente, telefono_cliente, extension_ci) VALUES
    (6963367, 'Dylan Imanol', 'Chambi', 'Frontanilla', 'dylanchambifi@gmail.com', '65608561', 'LP'),
    (9546465, 'Juan', 'Pérez', 'García', 'juan.perez@gmail.com', '77658589', 'LP'),
    (4516514, 'María', 'López', 'González', 'maria.lopez@gmail.com', '70564564', 'SC'),
    (6975165, 'Pedro', 'Ramírez', 'Martínez', 'pedro.ramirez@gmail.com', '66854564', 'CB'),
    (4514645, 'Ana', 'Hernández', 'Vargas', 'ana.hernandez@gmail.com', '67745444', 'OR'),
    (4516466, 'Luis', 'Gutiérrez', 'Díaz', 'luis.gutierrez@gmail.com', '72545465', 'PT');

INSERT INTO marca (id_marca, nombre_marca, empresa_id) VALUES
    (1, 'IceFruit', 1),
    (2, 'PilFrut', 2),
    (3, 'Nesquik', 3),
    (4, 'Kris', 4),
    (5, 'Rocklets', 5);

INSERT INTO proveedor (id_proveedor, nombre_proveedor, empresa_id, telefono_proveedor, encargado_proveedor) VALUES
        (1, 'Grupo Venado', 4, '65608561', 'Juan'),
        (2, 'Andes Tropico', 2, '65608561', 'Juan'),
        (3, 'Francisco Susz Guggenheim Ltda', 3, '77658589', 'María'),
        (4, 'CRUZIMEX LTDA', 1, '65608561', 'Juan'),
        (5, 'EL ARRIERO', 5, '65608561', 'Juan');

INSERT INTO factura (nro_factura, nro_autorizacion, nit_empresa, fecha_emision, nombre_o_razon_social, cliente_nit_ci, detalle, subtotal, importe_total, codigo_control, codigo_qr, fecha_limite_emision, estado) VALUES
    (10000001, 45645, 45146484, '2023-05-22', 'Empresa ABC', 6963367, 'Compra de alimentos', 45.20, 50.26, 'A4-GH-59-B2', NULL, '2023-06-30', 'ACTIVA'),
    (10000002, 45645, 45146484, '2023-06-22', 'Empresa CENIL', 9546465, 'Compra de alimentos', 102.20, 110.05, 'A4-GH-59-B2', NULL, '2023-07-30', 'ACTIVA'),
    (10000003, 45645, 45146484, '2023-04-02', 'N/A', 4516514, 'Compra de alimentos', 23.00, 25.00, 'A4-GH-59-B2', NULL, '2023-06-30', 'ACTIVA'),
    (10000004, 45645, 45146484, '2023-05-12', 'N/A', 6975165, 'Compra de alimentos', 23.00, 25.00, 'A4-GH-59-B2', NULL, '2023-06-30', 'ACTIVA'),
    (10000005, 45645, 45146484, '2023-07-01', 'N/A', 4514645, 'Compra de alimentos', 23.00, 25.00, 'A4-GH-59-B2', NULL, '2023-06-30', 'ACTIVA');


INSERT INTO producto (id_producto, nombre_producto, proveedor_id, codigo_barras, precio_nacional, marca_id, categoria_id, fecha_vencimiento, estado_producto) VALUES
    (1, 'Kris Mayonesa Pomo 380ml', 1, 1234567890, 17.30, 4, 6, '2023-06-30', 'HABILITADO'),
    (2, 'PILFRUT MANZANA 800ML', 2, 2345678901, 1.00, 2, 5, '2023-06-25', 'HABILITADO'),
    (3, 'Nesquik Chocolate 400g', 3, 3456789012, 14.50, 3, 5, '2023-06-28', 'HABILITADO'),
    (4, 'Ice Fruit Mango Botella 2L', 4, 4567890123, 10.50, 1, 5, '2023-06-20', 'HABILITADO'),
    (5, 'Arcor Tableta Rocklets X 80Gr', 5, 5678901234, 10.50, 5, 7, '2023-07-15', 'HABILITADO');


INSERT INTO compra (id_compra, fecha_compra, proveedor_id, total_compra) VALUES
    (1, '2023-05-20', 1, 742.50), -- x 45
    (2, '2023-05-21', 2, 96.00), -- x 120
    (3, '2023-05-22', 3, 417.00), -- x 30
    (4, '2023-05-23', 4, 411.60), -- x 42
    (5, '2023-05-24', 5, 495.00); -- x 50

INSERT INTO detalle_compra (compra_id, producto_id, cantidad_producto, precio_unitario, total_detalle_compra) VALUES
    (1, 1, 45, 16.50, 742.50),
    (2, 2, 120, 0.80, 96.00),
    (3, 3, 30, 13.90, 417.00),
    (4, 4, 42, 9.80, 411.60),
    (5, 5, 50, 9.90, 495.00);

INSERT INTO venta (id_venta, fecha_venta, cliente_nit_ci, estado_venta, factura_nro, total_venta) VALUES
    (1, '2023-05-20', 6963367, 'INMEDIATA', 10000001, 55.00),
    (2, '2023-05-21', 6975165, 'INMEDIATA', 10000002, 90.00),
    (3, '2023-05-22', 4516466, 'PENDIENTE', 10000003, 35.00),
    (4, '2023-05-23', 4514645, 'PENDIENTE', 10000004, 18.00),
    (5, '2023-05-24', 6963367, 'PAGADA', 10000005, 28.00);

INSERT INTO detalle_venta (venta_id, producto_id, cantidad_producto, precio_unitario, total_detalle_compra) VALUES
    (1, 1, 2, 2.50, 5.00),
    (2, 2, 1, 5.00, 5.00),
    (3, 3, 4, 1.80, 7.20),
    (4, 4, 1, 2.00, 2.00),
    (5, 5, 3, 1.50, 4.50);

INSERT INTO movimiento_producto (producto_id, almacen_origen_id, almacen_destino_id, fecha_movimiento) VALUES
    (1, 1, 2, '2023-05-20'),
    (2, 2, 1, '2023-05-21'),
    (3, 1, 3, '2023-05-22'),
    (4, 3, 2, '2023-05-23'),
    (5, 2, 3, '2023-05-24');