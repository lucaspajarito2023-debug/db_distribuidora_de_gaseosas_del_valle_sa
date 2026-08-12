
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

