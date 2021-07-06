-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Consulta de restricciones de referencia en scl-pc

PROMPT Conectando a S1 - sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1
-- Se invoca la consulta
@s-05-scl-consulta-restricciones.sql

PROMPT Conectando a S2 - sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2
-- Se invoca la consulta
@s-05-scl-consulta-restricciones.sql

PROMPT ¡¡Listo!!
EXIT
