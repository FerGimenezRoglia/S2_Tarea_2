USE universidad;

-- 1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos/as. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Devuelve el listado de los alumnos que nacieron en 1999.
SELECT nombre, apellido1, apellido2, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4. Devuelve el listado de profesores/as que no han dado de alta su número de teléfono en la base de datos y además su NIF termina en ‘K’.
SELECT nombre, apellido1, apellido2, nif FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT nombre AS asignatura, creditos, tipo FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Devuelve un listado de los profesores/as junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas: primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por apellidos y nombre.
SELECT p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.nombre AS nombre_profesor, d.nombre AS nombre_departamento FROM persona p INNER JOIN profesor prof ON p.id = prof.id_profesor INNER JOIN departamento d ON prof.id_departamento = d.id WHERE p.tipo = 'profesor' ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;

-- 7. Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno/a con NIF 26902806M.
SELECT a.nombre AS asignatura, ce.anyo_inicio AS anio_inicio, ce.anyo_fin AS anio_fin FROM alumno_se_matricula_asignatura am INNER JOIN persona p ON am.id_alumno = p.id INNER JOIN asignatura a ON am.id_asignatura = a.id INNER JOIN curso_escolar ce ON am.id_curso_escolar = ce.id WHERE p.nif = '26902806M';

-- 8. Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT d.nombre AS nombre_departamento FROM departamento d INNER JOIN profesor p ON d.id = p.id_departamento INNER JOIN asignatura a ON p.id_profesor = a.id_profesor INNER JOIN grado g ON a.id_grado = g.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT p.nombre AS nombre_alumno, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido FROM alumno_se_matricula_asignatura am INNER JOIN persona p ON am.id_alumno = p.id INNER JOIN curso_escolar ce ON am.id_curso_escolar = ce.id WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;

-- Resuelve las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1. Devuelve un listado con los nombres de todos los profesores/as y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores/as que no tienen ningún departamento asociado.
SELECT p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, d.nombre AS nombre_departamento FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN departamento d ON prof.id_departamento = d.id WHERE p.tipo = 'profesor';

-- 2. Devuelve un listado con los profesores/as que no están asociados a un departamento.
SELECT p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor WHERE p.tipo = 'profesor' AND prof.id_departamento IS NULL;

-- 3. Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT d.nombre AS nombre_departamento FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento WHERE prof.id_profesor IS NULL;

-- 4. Devuelve un listado con los profesores/as que no imparten ninguna asignatura.
SELECT p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.id IS NULL;

-- 5. Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
SELECT a.nombre AS nombre_asignatura, a.creditos AS creditos, a.tipo AS tipo_asignatura FROM asignatura a LEFT JOIN profesor p ON a.id_profesor = p.id_profesor WHERE a.id_profesor IS NULL;

-- 6. Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT d.nombre AS nombre_departamento FROM departamento d LEFT JOIN profesor p ON d.id = p.id_departamento LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor WHERE a.id IS NULL;

-- Consultas resumen:

-- 1. Devuelve el número total de alumnos existentes.
SELECT COUNT(*) AS total_alumnos FROM persona WHERE tipo = 'alumno';

-- 2. Calcula cuántos alumnos nacieron en 1999.
SELECT COUNT(*) AS alumnos_1999 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula cuántos profesores/as hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores/as que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores/as asociados y tendrá que estar ordenado de mayor a menor por el número de profesores/as.
SELECT d.nombre AS nombre_departamento, COUNT(prof.id_profesor) AS total_profesores FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento GROUP BY d.id, d.nombre HAVING total_profesores > 0 ORDER BY total_profesores DESC;

-- 4. Devuelve un listado con todos los departamentos y el número de profesores/as que hay en cada uno de ellos. Ten en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también deben aparecer en el listado.
SELECT d.nombre AS nombre_departamento, COUNT(prof.id_profesor) AS total_profesores FROM departamento d LEFT JOIN profesor prof ON d.id = prof.id_departamento GROUP BY d.id, d.nombre ORDER BY total_profesores DESC;

-- 5. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Ten en cuenta que pueden existir grados que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS total_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre ORDER BY total_asignaturas DESC;

-- 6. Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS total_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre HAVING total_asignaturas > 40 ORDER BY total_asignaturas DESC;

-- 7. Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
SELECT g.nombre AS nombre_grado, a.tipo AS tipo_asignatura, SUM(a.creditos) AS total_creditos FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id, g.nombre, a.tipo ORDER BY g.nombre, a.tipo;

-- 8. Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado tendrá que mostrar dos columnas: una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
SELECT ce.anyo_inicio AS anio_inicio, COUNT(DISTINCT asa.id_alumno) AS total_alumnos FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asa ON ce.id = asa.id_curso_escolar GROUP BY ce.anyo_inicio ORDER BY ce.anyo_inicio ASC;

-- 9. Devuelve un listado con el número de asignaturas que imparte cada profesor/a. El listado debe tener en cuenta a aquellos profesores/as que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.
SELECT p.id AS id_profesor, p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, COUNT(a.id) AS total_asignaturas FROM persona p LEFT JOIN profesor prof ON p.id = prof.id_profesor LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' GROUP BY p.id, p.nombre, p.apellido1, p.apellido2 ORDER BY total_asignaturas DESC;

-- 10. Devuelve todos los datos del alumno/a más joven.
SELECT p.id AS id_alumno, p.nombre AS nombre_alumno, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, p.fecha_nacimiento AS fecha_nacimiento FROM persona p WHERE p.tipo = 'alumno' ORDER BY p.fecha_nacimiento DESC LIMIT 1;

-- 11. Devuelve un listado con los profesores/as que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT p.id AS id_profesor, p.nombre AS nombre_profesor, p.apellido1 AS primer_apellido, p.apellido2 AS segundo_apellido, d.nombre AS nombre_departamento FROM persona p INNER JOIN profesor prof ON p.id = prof.id_profesor INNER JOIN departamento d ON prof.id_departamento = d.id LEFT JOIN asignatura a ON prof.id_profesor = a.id_profesor WHERE p.tipo = 'profesor' AND a.id IS NULL;