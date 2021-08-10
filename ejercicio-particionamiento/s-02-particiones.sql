-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Creación de tablas particionadas

-- Tabla agencia usando partición por rangos
CREATE TABLE agencia(
  agencia_id NUMBER(10, 0) NOT NULL,
  nombre VARCHAR2(40) NOT NULL,
  clave VARCHAR2(8) NOT NULL,
  agencia_anexa_id NUMBER(10, 0),
  CONSTRAINT agencia_pk PRIMARY KEY (agencia_id),
  CONSTRAINT agencia_anexa_id_fk FOREIGN KEY (agencia_anexa_id)
  REFERENCES agencia(agencia_id)
  --Se indica la columna pivote para particionar
) PARTITION BY RANGE (clave) (
    -- Indica el valor al que deben ser menores los datos de cada partición
    PARTITION agencia_p1_ae VALUES LESS THAN ('F'),
    PARTITION agencia_p2_fj VALUES LESS THAN ('K'),
    PARTITION agencia_p3_ko VALUES LESS THAN ('P'),
    PARTITION agencia_p4_pt VALUES LESS THAN ('U'),
    -- Última partición, acepta los valores no admitidos en las anteriores
    PARTITION agencia_p5_uz VALUES LESS THAN (MAXVALUE)
);


-- Tabla cliente usando particionamiento con hash codes ya que
-- no se tiene un criterio específico
CREATE TABLE cliente(
  cliente_id NUMBER(10, 0) NOT NULL,
  nombre VARCHAR2(40) NOT NULL,
  ap_paterno VARCHAR2(40) NOT NULL,
  ap_materno VARCHAR2(40),
  num_identificacion VARCHAR2(18) NOT NULL,
  email VARCHAR2(500) NOT NULL,
  CONSTRAINT cliente_pk PRIMARY KEY (cliente_id)
  -- Se indica el uso de hash codes
) PARTITION BY HASH(cliente_id) (
    --Sólo se nombran las particiones que se crearán
    PARTITION cliente_p1,
    PARTITION cliente_p2,
    PARTITION cliente_p3
);

-- Tabla orden_compra usando un particionamiento por referencia ya que es
-- tabla hija de cliente; se busca optimizar JOIN entre tablas
CREATE TABLE ORDEN_COMPRA(
  orden_compra_id NUMBER(10, 0) NOT NULL,
  fecha_compra DATE,
  num_cuenta_banco VARCHAR2(50),
  cliente_id NUMBER(10, 0) NOT NULL,
  CONSTRAINT orden_compra_pk PRIMARY KEY (orden_compra_id),
  CONSTRAINT orden_compra_cliente_id_fk FOREIGN KEY (cliente_id)
  REFERENCES cliente(cliente_id)
  -- Se indica particionamiento por referencia usando constraint de FK
) PARTITION BY REFERENCE (orden_compra_cliente_id_fk);

-- Tabla usando particionamiento compuesto Rango-Rango
CREATE TABLE pago_auto(
  num_pago NUMBER(3, 0) NOT NULL,
  orden_compra_id NUMBER(10, 0) NOT NULL,
  fecha_pago DATE,
  importe NUMBER(10, 2),
  CONSTRAINT pago_auto_pk PRIMARY KEY (num_pago, orden_compra_id),
  CONSTRAINT pago_auto_orden_compra_id_fk FOREIGN KEY (orden_compra_id)
  REFERENCES ORDEN_COMPRA(orden_compra_id)
  --Indica el particionamiento por rango usando columna fecha_pago
) PARTITION BY RANGE (fecha_pago)
  -- Se indica el intervalo de 6 meses después de la partición inicial
  INTERVAL (numtoyminterval(6, 'MONTH'))
  --Se indica la creación de subparticiones por rango usando num_pago
  SUBPARTITION BY RANGE (num_pago)
  SUBPARTITION TEMPLATE (
    --Definición de las subparticiones
    SUBPARTITION pago_auto_num_pago_1 VALUES LESS THAN (7),
    SUBPARTITION pago_auto_num_pago_2 VALUES LESS THAN (13),
    SUBPARTITION pago_auto_num_pago_3 VALUES LESS THAN (19),
    SUBPARTITION pago_auto_num_pago_4 VALUES LESS THAN (MAXVALUE)
  )
  --Se define la partición inicial de primer nivel
  (PARTITION pago_auto_periodo_ini
    VALUES LESS THAN (to_date('01-01-2011', 'dd-mm-yyyy')));


