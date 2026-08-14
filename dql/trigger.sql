
-- ============
-- tr_actualizar_stock
-- ============
DELIMITER $$ CREATE TRIGGER tr_actualizar_stock AFTER INSERT ON detalle_pedidos FOR EACH ROW BEGIN UPDATE productos SET stock_actual = stock_actual - NEW.cantidad WHERE id_producto = NEW.id_producto; END $$ DELIMITER ;

-- ===== Prueba ======
INSERT INTO detalle_pedidos(id_pedido,id_producto,cantidad,subtotal) VALUES (101,1,2,3600); 

SELECT id_producto, nombre, stock_actual FROM productos WHERE id_producto = 1;



-- ============
-- tr_auditar_cambio_precio
-- ============

DELIMITER $$ CREATE TRIGGER tr_auditar_cambio_precio AFTER UPDATE ON productos FOR EACH ROW BEGIN IF OLD.precio <> NEW.precio THEN INSERT INTO auditoria_precios( id_producto, precio_anterior, precio_nuevo, fecha_cambio ) VALUES( NEW.id_producto, OLD.precio, NEW.precio, NOW() ); END IF; END $$ DELIMITER ;


-- ====== Prueba 
UPDATE productos SET precio = 2700 WHERE id_producto = 1;

SELECT * FROM auditoria_precios WHERE id_producto = 1 ORDER BY fecha_cambio DESC;