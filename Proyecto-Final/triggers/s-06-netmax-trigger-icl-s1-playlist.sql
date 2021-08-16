-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   14/08/2021
-- @Descripción:      Trigger para PLAYLIST en iclbd_s1

CREATE OR REPLACE TRIGGER t_dml_playlist
  INSTEAD OF INSERT OR UPDATE OR DELETE ON playlist
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
        INSERT INTO playlist_f2(playlist_id, calificacion, indice,
          num_reproducciones, programa_id, usuario_id)
        VALUES (:new.playlist_id, :new.calificacion, :new.indice,
          :new.num_reproducciones, :new.programa_id, :new.usuario_id);
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f1
        WHERE programa_id = :new.programa_id;

        IF v_count > 0 THEN
          --Inserción en fragmento 1
          INSERT INTO playlist_f1(playlist_id, calificacion, indice,
            num_reproducciones, programa_id, usuario_id)
          VALUES (:new.playlist_id, :new.calificacion, :new.indice,
            :new.num_reproducciones, :new.programa_id, :new.usuario_id);
        ELSE
          SELECT COUNT(*) INTO v_count
          FROM programa_f3
          WHERE programa_id = :new.programa_id;

          IF v_count > 0 THEN
            -- Inserción en fragmento 3
            INSERT INTO playlist_f3(playlist_id, calificacion, indice,
              num_reproducciones, programa_id, usuario_id)
            VALUES (:new.playlist_id, :new.calificacion, :new.indice,
              :new.num_reproducciones, :new.programa_id, :new.usuario_id);
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
      FROM programa_f2
      WHERE programa_id = :new.programa_id;

      IF v_count > 0 THEN
        -- Borrado local
        DELETE FROM playlist_f2 WHERE playlist_id = :old.playlist_id;
      ELSE
        SELECT COUNT(*) INTO v_count
        FROM programa_f1
        WHERE programa_id = :new.programa_id;

        IF v_count > 0 THEN
          --Borrado en fragmento 1
          DELETE FROM playlist_f1 WHERE playlist_id = :old.playlist_id;
        ELSE
          SELECT COUNT(*) INTO v_count
          FROM programa_f3
          WHERE programa_id = :new.programa_id;

          IF v_count > 0 THEN
            -- Borrado en fragmento 3
            DELETE FROM playlist_f3 WHERE playlist_id = :old.playlist_id;
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
