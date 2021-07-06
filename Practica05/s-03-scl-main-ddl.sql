-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Script encargado de conectarse a los PDB e invocar los
--                script de creación de objetos

--Conexión al PDB 01
PROMPT Conectando al PDB sclbdd_s1 como consultora_bdd..
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

--Creación de objetos
PROMPT Creandos objetos del sitio 01...
@s-02-scl-n1-ddl.sql

--Conexión al PDB 02
PROMPT Conectando al PDB sclbdd_s2 como consultora_bdd..
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

--Creación de objetos
PROMPT Creandos objetos del sitio 02...
@s-02-scl-n2-ddl.sql

PROMPT ¡¡Listo!!
