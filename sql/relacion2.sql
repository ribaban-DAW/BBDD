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

SYSTEM clear;

/* @------------------------------------------------------------------------@ */
/* |                           Ejercicios INSERT                            | */
/* @------------------------------------------------------------------------@ */

-- 1. Insertar un nuevo alumno con código 6, 22 años, de Sevila, con beca y nombre Luis Martínez.

SELECT "Ap1";

INSERT INTO alumnos (
	cod_al,
	edad,
	prov,
	beca,
	nombre
)
VALUES (
	6,
	22,
	'Sevilla',
	1,
	'Luis Martínez'
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM alumnos;

-- 2. Insertar una nueva asignatura con código WEB, nombre Desarrollo Web y curso 3.

SELECT "Ap2";

INSERT INTO asignatura (
	cod_asig,
	nombre,
	curso
)
VALUES (
	'WEB',
	'Desarrollo Web',
	3
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM asignatura;

-- 3. Matricular al alumno con código 3 en la asignatura WEB, en el grupo 3ESOB.

SELECT "Ap3";

INSERT INTO matricula (
	cod_al,
	cod_asig,
	grupo
)
VALUES (
	3,
	'WEB',
	'3ESOB'
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM matricula WHERE cod_asig = 'WEB';

-- 4. Insertar una profesora con código 4, grupo 3ESOB, asignatura WEB y nombre Ana Torres.

SELECT "Ap4";

INSERT INTO profesores (
	cod_prof,
	grupo,
	cod_asig,
	nombre
)
VALUES (
	4,
	'3ESOB',
	'WEB',
	'Ana Torres'
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM profesores WHERE grupo = '3ESOB';

-- 5. Insertar una nueva alumna con código 7, 28 años, de Cádiz, sin beca y nombre Marta Fernández.

SELECT "Ap5";

INSERT INTO alumnos (
	cod_al,
	edad,
	prov,
	beca,
	nombre
)
VALUES (
	7,
	28,
	'Cádiz',
	false,
	'Marta Fernández'
);

-- Para comprobar que se ha insertado correctamente
SELECT * FROM alumnos WHERE cod_al = 7;

-- 6. Insertar una nueva asignatura con código IA, nombre IntArt y curso 4.

SELECT "Ap6";

INSERT INTO asignatura (
	cod_asig,
	nombre,
	curso
)
VALUES (
	'IA',
	'IntArt',
	4
);

-- Para comprobar que se ha insertado correctamente
SELECT * FROM asignatura WHERE cod_asig = 'IA';

-- 7. Asignar el profesor con código 4 para que imparta la asignatura IA en el grupo 3ESOB.

SELECT "Ap7";

INSERT INTO profesores (
	cod_prof,
	cod_asig,
	grupo,
	nombre
)
VALUES (
	'4',
	'IA',
	'3ESOB',
	(SELECT nombre
	FROM profesores as p
	WHERE cod_prof = 4)
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM profesores;

-- 8. Matricular al alumno con código 7 en las asignaturas IA y WEB en el grupo 3ESOB.

SELECT "Ap8";

INSERT INTO matricula (
	cod_al,
	cod_asig,
	grupo
)
VALUES (
	7,
	'IA',
	'3ESOB'
),
(
	7,
	'WEB',
	'3ESOB'
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM matricula WHERE cod_al = 7;

-- 9. Insertar un nuevo profesor con código 5, grupo 4ESOA, asignatura BDII y nombre Pablo Ramírez.

SELECT "Ap9";

INSERT INTO profesores (
	cod_prof,
	grupo,
	cod_asig,
	nombre
)
VALUES (
	5,
	'4ESOA',
	'BDII',
	'Pablo Ramírez'
);

-- Para comprobar que se ha insertado correctamente.
SELECT * FROM profesores WHERE cod_prof = 5;

-- 10. Insertar una alumna con código 8, 30 años, de Valencia, con beca y nombre Elena Ruiz.

SELECT "Ap10";

INSERT INTO alumnos (
	cod_al,
	edad,
	prov,
	beca,
	nombre
)
VALUES (
	8,
	30,
	'Valencia',
	true,
	'Elena Ruiz'
);

SELECT * FROM alumnos WHERE cod_al = 8;

-- 11. Crea una única consulta que inserte 3 alumnos a la vez (inventa los datos)

SELECT "Ap11";

INSERT INTO alumnos (
	cod_al,
	edad,
	prov,
	beca,
	nombre
)
VALUES (
	333,
	20,
	'Murcia',
	true,
	'Minerva'
),
(
	666,
	21,
	'Badajoz',
	false,
	'Berto'
),
(
	999,
	22,
	'Guipuzkoa',
	false,
	'Garazi'
);

-- Para comprobar que se han insertado correctamente
SELECT * FROM alumnos WHERE cod_al > 10;

-- 12. Inserta un nuevo profesor sin incluir el grupo en el que imparte clase.

SELECT "Ap12";

INSERT INTO profesores (
	cod_prof,
	cod_asig,
	nombre
)
VALUES (
	3327,
	'PRI',
	'Alan Turing'
);

-- Para comprobar que se han insertado correctamente
SELECT * FROM profesores WHERE cod_prof = 3327;

/* @------------------------------------------------------------------------@ */
/* |                           Ejercicios DELETE                            | */
/* @------------------------------------------------------------------------@ */

-- 1. Eliminar al alumno con código 5 de la tabla alumnos.

SELECT "Ap1";

DELETE FROM matricula
WHERE cod_al = 5;

DELETE FROM alumnos
WHERE cod_al = 5;

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM alumnos;

-- 2. Eliminar la asignatura con código SAD de la tabla asignatura.

SELECT "Ap2";

DELETE FROM asignatura
WHERE cod_asig = 'SAD';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM asignatura;

-- 3. Eliminar la matrícula del alumno 4 en la asignatura BD3.

SELECT "Ap3";

DELETE FROM matricula
WHERE cod_al = 4 AND cod_asig = 'BD3';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM matricula;

-- 4. Eliminar al profesor con código 3 de la tabla profesores.

SELECT "Ap4";

DELETE FROM profesores
WHERE cod_prof = 3;

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM profesores;

-- 5. Eliminar la matrícula de todos los alumnos en la asignatura PRI.

SELECT "Ap5";

DELETE FROM matricula
WHERE cod_asig = 'PRI';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM matricula;

-- 6. Eliminar todas las asignaturas del curso 1 de la tabla asignatura.

SELECT "Ap6";

DELETE FROM profesores
WHERE cod_asig
IN (SELECT cod_asig
	FROM asignatura
	WHERE curso = 1);

DELETE FROM asignatura
WHERE curso = 1;

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM asignatura;

-- 7. Eliminar a todos los alumnos que sean de Madrid.

SELECT "Ap7";

DELETE FROM matricula
WHERE cod_al
IN (SELECT cod_al
	FROM alumnos
	WHERE prov = 'Madrid');

DELETE FROM alumnos
WHERE prov = 'Madrid';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM alumnos;

-- 8. Eliminar a todas las matrículas del grupo 2ESI.

SELECT "Ap8";

INSERT INTO matricula (
	cod_al,
	cod_asig,
	grupo
)
VALUEs (
	333,
	'IA',
	'2ESI'
);

DELETE FROM matricula
WHERE grupo = '2ESI';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM matricula;

-- 9. Eliminar a todos los profesores que imparten BDII.

SELECT "Ap9";

DELETE FROM profesores
WHERE cod_asig = 'BDII';

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM profesores;

-- 10. Eliminar todas las asignaturas que no tienen ninguna matrícula asociada.

SELECT "Ap10";

DELETE FROM profesores
WHERE cod_asig = 'IA';

DELETE FROM matricula
WHERE cod_asig = 'IA';

DELETE FROM asignatura
WHERE cod_asig
NOT IN (SELECT cod_asig
		FROM matricula);

-- Para comprobar que se ha eliminado correctamente.
SELECT * FROM asignatura;

/* @------------------------------------------------------------------------@ */
/* |                           Ejercicios UPDATE                            | */
/* @------------------------------------------------------------------------@ */

-- 1. Modificar la edad del alumno con código 2 y establecerla en 26.

SELECT "Ap1";

INSERT INTO alumnos
VALUES (
	'2',
	24,
	'Madrid',
	1,
	'Juan Suarez'
);

UPDATE alumnos
SET edad = 26
WHERE cod_al = 2;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM alumnos;

-- 2. Cambiar la provincia del alumno 3 a Valencia.

SELECT "Ap2";

UPDATE alumnos
SET prov = 'Valencia'
WHERE cod_al = 3;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM alumnos;

-- 3. Modificar el nombre de la asignatura BD3 a BDA.

SELECT "Ap3";

UPDATE asignatura
SET nombre = 'BasDatAv'
WHERE cod_asig = 'BD3';

-- Para comrpobar que se ha actualizado correctamente.
SELECT * FROM asignatura;

-- 4. Cambiar la beca de todos los alumnos que tengan más de 28 años a que tiene beca.

SELECT "Ap4";

UPDATE alumnos
SET beca = true
WHERE edad > 28;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM alumnos;

-- 5. Cambiar el grupo del alumno 1 en la asignatura PRII a 3ESOC.

SELECT "Ap5";

UPDATE matricula
SET grupo = '3ESOC'
WHERE cod_asig = 'PRII';

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM matricula;

-- 6. Actualizar el nombre del profesor con código 2 a Andrés Esteban García.

SELECT "Ap6";

UPDATE profesores
SET nombre = 'Andrés Esteban García'
WHERE cod_prof = 2;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM profesores;

-- 7. Incrementar en 1 la edad de todos los alumnos de Málaga.

SELECT "Ap7";

UPDATE alumnos
SET edad = edad + 1
WHERE prov = 'Malaga';

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM alumnos;

-- 8. Cambiar el grupo del profesor con código 3 en la asignatura BD3 a 2ESOA.

SELECT "Ap8";

INSERT INTO profesores
VALUES (
	'3',
	'2ESI',
	'BD3',
	'Raul Aguilar'
);

UPDATE profesores
SET grupo = '2ESOA'
WHERE cod_prof = 3;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM profesores;

-- 9. Modificar el curso de la asignatura PRII y establecerlo en 4.

SELECT "Ap9";

UPDATE asignatura
SET curso = 4
WHERE cod_asig = 'PRII';

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM asignatura;

-- 10. Cambiar el nombre del alumno con código 4 a Miguel Ángel Lara.

SELECT "Ap10";

UPDATE alumnos
SET nombre = 'Miguel Ángel Lara'
WHERE cod_al = 4;

-- Para comprobar que se ha actualizado correctamente.
SELECT * FROM alumnos;
