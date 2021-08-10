-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Recolección y consulta de las estadísticas

-- Conexión como usuario sys
CONNECT sys/system@sclbdd_s1 AS sysdba

-- Procedimiento para recolectar estadisticas
BEGIN
  dbms_stats.gather_schema_stats(
    ownname   =>  'SCL_PARTICIONES_BDD',
    degree    =>  3
  );
END;
/

-- Consulta de las estadísticas del esquema
SELECT table_name, partition_name,
  COUNT(subpartition_name) AS total_subparticiones,
  SUM(num_rows) AS total_registros
FROM dba_tab_statistics
WHERE owner = 'SCL_PARTICIONES_BDD'
GROUP BY table_name, partition_name
ORDER BY table_name;
