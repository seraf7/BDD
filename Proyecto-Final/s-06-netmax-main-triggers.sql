-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Script principal - creación de triggers

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT =====================================
PROMPT Creando triggers para sclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@triggers/s-06-netmax-trigger-usuario.sql
@triggers/s-06-netmax-trigger-programa.sql
@triggers/s-06-netmax-trigger-scl-s1-serie.sql
@triggers/s-06-netmax-trigger-scl-s1-pelicula.sql
-- @triggers/s-06-netmax-trigger-scl-s1-documental.sql
-- @triggers/s-06-netmax-trigger-scl-s1-iclhivo-programa.sql
@triggers/s-06-netmax-trigger-scl-s1-playlist.sql
@triggers/s-06-netmax-tipo-cuenta-trigger.sql
@triggers/s-06-netmax-tipo-serie-trigger.sql
@triggers/s-06-netmax-pais-trigger.sql

PROMPT =====================================
PROMPT Creando triggers para sclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@triggers/s-06-netmax-trigger-usuario.sql
@triggers/s-06-netmax-trigger-programa.sql
@triggers/s-06-netmax-trigger-scl-s1-serie.sql
@triggers/s-06-netmax-trigger-scl-s1-pelicula.sql
-- @triggers/s-06-netmax-trigger-scl-s2-documental.sql
-- @triggers/s-06-netmax-trigger-scl-s2-iclhivo-programa.sql
@triggers/s-06-netmax-trigger-scl-s1-playlist.sql
@triggers/s-06-netmax-tipo-cuenta-trigger.sql
@triggers/s-06-netmax-tipo-serie-trigger.sql
@triggers/s-06-netmax-pais-trigger.sql

PROMPT =====================================
PROMPT Creando triggers para iclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@triggers/s-06-netmax-trigger-usuario.sql
@triggers/s-06-netmax-trigger-programa.sql
@triggers/s-06-netmax-trigger-icl-s1-serie.sql
@triggers/s-06-netmax-trigger-icl-s1-pelicula.sql
-- @triggers/s-06-netmax-trigger-icl-s1-documental.sql
-- @triggers/s-06-netmax-trigger-icl-s1-iclhivo-programa.sql
@triggers/s-06-netmax-trigger-icl-s1-playlist.sql
@triggers/s-06-netmax-tipo-cuenta-trigger.sql
@triggers/s-06-netmax-tipo-serie-trigger.sql
@triggers/s-06-netmax-pais-trigger.sql

PROMPT =====================================
PROMPT Creando triggers para iclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@triggers/s-06-netmax-trigger-usuario.sql
@triggers/s-06-netmax-trigger-programa.sql
@triggers/s-06-netmax-trigger-icl-s2-serie.sql
@triggers/s-06-netmax-trigger-icl-s2-pelicula.sql
-- @triggers/s-06-netmax-trigger-icl-s2-documental.sql
-- @triggers/s-06-netmax-trigger-icl-s2-iclhivo-programa.sql
@triggers/s-06-netmax-trigger-icl-s2-playlist.sql
@triggers/s-06-netmax-tipo-cuenta-trigger.sql
@triggers/s-06-netmax-tipo-serie-trigger.sql
@triggers/s-06-netmax-pais-trigger.sql

PROMPT ¡¡Listo!!
EXIT
