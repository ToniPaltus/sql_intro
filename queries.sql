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

--5. Вывести топ 3 актеров, которые больше всего появлялись в фильмах в категории “Children”.
--Если у нескольких актеров одинаковое кол-во фильмов, вывести всех.
SELECT actor.actor_id AS id,
actor.first_name AS fname,
actor.last_name AS lname,
COUNT(film.film_id) AS cnt
FROM actor INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film.film_id = film_actor.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Children'
GROUP BY actor.actor_id
HAVING count(film.film_id) IN (7, 5)               
ORDER BY cnt desc, actor.actor_id;

--6. Вывести города с количеством активных и неактивных клиентов (активный — customer.active = 1). Отсортировать по количеству неактивных клиентов по убыванию.
SELECT city.city,
    CASE
       WHEN customer.active = 1 THEN 'Active'
       WHEN customer.active = 0 THEN 'Passive'
    END AS active_group,
    count(*) AS count_customers
FROM customer INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id   
GROUP BY city.city, active_group
ORDER BY active_group desc, count_customers, city.city;

--7. Вывести категорию фильмов, у которой самое большое кол-во часов суммарной аренды в городах (customer.address_id в этом city), и которые начинаются на букву “a”. То же самое сделать для городов в которых есть символ “-”. Написать все в одном запросе.
SELECT category.name,
	SUM(film.rental_duration) AS S,
	city.city
FROM
category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film
ON film_category.film_id = film.film_id
INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN store
ON inventory.store_id = store.store_id
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
GROUP BY city.city, category.name
ORDER BY city;







