-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/07/2021
-- @Descripción:  Procedimiento empleado para exportar un el contenido de una
--                columna BLOB a un archivo. Se emplea el valor de la llave
--                primaria para localizar el registro.

-- 1. Como SYS crear un directorio virtual en el que se guardará el archivo.
-- Por ejemplo:
-- create or replace directory tmp_dir as '/tmp/bdd';
-- 2. Como SYS otorgar permisos de lectura y escritura al usuario que va
-- ejecutar el script.
-- grant read,write on directory tmp_dir to <my_user>;
-- 3. Suponer que se desea leer el contenido de la columna pdf de la tabla:
-- create table my_table(
-- id number(2,0) ,
-- pdf blob
-- );
-- 4. Invocar el procedimiento:
--
-- exec save_file_from_blob('TMP_DIR','revista3.pdf','my_table','pdf','id','5');
--
-- parámetro 1: nombre del directorio virtual creado anteriormente
-- parámetro 2: nombre del archivo dentro del directorio configurado
-- parámetro 3: nombre de la tabla que contiene lacolumna a leer
-- parámetro 4: nombre de la columna tipo blob.
-- parámetro 5: nombre de la columna que actua como PK.
-- parámetro 6: valor de la PK que se emplea para localizar al registro cuyo
--              valor de la columna de tipo blob se va a leer.
-- parametro 7: nombre de la segunda columna que forma parte de la PK.
-- parametro 8: valor para la segunda columna que forma parte de la PK.

-- Creación del procedimiento
CREATE OR REPLACE PROCEDURE guarda_blob_en_archivo (
  --Parámetros de entrada
  v_directory_name IN VARCHAR2,
  v_dest_file_name IN VARCHAR2,
  v_table_name IN VARCHAR2,
  v_blob_column_name IN VARCHAR2,
  v_pk1_column_name IN VARCHAR2,
  v_pk1_column_value IN VARCHAR2,
  v_pk2_column_name IN VARCHAR2,
  v_pk2_column_value IN VARCHAR2
) IS
  --Definición de variables
  v_file UTL_FILE.FILE_TYPE;
  v_buffer_size NUMBER := 32767;
  v_buffer RAW(32767);
  v_blob BLOB;
  v_blob_length NUMBER;
  v_position NUMBER;
  v_query VARCHAR2(2000);
  --Variables para nombres válidos de columnas y tablas
  v_valid_table_name VARCHAR2(30);
  v_valid_blob_column_name VARCHAR2(30);
  v_valid_pk1_column_name VARCHAR2(30);
  v_valid_pk2_column_name VARCHAR2(30);
BEGIN
  --Se verifica que los nombres de tablas y columnas sean validos.
  --Evita inyección de SQL
  v_valid_table_name := dbms_assert.simple_sql_name(v_table_name);
  v_valid_blob_column_name := dbms_assert.simple_sql_name(v_blob_column_name);
  v_valid_pk1_column_name := dbms_assert.simple_sql_name(v_pk1_column_name);

  --Verifica que exista una segunda columna de la PK
  IF v_pk2_column_name IS NOT NULL THEN
    v_valid_pk2_column_name := dbms_assert.simple_sql_name(v_pk2_column_name);
  END IF;

  --Construcción del query
  v_query := 'select '
    || v_valid_blob_column_name
    || ' into :ph_blob'
    || ' from '
    || v_valid_table_name
    || ' where '
    || v_valid_pk1_column_name
    || ' = '
    || ':ph_pk1_column_value';

  --Completa el query si existe una segunda columna en la PK
  IF v_pk2_column_name IS NOT NULL THEN
    v_query := v_query
    || ' and '
    || v_valid_pk2_column_name
    || ' = '
    || ':ph_pk2_column_value';
  END IF;

  --Se imprime el query construido
  dbms_output.put_line(v_query);

  --Ejecución del query dinámico. Se valida que exista la PK2
  IF v_pk2_column_name IS NOT NULL THEN
    --El blob devuelto se guarda en la variable v_blob
    EXECUTE IMMEDIATE v_query INTO v_blob
    USING v_pk1_column_value, v_pk2_column_value;
  ELSE
    EXECUTE IMMEDIATE v_query INTO v_blob
    USING v_pk1_column_value;
  END IF;

  --Obtiene el tamaño del blob
  v_blob_length := dbms_lob.getlength(v_blob);
  v_position := 1;
  --Se abre el archivo para ser escrito en el destino especificado
  v_file := UTL_FILE.FOPEN(v_directory_name, v_dest_file_name, 'wb', 32767);

  --Lectura del archivo por partes hasta completar
  WHILE v_position < v_blob_length LOOP
    --Lee una sección del archivo y lo guarda en el v_buffer
    dbms_lob.read(v_blob, v_buffer_size, v_position, v_buffer);
    --Escribe el contenido del buffer en la variable tipo archivo
    UTL_FILE.PUT_RAW(v_file, v_buffer, TRUE);
    v_position := v_position + v_buffer_size;
  END LOOP;
  UTL_FILE.FCLOSE(v_file);

--Cierra el archivo en caso de error y relanza la excepción
EXCEPTION WHEN OTHERS THEN
  --Cierra v_file en caso de error
  IF UTL_FILE.is_open(v_file) THEN
    UTL_FILE.FCLOSE(v_file);
  END IF;
  RAISE;
END;
/

--Muestra los errores ocurridos
SHOW ERRORS;
