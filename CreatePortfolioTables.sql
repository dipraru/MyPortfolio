-- Portfolio Database Setup Script
-- This script creates the necessary tables for the MyPortfolio admin dashboard

-- First, let's ensure we're using the correct database
-- You can change this to match your preferred database name
USE master;
GO

-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'MyPortfolioDB')
BEGIN
    CREATE DATABASE MyPortfolioDB;
    PRINT 'Database MyPortfolioDB created successfully!';
END
ELSE
BEGIN
    PRINT 'Database MyPortfolioDB already exists.';
END
GO

-- Switch to the portfolio database
USE MyPortfolioDB;
GO

-- Create AdminUsers table FIRST (this is what we need for login)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
BEGIN
    CREATE TABLE AdminUsers (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) UNIQUE NOT NULL,
        Password NVARCHAR(256) NOT NULL, -- We'll store plain text for now, hash later
        Email NVARCHAR(200),
        FullName NVARCHAR(100),
        IsActive BIT DEFAULT 1,
        LastLogin DATETIME,
        CreatedDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'AdminUsers table created successfully!';
END
ELSE
BEGIN
    PRINT 'AdminUsers table already exists.';
END
GO

-- Insert default admin user if table is empty
IF NOT EXISTS (SELECT * FROM AdminUsers WHERE Username = 'admin')
BEGIN
    INSERT INTO AdminUsers (Username, Password, Email, FullName, IsActive) VALUES 
    ('admin', 'admin123', 'admin@portfolio.com', 'System Administrator', 1);
    PRINT 'Default admin user created: admin/admin123';
END
ELSE
BEGIN
    PRINT 'Admin user already exists.';
END
GO

-- Create Projects table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Projects' AND xtype='U')
BEGIN
    CREATE TABLE Projects (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NTEXT,
        Technologies NVARCHAR(500),
        GithubUrl NVARCHAR(500),
        DemoUrl NVARCHAR(500),
        ImageUrl NVARCHAR(500),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        UpdatedDate DATETIME
    );
    PRINT 'Projects table created successfully!';
END
ELSE
BEGIN
    PRINT 'Projects table already exists.';
END
GO

-- Create Skills table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Skills' AND xtype='U')
BEGIN
    CREATE TABLE Skills (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Level INT CHECK (Level >= 0 AND Level <= 100),
        Category NVARCHAR(50),
        IconClass NVARCHAR(100),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        UpdatedDate DATETIME
    );
    PRINT 'Skills table created successfully!';
END
ELSE
BEGIN
    PRINT 'Skills table already exists.';
END
GO

-- Create Achievements table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Achievements' AND xtype='U')
BEGIN
    CREATE TABLE Achievements (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Contest NVARCHAR(200) NOT NULL,
        Position NVARCHAR(50),
        Year INT,
        Description NTEXT,
        IconClass NVARCHAR(100),
        IsActive BIT DEFAULT 1,
        CreatedDate DATETIME DEFAULT GETDATE(),
        UpdatedDate DATETIME
    );
    PRINT 'Achievements table created successfully!';
END
ELSE
BEGIN
    PRINT 'Achievements table already exists.';
END
GO

-- Create ContactMessages table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
BEGIN
    CREATE TABLE ContactMessages (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(200) NOT NULL,
        Subject NVARCHAR(200),
        Message NTEXT NOT NULL,
        IsRead BIT DEFAULT 0,
        DateReceived DATETIME DEFAULT GETDATE(),
        ResponseSent BIT DEFAULT 0,
        ResponseDate DATETIME
    );
    PRINT 'ContactMessages table created successfully!';
END
ELSE
BEGIN
    PRINT 'ContactMessages table already exists.';
END
GO

-- Insert some sample data for testing (only if tables are empty)

