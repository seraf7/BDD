-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Archivo de carga inicial en scl-pc

PROMPT Conectando a S1 - sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;
PROMPT Limpiando...
DELETE FROM f_scl_proyecto_pdf_1;
DELETE FROM f_scl_proyecto_1;
DELETE FROM f_scl_oficina_1;
DELETE FROM f_scl_pais_1;
DELETE FROM f_scl_pago_empleado_1;
DELETE FROM f_scl_empleado_2;
-- --Procedimiento para borrar
-- DECLARE
--   -- Declaración de un cursor
--   CURSOR cur_fragmentos IS
--   SELECT table_name FROM user_tables;
-- BEGIN
--   FOR p IN cur_fragmentos LOOP
--     EXECUTE IMMEDIATE 'delete from ' || p.table_name;
--   END LOOP;
-- END;
-- /

PROMPT Cargando datos...
ALTER SESSION SET nls_date_format='dd/mm/yyyy';
-- Inserción en pais
INSERT INTO f_scl_pais_1(pais_id, clave, nombre, region)
VALUES (1, 'MX', 'MEXICO', 'A');

--Inserción en oficina
INSERT INTO f_scl_oficina_1(oficina_id, nombre, pais_id, oficina_anexa_id)
VALUES (1, 'OFICINA 1 DE CDMX', 1, NULL);

-- Inserción en empleado
INSERT INTO f_scl_empleado_2(empleado_id, nombre, ap_paterno, ap_materno, rfc,
  email, jefe_id)
VALUES (1, 'JUAN', 'LOPEZ', 'LARA', 'LOLA890802KML', 'juanq@m.com', NULL);
INSERT INTO f_scl_empleado_2(empleado_id, nombre, ap_paterno, ap_materno, rfc,
  email, jefe_id)
VALUES (2, 'CARLOS', 'BAEZ', 'AGUIRRE', 'BAAGCA982613', 'carlos@m.com', 1);

-- Inserción en proyecto
INSERT INTO f_scl_proyecto_1(proyecto_id, nombre, clave, fecha_inicio,
  fecha_fin, responsable_id, oficina_id)
VALUES (1, 'PROYECTO A', 'P00A', '16/02/2009', '31/12/2012', 1, 1);

-- Inserción en proyecto_pdf
INSERT INTO f_scl_proyecto_pdf_1(num_pdf, proyecto_id, archivo_pdf, tamanio)
VALUES (1, 1, empty_blob(), 2);

-- Inserción en pago_empleado
INSERT INTO f_scl_pago_empleado_1(pago_empleado_id, importe, fecha_pago,
  proyecto_id, empleado_id)
VALUES (1, 1500.45, '01/02/2017', 1, 1);
INSERT INTO f_scl_pago_empleado_1(pago_empleado_id, importe, fecha_pago,
  proyecto_id, empleado_id)
VALUES
(2, 5490.45, '01/08/2017', 3, 2);

--hacer commit al terminar
COMMIT;

PROMPT Conectando a S2 - sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;
PROMPT Limpiando...
DELETE FROM f_scl_proyecto_pdf_2;
DELETE FROM f_scl_proyecto_2;
DELETE FROM f_scl_proyecto_3;
DELETE FROM f_scl_oficina_2;
DELETE FROM f_scl_pais_2;
DELETE FROM f_scl_pago_empleado_2;
DELETE FROM f_scl_empleado_3;
DELETE FROM f_scl_empleado_1;

PROMPT Cargando datos...
ALTER SESSION SET nls_date_format='dd/mm/yyyy';
-- Inserción en pais
INSERT INTO f_scl_pais_2(pais_id, clave, nombre, region)
VALUES (2, 'JAP', 'JAPON', 'B');

--Inserción en oficina
INSERT INTO f_scl_oficina_2(oficina_id, nombre, pais_id, oficina_anexa_id)
VALUES (2, 'OFICINA 1 DE TOKIO', 2, 1);

-- Inserción en empleado
INSERT INTO f_scl_empleado_1(empleado_id, foto, num_cuenta)
VALUES (1, empty_blob(), '09934902');
INSERT INTO f_scl_empleado_1(empleado_id, foto, num_cuenta)
VALUES (2, empty_blob(), '04449321');
INSERT INTO f_scl_empleado_1(empleado_id, foto, num_cuenta)
VALUES (3, empty_blob(), '67382342');

INSERT INTO f_scl_empleado_3(empleado_id, nombre, ap_paterno, ap_materno, rfc,
  email, jefe_id)
VALUES(3, 'EVA', 'ZAVALA', 'CORTES', 'ZACOEV040423', 'eva@m.com', 1);

-- Inserción en proyecto
INSERT INTO f_scl_proyecto_2(proyecto_id, nombre, clave, fecha_inicio,
  fecha_fin, responsable_id, oficina_id)
VALUES (2, 'PROYECTO B', 'P00B', '14/01/2008', '31/12/2013', 2, 2);

INSERT INTO f_scl_proyecto_3(proyecto_id, nombre, clave, fecha_inicio,
  fecha_fin, responsable_id, oficina_id)
VALUES (3, 'PROYECTO C', 'P00C', '06/05/2008', NULL, 3, 2);

-- Inserción en proyecto_pdf
INSERT INTO f_scl_proyecto_pdf_2(num_pdf, proyecto_id, archivo_pdf, tamanio)
VALUES (1, 2, empty_blob(), 4);

-- Inserción en pago_empleado
INSERT INTO f_scl_pago_empleado_2(pago_empleado_id, importe, fecha_pago,
  proyecto_id, empleado_id)
VALUES (3, 760.67, '31/12/2016', 2, 3);

--hacer commit al terminar
COMMIT;
