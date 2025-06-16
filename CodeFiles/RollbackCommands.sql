-- File: RollbackCommands.sql
-- Purpose: Demonstrate the use of ROLLBACK and COMMIT
-- Transactions allow you to make changes and then decide whether to save or discard them.

-- Transaction with ROLLBACK (changes will not be saved)
BEGIN;

-- Increase max_value by 10% for those who haven't updated in 3 months
UPDATE CardLimit
SET max_value = max_value * 1.10
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

-- Optionally check the result
SELECT * FROM CardLimit
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

-- Revert the changes
ROLLBACK;



-- Transaction with COMMIT (changes will be saved)
BEGIN;

UPDATE CardLimit
SET max_value = max_value * 1.10
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

-- Optionally check the result
SELECT * FROM CardLimit
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

-- Confirm and save the changes
COMMIT;