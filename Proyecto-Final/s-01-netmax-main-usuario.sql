-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   09/08/2021
-- @Descripción:      Creación de usuarios en los cuatro nodos

CLEAR SCREEN
WHENEVER SQLERROR EXIT ROLLBACK;
SET SERVEROUTPUT ON

PROMPT Inciando creacion/eliminacion de usuarios.
ACCEPT syspass CHAR PROMPT 'Proporcione el password de sys: ' hide

PROMPT =====================================
PROMPT Creando usuario en sclbd_s1
PROMPT =====================================
CONNECT sys/&&syspass@sclbd_s1 as sysdba
@s-01-netmax-usuario.sql

PROMPT =====================================
PROMPT Creando usuario en sclbd_s2
PROMPT =====================================
CONNECT sys/&&syspass@sclbd_s2 as sysdba
@s-01-netmax-usuario.sql

PROMPT =====================================
PROMPT Creando usuario en iclbd_s1
PROMPT =====================================
CONNECT sys/&&syspass@iclbd_s1 as sysdba
@s-01-netmax-usuario.sql

PROMPT =====================================
PROMPT Creando usuario en iclbd_s2
PROMPT =====================================
CONNECT sys/&&syspass@iclbd_s2 as sysdba
@s-01-netmax-usuario.sql

PROMPT ¡¡Listo!!
EXIT
