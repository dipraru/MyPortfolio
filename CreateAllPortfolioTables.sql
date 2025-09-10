-- Complete Portfolio Database Setup Script
-- This script creates all necessary tables for the portfolio management system
-- Run this script to create all tables at once

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

-- 1. Projects Table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Projects')
BEGIN
    CREATE TABLE Projects (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        ImageUrl NVARCHAR(1000) NULL,
        Tags NVARCHAR(500) NULL,
        GitHubUrl NVARCHAR(1000) NULL,
        LiveDemoUrl NVARCHAR(1000) NULL,
        IsActive BIT DEFAULT 1,
        DisplayOrder INT DEFAULT 0,
        DateAdded DATETIME DEFAULT GETDATE(),
        DateModified DATETIME DEFAULT GETDATE(),
        CreatedBy NVARCHAR(100) DEFAULT 'admin'
    );
    
    CREATE INDEX IX_Projects_IsActive_DisplayOrder ON Projects (IsActive, DisplayOrder);
    PRINT 'Projects table created successfully!';
END
ELSE
BEGIN
    PRINT 'Projects table already exists.';
END
GO

-- 2. Skills Table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Skills')
BEGIN
    CREATE TABLE Skills (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Description NVARCHAR(500) NULL,
        Category NVARCHAR(50) NOT NULL, -- 'Programming', 'Framework', 'Tool', 'Database', etc.
        ProficiencyLevel INT NOT NULL DEFAULT 50 CHECK (ProficiencyLevel >= 0 AND ProficiencyLevel <= 100), -- Percentage 0-100
        YearsOfExperience DECIMAL(3,1) NULL,
        IconClass NVARCHAR(100) NULL, -- CSS class for icon (e.g., 'fab fa-js-square')
        IconColor NVARCHAR(20) NULL, -- Hex color for the icon
        IsActive BIT DEFAULT 1,
        DisplayOrder INT DEFAULT 0,
        DateAdded DATETIME DEFAULT GETDATE(),
        DateModified DATETIME DEFAULT GETDATE(),
        CreatedBy NVARCHAR(100) DEFAULT 'admin'
    );
    
    CREATE INDEX IX_Skills_Category_IsActive ON Skills (Category, IsActive);
    CREATE INDEX IX_Skills_DisplayOrder ON Skills (DisplayOrder);
    PRINT 'Skills table created successfully!';
END
ELSE
BEGIN
    PRINT 'Skills table already exists.';
END
GO

-- 3. Achievements Table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Achievements')
BEGIN
    CREATE TABLE Achievements (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(1000) NOT NULL,
        Category NVARCHAR(50) NOT NULL, -- 'Award', 'Certification', 'Competition', 'Publication'
        Organization NVARCHAR(200) NULL, -- Issuing organization
        DateAchieved DATE NOT NULL,
        CertificateUrl NVARCHAR(500) NULL, -- Link to certificate or proof
        BadgeUrl NVARCHAR(500) NULL, -- Link to badge image
        IsVerified BIT DEFAULT 0, -- Whether the achievement is verified
        IsActive BIT DEFAULT 1,
        DisplayOrder INT DEFAULT 0,
        DateAdded DATETIME DEFAULT GETDATE(),
        DateModified DATETIME DEFAULT GETDATE(),
        CreatedBy NVARCHAR(100) DEFAULT 'admin'
    );
    
    CREATE INDEX IX_Achievements_Category_IsActive ON Achievements (Category, IsActive);
    CREATE INDEX IX_Achievements_DateAchieved ON Achievements (DateAchieved);
    CREATE INDEX IX_Achievements_DisplayOrder ON Achievements (DisplayOrder);
    PRINT 'Achievements table created successfully!';
END
ELSE
BEGIN
    PRINT 'Achievements table already exists.';
END
GO

-- 4. Profile Table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Profile')
BEGIN
    CREATE TABLE Profile (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        FullName NVARCHAR(100) NOT NULL,
        Title NVARCHAR(200) NOT NULL, -- Professional title
        Bio NVARCHAR(MAX) NOT NULL, -- Professional bio/summary
        Email NVARCHAR(100) NOT NULL,
        Phone NVARCHAR(20) NULL,
        Location NVARCHAR(100) NULL,
        ProfileImageUrl NVARCHAR(500) NULL,
        ResumeUrl NVARCHAR(500) NULL,
        LinkedInUrl NVARCHAR(500) NULL,
        GitHubUrl NVARCHAR(500) NULL,
        TwitterUrl NVARCHAR(500) NULL,
        WebsiteUrl NVARCHAR(500) NULL,
        YearsOfExperience INT NULL,
        CurrentCompany NVARCHAR(200) NULL,
        CurrentPosition NVARCHAR(200) NULL,
        IsPublic BIT DEFAULT 1, -- Whether profile is publicly visible
        IsActive BIT DEFAULT 1,
        DateAdded DATETIME DEFAULT GETDATE(),
        DateModified DATETIME DEFAULT GETDATE(),
        CreatedBy NVARCHAR(100) DEFAULT 'admin'
    );
    
    -- Only one active profile should exist at a time
    CREATE UNIQUE INDEX IX_Profile_IsActive ON Profile (IsActive) WHERE IsActive = 1;
    PRINT 'Profile table created successfully!';
