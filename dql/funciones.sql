

-- ========================
--fn_calcular_total_con_iva(id_pedido)
--==========================
DELIMITER $$
CREATE FUNCTION fn_calcular_total_con_iva( p_id_pedido INT)
    RETURNS DECIMAL(10,2) DETERMINISTIC READS SQL DATA
    BEGIN
DECLARE v_total DECIMAL(10,2);
    SELECT COALESCE(SUM(subtotal),0)
    INTO v_total
    FROM detalle_pedidos
    WHERE id_pedido = p_id_pedido;
    RETURN ROUND(v_total * 1.19, 2);
END $$
DELIMITER ;

-- ====== Prueba =======
SELECT fn_calcular_total_con_iva(1) Total_con_iva;



-- ======================
-- fn_validar_stock(id_producto, cantidad)
-- ======================
DELIMITER $$
CREATE FUNCTION fn_validar_stock(p_id_producto INT,p_cantidad INT)
    RETURNS VARCHAR(100)DETERMINISTIC READS SQL DATA
    BEGIN
    DECLARE v_stock_actual INT;
        SELECT stock_actual
        INTO v_stock_actual
        FROM productos
        WHERE id_producto = p_id_producto;

    IF v_stock_actual IS NULL THEN
        RETURN 'Producto no existe';
    END IF;

    IF v_stock_actual >= p_cantidad THEN
        RETURN 'Stock disponible';
    ELSE
        RETURN 'Stock insuficiente';
    END IF;

END $$
DELIMITER ;


-- ===== PRUEBA ======
SELECT fn_validar_stock(1,10) Validacion;

SELECT fn_validar_stock(1,500) Validacion;

SELECT fn_validar_stock(999,5) Validacion;