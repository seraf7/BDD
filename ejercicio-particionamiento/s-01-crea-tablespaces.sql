-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Creación de tablespaces y asignación a usuario

PROMPT Conectando como usuario sys...
CONNECT sys/system@sclbdd_s1 AS sysdba

PROMPT Creando tablespaces...
--Creación de los tablespaces
CREATE TABLESPACE autos_tbs_0
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_0.dbf'
  SIZE 100M
  AUTOEXTEND ON NEXT 50M MAXSIZE 5G
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE autos_tbs_1
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_1.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE autos_tbs_2
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_2.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE autos_tbs_3
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_3.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE autos_tbs_4
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_4.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE autos_tbs_5
DATAFILE '/u01/app/oracle/oradata/SCLBDD/sclbdd_s1/autos_tbs_5.dbf'
  SIZE 10M
  AUTOEXTEND ON NEXT 5M MAXSIZE 50M
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
SEGMENT SPACE MANAGEMENT AUTO;

-- Asignación del tablespace por default 
ALTER USER scl_particiones_bdd DEFAULT TABLESPACE autos_tbs_0;

-- Asignación de cuotas ilimitadas
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_0;
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_1;
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_2;
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_3;
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_4;
ALTER USER scl_particiones_bdd QUOTA UNLIMITED ON autos_tbs_5;
