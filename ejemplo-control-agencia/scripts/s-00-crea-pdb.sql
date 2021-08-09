--@Autor:           Jorge Rodriguez
--@Fecha creación:  08/08/2021
--@Descripción:     Creación de dos nuevos PDB

-- sudo ls -lh /u01/app/oracle/oradata/SCLBDD/sclbdd_s2

-- Conexión como usuario sys al CDB (contenedor)
CONNECT sys/system AS sysdba

-- Creación de un nuevo PDB a partir de otro ya existente
CREATE PLUGGABLE DATABASE hclbdd_s1 FROM sclbdd_s2
file_name_convert =
  ('/u01/app/oracle/oradata/SCLBDD/sclbdd_s2',
  '/u01/app/oracle/oradata/SCLBDD/hclbdd_s1');

CREATE PLUGGABLE DATABASE hclbdd_s2 FROM sclbdd_s2
file_name_convert =
  ('/u01/app/oracle/oradata/SCLBDD/sclbdd_s2',
  '/u01/app/oracle/oradata/SCLBDD/hclbdd_s2');

-- Consultar estado de los PDB existentes
SELECT con_id, name, open_mode
FROM v$containers
ORDER BY con_id;

-- Se abren todos los PDB's
ALTER PLUGGABLE DATABASE ALL OPEN;

-- Se guarda el estado para que al iniciar la BD esten abiertos
ALTER PLUGGABLE DATABASE ALL SAVE STATE;
