CREATE DATABASE distribuidora_de_gaseosas_del_valle;
USE distribuidora_de_gaseosas_del_valle;

/* Tabla clientes */
CREATE TABLE IF NOT EXISTS clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(160) NOT NULL,
    identificacion VARCHAR(15) NOT NULL,
    direccion VARCHAR(90) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE
)Engine=innoDB; 

/*  Tabla categorias y productos*/
CREATE TABLE categorias(
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(60) NOT NULL
)Engine=innoDB;


CREATE TABLE productos(
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    stock_actual INT DEFAULT 0 NOT NULL,
    stock_minimo INT DEFAULT 0 NOT NULL,
    volumen_ml DECIMAL(10,2) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    Foreign Key (id_categoria) REFERENCES categorias(id_categoria)
)Engine=innoDB;

/* Tabla encargados y sedes*/
CREATE TABLE encargados(
    id_incargado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(90) NOT NULL
)Engine=InnoDB;

CREATE TABLE sedes(
    id_sede INT PRIMARY KEY AUTO_INCREMENT,
    id_encargado INT,
    nombre_sede VARCHAR(90) NOT NULL,
    capacidad VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    Foreign Key (id_encargado) REFERENCES encargados(id_encargado)
)Engine=InnoDB;

/* Tablas pedido y detalles pedidos */
CREATE TABLE pedidos(
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total_sin_iva FLOAT NOT NULL,
    total_con_iva FLOAT NOT NULL,
    Foreign Key (id_cliente) REFERENCES clientes(id_cliente),
    Foreign Key (id_sede) REFERENCES sedes(id_sede)
)Engine=InnoDB;

CREATE TABLE detalle_pedidos(
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 0,
    subtotal DECIMAL(10,2) NOT NULL,
    Foreign Key (id_pedido) REFERENCES pedidos(id_pedido),
    Foreign Key (id_producto) REFERENCES productos(id_producto)
)Engine=InnoDB;
