-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   12/08/2021
-- @Descripción:      Definición de funciones para acceso a BLOBs

PROMPT Funciones para acceso de blobs - DOCUMENTAL...
-- Función para obtener BLOB del fragmento 1
CREATE OR REPLACE FUNCTION get_remote_trailer_f1_by_id(v_id IN NUMBER)
  RETURN BLOB IS
  PRAGMA autonomous_transaction;
  v_temp_trailer BLOB;
BEGIN
  -- Asegura que no haya registros en tabla temporal
  DELETE FROM ts_documental_1;
  -- Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO ts_documental_1
    SELECT programa_id, trailer
    FROM documental_f1
    WHERE programa_id = v_id;
  -- Obtiene registro de la tabla temporal y lo devuelve como BLOB
  SELECT trailer INTO v_temp_trailer
  FROM ts_documental_1
  WHERE programa_id = v_id;
  -- Limpia la tabla temporal
  DELETE FROM ts_documental_1;
  COMMIT;
  -- Devuelve el BLOB
  RETURN v_temp_trailer;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;

-- Función para obtener BLOB del fragmento 2
CREATE OR REPLACE FUNCTION get_remote_trailer_f2_by_id(v_id IN NUMBER)
  RETURN BLOB IS
  PRAGMA autonomous_transaction;
  v_temp_trailer BLOB;
BEGIN
  -- Asegura que no haya registros en tabla temporal
  DELETE FROM ts_documental_2;
  -- Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO ts_documental_2
    SELECT programa_id, trailer
    FROM documental_f2
    WHERE programa_id = v_id;
  -- Obtiene registro de la tabla temporal y lo devuelve como BLOB
  SELECT trailer INTO v_temp_trailer
  FROM ts_documental_2
  WHERE programa_id = v_id;
  -- Limpia la tabla temporal
  DELETE FROM ts_documental_2;
  COMMIT;
  -- Devuelve el BLOB
  RETURN v_temp_trailer;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;

-- Función para obtener BLOB del fragmento 3
CREATE OR REPLACE FUNCTION get_remote_trailer_f3_by_id(v_id IN NUMBER)
  RETURN BLOB IS
  PRAGMA autonomous_transaction;
  v_temp_trailer BLOB;
BEGIN
  -- Asegura que no haya registros en tabla temporal
  DELETE FROM ts_documental_3;
  -- Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO ts_documental_3
    SELECT programa_id, trailer
    FROM documental_f3
    WHERE programa_id = v_id;
  -- Obtiene registro de la tabla temporal y lo devuelve como BLOB
  SELECT trailer INTO v_temp_trailer
  FROM ts_documental_3
  WHERE programa_id = v_id;
  -- Limpia la tabla temporal
  DELETE FROM ts_documental_3;
  COMMIT;
  -- Devuelve el BLOB
  RETURN v_temp_trailer;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;


PROMPT Funciones para acceso de blobs - ARCHIVO_PROGRAMA...
-- Función para obtener BLOB del fragmento 1
CREATE OR REPLACE FUNCTION get_remote_archivo_f1_by_id(
  v_num IN NUMBER, v_id IN NUMBER
)
  RETURN BLOB IS
  PRAGMA autonomous_transaction;
  v_temp_archivo BLOB;
BEGIN
  -- Asegura que no haya registros en la tabla temporal
  DELETE FROM ts_archivo_programa_1;
  -- Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO ts_archivo_programa_1
    SELECT num_archivo, programa_id, archivo
    FROM archivo_programa_f1
    WHERE num_archivo = v_num
    AND programa_id = v_id;
  -- Obtiene registro de la tabla temporal y lo devuelve como BLOB
  SELECT archivo INTO v_temp_archivo
  FROM ts_archivo_programa_1
  WHERE num_archivo = v_num
  AND programa_id = v_id;
  -- Limpia la tabla temporal
  DELETE FROM ts_archivo_programa_1;
  COMMIT;
  -- Devuelve el BLOB
  RETURN v_temp_archivo;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;

-- Función para obtener BLOB del fragmento 2
CREATE OR REPLACE FUNCTION get_remote_archivo_f2_by_id(
  v_num IN NUMBER, v_id IN NUMBER
)
  RETURN BLOB IS
  PRAGMA autonomous_transaction;
  v_temp_archivo BLOB;
BEGIN
  -- Asegura que no haya registros en la tabla temporal
  DELETE FROM ts_archivo_programa_2;
  -- Inserta datos del fragmento remoto en la tabla temporal
  INSERT INTO ts_archivo_programa_2
    SELECT num_archivo, programa_id, archivo
    FROM archivo_programa_f2 
    WHERE num_archivo = v_num
    AND programa_id = v_id;
  -- Obtiene registro de la tabla temporal y lo devuelve como BLOB
  SELECT archivo INTO v_temp_archivo
  FROM ts_archivo_programa_2
  WHERE num_archivo = v_num
  AND programa_id = v_id;
  -- Limpia la tabla temporal
  DELETE FROM ts_archivo_programa_2;
  COMMIT;
  -- Devuelve el BLOB
  RETURN v_temp_archivo;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/
SHOW ERRORS;
