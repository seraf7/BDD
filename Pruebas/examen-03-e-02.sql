-- 1
CREATE GLOBAL TEMPORARY TABLE t_respuesta(
  agencia_id NUMBER(10, 0) NOT NULL,
  clave VARCHAR2(40),
  CONSTRAINT t_respuesta_pk PRIMARY KEY (agencia_id)
) ON COMMIT DELETE ROWS;

INSERT INTO t_respuesta(agencia_id, clave)
  SELECT /*+driving_site(ag1)*/ ag1.agencia_id, ag1.clave
  FROM agencia_1 ag1
  WHERE EXISTS (
    SELECT agencia_id
    FROM auto_1 au1
    WHERE au1.agencia_id = ag1.agencia_id
  );

SELECT *
FROM auto_1 a1
JOIN t_respuesta T ON a1.agencia_id = T.agencia_id;


-- E2
-- A) datos mínimos
SELECT vuelo_id
FROM vuelo_1
WHERE TO_CHAR(fecha_salida, 'dd/mm/yyyy') = '01/01/2010';

-- B) datos mínimos de regreso
SELECT P.vuelo_id, P.rfc
FROM pasajero_1 P
WHERE EXISTS (
  SELECT 1
  FROM temp T
  WHERE T.vuelo_id = P.vuelo_id
);

-- C) Join Local
SELECT T.rfc, V.origen, V.destino
FROM temp T
JOIN vuelo_1 V ON T.vuelo_id = V.vuelo_id;
