-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        03/08/2021
-- @Descripción:  Definición del trigger para las operaciones DML en
--                oficina_1, sitio 1

CREATE OR REPLACE TRIGGER t_dml_oficina
INSTEAD OF INSERT OR UPDATE OR DELETE ON oficina
DECLARE
  v_count NUMBER;
BEGIN
  --Detección de la operación DML a realizar
  CASE
    WHEN INSERTING THEN
      --Se verifica que hay correspondencia local de pais
      SELECT COUNT(*) INTO v_count
      FROM pais_1
      WHERE pais_id = :new.pais_id;
      --Validación para realizar inserción local
      IF v_count > 0 THEN
        INSERT INTO oficina_1(oficina_id, nombre, oficina_anexa_id, pais_id)
        VALUES (:new.oficina_id, :new.nombre, :new.oficina_anexa_id,
          :new.pais_id);
      ELSE
        --Verifica que hay correspondencia en el nodo remoto
        SELECT COUNT(*) INTO v_count
        FROM pais_2
        WHERE pais_id = :new.pais_id;
        --Validación para realizar inserción remota
        IF v_count > 0 THEN
          INSERT INTO oficina_2(oficina_id, nombre, oficina_anexa_id, pais_id)
          VALUES (:new.oficina_id, :new.nombre, :new.oficina_anexa_id,
            :new.pais_id);
        ELSE
          --Se levanta una excepción por violación de integridad
          raise_application_error(-20001,
            'Error de integridad para el campo pais_id: '
            || :new.pais_id
            || 'No se encontró el registro padre en los fragmentos');
        END IF;
      END IF;

    WHEN UPDATING THEN
      --Se levanta una excepción por operación no soportada
      raise_application_error(-20002,
        'La operación update no se encuentra soportada');

    WHEN DELETING THEN
      --Se verifica que hay correspondencia local de pais
      SELECT COUNT(*) INTO v_count
      FROM pais_1
      WHERE pais_id = :old.pais_id;
      --Validación para realizar borrado local
      IF v_count > 0 THEN
        DELETE FROM oficina_1 WHERE oficina_id = :old.oficina_id;
      ELSE
        --Verifica que hay correspondencia en nodo remoto
        SELECT COUNT(*) INTO v_count
        FROM pais_2
        WHERE pais_id = :old.pais_id;
        --Validación para realizar borrado remoto
        IF v_count > 0 THEN
          DELETE FROM oficina_2 WHERE oficina_id = :old.oficina_id;
        ELSE
          --Se levanta una excepción por violación de integridad
          raise_application_error(-20001,
            'Error de integridad para el campo pais_id: '
            || :new.pais_id
            || 'No se encontró el registro padre en los fragmentos');
        END IF;
      END IF;
  END CASE;
END;
/
