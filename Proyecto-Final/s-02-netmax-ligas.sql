-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   09/08/2021
-- @Descripción:      Creación de ligas en los 4 nodos

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;

-- Ligas para el PDB sclbd_s1
PROMPT Creando ligas en sclbd_s1...
CONNECT netmax_bdd/netmax_bdd@sclbd_s1

CREATE DATABASE LINK sclbd_s2.fi.unam USING 'SCLBD_S2';
CREATE DATABASE LINK iclbd_s1.fi.unam USING 'ICLBD_S1';
CREATE DATABASE LINK iclbd_s2.fi.unam USING 'ICLBD_S2';

-- Ligas para el PDB sclbd_s2
PROMPT Creando ligas en sclbd_s2...
CONNECT netmax_bdd/netmax_bdd@sclbd_s2

CREATE DATABASE LINK sclbd_s1.fi.unam USING 'SCLBD_S1';
CREATE DATABASE LINK iclbd_s1.fi.unam USING 'ICLBD_S1';
CREATE DATABASE LINK iclbd_s2.fi.unam USING 'ICLBD_S2';

-- Ligas para el PDB iclbd_s1
PROMPT Creando ligas en iclbd_s1...
CONNECT netmax_bdd/netmax_bdd@iclbd_s1

CREATE DATABASE LINK sclbd_s1.fi.unam USING 'SCLBD_S1';
CREATE DATABASE LINK sclbd_s2.fi.unam USING 'SCLBD_S2';
CREATE DATABASE LINK iclbd_s2.fi.unam USING 'ICLBD_S2';

-- Ligas para el PDB iclbd_s2
PROMPT Creando ligas en iclbd_s2...
CONNECT netmax_bdd/netmax_bdd@iclbd_s2

CREATE DATABASE LINK sclbd_s1.fi.unam USING 'SCLBD_S1';
CREATE DATABASE LINK sclbd_s2.fi.unam USING 'SCLBD_S2';
CREATE DATABASE LINK iclbd_s1.fi.unam USING 'ICLBD_S1';

PROMPT ¡¡Listo!!
