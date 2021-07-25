-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        21/07/2021
-- @Descripción:  Definición de vistas para manejo de BLOBs en la PDB sclbdd_s1

PROMPT Connectando a sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT =========================================================================
PROMPT Paso 1. Creando vistas con columnas BLOB locales.
PROMPT

-- No hay vistas locales con columnas BLOB

PROMPT =========================================================================
PROMPT Paso 2 creando objetos type para vistas que involucran BLOBs remotos
PROMPT

--Objeto personalizado para registros empleado_1
CREATE OR REPLACE TYPE empleado_type AS OBJECT (
  empleado_id NUMERIC(10, 0),
  foto BLOB,
  num_cuenta VARCHAR(18)
);
/
--Objeto personalizado para registros PROYECTO_PDF
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

--Objeto tipo tabla para guardar datos de EMPLEADO
CREATE OR REPLACE TYPE empleado_table AS TABLE OF empleado_type;
/

--Objeto tipo tabla para guardar datos de PROYECTO_PDF
CREATE OR REPLACE TYPE proyecto_pdf_table AS TABLE OF proyecto_pdf_type;
/
SHOW ERRORS;

PROMPT =========================================================================
PROMPT Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos
PROMPT

--Tabla temporal para fragmento f_scl_empleado_1
CREATE GLOBAL TEMPORARY TABLE t_scl_empleado_1(
  empleado_id NUMERIC(10, 0) NOT NULL,
  foto BLOB NOT NULL,
  num_cuenta VARCHAR(18) NOT NULL,
  CONSTRAINT t_scl_empleado_1_pk PRIMARY KEY (empleado_id)
  --Se indica que los registros se preservan después del commit y son
  --borrados al terminar la sesión
) ON COMMIT PRESERVE ROWS;

--Tabla temporal para el fragmento f_scl_proyecto_pdf_2
CREATE GLOBAL TEMPORARY TABLE t_scl_proyecto_pdf_2(
  num_pdf NUMERIC(1, 0) NOT NULL,
  proyecto_id NUMERIC(10, 0) NOT NULL,
  archivo_pdf BLOB NOT NULL,
  tamanio NUMERIC(10, 0) NOT NULL,
  CONSTRAINT t_scl_proyecto_pdf_pk PRIMARY KEY (num_pdf, proyecto_id)
) ON COMMIT PRESERVE ROWS;

PROMPT =========================================================================
PROMPT Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
PROMPT

--Función para obtener registros de empleado_1
CREATE OR REPLACE FUNCTION get_remote_empleado
--Se usa PIPELINED debido a que la función regresa una colección de datos
RETURN empleado_table PIPELINED IS
--Se indica que las sentencias DML internas se ejecutan de forma independiente
PRAGMA autonomous_transaction;
BEGIN
  --Inicia transacción autónoma 1, asegura que no haya registros
  DELETE FROM t_scl_empleado_1;
  --Se insertan datos del fragmento remoto en la tabla temporal
  INSERT INTO t_scl_empleado_1
    SELECT empleado_id, foto, num_cuenta FROM empleado_1;
  --Termina transacción autónoma 1 antes de construir el objeto TABLE
  COMMIT;

  --Obtiene registros de la tabla temporal, mediante un cursor
  --se devuelven objetos empleado_type
  FOR cur IN (SELECT empleado_id, foto, num_cuenta FROM t_scl_empleado_1) LOOP
    --Permite incluir el registro en el objeto empleado_table
    PIPE ROW(empleado_type(cur.empleado_id, cur.foto, cur.num_cuenta));
  END LOOP;

  --Inicia transacción autónoma 2, limpia la tabla temporal
  DELETE FROM t_scl_empleado_1;
  --Termina transacción autónoma 2
  COMMIT;
  RETURN;

EXCEPTION
  WHEN OTHERS THEN
    --Termina la transacción autónoma si ocurre un error, deshace los cambios
    ROLLBACK;
    --Se relanza el error para que sea propagado
    RAISE;
END;
/

--Función para obtener registros de PROYECTO_PDF
CREATE OR REPLACE FUNCTION get_remote_proyecto_pdf
RETURN proyecto_pdf_table PIPELINED IS
PRAGMA autonomous_transaction;
BEGIN
  --transacción 1, asegura que no haya registros
  DELETE FROM t_scl_proyecto_pdf_2;
  --Inserta datos del fragmento remoto en tabla temporal
  INSERT INTO t_scl_proyecto_pdf_2
    SELECT num_pdf, proyecto_id, archivo_pdf, tamanio FROM proyecto_pdf_2;
  COMMIT;

  --Obtiene registros de tabla temporal y los regresa como proyecto_pdf_type
  FOR cur IN (SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
    FROM t_scl_proyecto_pdf_2)
  LOOP
    --Incluye el registro en el objeto proyecto_pdf_table
    PIPE ROW(proyecto_pdf_type(cur.num_pdf, cur.proyecto_id,
      cur.archivo_pdf, cur.tamanio));
  END LOOP;

  --transacción 2, limpia la tabla temporal
  DELETE FROM t_scl_proyecto_pdf_2;
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

