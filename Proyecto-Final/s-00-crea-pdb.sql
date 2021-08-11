-- @Autor:           Humberto Serafín Castillo López
-- @Fecha creación:  08/08/2021
-- @Descripción:     Creación de dos nuevos PDB

-- Previamente definir valor de la variable de entorno
-- export ORACLE_SID=sclbd

-- Conexión como usuario sys al CDB (contenedor)
PROMPT Conectando al contenedor como sys...
CONNECT sys/system AS sysdba

PROMPT Creando al PB iclbd_s1...
-- Creación de un nuevo PDB a partir de otro ya existente
CREATE PLUGGABLE DATABASE iclbd_s1 FROM sclbd_s1
file_name_convert =
  ('/u01/app/oracle/oradata/SCLBD/sclbd_s1',
  '/u01/app/oracle/oradata/SCLBD/iclbd_s1');

PROMPT Creando al PB iclbd_s2...
-- Creación de un nuevo PDB a partir de otro ya existente
CREATE PLUGGABLE DATABASE iclbd_s2 FROM sclbd_s2
file_name_convert =
  ('/u01/app/oracle/oradata/SCLBD/sclbd_s2',
  '/u01/app/oracle/oradata/SCLBD/iclbd_s2');

PROMPT Consultando estado de los PDB...
-- Formato de columna
COLUMN name FORMAT a20

-- Consultar estado de los PDB existentes
SELECT con_id, name, open_mode
FROM v$containers
ORDER BY con_id;

PROMPT Abriendo todos los PDB...
-- Se abren todos los PDB's
ALTER PLUGGABLE DATABASE ALL OPEN;

PROMPT Guardando estado...
-- Se guarda el estado para que al iniciar la BD esten abiertos
ALTER PLUGGABLE DATABASE ALL SAVE STATE;

PROMPT ¡¡Listo!!
EXIT
