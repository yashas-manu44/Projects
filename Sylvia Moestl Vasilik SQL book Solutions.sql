-- LETS GO 

-- PROBLEM 1 
select * 
from shippers;

-- PROBLEM 2
select CategoryName, Description
From categories;

-- Problem 3
Select firstname, lastname, hiredate
From employees
where title = 'Sales Representative';

--Problem 4
select firstname, lastname, hiredate
from employees
where title =  'Sales Representative' and 
country = 'USA';

--Problem 5 
select orderid, orderdate
from orders
where employeeid = 5;

--Problem 6
select supplierid, contactname, contacttitle
from suppliers
where contacttitle NOT IN ('Marketing Manager');
-- remember not in has to be within brackets 

--Problem 7 
select productid, productname
from products
where productname ILIKE 'queso%';

--Problem 8
select orderid, customerid, shipcountry
from orders
where shipcountry = 'France' OR shipcountry = 'Belgium';

--OR 
select orderid, customerid, shipcountry
from orders
where shipcountry IN ('France', 'Belgium');

--Problem 9 
select orderid, customerid, shipcountry
from orders
where shipcountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

--Problem 10
select firstname, lastname, title, birthdate
from employees
order by birthdate ASC;

--Problem 11
select firstname, lastname, title, birthdate
from employees
order by birthdate ASC;
-- if the birthdate was a datetime column and i only wanted date, we can use CAST to convert from one data 
-- type to another 
Select firstname, lastname, title, cast(birthdate as date) as newdate
from employees
order by birthdate ASC;

-- Problem 12
select firstname, lastname, (firstname || ' ' || lastname) as fullname
from employees;

-- Problem 13
select orderid, productid, unitprice, quantity, (unitprice*quantity) as Totalprice
from order_details;

-- Problem 14 
select count(*)
from customers;

-- Problem 15 
select min(orderdate)
from orders;
-- OR 
select orderdate
from orders
order by orderdate ASC
limit 1;

-- Problem 16
select country
from customers
group by country;

-- Problem 17
select contacttitle, count(contacttitle) as countoftitle
from customers
group by contacttitle
order by countoftitle desc;

-- Problem 18
select productid, productname, companyname
from suppliers as s
	inner join products as p
	on s.supplierid = p.supplierid
order by productid ASC;

-- Problem 19
select orderid, cast(orderdate as DATE) as Orderdate, s.companyname as shipper  
from orders as o
	inner join shippers as s
	on o.shipvia = s.shipperid
where orderid < 10300;

-- Problem 20
with joinedtable as (select * 
from categories as c 
	inner join products as p
	on c.categoryid = p.categoryid)
	
select categoryname, count(categoryname) as Totalproducts
from joinedtable
group by categoryname
order by Totalproducts DESC;

-- Problem 21 
select country, city, count(city) as totalcount
from customers
group by country, city
order by totalcount DESC;

-- Problem 22 
select productid, productname, unitsinstock, reorderlevel
from products
where unitsinstock < reorderlevel
order by productid ASC;

-- Problem 23
select productid, productname, unitsinstock, unitsonorder, discontinued
from products
where (unitsinstock + unitsonorder) <= reorderlevel and discontinued = 0;

-- Problem 24 
select customerid, companyname, region
from customers
order by region ASC, customerid;

-- if the null values are appearing on top and you only want it at the bottom then
-- we can use CASE when then to give a numerical value to this and then sort it 

select customerid, companyname, region, 
	(CASE 
		when region is null then 1 else 0 -- every row where there is a region will now have 0  
		end) as sortedregion
from customers
order by sortedregion, region, customerid;

-- Problem 25 
with joinedtable as (
select * 
from orders as o
	inner join shippers as s
	on o.shipvia = s.shipperid
)
-- Round function can only be applied to numeric type so if its not then cast it to numeric
select shipcountry, ROUND(AVG(freight):: numeric, 2) as FreightCharges -- :: also is a way to CAST 
from joinedtable
group by shipcountry
order by FreightCharges DESC
limit 3;

-- Problem 26

