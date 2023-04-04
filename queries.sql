--1. Вывести количество фильмов в каждой категории, отсортировать по убыванию.
SELECT category_id AS category, COUNT(film_id) AS film_count
FROM film_category
GROUP BY category_id
ORDER BY film_count desc;

--2. Вывести 10 актеров, чьи фильмы большего всего арендовали,
-- отсортировать по убыванию.
SELECT actor.first_name AS fname,
actor.last_name AS lname,
SUM(film.rental_duration) AS rduration
FROM actor INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
GROUP BY actor.actor_id
ORDER BY rduration DESC
LIMIT 10;

--3. Вывести категорию фильмов, на которую потратили больше всего денег.
SELECT category.name AS c_name,
SUM(film.rental_rate) AS rate
FROM category INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film
ON film_category.film_id = film.film_id
GROUP BY category.category_id
ORDER BY rate DESC
LIMIT 1;

--4. Вывести названия фильмов, которых нет в inventory.
--Написать запрос без использования оператора IN.
SELECT film.film_id, film.title AS f_name
FROM inventory RIGHT JOIN film
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL;
