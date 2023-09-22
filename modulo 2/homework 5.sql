create database henry;

create table Carrera (
IDcarrera int auto_increment,
nombre varchar(25),
primary key (IDcarrera)
);
create table Instructores(
IDinstructor int auto_increment, 
Cedula_de_identidad varchar(25),
Nombre varchar(25),
Apellido varchar(25), 
Fecha_de_Nacimiento date, 
Fecha_de_Incorporacion date,
primary key (IDinstructor)
);
create table Cohorte(
 IDcohorte int auto_increment, 
 Codigo varchar(25),
 IDcarrera int, 
 Fecha_de_Inicio date,
 Fecha_de_Finalizacion date, 
 IDinstructor int,
 primary key (IDcohorte),
 foreign key (IDcarrera) references Carrera(IDcarrera),
 foreign key (Idinstructor) references Instructores(IDinstructor)
 );

create table Alumnos (
 IDalumno int auto_increment,
 Cedula_de_identidad int,
 Nombre varchar(25), 
 Apellido varchar(25),
 Fecha_de_Nacimiento date,
 Fecha_de_Ingreso date,
 IDcohorte int,
 primary key(IDalumno),
 foreign key(IDcohorte) references Cohorte(IDcohorte)
 );

