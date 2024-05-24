USE library;

-- View: num_books_lent
CREATE VIEW num_books_lent AS
SELECT CONCAT(fname, ' ', lname) AS user_name, COUNT(user_id) AS books_lent
FROM users u
JOIN lending l
USING(user_id)
GROUP BY user_name
ORDER BY books_lent DESC;

-- View: over_due_books
CREATE VIEW over_due_books AS
SELECT CONCAT(fname, ' ', lname) AS user_name, COUNT(days_overdue) AS over_due_books
FROM users u
JOIN lending l
USING(user_id)
WHERE days_overdue > 0
GROUP BY user_name
ORDER BY over_due_books DESC;

-- View: largest_genres
CREATE VIEW largest_genres AS
SELECT genre_name, COUNT(genre_id) AS num_books
FROM books b
JOIN genre g
USING(genre_id)
GROUP BY genre_name
HAVING num_books > 2
ORDER BY num_books DESC;

-- View: largest_publishers
CREATE VIEW largest_publishers AS
SELECT publisher_name, COUNT(publisher_id) AS num_books_published
FROM books b
JOIN publishers p
USING(publisher_id)
GROUP BY publisher_id
HAVING num_books_published > 1
ORDER BY num_books_published DESC;

-- View: largest_authors
CREATE VIEW largest_authors AS
SELECT CONCAT(fname, ' ', lname) AS author_name, COUNT(author_id) AS num_books_authored
FROM books b
JOIN authors a
USING(author_id)
GROUP BY author_id
HAVING num_books_authored > 2
ORDER BY num_books_authored DESC;
