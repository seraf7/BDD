--@Autor:          Jorge A. Rodriguez C
--@Fecha creación:  dd/mm/yyyy
--@Descripción:  Pruebas Operaciones DML

whenever sqlerror exit rollback
set serveroutput on
set verify off

--Modificar las siguientes 5 variables en caso de ser necesario.
--En scripts reales no debeń incluirse passwords. Solo se hace para
--propósitos de pruebas y evitar escribirlos cada vez que se quiera ejecutar 
--el proceso de validación de la práctica (propósitos académicos).

--
-- Nombre del usuario empleado en esta práctica
--
define p_usuario='consultora_bdd'

--
-- Password del usuario empleado en esta práctica
--
define p_usuario_pass='consultora_bdd'

--
-- Password del usuario sys
--
define p_sys_password='system'

--
-- Nombre de la PDB 1
--
define p_pdb1='jrcbdd_s1'

--
-- Nombre de la PDB 2
--
define p_pdb2='jrcbdd_s2'


--- ============= Las siguientes configuraciones ya no requieren cambiarse====

whenever sqlerror exit rollback
set verify off
set feedback off

Prompt =========================================================
Prompt Iniciando validador - Práctica 8
Prompt Presionar Enter si los valores configurados son correctos.
Prompt De lo contario editar el script s-06-validador-main.sql
Prompt O en su defecto proporcionar nuevos valores
Prompt =========================================================

accept p_usuario default '&&p_usuario_pass' prompt 'Proporcionar el nombre de usuario [&&p_usuario]: '
accept p_usuario_pass default '&&p_usuario_pass'  prompt 'Proporcionar el password del usuario &&p_usuario [&&p_usuario_pass]: ' hide
accept p_sys_password default '&&p_sys_password' prompt 'Proporcionar el password de sys [&&p_sys_password]: ' hide
accept p_pdb_1 default '&&p_pdb1' prompt 'Proporcionar el nombre de la pdb 1 : [&&p_pdb1]: '
accept p_pdb_2 default '&&p_pdb2' prompt 'Proporcionar el nombre de la pdb 2 : [&&p_pdb2]: '

define p_script_validador='s-06p-validador-fragmentacion.plb'

Prompt 1. ===> Creando archivos binarios de prueba

--crea archivos binarios de prueba.
!rm -rf /tmp/bdd/p8
!mkdir -p /tmp/bdd/p8
--crea un archivo binario de 1 MB
!dd if=/dev/urandom of=/tmp/bdd/p8/p8-sample-1.bin bs=1 count=0 seek=1M
--crea un archivo binario de 2 MB
!dd if=/dev/urandom of=/tmp/bdd/p8/p8-sample-2.bin bs=1 count=0 seek=2M
--crea un archivo binario de 3 MB
!dd if=/dev/urandom of=/tmp/bdd/p8/p8-sample-3.bin bs=1 count=0 seek=3M

Prompt 2. ===> Creando objeto directory  en &p_pdb_1 llamado bdd_p8_dir

connect sys/&&p_sys_password@&&p_pdb_1 as sysdba
create or replace directory bdd_p8_dir as '/tmp/bdd/p8';
grant read,write on directory bdd_p8_dir to &p_usuario;	

Prompt 3. ===> Creando objeto directory  en &p_pdb_2 llamado bdd_p8_dir

connect sys/&&p_sys_password@&&p_pdb_2 as sysdba
create or replace directory bdd_p8_dir as '/tmp/bdd/p8';
grant read,write on directory bdd_p8_dir to &p_usuario;	

Prompt conectando a &&p_pdb_1
connect &p_usuario/&&p_usuario_pass@&&p_pdb_1
Prompt Validando respuestas en &&p_pdb_1
Prompt Creando procedimientos para validar.
@s-00-funciones-validacion.plb
@&&p_script_validador

Prompt conectando a &&p_pdb_2
connect &&p_usuario/&&p_usuario_pass@&&p_pdb_2
Prompt Validando respuestas en &p_pdb_2
Prompt Creando procedimientos para validar.
@s-00-funciones-validacion.plb
@&&p_script_validador

exit