--  ================================
-- ============EXAMEN==============
-- =================================================================
DROP view vista_resumen_sedes;

select * FROM vista_resumen_sedes;

CREATE view vista_resumen_sedes AS
	SELECT S.nombre_sede AS SEDE, count(P.id_sede) AS Total_por_sede, 
		   sum(P.total_sin_iva) Total_sin_iva, avg(DP.subtotal) AS Pr_valor_pedido
		FROM sedes S INNER JOIN pedidos P
        ON S.id_sede = P.id_sede INNER JOIN detalle_pedidos DP
        ON P.id_pedido = DP.id_pedido
        group by nombre_sede;