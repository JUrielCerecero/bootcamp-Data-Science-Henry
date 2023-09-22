delete from cohorte where idcohorte=1245;
delete from cohorte where idcohorte=1246;
delete from carrera where idcarrera>2;
select * from carrera;

update cohorte set fecha_de_inicio='2022-05-16' where idcohorte=1243;
select * from cohorte where IDcohorte=1243;

select * from alumno where idalumno=165;
update alumno set apellido='Ramirez' where idalumno=165;

select distinct idinstructor from cohorte where idcarrera=1;

select * from alumno where idcohorte=1235;

select * from alumno where idcohorte=1235 and fechaingreso like'2019%';

SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera;
-- ¿Que campos permiten que se puedan acceder al nombre de la carrera? id cohorote y idcarrera
-- b. ¿Que tipo de relación existe entre el nombre la tabla cohortes y alumnos? por el id cohorte
-- c. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', utilizando LIKE y NOT LIKE?, ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? l delike es el correcto, porquer nos arroja los datos que requerimos sin recurrir a los que no coinciden con nuestra busqueda
SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera
where carrera.nombre like 'Full%';

SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera
where carrera.nombre not like 'Data%';
-- d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', utilizando " = " y " != "? ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que? 
SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera
where carrera.nombre='full stack developer';

SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera
where carrera.Nombre!='Data science';
-- e. ¿Como emplearía el filtrado utilizando el campo idCarrera?--
SELECT alumno.Nombre, Apellido, fechaNacimiento, carrera.nombre FROM alumno
INNER JOIN cohorte
ON alumno.IDcohorte=cohorte.IDcohorte
INNER JOIN carrera
ON carrera.IDcarrera = cohorte.IDcarrera
where carrera.IDcarrera=1;