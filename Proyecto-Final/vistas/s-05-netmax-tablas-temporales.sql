-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   11/08/2021
-- @Descripción:      Definición de tablas temporales para manejor de BLOBs

PROMPT Eliminando tablas temporales en caso de existir...
DECLARE
  -- Creación de un cursor con nombres de las tablas temporales
  CURSOR cur_tablas IS
    SELECT table_name FROM user_tables
    WHERE table_name IN ('TS_DOCUMENTAL_1','TS_DOCUMENTAL_2','TS_DOCUMENTAL_3',
      'TI_DOCUMENTAL_1','TI_DOCUMENTAL_2','TI_DOCUMENTAL_3',
      'TS_ARCHIVO_PROGRAMA_1','TS_ARCHIVO_PROGRAMA_2',
      'TI_ARCHIVO_PROGRAMA_1','TI_ARCHIVO_PROGRAMA_2');
BEGIN
  -- Ciclo para recorrer el cursor
  FOR r IN cur_tablas LOOP
    -- Se elimina la tabla en iteración
    EXECUTE IMMEDIATE 'drop table ' || r.table_name;
  END LOOP;
END;
/

PROMPT Creando tablas temporales para transparencias - SELECT...
-- Tablas temporales para DOCUMENTAL
CREATE GLOBAL TEMPORARY TABLE ts_documental_1 (
  programa_id NUMBER(10,0) CONSTRAINT ts_documental_1_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ts_documental_2 (
  programa_id NUMBER(10,0) CONSTRAINT ts_documental_2_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ts_documental_3 (
  programa_id NUMBER(10,0) CONSTRAINT ts_documental_3_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

-- Tablas temporales para ARCHIVO_PROGRAMA
CREATE GLOBAL TEMPORARY TABLE ts_archivo_programa_1 (
  num_archivo NUMBER(5,0),
  programa_id NUMBER(10,0),
  archivo BLOB NOT NULL,
  CONSTRAINT ts_archivo_programa_1_pk PRIMARY KEY (num_archivo,programa_id)
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ts_archivo_programa_2 (
  num_archivo NUMBER(5,0),
  programa_id NUMBER(10,0),
  archivo BLOB NOT NULL,
  CONSTRAINT ts_archivo_programa_2_pk PRIMARY KEY (num_archivo,programa_id)
) ON COMMIT PRESERVE ROWS;


PROMPT tablas temporales para transparencia - Insert...
-- Tablas temporales para DOCUMENTAL
CREATE GLOBAL TEMPORARY TABLE ti_documental_1 (
  programa_id NUMBER(10,0) CONSTRAINT ti_documental_1_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ti_documental_2 (
  programa_id NUMBER(10,0) CONSTRAINT ti_documental_2_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ti_documental_3 (
  programa_id NUMBER(10,0) CONSTRAINT ti_documental_3_pk PRIMARY KEY,
  trailer BLOB NOT NULL
) ON COMMIT PRESERVE ROWS;

-- Tablas temporales para ARCHIVO_PROGRAMA
CREATE GLOBAL TEMPORARY TABLE ti_archivo_programa_1 (
  num_archivo NUMBER(5,0),
  programa_id NUMBER(10,0),
  archivo BLOB NOT NULL,
  CONSTRAINT ti_archivo_programa_1_pk PRIMARY KEY (num_archivo,programa_id)
) ON COMMIT PRESERVE ROWS;

CREATE GLOBAL TEMPORARY TABLE ti_archivo_programa_2 (
  num_archivo NUMBER(5,0),
  programa_id NUMBER(10,0),
  archivo BLOB NOT NULL,
  CONSTRAINT ti_archivo_programa_2_pk PRIMARY KEY (num_archivo,programa_id)
) ON COMMIT PRESERVE ROWS;
