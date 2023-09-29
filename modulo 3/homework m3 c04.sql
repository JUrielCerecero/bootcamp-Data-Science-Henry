create database if not exists henry_m3;
create table CanalDeVenta (IdCanal int, DESCRIPCION varchar (50), primary key (IdCanal));
create table Clientes (IdCliente int, Provincia varchar (50), Nombre_y_Apellido varchar (150), Domicilio varchar(250), Telefono varchar(30), 
Edad int (3), Localidad varchar(60), X varchar(25), Y varchar(25), Fecha_Alta date, Usuario_Alta varchar(25), Fecha_Ultima_Modificacion date, 
Usuario_Ultima_Modificacion varchar(25),Marca_Baja int,col10  varchar (10),
primary key (IdCliente));
create table Productos (IdProducto int, Concepto varchar(60), Tipo varchar(20), Precio float(2),
primary key (Idproducto));
create table Proveedores (IDProveedor int, Nombre varchar(40), Address varchar(50), City varchar (30),
State varchar(25),Country varchar(25), departamento varchar(25),
primary key (IDProveedor));
create table compra (IdCompra int, Fecha date, IdProducto int,Cantidad int, Precio float(2), IdProveedor int,
primary key (IdCompra), 
foreign key (IdProducto) references Productos(IdProducto),
foreign key (IdProveedor) references Proveedores(IdProveedor));
create table Sucursales (IdSucursal int, Sucursal varchar (25), Direccion varchar(50), Localidad varchar(25), 
Provincia varchar(25), Latitud varchar(15), Longitud varchar(15),
primary key (IdSucursal));
create table Empleados (IdEmpleado int, Apellido varchar(25), Nombre varchar(25), Sucursal varchar (20), 
Sector varchar (25), Cargo varchar (20), Salario int);
create table Gasto(IdGasto int, IdSucursal int, IdTipoGasto int, Fecha date, Monto float(2),
primary key (IdGasto), 
foreign key (IdSucursal) references Sucursales(IdSucursal));
create table TipoDeGasto (IdTipoGasto int, Descripcion varchar(20), Monto_Aproximado int,
primary key(IdtipoGasto));
create table Venta(IdVenta int, Fecha date, Fecha_Entrega date, IdCanal int, IdCliente int, IdSucursal int, IdEmpleado int, IdProducto int, Precio varchar(15), Cantidad varchar(10),
primary key(Idventa),
foreign key (IdCanal) references CanalDeVenta(IdCanal),
foreign key (IdCliente) references Clientes(IdCliente),
foreign key (IdSucursal) references Sucursales(IdSucursal),
foreign key (IdProducto) references Productos(IdProducto));
/*foreign key (IdEmpleado) references Empleados(IdEmpleado),*/

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CanalDeVenta.csv'
into table CanalDeVenta
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

select * from canaldeventa;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Clientes.csv'
into table Clientes
FIELDS TERMINATED BY ';'
IGNORE 1 LINES;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Productos.csv'
into table productos
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Proveedores.csv'
into table proveedores
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Compra.csv'
into table Compra
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Sucursales.csv'
into table sucursales
FIELDS TERMINATED BY ';'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Gasto.csv'
into table Gasto
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\TiposDeGasto.csv'
into table tipodegasto
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Empleados.csv'
into table Empleados
FIELDS TERMINATED BY ','
IGNORE 1 LINES;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\venta.csv'
into table venta
FIELDS TERMINATED BY ','
IGNORE 1 LINES
(IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdSucursal, IdEmpleado, IdProducto, Precio, Cantidad);

/*drop table venta;
drop table canaldeventa;
drop table clientes;
drop table compra;
drop table productos;
drop table proveedores;
drop table gasto;
drop table sucursales;
drop table tipodegasto;
drop table empleados;*/


