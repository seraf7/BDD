-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   08/08/2021
-- @Descripción:      Creación de ligas y definición de vistas materializadas

-- Conexión al sitio sclbdd_s2
PROMPT Conectando como scl_replica_bdd...
CONNECT scl_replica_bdd/serafin

PROMPT Creando ligas...
-- Liga administrativa
CREATE PUBLIC DATABASE LINK sclbdd_s1_master.fi.unam
USING 'SCLBDD_S1';

--Liga privada
CREATE DATABASE LINK sclbdd_s1_master.fi.unam
  CONNECT TO scl_replica_bdd IDENTIFIED BY serafin;

-- Creación de vistas materializadas simples solicitadas

-- Vista materializada con todos los atributos de las agencias cuya clave
-- inicia con [A-F]
CREATE MATERIALIZED VIEW mv_agencia
REFRESH FAST WITH PRIMARY KEY AS
  SELECT * FROM agencia@sclbdd_s1_master
  WHERE SUBSTR(clave, 1, 1) BETWEEN 'A' AND 'F';

-- Vista materializada con autos tipo P y agencia en mv_agencia
CREATE MATERIALIZED VIEW mv_auto
REFRESH FAST WITH PRIMARY KEY AS
  SELECT P.auto_id, P.marca, P.modelo, P.anio, P.num_serie, P.tipo, P.precio,
    P.descuento, P.agencia_id, P.cliente_id
  FROM auto@sclbdd_s1_master P
  WHERE tipo = 'P'
  AND EXISTS (
    SELECT 1 FROM agencia@sclbdd_s1_master A
    WHERE SUBSTR(A.clave, 1, 1) BETWEEN 'A' AND 'F'
    AND P.agencia_id = A.agencia_id
  );

-- Vista materializada de los clientes con email .gov y clientes cuyos autos
-- estan en la vista mv_auto
CREATE MATERIALIZED VIEW mv_cliente
REFRESH FAST WITH PRIMARY KEY AS
  SELECT * FROM cliente@sclbdd_s1_master
  WHERE email LIKE '%.gov'
  UNION
  SELECT * FROM cliente@sclbdd_s1_master C
  WHERE EXISTS (
    SELECT 1 FROM auto@sclbdd_s1_master P
    WHERE P.tipo = 'P'
    AND P.cliente_id = C.cliente_id
    AND EXISTS(
      SELECT 1 FROM agencia@sclbdd_s1_master A
      WHERE SUBSTR(A.clave, 1, 1) BETWEEN 'A' AND 'F'
      AND P.agencia_id = A.agencia_id
    )
  );

--Consultas informativas de las vistas materializadas creadas
SELECT owner,mview_name,master_link,updatable,refresh_method,refresh_mode
FROM user_mviews;

SELECT mview_name,last_refresh_type,last_refresh_date,last_refresh_end_time
FROM user_mviews;

PROMPT ¡¡Listo!!
EXIT