-- we use date_part function to get a specific part of the date, for some reason extract did not work wiht where clause 
with joinedtable as (
select * 
from orders as o
	inner join shippers as s
	on o.shipvia = s.shipperid
where date_part('year', orderdate) = '1996'
)


-- Round function can only be applied to numeric type so if its not then cast it to numeric
select shipcountry, ROUND(AVG(freight):: numeric, 2) as FreightCharges -- :: also is a way to CAST 
from joinedtable
group by shipcountry
order by FreightCharges DESC
limit 3;


-- Problem 28

-- we can use a simple max(orderdate) to get the latest order date and use between clause 
-- or we can add a certain interval to date( in this case its 12months or 1 year ) we can use DATEADD function
select max(orderdate) from orders; -- this will help us get the latest order, now this can be used as subqueries

select shipcountry, avg(freight)
from orders
where orderdate BETWEEN '1997-05-06' AND '1998-05-06'
group by shipcountry
order by avg DESC
limit 3;

-- Problem 29

-- we need to combine employee, orders, order_details, products tables  
select e.employeeid, e.lastname, o.orderid, od.quantity, p.productname
	from employees as e 
	inner join orders as o
	on e.employeeid = o.employeeid
	inner join order_details as od
	on o.orderid =  od.orderid
	inner join products as p
	on od.productid = p.productid
;

-- Problem 30
select c.companyname, o.orderid, od.quantity
	from customers as c 
	left join orders as o 
	on c.customerid = o.customerid
	left join order_details as od
	on o.orderid = od.orderid
where o.orderid is null;
	
-- Problem 31

-- first we look at all the customers who had placed an order with employeeid '4'
select customerid 
from orders
where employeeid = 4;

-- then we use the above result as a nested query and see those who are not in that list 
select customerid, companyname
from customers
where customerid not in (select customerid
						 from orders 
						 where employeeid = 4)


-- Problem 32

/* In this problem it makes a difference how you groupby 
because if you consider orderid in groupby then it will group even based on orderid
and since the question mentions atleast one individual order > 10000 we need to groupby orderid also */



select c.customerid, c.companyname, o.orderid, sum(od.unitprice*od.quantity) as Totalamount
	from customers as c 
	inner join orders as o 
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
where date_part('year', o.orderdate) = '1998'
Group by c.customerid, c.companyname, o.orderid
having sum(unitprice*quantity) > 10000
order by 3 DESC
;


-- Problem 33

/*Similar to the above problem, but instead of atleast one individual order being > 10000 , in this case we need
the orders total > 15000 */
-- so here we dont need to group by orderid

select c.customerid, c.companyname, sum(od.unitprice*od.quantity) as Totalamount
	from customers as c 
	inner join orders as o 
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
where date_part('year', o.orderdate) = '1998'
Group by c.customerid, c.companyname
having sum(unitprice*quantity) > 15000
order by 3 DESC
;


-- Problem 34 
-- with discount
select c.customerid, c.companyname, sum((od.unitprice*od.quantity)*(1-od.discount)) as Totalamount
	from customers as c 
	inner join orders as o 
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
where date_part('year', o.orderdate) = '1998'
Group by c.customerid, c.companyname
having sum((od.unitprice*od.quantity)*(1-od.discount)) > 10000
order by 3 DESC
;

-- Problem 35
-- there is no EOMONTH function in postgres, so in this case i just used date_part along with AND , OR operators

select employeeid, orderid, orderdate 
from orders
where (date_part('month', orderdate) = '02' and date_part('day', orderdate) = '28')
or (date_part('month', orderdate) in ('01', '03', '05', '07', '08', '10', '12') and date_part('day', orderdate) = '31')
or (date_part('month', orderdate) not in ('01', '02', '03', '05', '07', '08', '10', '12') and date_part('day', orderdate) = '30')
;

-- Problem 36 
-- just group by orderid and check which has highest count 

select orderid, count(orderid) as Totalcount
from order_details 
group by orderid
order by Totalcount DESC
limit 10;


-- Problem 37
-- arrange results in random using random() and limit to 2%
select orderid
from order_details
group by orderid
order by random()
limit (0.02*(select count(*) from order_details));

