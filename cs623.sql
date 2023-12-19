# Creating a Table:

CREATE TABLE Product (
    prodid VARCHAR(10) PRIMARY KEY,
    pname VARCHAR(50),
    price NUMERIC
);

CREATE TABLE Depot (
    depid VARCHAR(10) PRIMARY KEY,
    addr VARCHAR(50),
    volume INT
);

CREATE TABLE Stock (
    prodid VARCHAR(10) REFERENCES Product(prodid),
    depid VARCHAR(10) REFERENCES Depot(depid),
    quantity INT,
    PRIMARY KEY (prodid, depid)
);


# Inserting Data:

INSERT INTO Product VALUES
    ('p1', 'tape', 2.5),
    ('p2', 'tv', 250),
    ('p3', 'vcr', 80);


INSERT INTO Depot VALUES
    ('d1', 'New York', 9000),
    ('d2', 'Syracuse', 6000),
    ('d4', 'New York', 2000);


INSERT INTO Stock VALUES
    ('p1', 'd1', 1000),
    ('p1', 'd2', -100),
    ('p1', 'd4', 1200),
    ('p3', 'd1', 3000),
    ('p3', 'd4', 2000),
    ('p2', 'd4', 1500),
    ('p2', 'd1', -400),
    ('p2', 'd2', 2000);


# Transactions:
# Transaction 1: Delete product p1 from Product and Stock
BEGIN;
DELETE FROM Stock WHERE prodid = 'p1';
DELETE FROM Product WHERE prodid = 'p1';
COMMIT;

# Transaction 2: Delete depot d1 from Depot and Stock
BEGIN;
DELETE FROM Stock WHERE depid = 'd1';
DELETE FROM Depot WHERE depid = 'd1';
COMMIT;

# Transaction 3: Change the name of product p1 to pp1 in Product and Stock
BEGIN;
UPDATE Product SET pname = 'pp1' WHERE prodid = 'p1';
UPDATE Stock SET prodid = 'pp1' WHERE prodid = 'p1';
COMMIT;

# Transaction 4: Change the name of depot d1 to dd1 in Depot and Stock
BEGIN;
UPDATE Depot SET addr = 'dd1' WHERE depid = 'd1';
UPDATE Stock SET depid = 'dd1' WHERE depid = 'd1';
COMMIT;

# Transaction 5: Add a new product (p100, cd, 5) in Product and (p100, d2, 50) in Stock
BEGIN;
INSERT INTO Product VALUES ('p100', 'cd', 5);
INSERT INTO Stock VALUES ('p100', 'd2', 50);
COMMIT;

# Transaction 6: Add a new depot (d100, Chicago, 100) in Depot and (p1, d100, 100) in Stock
BEGIN;
INSERT INTO Depot VALUES ('d100', 'Chicago', 100);
INSERT INTO Stock VALUES ('p1', 'd100', 100);
COMMIT;