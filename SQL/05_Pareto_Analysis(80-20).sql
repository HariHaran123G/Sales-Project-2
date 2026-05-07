-- To understand the number of products contributing 80% of revenue
WITH BASE AS(
SELECT p.product_name, oi.product_id, sum(oi.amount) as revenue
FROM order_items oi
JOIN products p
  ON oi.product_id=p.product_id
GROUP BY p.product_name, oi.product_id
),

Ranked AS(
  SELECT *, SUM(revenue) OVER(ORDER BY revenue DESC) as Running_total,
              Sum(revenue) OVER() as Total_company_revenue
  FROM Base),

pct AS(
  SELECT *, Running_total*100.0/Total_company_revenue as Running_pct
  FROM Ranked)
  
SELECT * FROM pct
where Running_pct<=80;
