SET@@sql_mode=SYS.LIST_DROP(@@sql_mode,'ONLY_FULL_GROUP_BY');
/* quitar error 1055 */

/*1.Obtener un listado de cuál fue el volumen de ventas (cantidad) por año y método de envío mostrando para cada registro, 
qué porcentaje representa del total del año.  Resolver utilizando Subconsultas y Funciones Ventana, 
luego comparar la diferencia en la demora de las consultas.*/
select v.año, v.metodo_de_envio, v.volumen, v.volumen/sum(v.volumen) over(partition by año) por
 from (select year(soh.orderdate) año, sm.name metodo_de_envio, sum(sod.orderqty) volumen from salesorderdetail sod
	join salesorderheader soh
	on sod.SalesOrderID=soh.SalesOrderID
	join shipmethod sm
	on soh.shipmethodid=sm.shipmethodid
	join (select sum(sod.orderqty) volumen,year(soh.orderdate) año  from salesorderdetail sod
		join salesorderheader soh
		on sod.SalesOrderID=soh.SalesOrderID
		group by year(soh.orderdate)) as por
	on  year(soh.orderdate)=por.año
group by year(soh.orderdate),2) v;


    

select year(soh.orderdate) año, sm.name metodo_de_envio, sum(sod.orderqty) volumen,
round(sum(sod.orderqty)/por.volumen*100,2) as porcentaje
 from salesorderdetail sod
	join salesorderheader soh
	on sod.SalesOrderID=soh.SalesOrderID
	join shipmethod sm
	on soh.shipmethodid=sm.shipmethodid
    join (select sum(sod.orderqty) volumen,year(soh.orderdate) año  from salesorderdetail sod
		join salesorderheader soh
		on sod.SalesOrderID=soh.SalesOrderID
		group by year(soh.orderdate)) as por
	on  year(soh.orderdate)=por.año
    group by 1,2;

/*2. Obtener un listado por categoría de productos, con el valor total de ventas y productos vendidos, 
mostrando para ambos, su porcentaje respecto del total.*/

/*subquery*/
select total.categoria,round(total.total,2)total_ventas, round(total.total,2)/(select sum(linetotal)from salesorderdetail)*100 porcentaje_ventas, total.cantidad cantidad_total, total.cantidad/(select sum(orderqty) from salesorderdetail)*100 porcentaje_cantidad
	from (select pc.name categoria,sum(sod.linetotal) total, sum(sod.OrderQty) cantidad from product p
		join productsubcategory ps
		on p.ProductSubcategoryID=ps.ProductSubcategoryID
		join productcategory pc 
		on ps.ProductCategoryID=pc.ProductCategoryID
		join salesorderdetail sod
		on p.ProductID=sod.ProductID
	group by 1) total
    group by 1;
  /*ventana*/  
    select categoria,total,total/sum(total) over(),cantidad,cantidad/sum(cantidad) over()
    from (select pc.name categoria,sum(sod.unitprice*sod.OrderQty) total, sum(sod.OrderQty) cantidad from product p
		join productsubcategory ps
		on p.ProductSubcategoryID=ps.ProductSubcategoryID
		join productcategory pc 
		on ps.ProductCategoryID=pc.ProductCategoryID
		join salesorderdetail sod
		on p.ProductID=sod.ProductID
	group by 1) v
    group by 1;

/*3. Obtener un listado por país (según la dirección de envío), con el valor total de ventas y productos vendidos,
 mostrando para ambos, su porcentaje respecto del total.*/
  select cr.name pais, round(sum(sod.linetotal),2) 'TOTAL VENTAS', round(sum(sod.linetotal),2)/(select sum(linetotal) from salesorderdetail)*100 porcentaje_total_ventas, sum(sod.OrderQty) 'productos vendidos', sum(sod.OrderQty)/(select sum(orderqty) from salesorderdetail)*100 porcentaje_prod from countryregion cr
 join stateprovince sp
 on cr.countryregioncode= sp.countryregioncode
 join address ad
 on sp.StateProvinceID=ad.StateProvinceID
 join salesorderheader soh
 on ad.AddressID=soh.ShipToAddressID
 join salesorderdetail sod
 on soh.salesorderid=sod.salesorderid
 group by 1;

select pais,total_ventas, round((total_ventas/sum(total_ventas) over()*100),2) porcentaje_ventas,productos_vendidos, round((productos_vendidos/sum(productos_vendidos) over()*100),2) porcentaje_cantidad
from (select cr.name pais, round(sum(sod.linetotal),2) TOTAL_VENTAS,  sum(sod.OrderQty) productos_vendidos from countryregion cr
 join stateprovince sp
 on cr.countryregioncode= sp.countryregioncode
 join address ad
 on sp.StateProvinceID=ad.StateProvinceID
 join salesorderheader soh
 on ad.AddressID=soh.ShipToAddressID
 join salesorderdetail sod
 on soh.salesorderid=sod.salesorderid
 group by 1) v;

/*4. Obtener por ProductID, los valores correspondientes a la mediana de las ventas (LineTotal), 
sobre las ordenes realizadas. Investigar las funciones FLOOR() y CEILING().*/

SELECT ProductID, avg(LineTotal) AS Mediana_Producto, Cnt
FROM (
	SELECT	d.ProductID,
			d.LineTotal, 
			COUNT(*) OVER (PARTITION BY d.ProductID) AS Cnt,
			ROW_NUMBER() OVER (PARTITION BY d.ProductID ORDER BY d.LineTotal) AS RowNum
	FROM	salesorderheader h
		JOIN salesorderdetail d ON (h.SalesOrderID = d.SalesOrderID)) v
WHERE 	(FLOOR(Cnt/2) = CEILING(Cnt/2) AND (RowNum = FLOOR(Cnt/2) OR RowNum = FLOOR(Cnt/2) + 1))
	OR
		(FLOOR(Cnt/2) <> CEILING(Cnt/2) AND RowNum = CEILING(Cnt/2))
GROUP BY ProductID;
