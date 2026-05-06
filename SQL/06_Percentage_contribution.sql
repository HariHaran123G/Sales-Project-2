WITH Base AS(
SELECT oi.product_id, p.product_name, sum(oi.amount) as Tot_rev
FROM order_items oi
JOIN products p
ON p.product_id=oi.product_id
GROUP BY oi.product_id, p.product_name
)

SELECT *, Tot_rev*100.0/sum(Tot_rev) OVER() as pct_contribution
FROM Base; 
