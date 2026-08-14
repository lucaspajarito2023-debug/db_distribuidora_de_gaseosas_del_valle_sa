USE distribuidora_de_gaseosas_del_valle;


-- =======================
-- 1. Consultar los productos con stock por debajo del mínimo.
-- =======================
SELECT id_producto AS ID, nombre AS Producto, stock_actual AS Stock_Actual, stock_minimo AS Stock_Minimo FROM productos WHERE stock_actual < stock_minimo ORDER BY stock_actual ASC;



-- =======================
-- 2. Consultar los pedidos realizados entre dos fechas (BETWEEN).
-- =======================
SELECT id_pedido AS ID, fecha_pedido, total_sin_iva, total_con_iva FROM pedidos WHERE fecha_pedido BETWEEN '2026-08-01' AND '2026-08-31' ORDER BY fecha_pedido ASC;


-- =======================
-- 3. Listar los productos más vendidos (con JOIN y GROUP BY).
-- =======================
SELECT P.id_producto, P.nombre AS Producto, SUM(DP.cantidad) AS Cantidad_Vendida FROM productos P INNER JOIN detalle_pedidos DP ON P.id_producto = DP.id_producto GROUP BY P.id_producto, P.nombre ORDER BY Cantidad_Vendida DESC LIMIT 10;



-- =======================
-- 4. Mostrar clientes y la cantidad de pedidos realizados.
-- =======================
SELECT C.id_cliente, C.nombre_completo AS Cliente, COUNT(P.id_pedido) AS Cantidad_Pedidos FROM clientes C LEFT JOIN pedidos P ON C.id_cliente = P.id_cliente GROUP BY C.id_cliente, C.nombre_completo ORDER BY Cantidad_Pedidos DESC, Cliente ASC;



-- =======================
-- 5. Buscar clientes por nombre parcial usando LIKE.
-- =======================
SELECT id_cliente, nombre_completo, telefono, correo_electronico FROM clientes WHERE nombre_completo LIKE '%juan%' ORDER BY nombre_completo ASC;



-- =======================
-- 6. Consultar productos de ciertas categorías usando IN.
-- =======================
SELECT P.id_producto, P.nombre AS Producto, C.nombre_categoria AS Categoria FROM productos P INNER JOIN categorias C ON P.id_categoria = C.id_categoria WHERE C.id_categoria IN (1, 3, 5) ORDER BY P.id_producto ASC;


-- =======================
-- 7. Mostrar el cliente con mayor número de pedidos (subconsulta).
-- =======================
SELECT C.id_cliente, C.nombre_completo, COUNT(P.id_pedido) AS Total_Pedidos FROM clientes C INNER JOIN pedidos P ON C.id_cliente = P.id_cliente GROUP BY C.id_cliente, C.nombre_completo HAVING COUNT(P.id_pedido) = ( SELECT MAX(total_pedidos) FROM ( SELECT COUNT(id_pedido) AS total_pedidos FROM pedidos GROUP BY id_cliente ) AS T );



-- =======================
-- 8. Consultar pedidos y sus totales agrupados por sede.
-- =======================
SELECT S.id_sede, S.nombre_sede, COUNT(P.id_pedido) AS Cantidad_Pedidos, SUM(P.total_sin_iva) AS Total_Sin_IVA, SUM(P.total_con_iva) AS Total_Con_IVA FROM sedes S LEFT JOIN pedidos P ON S.id_sede = P.id_sede GROUP BY S.id_sede, S.nombre_sede ORDER BY Total_Con_IVA DESC;