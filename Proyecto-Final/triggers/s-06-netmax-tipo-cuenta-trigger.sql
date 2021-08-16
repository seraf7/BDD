-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Trigger para TIPO_CUENTA

CREATE OR REPLACE TRIGGER t_dml_tipo_cuenta
  INSTEAD OF INSERT OR UPDATE OR DELETE ON tipo_cuenta
DECLARE
  v_count NUMBER;
BEGIN
  -- Identifica la operación DML realizada
  CASE
    WHEN INSERTING THEN
      v_count := 0;
      -- Replica local
      INSERT INTO tipo_cuenta_r1(tipo_cuenta_id, clave,
        descripcion, costo_mensual)
      VALUES (:new.tipo_cuenta_id, :new.clave,
        :new.descripcion, :new.costo_mensual);
      -- Actualiza cantidad de registros afectados
      v_count := v_count + sql%rowcount;
      -- Replica 2
      INSERT INTO tipo_cuenta_r2(tipo_cuenta_id, clave,
        descripcion, costo_mensual)
      VALUES (:new.tipo_cuenta_id, :new.clave,
        :new.descripcion, :new.costo_mensual);
      v_count := v_count + sql%rowcount;
      -- Replica 3
      INSERT INTO tipo_cuenta_r3(tipo_cuenta_id, clave,
        descripcion, costo_mensual)
      VALUES (:new.tipo_cuenta_id, :new.clave,
        :new.descripcion, :new.costo_mensual);
      v_count := v_count + sql%rowcount;
      -- Replica 4
      INSERT INTO tipo_cuenta_r4(tipo_cuenta_id, clave,
        descripcion, costo_mensual)
      VALUES (:new.tipo_cuenta_id, :new.clave,
        :new.descripcion, :new.costo_mensual);
      v_count := v_count + sql%rowcount;

      -- Se valida la cantidad de registros afectados
      IF v_count <> 4 THEN
        raise_application_error(-20040,
          'Número incorrecto de registros insertados en tabla replicada: '
          || v_count);
      END IF;

    WHEN DELETING THEN
      v_count := 0;
      -- Replica local
      DELETE FROM tipo_cuenta_r1 WHERE tipo_cuenta_id = :old.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica 2
      DELETE FROM tipo_cuenta_r2 WHERE tipo_cuenta_id = :old.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica 3
      DELETE FROM tipo_cuenta_r3 WHERE tipo_cuenta_id = :old.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica 4
      DELETE FROM tipo_cuenta_r4 WHERE tipo_cuenta_id = :old.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;

      -- Se valida la cantidad de registros afectados
      IF v_count <> 4 THEN
        raise_application_error(-20040,
          'Número incorrecto de registros insertados en tabla replicada: '
          || v_count);
      END IF;

    WHEN UPDATING THEN
      v_count := 0;
      -- Replica local
      UPDATE tipo_cuenta_r1 SET clave = :new.clave,
        descripcion = :new.descripcion, costo_mensual = :new.costo_mensual
      WHERE tipo_cuenta_id = :new.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_cuenta_r2 SET clave = :new.clave,
        descripcion = :new.descripcion, costo_mensual = :new.costo_mensual
      WHERE tipo_cuenta_id = :new.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_cuenta_r3 SET clave = :new.clave,
        descripcion = :new.descripcion, costo_mensual = :new.costo_mensual
      WHERE tipo_cuenta_id = :new.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_cuenta_r4 SET clave = :new.clave,
        descripcion = :new.descripcion, costo_mensual = :new.costo_mensual
      WHERE tipo_cuenta_id = :new.tipo_cuenta_id;
      v_count := v_count + sql%rowcount;

      -- Se valida la cantidad de registros afectados
      IF v_count <> 4 THEN
        raise_application_error(-20040,
          'Número incorrecto de registros insertados en tabla replicada: '
          || v_count);
      END IF;
  END CASE;
END;
/
SHOW ERRORS;
