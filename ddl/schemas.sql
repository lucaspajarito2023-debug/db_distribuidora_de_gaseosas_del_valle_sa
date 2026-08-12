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
    nombre_sede VARCHAR(90) NOT NULL,
    capacidad VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL
)Engine=InnoDB;
