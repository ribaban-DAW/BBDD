/* @------------------------------------------------------------------------@ */
/* |                            Código copiado                              | */
/* @------------------------------------------------------------------------@ */

drop database if exists Relacion1;

create database Relacion1;
use Relacion1;

DROP TABLE IF EXISTS matricula;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS alumnos;
DROP TABLE IF EXISTS asignatura;

create table alumnos (
	cod_al varchar(5) primary key,
	edad int not null,
	prov varchar(20) not null,
	beca varchar(1) not null,
	nombre varchar(40)
)Engine=InnoDB;

create table asignatura (
	cod_asig varchar(4) primary key,
	nombre varchar(20) not null,
	curso int not null
)Engine=InnoDB;

create table matricula (
	cod_al varchar(40) not null,
	cod_asig varchar(4) not null,
	grupo varchar(5) not null,
	primary key (cod_al, cod_asig),
	constraint a1 foreign key (cod_al) references alumnos(cod_al),
	constraint a2 foreign key (cod_asig) references asignatura(cod_asig)
)Engine=InnoDB;

create table profesores (
	cod_prof varchar(5) not null,
	grupo varchar(5) not null,
	cod_asig varchar(4) not null,
	nombre varchar(40) not null,
	primary key (cod_prof, cod_asig),
	constraint a3 foreign key (cod_asig) references asignatura(cod_asig)
)Engine=InnoDB;

INSERT INTO alumnos VALUES ('1',25, 'Malaga', 1,'Jose Perez');
INSERT INTO alumnos VALUES ('2',24, 'Madrid', 1,'Juan Suarez');
INSERT INTO alumnos VALUES ('3',27, 'Barcelona', 0,'Victor Sanchez');
INSERT INTO alumnos VALUES ('4',29, 'Malaga', 0,'Miguel Lara');
INSERT INTO alumnos VALUES ('5',31, 'Granada', 0,'Raul Ortega');

INSERT INTO asignatura VALUES ('BDII', 'Base de datos II', 4);
INSERT INTO asignatura VALUES ('PRII', 'Programacion II', 3);
INSERT INTO asignatura VALUES ('BD3', 'Base de datos', 2);
INSERT INTO asignatura VALUES ('PRI', 'Programacion I', 1);
INSERT INTO asignatura VALUES ('SAD', 'Seg y Alta Disp', 2);

INSERT INTO matricula VALUES ('1', 'PRII', '2ESOC');
INSERT INTO matricula VALUES ('1', 'BD3', '2ESOC');
INSERT INTO matricula VALUES ('2', 'BDII', '3ESOA');
INSERT INTO matricula VALUES ('2', 'PRI', '3ESOA');
INSERT INTO matricula VALUES ('3', 'BDII', '3ESOA');
INSERT INTO matricula VALUES ('4', 'BD3', '2ESI');
INSERT INTO matricula VALUES ('4', 'PRI', '2ESI');
INSERT INTO matricula VALUES ('5', 'BD3', '2ESI');
INSERT INTO matricula VALUES ('5', 'PRI', '2ESI');
INSERT INTO matricula VALUES ('5', 'SAD', '2ESI');

INSERT INTO profesores VALUES ('1', '2ESOC', 'PRII','Juan Lopez');
INSERT INTO profesores VALUES ('1', '2ESOC', 'PRI','Juan Lopez');
INSERT INTO profesores VALUES ('2', '2ESO', 'BDII','Andres Esteban');
INSERT INTO profesores VALUES ('2', '2ESO', 'BD3','Andres Esteban');
INSERT INTO profesores VALUES ('3', '2ESI', 'BD3','Raul Aguilar');
INSERT INTO profesores VALUES ('3', '2ESI', 'PRI','Raul Aguilar');

/* @------------------------------------------------------------------------@ */
/* |                              Ejercicios                                | */
/* @------------------------------------------------------------------------@ */

-- 1. Obtener la lista de los alumnos matriculados en la asignatura de código BD3.

SELECT "Ap1";

SELECT nombre
FROM alumnos
WHERE cod_al
IN (SELECT cod_al
	FROM matricula
	WHERE cod_asig = 'BD3');

-- 2. Obtener la lista de los alumnos matriculados en Base de Datos.

SELECT "Ap2";

SELECT nombre
FROM alumnos
WHERE cod_al
IN (SELECT cod_al
	FROM matricula
	WHERE cod_asig
	IN (SELECT cod_asig
		FROM asignatura
		WHERE nombre = 'Base de Datos'));

-- 3. Encontrar los profesores que imparten la asignatura Programación I.

SELECT "Ap3";

