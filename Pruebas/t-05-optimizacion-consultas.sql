--@Autor:           Humberto Serafín Castillo López
--@Fecha creación:  09/08/2021
--@Descripción:     Ejemplos de optimización de consultas distribuidas

--Consulta original
explain plan
set statement_id ='s1'
for
select a2.auto_id,a2.marca,a2.modelo,ac1.peso_maximo,ac1.volumen,a1.precio
from auto_2 a2, auto_carga_1 ac1, auto_1 a1
where a2.auto_id = ac1.auto_id
and a2.auto_id = a1.auto_id;

select plan_table_output
from table(dbms_xplan.display('PLAN_TABLE','s1','TYPICAL'));

--Consulta con collocated Inline views.
explain plan
set statement_id ='s2' for
select r.auto_id,r.marca,r.modelo,r.peso_maximo,r.volumen,a1.precio
from (
  --Subconsulta para minimizar accesos remotos
  select a2.auto_id,a2.marca,a2.modelo,ac1.peso_maximo,ac1.volumen
  from auto_2 a2, auto_carga_1 ac1
  where a2.auto_id = ac1.auto_id
) r , auto_1 a1
where a1.auto_id = r.auto_id;

-- El plan desplegado es el mismo que en la consulta original debido a que se
-- fusiona la subconsulta r
select plan_table_output
from table(dbms_xplan.display('PLAN_TABLE','s2','TYPICAL'));

-- Consulta optimizada con collocated Inline views.
-- Se indica con no_merge que la subconsulta r no se fusione
explain plan
set statement_id ='s3' for
select /*+no_merge(r)*/
r.auto_id,r.marca,r.modelo,r.peso_maximo,r.volumen,a1.precio
from (
  --Subconsulta para hacer un solo acceso remoto
  select a2.auto_id,a2.marca,a2.modelo,ac1.peso_maximo,ac1.volumen
  from auto_2 a2, auto_carga_1 ac1
  where a2.auto_id = ac1.auto_id
) r , auto_1 a1
where a1.auto_id = r.auto_id;

select plan_table_output
from table(dbms_xplan.display('PLAN_TABLE','s3','TYPICAL'));
