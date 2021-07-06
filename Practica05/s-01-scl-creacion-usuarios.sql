-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        28/06/2021
-- @Descripción:  Script encargado de la creación de los usuarios que para
--                la conexión con los PBD's. Se ejecuta sin hacer loggin

-- Conexión al PDB sclbdd_s1
PROMPT Conectando al PDB sclbdd_s1 como sys...
CONNECT sys@sclbdd_s1 AS sysdba

-- Verifica si el usuario consultora_bdd existe
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'CONSULTORA_BDD';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

-- Creación del usuario
PROMPT Creando al usuario consultora_bdd...
CREATE USER consultora_bdd IDENTIFIED BY consultora_bdd
QUOTA UNLIMITED ON USERS;

-- Asignación de privilegios
PROMPT Asignando privilegios a consultora_bdd...
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE SEQUENCE
TO consultora_bdd;

-- Conexión al PDB sclbdd_s2
PROMPT Conectando al PDB sclbdd_s2 como sys...
CONNECT sys@sclbdd_s2 AS sysdba

-- Verifica si el usuario consultora_bdd existe
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'CONSULTORA_BDD';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra el usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

-- Creación del usuario
PROMPT Creando al usuario consultora_bdd...
CREATE USER consultora_bdd IDENTIFIED BY consultora_bdd
QUOTA UNLIMITED ON USERS;

-- Asignación de privilegios
PROMPT Asignando privilegios a consultora_bdd...
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE SEQUENCE
TO consultora_bdd;

PROMPT ¡¡Listo!!
EXIT
