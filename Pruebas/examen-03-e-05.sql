-- A)
CREATE TABLE orden_compra(
  orden_compra_id NUMBER(10, 0) NOT NULL,
  fecha_compra DATE NOT NULL,
  region_entrega VARCHAR2(20) NOT NULL,
  tipo_orden VARCHAR2(40) NOT NULL,
  folio_factura VARCHAR2(13) NOT NULL,
  CONSTRAINT orden_compra_pk PRIMARY KEY (orden_compra_id)
) PARTITION BY LIST (tipo_orden)
  SUBPARTITION BY RANGE (fecha_compra)
  INTERVAL (numtoyminterval(1, 'MONTH'))
  SUBPARTITION TEMPLATE (
    SUBPARTITION sp1 VALUES LESS THAN (to_date('01/01/2015', 'dd/mm/yyyy'))
  ) (
    PARTITION p1 VALUES ('VIP'),
    PARTITION p2 VALUES ('ORD'),
    PARTITION p3 VALUES ('URG')
  );


-- B)
