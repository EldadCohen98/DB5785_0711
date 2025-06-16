-- Constraints for cardType table
ALTER TABLE cardType
ADD CONSTRAINT check_daily_limit_positive
CHECK (daily_limit >= 0);

ALTER TABLE cardType
ADD CONSTRAINT check_withdrawal_limit_positive
CHECK (withdrawal_limit >= 0);

ALTER TABLE cardType
ADD CONSTRAINT check_annual_fee_positive
CHECK (annual_fee >= 0);

ALTER TABLE cardType
ALTER COLUMN annual_fee SET DEFAULT 0;



-- Constraints for TransactionType table
ALTER TABLE TransactionType
ADD CONSTRAINT check_description_length
CHECK (LENGTH(description) <= 50);



-- Constraints for LimitType table
ALTER TABLE LimitType
ADD CONSTRAINT check_description_length
CHECK (LENGTH(description) <= 50);

ALTER TABLE LimitType
ADD CONSTRAINT unique_description
UNIQUE (description);



-- Constraints for FraudType table
ALTER TABLE FraudType
ADD CONSTRAINT check_fraud_description_length
CHECK (LENGTH(description) <= 50);

ALTER TABLE FraudType
ADD CONSTRAINT unique_fraud_description
UNIQUE (description);



-- Constraints for CardLimit table

ALTER TABLE CardLimit
ADD CONSTRAINT check_current_value_positive
CHECK (current_value >= 0);

ALTER TABLE CardLimit
ADD CONSTRAINT check_max_ge_current
CHECK (max_value >= current_value);

-- Optional: prevent future effective dates
ALTER TABLE CardLimit
ADD CONSTRAINT check_effective_date_not_future
CHECK (effective_date <= CURRENT_DATE);



-- Constraints for card table
ALTER TABLE card
ADD CONSTRAINT check_card_status
CHECK (status IN ('Active', 'Blocked', 'Expired', 'Cancelled'));

ALTER TABLE card
ADD CONSTRAINT check_card_cvv_range
CHECK (cvv BETWEEN 100 AND 999);

ALTER TABLE card
ADD CONSTRAINT check_issue_number_positive
CHECK (issue_number > 0);



-- Constraints for CardTransaction table
ALTER TABLE CardTransaction
ADD CONSTRAINT check_transaction_amount_positive
CHECK (amount > 0);

ALTER TABLE CardTransaction
ADD CONSTRAINT check_transaction_date_not_future
CHECK (transaction_date <= CURRENT_DATE);

ALTER TABLE CardTransaction
ADD CONSTRAINT check_transaction_status
CHECK (status IN ('Approved', 'Declined', 'Reversed', 'Pending'));

ALTER TABLE CardTransaction
ADD CONSTRAINT check_merchant_name_length
CHECK (LENGTH(merchant_name) <= 50);

ALTER TABLE CardTransaction
ADD CONSTRAINT check_location_length
CHECK (LENGTH(location) <= 50);



-- Constraints for CardFraud table
ALTER TABLE CardFraud
ADD CONSTRAINT check_fraud_amount_positive
CHECK (amount_involved > 0);

ALTER TABLE CardFraud
ADD CONSTRAINT check_detection_date_not_future
CHECK (detection_date <= CURRENT_DATE);

ALTER TABLE CardFraud
ADD CONSTRAINT check_resolution_after_detection
CHECK (resolution_date >= detection_date);

ALTER TABLE CardFraud
ADD CONSTRAINT check_resolution_status_valid
CHECK (resolution_status IN ('Dismissed', 'Investigating', 'Pending', 'Resolved'));



-- Constraints for CardHistory table
ALTER TABLE CardHistory
ADD CONSTRAINT check_reason_length
CHECK (LENGTH(reason) <= 100);

ALTER TABLE CardHistory
ADD CONSTRAINT check_request_date_not_future
CHECK (request_date <= CURRENT_DATE);

ALTER TABLE CardHistory
ADD CONSTRAINT check_new_card_id_positive
CHECK (new_card_id > 0);

ALTER TABLE CardHistory
ADD CONSTRAINT check_card_history_status
CHECK (status IN ('Cancelled', 'Completed', 'Pending', 'Processed'));
