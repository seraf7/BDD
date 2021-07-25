-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        21/07/2021
-- @Descripción:  Script encargado de realizar consultas con sinónimos
--                en ambas PDBs

--Conexión y consulta en el PDB sclbdd_s1
PROMPT Conectando a sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1
PROMPT Realizando conteo de registros
SET SERVEROUTPUT ON
START s-03-scl-consultas-localizacion.sql

--Conexión y consulta en el PDB sclbdd_s2
PROMPT conectando a sclbdd_s2
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2
PROMPT Realizando conteo de registros
SET SERVEROUTPUT ON
START s-03-scl-consultas-localizacion.sql

PROMPT ¡¡Listo!!
EXIT
