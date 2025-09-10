-- Script to manually create anotherDemo database and test2 table
-- Run this in SQL Server Management Studio if the automatic creation doesn't work

-- Create database
USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'anotherDemo')
BEGIN
    CREATE DATABASE anotherDemo;
    PRINT 'Database anotherDemo created successfully';
END
ELSE
BEGIN
    PRINT 'Database anotherDemo already exists';
END
GO

-- Use the new database
USE anotherDemo;
GO

-- Create test2 table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test2')
BEGIN
    CREATE TABLE test2 (
        roll int PRIMARY KEY,
        name nvarchar(100) NOT NULL
    );
    PRINT 'Table test2 created successfully';
END
ELSE
BEGIN
    PRINT 'Table test2 already exists';
END
GO

-- Insert some sample data for testing
INSERT INTO test2 (roll, name) VALUES 
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Mike Johnson');

PRINT 'Sample data inserted successfully';

-- Display all records
SELECT * FROM test2 ORDER BY roll;