--@Autor:           Jorge Rodriguez
--@Fecha creación:  dd/mm/yyyy
--@Descripción:     Archivo principal

--si ocurre un error, se hace rollback de los datos y
--se sale de SQL *Plus
whenever  sqlerror exit rollback

Prompt creando usuario control_agencia

Prompt conectando en sclbdd_s1
connect sys/system@sclbdd_s1 as sysdba
@s-01-creacion-usuario.sql

Prompt conectando en sclbdd_s2
connect sys/system@sclbdd_s2 as sysdba
@s-01-creacion-usuario.sql

Prompt conectando en hclbdd_s1
connect sys/system@hclbdd_s1 as sysdba
@s-01-creacion-usuario.sql

Prompt conectando en hclbdd_s2
connect sys/system@hclbdd_s2 as sysdba
@s-01-creacion-usuario.sql


Prompt creando tablas e indices en Fks

Prompt conectando en sclbdd_s1
connect control_agencia/serafin@sclbdd_s1
@s-02-jrcbd-s1-ddl.sql

create index  auto_3_agencia_1_id_ix on f_jrc_auto_3(agencia_id) ;

Prompt conectando en sclbdd_s2
connect control_agencia/serafin@sclbdd_s2
@s-02-jrcbd-s2-ddl.sql

create index  auto_4_agencia_2_id_ix on f_jrc_auto_4(agencia_id) ;

Prompt conectando en hclbdd_s1
connect control_agencia/serafin@hclbdd_s1
@s-02-arcbd-s1-ddl.sql

-- create index auto_3_agencia_1_id_ix on f_jrc_auto_3(agencia_id);

Prompt conectando en hclbdd_s2
connect control_agencia/serafin@hclbdd_s2
@s-02-arcbd-s2-ddl.sql

----------------------------------------------------------
Prompt  creando ligas, sinónimos y vistas

Prompt conectando en sclbdd_s1
connect control_agencia/serafin@sclbdd_s1

--ligas
create database link sclbdd_s2.fi.unam using 'SCLBDD_S2';
create database link hclbdd_s1.fi.unam using 'HCLBDD_S1';
create database link hclbdd_s2.fi.unam using 'HCLBDD_S2';
--sinonimos
create or replace synonym auto_1 for f_jrc_auto_1;
create or replace synonym auto_3 for f_jrc_auto_3;
create or replace synonym auto_4 for f_jrc_auto_4@sclbdd_s2;
create or replace synonym auto_2 for f_arc_auto_2@hclbdd_s2;

create or replace synonym agencia_1 for f_jrc_agencia_1;
create or replace synonym agencia_2 for f_jrc_agencia_2@sclbdd_s2;

create or replace synonym cliente_1 for f_arc_cliente_1@hclbdd_s1;
create or replace synonym cliente_2 for f_arc_cliente_2@hclbdd_s2;
create or replace synonym cliente_3 for f_arc_cliente_3@hclbdd_s1;

create or replace synonym auto_particular_1 for f_jrc_auto_particular_1;
create or replace synonym auto_particular_2 for f_jrc_auto_particular_2@sclbdd_s2;

create or replace synonym auto_carga_1 for f_arc_auto_carga_1@hclbdd_s2;

--vistas
Prompt creando vistas
@s-03-vistas.sql

Prompt conectando en sclbdd_s2
connect control_agencia/serafin@sclbdd_s2

create database link sclbdd_s1.fi.unam using 'SCLBDD_S1';
create database link hclbdd_s1.fi.unam using 'HCLBDD_S1';
create database link hclbdd_s2.fi.unam using 'HCLBDD_S2';
--sinonimos
create or replace synonym auto_1 for f_jrc_auto_1@sclbdd_s1;
create or replace synonym auto_3 for f_jrc_auto_3@sclbdd_s1;
create or replace synonym auto_4 for f_jrc_auto_4;
create or replace synonym auto_2 for f_arc_auto_2@hclbdd_s2;

create or replace synonym agencia_1 for f_jrc_agencia_1@sclbdd_s1;
create or replace synonym agencia_2 for f_jrc_agencia_2;

create or replace synonym cliente_1 for f_arc_cliente_1@hclbdd_s1;
create or replace synonym cliente_2 for f_arc_cliente_2@hclbdd_s2;
create or replace synonym cliente_3 for f_arc_cliente_3@hclbdd_s1;

create or replace synonym auto_particular_1 for f_jrc_auto_particular_1@sclbdd_s1;
create or replace synonym auto_particular_2 for f_jrc_auto_particular_2;

create or replace synonym auto_carga_1 for f_arc_auto_carga_1@hclbdd_s2;

--vistas
Prompt creando vistas
@s-03-vistas.sql

Prompt conectando en hclbdd_s1
connect control_agencia/serafin@hclbdd_s1

create database link sclbdd_s1.fi.unam using 'SCLBDD_S1';
create database link sclbdd_s2.fi.unam using 'SCLBDD_S2';
create database link hclbdd_s2.fi.unam using 'HCLBDD_S2';

