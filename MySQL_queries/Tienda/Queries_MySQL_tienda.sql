USE tienda;

-- 1. Lista el nombre de todos los productos que hay en la mesa producto.
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto
SELECT * FROM producto;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD)
SELECT nombre, precio AS precio_euros, precio * 1.09 AS precio_dolares FROM producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD) con sobrenombres específicos.
SELECT nombre AS "nombre de prducto", precio AS euro, precio * 1.09 AS dolares FROM producto;

-- 6. Lista los nombres y precios de todos los productos, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre) AS nombre, precio FROM producto;

-- 7. Lista los nombres y precios de todos los productos, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre) AS nombre, (precio) AS precio FROM producto;
 
-- 8. Lista el nombre de todos los fabricantes y las iniciales en mayúsculas (dos primeros caracteres).
SELECT nombre, UPPER(LEFT(nombre, 2)) AS iniciales FROM fabricante;

-- 9. Lista los nombres y precios de todos los productos, redondeando el precio.
SELECT nombre, ROUND(precio, 0) AS "precio redondeado" FROM producto;

-- 10. Lista los nombres y precios de todos los productos, truncando el precio sin decimales.
SELECT nombre, TRUNCATE(precio, 0) AS "precio truncado" FROM producto;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT codigo_fabricante FROM producto;

-- 12. Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. Lista los nombres de los fabricantes en orden ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14. Lista los nombres de los fabricantes en orden descendente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Lista los nombres de los productos ordenados por nombre (ascendente) y precio (descendente).
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

-- 17. Devuelve 2 filas a partir de la cuarta fila de la tabla fabricante.
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Lista el nombre y precio del producto más barato. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Lista el nombre y precio del producto más caro. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA : Aquí no podría usar MAX(precio), necesitaría GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. Lista todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT producto.nombre AS producto, producto.precio AS precio,fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordena el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre AS producto, producto.precio AS precio, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;

-- 23. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT producto.codigo AS codigo_producto, producto.nombre AS nombre_producto, producto.codigo_fabricante AS codigo_fabricante, fabricante.nombre AS nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 24. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT producto.nombre AS producto, producto.precio AS precio, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio ASC LIMIT 1;

-- 25. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT producto.nombre AS producto, producto.precio AS precio, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY producto.precio DESC LIMIT 1;

-- 26. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';

-- 27. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

-- 28. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 30. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
SELECT producto.nombre AS producto, producto.precio AS precio FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';

-- 31. Devuelve un listado con el nombre y precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT producto.nombre AS producto, producto.precio AS precio FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';

-- 32. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordena el resultado, en primer lugar, por el precio (en orden descendente) y, en segundo lugar, por el nombre (en orden ascendente).
SELECT producto.nombre AS producto, producto.precio AS precio, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;

-- 33. Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT fabricante.codigo AS codigo_fabricante, fabricante.nombre AS nombre_fabricante FROM fabricante WHERE fabricante.codigo IN (SELECT DISTINCT producto.codigo_fabricante FROM producto);

-- 34. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
SELECT fabricante.nombre AS fabricante, producto.nombre AS producto FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

-- 35. Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT fabricante.nombre AS fabricante FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo_fabricante IS NULL;

-- 36. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT producto.nombre AS producto FROM producto, fabricante WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Lenovo';

-- 37. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo.
SELECT producto.* FROM producto WHERE producto.precio = (SELECT MAX(p.precio) FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 38. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo' ORDER BY producto.precio DESC LIMIT 1;

-- 39. Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Hewlett-Packard' ORDER BY producto.precio ASC LIMIT 1;

-- 40. Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT producto.nombre AS producto FROM producto WHERE producto.precio >= (SELECT MAX(p.precio) FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo');

-- 41. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT producto.nombre AS producto FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' AND producto.precio > (SELECT AVG(p.precio) FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Asus');