-- Sample Projects
IF NOT EXISTS (SELECT * FROM Projects)
BEGIN
    INSERT INTO Projects (Title, Description, Technologies, GithubUrl, DemoUrl) VALUES
    ('Algorithm Visualizer', 'An interactive web application that visualizes common algorithms and data structures to help students understand complex concepts.', 'JavaScript, D3.js, HTML5, CSS3', 'https://github.com/dipra/algorithm-visualizer', 'https://algo-visualizer-demo.com'),
    ('CP Practice Platform', 'A custom platform for competitive programmers to practice problems, track progress, and participate in virtual contests.', 'React, Node.js, MongoDB, Express.js', 'https://github.com/dipra/cp-platform', 'https://cp-practice.com'),
    ('Code Complexity Analyzer', 'A tool that analyzes code complexity, suggests optimizations, and helps improve algorithm efficiency.', 'Python, AST, Machine Learning, Flask', 'https://github.com/dipra/code-analyzer', 'https://code-analyzer.herokuapp.com');
    PRINT 'Sample projects inserted successfully!';
END
GO

-- Sample Skills
IF NOT EXISTS (SELECT * FROM Skills)
BEGIN
    INSERT INTO Skills (Name, Level, Category, IconClass) VALUES
    ('C++', 95, 'Programming', 'fab fa-cuttlefish'),
    ('Python', 85, 'Programming', 'fab fa-python'),
    ('Algorithms', 90, 'Programming', 'fas fa-project-diagram'),
    ('Data Structures', 92, 'Programming', 'fas fa-database'),
    ('Mathematics', 88, 'Programming', 'fas fa-calculator'),
    ('Version Control', 80, 'Tool', 'fab fa-git-alt'),
    ('React', 75, 'Framework', 'fab fa-react'),
    ('Node.js', 70, 'Framework', 'fab fa-node-js');
    PRINT 'Sample skills inserted successfully!';
END
GO

-- Sample Achievements
IF NOT EXISTS (SELECT * FROM Achievements)
BEGIN
    INSERT INTO Achievements (Contest, Position, Year, Description, IconClass) VALUES
    ('ICPC Dhaka Regional', '32nd', 2023, 'Achieved 32nd rank in the prestigious ICPC Dhaka Regional contest, competing against top teams from Bangladesh.', 'fas fa-trophy'),
    ('UIU IUPC 2025', '7th', 2025, 'Secured 7th position in UIU Inter-University Programming Contest 2025, demonstrating strong problem-solving skills.', 'fas fa-medal'),
    ('UU IUPC 2025', '13th', 2025, 'Achieved 13th rank in UU Inter-University Programming Contest 2025, competing against talented programmers.', 'fas fa-award'),
    ('BUET IUPC 2024', '28th', 2024, 'Secured 28th position in BUET Inter-University Programming Contest 2024.', 'fas fa-star'),
    ('CUET IUPC 2024', '41st', 2024, 'Achieved 41st rank in CUET Inter-University Programming Contest 2024.', 'fas fa-certificate'),
    ('KUET IUPC 2025', '28th', 2025, 'Secured 28th position in KUET Inter-University Programming Contest 2025.', 'fas fa-puzzle-piece');
    PRINT 'Sample achievements inserted successfully!';
END
GO

-- Sample Contact Messages
IF NOT EXISTS (SELECT * FROM ContactMessages)
BEGIN
    INSERT INTO ContactMessages (Name, Email, Subject, Message) VALUES
    ('John Doe', 'john.doe@example.com', 'Collaboration Opportunity', 'Hi Dipra, I came across your portfolio and I am impressed with your competitive programming achievements. I would like to discuss a potential collaboration opportunity.'),
    ('Sarah Smith', 'sarah.smith@techcorp.com', 'Job Opportunity', 'We have an opening for a software engineer position that might interest you. Would you be available for a brief discussion?'),
    ('Alex Johnson', 'alex.j@university.edu', 'Algorithm Help', 'I am stuck on a dynamic programming problem and saw your expertise. Could you provide some guidance?');
    PRINT 'Sample contact messages inserted successfully!';
END
GO

-- Display final status
PRINT '=================================';
PRINT 'Database setup completed successfully!';
PRINT 'Default admin credentials:';
PRINT 'Username: admin';
PRINT 'Password: admin123';
PRINT '=================================';

-- Verify the admin user was created
SELECT 'Admin User Verification:' as Status;
SELECT Username, Email, FullName, IsActive, CreatedDate FROM AdminUsers WHERE Username = 'admin';