-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   13/08/2021
-- @Descripción:      Trigger para USUARIO

CREATE OR REPLACE TRIGGER t_dml_usuario
  INSTEAD OF INSERT OR UPDATE OR DELETE ON usuario
BEGIN
  -- Se Identifica la operación DML realizada
  CASE
    WHEN INSERTING THEN
      -- Se valida vigencia de la cuenta
      IF :new.vigente = 0 THEN
        -- Inserta en el fragmento 2
        INSERT INTO usuario_f2(usuario_id, email, nombre, ap_paterno,
          ap_materno, fecha_ingreso, fecha_cuenta_fin, vigente, tipo_cuenta_id)
        VALUES (:new.usuario_id, :new.email, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.fecha_ingreso, :new.fecha_cuenta_fin,
          :new.vigente, :new.tipo_cuenta_id);

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 1 THEN
        -- Inserta en el fragmento 3
        INSERT INTO usuario_f3(usuario_id, email, nombre, ap_paterno,
          ap_materno, fecha_ingreso, fecha_cuenta_fin, vigente, tipo_cuenta_id)
        VALUES (:new.usuario_id, :new.email, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.fecha_ingreso, :new.fecha_cuenta_fin,
          :new.vigente, :new.tipo_cuenta_id);

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 2 THEN
        -- Inserta en el fragmento 4
        INSERT INTO usuario_f4(usuario_id, email, nombre, ap_paterno,
          ap_materno, fecha_ingreso, fecha_cuenta_fin, vigente, tipo_cuenta_id)
        VALUES (:new.usuario_id, :new.email, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.fecha_ingreso, :new.fecha_cuenta_fin,
          :new.vigente, :new.tipo_cuenta_id);

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 3 THEN
        -- Inserta en el fragmento 5
        INSERT INTO usuario_f5(usuario_id, email, nombre, ap_paterno,
          ap_materno, fecha_ingreso, fecha_cuenta_fin, vigente, tipo_cuenta_id)
        VALUES (:new.usuario_id, :new.email, :new.nombre, :new.ap_paterno,
          :new.ap_materno, :new.fecha_ingreso, :new.fecha_cuenta_fin,
          :new.vigente, :new.tipo_cuenta_id);

      ELSE
        -- Se lanza excepción por incumplir criterio de fragmentación
        raise_application_error(-20010,
          'Valor incorrecto en campo vigente ('
          || :new.vigente
          || ') o campor tipo_cuenta_id ('
          || :new.tipo_cuenta_id
          || '). Vigente debe ser 0 o 1.El campo '
          || 'tipo_cuenta_id debe estar en el rango 1 - 3');
      END IF;

      -- Se inserta en el fragmento verttical
      INSERT INTO usuario_f1(usuario_id, password, num_tarjeta)
      VALUES (:new.usuario_id, :new.password, :new.num_tarjeta);

    WHEN UPDATING THEN
      -- Excepción por operación no soportada
      raise_application_error(-20030,
        'La operación UPDATE no está soportada en tablas fragmentadas');

    WHEN DELETING THEN
      -- Se valida vigencia de la cuenta
      IF :new.vigente = 0 THEN
        -- Se borra del fragmento 2
        DELETE FROM usuario_f2 WHERE usuario_id = :old.usuario_id;

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 1 THEN
        -- Se borra del fragmento 3
        DELETE FROM usuario_f3 WHERE usuario_id = :old.usuario_id;

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 2 THEN
        -- Se borra del fragmento 4
        DELETE FROM usuario_f4 WHERE usuario_id = :old.usuario_id;

      ELSIF :new.vigente = 1 AND :new.tipo_cuenta_id = 3 THEN
        -- Se borra del fragmento 5
        DELETE FROM usuario_f5 WHERE usuario_id = :old.usuario_id;

      ELSE
        -- Se lanza excepción por incumplir criterio de fragmentación
        raise_application_error(-20010,
          'Valor incorrecto en campo vigente ('
          || :new.vigente
          || ') o campor tipo_cuenta_id ('
          || :new.tipo_cuenta_id
          || '). Vigente debe ser 0 o 1.El campo '
          || 'tipo_cuenta_id debe estar en el rango 1 - 3');
      END IF;

      -- Se elimina registro del fragmento verttical
      DELETE FROM usuario_f1 WHERE usuario_id = :old.usuario_id;
  END CASE;
END;
/
SHOW ERRORS;
