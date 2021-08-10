-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Carga de datos en las tablas creadas y verificación de
--                    su localización

-- Inserción de registros, uno para cada partición de agencia
INSERT INTO agencia (agencia_id, nombre, clave, agencia_anexa_id)
VALUES (1, 'Ronstring', 'BF-067-N', null);
INSERT INTO agencia (agencia_id, nombre, clave, agencia_anexa_id)
VALUES (2, 'Lotstring', 'FJ-044-I', null);
INSERT INTO agencia (agencia_id, nombre, clave, agencia_anexa_id)
VALUES (3, 'Gembucket', 'ML-081-Q', null);
INSERT INTO agencia (agencia_id, nombre, clave, agencia_anexa_id)
VALUES (4, 'Tresom', 'RI-951-L', 2);
INSERT INTO agencia (agencia_id, nombre, clave, agencia_anexa_id)
VALUES (5, 'Bytecard', 'YB-193-U', null);

-- Consulta de los registros de cada fragmento de agencia
SELECT a.*, 'agencia_p1_ae' AS nombre_particion
FROM agencia PARTITION(agencia_p1_ae) a
UNION ALL
SELECT a.*, 'agencia_p2_fj' AS nombre_particion
FROM agencia PARTITION(agencia_p2_fj) a
UNION ALL
SELECT a.*, 'agencia_p3_ko' AS nombre_particion
FROM agencia PARTITION(agencia_p3_ko) a
UNION ALL
SELECT a.*, 'agencia_p4_pt' AS nombre_particion
FROM agencia PARTITION(agencia_p4_pt) a
UNION ALL
SELECT a.*, 'agencia_p5_uz' AS nombre_particion
FROM agencia PARTITION(agencia_p5_uz) a;


-- Inserción de cliente
INSERT INTO cliente (cliente_id, nombre, ap_paterno, ap_materno,
  num_identificacion, email)
VALUES (1, 'Sonia', 'Newvell', 'Smithin', 'QDM051177QWXSF0268',
  'ssmithin0@psu.edu');
INSERT INTO cliente (cliente_id, nombre, ap_paterno, ap_materno,
  num_identificacion, email)
VALUES (2, 'Gradeigh', 'Stamper', 'Risborough', 'KFA898352XPGFT0367',
  'grisborough1@scientificamerican.com');
INSERT INTO cliente (cliente_id, nombre, ap_paterno, ap_materno,
  num_identificacion, email)
VALUES (3, 'Cecil', 'Rodolico', 'Crotty', 'WXO703709FXQWH8409',
  'ccrotty2@wikipedia.org');
-- Inserción de orden_compra
INSERT INTO orden_compra (orden_compra_id, fecha_compra, num_cuenta_banco,
  cliente_id)
VALUES (1, to_date('2010-01-01', 'yyyy-mm-dd'),
  'MU05 NHJR 2456 7770 2077 8301 462H FC', 1);
INSERT INTO orden_compra (orden_compra_id, fecha_compra, num_cuenta_banco,
  cliente_id)
VALUES (2, to_date('2015-06-01', 'yyyy-mm-dd'),
  'FR89 6559 6570 18IR EW3U P0RT B44', 2);
INSERT INTO orden_compra (orden_compra_id, fecha_compra, num_cuenta_banco,
  cliente_id)
VALUES (3, to_date('2019-01-20', 'yyyy-mm-dd'),
  'VG52 FRQC 8477 9187 2227 5074', 3);

-- Consulta para comprobar asignación de clientes
SELECT C.*, 'cliente_p1' AS nombre_particion
FROM cliente PARTITION(cliente_p1) C
UNION ALL
SELECT C.*, 'cliente_p2' AS nombre_particion
FROM cliente PARTITION(cliente_p2) C
UNION ALL
SELECT C.*, 'cliente_p3' AS nombre_particion
FROM cliente PARTITION(cliente_p3) C;

-- Consulta para comprobar asignación de orden_compra
SELECT C.*, 'cliente_p1' AS nombre_particion
FROM orden_compra PARTITION(cliente_p1) C
UNION ALL
SELECT C.*, 'cliente_p2' AS nombre_particion
FROM orden_compra PARTITION(cliente_p2) C
UNION ALL
SELECT C.*, 'cliente_p3' AS nombre_particion
FROM orden_compra PARTITION(cliente_p3) C;

