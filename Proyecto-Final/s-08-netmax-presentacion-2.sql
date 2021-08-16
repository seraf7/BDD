-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   15/08/2021
-- @Descripción:      Archivo de carga inicial para tablas de copias manuales

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT ======================================
PROMPT Cargando catalogos replicados en sclbd_s1
PROMPT ======================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
DELETE FROM status_programa;
@carga-inicial/netmax-carga-inicial-status-programa.sql
COMMIT;

PROMPT ======================================
PROMPT Cargando catalogos replicados en sclbd_s2
PROMPT ======================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
DELETE FROM status_programa;
@carga-inicial/netmax-carga-inicial-status-programa.sql
COMMIT;

PROMPT ======================================
PROMPT Cargando catalogos replicados en iclbd_s1
PROMPT ======================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
DELETE FROM status_programa;
@carga-inicial/netmax-carga-inicial-status-programa.sql
COMMIT;

PROMPT ======================================
PROMPT Cargando catalogos replicados en iclbd_s2
PROMPT ======================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
DELETE FROM status_programa;
@carga-inicial/netmax-carga-inicial-status-programa.sql
COMMIT;

PROMPT ¡¡CARGA DE DATOS REPLICADOS EXITOSA!!
EXIT
