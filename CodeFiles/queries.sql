										-- /* SELECT */ --
--1. Returns all expired card details
SELECT 
  card_id, userid, account_id, expiry_date, status,
  CURRENT_DATE - expiry_date AS days_since_expiry
FROM Card
WHERE status = 'Expired';


--2. How many cards are there of each type, and the order from the highest number of cards to the lowest number of cards.
SELECT type_id, COUNT(*) AS card_count
FROM Card
GROUP BY type_id
ORDER BY card_count DESC;


--3. Returns users with more than two cards, and the status of each card.
SELECT c.userid, c.card_id, c.status
FROM Card c
WHERE c.userid IN (
  SELECT userid
  FROM Card
  GROUP BY userid
  HAVING COUNT(*) > 2
)
ORDER BY c.userid, c.card_id;


--4. How many transactions in each merchant category?
SELECT merchant_category, COUNT(*) AS transaction_count
FROM CardTransaction
GROUP BY merchant_category
ORDER BY transaction_count DESC;


--5. How many transactions were declined per card?
SELECT card_id, COUNT(*) AS declined_count
FROM CardTransaction
WHERE status = 'Declined'
GROUP BY card_id
ORDER BY declined_count DESC;


--6. Monthly transaction amount per card
SELECT card_id, DATE_TRUNC('month', transaction_date) AS transaction_month, SUM(amount) AS total_amount
FROM CardTransaction
GROUP BY card_id, transaction_month
ORDER BY card_id, transaction_month;


--7. How many transactions were made in each city?
SELECT location, COUNT(*) AS transaction_count
FROM CardTransaction
GROUP BY location
ORDER BY transaction_count DESC;


--8. The ten categories with the highest total shopping amount	
SELECT merchant_category, SUM(amount) AS total_amount
FROM CardTransaction
GROUP BY merchant_category
ORDER BY total_amount DESC
LIMIT 10;





									-- /* DELETE */ --
--1. Deleting cards that were involved in fraudulent events
SELECT *
FROM Card
WHERE card_id IN (
    SELECT card_id
    FROM CardFraud
);
DELETE FROM Card
WHERE card_id IN (
    SELECT card_id
    FROM CardFraud
);

--2. Deleting expired card transactions
SELECT *
FROM CardTransaction
WHERE card_id IN (
    SELECT card_id
    FROM Card
    WHERE status = 'Expired'
);
DELETE FROM CardTransaction
WHERE card_id IN (
    SELECT card_id
    FROM Card
    WHERE status = 'Expired'
);

--3. Deleting cards on which no transaction has been made in the last five months
SELECT *
FROM Card
WHERE card_id NOT IN (
    SELECT DISTINCT card_id
    FROM CardTransaction
    WHERE transaction_date >= CURRENT_DATE - INTERVAL '5 months'
);
DELETE FROM Card
WHERE card_id NOT IN (
    SELECT DISTINCT card_id
    FROM CardTransaction
    WHERE transaction_date >= CURRENT_DATE - INTERVAL '5 months'
);





									-- /* UPDATE */ --
--1. Update cards that are expired but not yet marked as 'Expired'
SELECT *
FROM Card
WHERE expiry_date < CURRENT_DATE
AND status != 'Expired';

UPDATE Card
SET status = 'Expired'
WHERE expiry_date < CURRENT_DATE
AND status != 'Expired';


--2. Card limit update: Increase max_value by 10% for those who haven't updated in 3 months
SELECT *
FROM CardLimit
WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

UPDATE CardLimit
SET max_value = max_value * 1.10

WHERE effective_date < CURRENT_DATE - INTERVAL '3 months';

--3. 20% reduction in limit for cards with low annual usage
SELECT cl.card_id, SUM(ct.amount) AS total_spent, cl.max_value
FROM CardLimit cl
JOIN CardTransaction ct ON cl.card_id = ct.card_id
WHERE ct.transaction_date >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY cl.card_id, cl.max_value
HAVING SUM(ct.amount) <= 12000;

UPDATE CardLimit
SET max_value = max_value * 0.80
WHERE card_id IN (
    SELECT card_id
    FROM CardTransaction
    WHERE transaction_date >= CURRENT_DATE - INTERVAL '12 months'
    GROUP BY card_id
    HAVING SUM(amount) <= 12000
);
