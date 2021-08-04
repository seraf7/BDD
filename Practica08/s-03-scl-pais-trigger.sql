-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/07/2021
-- @Descripción:  Definición del trigger para las operaciones DML en PAIS

CREATE OR REPLACE TRIGGER t_dml_pais
INSTEAD OF INSERT OR UPDATE OR DELETE ON pais
DECLARE
BEGIN
  --Detección del tipo de operación DML a realizar
  CASE
    WHEN INSERTING THEN
      --Se valida la región del registro
      IF :new.region = 'A' THEN
        --Se inserta registro en el sitio sclbdd_s1
        INSERT INTO pais_1(pais_id, clave, nombre, region)
        VALUES (:new.pais_id, :new.clave, :new.nombre, :new.region);
      ELSIF :new.region = 'B' THEN
        --Se inserta registro en el sitio sclbdd_s2
        INSERT INTO pais_2(pais_id, clave, nombre, region)
        VALUES (:new.pais_id, :new.clave, :new.nombre, :new.region);
      ELSE
        --Se lanza una excepción por región incorrecta
        raise_application_error(20001,
          'Valor incorrecto para el campo region: '
          || :new.region
          || '. Sólo se permiten los valores A, B');
      END IF;

    WHEN UPDATING THEN
      --Valida si el registro se queda en sclbdd_s1
      IF :new.region = 'A' AND :old.region = 'A' THEN
        UPDATE pais_1 SET pais_id = :new.pais_id, clave = :new.clave,
          nombre = :new.nombre, region = :new.region
        WHERE pais_id = :old.pais_id;

      --Valida si el registro debe moverse a sclbdd_s2
      ELSIF :new.region = 'B' AND :old.region = 'A' THEN
        DELETE FROM pais_1 WHERE pais_id = :old.pais_id;
        INSERT INTO pais_2(pais_id, clave, nombre, region)
        VALUES (:new.pais_id, :new.clave, :new.nombre, :new.region);

      --Valida si el registro se queda en sclbdd_s2
      ELSIF :new.region = 'B' AND :old.region = 'B' THEN
        UPDATE pais_2 SET pais_id = :new.pais_id, clave = :new.clave,
          nombre = :new.nombre, region = :new.region
        WHERE pais_id = :old.pais_id;

      --Valida si el registro debe moverse a sclbdd_s1
      ELSIF :new.region = 'A' AND :old.region = 'B' THEN
        DELETE FROM pais_2 WHERE pais_id = :old.pais_id;
        INSERT INTO pais_1(pais_id, clave, nombre, region)
        VALUES (:new.pais_id, :new.clave, :new.nombre, :new.region);
      ELSE
        --Se lanza una excepción por región incorrecta
        raise_application_error(20001,
          'Valor incorrecto para el campo region: '
          || :new.region
          || '. Sólo se permiten los valores A, B');
      END IF;

    WHEN DELETING THEN
      --Se valida la región del registro
      IF :old.region = 'A' THEN
        --Se borra el registro en sclbdd_s1
        DELETE FROM pais_1 WHERE pais_id = :old.pais_id;
      ELSIF :old.region = 'B' THEN
        --Se borra el registro en sclbdd_s2
        DELETE FROM pais_2 WHERE pais_id = :old.pais_id;
      ELSE
        --Se lanza una excepción por región incorrecta
        raise_application_error(-20001,
          'Valor incorrecto para el campo region: '
          || :new.region
          || '. Sólo se permiten los valores A, B');
      END IF;
  END CASE;
END;
/
