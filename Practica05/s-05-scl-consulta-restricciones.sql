-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Consulta de restricciones de referencia de las tablas
--                de el usuario actual

PROMPT Mostrando lista de restricciones de referencia...

-- Se da formato a la consulta
COL tabla_padre FORMAT a30
COL tabla_hija FORMAT a30
COL nombre_restriccion FORMAT a30
set linesize 200

SELECT H.constraint_name AS nombre_restriccion, H.table_name AS tabla_hija,
  P.table_name AS tabla_padre, H.constraint_type AS tipo_restriccion
FROM user_constraints H
JOIN user_constraints P ON H.r_constraint_name = P.constraint_name
WHERE H.constraint_type = 'R'
ORDER BY P.table_name;