-- Problem 38
select * from orders;

select orderid
from order_details
where quantity >= 60
group by orderid, quantity
having count(orderid) > 1; -- this is just seeing within the groups which groups have more than 1 entry

-- Problem 39
select orderid, productid, unitprice, quantity, discount
from order_details
where orderid in 
	(select orderid
	from order_details
	where quantity >= 60
	group by orderid, quantity
	having count(orderid) > 1);
	
	 
-- Problem 41
select orderid, orderdate, requireddate, shippeddate
from orders
where shippeddate >= requireddate;

-- Problem 42 
with joined as (
	select o.orderid, o.orderdate, o.requireddate, o.shippeddate, e.employeeid, e.firstname, e.lastname
		from orders as o 
		inner join employees as e
		on o.employeeid = e.employeeid	
where shippeddate >= requireddate
)
select employeeid, lastname, count(employeeid) as TotalLateOrders
from joined
group by employeeid, lastname
order by totalLateOrders DESC;

-- Problem 43

-- Late orders table 
with joined as (
	select e.employeeid, e.lastname, count(*) as TotalLate
		from orders as o 
		inner join employees as e
		on o.employeeid = e.employeeid	
	where shippeddate >= requireddate
	group by e.employeeid, e.lastname
	order by TotalLate DESC
), totalorders as (
	select e.employeeid, e.lastname, count(*) as Totalorders
	from orders as o
	inner join employees as e
	on o.employeeid = e.employeeid
	group by e.employeeid, e.lastname
	order by Totalorders DESC
)

select t.employeeid, t.lastname, t.Totalorders, j.TotalLate
from totalorders as t 
inner join joined as j
on t.employeeid = j.employeeid;


-- Problem 46

-- here we want to get percentage of late orders over total orders 

with joined as (
	select e.employeeid, e.lastname, count(*) as TotalLate
		from orders as o 
		inner join employees as e
		on o.employeeid = e.employeeid	
	where shippeddate >= requireddate
	group by e.employeeid, e.lastname
	order by TotalLate DESC
), totalorders as (
	select e.employeeid, e.lastname, count(*) as Totalorders
	from orders as o
	inner join employees as e
	on o.employeeid = e.employeeid
	group by e.employeeid, e.lastname
	order by Totalorders DESC
)

-- here if i dont cast the numerator and denominator as floats we just get answer as 0
select t.employeeid, t.lastname, t.Totalorders, j.TotalLate, (j.TotalLate::float/t.Totalorders::float) as PercentLate
from totalorders as t 
inner join joined as j
on t.employeeid = j.employeeid;


-- Problem 48
with customerorders as
	(select c.customerid, c.companyname, sum(od.unitprice*od.quantity) as Orderprice
	from customers as c 
	inner join orders as o
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
	where date_part('year', o.orderdate)  = '1998'
	group by c.customerid, c.companyname)
	
select customerid, companyname, Orderprice, 
	CASE 
		WHEN Orderprice between 0 and 1000 THEN 'Low'
		WHEN Orderprice between 1000 and 5000 THEN 'Medium'
		WHEN Orderprice between 5000 and 10000 THEN 'High'
		WHEN Orderprice > 10000 THEN 'Very High'
		END as Grouping 
From customerorders
Order by customerid ASC;


-- Problem 50

-- percent of groupings 
-- take the two queries above as CTE's

with customerorders as
	(select c.customerid, c.companyname, sum(od.unitprice*od.quantity) as Orderprice
	from customers as c 
	inner join orders as o
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
	where date_part('year', o.orderdate)  = '1998'
	group by c.customerid, c.companyname), 
	
groupingtable as 

	(select customerid, companyname, Orderprice, 
	CASE 
		WHEN Orderprice between 0 and 1000 THEN 'Low'
		WHEN Orderprice between 1000 and 5000 THEN 'Medium'
		WHEN Orderprice between 5000 and 10000 THEN 'High'
		WHEN Orderprice > 10000 THEN 'Very High'
		END as Grouping 
From customerorders
Order by customerid ASC)

