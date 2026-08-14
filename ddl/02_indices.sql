

-- Indices
-- =========================================

CREATE INDEX idx_productos_categoria
    ON productos(id_categoria);

CREATE INDEX idx_pedidos_cliente
    ON pedidos(id_cliente);

CREATE INDEX idx_pedidos_sede
    ON pedidos(id_sede);

CREATE INDEX idx_detalle_producto
    ON detalle_pedidos(id_producto);

CREATE INDEX idx_clientes_nombre
    ON clientes(nombre_completo);