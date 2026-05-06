WITH Base AS(
  SELECT o.customer_id, sum(oi.amount) as Tot_rev
    from order_items oi
    JOIN orders o
    ON o.order_id=oi.order_id
    GROUP BY o.customer_id;),
Category AS(
  SELECT *, NTILE(3) OVER(order by Tot_rev DESC) as n
  from Base
  )
SELECT *, 
CASE WHEN n=1 then 'High' 
WHEN n=2 then 'Medium'
ELSE 'LOW'
END AS Customer_level
FROM Category;
