--BUSINESS QUESTION SQL QUERY
--Which 3 bundles have the highest subscription volume/count?
SELECT bundles.bundle_id,
       bundles.bundle_name,
COUNT(subscriptions.subscription_id) AS subscription_count
FROM subscriptions 
JOIN bundles on subscriptions.bundle_id = bundles.bundle_id
GROUP BY bundles.bundle_id, bundles.bundle_name
ORDER BY subscription_count DESC
LIMIT 3;

--What is the average spend per loyalty tier?
SELECT customers.loyalty_tier,
ROUND(AVG(subscriptions.total_value), 2) AS avg_spend
FROM customers
JOIN subscriptions ON customers.customer_id = subscriptions.customer_id
JOIN payments ON subscriptions.subscription_id = payments.subscription_id
WHERE payments.is_successful = TRUE
GROUP BY customers.loyalty_tier
ORDER BY avg_spend DESC;

-- How many payments failed, and what methods are used?
SELECT payments.payment_method,
COUNT(payments.payment_id) AS failed_count
FROM payments 
WHERE LOWER(payments.payment_status) = 'failed'
GROUP BY payments.payment_method
ORDER BY failed_count DESC;

--What is the total revenue by bundle category?
SELECT bundles.category,
SUM(subscriptions.total_value) AS total_revenue
FROM bundles 
JOIN subscriptions  ON bundles.bundle_id = subscriptions.bundle_id
JOIN payments  ON subscriptions.subscription_id = payments.subscription_id
WHERE bundles.is_active = TRUE
AND payments.is_successful = TRUE
GROUP BY bundles.category
ORDER BY total_revenue DESC;

--What issue types receive the lowest ratings?
SELECT support_tickets.issue_type,
ROUND(AVG(support_tickets.rating), 2) AS avg_rating
FROM support_tickets
GROUP BY support_tickets.issue_type
ORDER BY avg_rating ASC;

