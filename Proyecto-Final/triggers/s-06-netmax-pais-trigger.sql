-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Trigger para PAIS

CREATE OR REPLACE TRIGGER t_dml_pais
  INSTEAD OF INSERT OR UPDATE OR DELETE ON pais
DECLARE
  v_count NUMBER;
BEGIN
  -- Identifica el tipo de operación DML realizada
  CASE
    WHEN INSERTING THEN
      v_count := 0;
      -- Replica local
      INSERT INTO pais_r1(pais_id, clave, nombre, continente)
      VALUES (:new.pais_id, :new.clave, :new.nombre, :new.continente);
      -- Actualiza cantidad de registros afectados
      v_count := v_count + sql%rowcount;
      -- Replica 2
      INSERT INTO pais_r2(pais_id, clave, nombre, continente)
      VALUES (:new.pais_id, :new.clave, :new.nombre, :new.continente);
      -- Actualiza cantidad de registros afectados
      v_count := v_count + sql%rowcount;
      -- Replica 3
      INSERT INTO pais_r3(pais_id, clave, nombre, continente)
      VALUES (:new.pais_id, :new.clave, :new.nombre, :new.continente);
      -- Actualiza cantidad de registros afectados
      v_count := v_count + sql%rowcount;
      -- Replica 4
      INSERT INTO pais_r4(pais_id, clave, nombre, continente)
      VALUES (:new.pais_id, :new.clave, :new.nombre, :new.continente);
      -- Actualiza cantidad de registros afectados
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
      DELETE FROM pais_r1 WHERE pais_id = :old.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 2
      DELETE FROM pais_r2 WHERE pais_id = :old.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 3
      DELETE FROM pais_r3 WHERE pais_id = :old.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 4
      DELETE FROM pais_r4 WHERE pais_id = :old.pais_id;
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
      UPDATE pais_r1 SET clave = :new.clave,nombre =:new.nombre,
      continente =:new.continente
      WHERE pais_id = :new.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 2
      UPDATE pais_r2 SET clave = :new.clave,nombre =:new.nombre,
      continente =:new.continente
      WHERE pais_id = :new.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 3
      UPDATE pais_r3 SET clave = :new.clave,nombre =:new.nombre,
      continente =:new.continente
      WHERE pais_id = :new.pais_id;
      v_count := v_count + sql%rowcount;
      -- Replica 4
      UPDATE pais_r4 SET clave = :new.clave,nombre =:new.nombre,
      continente =:new.continente
      WHERE pais_id = :new.pais_id;
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