--Función para obtener BLOB de EMPLEADO
CREATE OR REPLACE FUNCTION get_remote_foto_by_id(
  --Parámtro de entrada
  v_empleado_id IN NUMBER
)
--Indica que se retorna un dato BLOB
RETURN BLOB IS
--Indica el uso de transacciones autónomas
PRAGMA autonomous_transaction;
  --Definición de variables
  v_temp_foto BLOB;
BEGIN
  --transacción autónoma 1, asegura que no haya registros
  DELETE FROM t_scl_empleado_1;
  --Inserta un registro del fragmento remoto en tabla temporal
  INSERT INTO t_scl_empleado_1
    SELECT empleado_id, foto, num_cuenta
    FROM empleado_1
    WHERE empleado_id = v_empleado_id;

  --Obtiene registro de tabla temporal y lo guarda en variable de retorno
  SELECT foto INTO v_temp_foto
  FROM t_scl_empleado_1
  WHERE empleado_id = v_empleado_id;

  --Limpia la tabla temporal
  DELETE FROM t_scl_empleado_1;
  COMMIT;

  RETURN v_temp_foto;

EXCEPTION
  WHEN OTHERS THEN
    --Deshace transacción en caso de error y lo propaga
    ROLLBACK;
    RAISE;
END;
/

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
  DELETE FROM t_scl_proyecto_pdf_2;
  --Inserta registro de fragmento remoto en tabla temporal
  INSERT INTO t_scl_proyecto_pdf_2
    SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
    FROM proyecto_pdf_2
    WHERE num_pdf = v_num_pdf AND proyecto_id = v_proyecto_id;

  --Obtiene archivo_pdf de tabla temporal y lo guarda en la variable de retorno
  SELECT archivo_pdf INTO v_temp_archivo_pdf
  FROM t_scl_proyecto_pdf_2
  WHERE num_pdf = v_num_pdf AND proyecto_id = v_proyecto_id;

  --Limpia la tabla temporal
  DELETE FROM t_scl_proyecto_pdf_2;
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

--Definición de la vista de EMPLEADO
CREATE OR REPLACE VIEW empleado_e1 AS
  SELECT Q2.empleado_id, Q1.nombre, Q1.ap_paterno, Q1.ap_materno, Q1.rfc,
    Q2.foto, Q2.num_cuenta, Q1.email, Q1.jefe_id
  FROM (
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_2
    UNION ALL
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_3
  ) Q1 JOIN (
    --Se obtiene la tabla remota a través de una función
    SELECT * FROM TABLE (get_remote_empleado)
  ) Q2 ON Q1.empleado_id = Q2.empleado_id;

--Definición de la vista PROYECTO_PDF
CREATE OR REPLACE VIEW proyecto_pdf_e1 AS
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM proyecto_pdf_1
  UNION ALL
  --Se usa la tabla retornada por la función get_remote_proyecto_pdf
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM TABLE (get_remote_proyecto_pdf);

PROMPT =========================================================================
PROMPT Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2
PROMPT

--Definición de la vista EMPLEADO
CREATE OR REPLACE VIEW empleado_e2 AS
  SELECT Q2.empleado_id, Q1.nombre, Q1.ap_paterno, Q1.ap_materno, Q1.rfc,
    --Se obtiene cada foto a través de la función
    get_remote_foto_by_id(Q2.empleado_id) AS foto,
    Q2.num_cuenta, Q1.email, Q1.jefe_id
  FROM (
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_2
    UNION ALL
    SELECT empleado_id, nombre, ap_paterno, ap_materno, rfc, email, jefe_id
    FROM empleado_3
  ) Q1 JOIN (
    SELECT empleado_id, num_cuenta FROM empleado_1
  ) Q2 ON Q1.empleado_id = Q2.empleado_id;

--Definición de la vista PROYECTO_PDF
CREATE OR REPLACE VIEW proyecto_pdf_e2 AS
  SELECT num_pdf, proyecto_id, archivo_pdf, tamanio
  FROM proyecto_pdf_1
  UNION ALL
  SELECT num_pdf, proyecto_id,
  get_remote_pdf_by_id(num_pdf, proyecto_id) AS archivo_pdf, tamanio
  FROM proyecto_pdf_2;

PROMPT =========================================================================
PROMPT Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.
PROMPT

--Sinónimo para EMPLEADO
CREATE OR REPLACE SYNONYM empleado FOR empleado_e2;

--Sinónimo para PROYECTO_PDF
CREATE OR REPLACE SYNONYM proyecto_pdf FOR proyecto_pdf_e2;

PROMPT ¡¡Listo!!
EXIT
