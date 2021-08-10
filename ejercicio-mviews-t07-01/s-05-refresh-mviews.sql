-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   08/08/2021
-- @Descripción:      Creación de grupos de refresg y actualización de las
--                    vistas materializadas

-- Conexión al sitio mview
PROMPT Conectando al sitio mview...
CONNECT scl_replica_bdd/serafin@sclbdd_s2

-- Creación de un nuevo grupo de refresh que se actualiza cada minuto
BEGIN
  dbms_refresh.make(
    name        =>  'clientes_agencias_refresh_g1',
    list        =>  'mv_auto, mv_agencia',
    next_date   =>  sysdate,
    interval    =>  'sysdate + 1/(24*60)',
    refresh_after_errors  =>  false
  );
END;
/

-- Se añade la vista faltante al grupo de refresh
BEGIN
    dbms_refresh.add(
      name  =>  'clientes_agencias_refresh_g1',
      list  =>  'mv_cliente',
      lax   =>  false   --No se realizará cambio de grupo
    );
END;
/

COMMIT;

-- Consulta información de los grupos de refresh
SELECT rowner,rname,refgroup,job,implicit_destroy,
  next_date,interval,broken
FROM user_refresh;

-- Información del último refresh realizado
SELECT * FROM user_mview_refresh_times;

-- Información del JOB que hace las operaciones de refresh
SELECT job,log_user,last_date,next_date,total_time
FROM user_jobs;

SELECT broken,interval,failures, what
FROM user_jobs;


-- Consultas de los cambios realizados

SELECT * FROM mv_auto WHERE cliente_id = 150;

SELECT * FROM mv_agencia WHERE agencia_id = 502;

SELECT * FROM mv_auto WHERE auto_id = 3002;

SELECT * FROM mv_auto WHERE auto_id = 5;

SELECT * FROM mv_cliente WHERE cliente_id = 80;
