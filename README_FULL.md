# 🏦 Card Management System - Database Project

This project demonstrates a relational database system for managing credit cards, transactions, fraud detection, and card history, implemented using PostgreSQL.

---

## 📁 Contents

- [1. ERD & DSD](#1-erd--dsd)
- [2. Table Creation](#2-table-creation)
- [3. Sample Data (SQL + CSV)](#3-sample-data-sql--csv)
- [4. Select All Queries](#4-select-all-queries)
- [5. Stage 2 – SQL Queries & Constraints](#5-stage-2--sql-queries--constraints)
- [6. Transactions: Rollback & Commit](#6-transactions-rollback--commit)

---

## 1. ERD & DSD

### 📊 Entity-Relationship Diagram (ERD)
![ERD](images/ERD/CardManagement_ERD.png)

### 🧱 Data Structure Diagram (DSD)
![DSD](images/DSD/CardManagement_DSD.png)

---

## 2. Table Creation

**SQL File:** [`creatTable.sql`](creatTable.sql)

Defines the following tables:
- cardType
- TransactionType
- LimitType
- FraudType
- CardLimit
- card
- CardTransaction
- CardFraud
- CardHistory

---

## 3. Sample Data (SQL + CSV)

### 📜 SQL Inserts: [`insertTable.sql`](insertTable.sql)

Includes sample data for all tables using `INSERT INTO` statements.

### 📂 CSV Files:
These files provide the same data in CSV format (can be used for `COPY` commands):
- `CardDATA.csv`
- `CardTransactionDATA.csv`
- `CardFraudDATA.csv`
- `CardHistoryDATA.csv`
- `CardLimitDATA.csv`
- `cardTypeDATA.csv`
- `FraudTypeDATA.csv`
- `LimitTypeDATA.csv`
- `TransactionTypeDATA.csv`

---

## 4. Select All Queries

**SQL File:** [`selectAll.sql`](selectAll.sql)  
Returns all data from each table for verification and testing.

---

## 5. Stage 2 – SQL Queries & Constraints

### 🔍 SQL Queries

**File:** [`Queries.sql`](Queries.sql)

Includes:
- 8 `SELECT` queries with `GROUP BY`, `HAVING`, `JOIN`, and `SUBQUERY`
- 3 `DELETE` queries
- 3 `UPDATE` queries

#### Example Query: Get Expired Cards

```sql
SELECT 
  card_id, userid, account_id, expiry_date, status,
  CURRENT_DATE - expiry_date AS days_since_expiry
FROM Card
WHERE status = 'Expired';
```

> 💡 Screenshot Result:  
> ![Expired Cards](images/select/expired_cards.png)

_Add similar blocks for other queries..._

---

### 🛡️ Constraints

**File:** [`Constraints.sql`](Constraints.sql)

Includes `CHECK`, `DEFAULT`, and `UNIQUE` constraints for:
- Validating numeric ranges
- Limiting string lengths
- Enforcing status values
- Preventing invalid dates

---

## 6. Transactions: Rollback & Commit

**File:** [`RollbackCommands.sql`](RollbackCommands.sql)

Demonstrates use of transactions with:
- ROLLBACK example (undo changes)
- COMMIT example (apply changes)

```sql
BEGIN;

UPDATE CardLimit
SET max_value = max_value * 1.10
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

ROLLBACK;
```

> 💡 Screenshot (before and after):  
> ![Rollback Screenshot](images/transactions/rollback_example.png)

---

## ✅ Final Notes

- Make sure to use PostgreSQL or compatible system that supports transactions and constraints.
- All SQL files were tested inside a Dockerized PostgreSQL environment.
- For detailed instructions on how to run the scripts and populate data, refer to each script file and comments inside.