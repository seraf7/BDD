-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Creación de vistas para todos los sitios

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT ===========================================
PROMPT Creando vistas para sclbd_s1...
PROMPT ===========================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@vistas/s-05-netmax-vistas.sql
@vistas/s-05-netmax-tablas-temporales.sql
@vistas/s-05-netmax-funciones-blob.sql
@vistas/s-05-netmax-scl-s1-vistas-blob.sql

PROMPT ===========================================
PROMPT Creando vistas para sclbd_s2...
PROMPT ===========================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@vistas/s-05-netmax-vistas.sql
@vistas/s-05-netmax-tablas-temporales.sql
@vistas/s-05-netmax-funciones-blob.sql
@vistas/s-05-netmax-scl-s2-vistas-blob.sql

PROMPT ===========================================
PROMPT Creando vistas para iclbd_s1...
PROMPT ===========================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@vistas/s-05-netmax-vistas.sql
@vistas/s-05-netmax-tablas-temporales.sql
@vistas/s-05-netmax-funciones-blob.sql
@vistas/s-05-netmax-icl-s1-vistas-blob.sql

PROMPT ===========================================
PROMPT Creando vistas para iclbd_s2...
PROMPT ===========================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@vistas/s-05-netmax-vistas.sql
@vistas/s-05-netmax-tablas-temporales.sql
@vistas/s-05-netmax-funciones-blob.sql
@vistas/s-05-netmax-icl-s2-vistas-blob.sql

PROMPT ¡¡Listo!!
EXIT
