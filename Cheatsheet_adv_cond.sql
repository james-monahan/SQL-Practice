--row example (also ORDER BY OFFSET)

WITH first_orders AS (
SELECT * FROM (
	SELECT p.*, 
	       ROW_NUMBER() OVER(PARTITION BY p.customer_id ORDER BY p.payment_date )
	       FROM payment p
	       ORDER BY 2
	)t WHERE t.row_number = 1
)
-------------------------------------------------------------------------
WITH ranked_orders AS (
SELECT p.*, 
ROW_NUMBER() OVER(PARTITION BY p.customer_id ORDER BY p.payment_date )
FROM payment p
ORDER BY 2
)

SELECT ro.*,
CASE 
 WHEN ro.row_number = 1 THEN 'new_order'
 WHEN ro.row_number > 1 THEN 'rept_order'
  ELSE 'oops' END as outcome
FROM ranked_orders ro

-------------------------------------------------------------------------
with random_numbers as (
	select random() * 100 as val
	FROM generate_series(1,100)
)

SELECT rn.*, 
   CASE 
     WHEN rn.val < 50 THEN 'lt_50'
     WHEN rn.val >=50 THEN 'gte_50'
     ELSE 'some_other_condition'
     END as rand_outcome

FROM random_numbers rn

-------------------------------------------------------------------------
WITH base_table AS (
 SELECT p.customer_id, p.payment_date, 
 row_number() over(partition by p.customer_id order by p.payment_date asc) as early_order,
 row_number() over(partition by p.customer_id order by p.payment_date desc) as late_order	
 FROM payment p
), second_table AS (

	SELECT * FROM base_table bt 
	WHERE bt.early_order = 1 OR bt.late_order = 1
)

SELECT st.customer_id, max(st.payment_date) as rec_order, min(st.payment_date) as first_order,
(
	SELECT SUM(p2.amount) FROM payment p2 WHERE p2.customer_id = st.customer_id
) as ltv_spend
FROM second_table st 
GROUP BY 1 ORDER BY 1

-------------------------------------------------------------------------
SELECT t.customer_id, count(*) ,  array_agg(distinct t.rating),
row_number() over(partition by t.customer_id ORDER BY COUNT(*) DESC)
FROM (
	SELECT r.customer_id, r.inventory_id, i.film_id, f.rating
	FROM rental r
	 JOIN inventory i on r.inventory_id = i.inventory_id
	 JOIN film f ON f.film_id = i.film_id
) t GROUP BY 1
ORDER BY 1, 3 DESC

-------------------------------------------------------------------------
SELECT t.*, 
 t.payment_date - t.prior_order as some_interval, -- raw interval
 EXTRACT(epoch FROM t.payment_date - t.prior_order ) / 3600 as hours_since-- interval to hours
 
 FROM (
	SELECT p.*, 
		lag(p.payment_date) OVER (PARTITION BY p.customer_id) as prior_order
	FROM payment p
)t

-- Alternate Syntax and Some Moving Calculations

SELECT p.* , 
	avg(p.amount) over w2 as avg_over_prior7,
	avg(p.amount) over w2 as back3_fwd_3_avg
FROM payment p

WINDOW w AS (PARTITION BY p.customer_id ORDER BY p.payment_id ROWS BETWEEN 7 PRECEDING AND 0 FOLLOWING),
       w2 AS (PARTITION BY p.customer_id  ROWS BETWEEN 7 PRECEDING AND 0 FOLLOWING)
       
-------------------------------------------------------------------------
WITH first_orders AS (
  SELECT * FROM (
	  SELECT p.payment_id, p.amount, p.customer_id,p.payment_date, p.rental_id,
	  row_number() over(partition by p.customer_id ORDER BY p.payment_date)
	  FROM payment p
  )t WHERE t.row_number = 1
), second_table AS (

-- Rental --> Inventory --> Film
SELECT t.rating, t.customer_id, SUM(t.amount) as fo_sum, count(*) , (
 SELECT sum(p2.amount) from payment p2 
 WHERE p2.customer_id = t.customer_id
) as lifetime_spend
FROM (
	SELECT fo.payment_id, fo.amount, r.*, i.*, f.*
	FROM first_orders fo 
	JOIN rental r ON r.rental_id = fo.rental_id
	JOIN inventory i ON i.inventory_id = r.inventory_id
	JOIN film f ON f.film_id = i.film_id
)t 
GROUP BY 1, 2
)

SELECT st.rating, avg(st.lifetime_spend)
FROM second_table st
GROUP BY 1

-------------------------------------------------------------------------
WITH base_table AS (
	SELECT p.amount, r.inventory_id, f.film_id, a.first_name || ' ' || a.last_name as actor_actress,
	a.actor_id
	FROM payment p 
	 JOIN rental r ON r.rental_id = p.rental_id
	 JOIN inventory i ON i.inventory_id = r.inventory_id
	 JOIN film f ON f.film_id = i.film_id
	 JOIN film_actor fa ON fa.film_id = f.film_id
	 JOIN actor a ON fa.actor_id = a.actor_id
), second_table AS (

	SELECT  f.film_id, SUM(p.amount) as gross_sales
	FROM payment p 
	 JOIN rental r ON r.rental_id = p.rental_id
	 JOIN inventory i ON i.inventory_id = r.inventory_id
	 JOIN film f ON f.film_id = i.film_id
	 GROUP BY 1 ORDER BY 2 DESC
)

SELECT bt.film_id, st.gross_sales, array_agg(distinct bt.actor_id), array_length(array_agg(distinct bt.actor_id), 1)
FROM base_table bt JOIN second_table st ON st.film_id = bt.film_id
GROUP BY 1, 2

-------------------------------------------------------------------------
WITH bt as (
		SELECT * FROM (
		SELECT p.customer_id, p.payment_date, row_number() over(partition by p.customer_id order by p.payment_date)
		FROM payment p
	)t WHERE t.row_number = 1
)

SELECT bt.*, 
(
 SELECT SUM(p2.amount) FROM payment p2 WHERE p2.customer_id = bt.customer_id
 AND p2.payment_date BETWEEN bt.payment_date AND bt.payment_date + INTERVAL '7 days'
) as first7_sales,

(
 SELECT SUM(p2.amount) FROM payment p2 WHERE p2.customer_id = bt.customer_id
 AND p2.payment_date BETWEEN bt.payment_date AND bt.payment_date + INTERVAL '14 days'
) as first14_sales,

(
 SELECT SUM(p2.amount) FROM payment p2 WHERE p2.customer_id = bt.customer_id
 --AND p2.payment_date BETWEEN bt.payment_date AND bt.payment_date + INTERVAL '14 days'
) as LTV

FROM bt bt

-------------------------------------------------------------------------
SELECT t.spend_source, max(t.spend)::money as spend, 
	count(*) as customers, 
	(max(t.spend)/count(*))::money as CPA, 
	(SUM(t.LTV) / 3)::money as total_gross_margin  

	FROM (
	SELECT ssa.*,cs.*, (
         SELECT sum(p.amount) FROM payment p WHERE cs.customer_id = p.customer_id
	) as LTV
	FROM source_spend_all ssa 
	JOIN customer_sources cs ON cs.traffic_source = ssa.spend_source
)t 

GROUP BY 1 ORDER BY 2 DESC
