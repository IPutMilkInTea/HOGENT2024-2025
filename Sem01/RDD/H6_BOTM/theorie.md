# H6 Basics of transaction management

## **1. What is a Transaction?**

A **transaction** is a group of SQL operations performed as a single unit. Either **all operations succeed** (commit) or **none take effect** (rollback).  

**Example:**  
Transferring money between two accounts:  

1. Deduct from account A.
2. Add to account B.  

**If either step fails,** the entire operation is rolled back.

---

## **2. ACID Properties of Transactions:**  

- **A**tomicity – All operations are executed or none at all.  
- **C**onsistency – The database transitions from one valid state to another.  
- **I**solation – Concurrent transactions do not interfere with each other.  
- **D**urability – Once committed, changes persist even in case of system failure.  

---

## **3. SQL Example (ACID in Practice):**  

```sql
BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 100
WHERE AccountID = 1;

UPDATE Accounts
SET Balance = Balance + 100
WHERE AccountID = 2;

COMMIT;
```

- If any `UPDATE` fails, use `ROLLBACK` to undo changes.  

```sql
ROLLBACK;
```

---

## **4. Transaction Lifecycle (Delineating Transactions):**  

- **Explicit Transactions:**  

```sql
BEGIN TRANSACTION;
-- SQL statements
COMMIT;
```

- **Implicit Transactions:**
Executed automatically with each SQL statement.  

---

## **5. Logging (Logfile):**  

**Purpose:**  

- Tracks all operations in a transaction.  
- Stores **before and after** images of records.  
- Essential for rollback (UNDO) and recovery (REDO).  

**Example (Write-Ahead Logging):**  

```sql
-- Before image logged
UPDATE Products SET Price = 150 WHERE ProductID = 1;
```

---

## **6. Recovery Mechanisms:**  

- **System Failure** – DBMS or OS crash.  
- **Media Failure** – Disk corruption or unavailability.  
- **Transaction Failure** – Logical error (e.g., divide by zero).  

---

## **7. Recovery Techniques:**  

- **Undo (ROLLBACK):** Reverts uncommitted transactions.  
- **Redo (COMMIT):** Reapplies committed transactions.  

**Example:**  

```sql
-- UNDO example
ROLLBACK TRANSACTION;

-- REDO example
COMMIT TRANSACTION;
```

---

## **8. Concurrency Control:**  

Ensures transactions do not interfere with each other when accessing the same data.  

**Concurrency Issues:**

1. **Lost Update:** Two transactions update the same record.  
2. **Dirty Read:** Reading uncommitted data from another transaction.  
3. **Non-Repeatable Read:** Re-reading data gives different results.  
4. **Phantom Read:** Rows added/deleted by another transaction appear/disappear.  

---

## **9. Locking Protocols (Pessimistic vs Optimistic):**  

- **Exclusive Lock (X-Lock):** One transaction writes, no others can read or write.  
- **Shared Lock (S-Lock):** Multiple transactions can read, but none can write.  

**Example:**

```sql
-- Shared Lock
SELECT * FROM Orders WITH (HOLDLOCK);

-- Exclusive Lock
UPDATE Orders SET Status = 'Shipped' WHERE OrderID = 1;
```

---

## **10. Isolation Levels in SQL Server:**  

- **Read Uncommitted** – Can read uncommitted data (dirty read).  
- **Read Committed (Default)** – Only reads committed data.  
- **Repeatable Read** – Locks all read rows to prevent modification.  
- **Serializable** – Locks entire range, preventing inserts/updates/deletes.  

**Example (Isolation Level):**  

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

---

## **11. Deadlock Detection and Prevention:**  

**Deadlock:** Two transactions wait for each other’s resources.  
**Prevention:** Lock all resources at the start (2-phase locking).  

**Example:**  

```sql
-- Deadlock scenario
BEGIN TRANSACTION;
UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;
UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;
```

---

## **12. Backup and Recovery Strategies:**  

- **Full Backup:** Entire database.  
- **Incremental Backup:** Only changed data since last backup.  

**Example:**

```sql
BACKUP DATABASE MyDB TO DISK = 'D:\Backup\MyDB.bak';
```
