-- cardType
INSERT INTO cardType (type_name, description, daily_limit, withdrawal_limit, annual_fee) VALUES
('Classic', 'Basic card with limited features', 1000.00, 500.00, 50.00),
('Gold', 'Premium card with higher limits', 5000.00, 2000.00, 150.00),
('Platinum', 'Elite card with full privileges', 10000.00, 5000.00, 300.00);

-- TransactionType
INSERT INTO TransactionType (description) VALUES
('Purchase'),
('Withdrawal'),
('Online Payment');

-- LimitType
INSERT INTO LimitType (description) VALUES
('Daily Limit'),
('Monthly Limit'),
('Transaction Limit');

-- FraudType
INSERT INTO FraudType (description) VALUES
('Stolen Card'),
('Unusual Location'),
('High Amount');


INSERT INTO CardLimit (current_value, max_value, effective_date, id) VALUES
(500.00, 1000.00, '2024-01-01', 1),  -- Daily Limit
(2000.00, 3000.00, '2024-02-15', 2), -- Monthly Limit
(150.00, 500.00, '2024-03-10', 3);   -- Transaction Limit


INSERT INTO card (account_id, status, cvv, expiry_date, issue_number, userid, type_id, limit_id) VALUES
(1001, 'Active', 123, '2026-12-31', 1, 501, 1, 1),
(1002, 'Blocked', 456, '2025-10-15', 2, 502, 2, 2),
(1003, 'Active', 789, '2027-05-20', 3, 503, 3, 3);


INSERT INTO CardTransaction (transaction_date, amount, merchant_name, merchant_category, location, status, card_id, id) VALUES
('2024-04-01', 99.99, 'ZARA', 'Clothing', 'Tel Aviv', 'Completed', 1, 1), -- Purchase
('2024-04-02', 500.00, 'ATM Machine', 'Cash', 'Jerusalem', 'Completed', 2, 2), -- Withdrawal
('2024-04-03', 200.00, 'Amazon', 'E-commerce', 'Online', 'Pending', 3, 3); -- Online Payment


INSERT INTO CardFraud (detection_date, amount_involved, resolution_status, resolution_date, card_id, id) VALUES
('2024-04-10', 1200.00, 'Resolved', '2024-04-12', 1, 1), -- Stolen Card
('2024-04-11', 800.00, 'Under Investigation', '2024-04-13', 2, 2), -- Unusual Location
('2024-04-12', 3000.00, 'Blocked', '2024-04-14', 3, 3); -- High Amount


INSERT INTO CardHistory (reason, request_date, new_card_id, status, card_id) VALUES
('Card Expired', '2024-04-15', 10, 'Issued', 1),
('Lost Card', '2024-04-16', 11, 'Processing', 2),
('Card Upgrade', '2024-04-17', 12, 'Issued', 3);
