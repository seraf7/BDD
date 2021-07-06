-- @Autor:        Humberto Serafín Castillo López
-- @Fecha:        28/06/2021
-- @Descripción:  Consultas correspondientes a los ejercicios de la serie 01
--                Tema 05

-- Ejercicio 01
-- Obtener el nombre del paciente con curp ‘ABC798701GYTOS7029’
-- Creación de indices
create unique index paciente_curp_uk on paciente(curp);
create index paciente_nombre_ix on paciente(nombre);

SELECT nombre
FROM paciente
WHERE curp = 'ABC798701GYTOS7029';

-- Ejercicio 02
-- Obtener los correos electrónicos de todos los pacientes. Solo se requiere
-- mostrar los correos electrónicos que comiencen con ‘r’.
-- Creación de indices
create unique index paciente_email_uk on paciente(email);

SELECT email
FROM paciente
WHERE email LIKE 'r%';

-- Ejercicio 03
-- Obtener el nombre de todos los pacientes cuya ocupación sea ‘GERENTE’
-- Creación de índices
create index paciente_nombre_ix on paciente(nombre);

SELECT nombre
FROM paciente
WHERE ocupacion = 'GERENTE';

-- Ejercicio 04
-- De la tabla Cita, obtener el identificador del médico que atenderá la cita
-- con id 20.
-- Creación de indices
create index cita_medico_id_ix on cita(medico_id);

SELECT medico_id
FROM cita
WHERE cita_id = 20;

-- Ejercicio 05
-- De la tabla Cita, obtener el identificador de la cita que va a ser atendida
-- por el medico con id = 40
-- Creacion de indices
create index cita_medico_id_ix on cita(medico_id);

SELECT cita_id
FROM cita
WHERE medico_id = 40;

-- Ejercicio 06
-- De la tabla medicamento, seleccionar la lista de sus identificadores.

SELECT medicamento_id
FROM medicamento;

-- Ejercicio 07
-- Obtener el nombre y apellidos de todos los pacientes con genero igual a ‘F’
-- Creación de indices
create index paciente_genero_ix on paciente(genero);

SELECT nombre, ap_paterno, ap_materno
FROM paciente
WHERE genero = 'F';

-- Ejercicio 08
-- Obtener los identificadores de los pacientes con genero igual a ‘F’
-- Creación de indices
create index paciente_genero_ix on paciente(genero);

SELECT paciente_id
FROM paciente
WHERE genero = 'F';

-- Ejercicio 09
-- Creación de indices
create index medico_nombre_ix on medico(upper(nombre));

SELECT cedula
FROM medico
WHERE nombre = 'JUAN';

-- Ejercicio 10
create index paciente_ocupacion_ix on paciente(ocupacion);

SELECT COUNT(ocupacion)
FROM paciente;
