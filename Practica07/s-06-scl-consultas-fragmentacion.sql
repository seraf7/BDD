-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        22/07/2021
-- @Descripción:  Script para comprobar el funcionamiento de la transparencia
--                de fragmentación

--Conteo de registros en el PDB sclbdd_s1
PROMPT Connectando a sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Realizando conteo de registros...
SELECT * FROM
  (SELECT COUNT(*) AS pais FROM pais),
  (SELECT COUNT(*) AS oficina FROM oficina),
  (SELECT COUNT(*) AS proyecto FROM proyecto),
  (SELECT COUNT(*) AS proyecto_pdf FROM proyecto_pdf),
  (SELECT COUNT(*) AS empleado FROM empleado),
  (SELECT COUNT(*) AS pago_empleado FROM pago_empleado);

--Conteo de registros en el PDB sclbdd_s2
PROMPT Connectando a sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

PROMPT Realizando conteo de registros...
SELECT * FROM
  (SELECT COUNT(*) AS pais FROM pais),
  (SELECT COUNT(*) AS oficina FROM oficina),
  (SELECT COUNT(*) AS proyecto FROM proyecto),
  (SELECT COUNT(*) AS proyecto_pdf FROM proyecto_pdf),
  (SELECT COUNT(*) AS empleado FROM empleado),
  (SELECT COUNT(*) AS pago_empleado FROM pago_empleado);

PROMPT ¡¡Listo!!
EXIT
