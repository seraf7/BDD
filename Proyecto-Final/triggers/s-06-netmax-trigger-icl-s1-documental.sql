-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   14/08/2021
-- @Descripción:      Trigger para DOCUMENTAL en iclbd_s1

CREATE OR REPLACE TRIGGER t_dml_documental
  INSTEAD OF INSERT OR UPDATE OR DELETE ON documental
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
        INSERT INTO documental_f2(programa_id, tematica, duracion,
          trailer, pais_id)
        VALUES (:new.programa_id, :new.tematica, :new.duracion,
          :new.trailer, :new.pais_id);
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f1
        WHERE programa_id = :new.programa_id;

        IF v_count > 0 THEN
          -- Inserción en fragmento 1
          -- Iserta BLOB en tabla temporal
          INSERT INTO ti_documental_1(programa_id, trailer)
          VALUES (:new.programa_id, :new.trailer);
          -- Inserción en fragmento 1
          INSERT INTO documental_f1
            SELECT t1.programa_id, :new.tematica, :new.duracion, t1.trailer,
              :new.pais_id
            FROM ti_documental_1 t1
            WHERE programa_id = :new.programa_id;
          -- Se limpia la tabla temporal
          DELETE FROM ti_documental_1
          WHERE programa_id = :new.programa_id;
        ELSE
          SELECT COUNT(*) INTO v_count
          FROM programa_f3
          WHERE programa_id = :new.programa_id;

          IF v_count > 0 THEN
            -- Inserción en fragmento 3
            -- Iserta BLOB en tabla temporal
            INSERT INTO ti_documental_3(programa_id, trailer)
            VALUES (:new.programa_id, :new.trailer);
            -- Inserción en fragmento 3
            INSERT INTO documental_f3
              SELECT t3.programa_id, :new.tematica, :new.duracion, t3.trailer,
                :new.pais_id
              FROM ti_documental_3 t3
              WHERE programa_id = :new.programa_id;
            -- Se limpia la tabla temporal
            DELETE FROM ti_documental_3
            WHERE programa_id = :new.programa_id;
          ELSE
            raise_application_error(-20020,
              'Error de integridad para el campo programa_id: '
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
      FROM programa_f1
      WHERE programa_id = :new.programa_id;

      IF v_count > 0 THEN
        -- Borrado local
        DELETE FROM documental_f1 WHERE programa_id = :old.programa_id;
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f2
        WHERE programa_id = :new.programa_id;

        IF v_count > 0 THEN
          -- Borrado en fragmento 2
          DELETE FROM documental_f2 WHERE programa_id = :old.programa_id;
        ELSE
          SELECT COUNT(*) INTO v_count
          FROM programa_f3
          WHERE programa_id = :new.programa_id;

          IF v_count > 0 THEN
            -- Borrado en fragmento 3
            DELETE FROM documental_f3 WHERE programa_id = :old.programa_id;
          ELSE
            raise_application_error(-20020,
              'Error de integridad para el campo programa_id: '
              || :new.programa_id
              || '. No se encontró el registro padre');
          END IF;
        END IF;
      END IF;
  END CASE;
END;
/
SHOW ERRORS;