-- Inserción de pago_auto
-- Registros para generar particiones
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (1, 1, to_date('2010-07-12', 'yyyy-mm-dd'), '10472.85');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (2, 1, to_date('2011-01-01', 'yyyy-mm-dd'), '10914.30');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (3, 1, to_date('2011-08-28', 'yyyy-mm-dd'), '9844.61');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (1, 2, to_date('2012-01-15', 'yyyy-mm-dd'), '13661.21');
-- Registros para ubicarse en subparticiones
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (2, 2, to_date('2011-01-28', 'yyyy-mm-dd'), '10142.52');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (2, 8, to_date('2011-02-10', 'yyyy-mm-dd'), '4128.68');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (2, 15, to_date('2011-03-19', 'yyyy-mm-dd'), '6854.70');
INSERT INTO PAGO_AUTO (orden_compra_id, num_pago, fecha_pago, importe)
VALUES (2, 19, to_date('2011-04-01', 'yyyy-mm-dd'), '9324.70');


-- Carga de los status
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (1, 'EN TRANSITO', 'EN CAMINO A LA AGENCIA');
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (2, 'EN AGENCIA', 'DISPONIBLE EN LA AGENCIA PARA VENTA');
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (3, 'APARTADO', 'EL CLIENTE HA REALIZADO UN DEPOSITO');
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (4, 'VENDIDO', 'EL CARRO SE HA VENDIDO');
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (5, 'DEFECTUOSO', 'AUTOS NUEVOS CON DEFECTOS');
INSERT INTO status_auto (status_auto_id, clave, descripcion)
VALUES (6, 'EN REPARACION', 'PARA AUTOS VENDIDOS EN REPARACION');

-- Carga de autos P
INSERT INTO auto (auto_id, marca, modelo, anio, num_serie, tipo, precio,
  fecha_status, foto, agencia_id, status_auto_id, cliente_id)
VALUES (1, 'Volvo', 'Rapid', 2633, 'HNA014936SZIKN822656', 'P', '675950.79',
  to_date('2000-01-01', 'yyyy-mm-dd'), empty_blob(), 1, 6, 1);
INSERT INTO auto (auto_id, marca, modelo, anio, num_serie, tipo, precio,
  fecha_status, foto, agencia_id, status_auto_id, cliente_id)
VALUES (2, 'Jeep', 'Frv', 9, 'SWM426056XFTMH170374', 'P', '702951.13',
  to_date('2000-01-01', 'yyyy-mm-dd'), empty_blob(), 2, 4, 2);
-- Carga de autos C
INSERT INTO auto (auto_id, marca, modelo, anio, num_serie, tipo, precio,
  fecha_status, foto, agencia_id, status_auto_id, cliente_id)
VALUES (3, 'Daimler', 'I800', 1527, 'JCK091613IVUTP922910', 'C', '435412.44',
  to_date('2000-01-01', 'yyyy-mm-dd'), empty_blob(), 3, 6, 1);
INSERT INTO auto (auto_id, marca, modelo, anio, num_serie, tipo, precio,
  fecha_status, foto, agencia_id, status_auto_id, cliente_id)
VALUES (4, 'Peugeot', 'Jumper', 1956, 'UTI400974HKIJL953210', 'C', '681449.04',
  to_date('2000-01-01', 'yyyy-mm-dd'), empty_blob(), 4, 4, 3);

-- Consulta para comprobar asignación de tipos
SELECT a.auto_id, a.marca, a.tipo, a.agencia_id, a.cliente_id,
  'auto_particular_p1' AS nombre_particion,
FROM auto PARTITION(auto_particular_p1) a
UNION ALL
SELECT a.auto_id, a.marca, a.tipo, a.agencia_id, a.cliente_id,
  'auto_carga_p2' AS nombre_particion,
FROM auto PARTITION(auto_carga_p2) a;

-- Carga de historicos
-- Carga para generar particiones
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (1, to_date('2009-08-01', 'yyyy-mm-dd'), 3, 1);
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (2, to_date('2010-03-07', 'yyyy-mm-dd'), 1, 2);
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (3, to_date('2011-10-21', 'yyyy-mm-dd'), 3, 3);
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (4, to_date('2012-09-01', 'yyyy-mm-dd'), 6, 4);
-- Carga con ID solicitados
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (10, to_date('2010-01-01', 'yyyy-mm-dd'), 3, 1);
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (100, to_date('2010-08-01', 'yyyy-mm-dd'), 6, 1);
INSERT INTO historico_status_auto (historico_status_id, fecha_status,
  status_auto_id, auto_id)
VALUES (1000, to_date('2010-09-25', 'yyyy-mm-dd'), 2, 1);
