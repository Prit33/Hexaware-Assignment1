--q1 
use techshop;
select 
    c.customerid,
    c.firstname,
    c.lastname,
    c.email,
    c.phone,
    c.address
from 
    customers c
where 
    c.customerid not in (
        select o.customerid
        from orders o
    );


--q2 	
select 
    sum(quantityinstock) as totalproductsavailable
from 
    inventory;

--q3
select 
    sum(od.quantity * p.price) as totalrevenue
from 
    orderdetails od
join 
    products p on od.productid = p.productid;

--q4. 


declare @categoryname varchar(50)= 'electronics';  

select 
    avg(od.quantity) as averagequantityordered
from 
    orderdetails od
where 
    od.productid in (
        select p.productid
        from products p
        where p.category = @categoryname
    );


--q5. 
declare @customerid int= 4;   

select 
    sum(od.quantity * p.price) as totalrevenue
from 
    orders o
join 
    orderdetails od on o.orderid = od.orderid
join 
    products p on od.productid = p.productid
where 
    o.customerid = @customerid;

--q6. 
select 
    c.firstname,
    c.lastname,
    count(o.orderid) as numberoforders
from 
    customers c
join 
    orders o on c.customerid = o.customerid
group by 
    c.customerid, c.firstname, c.lastname
order by 
    numberoforders desc;

--q7. 
with categoryquantities as (
    select 
        p.category, 
        sum(od.quantity) as totalquantityordered
    from 
        orderdetails od
    join 
        products p on od.productid = p.productid
    group by 
        p.category
)

select 
    category, 
    totalquantityordered
from 
    categoryquantities
where 
    totalquantityordered = (select max(totalquantityordered) from categoryquantities);

--q8.
select 
    c.firstname,
    c.lastname,
    sum(od.quantity * p.price) as totalspending
from 
    customers c
join 
    orders o on c.customerid = o.customerid
join 
    orderdetails od on o.orderid = od.orderid
join 
    products p on od.productid = p.productid
group by 
    c.customerid, c.firstname, c.lastname
order by 
    totalspending desc
offset 0 rows fetch next 1 row only;

--q9.
select 
    sum(od.quantity * p.price) / nullif(count(distinct o.orderid), 0) as averageordervalue
from 
    orders o
join 
    orderdetails od on o.orderid = od.orderid
join 
    products p on od.productid = p.productid;

--q10.
select 
    c.firstname,
    c.lastname,
    count(o.orderid) as totalorders
from 
    customers c
left join 
    orders o on c.customerid = o.customerid
group by 
    c.customerid, c.firstname, c.lastname
order by 
    totalorders desc;


