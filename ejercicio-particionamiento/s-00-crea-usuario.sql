--@Autor:           Humberto Serafín Castillo López
--@Fecha creación:  09/08/2021
--@Descripción:     Creación de usuario para particionamiento

--Conexión como usuario sys
CONNECT sys/system@sclbdd_s1 AS sysdba

--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on

--este bloque anómimo valida la existencia del usuario, si existe lo elimina.
declare
	v_count number(1,0);
begin
	select count(*) into v_count
	from dba_users
	where username in ('SCL_PARTICIONES_BDD');
	if v_count > 0 then
		dbms_output.put_line('Eliminando usuario existente');
		execute immediate 'drop user scl_particiones_bdd cascade';
	end if;
end;
/

-- Crea el nuevo usuario
CREATE USER scl_particiones_bdd IDENTIFIED BY serafin;

-- Asigna privilegios
GRANT CREATE SESSION, CREATE TABLE, CREATE PROCEDURE, CREATE SEQUENCE
TO scl_particiones_bdd;