--sinonimos
create or replace synonym auto_1 for f_jrc_auto_1@sclbdd_s1;
create or replace synonym auto_3 for f_jrc_auto_3@sclbdd_s1;
create or replace synonym auto_4 for f_jrc_auto_4@sclbdd_s2;
create or replace synonym auto_2 for f_arc_auto_2@hclbdd_s2;

create or replace synonym agencia_1 for f_jrc_agencia_1@sclbdd_s1;
create or replace synonym agencia_2 for f_jrc_agencia_2@sclbdd_s2;

create or replace synonym cliente_1 for f_arc_cliente_1;
create or replace synonym cliente_2 for f_arc_cliente_2@hclbdd_s2;
create or replace synonym cliente_3 for f_arc_cliente_3;

create or replace synonym auto_particular_1 for f_jrc_auto_particular_1@sclbdd_s1;
create or replace synonym auto_particular_2 for f_jrc_auto_particular_2@sclbdd_s2;

create or replace synonym auto_carga_1 for f_arc_auto_carga_1@hclbdd_s2;

--vistas
Prompt creando vistas
@s-03-vistas.sql

Prompt conectando en hclbdd_s2
connect control_agencia/serafin@hclbdd_s2

create database link sclbdd_s1.fi.unam using 'SCLBDD_S1';
create database link sclbdd_s2.fi.unam using 'SCLBDD_S2';
create database link hclbdd_s1.fi.unam using 'HCLBDD_S1';

--sinonimos
create or replace synonym auto_1 for f_jrc_auto_1@sclbdd_s1;
create or replace synonym auto_3 for f_jrc_auto_3@sclbdd_s1;
create or replace synonym auto_4 for f_jrc_auto_4@sclbdd_s2;
create or replace synonym auto_2 for f_arc_auto_2;

create or replace synonym agencia_1 for f_jrc_agencia_1@sclbdd_s1;
create or replace synonym agencia_2 for f_jrc_agencia_2@sclbdd_s2;

create or replace synonym cliente_1 for f_arc_cliente_1@hclbdd_s1;
create or replace synonym cliente_2 for f_arc_cliente_2;
create or replace synonym cliente_3 for f_arc_cliente_3@hclbdd_s1;

create or replace synonym auto_particular_1 for f_jrc_auto_particular_1@sclbdd_s1;
create or replace synonym auto_particular_2 for f_jrc_auto_particular_2@sclbdd_s2;

create or replace synonym auto_carga_1 for f_arc_auto_carga_1;

--vistas
Prompt creando vistas
@s-03-vistas.sql

------------------------------------------------------------------------

Prompt realizando la carga de datos
--sclbdd_s1
Prompt conectando en sclbdd_s1
connect control_agencia/serafin@sclbdd_s1

@carga-inicial/s-03-AUTO_11.sql
@carga-inicial/s-03-AUTO_12.sql
@carga-inicial/s-03-AUTO_13.sql

@carga-inicial/s-03-AGENCIA_1.sql

@carga-inicial/s-03-AUTO_3.sql

@carga-inicial/s-03-AUTO_PARTICULAR_1.sql

Prompt  actualizando estadísticas
connect sys/system@sclbdd_s1 as sysdba
@s-04-estadisticas.sql

--sclbdd_s2
Prompt conectando en sclbdd_s2
connect control_agencia/serafin@sclbdd_s2

@carga-inicial/s-03-AGENCIA_2.sql

@carga-inicial/s-03-AUTO_4.sql

@carga-inicial/s-03-AUTO_PARTICULAR_2.sql

Prompt  actualizando estadísticas
connect sys/system@sclbdd_s2 as sysdba
@s-04-estadisticas.sql

--hclbdd_s1
Prompt conectando en hclbdd_s1
connect control_agencia/serafin@hclbdd_s1

@carga-inicial/s-03-CLIENTE_11.sql
@carga-inicial/s-03-CLIENTE_12.sql
@carga-inicial/s-03-CLIENTE_13.sql

@carga-inicial/s-03-CLIENTE_31.sql
@carga-inicial/s-03-CLIENTE_32.sql

Prompt  actualizando estadísticas
connect sys/system@hclbdd_s1 as sysdba
@s-04-estadisticas.sql

--hclbdd_s2
Prompt conectando en hclbdd_s2
connect control_agencia/serafin@hclbdd_s2

@carga-inicial/s-03-CLIENTE_21.sql
@carga-inicial/s-03-CLIENTE_22.sql

@carga-inicial/s-03-AUTO_2.sql
@carga-inicial/s-03-AUTO_CARGA_1.sql

Prompt  actualizando estadísticas
connect sys/system@hclbdd_s2 as sysdba
@s-04-estadisticas.sql

set define on

Prompt confirmando cambios
commit;

connect control_agencia/serafin@hclbdd_s2

--test
Prompt consultando datos finales
Prompt auto
select count(*) from auto;
Prompt auto_carga
select count(*) from auto_carga;
Prompt auto_particular
select count(*) from auto_particular;
Prompt agencia
select count(*) from agencia;
Prompt cliente
select count(*) from cliente;


--Si se encuentra un error, no se sale de SQL *Plus
--no se hace commit ni rollback, es decir, se
--regresa al estado original.
------------------------------------
whenever sqlerror continue none

Prompt Listo!
