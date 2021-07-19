-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        17/07/2021
-- @Descripción:  Scripta para preparar la lectura y carga de los archivos PDF
--                Realiza acciones por cada PDB

--Deshace todos los cambios en caso de algún error
whenever sqlerror exit rollback;

--Ruta donde se ubicaran los archivos PDF
DEFINE p_pdf_path = '/tmp/bdd/p06'
SET VERIFY OFF

PROMPT Limpiando y creando directorio en /tmp/bdd/p06...
--Borra todos los archivos del directorio
!rm -rf &p_pdf_path
--Creación de un nuevo directorio
!mkdir -p &p_pdf_path
--Permisos completos para todos los usuarios en el directorio
!chmod 777 /tmp/bdd/p06

--Copia archivos binarios a carpeta creada, se asume que están en el mismo
--directorio que el script
!cp m_archivo_*.pdf &p_pdf_path
--Permisos de lectura para todos los usuarios en los PDFs
!chmod 755 &p_pdf_path/m_archivo_*.pdf

--Conexión al PDB sclbdd_s1
PROMPT Conectando a jrcbdd_s1 como SYS para crear objetos tipo directory...
ACCEPT p_sys_password DEFAULT 'system' PROMPT 'Password de sys [system]: ' HIDE
CONNECT sys@sclbdd_s1/&p_sys_password AS sysdba

Prompt Creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06...
--Creación del directorio virtual
CREATE OR REPLACE DIRECTORY tmp_dir AS '&p_pdf_path';
--Privilegios para leer y escribir
GRANT READ, WRITE ON DIRECTORY tmp_dir TO consultora_bdd;

--Conexión al PDB sclbdd_s2
CONNECT sys@sclbdd_s2/&p_sys_password AS sysdba

Prompt Creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06...
--Creación del directorio virtual
CREATE OR REPLACE DIRECTORY tmp_dir AS '&p_pdf_path';
--Privilegios para leer y escribir
GRANT READ, WRITE ON DIRECTORY tmp_dir TO consultora_bdd;

------------------ Cargando datos en jrcbdd_s1 ----------------------
Prompt Conectando a jrcbdd_s1 con usuario consultora_bdd para cargar binarios...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

--Creación de procedimientos
Prompt Ejecutando procedimientos para hacer import/export de datos BLOB...
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

PROMPT Cargando archivos binarios...
--Ejecución del procedimiento de carga
BEGIN
  carga_blob_en_bd('TMP_DIR', 'm_archivo_4.pdf', 'f_scl_proyecto_pdf_1',
    'archivo_pdf', 'proyecto_id', '1', 'num_pdf', '1');
END;
/

PROMPT Mostrando el tamaño del PDF en BD...
--Obtenido tamaño de los datos cargados
SELECT proyecto_id, num_pdf,
  dbms_lob.getlength(archivo_pdf) AS longitud
FROM f_scl_proyecto_pdf_1;

Prompt Salvando datos BLOB en directorio TMP_DIR...
--Ejecución del procedimiento para exportar
BEGIN
  guarda_blob_en_archivo('TMP_DIR', 'm_export_archivo_4.pdf',
    'f_scl_proyecto_pdf_1', 'archivo_pdf', 'proyecto_id', '1', 'num_pdf', '1');
END;
/

Prompt Mostrando contenido del directorio para validar la existencia del PDF...
--Listar archivos PDF con nombre similar
!ls -l &p_pdf_path/m_export_archivo_*.pdf


------------------ Cargando datos en jrcbdd_s2 ----------------------
Prompt Conectando a jrcbdd_s2 con usuario consultora_bdd para cargar binarios...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

--Creación de procedimientos
Prompt Ejecutando procedimientos para hacer import/export de datos BLOB...
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

PROMPT Cargando archivos binarios...
--Ejecución del procedimiento de carga
BEGIN
  --PDF de proyetos
  carga_blob_en_bd('TMP_DIR', 'm_archivo_5.pdf', 'f_scl_proyecto_pdf_2',
    'archivo_pdf', 'proyecto_id', '2', 'num_pdf', '1');
  --Fotos de empleados
  carga_blob_en_bd('TMP_DIR', 'm_archivo_1.pdf', 'f_scl_empleado_1', 'foto',
    'empleado_id', '1', NULL, NULL);
  carga_blob_en_bd('TMP_DIR', 'm_archivo_2.pdf', 'f_scl_empleado_1', 'foto',
    'empleado_id', '2', NULL, NULL);
  carga_blob_en_bd('TMP_DIR', 'm_archivo_3.pdf', 'f_scl_empleado_1', 'foto',
    'empleado_id', '3', NULL, NULL);
END;
/

PROMPT Mostrando el tamaño del PDF en BD...
--Obtenido tamaño de los datos cargados
SELECT proyecto_id, num_pdf,
  dbms_lob.getlength(archivo_pdf) AS longitud
FROM f_scl_proyecto_pdf_2;

PROMPT Mostrando el tamaño de las fotos en BD...
SELECT empleado_id, dbms_lob.getlength(foto) AS longitud
FROM f_scl_empleado_1;

Prompt Salvando datos BLOB en directorio TMP_DIR...
--Ejecución del procedimiento para exportar
BEGIN
  --PDF de proyectos
  guarda_blob_en_archivo('TMP_DIR', 'm_export_archivo_5.pdf',
    'f_scl_proyecto_pdf_2', 'archivo_pdf', 'proyecto_id', '2', 'num_pdf', '1');
  --Fotos de empleados
  guarda_blob_en_archivo('TMP_DIR', 'm_export_archivo_1.pdf',
    'f_scl_empleado_1', 'foto', 'empleado_id', '1', NULL, NULL);
  guarda_blob_en_archivo('TMP_DIR', 'm_export_archivo_2.pdf',
    'f_scl_empleado_1', 'foto', 'empleado_id', '2', NULL, NULL);
  guarda_blob_en_archivo('TMP_DIR', 'm_export_archivo_3.pdf',
    'f_scl_empleado_1', 'foto', 'empleado_id', '3', NULL, NULL);
END;
/

Prompt Mostrando contenido del directorio para validar existencia de binarios...
--Listar archivos PDF con nombre similar
!ls -l &p_pdf_path/m_export_archivo_*.pdf

PROMPT ¡¡Listo!!
DISCONNECT
