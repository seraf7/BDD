--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Modelo S3.DM1
--
-- Date Created : Thursday, August 12, 2021 00:49:47
-- Target DBMS : Oracle 12c
--

--
-- table: archivo_programa_f2_icl_s1
--

CREATE TABLE archivo_programa_f2_icl_s1(
    num_archivo    NUMBER(5, 0)     NOT NULL,
    programa_id    NUMBER(10, 0)    NOT NULL,
    archivo        BLOB             NOT NULL,
    tamanio        NUMBER(10, 2)    NOT NULL,
    CONSTRAINT archivo_programa_f2_pk PRIMARY KEY (num_archivo, programa_id)
)
;



--
-- table: pais_r_icl_s1
--

CREATE TABLE pais_r_icl_s1(
    pais_id       NUMBER(2, 0)    NOT NULL,
    clave         VARCHAR2(4)     NOT NULL,
    nombre        VARCHAR2(50)    NOT NULL,
    continente    VARCHAR2(3)     NOT NULL,
    CONSTRAINT pais_r3_pk PRIMARY KEY (pais_id)
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
-- table: programa_f2_icl_s1
--

CREATE TABLE programa_f2_icl_s1(
    programa_id           NUMBER(10, 0)    NOT NULL,
    folio                 VARCHAR2(13)     NOT NULL,
    nombre                VARCHAR2(100)    NOT NULL,
    descripcion           VARCHAR2(500)    NOT NULL,
    fecha_status          DATE             NOT NULL,
    tipo                  CHAR(1)          NOT NULL,
    status_programa_id    NUMBER(2, 0)     NOT NULL,
    CONSTRAINT programa_f2_pk PRIMARY KEY (programa_id),
    CONSTRAINT programa_f2_sp_id_fk FOREIGN KEY (status_programa_id)
    REFERENCES status_programa(status_programa_id)
)
;



--
-- table: documental_f2_icl_s1
--

CREATE TABLE documental_f2_icl_s1(
    programa_id    NUMBER(10, 0)    NOT NULL,
    tematica       VARCHAR2(100)    NOT NULL,
    duracion       NUMBER(5, 2)     NOT NULL,
    trailer        BLOB             NOT NULL,
    pais_id        NUMBER(2, 0)     NOT NULL,
    CONSTRAINT documental_f2_pk PRIMARY KEY (programa_id),
    CONSTRAINT doc_f2_pais_id_fk FOREIGN KEY (pais_id)
    REFERENCES pais_r_icl_s1(pais_id),
    CONSTRAINT doc_f2_programa_id_fk FOREIGN KEY (programa_id)
    REFERENCES programa_f2_icl_s1(programa_id)
)
;



--
-- table: pelicula_f2_icl_s1
--

CREATE TABLE pelicula_f2_icl_s1(
    programa_id                NUMBER(10, 0)    NOT NULL,
    duracion                   NUMBER(5, 2)     NOT NULL,
    sinopsis                   VARCHAR2(500)    NOT NULL,
    clasificacion              CHAR(1)          NOT NULL,
    pelicula_antecedente_id    NUMBER(10, 0),
    CONSTRAINT pelicula_f2_pk PRIMARY KEY (programa_id),
    CONSTRAINT pe_f2_programa_id_fk FOREIGN KEY (programa_id)
    REFERENCES programa_f2_icl_s1(programa_id)
)
;



--
-- table: usuario_f1_icl_s1
--

CREATE TABLE usuario_f1_icl_s1(
    usuario_id     NUMBER(10, 0)    NOT NULL,
    password       VARCHAR2(16)     NOT NULL,
    num_tarjeta    VARCHAR2(16)     NOT NULL,
    CONSTRAINT usuario_f1_pk PRIMARY KEY (usuario_id)
)
;



--
-- table: playlist_f2_icl_s1
--

CREATE TABLE playlist_f2_icl_s1(
    playlist_id           NUMBER(10, 0)    NOT NULL,
    calificacion          NUMBER(1, 0)     NOT NULL,
    indice                NUMBER(10, 0)    NOT NULL,
    num_reproducciones    NUMBER(10, 0)    NOT NULL,
    programa_id           NUMBER(10, 0)    NOT NULL,
    usuario_id            NUMBER(10, 0)    NOT NULL,
    CONSTRAINT playlist_f2_pk PRIMARY KEY (playlist_id),
    CONSTRAINT pl_f2_programa_id_fk FOREIGN KEY (programa_id)
    REFERENCES programa_f2_icl_s1(programa_id),
    CONSTRAINT pl_f2_usuario_id_fk FOREIGN KEY (usuario_id)
    REFERENCES usuario_f1_icl_s1(usuario_id)
)
;



--
-- table: tipo_serie_r_icl_s1
--

CREATE TABLE tipo_serie_r_icl_s1(
    tipo_serie_id    NUMBER(2, 0)     NOT NULL,
    clave            VARCHAR2(40)     NOT NULL,
    descripcion      VARCHAR2(500)    NOT NULL,
    CONSTRAINT tipo_serie_r3_pk PRIMARY KEY (tipo_serie_id)
)
;



--
-- table: serie_f2_icl_s1
--

CREATE TABLE serie_f2_icl_s1(
    programa_id          NUMBER(10, 0)    NOT NULL,
    num_capitulos        NUMBER(3, 0)     NOT NULL,
    duracion_capitulo    NUMBER(5, 2)     NOT NULL,
    tipo_serie_id        NUMBER(2, 0)     NOT NULL,
    CONSTRAINT serie_f2_pk PRIMARY KEY (programa_id),
    CONSTRAINT se_f2_programa_id_fk FOREIGN KEY (programa_id)
    REFERENCES programa_f2_icl_s1(programa_id),
    CONSTRAINT se_f2_tipo_serie_id_fk FOREIGN KEY (tipo_serie_id)
    REFERENCES tipo_serie_r_icl_s1(tipo_serie_id)
)
;



--
-- table: tipo_cuenta_r_icl_s1
--

CREATE TABLE tipo_cuenta_r_icl_s1(
    tipo_cuenta_id    NUMBER(2, 0)     NOT NULL,
    clave             VARCHAR2(40)     NOT NULL,
    descripcion       VARCHAR2(500)    NOT NULL,
    costo_mensual     NUMBER(10, 2)    NOT NULL,
    CONSTRAINT tipo_cuenta_r3_pk PRIMARY KEY (tipo_cuenta_id)
)
;



--
-- table: usuario_f4_icl_s1
--

CREATE TABLE usuario_f4_icl_s1(
    usuario_id          NUMBER(10, 0)    NOT NULL,
    email               VARCHAR2(200)    NOT NULL,
    nombre              VARCHAR2(40)     NOT NULL,
    ap_paterno          VARCHAR2(40)     NOT NULL,
    ap_materno          VARCHAR2(40)     NOT NULL,
    fecha_ingreso       DATE             NOT NULL,
    fecha_cuenta_fin    DATE             NOT NULL,
    vigente             NUMBER(1, 0)     NOT NULL,
    tipo_cuenta_id      NUMBER(2, 0)     NOT NULL,
    CONSTRAINT usuario_f4_pk PRIMARY KEY (usuario_id),
    CONSTRAINT us_f4_tipo_cuenta_id_fk FOREIGN KEY (tipo_cuenta_id)
    REFERENCES tipo_cuenta_r_icl_s1(tipo_cuenta_id)
)
;
