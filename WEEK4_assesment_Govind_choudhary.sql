-- ============================================================
-- bookmart_setup.sql
-- Fresh dataset for Week 4 Weekly Assessment
-- The Unlox Academy · DA/DS Track
-- ============================================================
-- Three related tables — designed to exercise every Week 4 concept:
--   authors : self-join via mentor_id
--   books   : joined to authors via author_id
--   sales   : joined to books via book_id
--
-- HOW TO RUN:
--   1. Open MySQL Workbench
--   2. File > Open SQL Script > select this file
--   3. Press Ctrl+Shift+Enter
--   4. Verify:
--        SELECT COUNT(*) FROM bookmart.authors;   -- 10
--        SELECT COUNT(*) FROM bookmart.books;     -- 25
--        SELECT COUNT(*) FROM bookmart.sales;     -- 40
-- ============================================================

DROP DATABASE IF EXISTS bookmart;
CREATE DATABASE bookmart;
USE bookmart;

-- ============================================================
-- authors — 10 rows, 3 mentor relationships for SELF JOIN
-- ============================================================
CREATE TABLE authors (
    author_id    INT PRIMARY KEY,
    name         VARCHAR(60),
    country      VARCHAR(30),
    born_year    INT,
    mentor_id    INT,       -- self-reference for SELF JOIN
    FOREIGN KEY (mentor_id) REFERENCES authors(author_id)
);

INSERT INTO authors VALUES
    (1,  'Chetan Bhagat',        'India',   1974, NULL),
    (2,  'Amish Tripathi',       'India',   1974, NULL),
    (3,  'Ruskin Bond',          'India',   1934, NULL),
    (4,  'Preeti Shenoy',        'India',   1971, 1),     -- mentored by Chetan
    (5,  'Devdutt Pattanaik',    'India',   1970, NULL),
    (6,  'James Clear',          'USA',     1986, NULL),
    (7,  'Yuval Harari',         'Israel',  1976, NULL),
    (8,  'Alex Michaelides',     'UK',      1977, 7),     -- mentored by Yuval
    (9,  'Robert Kiyosaki',      'USA',     1947, NULL),
    (10, 'Malcolm Gladwell',     'Canada',  1963, 7);     -- mentored by Yuval

