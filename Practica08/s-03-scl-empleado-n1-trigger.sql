-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        03/08/2021
-- @Descripción:  Definición del trigger para las operaciones DML en
--                empleado, sitio 1

CREATE OR REPLACE TRIGGER t_dml_empleado
INSTEAD OF INSERT OR UPDATE OR DELETE ON empleado
DECLARE
BEGIN
  CASE
    WHEN INSERTING THEN
      --Se valida la primer letra del RFC
      IF SUBSTR(:new.rfc, 1, 1) BETWEEN 'A' AND 'M' THEN
        --Se realiza una inserción local
        INSERT INTO empleado_2(empleado_id, nombre, ap_paterno, ap_materno,
          rfc, email, jefe_id)
        VALUES (:new.empleado_id, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.rfc, :new.email, :new.jefe_id);
      ELSIF SUBSTR(:new.rfc, 1, 1) BETWEEN 'N' AND 'Z' THEN
        --Se realiza una inserción remota
        INSERT INTO empleado_3(empleado_id, nombre, ap_paterno, ap_materno,
          rfc, email, jefe_id)
        VALUES (:new.empleado_id, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.rfc, :new.email, :new.jefe_id);
      ELSE
        --Se lanza una excepción por rfc incorrecto
        raise_application_error(-20001,
          'Valor incorrecto para el campo rfc: '
          || :new.rfc
          || '. El primer caracter debe ser alfabetico');
      END IF;

      --Se inserta el binario en una tabla temporal
      INSERT INTO t_empleado_insert(empleado_id, foto, num_cuenta)
      VALUES (:new.empleado_id, :new.foto, :new.num_cuenta);
      --Se insera en el sitio remoto usando la tabla temporal
      INSERT INTO empleado_1
        SELECT * FROM t_empleado_insert
        WHERE empleado_id = :new.empleado_id;
      --Se limpia la tabla temporal
      DELETE FROM t_empleado_insert
      WHERE empleado_id = :new.empleado_id;

    WHEN UPDATING THEN
      --Se levanta una excepción por operación no soportada
      raise_application_error(-20002,
        'La operación update no se encuentra soportada');

    WHEN DELETING THEN
      --Se valida la primer letra del RFC
      IF SUBSTR(:old.rfc, 1, 1) BETWEEN 'A' AND 'M' THEN
        --Se borra el registro en sclbdd_s1
        DELETE FROM empleado_2 WHERE empleado_id = :old.empleado_id;
      ELSIF SUBSTR(:old.rfc, 1, 1) BETWEEN 'N' AND 'Z' THEN
        --Se borra el registro en sclbdd_s2
        DELETE FROM empleado_3 WHERE empleado_id = :old.empleado_id;
      ELSE
        --Se lanza una excepción por rfc incorrecto
        raise_application_error(-20001,
          'Valor incorrecto para el campo rfc: '
          || :old.rfc
          || '. El primer caracter debe ser alfabetico');
      END IF;
      --Se elimina el dato binario
      DELETE FROM empleado_1 WHERE empleado_id = :old.empleado_id;
  END CASE;
END;
/
