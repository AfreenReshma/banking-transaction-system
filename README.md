## banking-transaction-system.
##🏦 Banking Transaction Management System with Rollback Control (MySQL)

This project simulates a real-world banking transaction system using MySQL.
It includes secure fund transfers, ACID transactions, rollback control, triggers, logs, and error handling,
making it an ideal project for SQL Developer & Database Engineer portfolios.

##🎯 Objective

To build a reliable banking database that supports:

Fund transfers
Balance updates
Automatic rollback on errors
Transaction logging
Prevention of negative balances
Using full ACID principles: Atomicity, Consistency, Isolation, Durability.


##🧩 Key SQL Concepts Used

1. Transactions

Used START TRANSACTION, COMMIT, and ROLLBACK to ensure that:
Either the entire transfer is completed
Or nothing is updated (rollback)
Guarantees safe and reliable fund movements.

2. Stored Procedure (TransferFunds)

A stored procedure is created to handle the complete transfer process.
It includes:
*Checking whether sender exists
*Validating sufficient balance
*Transferring money between accounts
*Handling errors
*Logging every transaction
*Committing or rolling back the transaction
This simulates real-world banking rules and workflow.

3. Transaction Logs

A separate table stores all activity:
*Successful transfers
*Failed transfers
*Failure reasons
This adds transparency, accountability, and auditing capability.

This project helped me master database transactions, stored procedures, triggers,
and MySQL’s isolation levels — essential skills for Database Engineers and SQL Developers.
