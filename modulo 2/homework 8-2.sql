use henry;
/*A partir de tener los datos disponibles, responder a las siguientes preguntas:
a) ¿Cuál es el barrio con mayor cantidad de Pubs? */
select  categoria, barrio, count(categoria) cantidad from oferta
where categoria='pub'
group by categoria,barrio
order by cantidad desc
limit 5;

/*b) Obtener la cantidad de locales por categoría */
select categoria , count(categoria) cantidad from oferta
group by categoria;

/*c) Obtener la cantidad de restaurantes por comuna*/
select comuna, count(comuna) cantidad from oferta
group by comuna
order by cantidad desc;