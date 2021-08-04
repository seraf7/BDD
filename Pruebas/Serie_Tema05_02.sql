-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        09/07/2021
-- @Descripción:  Consultas correspondientes a los ejercicios de la serie 02
--                Tema 05

--Ejercicio 3
EXPLAIN PLAN FOR
SELECT M.nombre, E.nombre
FROM medico M
JOIN especialidad E ON M.especialidad_id = E.especialidad_id
WHERE E.nombre LIKE 'Neuro%';

SELECT plan_table_output
FROM table(dbms_xplan.display);


-- Ejercicio 4
EXPLAIN PLAN FOR
SELECT M.medicamento_id, M.nombre_generico
FROM medicamento M
JOIN receta R ON M.medicamento_id = R.medicamento_id
WHERE R.dias >= 10 AND R.dias <= 20
AND M.subclave = 'SX002'
AND M.medicamento_id IN (2, 3, 4);

SELECT plan_table_output
FROM table(dbms_xplan.display);

-- Plan de ejecución
NESTED LOOP
  NESTED LOOP
    TABLE ACCESS FULL     RECETA
    INDEX UNIQUE SCAN     MEDICAMENTO_PK
  HASH JOIN
    INDEX UNIQUE SCAN     PACIENTE_SUBCLAVE_UIX
    INDEX FAST FULL SCAN  MEDICAMENTO_NOMBRE_GENERICO_IX