END
ELSE
BEGIN
    PRINT 'Profile table already exists.';
END
GO

-- 5. Messages Table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Messages')
BEGIN
    CREATE TABLE Messages (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100) NOT NULL,
        Email NVARCHAR(200) NOT NULL,
        Subject NVARCHAR(200) NOT NULL,
        Message NVARCHAR(MAX) NOT NULL,
        IsRead BIT DEFAULT 0,
        IsReplied BIT DEFAULT 0,
        IsArchived BIT DEFAULT 0,
        Priority NVARCHAR(20) DEFAULT 'Normal', -- 'Low', 'Normal', 'High', 'Urgent'
        IpAddress NVARCHAR(50) NULL, -- For security tracking
        UserAgent NVARCHAR(500) NULL, -- Browser info
        DateReceived DATETIME DEFAULT GETDATE(),
        DateRead DATETIME NULL,
        DateReplied DATETIME NULL,
        ReplyMessage NVARCHAR(MAX) NULL,
        AdminNotes NVARCHAR(1000) NULL -- Internal notes for admin
    );
    
    CREATE INDEX IX_Messages_IsRead_DateReceived ON Messages (IsRead, DateReceived);
    CREATE INDEX IX_Messages_Priority_DateReceived ON Messages (Priority, DateReceived);
    CREATE INDEX IX_Messages_Email ON Messages (Email);
    PRINT 'Messages table created successfully!';
END
ELSE
BEGIN
    PRINT 'Messages table already exists.';
END
GO

-- Insert Sample Data

-- Sample Projects
IF NOT EXISTS (SELECT * FROM Projects WHERE Title = 'Algorithm Visualizer')
BEGIN
    INSERT INTO Projects (Title, Description, ImageUrl, Tags, GitHubUrl, LiveDemoUrl, DisplayOrder)
    VALUES 
    ('Algorithm Visualizer', 'An interactive web application that visualizes common algorithms and data structures.', 
     'https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
     'JavaScript,D3.js,Algorithms', 'https://github.com/dipra-datta/algorithm-visualizer', 
     'https://dipra-algorithm-visualizer.netlify.app', 1),
    ('CP Practice Platform', 'A custom platform for competitive programmers to practice problems and track progress.',
     'https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
     'React,Node.js,MongoDB', 'https://github.com/dipra-datta/cp-practice-platform',
     'https://dipra-cp-platform.herokuapp.com', 2),
    ('Code Complexity Analyzer', 'A tool that analyzes code complexity and suggests optimizations.',
     'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
     'Python,AST,Machine Learning', 'https://github.com/dipra-datta/code-complexity-analyzer',
     'https://dipra-code-analyzer.streamlit.app', 3);
    PRINT 'Sample projects inserted successfully!';
END
GO

-- Sample Skills
IF NOT EXISTS (SELECT * FROM Skills WHERE Name = 'C++')
BEGIN
    INSERT INTO Skills (Name, Description, Category, ProficiencyLevel, YearsOfExperience, IconClass, IconColor, DisplayOrder)
    VALUES 
    ('C++', 'Advanced competitive programming and system development', 'Programming', 95, 4.0, 'fab fa-cuttlefish', '#00599C', 1),
    ('Python', 'Machine learning, data analysis, and backend development', 'Programming', 85, 3.0, 'fab fa-python', '#3776AB', 2),
    ('JavaScript', 'Frontend development and modern web applications', 'Programming', 80, 3.5, 'fab fa-js-square', '#F7DF1E', 3),
    ('React', 'Modern frontend framework for building user interfaces', 'Framework', 75, 2.5, 'fab fa-react', '#61DAFB', 4),
    ('Node.js', 'Backend development and API creation', 'Framework', 70, 2.0, 'fab fa-node-js', '#339933', 5),
    ('Algorithms', 'Data structures and algorithmic problem solving', 'Programming', 90, 4.0, 'fas fa-project-diagram', '#FF6B6B', 6),
    ('Git', 'Version control and collaborative development', 'Tool', 85, 3.0, 'fab fa-git-alt', '#F05032', 7),
    ('SQL', 'Database design and query optimization', 'Database', 75, 2.5, 'fas fa-database', '#336791', 8);
    PRINT 'Sample skills inserted successfully!';
