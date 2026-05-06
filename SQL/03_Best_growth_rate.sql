WITH base as(
  SELECT DATE_FORMAT(o.order_date, '%Y-%m') as month, 
         p.category, sum(oi.amount) as Tot_rev
  from products p
  JOIN order_items oi
  ON oi.product_id=p.product_id
  JOIN orders o
  ON o.order_id=oi.order_id
  GROUP BY DATE_FORMAT(o.order_date, '%Y-%m'), p.category
  ),
Prev_value AS(
 SELECT *, LAG(Tot_rev) OVER( PARTITION BY category ORDER BY month) as Prev_fig
  FROM base),
Growth AS(
  SELECT *, (Tot_rev-Prev_fig)*100.0/Prev_fig as Pct_growth
FROM Prev_value),
Ranked AS(
  SELECT *, RANK() OVER(ORDER BY Pct_growth DESC)
  as rnk
  FROM Growth)
SELECT * FROM Ranked 
where rnk=1;
  
