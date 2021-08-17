-- @Autor:            Humberto Serafín Castillo López
-- @Fecha creación:   10/08/2021
-- @Descripción:      Creación de sinónimos en el nodo iclbd_s2

-- Sinónimos para sclbd_s1
CREATE OR REPLACE SYNONYM pais_r4 FOR pais_r_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM programa_f1 FOR programa_f1_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM documental_f1 FOR documental_f1_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pelicula_f1 FOR pelicula_f1_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM playlist_f1 FOR playlist_f1_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM tipo_serie_r4 FOR tipo_serie_r_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM serie_f1 FOR serie_f1_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM tipo_cuenta_r4 FOR tipo_cuenta_r_scl_s1@sclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM usuario_f3 FOR usuario_f3_scl_s1@sclbd_s1.fi.unam;

-- Sinónimos para sclbd_s2
CREATE OR REPLACE SYNONYM pais_r2 FOR pais_r_scl_s2@sclbd_s2.fi.unam;
CREATE OR REPLACE SYNONYM tipo_cuenta_r2 FOR tipo_cuenta_r_scl_s2@sclbd_s2.fi.unam;
CREATE OR REPLACE SYNONYM tipo_serie_r2 FOR tipo_serie_r_scl_s2@sclbd_s2.fi.unam;
CREATE OR REPLACE SYNONYM usuario_f5 FOR usuario_f5_scl_s2@sclbd_s2.fi.unam;

-- Sinónimos para iclbd_s1
CREATE OR REPLACE SYNONYM archivo_programa_f2 FOR archivo_programa_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pais_r3 FOR pais_r_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM programa_f2 FOR programa_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM documental_f2 FOR documental_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM pelicula_f2 FOR pelicula_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM usuario_f1 FOR usuario_f1_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM playlist_f2 FOR playlist_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM tipo_serie_r3 FOR tipo_serie_r_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM serie_f2 FOR serie_f2_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM tipo_cuenta_r3 FOR tipo_cuenta_r_icl_s1@iclbd_s1.fi.unam;
CREATE OR REPLACE SYNONYM usuario_f4 FOR usuario_f4_icl_s1@iclbd_s1.fi.unam;

-- Sinónimos locales
CREATE OR REPLACE SYNONYM archivo_programa_f1 FOR archivo_programa_f1_icl_s2;
CREATE OR REPLACE SYNONYM pais_r1 FOR pais_r_icl_s2;
CREATE OR REPLACE SYNONYM programa_f3 FOR programa_f3_icl_s2;
CREATE OR REPLACE SYNONYM documental_f3 FOR documental_f3_icl_s2;
CREATE OR REPLACE SYNONYM pelicula_f3 FOR pelicula_f3_icl_s2;
CREATE OR REPLACE SYNONYM playlist_f3 FOR playlist_f3_icl_s2;
CREATE OR REPLACE SYNONYM tipo_serie_r1 FOR tipo_serie_r_icl_s2;
CREATE OR REPLACE SYNONYM serie_f3 FOR serie_f3_icl_s2;
CREATE OR REPLACE SYNONYM tipo_cuenta_r1 FOR tipo_cuenta_r_icl_s2;
CREATE OR REPLACE SYNONYM usuario_f2 FOR usuario_f2_icl_s2;
CREATE OR REPLACE SYNONYM historico_status_programa_f1 FOR historico_status_programa_f1_icl_s2;
