-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   14/08/2021
-- @Descripción:      Trigger para SERIE en iclbd_s1

CREATE OR REPLACE TRIGGER t_dml_serie
  INSTEAD OF INSERT OR UPDATE OR DELETE ON serie
DECLARE
  v_count NUMBER;
BEGIN
  CASE
    WHEN INSERTING THEN
    -- Verifica si hay correspondencia local
    SELECT COUNT(*) INTO v_count
    FROM programa_f2
    WHERE programa_id = :new.programa_id;

    IF v_count > 0 THEN
      -- Inserción local
      INSERT INTO serie_f2(programa_id, num_capitulos,
        duracion_capitulo, tipo_serie_id)
      VALUES (:new.programa_id, :new.num_capitulos,
        :new.duracion_capitulo, :new.tipo_serie_id);
    ELSE
      SELECT COUNT(*) INTO v_count
      FROM programa_f1
      WHERE programa_id = :new.programa_id;

      IF v_count > 0 THEN
        -- Inserción en fragmento 1
        INSERT INTO serie_f1(programa_id, num_capitulos,
          duracion_capitulo, tipo_serie_id)
        VALUES (:new.programa_id, :new.num_capitulos,
          :new.duracion_capitulo, :new.tipo_serie_id);
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f3
        WHERE programa_id = :new.programa_id;

        IF v_count > 0 THEN
          -- Inserción en fragmento 3
          INSERT INTO serie_f3(programa_id, num_capitulos,
            duracion_capitulo, tipo_serie_id)
          VALUES (:new.programa_id, :new.num_capitulos,
            :new.duracion_capitulo, :new.tipo_serie_id);
        ELSE
          raise_application_error(-20020,
            'Error de integridar para el campo programa_id: '
            || :new.programa_id
            || '. No se encontró el registro padre');
        END IF;
      END IF;
    END IF;

    WHEN UPDATING THEN
      -- Excepción por operación no soportada
      raise_application_error(-20030,
        'La operación UPDATE no está soportada en tablas fragmentadas');

    WHEN DELETING THEN
      -- Verifica si hay correspondencia local
      SELECT COUNT(*) INTO v_count
      FROM programa_f2
      WHERE programa_id = :old.programa_id;

      IF v_count > 0 THEN
        -- Borrado local
        DELETE FROM serie_f2 WHERE programa_id = :old.programa_id;
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f1
        WHERE programa_id = :old.programa_id;

        IF v_count > 0 THEN
          -- Borrado en fragmento 1
          DELETE FROM serie_f1 WHERE programa_id = :old.programa_id;
        ELSE
          SELECT COUNT(*) INTO v_count
          FROM programa_f3
          WHERE programa_id = :old.programa_id;

          IF v_count > 0 THEN
            -- Borrado en fragmento 3
            DELETE FROM serie_f3 WHERE programa_id = :old.programa_id;
          ELSE
            raise_application_error(-20020,
              'Error de integridar para el campo programa_id: '
              || :old.programa_id
              || '. No se encontró el registro padre');
          END IF;
        END IF;
      END IF;
  END CASE;
END;
/
SHOW ERRORS;
