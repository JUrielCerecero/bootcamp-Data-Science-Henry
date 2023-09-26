use adventureworks;
set global log_bin_trust_function_creators = 1;
/*Homework
Ejecutar el script AdventureWorks.sql para cargar las tablas y sus registros. (Recuerda que si recibes el triángulo de alerta en vez del tilde verde, el código se ejecutó.)

1.Crear un procedimiento que recibe como parámetro una fecha y muestre la cantidad de órdenes ingresadas en esa fecha.*/

delimiter $$
drop procedure if exists orden_del_dia$$
create procedure orden_del_dia( in fecha date)
begin
	select count(date(orderdate)) 'ordenes de ese dia', fecha from purchaseorderheader
	where date(orderdate)=fecha;
end$$
delimiter ;
call orden_del_dia('2002-01-15');

/*2. Crear una función que calcule el valor nominal de un margen bruto 
determinado por el usuario a partir del precio de lista de los productos.*/


delimiter $$
drop function if exists valor_nominal$$
create function valor_nominal( precio decimal(10,3), margen decimal(10,2)) returns decimal (10,2)
begin
	declare valor_nominal decimal(10,3) default(0);
    set valor_nominal= precio*margen;
    return valor_nominal;
end $$
delimiter ;
select listprice, valor_nominal(listprice,1.1) 'valor nominal' from product
where listprice!=0;

/*3.Obtener un listado de productos en orden alfabético que muestre cuál debería ser el valor de precio de lista,
si se quiere aplicar un margen bruto del 20%, utilizando la función creada en el punto 2, sobre el campo StandardCost.
Mostrando tambien el campo ListPrice y la diferencia con el nuevo campo creado.*/
select name, listprice, valor_nominal(StandardCost,1.2) 'valor con maregn del 20%' from product
where listprice!=0
order by name asc;

/* 4.Crear un procedimiento que reciba como parámetro una fecha desde y una hasta, y muestre un listado
con los Id de los diez Clientes que más costo de transporte tienen entre esas fechas (campo Freight). */

delimiter $$
drop procedure if exists diezclientes_mascost$$
create procedure diezclientes_mascost ( in fecha_inicio date, fecha_fin date)
begin
	select customerid,sum(freight)costo_envio from salesorderheader 
	where date(shipdate) between fecha_inicio and fecha_fin
	group by customerid
	order by costo_envio desc
	limit 10;
end $$
delimiter ;
call diezclientes_mascost('2001-08-01','2001-08-31');

/* 5.Crear un procedimiento que permita realizar la insercción de datos en la tabla shipmethod.*/

delimiter $$
drop procedure if exists nuevo_reg_shipmethod $$
create procedure nuevo_reg_shipmethod( in name1 varchar(50),sb double, sr double, rg varbinary(16))
begin
	INSERT INTO shipmethod(Name,ShipBase,ShipRate,rowguid)
	VALUES
	('name1',sb,sr,rg);
end $$
delimiter ;
call nuevo_reg_shipmethod('a','3.95',0.99,0);



DELETE FROM `adventureworks`.`shipmethod`
where shipmethodid >5;

select * from shipmethod;
alter table shipmethod auto_increment=5;