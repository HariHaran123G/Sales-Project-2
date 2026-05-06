WITH Base as(
  SELECT oi.product_id, p.product_name, sum(oi.quantity) as Total_ordered, sum(oi.amount) as Tot_revenue
  from order_items oi
JOIN products p
ON p.product_id=oi.product_id
GROUP BY oi.product_idp,p.product_name
),
Ranked as(
  SELECT *, RANK() OVER(ORDER BY Tot_revenue DESC) as rnk1,
  RANK() OVER(ORDER BY Total_ordered DESC) as rnk2
  FROM Base
  )
SELECT * FROM Ranked
where rnk1=1 OR rnk2=1;
