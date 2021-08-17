-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   11/08/2021
-- @Descripción:      Creación de vistas comunes a todos los nodos.
--                    Se excluyen las vistas que contienen columnas BLOB

-- PROGRAMA
PROMPT Creando vista PROGRAMA...
CREATE OR REPLACE VIEW programa AS
  SELECT programa_id, folio, nombre, descripcion, fecha_status,
    tipo, status_programa_id
  FROM programa_f1
  UNION ALL
  SELECT programa_id, folio, nombre, descripcion, fecha_status,
    tipo, status_programa_id
  FROM programa_f2
  UNION ALL
  SELECT programa_id, folio, nombre, descripcion, fecha_status,
    tipo, status_programa_id
  FROM programa_f3;

-- PELICULA
PROMPT Creando vista PELICULA...
CREATE OR REPLACE VIEW pelicula AS
  SELECT programa_id, duracion, sinopsis, clasificacion,
    pelicula_antecedente_id
  FROM pelicula_f1
  UNION ALL
  SELECT programa_id, duracion, sinopsis, clasificacion,
    pelicula_antecedente_id
  FROM pelicula_f2
  UNION ALL
  SELECT programa_id, duracion, sinopsis, clasificacion,
    pelicula_antecedente_id
  FROM pelicula_f3;

-- SERIE
PROMPT Creando vista SERIE...
CREATE OR REPLACE VIEW serie AS
  SELECT programa_id, num_capitulos, duracion_capitulo, tipo_serie_id
  FROM serie_f1
  UNION ALL
  SELECT programa_id, num_capitulos, duracion_capitulo, tipo_serie_id
  FROM serie_f2
  UNION ALL
  SELECT programa_id, num_capitulos, duracion_capitulo, tipo_serie_id
  FROM serie_f3;

-- PLAYLIST
PROMPT Creando vista PLAYLIST...
CREATE OR REPLACE VIEW playlist AS
  SELECT playlist_id, calificacion, indice, num_reproducciones,
    programa_id, usuario_id
  FROM playlist_f1
  UNION ALL
  SELECT playlist_id, calificacion, indice, num_reproducciones,
    programa_id, usuario_id
  FROM playlist_f2
  UNION ALL
  SELECT playlist_id, calificacion, indice, num_reproducciones,
    programa_id, usuario_id
  FROM playlist_f3;

-- USUARIO
PROMPT Creando vista USUARIO...
CREATE OR REPLACE VIEW usuario AS
  SELECT u1.usuario_id, q1.email, q1.nombre, q1.ap_paterno, q1.ap_materno,
    u1.password, q1.fecha_ingreso, q1.fecha_cuenta_fin, q1.vigente,
    u1.num_tarjeta, q1.tipo_cuenta_id
  FROM usuario_f1 u1
  JOIN (
    SELECT usuario_id, email, nombre, ap_paterno, ap_materno, fecha_ingreso,
      fecha_cuenta_fin, vigente, tipo_cuenta_id
    FROM usuario_f2
    UNION ALL
    SELECT usuario_id, email, nombre, ap_paterno, ap_materno, fecha_ingreso,
      fecha_cuenta_fin, vigente, tipo_cuenta_id
    FROM usuario_f3
    UNION ALL
    SELECT usuario_id, email, nombre, ap_paterno, ap_materno, fecha_ingreso,
      fecha_cuenta_fin, vigente, tipo_cuenta_id
    FROM usuario_f4
    UNION ALL
    SELECT usuario_id, email, nombre, ap_paterno, ap_materno, fecha_ingreso,
      fecha_cuenta_fin, vigente, tipo_cuenta_id
    FROM usuario_f5
  ) q1 ON u1.usuario_id = q1.usuario_id;

-- PAIS
CREATE OR REPLACE VIEW pais AS
  SELECT pais_id, clave, nombre, continente
  FROM pais_r1;

-- TIPO_SERIE
CREATE OR REPLACE VIEW tipo_serie AS
  SELECT tipo_serie_id, clave, descripcion
  FROM tipo_serie_r1;

-- TIPO_CUENTA
CREATE OR REPLACE VIEW tipo_cuenta AS
  SELECT tipo_cuenta_id, clave, descripcion, costo_mensual
  FROM tipo_cuenta_r1;

-- HISTORICO_STATUS_PROGRAMA
CREATE OR REPLACE VIEW historico_status_programa AS
  SELECT historico_status_prog_id, fecha_status, status_programa_id, programa_id
  FROM historico_status_programa_f1;