END
GO

-- Sample Achievements
IF NOT EXISTS (SELECT * FROM Achievements WHERE Title = 'ICPC Dhaka Regional')
BEGIN
    INSERT INTO Achievements (Title, Description, Category, Organization, DateAchieved, DisplayOrder)
    VALUES 
    ('ICPC Dhaka Regional', 'Achieved 32nd rank in the prestigious ICPC Dhaka Regional contest', 'Competition', 'ICPC Foundation', '2023-11-15', 1),
    ('UIU IUPC 2025', 'Secured 7th position in UIU Inter-University Programming Contest', 'Competition', 'United International University', '2025-01-20', 2),
    ('UU IUPC 2025', 'Achieved 13th rank in UU Inter-University Programming Contest', 'Competition', 'University of Ulster', '2025-02-10', 3),
    ('BUET IUPC 2024', 'Secured 28th position in BUET Inter-University Programming Contest', 'Competition', 'Bangladesh University of Engineering and Technology', '2024-12-05', 4),
    ('CUET IUPC 2024', 'Achieved 41st rank in CUET Inter-University Programming Contest', 'Competition', 'Chittagong University of Engineering & Technology', '2024-11-25', 5),
    ('KUET IUPC 2025', 'Secured 28th position in KUET Inter-University Programming Contest', 'Competition', 'Khulna University of Engineering & Technology', '2025-01-30', 6);
    PRINT 'Sample achievements inserted successfully!';
END
GO

-- Default Profile
IF NOT EXISTS (SELECT * FROM Profile WHERE IsActive = 1)
BEGIN
    INSERT INTO Profile (FullName, Title, Bio, Email, Location, YearsOfExperience, CurrentCompany, CurrentPosition)
    VALUES 
    ('Your Name', 'Software Developer & Competitive Programmer', 
     'Passionate software developer with expertise in competitive programming, algorithm optimization, and modern web development. Experienced in multiple programming contests and dedicated to continuous learning.',
     'your.email@example.com', 'Your City, Country', 3, 'Your Company', 'Software Engineer');
    PRINT 'Default profile inserted successfully!';
END
GO

-- Sample Messages
IF NOT EXISTS (SELECT * FROM Messages WHERE Name = 'John Doe')
BEGIN
    INSERT INTO Messages (Name, Email, Subject, Message, Priority)
    VALUES 
    ('John Doe', 'john.doe@example.com', 'Collaboration Opportunity', 
     'Hi, I came across your portfolio and I am impressed with your competitive programming achievements. I would like to discuss a potential collaboration opportunity.', 'Normal'),
    ('Sarah Smith', 'sarah.smith@techcorp.com', 'Job Opportunity', 
     'We have an opening for a software engineer position that might interest you. Would you be available for a brief discussion?', 'High'),
    ('Alex Johnson', 'alex.j@university.edu', 'Algorithm Help', 
     'I am stuck on a dynamic programming problem and saw your expertise. Could you provide some guidance?', 'Low');
    PRINT 'Sample messages inserted successfully!';
END
GO

-- Display final status
PRINT '=================================';
PRINT 'Complete Portfolio Database Setup Completed!';
PRINT 'All tables created successfully:';
PRINT '• Projects - Project portfolio management';
PRINT '• Skills - Technical skills and expertise';
PRINT '• Achievements - Awards and accomplishments';
PRINT '• Profile - Personal profile information';
PRINT '• Messages - Contact form messages';
PRINT '=================================';

-- Verify table creation
SELECT 
    TABLE_NAME as 'Table',
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = t.TABLE_NAME) as 'Columns',
    CASE 
        WHEN TABLE_NAME = 'Projects' THEN (SELECT COUNT(*) FROM Projects)
        WHEN TABLE_NAME = 'Skills' THEN (SELECT COUNT(*) FROM Skills)
        WHEN TABLE_NAME = 'Achievements' THEN (SELECT COUNT(*) FROM Achievements)
        WHEN TABLE_NAME = 'Profile' THEN (SELECT COUNT(*) FROM Profile)
        WHEN TABLE_NAME = 'Messages' THEN (SELECT COUNT(*) FROM Messages)
        ELSE 0
    END as 'Records'
FROM INFORMATION_SCHEMA.TABLES t
WHERE TABLE_NAME IN ('Projects', 'Skills', 'Achievements', 'Profile', 'Messages')
ORDER BY TABLE_NAME;