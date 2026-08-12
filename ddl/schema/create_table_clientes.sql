CREATE TABLE IF NOT EXISTS clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(160) NOT NULL,
    identificacion VARCHAR(15) NOT NULL, 
    direccion VARCHAR(90) NOT NULL,
    telefono VARCHAR(9) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE
)Engine=innoDB;