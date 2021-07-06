-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        28/06/2021
-- @Descripción:  Script encargado de la definición de los objetos que son
--                ubicados en el Sitio 02

-- Creación de tabla PROYECTO_PDF
CREATE TABLE f_scl_proyecto_pdf_2(
  num_pdf NUMERIC(1, 0) NOT NULL,
  proyecto_id NUMERIC(10, 0) NOT NULL,
  archivo_pdf BLOB NOT NULL,
  tamanio NUMERIC(10, 2) NOT NULL,
  CONSTRAINT proyecto_pdf_pk PRIMARY KEY (num_pdf, proyecto_id)
);

-- Creación de la tabla PAIS
CREATE TABLE f_scl_pais_2(
  pais_id NUMERIC(5, 0) NOT NULL,
  clave VARCHAR(5) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  region CHAR(1) NOT NULL,
  CONSTRAINT pais_pk PRIMARY KEY (pais_id)
);

-- Creación del fragmento vertical de EMPLEADO
CREATE TABLE f_scl_empleado_1(
  empleado_id NUMERIC(10, 0) NOT NULL,
  foto BLOB NOT NULL,
  num_cuenta VARCHAR(18) NOT NULL,
  CONSTRAINT empleado_v_pk PRIMARY KEY (empleado_id)
);

-- Creación del fragmento horizontal de EMPLEADO
CREATE TABLE f_scl_empleado_3(
  empleado_id NUMERIC(10, 0) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  ap_paterno VARCHAR(40) NOT NULL,
  ap_materno VARCHAR(40) NULL,
  rfc VARCHAR(13) NOT NULL,
  email VARCHAR(40) NOT NULL,
  jefe_id NUMERIC(10, 0) NULL,
  CONSTRAINT empleado_pk PRIMARY KEY (empleado_id),
  CONSTRAINT empleado_empleado_id_fk FOREIGN KEY (jefe_id)
  REFERENCES f_scl_empleado_1(empleado_id) --ON DELETE CASCADE
);

-- Creación de la tabla PAGO_EMPLEADO
CREATE TABLE f_scl_pago_empleado_2(
  pago_empleado_id NUMERIC(10, 0) NOT NULL,
  importe NUMERIC(10, 2) NOT NULL,
  fecha_pago DATE NOT NULL,
  proyecto_id NUMERIC(10, 0) NOT NULL,
  empleado_id NUMERIC(10, 0) NOT NULL,
  CONSTRAINT pago_empleado_pk PRIMARY KEY (pago_empleado_id),
  CONSTRAINT emp_pe_pago_empleado_id_fk FOREIGN KEY (empleado_id)
  REFERENCES f_scl_empleado_3(empleado_id) --ON DELETE CASCADE
);

-- Creación de la tabla OFICINA
CREATE TABLE f_scl_oficina_2(
  oficina_id NUMERIC(5, 0) NOT NULL,
  nombre VARCHAR(40) NOT NULL,
  oficina_anexa_id NUMERIC(5, 0) NULL,
  pais_id NUMERIC(5, 0) NOT NULL,
  CONSTRAINT oficina_pk PRIMARY KEY (oficina_id),
  CONSTRAINT pais_oficina_pais_id_fk FOREIGN KEY (pais_id)
  REFERENCES f_scl_pais_2(pais_id) --ON DELETE CASCADE
);

-- Creación de fragmentos de PROYECTO
CREATE TABLE f_scl_proyecto_2(
  proyecto_id NUMERIC(10, 0) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  clave VARCHAR(5) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NULL,
  responsable_id NUMERIC(10, 0) NOT NULL,
  oficina_id NUMERIC(5, 0) NOT NULL,
  CONSTRAINT proyecto_2_pk PRIMARY KEY (proyecto_id),
  CONSTRAINT oficina_proy_2_proyecto_id_fk FOREIGN KEY (oficina_id)
  REFERENCES f_scl_oficina_2(oficina_id), --ON DELETE CASCADE,
  CONSTRAINT emp_proy_2_responsable_id_fk FOREIGN KEY (responsable_id)
  REFERENCES f_scl_empleado_1(empleado_id) --ON DELETE CASCADE
);

CREATE TABLE f_scl_proyecto_3(
  proyecto_id NUMERIC(10, 0) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  clave VARCHAR(5) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NULL,
  responsable_id NUMERIC(10, 0) NOT NULL,
  oficina_id NUMERIC(5, 0) NOT NULL,
  CONSTRAINT proyecto_3_pk PRIMARY KEY (proyecto_id),
  CONSTRAINT oficina_proy_3_proyecto_id_fk FOREIGN KEY (oficina_id)
  REFERENCES f_scl_oficina_2(oficina_id), --ON DELETE CASCADE,
  CONSTRAINT emp_proy_3_responsable_id_fk FOREIGN KEY (responsable_id)
  REFERENCES f_scl_empleado_1(empleado_id) --ON DELETE CASCADE
);
