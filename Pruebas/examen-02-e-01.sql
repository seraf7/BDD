-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        11/03/2021
-- @Descripción:  Sentencias e instrucciones de plan de ejecución para el
--                parcial 2

--D
SELECT *
FROM receta R
JOIN medicamento M ON M.med_id = R.med_id
WHERE M.tipo = 'analgesico';

SELECT *
FROM (
  SELECT * FROM medicamento
  WHERE tipo = 'analgesico'
) Q
JOIN receta R ON Q.med_id = R.med_id;


-- Ejerciciio 4
--A)
A1  INDEX UNIQUE SCAN             -->   PAGO_OK
A2  TABLE ACCESS BY INDEX ROW ID  -->   PAGO

--B)
A1  INDEX FAST FULL SCAN          -->   EMPLEADO_PK

--C)
A1  TABLE ACCESS FULL             -->   EMPLEADO

--D)
A1  INDEX RANGE SCAN              -->   PAGO_EMP_ID_IX
A2  TABLE ACCESS BY INDEX ROW ID  -->   PAGO

--E)
A1  TABLE ACCESS FULL             -->   EMPLEADO

--F)
A1  INDEX FAST FULL SCAN          -->   EMPLEADO_CURP_UK

--G)
A1  INDEX FAST FULL SCAN          -->   EMPLEADO_PK
