-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   08/08/2021
-- @Descripción:      Aplicación de operaciones DML y consulta de los mlogs

PROMPT Conectando al sitio master...
CONNECT sclbdd_s1_master/serafin@sclbdd_s1

PROMPT Información de tablas referenciadas...
-- Consulta de la vistas materializadas que referencian tablas locales
SELECT r.mview_id,r.owner,r.name,r.mview_site,
  r.can_use_log,r.refresh_method,
  v.master,v.mview_last_refresh_time, l.log_table
FROM user_registered_mviews r
JOIN user_base_table_mviews v
ON r.mview_id = v.mview_id
LEFT JOIN user_mview_logs l
ON l.master = v.master
ORDER BY r.mview_id;

-- operaciones DML
-- Limpieza de datos
DELETE FROM auto WHERE cliente_id = 101;

-- Inserción de una nueva agencia
INSERT INTO agencia(agencia_id, nombre, clave, agencia_anexa_id)
VALUES (501, 'Cartoon', 'PL-737-A', null);

-- Inserción de un nuevo auto
INSERT INTO auto(auto_id, marca, modelo, anio, num_serie, tipo, precio,
  descuento, foto, fecha_status, status_auto_id, agencia_id, cliente_id)
VALUES (3001, 'Renault', 'Kangoo', 2004, 'HNA014936SZIKN822616', 'P', 64253.92,
  null, empty_blob(), to_date('2000-01-01', 'yyyy-mm-dd'), 1, 501, 12);

-- Actualización de un auto
UPDATE auto SET tipo = 'C' WHERE auto_id = 20;
-- Actualización de un cliente
UPDATE cliente SET email = 'zaske_4@hotmail.com' WHERE cliente_id = 10;

COMMIT;

--Consulta de cambios pendientes
PROMPT Consultando cambios pendientes en mlogs...
-- Consulta de cambios pendientes en cliente
SELECT cliente_id, snaptime$$, dmltype$$ FROM mlog$_cliente;

-- Consulta de cambios pendientes en agencia
SELECT agencia_id, clave, snaptime$$, dmltype$$ FROM mlog$_agencia;

-- Consulta de cambios pendientes en auto
SELECT auto_id, tipo, cliente_id, agencia_id,
  snaptime$$, dmltype$$
FROM mlog$_auto;
