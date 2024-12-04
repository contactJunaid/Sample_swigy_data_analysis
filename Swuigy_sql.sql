Create database swigy_dataset;
select * from users;
select * from orders;

select users_name 
from users 
where user_id NOT IN (select user_id from orders);

with cte_A as (select f_id, avg(price) as avg_price from menu 
group by f_id)
select food.f_name , cte_A.avg_price
from food
left join cte_A on food.f_id = cte_A.f_id;

 with cte_S as (with cte_p as (SELECT *, MONTHNAME(STR_TO_DATE(`order_date`, '%d-%m-%Y')) AS month_name
FROM orders)
select r_id, count(order_id) as total_orders from cte_p where month_name like 'july'
group by r_id
order by total_orders desc)
select restaurants.r_name, restaurants.cuisine, cte_S.total_orders
from cte_s
left join restaurants on restaurants.r_id=cte_S.r_id;


SELECT *, MONTHNAME(STR_TO_DATE(`date`, '%d-%m-%Y')) AS month_name
FROM orders
WHERE MONTHNAME(STR_TO_DATE(`date`, '%d-%m-%Y')) = 'June';

with CTE_M as ( select r_id, sum(amount) as revenue
from orders
where  MONTHNAME(STR_TO_DATE(`order_date`, '%d-%m-%Y'))= 'june'
group by  r_id)
select r.r_name, CTE_M.r_id,CTE_M.revenue
from CTE_M 
left join restaurants as r 
on r.r_id= CTE_M.r_id
having revenue> 500
order by revenue desc;


-- select * from orders
-- where user_id = (select user_id from users where user_id = 4)
-- and (date >'2022-06-10' and date < '2022-07-10')
with cte_m as (SELECT *
FROM orders
WHERE user_id = 4
AND STR_TO_DATE(`order_date`, '%d-%m-%Y') > '2022-06-10'
AND STR_TO_DATE(`order_date`, '%d-%m-%Y') < '2022-07-10')
select users.users_name, cte_m.user_id, cte_m.r_id, cte_m.amount, cte_m.order_date
from cte_m 
left join users 
on users.user_id=cte_m.user_id;










