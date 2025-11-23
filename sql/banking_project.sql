-- Create Database
CREATE DATABASE banking_system;
USE banking_system;

-------------------------------------------------
-- TABLE 1: Accounts Table
-------------------------------------------------
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    balance DECIMAL(10,2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Sample Data
INSERT INTO accounts (account_id, account_holder, balance) VALUES
(1, 'Afrin Reshma', 5000.00),
(2, 'Neha Sharma', 3000.00),
(3, 'Rahul Verma', 7000.00);

-------------------------------------------------
-- TABLE 2: Transaction Logs Table
-------------------------------------------------
CREATE TABLE transaction_logs (
    sender_id INT,
    receiver_id INT,
    amount DECIMAL(10,2),
    status VARCHAR(50)  
);

-------------------------------------------------
-- STORED PROCEDURE: Transfer Funds
-------------------------------------------------
DELIMITER //

CREATE PROCEDURE TransferFunds(
    IN sender_id INT,
    IN receiver_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE sender_balance DECIMAL(10,2);
    DECLARE account_exists INT DEFAULT 0;
    DECLARE error_occurred BOOLEAN DEFAULT FALSE;

    START TRANSACTION;

    -- Step 1: Check if sender exists
    SELECT COUNT(*) INTO account_exists 
    FROM accounts 
    WHERE account_id = sender_id;

    IF account_exists = 0 THEN
        SET error_occurred = TRUE;

        INSERT INTO transaction_logs (sender_id, receiver_id, amount, status)
        VALUES (sender_id, receiver_id, amount, 'FAILED - INVALID SENDER');

    ELSE
        -- Step 2: Get sender balance
        SELECT balance INTO sender_balance 
        FROM accounts 
        WHERE account_id = sender_id;

        IF sender_balance < amount THEN
            SET error_occurred = TRUE;

            INSERT INTO transaction_logs (sender_id, receiver_id, amount, status)
            VALUES (sender_id, receiver_id, amount, 'FAILED - INSUFFICIENT BALANCE');

        ELSE
            -- Deduct from sender
            UPDATE accounts 
            SET balance = balance - amount,
                last_updated = NOW()
            WHERE account_id = sender_id;

            -- Add to receiver
            UPDATE accounts 
            SET balance = balance + amount,
                last_updated = NOW()
            WHERE account_id = receiver_id;

            INSERT INTO transaction_logs (sender_id, receiver_id, amount, status)
            VALUES (sender_id, receiver_id, amount, 'SUCCESS');
        END IF;
    END IF;

    -- Commit or Rollback
    IF error_occurred THEN
        ROLLBACK;
        SELECT 'Transaction Failed' AS Message;
    ELSE
        COMMIT;
        SELECT 'Transaction Successful' AS Message;
    END IF;
END //

DELIMITER ;

-------------------------------------------------
-- TEST CASES
-------------------------------------------------
-- CALL TransferFunds(1, 2, 2000.00);  
-- CALL TransferFunds(2, 3, 90000.00); 
-- SELECT * FROM accounts;
-- SELECT * FROM transaction_logs;
