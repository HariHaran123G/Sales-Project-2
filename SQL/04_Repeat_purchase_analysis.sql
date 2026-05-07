SELECT o.customer_id,
        p.product_name, count(*) as Total_purchase
FROM products p
JOIN order_items oi
ON oi.product_id=p.product_id
JOIN orders o
ON o.order_id=oi.order_id
GROUP BY o.customer_id, p.product_name
Having count(*)>1;
