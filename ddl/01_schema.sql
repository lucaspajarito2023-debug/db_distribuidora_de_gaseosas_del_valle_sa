
-- BASE DE DATOS
-- =====================================================
DROP DATABASE IF EXISTS distribuidora_de_gaseosas_del_valle;
CREATE DATABASE distribuidora_de_gaseosas_del_valle;
USE distribuidora_de_gaseosas_del_valle;


-- TABLA CLIENTES
-- =====================================================
CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(160) NOT NULL,
    identificacion VARCHAR(20) NOT NULL UNIQUE,
    direccion VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- TABLA CATEGORIAS
-- =====================================================
CREATE TABLE categorias(
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(60) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- TABLA PRODUCTOS
-- =====================================================
CREATE TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 0,
    volumen_ml DECIMAL(10,2) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_productos_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria),

    CONSTRAINT chk_stock_actual
        CHECK (stock_actual >= 0),

    CONSTRAINT chk_stock_minimo
        CHECK (stock_minimo >= 0),

    CONSTRAINT chk_precio
        CHECK (precio > 0)
) ENGINE=InnoDB;

-- TABLA ENCARGADOS
-- =====================================================
CREATE TABLE encargados(
    id_encargado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(90) NOT NULL
) ENGINE=InnoDB;


-- TABLA SEDES
-- =====================================================
CREATE TABLE sedes(
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    id_encargado INT NOT NULL,
    nombre_sede VARCHAR(90) NOT NULL,
    capacidad_almacenamiento INT NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,

    CONSTRAINT fk_sedes_encargado
        FOREIGN KEY (id_encargado)
        REFERENCES encargados(id_encargado),

    CONSTRAINT chk_capacidad
        CHECK (capacidad_almacenamiento > 0)
) ENGINE=InnoDB;


-- TABLA PEDIDOS
-- =====================================================
CREATE TABLE pedidos(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    total_sin_iva DECIMAL(12,2) NOT NULL DEFAULT 0,
    total_con_iva DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_pedidos_sede
        FOREIGN KEY (id_sede)
        REFERENCES sedes(id_sede)
) ENGINE=InnoDB;


-- TABLA DETALLE PEDIDOS
-- =====================================================
CREATE TABLE detalle_pedidos(
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,

    PRIMARY KEY (id_pedido, id_producto),

    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES pedidos(id_pedido),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),

    CONSTRAINT chk_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT chk_subtotal
        CHECK (subtotal >= 0)
) ENGINE=InnoDB;


-- TABLA AUDITORIA PRECIOS
-- =====================================================
CREATE TABLE auditoria_precios(
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_auditoria_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
) ENGINE=InnoDB;