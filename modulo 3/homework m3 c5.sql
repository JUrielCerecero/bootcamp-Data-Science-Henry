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
*/
select * from canaldeventa;
update canaldeventa
set descripcion= UC_words(descripcion);

select * from clientes;
update clientes
set nombre_y_apellido= UC_words(Nombre_y_apellido);
update clientes
set domicilio=uc_words(domicilio);
update clientes
set localidad=uc_words(localidad);

select *from compra;
select * from empleados;
select * from gasto;
select * from productos;
update productos
set concepto=uc_words(concepto);
update productos
set tipo=uc_words(tipo);

select * from proveedores;
update proveedores
set nombre=uc_words(nombre);
update proveedores
set direccion=uc_words(direccion);
update proveedores
set ciudad=uc_words(ciudad);
update proveedores
set estado=uc_words(estado);
update proveedores
set pais=uc_words(pais);
update proveedores
set departamento=uc_words(departamento);

select * from sucursales;
select * from tipodegasto;

/*Chequear la consistencia de los campos precio y cantidad de la tabla de ventas.*/
select * from venta;
select count(v.precio=p.precio), count(v.precio)from venta v
join productos p
on v.idproducto=p.idproducto;
/*Chequear que no haya claves duplicadas, y de encontrarla en alguna de las tablas, proponer una solución.    
 ya quedo*/


/*Normalización
Generar dos nuevas tablas a partir de la tabla 'empelado' que contengan las entidades Cargo y Sector.*/
select distinct(sector) from empleados;
create table cargo(idcargo int auto_increment, tipodecargo varchar (30), primary key (idcargo));
INSERT INTO cargo (tipodecargo) 
SELECT DISTINCT Cargo 
FROM empleados 
ORDER BY Cargo;

update empleados e
join cargo c
on e.idcargo=c.tipodecargo
set e.idcargo=c.idcargo;
alter table empleados change idcargo idcargo int;
select distinct(idcargo) from empleados;


create table sector(idsector int auto_increment, sector varchar(30),primary key (idsector));
INSERT INTO sector (sector) 
SELECT DISTINCT sector 
FROM empleados
ORDER BY sector;

update empleados e
join sector s
on e.sector=s.sector
set e.sector=s.idsector;
alter table empleados change sector idsector int;

/*Generar una nueva tabla a partir de la tabla 'producto' que contenga la entidad Tipo de Producto.*/
create table TipoDeProducto();
select * from productos;
create table TipoDeProducto 
(IdTipoDeProducto int auto_increment, TipoDeProducto varchar (30),primary key(IdTipoDeProducto));
insert into TipoDeProducto(TipoDeProducto)
select distinct(tipo) from productos
order by tipo;
update productos p
join tipodeproducto t
on p.tipo=t.tipodeproducto
set p.tipo=t.idtipodeproducto;
alter table productos change tipo IdTipoDeProducto int;

SELECT-- el nombre completo en este campo (APELLIDO NOMBRES)
SUBSTRING(Nombre_y_Apellido,1,LOCATE(" ",Nombre_y_Apellido)) AS apellido ,
SUBSTRING(Nombre_y_Apellido,LOCATE(" ",Nombre_y_Apellido)+1,LENGTH(Nombre_y_Apellido) ) AS nombres
FROM clientes;

SELECT substring(Nombre_y_Apellido,1,length(Nombre_y_Apellido)-1-length(SUBSTRING_INDEX(nombre_y_apellido, ' ', -1))) nombre, SUBSTRING_INDEX(nombre_y_apellido, ' ', -1) apellido from clientes;
alter table clientes add column nombre varchar(50);
alter table clientes add column apellido varchar (50);
update clientes
set nombre=substring(Nombre_y_Apellido,1,length(Nombre_y_Apellido)-1-length(SUBSTRING_INDEX(nombre_y_apellido, ' ', -1)));
update clientes
set apellido =SUBSTRING_INDEX(nombre_y_apellido, ' ', -1);
delete from clientes 
where nombre is not null;

select domicilio from clientes;

select * from clientes;

select count(*) from empleados;

update empleados e
join sucursales s
on e.sucursal=s.sucursal
set e.sucursal= s.idsucursal;

alter table empleados change sucursal idsucursal int;
alter table sucursales change nombre Nombre varchar(25);

CREATE TABLE IF NOT EXISTS `aux_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCliente`			INTEGER, 
  `IdSucursal`			INTEGER,
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				FLOAT,
  `Cantidad`			INTEGER,
  `Motivo`				INTEGER  		-- El campo motivo nos va a servir para identificar las ventas que tengas problemas
);

UPDATE venta v JOIN productos p 
		ON (v.IdProducto = p.IdProducto)
SET v.Precio = p.Precio
WHERE v.Precio = 0;

SELECT * FROM venta
WHERE precio = 0;

SELECT * FROM venta
WHERE Cantidad = '';


INSERT INTO aux_venta (IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad, Motivo)
SELECT IdVenta, Fecha, Fecha_Entrega, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, 0, 1
FROM venta WHERE Cantidad = '' OR Cantidad IS NULL or cantidad=0;

SELECT * FROM aux_venta;

UPDATE venta SET Cantidad = 1 WHERE Cantidad =0 OR ISNULL(Cantidad); -- Aca modificamos los datos vacios en cantidad

ALTER TABLE venta CHANGE Cantidad Cantidad INT NOT NULL DEFAULT 1;


select * from venta
where cantidad = 1;


/*Utilizar la funcion provista 'UC_Words' (Homework_Utiles.sql) para modificar a letra capital los campos que contengan descripciones para todas las tablas.*/
/*Utilizar el procedimiento provisto 'Llenar_Calendario' (Homework_Utiles.sql) para poblar la tabla de calendario.*/