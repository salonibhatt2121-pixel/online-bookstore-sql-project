CREATE DATABASE OnlineBookstore;

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10, 2),
Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Books.csv'
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Customers.csv'
CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'D:\Course Updates\30 Day Series\SQL\CSV\Orders.csv'
CSV HEADER;

SELECT * FROM Books
WHERE Genre='Fiction';

SELECT * FROM Books
WHERE Published_year>1950;

SELECT * FROM Customers
WHERE country='Canada';

SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

SELECT SUM(stock) AS Total_Stock
FROM Books;

SELECT * FROM ORDERS;
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_sold
FROM Orders o
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre;

SELECT AVG(price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;

SELECT * FROM books
WHERE genre ='Fantasy'
ORDER BY price DESC LIMIT 3;

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;
