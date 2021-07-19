-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        16/07/2021
-- @Descripción:  Script encargado de realizar consultas para comprobar ligas

--Conexión a sclbdd_s1
PROMPT Conectando a sclbdd_s1
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Realizando conteo de registros
--Se activa la salida de mensajes
SET SERVEROUTPUT ON

--Bloque anónimo para realizar las consultas
DECLARE
  v_num_paises NUMBER;
  v_num_oficinas NUMBER;
  v_num_proyectos NUMBER;
  v_num_pdfs NUMBER;
  v_num_empleados NUMBER;
  v_num_pagos NUMBER;
BEGIN
  dbms_output.put_line('Realizando consulta mediante ligas');
  --Conteo de paises
  SELECT COUNT(*) AS INTO v_num_paises
  FROM (
    SELECT pais_id FROM f_scl_pais_1
    UNION ALL
    SELECT pais_id FROM f_scl_pais_2@sclbdd_s2.fi.unam
  );

  --Conteo de oficinas
  SELECT COUNT(*) AS INTO v_num_oficinas
  FROM (
    SELECT oficina_id FROM f_scl_oficina_1
    UNION ALL
    SELECT oficina_id FROM f_scl_oficina_2@sclbdd_s2.fi.unam
  );

  --Conteo de proyectos
  SELECT COUNT(*) AS INTO v_num_proyectos
  FROM (
    SELECT proyecto_id FROM f_scl_proyecto_1
    UNION ALL
    SELECT proyecto_id FROM f_scl_proyecto_2@sclbdd_s2.fi.unam
    UNION ALL
    SELECT proyecto_id FROM f_scl_proyecto_3@sclbdd_s2.fi.unam
  );

  --Conteo de PDFs
  SELECT COUNT(*) AS INTO v_num_pdfs
  FROM (
    SELECT num_pdf, proyecto_id
    FROM f_scl_proyecto_pdf_1
    UNION ALL
    SELECT num_pdf, proyecto_id
    FROM f_scl_proyecto_pdf_2@sclbdd_s2.fi.unam
  );

  --Conteo de empleados
  SELECT COUNT(*) AS INTO v_num_empleados
  FROM (
    SELECT E1.empleado_id FROM f_scl_empleado_1@sclbdd_s2.fi.unam E1
    JOIN (
      SELECT empleado_id FROM f_scl_empleado_2
      UNION ALL
      SELECT empleado_id FROM f_scl_empleado_3@sclbdd_s2.fi.unam
    ) Q1 ON Q1.empleado_id = E1.empleado_id
  );

  --Conteo de pagos
  SELECT COUNT(*) AS INTO v_num_pagos
  FROM (
    SELECT pago_empleado_id FROM f_scl_pago_empleado_1
    UNION ALL
    SELECT pago_empleado_id FROM f_scl_pago_empleado_2@sclbdd_s2.fi.unam
  );

  --Impresión de resultados
  dbms_output.put_line('========================================');
  dbms_output.put_line('Resultados del conteo de registros');
  dbms_output.put_line('========================================');
  dbms_output.put_line('Paises:         ' || v_num_paises);
  dbms_output.put_line('Oficinas:       ' || v_num_oficinas);
  dbms_output.put_line('Proyectos:      ' || v_num_proyectos);
  dbms_output.put_line('Proyecto PDF:   ' || v_num_pdfs);
  dbms_output.put_line('Empleados:      ' || v_num_empleados);
  dbms_output.put_line('Pago empleado:  ' || v_num_pagos);
  dbms_output.put_line('========================================');
END;
/

PROMPT ¡¡Listo!!
EXIT
