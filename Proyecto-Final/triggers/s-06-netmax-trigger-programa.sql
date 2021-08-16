-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Trigger para PROGRAMA

CREATE OR REPLACE TRIGGER t_dml_programa
  INSTEAD OF INSERT OR UPDATE OR DELETE ON programa
BEGIN
  -- Identifica la operación DML realizada
  CASE
    WHEN INSERTING THEN
      -- Se comprueba el rango del folio
      IF SUBSTR(:new.folio, 1, 2) BETWEEN 'AA' AND 'MZ' THEN
        -- Inserta en fragmento 1
        INSERT INTO programa_f1(programa_id, folio, nombre, descripcion,
          fecha_status, tipo, status_programa_id)
        VALUES (:new.programa_id, :new.folio, :new.nombre, :new.descripcion,
          :new.fecha_status, :new.tipo, :new.status_programa_id);

      ELSIF (SUBSTR(:new.folio, 1, 2) BETWEEN 'NA' AND 'ZZ')
        AND (:new.status_programa_id BETWEEN 1 AND 3) THEN
        -- Inserta en fragmento 2
        INSERT INTO programa_f2(programa_id, folio, nombre, descripcion,
          fecha_status, tipo, status_programa_id)
        VALUES (:new.programa_id, :new.folio, :new.nombre, :new.descripcion,
          :new.fecha_status, :new.tipo, :new.status_programa_id);

      ELSIF (SUBSTR(:new.folio, 1, 2) BETWEEN 'NA' AND 'ZZ')
        AND (:new.status_programa_id BETWEEN 4 AND 5) THEN
        -- Inserta en fragmento 2
        INSERT INTO programa_f3(programa_id, folio, nombre, descripcion,
          fecha_status, tipo, status_programa_id)
        VALUES (:new.programa_id, :new.folio, :new.nombre, :new.descripcion,
          :new.fecha_status, :new.tipo, :new.status_programa_id);

      ELSE
        -- Se lanza excepción por incumplir criterio de fragmentación
        raise_application_error(-20010,
          'Valor incorrecto en campo folio ('
          || :new.folio
          || ') o campor status_programa_id ('
          || :new.status_programa_id
          || '). Folio debe comenzar con caracteres alfabéticos y '
          || 'status_programa_id debe estar en el rango 1 - 5');
      END IF;

    WHEN UPDATING THEN
      -- Excepción por operación no soportada
      raise_application_error(-20030,
        'La operación UPDATE no está soportada en tablas fragmentadas');

    WHEN DELETING THEN
    -- Se comprueba el rango del folio
    IF SUBSTR(:old.folio, 1, 2) BETWEEN 'AA' AND 'MZ' THEN
      -- Se borra en fragmento 1
      DELETE FROM programa_f1 WHERE programa_id = :old.programa_id;

    ELSIF (SUBSTR(:old.folio, 1, 2) BETWEEN 'NA' AND 'ZZ')
      AND (:old.status_programa_id BETWEEN 1 AND 3) THEN
      -- Se borra en fragmento 2
      DELETE FROM programa_f2 WHERE programa_id = :old.programa_id;

    ELSIF (SUBSTR(:old.folio, 1, 2) BETWEEN 'NA' AND 'ZZ')
      AND (:old.status_programa_id BETWEEN 4 AND 5) THEN
      -- Se borra en fragmento 3
      DELETE FROM programa_f3 WHERE programa_id = :old.programa_id;

    ELSE
      -- Se lanza excepción por incumplir criterio de fragmentación
      raise_application_error(-20010,
        'Valor incorrecto en campo folio ('
        || :new.folio
        || ') o campor status_programa_id ('
        || :new.status_programa_id
        || '). Folio debe comenzar con caracteres alfabéticos y '
        || 'status_programa_id debe estar en el rango 1 - 5');
    END IF;

  END CASE;
END;
/
SHOW ERRORS;
