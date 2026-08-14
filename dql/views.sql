USE distribuidora_de_gaseosas_del_valle;

-- ============================================================
-- 1. VISTA: RESUMEN DE PEDIDOS POR SEDE
-- ============================================================

DROP VIEW IF EXISTS vista_resumen_pedidos_por_sede;

CREATE VIEW vista_resumen_pedidos_por_sede AS
SELECT
    s.id_sede,
    s.nombre_sede,
    COUNT(p.id_pedido) AS cantidad_total_pedidos,
    COALESCE(SUM(p.total_sin_iva), 0) AS ventas_totales_sin_iva,
    COALESCE(SUM(p.total_con_iva), 0) AS ventas_totales_con_iva
FROM sedes s
LEFT JOIN pedidos p
    ON s.id_sede = p.id_sede
GROUP BY
    s.id_sede,
    s.nombre_sede;


-- ============================================================
-- 2. VISTA: PRODUCTOS BAJO STOCK
-- ============================================================
DROP VIEW IF EXISTS vista_productos_bajo_stock;

CREATE VIEW vista_productos_bajo_stock AS
SELECT
    id_producto,
    nombre,
    id_categoria,
    precio,
    volumen_ml,
    stock_actual,
    stock_minimo
FROM productos
WHERE stock_actual <= stock_minimo;


-- ============================================================
-- 3. VISTA: CLIENTES ACTIVOS
-- ============================================================

DROP VIEW IF EXISTS vista_clientes_activos;

CREATE VIEW vista_clientes_activos AS
SELECT DISTINCT
    c.id_cliente,
    c.nombre_completo,
    c.identificacion,
    c.direccion,
    c.telefono,
    c.correo_electronico
FROM clientes c
INNER JOIN pedidos p
    ON c.id_cliente = p.id_cliente;


-- ============================================================
-- PRUEBAS DE LAS VISTAS
-- ============================================================

-- Vista 1
SELECT *
FROM vista_resumen_pedidos_por_sede;

-- Vista 2
SELECT *
FROM vista_productos_bajo_stock;

-- Vista 3
SELECT *
FROM vista_clientes_activos;