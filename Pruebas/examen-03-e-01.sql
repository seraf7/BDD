Considerar los fragmentos BIBLIOTECA_2, LIBRO_2 ubicadas prod_s1; EJEMPLAR_2,
y EDITORIAL_2 ubicadas en prod_s2. Se desea generar una consulta que muestre
a todas las bibliotecas que tienen ejemplares cuyos títulos contengan la
palabra ‘anatomía’. En la consulta se debe mostrar el código de la biblioteca,
la clasificación del ejemplar y su editorial. El programador decide construir
una sentencia SQL empleando collocated inline views. Generar el código SQL
necesario para que el optimizador pueda hacer uso de esta técnica evitando
descomposiciones así minimizar el uso de la Red. Considere que no existen
sinónimos, solo existen ligas cuyos nombres coinciden con los nombres de los
sitios remotos. La consulta se lanza en prod_s2

SELECT /*+no_merge(q1)*/ q1.codigo, EJ.num_clasificacion, ED.nombre
FROM (
  SELECT  B.codigo, L.libro_id
  FROM biblioteca_2@prod_1 B
  JOIN libro_2@prod_1 L ON B.biblioteca_id = L.biblioteca_id
  WHERE titulo LIKE '%anatomia%'
) q1
JOIN ejemplar_2 EJ ON q1.libro_id = EJ.libro_id
JOIN editorial_2 ED ON EJ.editorial_id = ED.editorial_id;
