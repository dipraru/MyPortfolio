-- Projects Management Database Tables
-- For MyPortfolio Admin Dashboard
-- Target: SQLEXPRESS (anotherDemo database)

USE anotherDemo;
GO

-- Create Projects table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Projects')
BEGIN
    CREATE TABLE Projects (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(200) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        ImageUrl NVARCHAR(500) NULL,
        Tags NVARCHAR(500) NULL, -- Comma-separated tags (JavaScript, React, etc.)
        GitHubUrl NVARCHAR(500) NULL,
        LiveDemoUrl NVARCHAR(500) NULL,
        IsActive BIT DEFAULT 1,
        DisplayOrder INT DEFAULT 0,
        DateAdded DATETIME DEFAULT GETDATE(),
        DateModified DATETIME DEFAULT GETDATE(),
        CreatedBy NVARCHAR(100) DEFAULT 'admin'
    );
    
    PRINT 'Projects table created successfully.';
END
ELSE
BEGIN
    PRINT 'Projects table already exists.';
END

-- Insert sample projects data to match your dashboard
IF NOT EXISTS (SELECT * FROM Projects WHERE Title = 'Algorithm Visualizer')
BEGIN
    INSERT INTO Projects (Title, Description, ImageUrl, Tags, GitHubUrl, LiveDemoUrl, DisplayOrder)
    VALUES 
    (
        'Algorithm Visualizer',
        'An interactive web application that visualizes common algorithms and data structures.',
        'https://images.unsplash.com/photo-1555066931-4365d14bab8c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'JavaScript,D3.js,Algorithms',
        'https://github.com/dipra-datta/algorithm-visualizer',
        'https://dipra-algorithm-visualizer.netlify.app',
        1
    ),
    (
        'CP Practice Platform',
        'A custom platform for competitive programmers to practice problems and track progress.',
        'https://images.unsplash.com/photo-1551288049-bebda4e38f71?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'React,Node.js,MongoDB',
        'https://github.com/dipra-datta/cp-practice-platform',
        'https://dipra-cp-platform.herokuapp.com',
        2
    ),
    (
        'Code Complexity Analyzer',
        'A tool that analyzes code complexity and suggests optimizations.',
        'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        'Python,AST,Machine Learning',
        'https://github.com/dipra-datta/code-complexity-analyzer',
        'https://dipra-code-analyzer.streamlit.app',
        3
    );
    
    PRINT 'Sample projects data inserted successfully.';
END
ELSE
BEGIN
    PRINT 'Sample projects data already exists.';
END

-- Create index for better performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Projects_IsActive_DisplayOrder')
BEGIN
    CREATE INDEX IX_Projects_IsActive_DisplayOrder ON Projects (IsActive, DisplayOrder);
    PRINT 'Projects index created successfully.';
END

-- Verify the table structure
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Projects'
ORDER BY ORDINAL_POSITION;

-- Show sample data
SELECT * FROM Projects ORDER BY DisplayOrder;

PRINT 'Projects database setup completed successfully!';
PRINT 'Table: Projects';
PRINT 'Location: anotherDemo database on SQLEXPRESS';
PRINT 'Ready for admin dashboard integration.';