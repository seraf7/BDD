-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   15/08/2021
-- @Descripción:      Script empleado para configurar el
--                    soporte de datos BLOB.

PROMPT Creando objetos para leer datos BLOB...

PROMPT Creando directorio...
-- El usuario debe tener el privilegio CREATE ANY DIRECTORY

-- Objeto DIRECTORY para representar el campo archivo_programa.archivo
CREATE OR REPLACE DIRECTORY proyecto_final_pdfs_dir
AS '/tmp/bdd/proyecto-final/pdfs';

-- Objeto DIRECTORY para almacenar los trailer de documental
CREATE OR REPLACE DIRECTORY proyecto_final_trailers_dir
AS '/tmp/bdd/proyecto-final/trailers';

PROMPT Creando función para leer datos BLOB...
CREATE OR REPLACE FUNCTION fx_carga_blob(
  p_directory_name  IN VARCHAR2,
  p_src_file_name   IN VARCHAR2
) RETURN BLOB IS
  -- Declaración de variables
  v_src_blob BFILE := bfilename(UPPER(p_directory_name), p_src_file_name);
  v_dest_blob BLOB := empty_blob();
  v_src_offset NUMBER := 1;
  v_dest_offset NUMBER := 1;
  v_src_blob_size NUMBER;
BEGIN
  -- Comprueba existencia del archivo
  IF dbms_lob.fileexists(v_src_blob) = 0 THEN
    raise_application_error(-20001, p_src_file_name
      || ' El archivo '
      || p_src_file_name
      || ' no existe en '
      || p_directory_name);
  END IF;

  -- Comprueba si el archivo está abierto
  IF dbms_lob.isopen(v_src_blob) = 0 THEN
    -- Abre el archivo
    dbms_lob.open(v_src_blob, dbms_lob.LOB_READONLY);
  END IF;

  -- Obtiene el tamaño del archivo
  v_src_blob_size := dbms_lob.getlength(v_src_blob);

  -- Crea un objeto LOB temporal
  dbms_lob.createtemporary(
    lob_loc => v_dest_blob,
    cache   => true,
    dur     => dbms_lob.call
  );

  -- Lee el archivo y escribe en el BLOB
  dbms_lob.loadblobfromfile(
    dest_lob => v_dest_blob,
    src_bfile => v_src_blob,
    amount => dbms_lob.getlength(v_src_blob),
    dest_offset => v_dest_offset,
    src_offset => v_src_offset
  );

  -- Se cierra el BLOB
  dbms_lob.close(v_src_blob);

  -- Comprueba que se haya leido el archivo completo
  IF v_src_blob_size <> dbms_lob.getlength(v_dest_blob) THEN
    raise_application_error(-20104,
      'Numero de bytes leídos VS escritos no coinciden: '
      || v_src_blob_size || ', actual: ' || dbms_lob.getlength(v_dest_blob));
  END IF;

  -- Se devuelve el objeto leido
  RETURN v_dest_blob;
END;
/
SHOW ERRORS;
