alter table canaldeventa change DESCRIPCION Descripcion varchar(50);
select * from clientes;
alter table clientes drop column col10;
alter table proveedores change Address Direccion varchar (50);
alter table proveedores change city Ciudad varchar(50);
alter table proveedores change state Estado varchar(25);
alter table proveedores change country Pais varchar(25);

select precio from venta
where precio='' and precio=' ' and precio is null;

select p.precio,v.precio, (p.precio=v.precio) from productos p
join venta v on p.IdProducto=v.idproducto
where v.precio='';

update venta v
join productos p
on v.idproducto=p.idproducto
set v.precio=p.precio
where v.precio='';

alter table venta modify column precio float;

select distinct(localidad)from sucursales;

alter table sucursales modify column Localidad varchar(35);

update sucursales
set localidad='Ciudad Autonoma de Buenos Aires'
where localidad like '%buenos%';

update sucursales
set localidad='Ciudad Autonoma de Buenos Aires'
where localidad like 'CABA%';

update sucursales
set localidad='Ciudad Autonoma de Buenos Aires'
where localidad like 'Cap%';

update sucursales
set localidad='Córdoba'
where localidad like 'coroba';

select distinct(provincia) from sucursales
order by  provincia asc;

update sucursales
set provincia='Buenos Aires'
where provincia like 'B%Aires';

update sucursales
set provincia='Buenos Aires'
where provincia like'Bs%As%';

update sucursales
set provincia='Buenos Aires'
where provincia like'p%B%A%';

alter table sucursales modify column provincia varchar(35);

update sucursales
set provincia='Ciudad Autónoma de Buenos Aires'
where provincia like'C%B%Aires';

update sucursales
set provincia='Ciudad Autónoma de Buenos Aires'
where provincia like'Caba';

select nombre from proveedores
where nombre='';

update proveedores
set nombre='N/D'
where nombre='';

select *from proveedores
where direccion= 'SANTA ROSA 1564';

select * from compra
where IdProveedor between 7 and 8;

/*contar cuantos datos repetidos 2 o mas veces hay*/
select count(idempleado) from (select IdEmpleado from empleados
group by IdEmpleado
having count(*)>1
order by 1 asc) v;

/*ver cuales son los ids repetidos 2 o mas veces*/
select IdEmpleado from empleados
group by IdEmpleado
having count(*)>1
order by 1 asc;

/*procedimiento para cambiar un id que esta repetido do o mas veces*/
delimiter $$
drop procedure if exists updaempleados$$
create procedure updaempleados(in idset int, idwhere int, nom varchar(20))
begin
	update empleados
	set idempleado=idset
	where idempleado=idwhere and nombre=nom;
end $$
delimiter ;


/*procedimiento para aplicar a todos los datos el procecimiento updamepleados*/
DELIMITER $$ 
CREATE PROCEDURE updatodo(no1 int)
	BEGIN
		valrep : LOOP
			call updaempleados((select idempleado+1 from empleados
			order by IdEmpleado desc
			limit 1),(select idempleado from empleados
			where IdEmpleado=
			(select IdEmpleado from empleados
			group by IdEmpleado
			having count(*)>1
			limit 1)limit 1),(select nombre from empleados
			where IdEmpleado=
			(select IdEmpleado from empleados
			group by IdEmpleado
			having count(*)>1
			limit 1)limit 1,1));
            SET no1 = no1 -1;
			if no1 = 0 then
				leave valrep;
			end if;
		end loop valrep;
	end $$
delimiter ;

call updatodo((select count(idempleado) from (select IdEmpleado from empleados
group by IdEmpleado
having count(*)>1
order by 1 asc) v));
    
	call updaempleados((select idempleado+1 from empleados
	order by IdEmpleado desc
	limit 1),(select idempleado from empleados
	where IdEmpleado=
	(select IdEmpleado from empleados
	group by IdEmpleado
	having count(*)>1
	limit 1)limit 1),(select nombre from empleados
	where IdEmpleado=
	(select IdEmpleado from empleados
	group by IdEmpleado
	having count(*)>1
	limit 1)limit 1,1));
  
select *from proveedores
where nombre=  
(select nombre from proveedores
group by nombre
having count(*)>1
limit 1,1);

select count(*) from empleados
where salario='';

select * from clientes where localidad='';

update clientes
set provincia= 'N/D'
where provincia='';

update clientes
set localidad= 'N/D'
where localidad='' and provincia='N/D';

update clientes
set localidad= 'Tucumán'
where localidad='';

select * from clientes
where Nombre_y_Apellido='';

select count(v.idventa) from venta v
join clientes c
on v.idcliente=c.idcliente
where c.Nombre_y_Apellido='';

update clientes
set Nombre_y_Apellido= 'N/D'
where Nombre_y_Apellido='';

select * from clientes
where Domicilio='';

update clientes
set domicilio='N/D'
where domicilio='';

select * from clientes
where telefono='';

update clientes
set telefono='N/D'
where telefono='';

select count(*) from clientes
where edad='';

select * from clientes
where x='' and y='';
update clientes
set x='N/D', y='N/D'
where x='' and y='';

select * from clientes
where x='';
update clientes
set x='N/D'
where x='';
select count(*) from clientes
where y='';

update clientes
set y='N/D'
where y='';

select * from clientes
where Nombre_y_Apellido in
(select Nombre_y_Apellido from clientes
group by 1
having count(*)>1)
and y=''
order by nombre_y_apellido asc;

select count(Marca_Baja) from clientes
where Marca_Baja=0;

alter table clientes
drop column Marca_Baja;

select * from sucursales;

/* Normalizar los nombres de los campos y colocar el tipo de dato adecuado para cada uno en cada una de las tablas. Descartar columnas que consideres que no tienen relevancia.
Buscar valores faltantes y campos inconsistentes en las tablas sucursal, proveedor, empleado y cliente. De encontrarlos, deberás corregirlos o desestimarlos. Propone y realiza una acción correctiva sobre ese problema.
ya quedo */


/*Utilizar la funcion provista 'UC_Words' (Homework_Utiles.sql) para modificar a letra capital los campos que contengan descripciones para todas las tablas.

Chequear la consistencia de los campos precio y cantidad de la tabla de ventas.

Chequear que no haya claves duplicadas, y de encontrarla en alguna de las tablas, proponer una solución.    
 ya quedo*/

/*me quede en la tala clientes*/
