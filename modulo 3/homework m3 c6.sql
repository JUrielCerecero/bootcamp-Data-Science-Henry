/*cambiar  la laitud y longitud de sucursales*/

/*Normalización
1.Es necesario contar con una tabla de localidades del país con el fin de evaluar la apertura de una nueva sucursal 
y mejorar nuestros datos. A partir de los datos en las tablas cliente, sucursal y proveedor 
hay que generar una tabla definitiva de Localidades y Provincias. Utilizando la nueva tabla de Localidades
 controlar y corregir (Normalizar) los campos Localidad y Provincia de las tablas cliente, sucursal y proveedor.*/
select distinct(provincia) from clientes c;
select distinct(provincia) from sucursales;
select * from proveedores;
/*2.Es necesario discretizar el campo edad en la tabla cliente.*/

alter table clientes modify edad varchar(10);
update clientes
set edad='18-30'
where edad between 18 and 30  or edad =18 or edad =30;
update clientes 
set edad='31-45'
where edad!= '18-30' and edad ='31' or edad ='45';

update clientes 
set edad='31-45'
where edad!= '18-30' and edad ='31' or edad ='45';

update clientes 
set edad='31-45'
where edad!= '18-30' and edad between '31' and '45';

update clientes
set edad='-17'
where edad<'18';

update clientes
set edad = '46-60'
where edad between '46' and '60'or edad='46' or edad ='60';

update clientes
set edad = '61-75'
where edad between '61' and '75'or edad='61' or edad ='75';
 select distinct(edad) from clientes
 order by edad asc;
 
select * from venta
order by cantidad desc;


-- kpis --

-- ticket promedio --
select year(fecha) año ,month(fecha) mes,round(avg(precio*cantidad),2) ticket_promedio from venta
where fecha between'2015-01-01' and '2018-10-31'
group by 1,2
order by 1 asc,3 desc;

-- gastos por mes %

select g.idsucursal, year(g.fecha) año, month(g.fecha) mes, sum(g.monto) gasto from gasto g
where  g.fecha between'2015-01-01' and '2018-01-31'
group by 1,2,3
order by 1

select idsucursal, year(fecha) año, month(fecha) mes,sum(precio*cantidad) venta from venta
where  fecha between'2015-01-01' and '2015-01-31'
group by 1,2,3
order by 1;

-- % compras por la venta de cada mes

select *  from clientes;
select distinct(provincia), localidad from clientes
group by 1,2
order by 1;
truncate table localidad;
create table localidad (IdLocalidad int auto_increment,Localidad varchar (100), Provincia varchar(100), primary key (idlocalidad));
insert into localidad (Provincia,Localidad)
select distinct(provincia), localidad from clientes
group by 1,2
order by 1;

select provincia,Localidad from proveedores
where provincia  not in (select distinct(provincia) from localidad);

insert into localidad (Provincia,Localidad)
select distinct(provincia),Localidad from proveedores 
where provincia  not in (select distinct(provincia) from localidad);


select provincia,Localidad from proveedores
where localidad  not in (select distinct(Localidad) from localidad);

insert into localidad (Provincia,Localidad)
select distinct(provincia),Localidad from proveedores 
where localidad  not in (select distinct(Localidad) from localidad);

select provincia,Localidad from sucursales 
where localidad  not in (select distinct(Localidad) from localidad);

insert into localidad (Provincia,Localidad)
select distinct(provincia),Localidad from sucursales 
where localidad  not in (select distinct(Localidad) from localidad);

insert into localidad (Provincia,Localidad)
select distinct(provincia),Localidad from sucursales 
where provincia  not in (select distinct(provincia) from localidad);

update sucursales
set localidad='Buenos Aires'
where provincia ='Buenos Aires' and localidad ='Ciudad Autonoma de Buenos Aires';

update sucursales
set Provincia = 'Buenos Aires',localidad='Buenos Aires'
where provincia ='Ciudad Autónoma de Buenos Aires' and localidad ='Ciudad Autonoma de Buenos Aires';
select distinct(provincia), localidad from localidad
where provincia ='ciudad de buenos aires' and localidad='ciudad de buenos aires';

select distinct(localidad),provincia from localidad;


create table localidad2 (IdLocalidad int auto_increment,Localidad varchar (100), Provincia varchar(100), primary key (idlocalidad));
insert into localidad2 (localidad,provincia)
select distinct(localidad),provincia from localidad;
drop table localidad;
alter table localidad rename Localidad;

create table provincia ( IdProvincia int auto_increment, provincia varchar(50), primary key (IdProvincia));
insert into provincia(provincia)
select distinct(provincia) from localidad;

update localidad l
join provincia p
on l.provincia=p.provincia
set l.Provincia= p.idprovincia
where l.Provincia=p.provincia;

ALTER TABLE `clientes` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Localidad`;
ALTER TABLE `proveedores` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `localidad`;
ALTER TABLE `sucursales` ADD `IdLocalidad` INT NOT NULL DEFAULT '0' AFTER `Provincia`;

select distinct(provincia) from clientes;
update localidad 
set provincia= 'Buenos Aires', localidad='Buenos Aires'
where provincia ='ciudad de buenos aires' and localidad='ciudad de buenos aires';
alter table proveedores change ciudad Localidad varchar (50) not null;
alter table proveedores change departamento Provincia varchar(50) not null;
drop table clientes2;
drop table proveedores2;
drop table sucursales2;



