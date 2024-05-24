# Library Database Views

This repository contains SQL queries to create views for analyzing various aspects of a library database. Each view provides specific insights into the library's data, such as the number of books lent, overdue books, genres, publishers, and authors.

## Database Schema

Before running the queries, ensure your database contains the following tables:

- `users`
  - `user_id`
  - `fname`
  - `lname`

- `lending`
  - `user_id`
  - `days_overdue`

- `books`
  - `book_id`
  - `genre_id`
  - `publisher_id`
  - `author_id`

- `genre`
  - `genre_id`
  - `genre_name`

- `publishers`
  - `publisher_id`
  - `publisher_name`

- `authors`
  - `author_id`
  - `fname`
  - `lname`

## Instructions

1. **Switch to the `library` database:**

   ```sql
   USE library;
