SELECT p.nombre_producto, c.nombre_categoria, p.stock
FROM  productos p
JOIN  categorias c ON p.id_categoria = c.id_categoria
WHERE p.precio > (SELECT AVG(precio) FROM productos);