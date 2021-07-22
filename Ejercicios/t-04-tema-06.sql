-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        19/07/2021
-- @Descripción:  Programas PL/SQL para la implementación del control pesmista
--                y optimista en transacciones concurrentes

--Instrucción para detener la ejecución del script al detectar algún error
--sin aplicar cambios en la BD
whenever sqlerror exit rollback;

--Conexión como usuario sys
PROMPT Conectando como usuario sys...
CONNECT sys/system@sclbdd_s1 as sysdba

--Verifica si existe el usuario serafin06
DECLARE
  v_count NUMBER;
  v_username VARCHAR2(20) := 'SERAFIN06';
BEGIN
  SELECT COUNT(*) INTO v_count FROM all_users WHERE username=v_username;
  IF v_count > 0 THEN
    --Borra al usuario existente
    EXECUTE IMMEDIATE 'drop user ' || v_username || ' cascade';
  END IF;
END;
/

--Creación de nuevo usuario
PROMPT Creando usuario serafin06...
CREATE USER serafin06 IDENTIFIED BY serafin QUOTA UNLIMITED ON users;

--Se otorgan privilegios
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE
TO serafin06;

--Conexión con el nuevo usuario
CONNECT serafin06/serafin@sclbdd_s1

--Creación de la tabla de prueba
CREATE TABLE prod(
  prod_id NUMBER,
  cantidad NUMBER
);

--Se insertan datos a la tabla
INSERT INTO prod(prod_id, cantidad) VALUES (1, 10);
INSERT INTO prod(prod_id, cantidad) VALUES (2, 20);

PROMPT Creando procedimientos...

--Creación de procedimiento con control pesimista
CREATE OR REPLACE PROCEDURE aumenta_inventario_pesimista(
  --Parámetros de entrada
  v_prod_id NUMBER,
  v_recibido NUMBER
) IS
  --Variables usadas en el procedimiento
  v_cantidad_actual NUMBER;
BEGIN
  --Se obtiene valor actual y se bloquea el registro para otras transacciones
  SELECT cantidad INTO v_cantidad_actual
  FROM prod
  WHERE prod_id = v_prod_id
  FOR UPDATE;

  dbms_output.put_line('Lectura inicial, el producto ' || v_prod_id
  || ' actualmente tiene cantidad de ' || v_cantidad_actual);

  --Se pausa la sesión durante 10s
  dbms_session.sleep(10);

  --Se actualiza el registro
  UPDATE prod
  SET cantidad = v_cantidad_actual + v_recibido
  WHERE prod_id = v_prod_id;

  COMMIT;

  dbms_output.put_line('El producto ' || v_prod_id || ' se ha actualizado');
END;
/

--Muesta errores
SHOW ERRORS;

--Creación de procedimiento con control optimista
CREATE OR REPLACE PROCEDURE aumenta_inventario_optimista(
  --Parámetros de entrada
  v_prod_id NUMBER,
  v_recibido NUMBER
) IS
  --Variables usadas en el procedimiento
  v_cantidad_actual NUMBER;
  v_actualizados NUMBER;
BEGIN
  --Ciclo infinito para reintentar la transacción
  LOOP
    --Se obtiene la cantidad actual
    SELECT cantidad INTO v_cantidad_actual
    FROM prod
    WHERE prod_id = v_prod_id;

    dbms_output.put_line('Lectura inicial, el producto ' || v_prod_id
    || ' actualmente tiene cantidad de ' || v_cantidad_actual);

    --Se pausa la sesión por 5s
    dbms_session.sleep(5);

    --Se actualiza el registro
    UPDATE prod
    SET cantidad = v_cantidad_actual + v_recibido
    WHERE prod_id = v_prod_id
    AND cantidad = v_cantidad_actual;

    --Se obtiene la cantidad de refistros actualizados
    v_actualizados := sql%rowcount;

    --Se valida si se actualizó algún registro
    IF v_actualizados > 0 THEN
      --Termina el ciclo porque se realizó la actualización
      EXIT;
    ELSE
      --Ningún registro actualizado, se vuelve al ciclo para reintentar
      dbms_output.put_line('Se reintentará la actualización');
      NULL;
    END IF;
  END LOOP;
  COMMIT;
  dbms_output.put_line('El producto ' || v_prod_id || ' se ha actualizado');
END;
/

--Muesta errores
SHOW ERRORS;

COMMIT;

PROMPT ¡¡Listo!!

--Para regresar a la configuración original
whenever sqlerror continue none;


---------------Sección de transacciones---------------
--Ejecutar en distintas terminales para simular concurrencia
--Terminal 1
BEGIN
  aumenta_inventario_pesimista(1, 5);
END;
/

--Terminal 2
BEGIN
  aumenta_inventario_pesimista(1, 8);
END;
/

-- Ejecución optimista
-- Terminal 1
BEGIN
  aumenta_inventario_optimista(2, 10);
END;
/

-- Terminal 2
BEGIN
  aumenta_inventario_optimista(2, 5);
END;
/
