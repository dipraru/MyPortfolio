-- Fix Projects Table Column Sizes
-- Increase ImageUrl column size to handle long URLs (like Facebook URLs)

USE anotherDemo;
GO

-- Check current column size
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Projects' 
AND COLUMN_NAME IN ('ImageUrl', 'GitHubUrl', 'LiveDemoUrl');

-- Increase column sizes to handle longer URLs
BEGIN TRY
    -- Increase ImageUrl column size to 1000 characters
    ALTER TABLE Projects 
    ALTER COLUMN ImageUrl NVARCHAR(1000) NULL;
    
    -- Also increase other URL columns for consistency
    ALTER TABLE Projects 
    ALTER COLUMN GitHubUrl NVARCHAR(1000) NULL;
    
    ALTER TABLE Projects 
    ALTER COLUMN LiveDemoUrl NVARCHAR(1000) NULL;
    
    PRINT 'Successfully increased URL column sizes:';
    PRINT '- ImageUrl: NVARCHAR(500) -> NVARCHAR(1000)';
    PRINT '- GitHubUrl: NVARCHAR(500) -> NVARCHAR(1000)';
    PRINT '- LiveDemoUrl: NVARCHAR(500) -> NVARCHAR(1000)';
    
END TRY
BEGIN CATCH
    PRINT 'Error updating column sizes:';
    PRINT ERROR_MESSAGE();
END CATCH

-- Verify the changes
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Projects' 
AND COLUMN_NAME IN ('ImageUrl', 'GitHubUrl', 'LiveDemoUrl')
ORDER BY COLUMN_NAME;

PRINT 'Column size update completed!';