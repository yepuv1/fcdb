#!/bin/bash

# Define the SQLite database file
DB_FILE="./contact.db"

# Remove the database file if it already exists
if [ -f "$DB_FILE" ]; then
    rm "$DB_FILE"
fi

# Execute the SQL commands to create the schema and populate the database
sqlite3 "$DB_FILE" <<EOF
-- SQLite schema for an Address Book

CREATE TABLE contacts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone_number TEXT,
    email TEXT,
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to update the updated_at column on row update
CREATE TRIGGER update_timestamp
AFTER UPDATE ON contacts
FOR EACH ROW
BEGIN
    UPDATE contacts
    SET updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.id;
END;

-- Insert sample data into the contacts table
INSERT INTO contacts (first_name, last_name, phone_number, email, address)
VALUES 
('John', 'Doe', '123-456-7890', 'john.doe@example.com', '123 Elm Street'),
('Jane', 'Smith', '987-654-3210', 'jane.smith@example.com', '456 Oak Avenue'),
('Alice', 'Johnson', '555-123-4567', 'alice.johnson@example.com', '789 Pine Road'),
('Bob', 'Brown', '444-555-6666', 'bob.brown@example.com', '321 Maple Lane');

-- Query to select all contacts
SELECT * FROM contacts;

-- Query to select a contact by ID
SELECT * FROM contacts WHERE id = 1;

-- Query to update a contact
UPDATE contacts
SET phone_number = '111-222-3333'
WHERE id = 1;
EOF

echo "SQLite database created at $DB_FILE"
