--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Creación de usuario Practica 12

--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on

--este bloque anómimo valida la existencia del usuario, si existe lo elimina.
declare
	v_count number(1,0);
begin
	select count(*) into v_count
	from dba_users
	where username in ('SCL_REPLICA_BDD');
	if v_count > 0 then
		dbms_output.put_line('Eliminando usuario existente');
		execute immediate 'drop user scl_replica_bdd cascade';
	end if;
end;
/

create user scl_replica_bdd identified by serafin quota unlimited on users;
grant create session, create table, create procedure, create sequence,
  create trigger, create view
to scl_replica_bdd;
