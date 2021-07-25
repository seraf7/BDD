-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        22/07/2021
-- @Descripción:  Script para comprobar el funcionamiento de la transparencia
--                de fragmentación para datos BLOB

--Conexión al PDB sclbdd_s1
PROMPT Connectando a sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

--Consultas para EMPLEADO
PROMPT EMPLEADO, estrategia 1...
SELECT empleado_id, dbms_lob.getlength(foto) AS longitud
FROM empleado_e1;

PROMPT EMPLEADO, estrategia 2...
SELECT empleado_id, dbms_lob.getlength(foto) AS longitud
FROM empleado_e2;

PROMPT EMPLEADO, uso de sinónimo...
SELECT empleado_id, dbms_lob.getlength(foto) AS longitud
FROM empleado;

--Consultas para PROYECTO_PDF
PROMPT PROYECTO_PDF, estrategia 1...
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf_e1;

PROMPT PROYECTO_PDF, estrategia 2...
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf_e2;

PROMPT PROYECTO_PDF, uso de sinónimo
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf;

--Conexión al PDB sclbdd_s2
PROMPT Connectando a sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

--Consulta para empleado
PROMPT EMPLEADO, uso de la vista (acceso local al dato BLOB)...
SELECT empleado_id, dbms_lob.getlength(foto) AS longitud
FROM empleado;

--Consulta para PROYECTO_PDF
PROMPT PROYECTO_PDF, estrategia 1...
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf_e1;

PROMPT PROYECTO_PDF, estrategia 2...
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf_e2;

PROMPT PROYECTO_PDF, uso de sinónimo
SELECT num_pdf, proyecto_id, dbms_lob.getlength(archivo_pdf) AS longitud
FROM proyecto_pdf;

PROMPT ¡¡Listo!!
EXIT
