--q1
CREATE DATABASE TechShop;

USE TechShop;

--q2
create table customers (
    customerid int identity primary key ,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    phone varchar(15),
    address varchar(255)
);
create table products (
    productid int identity primary key ,
    productname varchar(100),
    description varchar(255),
    price decimal(10, 2)
);
create table orders (
    orderid int identity primary key ,
    customerid int,
    orderdate date,
    totalamount decimal(10, 2),
    foreign key (customerid) references customers(customerid)
);
create table orderdetails (
    orderdetailid int identity primary key ,
    orderid int,
    productid int,
    quantity int,
    foreign key (orderid) references orders(orderid),
    foreign key (productid) references products(productid)
);
create table inventory (
    inventoryid int identity primary key ,
    productid int,
    quantityinstock int,
    laststockupdate date,
    foreign key (productid) references products(productid)
);

--q5
insert into customers (firstname, lastname, email, phone, address)
values
('peter', 'smith', 'jane.smith@example.com', '0987654321', 'Avenger Avenue 321'),
('Dan', 'williams', 'e.williams@example.com', '3456789012', '321 maple blvd'),
('daniel', 'brown', 'd.brown@example.com', '4567890123', '654 cedar court'),
('michael', 'johnson', 'm.johnson@example.com', '2345678901', '789 pine road'),
('Aussie', 'davis', 'emma.davis@example.com', '5678901234', '987 birch lane'),
('john', 'doe', 'john.doe@example.com', '1234567890', '123 elm street'),
('olivia', 'taylor', 'o.taylor@example.com', '9012345678', '357 hickory place'),
('william', 'miller', 'w.miller@example.com', '6789012345', '159 spruce street'),
('sophia', 'wilson', 'sophia.wilson@example.com', '7890123456', '753 sycamore drive'),
('james', 'moore', 'j.moore@example.com', '8901234567', '951 redwood circle');

insert into products (productname, description, price)
values
('laptop', 'high-performance laptop', 999.99),
('smartphone', 'latest smartphone model', 799.99),
('tablet', '10-inch display tablet', 499.99),
('smartwatch', 'wearable smart device', 199.99),
('headphones', 'noise-cancelling headphones', 149.99),
('keyboard', 'mechanical keyboard', 99.99),
('mouse', 'wireless mouse', 49.99),
('monitor', '27-inch 4k monitor', 299.99),
('speaker', 'bluetooth speaker', 59.99),
('charger', 'fast charging adapter', 29.99);

insert into orders (customerid, orderdate, totalamount)
values
(1, '2024-09-01', 1299.98),
(2, '2024-09-02', 1049.98),
(3, '2024-09-03', 1499.98),
(4, '2024-09-04', 549.98),
(5, '2024-09-05', 249.98),
(6, '2024-09-06', 849.98),
(7, '2024-09-07', 399.98),
(8, '2024-09-08', 229.98),
(9, '2024-09-09', 399.98),
(10, '2024-09-10', 699.98);

insert into orderdetails (orderid, productid, quantity)
values
(1, 1, 1), (1, 2, 1),
(2, 3, 2),
(3, 4, 3),
(4, 5, 1),
(5, 6, 2),
(6, 7, 1),
(7, 8, 1),
(8, 9, 2),
(9, 10, 3);

insert into inventory (productid, quantityinstock, laststockupdate)
values
(1, 50, '2024-09-01'),
(2, 100, '2024-09-02'),
(3, 75, '2024-09-03'),
(4, 60, '2024-09-04'),
(5, 30, '2024-09-05'),
(6, 40, '2024-09-06'),
(7, 85, '2024-09-07'),
(8, 25, '2024-09-08'),
(9, 70, '2024-09-09'),
(10, 90, '2024-09-10');

-- task 2
-- q1
select firstname, lastname, email
from customers;

--q2
select orderid,orderdate,firstname,lastname from customers,orders 
where orders.customerid=customers.customerid;

--q3
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alex', 'Johnson', 'alex.johnson@example.com', '1234567890', '456 Oak Street');
Select * from  Customers;

--q4
update products
set price = price * 1.1 ;
select * from products;

--q5
DECLARE @OrderID INT = 1; 

DELETE FROM OrderDetails
WHERE OrderID = @OrderID;
DELETE FROM Orders
WHERE OrderID = @OrderID;


--q6
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (11, '2024-09-17', 379.99);

--q7
UPDATE Customers
SET Email = 'example.gmail.com',
    Address = '96 new york city'
WHERE CustomerID = 5;

