# Stage 2 - Queries and Constraints

## Overview
This stage includes the implementation of SQL queries and constraints based on the previously defined database schema. The objective is to demonstrate proficiency with SELECT, DELETE, and UPDATE queries, use of transactions (ROLLBACK and COMMIT), and enforcing data integrity with constraints.

---

## Files Included

### 1. `Queries.sql`
Contains:
- 8 SELECT queries including examples of:
  - `GROUP BY`, `ORDER BY`, `HAVING`
  - `JOIN`
  - `SUBQUERY`
- 3 DELETE queries
- 3 UPDATE queries

### 2. `Constraints.sql`
Includes `ALTER TABLE` statements to add various constraints:
- `NOT NULL`, `CHECK`, `DEFAULT`, and `UNIQUE`
- Ensures data integrity across all tables (Card, CardLimit, CardTransaction, etc.)

### 3. `RollbackCommands.sql`
Demonstrates use of transactions with:
- One update wrapped in a `BEGIN ... ROLLBACK;` block (changes are canceled)
- One update wrapped in a `BEGIN ... COMMIT;` block (changes are saved)

### 4. `backup2.sql` (optional)
A backup file for the database state before or after performing queries.

---

## How to Use

1. Run `Constraints.sql` to enforce data constraints on existing tables.
2. Execute queries from `Queries.sql` to explore and manipulate data.
3. Test transaction handling with `RollbackCommands.sql`:
   - First, try with `ROLLBACK` to see that changes are not saved.
   - Then, try with `COMMIT` to see that changes are permanent.

---

## Notes

- Make sure to use a database system that supports transactions (such as PostgreSQL).
- All files are prepared to be run independently, but the order is: constraints → queries → transactions.
- Tag this stage in Git with: `stage-2-completed`