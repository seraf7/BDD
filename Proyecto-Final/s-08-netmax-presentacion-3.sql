-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   15/08/2021
-- @Descripción:      Archivo de carga inicial - fragmentos

CLEAR SCREEN
--Para visualizar export NLS_LANG=SPANISH_SPAIN.WE8ISO8859P1

PROMPT ======================================
PROMPT Preparando carga de Datos
PROMPT ======================================
PROMPT => Seleccionar la PDB LOCAL para insertar datos
PROMPT => Para seleccionar una PDB remota, asegurarse que los archivos existen.
CONNECT netmax_bdd/netmax_bdd@&pdb

PROMPT Personalizando el formato de fechas
ALTER SESSION SET nls_date_format='yyyy-mm-dd hh24:mi:ss';
PROMPT => Al ocurrir un error se saldrá del programa y se hará rollback
WHENEVER SQLERROR EXIT ROLLBACK
PAUSE => Presionar Enter para Iniciar con la extracción de datos binarios, Ctrl-C para cancelar
--Invoca a un shell script para realizar la extracción y copia de archivos
!sh s-08-netmax-presentacion-3.sh

PROMPT ==================================================
PROMPT ¿ Listo para Iniciar con la carga ?
PROMPT ==================================================
PAUSE => Presionar Enter para Iniciar, Ctrl-C para cancelar
PROMPT => Realizando limpieza inicial ....
set feedback off

PROMPT Eliminando datos de PLAYLIST
DELETE FROM playlist;
PROMPT Eliminando datos de USUARIO
DELETE FROM usuario;
PROMPT Eliminando datos de SERIE
DELETE FROM serie;
PROMPT Eliminando datos de PELICULA
DELETE FROM pelicula;
PROMPT Eliminando datos de DOCUMENTAL
DELETE FROM documental;
PROMPT Eliminando datos de HISTORICO
DELETE FROM historico_status_programa;
PROMPT Eliminando datos de ARCHIVO_PROGRAMA
DELETE FROM archivo_programa;
PROMPT Eliminando datos de PROGRAMA
DELETE FROM programa;
PROMPT Eliminando datos de PAIS
DELETE FROM pais;
PROMPT Eliminando datos de TIPO_CUENTA
DELETE FROM tipo_cuenta;
PROMPT Eliminando datos de TIPO_SERIE
DELETE FROM tipo_serie;

PROMPT => Realizando Carga de datos ....
PROMPT Cargando PAIS
@carga-inicial/netmax-carga-inicial-pais.sql

PROMPT Cargando TIPO_SERIE
@carga-inicial/netmax-carga-inicial-tipo-serie.sql

PROMPT Cargando TIPO_CUENTA
@carga-inicial/netmax-carga-inicial-tipo-cuenta.sql

PROMPT Cargando USUARIO
@carga-inicial/netmax-carga-inicial-usuario.sql

PROMPT Cargando PROGRAMA (DOCUMENTAL)
@carga-inicial/netmax-carga-inicial-programa-documental.sql

PROMPT Cargando PROGRAMA (PELICULA)
@carga-inicial/netmax-carga-inicial-programa-pelicula.sql

PROMPT Cargando PROGRAMA (SERIE)
@carga-inicial/netmax-carga-inicial-programa-serie.sql

PROMPT Cargando HISTORICO_STATUS_PROGRAMA
@carga-inicial/netmax-carga-inicial-historico-status-prog.sql

PROMPT Cargando DOCUMENTAL (con datos BLOB)
--@carga-inicial/netmax-carga-inicial-documental-empty-blob.sql
@carga-inicial/netmax-carga-inicial-documental.sql

PROMPT Cargando SERIE
@carga-inicial/netmax-carga-inicial-serie.sql

PROMPT Cargando PELICULA
@carga-inicial/netmax-carga-inicial-pelicula.sql

PROMPT Cargando PLAYLIST
@carga-inicial/netmax-carga-inicial-playlist.sql

PROMPT cargando ARCHIVO_PROGRAMA (con datos BLOB)
--@carga-inicial/netmax-carga-inicial-archivo-programa-empty-blob.sql
@carga-inicial/netmax-carga-inicial-archivo-programa.sql


PROMPT Carga de datos replicados exitosa, haciendo commit!.
COMMIT;
EXIT