--q8
update orders
set totalamount = (
    select 
        sum(od.quantity * p.price)
    from 
        orderdetails od
    join 
        products p on od.productid = p.productid
    where 
        od.orderid = orders.orderid
);

--q9  
--q9  
DECLARE @CustomerID INT = 6; 

DELETE FROM OrderDetails
WHERE OrderID IN (
    SELECT OrderID
    FROM Orders
    WHERE CustomerID = @CustomerID
);

DELETE FROM Orders
WHERE CustomerID = @CustomerID

--q10
INSERT INTO Products (ProductName, Description, Price)
VALUES ('Smartphone X10', 'Latest model with snapdragon 8 gen 4', 899.99);


--q11
ALTER TABLE Orders
ADD Status VARCHAR(50);

DECLARE @OrderID INT = 4;           
DECLARE @NewStatus VARCHAR(20) = 'Shipped'; 

UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @OrderID;

select * from orders;

--q12
alter table customers
add ordercount int default 0;

update customers
set ordercount = (
    select count(*)
    from orders
    where orders.customerid = customers.customerid
);


-- TASK 3
--Q1	
use TechShop;
select o.orderid, o.orderdate, concat(c.firstname,' ',c.lastname) as customername, c.email
from orders o,customers c
where o.customerid=c.customerid;



-- q2
select 
    p.ProductName,
    sum(od.quantity * p.price) as TotalRevenue
from 
    orderdetails od
join 
    products p on od.productid = p.productid
group by 
p.productname;


--q3
SELECT 
    C.CustomerID,
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    Customers C
INNER JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone, C.Address
ORDER BY 
    CustomerName;
	
-- q4

SELECT top 1
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantityOrdered
FROM 
    OrderDetails OD
INNER JOIN 
    Products P ON OD.ProductID = P.ProductID
GROUP BY 
    P.ProductName
ORDER BY 
    TotalQuantityOrdered DESC;


-- q5
ALTER TABLE Products ADD Category VARCHAR(50);

UPDATE Products
SET Category = 'Electronics'
WHERE ProductName IN ('Laptop', 'Smartphone', 'Tablet', 'Smartwatch', 'Headphones', 'Monitor', 'Speaker', 'Smartphone X10');

UPDATE Products
SET Category = 'Accessories'
WHERE ProductName IN ('Keyboard', 'Mouse', 'Charger');

select * from Products;

SELECT 
    ProductName,
    Category
FROM 
    Products 
WHERE 
    Category = 'Electronics';


-- q6

SELECT 
    CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
    AVG(O.TotalAmount) AS AverageOrderValue
FROM 
    Customers C
INNER JOIN 
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY 
    C.FirstName, C.LastName;



-- q7

WITH OrderTotals AS (
    SELECT 
        O.OrderID,
        O.CustomerID,
        O.TotalAmount,
        CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName,
        C.Email,
        C.Phone,
        C.Address
    FROM 
        Orders O
    INNER JOIN 
        Customers C ON O.CustomerID = C.CustomerID
)
SELECT 
    OrderID,
    CustomerName,
    Email,
    Phone,
    Address,
    TotalAmount AS TotalRevenue
FROM 
    OrderTotals
WHERE 
    TotalAmount = (SELECT MAX(TotalAmount) FROM Orders);

-- q8

SELECT 
    P.ProductName,
    COUNT(OD.OrderID) AS TimesOrdered
FROM 
    Products P
INNER JOIN 
    OrderDetails OD ON P.ProductID = OD.ProductID
WHERE 
    P.ProductName IN ('Laptop', 'Smartphone', 'Tablet', 'Smartwatch', 'Headphones', 'Monitor', 'Speaker')
GROUP BY 
    P.ProductName
ORDER BY 
    TimesOrdered DESC;

-- q9

DECLARE @ProductName VARCHAR(100) = 'Tablet'; 

SELECT DISTINCT
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.Phone,
    C.Address
FROM 
    OrderDetails OD
JOIN 
    Orders O ON OD.OrderID = O.OrderID
JOIN 
    Products P ON OD.ProductID = P.ProductID
JOIN 
    Customers C ON O.CustomerID = C.CustomerID
WHERE 
    P.ProductName = @ProductName;


--q10
DECLARE @StartDate VARCHAR(100) = '2024-09-01'; 
DECLARE @EndDate VARCHAR(100) = '2024-09-07'; 
SELECT 
    SUM(TotalAmount) AS TotalRevenue
FROM 
    Orders
WHERE 
    OrderDate BETWEEN @StartDate AND @EndDate;

use TechShop;
select * from Customers;
select * from Orders;
select * from Products;
select * from OrderDetails;
select * from Inventory;
	