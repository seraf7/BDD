-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Creación de fragmentos en los cuatro nodos

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT =====================================
PROMPT Creando fragmentos para sclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@s-03-netmax-sclbd-s1-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para sclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@s-03-netmax-sclbd-s2-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para iclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@s-03-netmax-iclbd-s1-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para iclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@s-03-netmax-iclbd-s2-ddl.sql

PROMPT ¡¡Listo!!
EXIT
