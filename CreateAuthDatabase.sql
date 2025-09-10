-- Simple Authentication for SQLEXPRESS
-- Uses your existing anotherDemo database to add authentication

USE anotherDemo;
GO

-- Create AdminUsers table in your existing anotherDemo database
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
BEGIN
    CREATE TABLE AdminUsers (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) UNIQUE NOT NULL,
        Password NVARCHAR(256) NOT NULL,
        Email NVARCHAR(200),
        FullName NVARCHAR(100),
        IsActive BIT DEFAULT 1,
        LastLogin DATETIME,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'AdminUsers table created in anotherDemo database!';
END
ELSE
BEGIN
    PRINT 'AdminUsers table already exists.';
END
GO

-- Insert admin user credentials
IF NOT EXISTS (SELECT * FROM AdminUsers WHERE Username = 'admin')
BEGIN
    INSERT INTO AdminUsers (Username, Password, Email, FullName, IsActive) VALUES 
    ('admin', 'admin123', 'admin@portfolio.com', 'System Administrator', 1);
    PRINT 'Admin user created: admin/admin123';
END
ELSE
BEGIN
    -- Update existing admin user
    UPDATE AdminUsers 
    SET Password = 'admin123', Email = 'admin@portfolio.com', FullName = 'System Administrator', IsActive = 1
    WHERE Username = 'admin';
    PRINT 'Admin user updated: admin/admin123';
END
GO

-- Verify the setup
PRINT '=================================';
PRINT 'Authentication Setup Complete!';
PRINT 'Database: anotherDemo (SQLEXPRESS)';
PRINT 'Table: AdminUsers';
PRINT 'Login: admin/admin123';
PRINT '=================================';

-- Show the admin user
SELECT 'Admin User in anotherDemo database:' as Info;
SELECT Username, Email, FullName, IsActive, CreatedDate 
FROM AdminUsers 
WHERE Username = 'admin';