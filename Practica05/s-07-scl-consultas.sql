-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/06/2021
-- @Descripción:  Script ecargado de realizar el conteo de registros en cada
--                tabla de cada PDB

PROMPT Conectando a S1 - sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Realizando conteo de registros...
SET LINESIZE window

SELECT * FROM
  (SELECT COUNT(*) AS pais_1 FROM f_scl_pais_1),
  (SELECT COUNT(*) AS oficina_1 FROM f_scl_oficina_1),
  (SELECT COUNT(*) AS empleado_2 FROM f_scl_empleado_2),
  (SELECT COUNT(*) AS proyecto_1 FROM f_scl_proyecto_1),
  (SELECT COUNT(*) AS proyecto_pdf_1 FROM f_scl_proyecto_pdf_1),
  (SELECT COUNT(*) AS pago_empleado_1 FROM f_scl_pago_empleado_1);

PROMPT Conectando a S2 - sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

PROMPT Realizando conteo de registros...
SET LINESIZE window

SELECT * FROM
  (SELECT COUNT(*) AS pais_2 FROM f_scl_pais_2),
  (SELECT COUNT(*) AS oficina_2 FROM f_scl_oficina_2),
  (SELECT COUNT(*) AS empleado_1 FROM f_scl_empleado_1),
  (SELECT COUNT(*) AS empleado_3 FROM f_scl_empleado_3),
  (SELECT COUNT(*) AS proyecto_2 FROM f_scl_proyecto_2),
  (SELECT COUNT(*) AS proyecto_3 FROM f_scl_proyecto_3),
  (SELECT COUNT(*) AS proyecto_pdf_2 FROM f_scl_proyecto_pdf_2),
  (SELECT COUNT(*) AS pago_empleado_2 FROM f_scl_pago_empleado_2);
