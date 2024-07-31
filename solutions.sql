-- 1. Escribe una consulta para mostrar para cada tienda su ID de tienda, ciudad y país.
SELECT s.store_id AS StoreID,
  c.city AS City,
  co.country AS Country
FROM store s
  JOIN address a ON s.address_id = a.address_id
  JOIN city c ON a.city_id = c.city_id
  JOIN country co ON c.country_id = co.country_id;
-- 2. Escribe una consulta para mostrar cuánto negocio, en dólares, trajo cada tienda.
SELECT s.store_id AS StoreID,
  SUM(p.amount) AS Amount
FROM store s
  JOIN customer c ON s.store_id = c.store_id
  JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY TotalRevenue DESC;
-- 3. ¿Cuál es el tiempo de ejecución promedio de las películas por categoría?
SELECT c.name AS Category,
  AVG(f.length) AS AverageLength
FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AverageLength DESC;
-- 4. ¿Qué categorías de películas son las más largas?
SELECT c.name AS Category,
  AVG(f.length) AS AverageLength
FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AverageLength DESC;
-- 5. Muestra las películas más alquiladas en orden descendente.
SELECT f.title AS MovieTitle,
  COUNT(r.rental_id) AS RentalCount
FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY RentalCount DESC;
-- 6. Enumera los cinco principales géneros en ingresos brutos en orden descendente.
SELECT c.name AS Category,
  SUM(p.amount) AS TotalRevenue
FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY TotalRevenue DESC
LIMIT 5;
-- 7. ¿Está "Academy Dinosaur" disponible para alquilar en la Tienda 1?
SELECT f.title AS MovieTitle,
  s.store_id AS StoreID,
  COUNT(i.inventory_id) AS AvailableCopies
FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN store s ON i.store_id = s.store_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
  AND s.store_id = 1
GROUP BY f.title,
  s.store_id
HAVING COUNT(i.inventory_id) > COUNT(r.rental_id)
ORDER BY AvailableCopies DESC;