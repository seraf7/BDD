-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        21/07/2021
-- @Descripción:  Script para definir la creación de vistas

--Definición de la vista PAIS
CREATE OR REPLACE VIEW pais AS
  SELECT pais_id, clave, nombre, region
  FROM pais_1
  UNION ALL
  SELECT pais_id, clave, nombre, region
  FROM pais_2;

--Definición de la vista OFICINA
CREATE OR REPLACE VIEW oficina AS
  SELECT oficina_id, nombre, oficina_anexa_id, pais_id
  FROM oficina_1
  UNION ALL
  SELECT oficina_id, nombre, oficina_anexa_id, pais_id
  FROM oficina_2;

--Definición de la vista PROYECTO
CREATE OR REPLACE VIEW proyecto AS
  SELECT proyecto_id, nombre, clave, fecha_inicio, fecha_fin,
    responsable_id, oficina_id
  FROM proyecto_1
  UNION ALL
  SELECT proyecto_id, nombre, clave, fecha_inicio, fecha_fin,
    responsable_id, oficina_id
  FROM proyecto_2
  UNION ALL
  SELECT proyecto_id, nombre, clave, fecha_inicio, fecha_fin,
    responsable_id, oficina_id
  FROM proyecto_3;

--Definición de la vista PAGO_EMPLEADO
CREATE OR REPLACE VIEW pago_empleado AS
  SELECT pago_empleado_id, importe, fecha_pago, proyecto_id, empleado_id
  FROM pago_empleado_1
  UNION ALL
  SELECT pago_empleado_id, importe, fecha_pago, proyecto_id, empleado_id
  FROM pago_empleado_2;

PROMPT ¡¡Listo!!
EXIT
