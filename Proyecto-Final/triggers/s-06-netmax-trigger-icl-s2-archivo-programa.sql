-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   14/08/2021
-- @Descripción:      Trigger para ARCHIVO_PROGRAMA en iclbd_s2

CREATE OR REPLACE TRIGGER t_dml_archivo_programa
  INSTEAD OF INSERT OR UPDATE OR DELETE ON archivo_programa
BEGIN
  CASE
    WHEN INSERTING THEN
      -- Se valida el tamaño del archivo
      IF :new.tamanio > 10 THEN
        -- Inserción local en fragmento 1
        INSERT INTO archivo_programa_f1(num_archivo, programa_id,
          archivo, tamanio)
        VALUES (:new.num_archivo, :new.programa_id, :new.archivo, :new.tamanio);

      ELSIF :new.tamanio BETWEEN 0 AND 10 THEN
        -- Inserción remota en fragmento 2
        -- Inserta BLOB en tabla temporal
        INSERT INTO ti_archivo_programa_2(num_archivo, programa_id, archivo)
        VALUES (:new.num_archivo, :new.programa_id, :new.archivo);
        -- Inserta en el sitio remoto
        INSERT INTO archivo_programa_f2
          SELECT :new.num_archivo, :new.programa_id, t2.archivo, :new.tamanio
          FROM ti_archivo_programa_2 t2
          WHERE num_archivo = :new.num_archivo
          AND programa_id = :new.programa_id;
        -- Limpia tabla temporal
        DELETE FROM ti_archivo_programa_2
        WHERE num_archivo = :new.num_archivo
        AND programa_id = :new.programa_id;

      ELSE
        raise_application_error(-20010,
          'Valor incorrecto para el campo tamanio: '
          || :new.tamanio
          || '. Debe ser un valor positivo');
      END IF;

    WHEN UPDATING THEN
      -- Excepción por operación no soportada
      raise_application_error(-20030,
        'La operación UPDATE no está soportada en tablas fragmentadas');

    WHEN DELETING THEN
      -- Se valida el tamaño del archivo
      IF :old.tamanio > 10 THEN
        -- Borrado local en fragmento 1
        DELETE FROM archivo_programa_f1
        WHERE num_archivo = :old.num_archivo
        AND programa_id = :old.programa_id;

      ELSIF :old.tamanio BETWEEN 0 AND 10 THEN
        -- Borrado remoto en fragmento 2
        DELETE FROM archivo_programa_f2
        WHERE num_archivo = :old.num_archivo
        AND programa_id = :old.programa_id;

      ELSE
        raise_application_error(-20010,
          'Valor incorrecto para el campo tamanio: '
          || :new.tamanio
          || '. Debe ser un valor positivo');
      END IF;
  END CASE;
END;
/
SHOW ERRORS;
