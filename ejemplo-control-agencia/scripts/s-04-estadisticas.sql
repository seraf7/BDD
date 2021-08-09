--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Consulta y recolección de estadisticas

SHOW con_name;
column table_name format a20
Prompt mostrando status de las estadisticas
select table_name,stale_stats
from dba_tab_statistics
where owner ='CONTROL_AGENCIA';

Prompt Recolectando estadisticas
begin
  -- dbms_stats.gather_table_stats, se cambia el procedimientos para usarlo
  -- en todas las tablas
  dbms_stats.gather_schema_stats (
      ownname => 'CONTROL_AGENCIA',
      degree  => 3
  );
end;
/

Prompt mostrando estadisticas despues de la recolección
select table_name,stale_stats
from dba_tab_statistics
where owner ='CONTROL_AGENCIA';

Prompt mostrando detalle de las estadisticas por tabla
select table_name,num_rows,blocks,empty_blocks,avg_row_len,last_analyzed
from dba_tab_statistics
where owner ='MEDICOS';