SELECT nombre
FROM profesores
WHERE cod_asig
IN (SELECT cod_asig
	FROM asignatura
	WHERE nombre = 'Programación I');

-- 4. Dado el alumno 'José Pérez', encontrar la lista de las asignaturas en las que está matriculado, detallando nombre y curso.

SELECT "Ap4";

SELECT nombre, curso
FROM asignatura
WHERE cod_asig
IN (SELECT cod_asig
	FROM matricula
	WHERE cod_al
	IN (SELECT cod_al
		FROM alumnos
		WHERE nombre = 'José Pérez'));

-- 5. Listar los profesores del alumno José Pérez.

SELECT "Ap5";

SELECT nombre
FROM profesores
WHERE cod_asig
IN (SELECT cod_asig
	FROM matricula
	WHERE cod_al
	IN (SELECT cod_al
		FROM alumnos
		WHERE nombre = 'José Pérez'));

-- 6. Listar los alumnos del profesor Juan López.

SELECT "Ap6";

SELECT DISTINCT al.nombre
FROM alumnos AS al,
	matricula AS m,
	profesores AS p
WHERE al.cod_al = m.cod_al
AND m.grupo = p.grupo
AND m.cod_asig = p.cod_asig;

-- 7. Lista todos los alumnos completamente de segundo curso.

SELECT "Ap7";

SELECT alumnos.nombre
FROM alumnos
WHERE (SELECT COUNT(matricula.cod_asig)
		FROM alumnos, matricula, asignatura
		WHERE alumnos.cod_al = matricula.cod_al
		AND matricula.cod_asig = asignatura.cod_asig
		AND asignatura.curso = 2);

-- 8. Listar todos los alumnos matriculados de alguna asignatura de segundo curso.

SELECT "Ap8";

SELECT DISTINCT alumnos.nombre
FROM alumnos, matricula, asignatura
WHERE alumnos.cod_al = matricula.cod_al
AND matricula.cod_asig = asignatura.cod_asig
AND asignatura.curso = 2;

-- 9. Listar todos los alumnos que tengan alguna asignatura de segundo pero que no sean de segundo.

SELECT "Ap9";

SELECT nombre
FROM alumnos
WHERE cod_al
IN (SELECT cod_al
	FROM matricula
	WHERE cod_asig
	IN (SELECT cod_asig
		FROM asignatura
		WHERE curso = 2))
AND nombre NOT IN (SELECT nombre
					FROM alumnos
					WHERE (SELECT COUNT(asignatura.cod_asig)
							FROM asignatura
							WHERE curso = 2) = (SELECT COUNT(asignatura.cod_asig)
												FROM alumnos, matricula, asignatura
												WHERE alumnos.cod_al = matricula.cod_al
												AND matricula.cod_asig = asignatura.cod_asig
												AND curso = 2));

-- 10. Listar los alumnos becados que son de fuera de Granada.

SELECT "Ap10";

SELECT nombre
FROM alumnos
WHERE prov
NOT LIKE 'Granada'
AND beca = true;

-- 11. Listar los alumnos mayores de 25 años que tengan alguna asignatura de primero.

SELECT "Ap11";

SELECT nombre
FROM alumnos
WHERE edad > 25
AND EXISTS (SELECT *
			FROM matricula
			WHERE alumnos.cod_al = matricula.cod_al
			AND EXISTS (SELECT *
						FROM asignatura
						WHERE matricula.cod_asig = asignatura.cod_asig
						AND asignatura.curso = 1));

-- 12. Encontrar todas las parejas de profesores que imparten una misma asignatura.

SELECT "Ap12";

SELECT p1.nombre AS n1, p2.nombre AS n2
FROM profesores AS p1, profesores AS p2
WHERE p1.cod_asig = p2.cod_asig
AND p1.cod_prof = p2.cod_prof;

-- 13. Listar las asignaturas que tengan matriculados alumnos de Málaga.

SELECT "Ap13";

SELECT DISTINCT asignatura.nombre
FROM alumnos, matricula, asignatura
WHERE alumnos.prov
LIKE 'Málaga'
AND alumnos.cod_al = matricula.cod_al
AND asignatura.cod_asig = matricula.cod_asig;

-- 14. Listar los alumnos que no tienen ninguna asignatura pendiente.

SELECT "Ap14";

SELECT nombre
FROM alumnos
WHERE cod_al
NOT IN (SELECT m1.cod_al
		FROM matricula AS m1, matricula AS m2, asignatura AS a1, asignatura AS a2
		WHERE m1.cod_al = m2.cod_al
		AND m1.cod_asig != m2.cod_asig
		AND a1.curso != a2.curso);
