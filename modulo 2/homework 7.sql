-- 1 ¿Cuantas carreas tiene Henry?
select count(*) from carrera;

-- 2 ¿Cuantos alumnos hay en total?
select count(*) from alumno;

-- 3 ¿Cuantos alumnos tiene cada cohorte?
select idcohorte, count(*) from alumno
group by idcohorte;

-- 4 Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.
select concat(nombre, ' ', apellido), fechaingreso from alumno
order by fechaingreso desc;

-- 5 ¿Cual es el nombre del primer alumno que ingreso a Henry?
select concat(nombre, ' ', apellido) from alumno
order by fechaingreso asc
limit 1;

-- 6¿En que fecha ingreso?
select fechaingreso from alumno
order by fechaingreso asc
limit 1;

-- 7 ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
select concat(nombre, ' ', apellido) from alumno
order by fechaingreso desc
limit 1;

-- 8 La función YEAR le permite extraer el año de un campo date, utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.
 select (year(fechaingreso)) as año, count(year(fechaingreso)) as 'alumnos por año' from alumno
 group by (year(fechaingreso));
 
 -- 9 ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()
SELECT YEAR(fechaIngreso) AS año, WEEKOFYEAR(fechaIngreso) as semana, count(*) as cantidad
FROM alumno
GROUP BY YEAR(fechaIngreso), WEEKOFYEAR(fechaIngreso)
ORDER BY 1,2;

-- 10 ¿En que años ingresaron más de 20 alumnos?
 select (year(fechaingreso)) as año, count(year(fechaingreso)) as 'alumnos por año' from alumno
 group by (year(fechaingreso))
 having count(year(fechaingreso))>20;

-- 11 Investigue las funciones TIMESTAMPDIFF() y CURDATE(). ¿Podría utilizarlas para saber cual es la edad de los instructores?. ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().
select nombre, apellido,fechanacimiento,timestampdiff(year,fechanacimiento,curdate()) as edad
from instructor;
select nombre, apellido,fechanacimiento,timestampdiff(year,fechanacimiento,curdate()) as edad,
 date_add(fechanacimiento,interval timestampdiff(year,fechanacimiento,curdate()) year), if(date_add(fechanacimiento,interval timestampdiff(year,fechanacimiento,curdate()) year)<curdate(),'si','no')from instructor;

-- Cálcula:
-- - La edad de cada alumno.
select idalumno, fechanacimiento,timestampdiff(year,fechanacimiento,curdate()) as edad from alumno;
-- - La edad promedio de los alumnos de henry.
select avg(timestampdiff(year,fechanacimiento,curdate())) from alumno;
-- - La edad promedio de los alumnos de cada cohorte.
select round(avg(timestampdiff(year,fechanacimiento,curdate())),0) as edad_promedio , idcohorte from alumno
group by idcohorte;

select *, (timestampdiff(year,fechanacimiento,curdate())) as edad  from alumno 
where timestampdiff(year,fechanacimiento,curdate()) > (select avg(timestampdiff(year,fechanacimiento,curdate())) from alumno);

