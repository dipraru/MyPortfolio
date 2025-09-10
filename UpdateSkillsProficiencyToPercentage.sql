-- Update Skills Table to use Percentage for Proficiency
-- This script updates the Skills table to use percentage (0-100) instead of 1-5 scale

USE [AnotherDemo]; -- Replace with your database name if different
GO

-- Step 1: Check if Skills table exists
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Skills')
BEGIN
    PRINT 'Skills table found. Updating proficiency to percentage...';
    
    -- Step 2: Check current data type and constraints
    SELECT 
        COLUMN_NAME,
        DATA_TYPE,
        IS_NULLABLE,
        COLUMN_DEFAULT
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Skills' AND COLUMN_NAME = 'ProficiencyLevel';
    
    -- Step 3: Update existing data from 1-5 scale to percentage (only if data exists with 1-5 values)
    IF EXISTS (SELECT * FROM Skills WHERE ProficiencyLevel <= 5)
    BEGIN
        PRINT 'Converting existing 1-5 scale values to percentage...';
        
        -- Convert 1-5 scale to percentage: 1=20%, 2=40%, 3=60%, 4=80%, 5=100%
        UPDATE Skills 
        SET ProficiencyLevel = CASE 
            WHEN ProficiencyLevel = 1 THEN 20
            WHEN ProficiencyLevel = 2 THEN 40
            WHEN ProficiencyLevel = 3 THEN 60
            WHEN ProficiencyLevel = 4 THEN 80
            WHEN ProficiencyLevel = 5 THEN 100
            ELSE ProficiencyLevel -- Keep existing percentage values unchanged
        END
        WHERE ProficiencyLevel <= 5;
        
        PRINT 'Existing proficiency values converted to percentage.';
    END
    
    -- Step 4: Add/Update check constraint to ensure percentage is between 0-100
    IF EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Skills_ProficiencyLevel')
    BEGIN
        ALTER TABLE Skills DROP CONSTRAINT CK_Skills_ProficiencyLevel;
        PRINT 'Removed existing proficiency constraint.';
    END
    
    -- Add new constraint for percentage (0-100)
    ALTER TABLE Skills ADD CONSTRAINT CK_Skills_ProficiencyLevel 
        CHECK (ProficiencyLevel >= 0 AND ProficiencyLevel <= 100);
    PRINT 'Added percentage constraint (0-100) to ProficiencyLevel.';
    
    -- Step 5: Update default value to be a reasonable percentage
    DECLARE @ConstraintName NVARCHAR(128);
    SELECT @ConstraintName = dc.name
    FROM sys.default_constraints dc
    INNER JOIN sys.columns c ON dc.parent_column_id = c.column_id
    INNER JOIN sys.tables t ON dc.parent_object_id = t.object_id
    WHERE t.name = 'Skills' AND c.name = 'ProficiencyLevel';
    
    IF @ConstraintName IS NOT NULL
    BEGIN
        EXEC('ALTER TABLE Skills DROP CONSTRAINT ' + @ConstraintName);
        PRINT 'Removed existing default constraint.';
    END
    
    -- Add new default value of 50% for new records
    ALTER TABLE Skills ADD CONSTRAINT DF_Skills_ProficiencyLevel DEFAULT 50 FOR ProficiencyLevel;
    PRINT 'Added default value of 50% for new skills.';
    
    -- Step 6: Verify the changes
    PRINT 'Verification - Current Skills data:';
    SELECT 
        Name,
        ProficiencyLevel as 'Proficiency%',
        Category
    FROM Skills 
    WHERE IsActive = 1
    ORDER BY ProficiencyLevel DESC;
    
    PRINT '? Skills table successfully updated to use percentage proficiency!';
END
ELSE
BEGIN
    PRINT '? Skills table not found. Please create the Skills table first using setup_projects.aspx';
END
GO