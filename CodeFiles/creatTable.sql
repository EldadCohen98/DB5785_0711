CREATE TABLE cardType (
  type_id INT PRIMARY KEY,
  type_name TEXT NOT NULL,
  description TEXT,
  daily_limit NUMERIC(10,2) NOT NULL,
  withdrawal_limit NUMERIC(10,2) NOT NULL,
  annual_fee NUMERIC(10,2) NOT NULL
);

CREATE TABLE TransactionType (
  id INT PRIMARY KEY,
  description TEXT UNIQUE NOT NULL
);

CREATE TABLE LimitType (
  id INT PRIMARY KEY,
  description TEXT NOT NULL
);

CREATE TABLE FraudType (
  id INT PRIMARY KEY,
  description TEXT NOT NULL
);

CREATE TABLE CardLimit (
  limit_id INT PRIMARY KEY,
  current_value NUMERIC(10,2) NOT NULL,
  max_value NUMERIC(10,2) NOT NULL,
  effective_date DATE NOT NULL,
  id INT NOT NULL REFERENCES LimitType(id)
);

CREATE TABLE card (
  card_id INT PRIMARY KEY,
  account_id INT NOT NULL,
  status TEXT NOT NULL,
  cvv INT NOT NULL,
  expiry_date DATE NOT NULL,
  issue_number INT NOT NULL,
  userid INT NOT NULL,
  type_id INT NOT NULL REFERENCES cardType(type_id),
  limit_id INT NOT NULL REFERENCES CardLimit(limit_id)
);

CREATE TABLE CardTransaction (
  transaction_id INT PRIMARY KEY,
  transaction_date DATE NOT NULL,
  amount NUMERIC(10,2) NOT NULL,
  merchant_name TEXT NOT NULL,
  merchant_category TEXT NOT NULL,
  location TEXT NOT NULL,
  status TEXT NOT NULL,
  card_id INT NOT NULL REFERENCES card(card_id),
  id INT NOT NULL REFERENCES TransactionType(id)
);

CREATE TABLE CardFraud (
  fraud_id INT PRIMARY KEY,
  detection_date DATE NOT NULL,
  amount_involved NUMERIC(10,2) NOT NULL,
  resolution_status TEXT NOT NULL,
  resolution_date DATE NOT NULL,
  card_id INT NOT NULL REFERENCES card(card_id),
  id INT NOT NULL REFERENCES FraudType(id)
);

CREATE TABLE CardHistory (
  replacement_id INT PRIMARY KEY,
  reason TEXT NOT NULL,
  request_date DATE NOT NULL,
  new_card_id INT NOT NULL,
  status TEXT NOT NULL,
  card_id INT NOT NULL REFERENCES card(card_id)
);
