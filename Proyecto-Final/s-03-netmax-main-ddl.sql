-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Creación de fragmentos en los cuatro nodos

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT =====================================
PROMPT Creando fragmentos para sclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@ddl/s-03-netmax-scl-s1-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para sclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@ddl/s-03-netmax-scl-s2-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para iclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@ddl/s-03-netmax-icl-s1-ddl.sql

PROMPT =====================================
PROMPT Creando fragmentos para iclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@ddl/s-03-netmax-icl-s2-ddl.sql

PROMPT ¡¡Listo!!
EXIT