-- Cración de tabla status_auto sin particionar
CREATE TABLE status_auto(
  status_auto_id NUMBER(2, 0) NOT NULL,
  clave VARCHAR2(20) NOT NULL,
  descripcion VARCHAR2(40) NOT NULL,
  CONSTRAINT status_auto_pk PRIMARY KEY (status_auto_id)
);

-- Tabla usando particionamiento compuesto Lista-Hash
CREATE TABLE auto(
  auto_id NUMBER(10, 0) NOT NULL,
  marca VARCHAR2(40) NOT NULL,
  modelo VARCHAR2(40) NOT NULL,
  anio NUMBER(4, 0) NOT NULL,
  num_serie VARCHAR2(20) NOT NULL,
  tipo CHAR(1) NOT NULL,
  precio NUMBER(9, 2) NOT NULL,
  descuento NUMBER(9, 2),
  foto BLOB NOT NULL,
  fecha_status TIMESTAMP(6) NOT NULL,
  status_auto_id NUMBER(2, 0) NOT NULL,
  agencia_id NUMBER(10, 0) NOT NULL,
  cliente_id NUMBER(10, 0),
  CONSTRAINT auto_pk PRIMARY KEY (auto_id),
  CONSTRAINT auto_agencia_id_fk FOREIGN KEY (agencia_id)
  REFERENCES agencia(agencia_id),
  CONSTRAINT auto_cliente_id_fk FOREIGN KEY (cliente_id)
  REFERENCES cliente(cliente_id),
  CONSTRAINT auto_status_id_fk FOREIGN KEY (status_auto_id)
  REFERENCES STATUS_AUTO(status_auto_id)
  -- Indica particionamiento por listas usando columna tipo
) PARTITION BY LIST (tipo)
  -- Se indica la creación de subparticiones por hash codes sobre cliente_id
  SUBPARTITION BY HASH (cliente_id)
  SUBPARTITION TEMPLATE (
    --Definición de las subparticiones
    SUBPARTITION auto_cliente_p1pA,
    SUBPARTITION auto_cliente_p1pB,
    SUBPARTITION auto_cliente_p2pA,
    SUBPARTITION auto_cliente_p2pB
  ) (
    --Definición de las particiones por lista
    PARTITION auto_particular_p1 VALUES ('P'),
    PARTITION auto_carga_p2 VALUES ('C')
  );

-- Tabla usando particionamiento compuesto Rango-Hash
CREATE TABLE historico_status_auto(
  historico_status_id NUMBER(10, 0) NOT NULL,
  fecha_status TIMESTAMP(6) NOT NULL,
  status_auto_id NUMBER(2, 0) NOT NULL,
  auto_id NUMBER(10, 0) NOT NULL,
  CONSTRAINT historico_status_auto_pk PRIMARY KEY (historico_status_id),
  CONSTRAINT hist_status_auto_status_id_fk FOREIGN KEY (status_auto_id)
  REFERENCES status_auto(status_auto_id),
  CONSTRAINT historico_status_auto_id_fk FOREIGN KEY (auto_id)
  REFERENCES auto(auto_id)
  -- Indica particionamiento por rango usando fecha_status
) PARTITION BY RANGE (fecha_status)
  -- Se define un intervalo anual para nuevas particiones
  INTERVAL (numtoyminterval(1, 'YEAR'))
  -- Se indica la creación de subparticiones por hash usando la PK
  SUBPARTITION BY HASH (historico_status_id)
  SUBPARTITION TEMPLATE (
    --Asignación de las subparticiones
    SUBPARTITION h_p1 TABLESPACE autos_tbs_1,
    SUBPARTITION h_p2 TABLESPACE autos_tbs_2,
    SUBPARTITION h_p3 TABLESPACE autos_tbs_3,
    SUBPARTITION h_p4 TABLESPACE autos_tbs_4,
    SUBPARTITION h_p5 TABLESPACE autos_tbs_5
  )
  -- Se define la partición inicial de primer nivel
  (PARTITION h_antigua VALUES LESS THAN (to_date('01-01-2010', 'dd-mm-yyyy')));
