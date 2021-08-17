--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Modelo S2.DM1
--
-- Date Created : Thursday, August 12, 2021 00:46:45
-- Target DBMS : Oracle 12c
--

--
-- table: pais_r_scl_s2
--

CREATE TABLE pais_r_scl_s2(
    pais_id       NUMBER(2, 0)    NOT NULL,
    clave         VARCHAR2(4)     NOT NULL,
    nombre        VARCHAR2(50)    NOT NULL,
    continente    VARCHAR2(3)     NOT NULL,
    CONSTRAINT pais_r2_pk PRIMARY KEY (pais_id)
)
;



--
-- table: status_programa
--

CREATE TABLE status_programa(
    status_programa_id    NUMBER(2, 0)     NOT NULL,
    clave                 VARCHAR2(40)     NOT NULL,
    descripcion           VARCHAR2(500)    NOT NULL,
    CONSTRAINT status_programa_pk PRIMARY KEY (status_programa_id)
)
;



--
-- table: tipo_cuenta_r_scl_s2
--

CREATE TABLE tipo_cuenta_r_scl_s2(
    tipo_cuenta_id    NUMBER(2, 0)     NOT NULL,
    clave             VARCHAR2(40)     NOT NULL,
    descripcion       VARCHAR2(500)    NOT NULL,
    costo_mensual     NUMBER(10, 2)    NOT NULL,
    CONSTRAINT tipo_cuenta_r2_pk PRIMARY KEY (tipo_cuenta_id)
)
;



--
-- table: tipo_serie_r_scl_s2
--

CREATE TABLE tipo_serie_r_scl_s2(
    tipo_serie_id    NUMBER(2, 0)     NOT NULL,
    clave            VARCHAR2(40)     NOT NULL,
    descripcion      VARCHAR2(500)    NOT NULL,
    CONSTRAINT tipo_serie_r2_pk PRIMARY KEY (tipo_serie_id)
)
;



--
-- table: usuario_f5_scl_s2
--

CREATE TABLE usuario_f5_scl_s2(
    usuario_id          NUMBER(10, 0)    NOT NULL,
    email               VARCHAR2(200)    NOT NULL,
    nombre              VARCHAR2(40)     NOT NULL,
    ap_paterno          VARCHAR2(40)     NOT NULL,
    ap_materno          VARCHAR2(40)     NOT NULL,
    fecha_ingreso       DATE             NOT NULL,
    fecha_cuenta_fin    DATE             NOT NULL,
    vigente             NUMBER(1, 0)     NOT NULL,
    tipo_cuenta_id      NUMBER(2, 0)     NOT NULL,
    CONSTRAINT usuario_f5_pk PRIMARY KEY (usuario_id),
    CONSTRAINT us_f5_tipo_cuenta_id_fk FOREIGN KEY (tipo_cuenta_id)
    REFERENCES tipo_cuenta_r_scl_s2(tipo_cuenta_id)
)
;
