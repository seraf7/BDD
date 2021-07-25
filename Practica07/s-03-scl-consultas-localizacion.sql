-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        21/07/2021
-- @Descripción:  Script encargado de realizar consultas con sinonimos.
--                El script de puede ejecutar el cualquier PDB.

--Bloque anónimo para realizar el conteo de registros
DECLARE
  v_num_paises NUMBER;
  v_num_oficinas NUMBER;
  v_num_proyectos NUMBER;
  v_num_pdfs NUMBER;
  v_num_empleados NUMBER;
  v_num_pagos NUMBER;
BEGIN
  dbms_output.put_line('Realizando consulta empleando sinónimos');

  --Conteo de paises
  SELECT COUNT(*) INTO v_num_paises
  FROM (
    SELECT pais_id FROM pais_1
    UNION ALL
    SELECT pais_id FROM pais_2
  );

  --Conteo de oficinas
  SELECT COUNT(*) INTO v_num_oficinas
  FROM (
    SELECT oficina_id FROM oficina_1
    UNION ALL
    SELECT oficina_id FROM oficina_2
  );

  --Conteo de proyectos
  SELECT COUNT(*) INTO v_num_proyectos
  FROM (
    SELECT proyecto_id FROM proyecto_1
    UNION ALL
    SELECT proyecto_id FROM proyecto_2
    UNION ALL
    SELECT proyecto_id FROM proyecto_3
  );

  --Conteo de PDFs
  SELECT COUNT(*) INTO v_num_pdfs
  FROM (
    SELECT num_pdf, proyecto_id FROM proyecto_pdf_1
    UNION ALL
    SELECT num_pdf, proyecto_id FROM proyecto_pdf_2
  );

  --Conteo de empleados
  SELECT COUNT(*) INTO v_num_empleados
  FROM (
    SELECT E.empleado_id FROM empleado_1 E
    JOIN (
      SELECT empleado_id FROM empleado_2
      UNION ALL
      SELECT empleado_id FROM empleado_3
    ) Q1 ON Q1.empleado_id = E.empleado_id
  );

  --Conteo de pagos
  SELECT COUNT(*) INTO v_num_pagos
  FROM (
    SELECT pago_empleado_id FROM pago_empleado_1
    UNION ALL
    SELECT pago_empleado_id FROM pago_empleado_2
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
