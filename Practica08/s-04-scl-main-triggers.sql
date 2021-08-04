-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/07/2021
-- @Descripción: Creación de triggers

PROMPT Creando triggers en S1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Creando trigger para pais...
@s-03-scl-pais-trigger.sql
SHOW ERRORS

PROMPT Creando trigger para oficina...
@s-03-scl-oficina-n1-trigger.sql
SHOW ERRORS

PROMPT Creando trigger para empleado...
@s-03-scl-empleado-n1-trigger.sql
SHOW ERRORS

PROMPT Creando triggers en S2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

PROMPT Creando trigger para pais...
@s-03-scl-pais-trigger.sql
SHOW ERRORS

PROMPT Creando trigger para oficina...
@s-03-scl-oficina-n2-trigger.sql
SHOW ERRORS

PROMPT Creando trigger para empleado...
@s-03-scl-empleado-n2-trigger.sql
SHOW ERRORS

PROMPT ¡¡Listo!!
EXIT
