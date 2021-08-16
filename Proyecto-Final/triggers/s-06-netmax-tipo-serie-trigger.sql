-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Trigger para TIPO_SERIE

CREATE OR REPLACE TRIGGER t_dml_tipo_serie
  INSTEAD OF INSERT OR UPDATE OR DELETE ON tipo_serie
DECLARE
  v_count NUMBER;
BEGIN
  -- Identifica la operación DML realizada
  CASE
    WHEN INSERTING THEN
      v_count := 0;
      -- Replica local
      INSERT INTO tipo_serie_r1(tipo_serie_id, clave, descripcion)
      VALUES (:new.tipo_serie_id, :new.clave, :new.descripcion);
      -- Actualiza cantidad de registros afectados
      v_count := v_count + sql%rowcount;
      -- Replica 2
      INSERT INTO tipo_serie_r2(tipo_serie_id, clave, descripcion)
      VALUES (:new.tipo_serie_id, :new.clave, :new.descripcion);
      v_count := v_count + sql%rowcount;
      -- Replica 3
      INSERT INTO tipo_serie_r3(tipo_serie_id, clave, descripcion)
      VALUES (:new.tipo_serie_id, :new.clave, :new.descripcion);
      v_count := v_count + sql%rowcount;
      -- Replica 4
      INSERT INTO tipo_serie_r4(tipo_serie_id, clave, descripcion)
      VALUES (:new.tipo_serie_id, :new.clave, :new.descripcion);
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
      DELETE FROM tipo_serie_r1 WHERE tipo_serie_id = :old.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica 2
      DELETE FROM tipo_serie_r2 WHERE tipo_serie_id = :old.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica 3
      DELETE FROM tipo_serie_r3 WHERE tipo_serie_id = :old.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica 4
      DELETE FROM tipo_serie_r4 WHERE tipo_serie_id = :old.tipo_serie_id;
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
      UPDATE tipo_serie_r1 SET clave = :new.clave,
        descripcion = :new.descripcion
      WHERE tipo_serie_id = :new.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_serie_r2 SET clave = :new.clave,
        descripcion = :new.descripcion
      WHERE tipo_serie_id = :new.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_serie_r3 SET clave = :new.clave,
        descripcion = :new.descripcion
      WHERE tipo_serie_id = :new.tipo_serie_id;
      v_count := v_count + sql%rowcount;
      -- Replica local
      UPDATE tipo_serie_r4 SET clave = :new.clave,
        descripcion = :new.descripcion
      WHERE tipo_serie_id = :new.tipo_serie_id;
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
