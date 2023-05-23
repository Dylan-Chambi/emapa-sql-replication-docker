# Database for EMAPA's sales and purchasing control system with MySQL, replication and docker compose.

## About The Project

This project aims to create the database for a sales and purchasing control system for the administrative management of marketing of the company EMAPA. Where the products, purchase and sale details, invoicing data, information for each product and also the movement of products between warehouses.

The database schema present in this project is designed based on the document "#2 Documento Base de Contratacion" of the contract object "Adquisicion De Un Sistema Informatico Para El Control De Productos Y Ventas Para La Gerencia De Comercializacion" with CUSE file "22-0047-34-1210323-1-1", which can be found at [SICOES Official Website](https://www.sicoes.gob.bo/portal/contrataciones/busqueda/convocatorias.php?tipo=convNacional).


## Requirements

- A machine with 64-bit installation (Windows, Linux, MacOS)
- Internet Acces to pull the images.
- Docker engine and docker compose installe (Linux, Windows with WSL2)
- Docker Desktop installed (MacOS, Windows, Windows with WSL2)

## Pre-steps after set up the enviroment

Go to [docker engine official install page](https://docs.docker.com/engine/install/) or follow the steps below

### Windows

1. Make sure you have WSL 2 or Hyper-V enabled and installed

2. Just download and install the .exe at this [link.](https://docs.docker.com/desktop/install/windows-install/)

### Linux

1. Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```

2. Add Docker’s official GPG key:

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

3. Use the following command to set up the repository:
```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

4. Update the apt package index:

```bash
sudo apt-get update
```

5. Install Docker Engine, containerd, and Docker Compose.

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


### MacOS

1. Download and install the .exe at this [link.](https://docs.docker.com/desktop/install/mac-install/)

2. Go to downloads folder

```bash
cd ~/Downloads/
```

2. Install from the command line

```bash
sudo hdiutil attach Docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Docker
```

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

* Docker Network:
    * Subnet: 192.168.20.0/24
    * Gateway: 192.168.20.1

* db-master container:
    * IP address: 192.168.20.21
    * Hostname: db-master
    * Internal Port: 3306
    * External Port: 3306
    * User: root
    * Password: root123

* db-slave-1 container:
    * IP address: 192.168.20.22
    * Hostname: db-slave-1
    * Internal Port: 3306
    * External Port: 3307
    * User: root
    * Password: root123

* db-slave-2 container:
    * IP address: 192.168.20.23
    * Hostname: db-slave-2
    * Internal Port: 3306
    * External Port: 3308
    * User: root
    * Password: root123


6. You can use these network configuration to connect to the MySQL containers or by using **localhost** or **docker container hostnames** from your application or preferred MySQL client.

Tested clients:
    
* MySQL WorkBench
* JetBrains DataGrip
* DBeaver


## Database Schema

## UML Diagram

![UML Diagram](./doc/database_scheme_uml.svg)

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
