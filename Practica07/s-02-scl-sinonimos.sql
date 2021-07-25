-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        20/07/2021
-- @Descripción:  Creación de sinónimos

--Conexión al PDB sclbdd_s1
PROMPT Conectando a sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Creando sinónimos en sclbdd_s1...

--Sinónimos para fragmentos de PAIS
CREATE OR REPLACE SYNONYM pais_1 FOR f_scl_pais_1;
CREATE OR REPLACE SYNONYM pais_2 FOR f_scl_pais_2@sclbdd_s2.fi.unam;

--Sinónimos para fragmentos de OFICINA
CREATE OR REPLACE SYNONYM oficina_1 FOR f_scl_oficina_1;
CREATE OR REPLACE SYNONYM oficina_2 FOR f_scl_oficina_2@sclbdd_s2.fi.unam;

--Sinónimos para fragmentos de PROYECTO
CREATE OR REPLACE SYNONYM proyecto_1 FOR f_scl_proyecto_1;
CREATE OR REPLACE SYNONYM proyecto_2 FOR f_scl_proyecto_2@sclbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM proyecto_3 FOR f_scl_proyecto_3@sclbdd_s2.fi.unam;

--Sinónimos para fragmentos de PROYECTO_PDF
CREATE OR REPLACE SYNONYM proyecto_pdf_1 FOR f_scl_proyecto_pdf_1;
CREATE OR REPLACE SYNONYM proyecto_pdf_2
  FOR f_scl_proyecto_pdf_2@sclbdd_s2.fi.unam;

--Sinónimos para fragmentos de EMPLEADO
CREATE OR REPLACE SYNONYM empleado_1 FOR f_scl_empleado_1@sclbdd_s2.fi.unam;
CREATE OR REPLACE SYNONYM empleado_2 FOR f_scl_empleado_2;
CREATE OR REPLACE SYNONYM empleado_3 FOR f_scl_empleado_3@sclbdd_s2.fi.unam;

--Sinónimos para PAGO_EMPLEADO
CREATE OR REPLACE SYNONYM pago_empleado_1 FOR f_scl_pago_empleado_1;
CREATE OR REPLACE SYNONYM pago_empleado_2
  FOR f_scl_pago_empleado_2@sclbdd_s2.fi.unam;

--Conexión al PDB sclbdd_s2
PROMPT Conectando a sclbdd_s2...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s2

PROMPT Creando sinónimos en sclbdd_s2...

--Sinónimos para fragmentos de PAIS
CREATE OR REPLACE SYNONYM pais_1 FOR f_scl_pais_1@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pais_2 FOR f_scl_pais_2;

--Sinónimos para fragmentos de OFICINA
CREATE OR REPLACE SYNONYM oficina_1 FOR f_scl_oficina_1@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM oficina_2 FOR f_scl_oficina_2;

--Sinónimos para fragmentos de PROYECTO
CREATE OR REPLACE SYNONYM proyecto_1 FOR f_scl_proyecto_1@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM proyecto_2 FOR f_scl_proyecto_2;
CREATE OR REPLACE SYNONYM proyecto_3 FOR f_scl_proyecto_3;

--Sinónimos para fragmentos de PROYECTO_PDF
CREATE OR REPLACE SYNONYM proyecto_pdf_1
  FOR f_scl_proyecto_pdf_1@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM proyecto_pdf_2 FOR f_scl_proyecto_pdf_2;

--Sinónimos para fragmentos de EMPLEADO
CREATE OR REPLACE SYNONYM empleado_1 FOR f_scl_empleado_1;
CREATE OR REPLACE SYNONYM empleado_2 FOR f_scl_empleado_2@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM empleado_3 FOR f_scl_empleado_3;

--Sinónimos para PAGO_EMPLEADO
CREATE OR REPLACE SYNONYM pago_empleado_1
  FOR f_scl_pago_empleado_1@sclbdd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pago_empleado_2 FOR f_scl_pago_empleado_2;

PROMPT ¡¡Listo!!
EXIT
