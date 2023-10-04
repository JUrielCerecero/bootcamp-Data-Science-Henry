select count(distinct(idcliente)) from clientes;
update clientes c
join provincia p
on c.provincia=p.provincia
set c.provincia=p.idprovincia
where c.provincia=p.provincia;

select Provincia from provincia;
select distinct provincia from clientes;

update clientes
set provincia='Buenos Aires'
where provincia='Ciudad de Buenos Aires';
alter table clientes modify provincia int;

update clientes
set localidad='Buenos Aires'
where localidad='Ciudad de Buenos Aires';

update clientes c
join localidad l
on c.localidad=l.localidad
set c.idlocalidad=l.idlocalidad
where c.localidad=l.localidad and c.provincia=l.idprovincia;

alter table clientes drop column localidad;
alter table clientes drop column  provincia;

select * from proveedores;

update proveedores p
join provincia pr
on p.provincia=pr.provincia
set p.provincia=pr.idprovincia
where p.provincia=pr.provincia;

update proveedores p
join localidad l
on p.localidad=l.localidad
set p.idlocalidad=l.idlocalidad
where p.localidad=l.localidad and p.provincia=l.idprovincia;

select * from sucursales;

update sucursales s
join provincia pr
on s.provincia=pr.provincia
set s.provincia=pr.idprovincia
where s.provincia=pr.provincia;

update sucursales s
join localidad l
on s.localidad=l.localidad
set s.idlocalidad=l.idlocalidad
where s.localidad=l.localidad and s.provincia=l.idprovincia;

select * from aux_venta;

alter table clientes add primary key(idcliente);
alter table compra add primary key (idcompra);
alter table empleados add primary key (idempleado);
alter table gasto add primary key (idgasto);
alter table productos add primary key (idproducto);
alter table proveedores add primary key (idproveedor);
alter table sucursales add primary key (idsucursal);
alter table tipodegasto add primary key (idtipogasto);
alter table venta add primary key(idventa);

create index Fecha on compra(fecha);
ADD CONSTRAINT `idproveedor`
  FOREIGN KEY (`IdProveedor`)
  REFERENCES `henry_m3`.`proveedores` (`IDProveedor`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE `henry_m3`.`empleados` 
ADD CONSTRAINT `idsucursal2`
  FOREIGN KEY (`idsucursal`)
  REFERENCES `henry_m3`.`sucursales` (`IdSucursal`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `idsector`
  FOREIGN KEY (`idsector`)
  REFERENCES `henry_m3`.`sector` (`idsector`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `idcargo`
  FOREIGN KEY (`idcargo`)
  REFERENCES `henry_m3`.`cargo` (`idcargo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
ALTER TABLE compra ADD FOREIGN KEY(idproducto) 
  REFERENCES productos(idproducto);
alter table gasto add foreign key (idsucursal)
references sucursales(idsucursal);
alter table gasto add foreign key (idtipogasto)
references tipodegasto(idtipogasto);
create index fecha on gasto(fecha);

alter table localidad change provincia IdProvincia int;

alter table localidad add foreign key (idprovincia)references provincia(idprovincia);

CREATE TABLE IF NOT EXISTS fact_venta (
	IdVenta INT,
    Fecha DATE,
    Fecha_Entrega DATE,
    IdCanal INT,
    IdCliente INT,
    IdEmpleado INT,
    IdProducto INT,
    Precio DECIMAL(15,3),
    Cantidad INT
);



INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020 AND outlier = 0;

SELECT * FROM fact_venta;

ALTER TABLE fact_venta ADD PRIMARY KEY(IdVenta);
ALTER TABLE fact_venta ADD INDEX(Fecha);
ALTER TABLE fact_venta ADD INDEX(Fecha_Entrega);
ALTER TABLE fact_venta ADD INDEX(IdCanal);
ALTER TABLE fact_Venta ADD INDEX(IdCliente);
ALTER TABLE fact_Venta ADD INDEX(IdEmpleado);
ALTER TABLE fact_venta ADD INDEX (IdProducto);

select distinct(motivo) from aux_venta;

select v.*,a.minimo,a.maximo from venta v
join (select  idproducto,(avg(precio)-(3*stddev(precio))) minimo,(avg(precio)+(3*stddev(precio)))maximo from venta
group by 1) a
on v.idproducto=a.IdProducto
where precio<minimo or precio>maximo;
select count(*) from venta;

select v.*,a.minimo,a.maximo from venta v
join (select  idproducto,(avg(cantidad)-(3*stddev(cantidad))) minimo,(avg(cantidad)+(3*stddev(cantidad)))maximo from venta
group by 1) a
on v.idproducto=a.IdProducto
where cantidad<minimo or cantidad>maximo;

INSERT INTO `henry_m3`.`aux_venta`
(`IdVenta`,
`Fecha`,
`Fecha_Entrega`,
`IdCliente`,
`IdSucursal`,
`IdEmpleado`,
`IdProducto`,
`Precio`,
`Cantidad`,
`Motivo`)
select v.IdVenta,
v.Fecha,
v.Fecha_Entrega,
v.IdCliente,
v.IdSucursal,
v.IdEmpleado,
v.IdProducto, v.Precio, v.Cantidad,2 from venta v
join (select  idproducto,(avg(precio)-(3*stddev(precio))) minimo,(avg(precio)+(3*stddev(precio)))maximo from venta
group by 1) a
on v.idproducto=a.IdProducto
where precio<minimo or precio>maximo;

INSERT INTO `henry_m3`.`aux_venta`
(`IdVenta`,
`Fecha`,
`Fecha_Entrega`,
`IdCliente`,
`IdSucursal`,
`IdEmpleado`,
`IdProducto`,
`Precio`,
`Cantidad`,
`Motivo`)
select v.IdVenta,
v.Fecha,
v.Fecha_Entrega,
v.IdCliente,
v.IdSucursal,
v.IdEmpleado,
v.IdProducto, v.Precio, v.Cantidad,3 from venta v
join (select idproducto,(avg(cantidad)-(3*stddev(cantidad))) minimo,(avg(cantidad)+(3*stddev(cantidad)))maximo from venta
group by 1) a
on v.idproducto=a.IdProducto
where cantidad<minimo or cantidad>maximo;

select count(*) from venta;


select v.*,a.minimo,a.maximo from venta v
join (select  idproducto,(avg(precio)-(3*stddev(precio))) minimo,(avg(precio)+(3*stddev(precio)))maximo from venta
group by 1) a
on v.idproducto=a.IdProducto
where precio<minimo or precio>maximo;
select count(*) from venta;
