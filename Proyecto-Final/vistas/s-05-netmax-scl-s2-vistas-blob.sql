-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   12/08/2021
-- @Descripción:      Definición de vistas con columnas BLOB para sclbd_s2

-- DOCUMENTAL
PROMPT Creando vista DOCUMENTAL...
CREATE OR REPLACE VIEW documental AS
  SELECT programa_id, tematica, duracion,
    get_remote_trailer_f1_by_id(programa_id) AS trailer, pais_id
  FROM documental_f1
  UNION ALL
  SELECT programa_id, tematica, duracion,
    get_remote_trailer_f2_by_id(programa_id), pais_id
  FROM documental_f2
  UNION ALL
  SELECT programa_id, tematica, duracion,
    get_remote_trailer_f3_by_id(programa_id), pais_id
  FROM documental_f3;

-- ARCHIVO_PROGRAMA
PROMPT Creando vista ARCHIVO_PROGRAMA...
CREATE OR REPLACE VIEW archivo_programa AS
  SELECT num_archivo, programa_id,
    get_remote_archivo_f1_by_id(num_archivo, programa_id) AS archivo, tamanio
  FROM archivo_programa_f1
  UNION ALL
  SELECT num_archivo, programa_id,
    get_remote_archivo_f2_by_id(num_archivo, programa_id), tamanio
  FROM archivo_programa_f2;
