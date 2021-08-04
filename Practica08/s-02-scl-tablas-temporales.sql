-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        29/07/2021
-- @Descripción:  Definición de las tablas temporales para el manejo de
--                columna BLOB

PROMPT Conectando al PDB sclbdd_s1...
CONNECT consultora_bdd/consultora_bdd@sclbdd_s1

PROMPT Creando tablas temporales...
--Definición de tabla temporal para inserciones en empleado
CREATE GLOBAL TEMPORARY TABLE t_empleado_insert(
  empleado_id NUMERIC(10, 0) NOT NULL,
  foto BLOB NOT NULL,
  num_cuenta VARCHAR(18) NOT NULL,
  CONSTRAINT t_empleado_insert_pk PRIMARY KEY (empleado_id)
) ON COMMIT PRESERVE ROWS;

--Definición de tabla temporal para actualizaciones en empleado
CREATE GLOBAL TEMPORARY TABLE t_empleado_update(
  empleado_id NUMERIC(10, 0) NOT NULL,
  foto BLOB NOT NULL,
  num_cuenta VARCHAR(18) NOT NULL,
  CONSTRAINT t_empleado_update_pk PRIMARY KEY (empleado_id)
) ON COMMIT PRESERVE ROWS;

PROMPT ¡¡Listo!!
EXIT
