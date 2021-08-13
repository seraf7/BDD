-- @Autor:           Humberto Serafín Castillo López
-- @Fecha creación:  09/08/2021
-- @Descripción:     Eliminación y creación de usuario

DECLARE
  v_count NUMBER(1, 0);
BEGIN
  -- Se busca el usuario en la BD
  SELECT COUNT(*) INTO v_count
  FROM dba_users
  WHERE LOWER(username) = 'netmax_bdd';
  -- Valida si existe el usuario
  IF v_count > 0 THEN
    -- Elimina el usuario y todos sus objetos
    EXECUTE IMMEDIATE 'drop user netmax_bdd cascade';
  ELSE
    dbms_output.put_line('El usuario netmax_bdd no existe');
  END IF;
END;
/

PROMPT Creando el usuario netmax_bdd...
CREATE USER netmax_bdd IDENTIFIED BY netmax_bdd
QUOTA UNLIMITED ON users;

PROMPT Asignando privilegios...
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE,
  CREATE VIEW, CREATE SYNONYM, CREATE DATABASE LINK
TO netmax_bdd;
