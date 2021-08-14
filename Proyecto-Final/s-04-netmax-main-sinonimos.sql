-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   11/08/2021
-- @Descripción:      Creación de sinónimos - main

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

PROMPT =====================================
PROMPT Creando sinonimos para sclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@sinonimos/s-04-netmax-scl-s1-sinonimos.sql
@sinonimos/s-04-netmax-valida-sinonimos.sql

PROMPT =====================================
PROMPT creando sinonimos para sclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@sinonimos/s-04-netmax-scl-s2-sinonimos.sql
@sinonimos/s-04-netmax-valida-sinonimos.sql

PROMPT =====================================
PROMPT creando sinonimos para iclbd_s1
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@sinonimos/s-04-netmax-icl-s1-sinonimos.sql
@sinonimos/s-04-netmax-valida-sinonimos.sql

PROMPT =====================================
PROMPT creando sinonimos para iclbd_s2
PROMPT =====================================
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@sinonimos/s-04-netmax-icl-s2-sinonimos.sql
@sinonimos/s-04-netmax-valida-sinonimos.sql

PROMPT ¡¡Listo!!
EXIT
