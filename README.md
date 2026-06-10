# Online Bookstore – SQL Project

A PostgreSQL-based database project I made to practice SQL and understand
how relational databases work in a real-world context like an online bookstore.

---

## What this project is about

I built a simple database system that handles books, customers, and orders
for an online bookstore. The idea was to design the schema myself, load some
data, and then write queries that answer actual business questions.

---

## Tables

- **Books** – title, author, genre, year, price, stock
- **Customers** – name, email, phone, city, country
- **Orders** – links customers to books, stores date, quantity, total amount

---

## Queries I wrote

**Basic stuff:**
- Get all books by genre or year
- Filter customers by country
- Orders placed in a specific month
- Total stock across all books

**More complex ones:**
- Total books sold per genre (JOIN + GROUP BY)
- Average price in a specific genre
- Customers who ordered more than once
- Most ordered book overall
- Top 3 priciest books in Fantasy
- Sales count per author

**Bonus queries:**
- Revenue generated per genre
- Books low on stock
- Month-wise orders in 2024
- Top 5 customers by total spending

---

## Tools used

- PostgreSQL
- pgAdmin
- SQL (DDL + DML + joins + aggregations)

---

## How to run it

1. Open pgAdmin and create a database called `OnlineBookstore`
2. Run the `online_bookstore.sql` file in the Query Tool
3. Before running the COPY commands, update the CSV file paths
   to wherever you saved them on your machine

---

## Files

- `online_bookstore.sql` – all the code (schema + queries)
- `CSV/Books.csv` – sample books data
- `CSV/Customers.csv` – sample customers data
- `CSV/Orders.csv` – sample orders data

---

## What I learned

Honestly this helped me understand JOINs way better than just reading about them.
Writing queries for real questions like "which book sold the most" made it
click faster than textbook exercises.
