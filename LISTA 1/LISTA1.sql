CREATE DATABASE ecommerce;
use ecommerce;

CREATE TABLE IF NOT EXISTS Customers (
   customer_id INT PRIMARY KEY,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Orders (
   order_id INT PRIMARY KEY,
   customer_id INT,
   order_date DATE,
   FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE IF NOT EXISTS Products (
   product_id INT PRIMARY KEY,
   product_name VARCHAR(100),
   price DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS Order_Items (
   order_item_id INT PRIMARY KEY,
   order_id INT,
   product_id INT,
   quantity INT,
   FOREIGN KEY (order_id) REFERENCES Orders(order_id),
   FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (customer_id, first_name, last_name, email) VALUES
(1, 'Ana', 'Silva', 'ana.silva@example.com'),
(2, 'Bruno', 'Santos', 'bruno.santos@example.com'),
(3, 'Carlos', 'Pereira', 'carlos.pereira@example.com'),
(4, 'Daniela', 'Oliveira', 'daniela.oliveira@example.com');

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2023-07-01'),
(2, 2, '2023-07-02'),
(3, 1, '2023-07-03'),
(4, 3, '2023-07-04');

INSERT INTO Products (product_id, product_name, price) VALUES
(1, 'Notebook', 2500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 100.00),
(4, 'Monitor', 600.00);

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 2, 1),
(4, 2, 3, 1),
(5, 3, 1, 2),
(6, 4, 4, 1);




SELECT 
	Orders.order_id,
    Orders.order_date,
    CONCAT(Customers.first_name,'',
Customers.last_name) AS customer_name,
	Customers.email
FROM
	Orders
INNER JOIN
	Customers ON Orders.customer_id =
Customers.customer_id;

SELECT 
	Products.product_name,
    Order_Items.quantity
FROM
	Order_Items
INNER JOIN 
	Orders ON Order_Items.order_id = 
Orders.order_id
INNER JOIN 
	Products ON Order_Items.product_id =
Products.product_id
WHERE
	Orders.customer_id = 1;    

SELECT
	CONCAT(Customers.first_name,'',
Customers.last_name) AS customer_name,
	SUM(Order_Items.quantity *
Products.price) AS total_spent
FROM 
	Customers
LEFT JOIN 
	Orders ON Customers.customer_id =
Orders.customer_id
LEFT JOIN
	Order_Items ON Orders.order_id =
Order_Items.order_id
LEFT JOIN
	Products ON Order_Items.product_id =
Products.product_id
GROUP BY
	Customers.customer_id, first_name;

SELECT 
	CONCAT(Customers.first_name,'',
Customers.last_name) AS full_name
FROM 
	Customers
LEFT JOIN 
	Orders ON Customers.customer_id = 
Orders.customer_id
WHERE
	Orders.order_id IS NULL;
    
SELECT
	Products.product_name,
    SUM(Order_Items.quantity) AS total_sold
FROM
	Order_Items
JOIN 
	Products ON Order_Items.product_id =
Products.product_id
GROUP BY
	Products.product_id,
Products.product_name
ORDER BY 
	total_sold DESC;