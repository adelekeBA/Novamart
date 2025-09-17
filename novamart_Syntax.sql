select * from bundles;

select * from customers;

select * from payments;

select * from subscriptions;

select * from support_tickets;

-- Which bundles are most profitable*? 
-- (Join BUNDLE: bundle_id, bundle_name, category, bundle_size, is_active, WITH SUBSCIPTION: bundle_id, quantity, discount, total_value)
-- No cost price in the data, so profitable is best measured as just total value of each sales.

-- Total Bundle Sales --
create table Total_Bundle_Sales AS
select b.bundle_id, bundle_name, category, is_active, round(sum(quantity),2) as total_quantity, round(sum(total_value),2) as total_sale
from bundles as b join subscriptions as s
on b.bundle_id = s.bundle_id
group by b.bundle_id
order by total_sale desc;

select * from total_bundle_sales;


-- Average Bundle Sales By Quantity and Value --
create table Avg_Bundle_Sales AS
select b.bundle_id, bundle_name, category, is_active, round(avg(quantity),2) as avg_quantity, round(avg(total_value),2) as avg_sale
from bundles as b join subscriptions as s
on b.bundle_id = s.bundle_id
group by b.bundle_id
order by avg_sale desc;

select * from avg_bundle_sales;

-- No Standard KPIs 
-- Yet Important metrics like total revenue (done), average spend (done), or discount impact aren’t calculated 

-- Subscription and Payment Table --

create table Subscription_Payment as 
select bundle_name, category, s.bundle_id, subscription_type, order_date, quantity, discount, total_value, p.payment_method, payment_date, is_successful, payment_status
from subscriptions as s
join payments as p
on p.subscription_id = s.subscription_id
join bundles as b
on s.bundle_id = b.bundle_id;

select * from Subscription_Payment;

-- Bundle with most paid subscription --
select bundle_name, subscription_type, quantity, discount, total_value, payment_method, payment_status
from Subscription_Payment
where payment_status = 'Paid'
order by discount desc;

-- Pending Subscription --
select bundle_name, subscription_type, quantity, discount, total_value, payment_method, payment_status
from Subscription_Payment
where payment_status = 'Pending';

-- Failed Subscription --
select bundle_name, subscription_type, quantity, discount, total_value, payment_method, payment_status
from Subscription_Payment
where payment_status = 'Failed';


-- Are discounts helping or hurting? *
-- Bundle_name vs Discount, total volue
select b.bundle_name, category, bundle_size, s.discount, total_value
from bundles as b
join subscriptions as s
on b.bundle_id = s.bundle_id;





-- Which customer tiers drive long-term value? 
-- (Join CUSTOME: customer_id, gender, birth_year, city, loyalty_tier, WITH SUBSCIPTION: customer_id, bundle_id, subscription_type)

select * from bundles;
select * from customers;
select * from payments;
select * from subscriptions;
select * from support_tickets;


-- What’s the root cause behind low ticket ratings? Of All the issues which issue_type scores the most/more rating*
select * from support_tickets;
select distinct issue_type from support_tickets;
select distinct rating from support_tickets order by rating asc;


-- Mixed Subscription Types (Orders include both recurring plans and one-time purchases, 
-- but there's no clear way to compare their performance)

-- Unclear Payment Outcomes 
-- Some payments are marked as failed or pending, but this isn’t filtered out when analyzing total revenue. 

-- Scattered Feedback Data 
-- Customer support tickets include ratings and issue types, but it's hard to tell which problems are the most serious.

-- No Customer Segments Defined
-- We don’t yet know which customers are loyal, high-spending, or at risk of churning, there’s no built-in grouping. 


