CREATE MATERIALIZED VIEW mv_reporte AS
  SELECT AU.*
  FROM auto_1 AU
  WHERE EXISTS (
    SELECT 1 FROM agencia_1 AG
    WHERE AU.agencia_id = AG.agencia_id
    AND AG.clave = '002'
  ) AND EXISTS (
    SELECT 1 FROM cliente_1 C
    WHERE AU.cliente_id = C.cliente_id
    AND C.nombre = 'Juan Luna'
  )
  AND AND AU.placa LIKE '%0';


Lista de mlogs
auto -> auto_id
cliente -> cliente_id, nombre
agencia -> agencia_id, clave