Select grouping, count(*) as TotalInGroup, (count(*)/ (select count(*) from groupingtable)::float) as percentagetotal
from groupingtable 
group by grouping 
order by TotalInGroup DESC;

-- Just adding customer group threshold table which has been missied earlier --------------

DROP TABLE IF EXISTS customergroupthreshold;


CREATE TABLE customergroupthreshold (
    groupname varchar(15) NOT NULL,
    rangebottom decimal NOT NULL,
    rangetop decimal NOT NULL
);

INSERT INTO customergroupthreshold VALUES ('Low', 0.0000, 999.9999);
INSERT INTO customergroupthreshold VALUES ('Medium', 1000.0000, 4999.9999);
INSERT INTO customergroupthreshold VALUES ('High', 5000.0000, 9999.9999);
INSERT INTO customergroupthreshold VALUES ('Very High', 10000.0000, 922337203685477.5807);


--------------------------------------------------------------------------------------------

-- Problem 51 

select * from customergroupthreshold;



with groupingtable as 
(select c.customerid, c.companyname, sum(od.unitprice*od.quantity) as Totalorders
	from customers as c 
	inner join orders as o
	on c.customerid = o.customerid
	inner join order_details as od 
	on o.orderid = od.orderid
where date_part('year', o.orderdate) = '1998'
group by c.customerid, c.companyname
order by c.customerid ASC)

select gt.customerid, gt.companyname, gt.Totalorders, cgh.groupname 
	from groupingtable as gt
	inner join customergroupthreshold as cgh
	on gt.Totalorders between cgh.rangebottom and cgh.rangetop
order by gt.customerid ASC
;

-- Problem 52 

-- use union statement to paste together results of two or more queries 

select distinct(country) from suppliers
UNION
select distinct(country) from customers
order by country asc;


-- Problem 53 
with suppliercountry as 
(select distinct(country) from suppliers), 
customercountry as 
(select distinct(country) from customers)

select s.country as suppliercountry, c.country as customercountry
from suppliercountry as s
full outer join customercountry as c
on c.country = s.country
order by s.country, c.country ASC;

-- Problem 54 

with allcountries as 
(select distinct(country) from suppliers
UNION
select distinct(country) from customers
order by country asc 
)


-- I'm choosing count(distinct) because there can same customerid's, supplierid's over mulitple dates 
-- but i only need a count of how many customers and suppliers are from each country

select a.country,
count(distinct(c.customerid)) as TotalCustomers,
count(distinct(s.supplierid)) as TotalSuppliers
from allcountries as a
left join customers as c 
on a.country = c.country
left join suppliers as s 
on a.country = s.country
group by a.country;


-- Problem 55 

with partitioned as 
(select shipcountry, orderdate, customerid, orderid, 
ROW_NUMBER() OVER(Partition by shipcountry order by orderdate )
from orders 
group by shipcountry, customerid, orderid
order by shipcountry ASC)

select * from partitioned
where row_number = 1;


-- Problem 56

--1. we want to customers who have made more than one order in a 5 day period 
--2. we want to then show which the intial order date and next order date for each customer who has satisfied 1.

-- we can do this by self join using inner join

select initialorders.customerid, 
initialorders.orderid as initialorderid,
initialorders.orderdate as initialorderdate, 
nextorders.orderid as nextordersid,
nextorders.orderdate as nextorderdate,
(nextorders.orderdate) -  (initialorders.orderdate) as DaysBetween

from orders as initialorders
inner join orders as nextorders
on initialorders.customerid = nextorders.customerid
where initialorders.orderid < nextorders.orderid
	AND 
	(nextorders.orderdate - initialorders.orderdate) <= 5
order by initialorders.customerid ASC
;
	

--Problem 57
-- another way of doing the previous problem using Window Functions 
With nextordertable as (select customerid, orderid, orderdate,
LEAD(orderdate, 1) OVER(partition by customerid order by orderdate) as Nextorderdate
from orders)

select customerid,
orderid,
orderdate as initialorderdate,
nextorderdate,
(nextorderdate - orderdate) as Datedifference
from nextordertable
where (nextorderdate - orderdate) <=5;


----------------- END OF BOOK -------------------------------



			





 
 
















