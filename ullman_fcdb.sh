#!/bin/bash

# Define the SQLite database file
DB_FILE="./ullman.db"

# Remove the database file if it already exists
if [ -f "$DB_FILE" ]; then
    rm "$DB_FILE"
fi

# Execute the SQL commands
sqlite3 "$DB_FILE" <<EOF
-- Schema for Ullman First Course in Databases (SQLite3)

CREATE TABLE Beers (
    name TEXT PRIMARY KEY,
    manufacturer TEXT
);

CREATE TABLE Bars (
    name TEXT PRIMARY KEY,
    address TEXT
);

CREATE TABLE Drinkers (
    name TEXT PRIMARY KEY,
    address TEXT
);

CREATE TABLE Likes (
    drinker TEXT,
    beer TEXT,
    PRIMARY KEY (drinker, beer),
    FOREIGN KEY (drinker) REFERENCES Drinkers(name),
    FOREIGN KEY (beer) REFERENCES Beers(name)
);

CREATE TABLE Sells (
    bar TEXT,
    beer TEXT,
    price REAL,
    PRIMARY KEY (bar, beer),
    FOREIGN KEY (bar) REFERENCES Bars(name),
    FOREIGN KEY (beer) REFERENCES Beers(name)
);

CREATE TABLE Frequents (
    drinker TEXT,
    bar TEXT,
    PRIMARY KEY (drinker, bar),
    FOREIGN KEY (drinker) REFERENCES Drinkers(name),
    FOREIGN KEY (bar) REFERENCES Bars(name)
);

-- Insert data into Beers table
INSERT INTO Beers (name, manufacturer) VALUES
('Budweiser', 'Anheuser-Busch'),
('Corona', 'Grupo Modelo'),
('Heineken', 'Heineken N.V.'),
('Guinness', 'Diageo'),
('Coors Light', 'Molson Coors');

-- Insert data into Bars table
INSERT INTO Bars (name, address) VALUES
('Cheers', '123 Main St'),
('The Drunken Clam', '456 Ocean Ave'),
('Moe\'s Tavern', '789 Springfield Rd'),
('Paddy\'s Pub', '101 Paddy Lane'),
('The Prancing Pony', 'Middle Earth');

-- Insert data into Drinkers table
INSERT INTO Drinkers (name, address) VALUES
('John Doe', '111 Elm St'),
('Jane Smith', '222 Oak St'),
('Alice Johnson', '333 Pine St'),
('Bob Brown', '444 Maple St'),
('Charlie White', '555 Birch St');

-- Insert data into Likes table
INSERT INTO Likes (drinker, beer) VALUES
('John Doe', 'Budweiser'),
('Jane Smith', 'Corona'),
('Alice Johnson', 'Heineken'),
('Bob Brown', 'Guinness'),
('Charlie White', 'Coors Light'),
('John Doe', 'Heineken'),
('Jane Smith', 'Guinness');

-- Insert data into Sells table
INSERT INTO Sells (bar, beer, price) VALUES
('Cheers', 'Budweiser', 5.00),
('Cheers', 'Corona', 6.00),
('The Drunken Clam', 'Heineken', 7.00),
('Moe\'s Tavern', 'Guinness', 8.00),
('Paddy\'s Pub', 'Coors Light', 4.50),
('The Prancing Pony', 'Guinness', 9.00);

-- Insert data into Frequents table
INSERT INTO Frequents (drinker, bar) VALUES
('John Doe', 'Cheers'),
('Jane Smith', 'The Drunken Clam'),
('Alice Johnson', 'Moe\'s Tavern'),
('Bob Brown', 'Paddy\'s Pub'),
('Charlie White', 'The Prancing Pony'),
('John Doe', 'Moe\'s Tavern'),
('Jane Smith', 'Cheers');
EOF

echo "Database created at $DB_FILE"
