-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        22/07/2021
-- @Descripción:  Definición de vistas para manejo de BLOBs en la PDB sclbdd_s2

PROMPT Connectando a sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

PROMPT =========================================================================
PROMPT Paso 1. Creando vistas con columnas BLOB locales.
PROMPT

--Definición de vista para EMPLEADO
CREATE OR REPLACE VIEW empleado AS
  SELECT E1.empleado_id, Q1.nombre, Q1.ap_paterno, Q1.ap_materno, Q1.rfc,
    E1.foto, E1.num_cuenta, Q1.email, Q1.jefe_id
  FROM empleado_1 E1
  JOIN (
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_2
    UNION ALL
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_3
  ) Q1 ON E1.empleado_id = Q1.empleado_id;

PROMPT =========================================================================
PROMPT Paso 2 creando objetos type para vistas que involucran BLOBs remotos
PROMPT

--Objeto personalizado para registros de PROYECTO_PDF
CREATE OR REPLACE TYPE proyecto_pdf_type AS OBJECT (
  num_pdf NUMERIC(1, 0),
  proyecto_id NUMERIC(10, 0),
  archivo_pdf BLOB,
  tamanio NUMERIC(10, 2)
);
/
SHOW ERRORS;

PROMPT =========================================================================
PROMPT Paso 3 creando objetos table para vistas que involucran BLOBs remotos
PROMPT

--Objeto tipo tabla para guardar datos de PROYECTO_PDF
CREATE OR REPLACE TYPE proyecto_pdf_table AS TABLE OF proyecto_pdf_type;
/
SHOW ERRORS;

PROMPT =========================================================================
PROMPT Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos
PROMPT

--Tabla temporal para fragmento f_scl_proyecto_pdf_1
CREATE GLOBAL TEMPORARY TABLE t_scl_proyecto_pdf_1(
  num_pdf NUMERIC(1, 0) NOT NULL,
  proyecto_id NUMERIC(10, 0) NOT NULL,
  archivo_pdf BLOB NOT NULL,
  tamanio NUMERIC(10, 2) NOT NULL,
  CONSTRAINT t_scl_proyecto_pdf_pk PRIMARY KEY (num_pdf, proyecto_id)
  --Se indica que los registros se preservan después del commit y son
  --borrados al terminar la sesión
) ON COMMIT PRESERVE ROWS;

PROMPT =========================================================================
PROMPT Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
PROMPT

--Función para obtener registros de proyecto_pdf_1
CREATE OR REPLACE FUNCTION get_remote_proyecto_pdf
--Se usa PIPELINED debido a que la función regresa una colección de datos
RETURN proyecto_pdf_table PIPELINED IS
--Se indica que las sentencias DML internas se ejecutan de forma independiente
PRAGMA autonomous_transaction;
BEGIN
  --transacción 1, asegura que no haya registros
  DELETE FROM t_scl_proyecto_pdf_1;
  --Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO t_scl_proyecto_pdf_1
    SELECT num_pdf, proyecto_id, archivo_pdf, tamanio FROM proyecto_pdf_1;
  COMMIT;

  --Obtiene registros de tabla temporal y los regresa como proyecto_pdf_type
  FOR cur IN (SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
    FROM t_scl_proyecto_pdf_1)
  LOOP
    PIPE ROW(proyecto_pdf_type(cur.num_pdf, cur.proyecto_id,
      cur.archivo_pdf, cur.tamanio));
  END LOOP;

  --transacción 2, se limpia la tabla temporal
  DELETE FROM t_scl_proyecto_pdf_1;
  COMMIT;

  RETURN;

EXCEPTION
  WHEN OTHERS THEN
    --Termina transacción autónoma si hay algún error y lo propaga
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;

PROMPT =========================================================================
PROMPT Paso 6 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
PROMPT

--Función para obtener BLOB de PROYECTO_PDF
CREATE OR REPLACE FUNCTION get_remote_pdf_by_id(
  --Parámtros de entrada
  v_num_pdf IN NUMBER,
  v_proyecto_id IN NUMBER
)
--Se retorna un dato BLOB y se usan transacciones autónomas
RETURN BLOB IS
PRAGMA autonomous_transaction;
  --Definición de variables
  v_temp_archivo_pdf BLOB;
BEGIN
  --transacción 1, asegura que no haya registros
  DELETE FROM t_scl_proyecto_pdf_1;
  --Inserta registro de fragmento remoto en tabla temporal
  INSERT INTO t_scl_proyecto_pdf_1
    SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
    FROM proyecto_pdf_1
    WHERE num_pdf = v_num_pdf AND proyecto_id = v_proyecto_id;

  --Obtiene archivo_pdf de tabla temporal y lo guarda en la variable de retorno
  SELECT archivo_pdf INTO v_temp_archivo_pdf
  FROM t_scl_proyecto_pdf_1
  WHERE num_pdf = v_num_pdf AND proyecto_id = v_proyecto_id;

  --Limpia la tabla temporal
  DELETE FROM t_scl_proyecto_pdf_1;
  COMMIT;

  RETURN v_temp_archivo_pdf;

EXCEPTION
  WHEN OTHERS THEN
    --Deshace cambios en caso de error y lo propaga
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;

PROMPT =========================================================================
PROMPT Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 1
PROMPT

--Definición de la vista PROYECTO_PDF
CREATE OR REPLACE VIEW proyecto_pdf_e1 AS
  --Se usa la tabla retornada por la función get_remote_proyecto_pdf
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM TABLE (get_remote_proyecto_pdf)
  UNION ALL
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM proyecto_pdf_2;

PROMPT =========================================================================
PROMPT Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2
PROMPT

--Definición de la vista proyecto_pdf
CREATE OR REPLACE VIEW proyecto_pdf_e2 AS
  SELECT num_pdf, proyecto_id,
  get_remote_pdf_by_id(num_pdf, proyecto_id) AS archivo_pdf, tamanio
  FROM proyecto_pdf_1
  UNION ALL
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM proyecto_pdf_2;

PROMPT =========================================================================
PROMPT Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.
PROMPT

--Sinónimo para PROYECTO_PDF
CREATE OR REPLACE SYNONYM proyecto_pdf FOR proyecto_pdf_e2;

PROMPT ¡¡Listo!!
EXIT
