WITH Base as(
SELECT p.category, p.product_id, p.product_name, sum(oi.amount) as Tot_revenue
FROM products p
JOIN order_items oi
ON oi.product_id=p.product_id
GROUP BY p.category, p.product_id, p.product_name),

Ranked as(
  SELECT *, RANK() OVER(PARTITION BY category ORDER BY Tot_revenue DESC) as rnk
FROM Base)

SELECT * FROM Ranked
where rnk=1;
