# Instructions for Setting the Database Proyect with Docker Compose

This repository contains a Docker Compose file that allows you to set up an environment with multiple MySQL containers.

## Requirements

- Linux OS, or Virtualized Linux on Windows.
- Internet Acces to pull the images.
- Docker and docker compose installed on your machine.

## Steps to Set Up the Environment

1. Clone this repository to your local machine:

```bash
git clone https://github.com/Dylan-Chambi/ProyectoBDAvanzadas.git
```

2. Navigate to the cloned directory:

```bash
cd ProyectoBDAvanzadas
```

3. Run the following command to start the containers:

```bash
docker compose up -d
```

4. Wait for the containers to start successfully. You can check the status of the containers with the following command:

```bash
docker compose ps
```

5. Once the containers are in an "Up" state, you can access them using the following addresses:

* db-master container:
    * IP address: 192.168.120.21
    * Port: 3306
    * User: root
    * Password: root123

* db-slave-1 container:
    * IP address: 192.168.120.22
    * Port: 3306
    * User: root
    * Password: root123

* db-slave-2 container:
    * IP address: 192.168.120.23
    * Port: 3306
    * User: root
    * Password: root123

6. You can use these addresses and credentials to connect to the MySQL containers from your application or preferred MySQL client.

Tested clients:
    
* MySQL WorkBench
* JetBrains DataGrip
* DBeaver


## Database Schema

## UML Diagram

![UML Diagram](https://raw.githubusercontent.com/Dylan-Chambi/ProyectoBDAvanzadas/main/doc/database_scheme_uml.svg?token=GHSAT0AAAAAACC7NJDGCEXRSLBQN2JNIUUCZDMIQCA)

This diagram can be downloaded at this [link.](https://drive.google.com/file/d/1eTbLLRmW8CyRixEevjMI6SeHs-z6a7nt/view?usp=sharing)

### Table: categoria

|      | Name             | Type         |
|------|------------------|--------------|
| PK   | id_categoria     | INT          |
|      | nombre_categoria | VARCHAR(30)  |

### Table: empresa

|      | Name            | Type         |
|------|-----------------|--------------|
| PK   | id_empresa      | INT          |
|      | nombre_empresa  | VARCHAR(100) |

### Table: almacen

|      | Name            | Type         |
|------|-----------------|--------------|
| PK   | id_almacen      | INT          |
|      | nombre_almacen  | VARCHAR(100) |
|      | lugar_almacen   | VARCHAR(255) |

### Table: cliente

|      | Name              | Type            |
|------|-------------------|-----------------|
| PK   | nit_ci            | BIGINT          |
|      | nombres_cliente   | VARCHAR(50)     |
|      | apellido_paterno  | VARCHAR(50)     |
|      | apellido_materno  | VARCHAR(50)     |
|      | correo_cliente     | VARCHAR(30)     |
|      | telefono_cliente  | VARCHAR(20)     |
|      | extension_ci      | VARCHAR(5)      |

### Table: marca

|      | Name             | Type         |
|------|------------------|--------------|
| PK   | id_marca         | INT          |
|      | nombre_marca     | VARCHAR(100) |
| FK   | empresa_id       | INT          |

### Table: proveedor

|      | Name               | Type         |
|------|--------------------|--------------|
| PK   | id_proveedor       | INT          |
|      | nombre_proveedor   | VARCHAR(100) |
| FK   | empresa_id         | INT          |
|      | telefono_proveedor | VARCHAR(20)  |
|      | encargado_proveedor| VARCHAR(50)  |

### Table: factura

|      | Name                  | Type            |
|------|-----------------------|-----------------|
| PK   | nro_factura           | BIGINT          |
|      | nro_autorizacion      | INT             |
|      | nit_empresa           | BIGINT          |
|      | fecha_emision         | DATE            |
|      | nombre_o_razon_social | VARCHAR(255)    |
| FK   | cliente_nit_ci        | BIGINT          |
|      | detalle               | VARCHAR(255)    |
|      | subtotal              | DECIMAL(10, 2)  |
|      | importe_total         | DECIMAL(10, 2)  |
|      | codigo_control        | VARCHAR(255)    |
|      | codigo_qr             | BLOB            |
|      | fecha_limite_emision  | DATE            |
|      | estado                | ENUM            |

### Table: producto

|      | Name              | Type         |
|------|-------------------|--------------|
| PK   | id_producto       | INT          |
|      | nombre_producto   | VARCHAR(100) |
| FK   | proveedor_id      | INT          |
|      | codigo_barras     | BIGINT       |
|      | precio_nacional   | DECIMAL(10, 2) |
| FK   | marca_id          | INT          |
| FK   | categoria_id      | INT          |
|      | fecha_vencimiento | DATE         |
|      | estado_producto   | ENUM         |

### Table: compra

|      | Name            | Type         |
|------|-----------------|--------------|
| PK   | id_compra       | INT          |
|      | fecha_compra    | DATE         |
| FK   | proveedor_id    | INT          |
|      | total_compra    | DECIMAL(10, 2) |

### Table: detalle_compra

|      | Name                  | Type         |
|------|-----------------------|--------------|
| PK   | id_detalle_compra     | INT          |
| FK   | compra_id             | INT          |
| FK   | producto_id           | INT          |
|      | cantidad_producto     | MEDIUMINT    |
|      | precio_unitario       | DECIMAL(10, 2) |
|      | total_detalle_compra  | DECIMAL(10, 2) |

### Table: venta

|      | Name               | Type            |
|------|--------------------|-----------------|
| PK   | id_venta           | INT             |
|      | fecha_venta        | DATE            |
| FK   | cliente_nit_ci     | BIGINT          |
|      | estado_venta       | ENUM            |
| FK   | factura_nro        | BIGINT          |
|      | total_venta        | DECIMAL(10, 2)  |

### Table: detalle_venta

|      | Name                  | Type         |
|------|-----------------------|--------------|
| PK   | id_detalle_venta      | INT          |
| FK   | venta_id              | INT          |
| FK   | producto_id           | INT          |
|      | cantidad_producto     | MEDIUMINT    |
|      | precio_unitario       | DECIMAL(10, 2) |
|      | total_detalle_compra  | DECIMAL(10, 2) |

### Table: movimiento_producto

|      | Name                | Type         |
|------|---------------------|--------------|
| PK   | id_movimiento       | INT          |
| FK   | producto_id         | INT          |
| FK   | almacen_origen_id   | INT          |
| FK   | almacen_destino_id  | INT          |
|      | fecha_movimiento    | DATE         |


## About The Project

The database schema present in this project is designed based on the document "#2 Documento Base de Contratacion" of the contract object "Adquisicion De Un Sistema Informatico Para El Control De Productos Y Ventas Para La Gerencia De Comercializacion" with CUSE file "22-0047-34-1210323-1-1", which can be found at [SICOES Official Website](https://www.sicoes.gob.bo/portal/contrataciones/busqueda/convocatorias.php?tipo=convNacional).