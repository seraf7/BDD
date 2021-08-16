-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   15/08/2021
-- @Descripción:      Script principal empleado para configurar el soporte
--                    de datos BLOB en los 4 nodos.

PROMPT configurando directorios y otorgando registros.
--sclbd_s1
PROMPT configurando soporte BLOB para sclbd_s1
CONNECT netmax_bdd/netmax_bdd@sclbd_s1
@s-07-netmax-configuracion-soporte-blobs.sql

--sclbd_s2
PROMPT configurando soporte BLOB para sclbd_s2
CONNECT netmax_bdd/netmax_bdd@sclbd_s2
@s-07-netmax-configuracion-soporte-blobs.sql

--iclbd_s1
PROMPT configurando soporte BLOB para iclbd_s1
CONNECT netmax_bdd/netmax_bdd@iclbd_s1
@s-07-netmax-configuracion-soporte-blobs.sql

--iclbd_s2
PROMPT configurando soporte BLOB para iclbd_s2
CONNECT netmax_bdd/netmax_bdd@iclbd_s2
@s-07-netmax-configuracion-soporte-blobs.sql

PROMPT ¡¡Listo!!
