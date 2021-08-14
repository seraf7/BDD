-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Script de validación de sinónimos

PROMPT Validando sinónimos de ARCHIVO_PROGRAMA...
SELECT
  (SELECT COUNT(*) FROM archivo_programa_f1) AS archivo_programa_f1,
  (SELECT COUNT(*) FROM archivo_programa_f2) AS archivo_programa_f2
FROM dual;

PROMPT Validando sinónimos de PAIS...
SELECT
  (SELECT COUNT(*) FROM pais_r1) AS pais_r1,
  (SELECT COUNT(*) FROM pais_r2) AS pais_r2,
  (SELECT COUNT(*) FROM pais_r3) AS pais_r3,
  (SELECT COUNT(*) FROM pais_r4) AS pais_r4
FROM dual;

PROMPT Validando sinónimos de USUARIO...
SELECT
  (SELECT COUNT(*) FROM usuario_f1) AS usuario_f1,
  (SELECT COUNT(*) FROM usuario_f2) AS usuario_f2,
  (SELECT COUNT(*) FROM usuario_f3) AS usuario_f3,
  (SELECT COUNT(*) FROM usuario_f4) AS usuario_f4,
  (SELECT COUNT(*) FROM usuario_f5) AS usuario_f5
FROM dual;

PROMPT Validando sinónimos de PROGRAMA...
SELECT
  (SELECT COUNT(*) FROM programa_f1) AS programa_f1,
  (SELECT COUNT(*) FROM programa_f2) AS programa_f2,
  (SELECT COUNT(*) FROM programa_f3) AS programa_f3
FROM dual;

PROMPT Validando sinónimos de PLAYLIST...
SELECT
  (SELECT COUNT(*) FROM playlist_f1) AS playlist_f1,
  (SELECT COUNT(*) FROM playlist_f2) AS playlist_f2,
  (SELECT COUNT(*) FROM playlist_f3) AS playlist_f3
FROM dual;

PROMPT Validando sinónimos de DOCUMENTAL...
SELECT
  (SELECT COUNT(*) FROM documental_f1) AS documental_f1,
  (SELECT COUNT(*) FROM documental_f2) AS documental_f2,
  (SELECT COUNT(*) FROM documental_f3) AS documental_f3
FROM dual;

PROMPT Validando sinónimos de PELICULA...
SELECT
  (SELECT COUNT(*) FROM pelicula_f1) AS pelicula_f1,
  (SELECT COUNT(*) FROM pelicula_f2) AS pelicula_f2,
  (SELECT COUNT(*) FROM pelicula_f3) AS pelicula_f3
FROM dual;

PROMPT Validando sinónimos de SERIE...
SELECT
  (SELECT COUNT(*) FROM serie_f1) AS serie_f1,
  (SELECT COUNT(*) FROM serie_f2) AS serie_f2,
  (SELECT COUNT(*) FROM serie_f3) AS serie_f3
FROM dual;

PROMPT Validando sinónimos de TIPO_SERIE...
SELECT
  (SELECT COUNT(*) FROM tipo_serie_r1) AS tipo_serie_r1,
  (SELECT COUNT(*) FROM tipo_serie_r2) AS tipo_serie_r2,
  (SELECT COUNT(*) FROM tipo_serie_r3) AS tipo_serie_r3,
  (SELECT COUNT(*) FROM tipo_serie_r4) AS tipo_serie_r4
FROM dual;

PROMPT Validando sinónimos de TIPO_CUENTA...
SELECT
  (SELECT COUNT(*) FROM tipo_cuenta_r1) AS tipo_cuenta_r1,
  (SELECT COUNT(*) FROM tipo_cuenta_r2) AS tipo_cuenta_r2,
  (SELECT COUNT(*) FROM tipo_cuenta_r3) AS tipo_cuenta_r3,
  (SELECT COUNT(*) FROM tipo_cuenta_r4) AS tipo_cuenta_r4
FROM dual;
