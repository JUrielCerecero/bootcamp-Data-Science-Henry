/* 1. Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes",
entre los años 2000 y 2003, cuyo método de envío sea "CARGO TRANSPORT 5".*/

SELECT c.contactid,soh.orderdate 'fecha de la orden', ps.name subcategoria, soh.salesorderid,sm.name 'metodo envio' FROM contact c
join salesorderheader soh
on c.contactid=soh.contactid
join salesorderdetail sod
on soh.salesorderid=sod.salesorderid
join product p
on sod.productid=p.productid
join productsubcategory ps
on p.ProductSubcategoryID=ps.ProductSubcategoryID
join shipmethod sm
on soh.ShipMethodID=sm.ShipMethodID
where year(soh.OrderDate) between 2000 and 2003
and ps.name='Mountain Bikes' and sm.name='CARGO TRANSPORT 5';


/* 2.Obtener un listado contactos que hayan ordenado productos de la subcategoría "Mountain Bikes", 
entre los años 2000 y 2003 con la cantidad de productos adquiridos y ordenado por este valor, de forma descendente.*/
select c.contactid, sum(sod.OrderQty) 'cant.prod. adquiridos' from contact c
join salesorderheader soh
on c.contactid=soh.contactid
join salesorderdetail sod
on soh.salesorderid=sod.salesorderid
join product p
on sod.productid=p.productid
join productsubcategory ps
on p.ProductSubcategoryID=ps.ProductSubcategoryID
where year(soh.OrderDate) between 2000 and 2003
and ps.name='Mountain Bikes'
group by c.ContactID
order by 2 desc;


/* 3.Obtener un listado de cual fue el volumen de compra (cantidad) por año y método de envío.*/
select sm.Name 'metodo envio', year(soh.orderdate) 'año de compra', sum(sod.OrderQty) 'volumen de compra' from salesorderdetail sod
join salesorderheader soh
on sod.SalesOrderID=soh.SalesOrderID
join shipmethod sm
on soh.ShipMethodID=sm.ShipMethodID
group by 1,2;

/* 4.Obtener un listado por categoría de productos, con el valor total de ventas y productos vendidos.*/

select pc.name categoria,  sum(sod.linetotal),2 'TOTAL', sum(sod.OrderQty) 'productos vendidos' from productcategory pc
join productsubcategory psc
on pc.ProductCategoryID=psc.ProductCategoryID
join product p
on psc.ProductSubcategoryID=p.ProductSubcategoryID
join salesorderdetail sod
on p.ProductID= sod.ProductID
join salesorderheader soh
on sod.SalesOrderID=soh.SalesOrderID
group by 1;

/* 5.Obtener un listado por país (según la dirección de envío), con el valor total de ventas y productos vendidos,
sólo para aquellos países donde se enviaron más de 15 mil productos.*/
 select cr.name pais, round(sum(soh.TotalDue),2) 'TOTAL VENTAS', sum(sod.OrderQty) 'productos vendidos'  from countryregion cr
 join stateprovince sp
 on cr.countryregioncode= sp.countryregioncode
 join address ad
 on sp.StateProvinceID=ad.StateProvinceID
 join salesorderheader soh
 on ad.AddressID=soh.ShipToAddressID
 join salesorderdetail sod
 on soh.salesorderid=sod.salesorderid
 group by 1
 having sum(sod.OrderQty)> 15000;

/* 6. Obtener un listado de las cohortes que no tienen alumnos asignados, 
utilizando la base de datos henry, desarrollada en el módulo anterior.*/
use henry;
select c.idcohorte from cohorte c
left join alumno a
on c.idcohorte=a.idcohorte
where a.idcohorte is null;


