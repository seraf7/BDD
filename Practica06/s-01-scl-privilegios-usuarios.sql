-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/07/2021
-- @Descripción:  Script para la asignación de privilegios a los usuarios en
--                cada PDB

--Conexión con el PDB sclbdd_s1
PROMPT Asignando privilegios a consultora_bdd...
CONNECT sys/system@sclbdd_s1 AS sysdba

--Asignación de privilegios
GRANT CREATE DATABASE LINK, CREATE PROCEDURE
TO consultora_bdd;

--Conexión con el PDB sclbdd_s2
PROMPT Asignando privilegios a consultora_bdd...
CONNECT sys/system@sclbdd_s2 AS sysdba

GRANT CREATE DATABASE LINK, CREATE PROCEDURE
TO consultora_bdd;

PROMPT ¡¡Listo!!
EXIT
