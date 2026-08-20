DELIMITER $$

CREATE FUNCTION calcular_promedio_pedidos_cliente(cliente_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10, 2);

    SELECT AVG(total_sin_iva) INTO promedio
    FROM pedidos
    WHERE id_cliente = cliente_id;

  
    IF promedio IS NULL THEN
        RETURN 0;
    END IF;

    RETURN promedio;
END$$

DELIMITER ;