-- ============================================================
-- books — 25 rows, spanning 7 genres and 10 authors
-- Author 3 (Ruskin Bond) and Author 9 (Kiyosaki) have some intentional
-- design decisions for LEFT JOIN demos below
-- ============================================================
CREATE TABLE books (
    book_id          INT PRIMARY KEY,
    title            VARCHAR(80),
    author_id        INT,
    genre            VARCHAR(30),
    price            DECIMAL(6, 2),
    published_year   INT,
    avg_rating       DECIMAL(3, 2),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO books VALUES
    -- Chetan Bhagat (author 1) — Fiction
    (101, 'Half Girlfriend',              1, 'Fiction',   199.00, 2014, 4.00),
    (102, 'One Indian Girl',              1, 'Fiction',   249.00, 2016, 3.80),
    (103, '400 Days',                     1, 'Fiction',   349.00, 2021, 4.10),
    -- Amish Tripathi (author 2) — Mythology
    (104, 'Immortals of Meluha',          2, 'Mythology', 299.00, 2010, 4.50),
    (105, 'Secret of the Nagas',          2, 'Mythology', 299.00, 2011, 4.60),
    (106, 'Oath of the Vayuputras',       2, 'Mythology', 399.00, 2013, 4.70),
    -- Ruskin Bond (author 3) — Fiction + Biography
    (107, 'The Room on the Roof',         3, 'Fiction',   199.00, 2012, 4.40),
    (108, 'Rain in the Mountains',        3, 'Fiction',   249.00, 2015, 4.50),
    (109, 'Landour Days',                 3, 'Biography', 299.00, 2018, 4.30),
    -- Preeti Shenoy (author 4)
    (110, 'Life is What You Make It',     4, 'Fiction',   299.00, 2011, 4.20),
    (111, 'The One You Cannot Have',      4, 'Fiction',   349.00, 2013, 4.00),
    -- Devdutt Pattanaik (author 5) — Mythology
    (112, 'Jaya',                         5, 'Mythology', 499.00, 2014, 4.60),
    (113, 'Sita',                         5, 'Mythology', 449.00, 2016, 4.50),
    (114, 'My Gita',                      5, 'Mythology', 399.00, 2018, 4.40),
    -- James Clear (author 6) — Self-Help
    (115, 'Atomic Habits',                6, 'Self-Help', 349.00, 2018, 4.70),
    -- Yuval Harari (author 7) — History
    (116, 'Sapiens',                      7, 'History',   499.00, 2011, 4.60),
    (117, 'Homo Deus',                    7, 'History',   599.00, 2015, 4.40),
    (118, '21 Lessons',                   7, 'History',   549.00, 2018, 4.30),
    -- Alex Michaelides (author 8) — Fiction
    (119, 'The Silent Patient',           8, 'Fiction',   399.00, 2019, 4.50),
    (120, 'The Maidens',                  8, 'Fiction',   449.00, 2021, 4.00),
    -- Robert Kiyosaki (author 9) — Business (only 1 book)
    (121, 'Rich Dad Poor Dad',            9, 'Business',  299.00, 2000, 4.40),
    -- Malcolm Gladwell (author 10) — Business
    (122, 'Outliers',                    10, 'Business',  449.00, 2008, 4.50),
    (123, 'Blink',                       10, 'Business',  399.00, 2005, 4.30),
    (124, 'Talking to Strangers',        10, 'Business',  549.00, 2019, 4.10),
    -- One book with NULL rating (new release)
    (125, 'The Wager',                    7, 'History',   599.00, 2024, NULL);

-- ============================================================
-- sales — 40 rows across 5 Indian cities and 6 months of 2024
-- Some books have NO sales (used for LEFT JOIN anti-join demos)
-- ============================================================
CREATE TABLE sales (
    sale_id        INT PRIMARY KEY,
    book_id        INT,
    quantity       INT,
    sale_date      DATE,
    city           VARCHAR(30),
    customer_type  VARCHAR(15),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO sales VALUES
    (1001, 101, 3, '2024-01-15', 'Bengaluru', 'Retail'),
    (1002, 104, 2, '2024-01-18', 'Mumbai',    'Retail'),
    (1003, 115, 5, '2024-01-22', 'Bengaluru', 'Corporate'),
    (1004, 116, 4, '2024-01-25', 'Delhi',     'Retail'),
    (1005, 121, 2, '2024-01-28', 'Bengaluru', 'Student'),
    (1006, 115, 3, '2024-02-02', 'Chennai',   'Retail'),
    (1007, 112, 1, '2024-02-05', 'Mumbai',    'Retail'),
    (1008, 116, 2, '2024-02-10', 'Bengaluru', 'Retail'),
    (1009, 122, 3, '2024-02-14', 'Delhi',     'Corporate'),
    (1010, 101, 1, '2024-02-18', 'Hyderabad', 'Student'),
    (1011, 115, 6, '2024-02-22', 'Bengaluru', 'Corporate'),
    (1012, 104, 3, '2024-02-25', 'Chennai',   'Retail'),
    (1013, 105, 2, '2024-03-01', 'Bengaluru', 'Retail'),
    (1014, 119, 4, '2024-03-05', 'Mumbai',    'Retail'),
    (1015, 116, 1, '2024-03-10', 'Delhi',     'Student'),
    (1016, 121, 5, '2024-03-14', 'Bengaluru', 'Corporate'),
    (1017, 115, 2, '2024-03-18', 'Chennai',   'Student'),
    (1018, 112, 3, '2024-03-22', 'Bengaluru', 'Retail'),
    (1019, 122, 2, '2024-03-25', 'Mumbai',    'Retail'),
    (1020, 107, 1, '2024-03-28', 'Delhi',     'Retail'),
    (1021, 104, 4, '2024-04-02', 'Bengaluru', 'Retail'),
    (1022, 115, 3, '2024-04-05', 'Hyderabad', 'Corporate'),
    (1023, 116, 2, '2024-04-10', 'Chennai',   'Retail'),
    (1024, 119, 3, '2024-04-14', 'Bengaluru', 'Student'),
    (1025, 121, 1, '2024-04-18', 'Mumbai',    'Retail'),
    (1026, 122, 4, '2024-04-22', 'Delhi',     'Corporate'),
    (1027, 112, 2, '2024-04-25', 'Bengaluru', 'Retail'),
    (1028, 115, 5, '2024-05-01', 'Bengaluru', 'Corporate'),
    (1029, 104, 2, '2024-05-05', 'Hyderabad', 'Retail'),
    (1030, 116, 3, '2024-05-10', 'Mumbai',    'Retail'),
    (1031, 121, 2, '2024-05-14', 'Chennai',   'Student'),
    (1032, 105, 1, '2024-05-18', 'Bengaluru', 'Retail'),
    (1033, 122, 2, '2024-05-22', 'Delhi',     'Retail'),
    (1034, 119, 3, '2024-05-25', 'Bengaluru', 'Corporate'),
    (1035, 115, 4, '2024-06-02', 'Mumbai',    'Retail'),
    (1036, 116, 1, '2024-06-05', 'Chennai',   'Student'),
    (1037, 112, 2, '2024-06-10', 'Bengaluru', 'Retail'),
    (1038, 121, 3, '2024-06-14', 'Delhi',     'Corporate'),
    (1039, 115, 2, '2024-06-18', 'Bengaluru', 'Retail'),
    (1040, 104, 1, '2024-06-22', 'Hyderabad', 'Retail');

-- ============================================================
-- Verify
-- ============================================================
SELECT COUNT(*) AS authors_count FROM authors;   -- 10
SELECT COUNT(*) AS books_count   FROM books;     -- 25
SELECT COUNT(*) AS sales_count   FROM sales;     -- 40
select * from authors;
select * from books;
select * from sales;
-- ======================SECTION-A============================
-- A1: B
-- A2: C
-- A3: C
-- A4: B
-- A5: B
-- A6: B
-- A7: B
-- A8: B

-- ======================SECTION-B============================
-- B1: It will return all commun columns from both books table and author table where author id is present. From my prediction there will be 25 rows present.
SELECT * FROM books b
INNER JOIN authors a ON b.author_id = a.author_id;
-- B2: It will return name from authors table and books table where book id is null. From my prediction there are 0 rows for this.
SELECT a.name FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
WHERE b.book_id IS NULL;
-- B3: It will return two columns one authors column and another mentors column where the author id of mentor column is equal to mentor id of author column. As there are only 3 mentors id so i predict there will be 3 rows.
SELECT a.name AS author, m.name AS mentor
FROM authors a
JOIN authors m ON a.mentor_id = m.author_id;
-- B4: It will return 5 rows as result as it select name from authors table where country is india and selected name from 
--   authors table where its author id is equal to author id of books table.
SELECT name FROM authors WHERE country = 'India'
UNION
SELECT a.name FROM authors a
JOIN books b ON a.author_id = b.author_id
WHERE b.genre = 'Mythology';
-- B5: It will return count = 13 as there are only 13 books which have price > avg price
SELECT COUNT(*) FROM books
WHERE price > (SELECT AVG(price) FROM books);
-- B6: It will return 15 rows of books table for book id which does not exist in sales table.
SELECT * FROM books b
WHERE NOT EXISTS (
 SELECT 1 FROM sales s WHERE s.book_id = b.book_id
);
-- B7: The total quantity of top selling book is 30
SELECT b.title, SUM(s.quantity) AS total_qty
FROM sales s JOIN books b ON s.book_id = b.book_id
GROUP BY b.book_id
ORDER BY total_qty DESC
LIMIT 1;
-- B8: This query will give columns as title, price and rank from books table where genre is business
SELECT title, price,
 RANK() OVER (PARTITION BY genre ORDER BY price DESC) AS rank_in_genre
FROM books WHERE genre = 'Business';

-- ======================SECTION-C============================
-- C1:Write a query using INNER JOIN to display each book's title alongside its author's name
SELECT a.name, b.title FROM authors a
INNER JOIN books b ON a.author_id = b.author_id;
-- C2:Write a LEFT JOIN query listing every author's name and every book they've written.
-- Authors with no books should still appear (once) with NULL for book columns.
SELECT a.name, b.title FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id;
-- C3:
SELECT SUM(s.quantity*b.price) AS revenue, b.genre FROM sales s
JOIN books b ON s.book_id=b.book_id
GROUP BY b.genre
ORDER BY revenue;
-- C4:
SELECT s.city, SUM(s.quantity * b.price) AS revenue
FROM sales s
JOIN books b ON s.book_id = b.book_id
GROUP BY s.city
ORDER BY revenue DESC
LIMIT 1;
-- C5:
SELECT a.name, b.title FROM authors a
RIGHT JOIN books b ON a.author_id = b.author_id;
-- C6:
SELECT a.name, b.title FROM authors a 
LEFT JOIN books b ON a.author_id = b.author_id
UNION
SELECT a.name, b.title FROM authors a 
RIGHT JOIN books b ON a.author_id = b.author_id;
-- C7:
SELECT a.name AS author, m.name AS mentor FROM authors a
JOIN authors m ON a.mentor_id = m.author_id;
-- C8:
SELECT c.city, ct.customer_type FROM (SELECT DISTINCT city FROM sales) c
CROSS JOIN (SELECT DISTINCT customer_type FROM sales) ct;
-- C9:
SELECT * FROM authors WHERE country = 'India'
UNION
SELECT * FROM authors WHERE born_year > 1970;
-- C10:
SELECT b.* FROM books b
LEFT JOIN sales s ON b.book_id = s.book_id
WHERE s.sale_id IS NULL;
-- C11:
SELECT * FROM books
WHERE price > (SELECT AVG(price) FROM books);
-- C12:
SELECT * FROM sales
WHERE book_id IN (SELECT book_id FROM books WHERE genre IN ('History', 'Mythology'));
-- C13:
SELECT * FROM books
WHERE price > ALL (SELECT price FROM books WHERE genre = 'Fiction');
-- C14:
SELECT b1.* FROM books b1
WHERE b1.price > (SELECT AVG(b2.price) FROM books b2 WHERE b2.genre = b1.genre );
-- C15:
SELECT a.* FROM authors a
WHERE EXISTS (SELECT 1 FROM books b WHERE b.author_id = a.author_id AND b.published_year > 2018);
-- C16:
SELECT a.* FROM authors a
WHERE NOT EXISTS (SELECT 1 FROM books b WHERE b.author_id = a.author_id AND b.genre = 'Business');
-- C17:
SELECT * FROM sales
WHERE book_id IN ( SELECT b.book_id FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE a.country = 'India');
-- C18:
SELECT title, genre, price,
AVG(price) OVER (PARTITION BY genre) AS genre_avg_price
FROM books;
-- C19:
SELECT title, genre, price, rn FROM (SELECT title, genre, price,
ROW_NUMBER() OVER (PARTITION BY genre ORDER BY price DESC) AS rn
FROM books) t
WHERE rn <= 2;
-- C20:
SELECT sale_id, sale_date, quantity,
LAG(quantity) OVER (ORDER BY sale_date) AS prev_quantity FROM sales
WHERE book_id = 115
ORDER BY sale_date;
-- C21:
SELECT sale_id, sale_date, quantity,
       SUM(quantity) OVER (ORDER BY sale_date) AS running_total
FROM sales
ORDER BY sale_date;
-- C22:
WITH book_totals AS (SELECT book_id, SUM(quantity) AS total_qty FROM sales
GROUP BY book_id)
SELECT b.title, bt.total_qty FROM book_totals bt
JOIN books b ON b.book_id = bt.book_id;
-- C23:
WITH genre_revenue AS (SELECT b.genre, SUM(s.quantity * b.price) AS revenue FROM sales s
JOIN books b ON s.book_id = b.book_id
GROUP BY b.genre),
ranked_genres AS (SELECT genre, revenue,
RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM genre_revenue)
SELECT * FROM ranked_genres;
-- C24:
WITH book_sales AS (SELECT b.book_id, b.title, b.genre, b.author_id, SUM(s.quantity) AS total_qty
FROM sales s
JOIN books b ON s.book_id = b.book_id
GROUP BY b.book_id, b.title, b.genre, b.author_id),
ranked_books AS (SELECT *,
ROW_NUMBER() OVER (PARTITION BY genre ORDER BY total_qty DESC) AS rn
FROM book_sales),
genre_revenue AS (SELECT b.genre, SUM(s.quantity * b.price) AS revenue FROM sales s
JOIN books b ON s.book_id = b.book_id
GROUP BY b.genre)
SELECT rb.genre,rb.title AS top_book,a.name AS author_name,rb.total_qty,gr.revenue AS genre_revenue
FROM ranked_books rb
JOIN authors a ON rb.author_id = a.author_id
JOIN genre_revenue gr ON rb.genre = gr.genre
WHERE rb.rn = 1
ORDER BY gr.revenue DESC;