-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   16/08/2021
-- @Descripción:      SCript de eliminación de datos

PROMPT Seleccionar la PDB para realizar la eliminación de datos

CONNECT netmax_bdd/netmax_bdd@&pdb
SET SERVEROUTPUT ON

PROMPT Eliminando datos...

-- Transacción para eliminar datos
DECLARE
  v_formato VARCHAR2(50) := 'yyyy-mm-dd hh24:mi:ss';
BEGIN
  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de playlist');
  DELETE FROM playlist;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de usuario');
  DELETE FROM usuario;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de tipo_cuenta');
  DELETE FROM tipo_cuenta;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de documental');
  DELETE FROM documental;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de pelicula');
  DELETE FROM pelicula;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de serie');
  DELETE FROM serie;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de pais');
  DELETE FROM pais;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de tipo_serie');
  DELETE FROM tipo_serie;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de historico_status_programa');
  DELETE FROM historico_status_programa;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de archivo_programa');
  DELETE FROM archivo_programa;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de programa');
  DELETE FROM programa;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Eliminando datos de status_programa');
  DELETE FROM status_programa;

  dbms_output.put_line(to_char(sysdate, v_formato)
    || '  Confirmando datos eliminados');
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Errores al realizar la eliminación');
    dbms_output.put_line('Se hará ROLLBACK');
    ROLLBACK;
    RAISE;
END;
/

PROMPT ¡¡Listo!!
EXIT
