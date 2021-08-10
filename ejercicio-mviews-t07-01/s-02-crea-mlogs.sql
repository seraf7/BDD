-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   08/08/2021
-- @Descripción:      Creación de mlogs usados en vistas materializadas en el
--                    sitio master

-- Conexión al sitio de las tablas master
PROMPT Conectando a sclbdd_s1...
CONNECT scl_replica_bdd/serafin@sclbdd_s1

PROMPT Creando mlogs...
-- Creación de mlog para agencia
CREATE MATERIALIZED VIEW LOG ON agencia
  WITH PRIMARY KEY (clave);

-- Creación de mlog para auto
CREATE MATERIALIZED VIEW LOG ON auto
  WITH PRIMARY KEY (tipo, cliente_id, agencia_id);

-- Creación de mlog para cliente
CREATE MATERIALIZED VIEW LOG ON cliente;

PROMPT Consultando mlogs existentes...
SELECT log_owner, master, log_table, primary_key,
  filter_columns, last_purge_date
FROM user_mview_logs;
