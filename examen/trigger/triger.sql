-- Crear la tabla de auditoría si no existe
CREATE TABLE IF NOT EXISTS auditoria_cambios_precio (
    id_auditoria SERIAL PRIMARY KEY,
    id_producto INT NOT NULL,
    precio_anterior DECIMAL(10, 2) NOT NULL,
    precio_nuevo DECIMAL(10, 2) NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$

CREATE TRIGGER auditar_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_cambios_precio (id_producto, precio_anterior, precio_nuevo)
        VALUES (NEW.id_producto, OLD.precio, NEW.precio);
    END IF;
END$$

DELIMITER ;