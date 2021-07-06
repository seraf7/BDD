-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Consulta de fragmentos creados en scl-pc

PROMPT Conectando a S1 - sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1
PROMPT Mostrando lista de fragmentos...

SELECT table_name
FROM user_tables
ORDER BY table_name;

PROMPT Conectando a S2 - sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2
PROMPT Mostrando lista de fragmentos...

SELECT table_name
FROM user_tables
ORDER BY table_name;

PROMPT ¡¡Listo!!
EXIT
