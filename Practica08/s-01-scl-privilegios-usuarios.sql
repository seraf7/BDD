-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/07/2021
-- @Descripción:  Script ecargado de la asignación de privilegios

--Conexión al PDB sclbdd_s1
PROMPT Conectando como sys a sclbdd_s1...
CONNECT sys/system@sclbdd_s1 AS sysdba

--Asignación de privilegios: crear sinónimos, vistas, tipos de datos
--y procedimientos
PROMPT Asignando privilegios a consultoda_bdd...
GRANT CREATE TRIGGER TO consultora_bdd;

--Conexión al PDB sclbdd_s1
PROMPT Conectando como sys a sclbdd_s2...
CONNECT sys/system@sclbdd_s2 AS sysdba

--Asignación de privilegios: crear sinónimos, vistas, tipos de datos
--y procedimientos
PROMPT Asignando privilegios a consultoda_bdd...
GRANT CREATE TRIGGER TO consultora_bdd;

PROMPT ¡¡Listo!!
EXIT
