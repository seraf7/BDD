-- @Autor:           Humberto Serafín Castillo López
-- @Fecha creación:  08/08/2021
-- @Descripción:     Creación de usuarios comunes en los PDBs

PROMPT Creando usuario en sclbdd_s1...
CONNECT sys/system@sclbdd_s1 AS sysdba
@ejemplo-autos-mviews/s-01-creacion-usuario.sql

PROMPT Creando usuario en sclbdd_s2...
CONNECT sys/system@sclbdd_s2 AS sysdba
@ejemplo-autos-mviews/s-01-creacion-usuario.sql

PROMPT Otorgando privilegios especiales en sclbdd_s2...
-- Permite crear mviews
GRANT CREATE MATERIALIZED VIEW TO scl_replica_bdd;
-- Permite realizar refresh a la vista
GRANT ALTER ANY MATERIALIZED VIEW TO scl_replica_bdd;
-- Permite crear ligas privadas
GRANT CREATE DATABASE LINK TO scl_replica_bdd;
-- Permite crear ligas públicas
GRANT CREATE PUBLIC DATABASE LINK TO scl_replica_bdd;

PROMPT ¡¡Listo!!
EXIT
