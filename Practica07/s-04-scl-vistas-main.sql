-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        21/07/2021
-- @Descripción:  Script de ejecución para crear las vistas en ambos PDBs

Prompt Conectandose a sclbdd_s1
connect consultora_bdd/consultora_bdd@sclbdd_s1
Prompt creando vistas en sclbdd_s1
@s-04-scl-def-vistas.sql

Prompt Conectandose a sclbdd_s2
connect consultora_bdd/consultora_bdd@sclbdd_s2
Prompt creando vistas en sclbdd_s2
@s-04-scl-def-vistas.sql

PROMPT ¡¡Listo!!
EXIT
