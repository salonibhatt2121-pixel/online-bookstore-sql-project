-- Online Bookstore Database Project
-- Tools: PostgreSQL, pgAdmin
-- Author: Saloni

-- ============================================================
-- SETUP
-- ============================================================

CREATE DATABASE OnlineBookstore;

-- connect to the database before running the rest
-- \c OnlineBookstore;


-- ============================================================
-- CREATE TABLES
-- ============================================================

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


-- ============================================================
-- IMPORT DATA FROM CSV
-- update the file paths below to match your local folder
-- ============================================================

COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'C:\YourFolder\CSV\Books.csv'
CSV HEADER;

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'C:\YourFolder\CSV\Customers.csv'
CSV HEADER;

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'C:\YourFolder\CSV\Orders.csv'
CSV HEADER;


-- ============================================================
-- VERIFY DATA
-- ============================================================

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- ============================================================
-- BASIC QUERIES
-- ============================================================

-- 1) All books in the Fiction genre
SELECT * FROM Books
WHERE Genre = 'Fiction';

-- 2) Books published after 1950
SELECT * FROM Books
WHERE Published_Year > 1950;

-- 3) Customers from Canada
SELECT * FROM Customers
WHERE Country = 'Canada';

-- 4) Orders placed in November 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Total stock of all books combined
SELECT SUM(Stock) AS Total_Stock
FROM Books;


-- ============================================================
-- ADVANCED QUERIES
-- ============================================================

-- 1) Total books sold per genre
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY Total_Books_Sold DESC;

-- 2) Average price of books in the Fantasy genre
SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

-- 3) Customers who placed at least 2 orders
SELECT o.Customer_ID, c.Name, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2
ORDER BY Order_Count DESC;

-- 4) Most frequently ordered book
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 1;

-- 5) Top 3 most expensive books in the Fantasy genre
SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- 6) Total quantity sold per author
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author
ORDER BY Total_Books_Sold DESC;


-- ============================================================
-- BONUS QUERIES
-- ============================================================

-- 7) Revenue generated per genre
SELECT b.Genre, SUM(o.Total_Amount) AS Total_Revenue
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY Total_Revenue DESC;

-- 8) Books that are low on stock (less than 40 copies left)
SELECT Title, Author, Stock
FROM Books
WHERE Stock < 40
ORDER BY Stock ASC;

-- 9) Month-wise total orders in 2024
SELECT TO_CHAR(Order_Date, 'Month') AS Month,
       COUNT(Order_ID) AS Total_Orders
FROM Orders
WHERE EXTRACT(YEAR FROM Order_Date) = 2024
GROUP BY TO_CHAR(Order_Date, 'Month'), EXTRACT(MONTH FROM Order_Date)
ORDER BY EXTRACT(MONTH FROM Order_Date);

-- 10) Top 5 customers by total amount spent
SELECT c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent DESC
LIMIT 5;
