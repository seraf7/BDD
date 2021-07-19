-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/07/2021
-- @Descripción:  Script para la creación de ligas y permitir la comunicación
--                entre los PDB

--Conexión al PDB sclbdd_s1
PROMPT Creando liga en sclbdd_s1 hacia sclbdd_s2
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

--Creación de liga
CREATE DATABASE LINK sclbdd_s2.fi.unam USING 'SCLBDD_S2';

--Conexión al PDB sclbdd_s2
PROMPT Creando liga en sclbdd_s2 hacia sclbdd_s1
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

--Creación de liga
CREATE DATABASE LINK sclbdd_s1.fi.unam USING 'SCLBDD_S1';

PROMPT ¡¡Listo!!
EXIT
