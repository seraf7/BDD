-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   08/08/2021
-- @Descripción:      Creación de los objetos en del caso de estudio de
--                    agencia de autos y carga de datos

--si ocurre un error, se hace rollback de los datos y
--se sale de SQL *Plus
whenever  sqlerror exit rollback

PROMPT Conectando a scl_replica_bdd...
CONNECT scl_replica_bdd/serafin@sclbdd_s1

PROMPT Creando objetos...
@ejemplo-autos-mviews/s-02-autos-ddl.sql

PROMPT Cargando datos iniciales...
@ejemplo-autos-mviews/s-03-status_auto.sql
@ejemplo-autos-mviews/s-03-agencia.sql
@ejemplo-autos-mviews/s-03-cliente.sql
@ejemplo-autos-mviews/s-03-auto_1.sql
@ejemplo-autos-mviews/s-03-auto_2.sql
@ejemplo-autos-mviews/s-03-auto_3.sql
@ejemplo-autos-mviews/s-03-historico_status_auto_1.sql
@ejemplo-autos-mviews/s-03-historico_status_auto_2.sql
@ejemplo-autos-mviews/s-03-historico_status_auto_3.sql
@ejemplo-autos-mviews/s-03-historico_status_auto_4.sql
@ejemplo-autos-mviews/s-03-orden_compra_1.sql
@ejemplo-autos-mviews/s-03-orden_compra_2.sql
@ejemplo-autos-mviews/s-03-pago_auto_1.sql
@ejemplo-autos-mviews/s-03-pago_auto_2.sql
@ejemplo-autos-mviews/s-03-pago_auto_3.sql

-- Regresa la BD al estado original si encuentra algún error
whenever sqlerror continue none

PROMPT ¡¡Listo!!
EXIT
