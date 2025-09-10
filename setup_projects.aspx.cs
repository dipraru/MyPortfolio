using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio
{
    public partial class setup_projects : Page
    {
        private string GetConnectionString()
        {
            var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
            if (connString != null)
            {
                return connString.ConnectionString;
            }

            var fallbackConnString = ConfigurationManager.ConnectionStrings["MyDBConnection"];
            if (fallbackConnString != null)
            {
                return fallbackConnString.ConnectionString;
            }

            throw new Exception("No database connection string found.");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateStatus();
            }
        }

        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    lblResult.Text = "<div class='success'>? Database connection successful!<br/>Connected to: " + conn.Database + "</div>";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "<div class='error'>? Database connection failed:<br/>" + ex.Message + "</div>";
            }
            UpdateStatus();
        }

        // Projects Table Methods
        protected void btnCreateProjectsTable_Click(object sender, EventArgs e)
        {
            CreateTable("Projects", GetProjectsTableSQL());
        }

        protected void btnInsertProjectsData_Click(object sender, EventArgs e)
        {
            InsertSampleData("Projects", GetProjectsSampleDataSQL(), "Algorithm Visualizer");
        }

        // Skills Table Methods
        protected void btnCreateSkillsTable_Click(object sender, EventArgs e)
        {
            CreateTable("Skills", GetSkillsTableSQL());
        }

        protected void btnInsertSkillsData_Click(object sender, EventArgs e)
        {
            InsertSampleData("Skills", GetSkillsSampleDataSQL(), "C++");
        }

        // Achievements Table Methods
        protected void btnCreateAchievementsTable_Click(object sender, EventArgs e)
        {
            CreateTable("Achievements", GetAchievementsTableSQL());
        }

        protected void btnInsertAchievementsData_Click(object sender, EventArgs e)
        {
            InsertSampleData("Achievements", GetAchievementsSampleDataSQL(), "ICPC Dhaka Regional");
        }

        // Profile Table Methods
        protected void btnCreateProfileTable_Click(object sender, EventArgs e)
        {
            CreateTable("Profile", GetProfileTableSQL());
        }

        protected void btnInsertProfileData_Click(object sender, EventArgs e)
        {
            InsertSampleData("Profile", GetProfileSampleDataSQL(), "Default Profile");
        }

        // Messages Table Methods
        protected void btnCreateMessagesTable_Click(object sender, EventArgs e)
        {
            CreateTable("Messages", GetMessagesTableSQL());
        }

        protected void btnInsertMessagesData_Click(object sender, EventArgs e)
        {
            InsertSampleData("Messages", GetMessagesSampleDataSQL(), "John Doe");
        }

        // Generic Methods
        private void CreateTable(string tableName, string createTableSQL)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    using (var cmd = new SqlCommand(createTableSQL, conn))
                    {
                        cmd.ExecuteNonQuery();
                        lblResult.Text = $"<div class='success'>? {tableName} table created successfully!</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error creating {tableName} table:<br/>{ex.Message}</div>";
            }
            UpdateStatus();
        }

        private void InsertSampleData(string tableName, string insertSQL, string checkValue)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Check if sample data already exists
                    string checkSQL = GetCheckDataSQL(tableName, checkValue);
                    using (var checkCmd = new SqlCommand(checkSQL, conn))
                    {
                        int existingCount = (int)checkCmd.ExecuteScalar();
                        if (existingCount > 0)
                        {
                            lblResult.Text = $"<div class='success'>? Sample {tableName.ToLower()} data already exists!</div>";
                            UpdateStatus();
                            return;
                        }
                    }

                    using (var cmd = new SqlCommand(insertSQL, conn))
                    {
                        int rowsAffected = cmd.ExecuteNonQuery();
                        lblResult.Text = $"<div class='success'>? Sample {tableName.ToLower()} data inserted successfully!<br/>Inserted {rowsAffected} records.</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error inserting sample {tableName.ToLower()} data:<br/>{ex.Message}</div>";
            }
            UpdateStatus();
        }

        protected void btnFixColumnSizes_Click(object sender, EventArgs e)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string updateSQL = @"
                        ALTER TABLE Projects ALTER COLUMN ImageUrl NVARCHAR(1000) NULL;
                        ALTER TABLE Projects ALTER COLUMN GitHubUrl NVARCHAR(1000) NULL;
                        ALTER TABLE Projects ALTER COLUMN LiveDemoUrl NVARCHAR(1000) NULL;";

                    using (var cmd = new SqlCommand(updateSQL, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    lblResult.Text = "<div class='success'>? Projects table column sizes updated successfully!</div>";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "<div class='error'>? Error updating column sizes:<br/>" + ex.Message + "</div>";
            }
            UpdateStatus();
        }

        protected void btnCreateAllTables_Click(object sender, EventArgs e)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string[] tableNames = { "Projects", "Skills", "Achievements", "Profile", "Messages" };
                    string[] createSQLs = { 
                        GetProjectsTableSQL(), 
                        GetSkillsTableSQL(), 
                        GetAchievementsTableSQL(), 
                        GetProfileTableSQL(), 
                        GetMessagesTableSQL() 
                    };

                    int created = 0;
                    for (int i = 0; i < tableNames.Length; i++)
                    {
                        try
                        {
                            using (var cmd = new SqlCommand(createSQLs[i], conn))
                            {
                                cmd.ExecuteNonQuery();
                                created++;
                            }
                        }
                        catch (Exception tableEx)
                        {
                            // Table might already exist, continue
                        }
                    }

                    lblResult.Text = $"<div class='success'>? All tables created successfully!<br/>Created/verified {created} tables.</div>";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "<div class='error'>? Error creating all tables:<br/>" + ex.Message + "</div>";
            }
            UpdateStatus();
        }

        protected void btnVerifyAllTables_Click(object sender, EventArgs e)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string[] tableNames = { "Projects", "Skills", "Achievements", "Profile", "Messages" };
                    string verificationResult = "?? Database Tables Verification:\n\n";

                    foreach (string tableName in tableNames)
                    {
                        // Check if table exists
                        string tableCheckSQL = $"SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{tableName}'";
                        using (var cmd = new SqlCommand(tableCheckSQL, conn))
                        {
                            int tableExists = (int)cmd.ExecuteScalar();
                            verificationResult += $"?? {tableName} Table: " + (tableExists > 0 ? "? Exists" : "? Not Found") + "\n";
                            
                            if (tableExists > 0)
                            {
                                // Check data count
                                string countSQL = $"SELECT COUNT(*) FROM {tableName}";
                                using (var countCmd = new SqlCommand(countSQL, conn))
                                {
                                    int recordCount = (int)countCmd.ExecuteScalar();
                                    verificationResult += $"   ?? Records: {recordCount}\n";
                                }
                            }
                        }
                    }

                    // Test all Helper classes
                    verificationResult += "\n?? Helper Classes Test:\n";
                    
                    try
                    {
                        bool projectsTest = ProjectsHelper.TestConnection();
                        int projectsCount = ProjectsHelper.GetProjectsCount();
                        verificationResult += $"?? ProjectsHelper: {(projectsTest ? "? Working" : "? Failed")} ({projectsCount} projects)\n";
                    }
                    catch (Exception ex)
                    {
                        verificationResult += $"?? ProjectsHelper: ? Error - {ex.Message}\n";
                    }

                    try
                    {
                        bool skillsTest = SkillsHelper.TestConnection();
                        int skillsCount = SkillsHelper.GetSkillsCount();
                        verificationResult += $"?? SkillsHelper: {(skillsTest ? "? Working" : "? Failed")} ({skillsCount} skills)\n";
                    }
                    catch (Exception ex)
                    {
                        verificationResult += $"?? SkillsHelper: ? Error - {ex.Message}\n";
                    }

                    try
                    {
                        bool achievementsTest = AchievementsHelper.TestConnection();
                        int achievementsCount = AchievementsHelper.GetAchievementsCount();
                        verificationResult += $"?? AchievementsHelper: {(achievementsTest ? "? Working" : "? Failed")} ({achievementsCount} achievements)\n";
                    }
                    catch (Exception ex)
                    {
                        verificationResult += $"?? AchievementsHelper: ? Error - {ex.Message}\n";
                    }

                    try
                    {
                        bool profileTest = ProfileHelper.TestConnection();
                        bool hasProfile = ProfileHelper.HasActiveProfile();
                        verificationResult += $"?? ProfileHelper: {(profileTest ? "? Working" : "? Failed")} ({(hasProfile ? "Profile exists" : "No profile")})\n";
                    }
                    catch (Exception ex)
                    {
                        verificationResult += $"?? ProfileHelper: ? Error - {ex.Message}\n";
                    }

                    try
                    {
                        bool messagesTest = MessagesHelper.TestConnection();
                        int messagesCount = MessagesHelper.GetMessagesCount();
                        int unreadCount = MessagesHelper.GetUnreadMessagesCount();
                        verificationResult += $"?? MessagesHelper: {(messagesTest ? "? Working" : "? Failed")} ({messagesCount} total, {unreadCount} unread)\n";
                    }
                    catch (Exception ex)
                    {
                        verificationResult += $"?? MessagesHelper: ? Error - {ex.Message}\n";
                    }

                    lblResult.Text = "<div class='success'>? Complete verification completed!</div>";
                    lblResult.Text += "<div class='info'>" + verificationResult + "</div>";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "<div class='error'>? Error during verification:<br/>" + ex.Message + "</div>";
            }
            UpdateStatus();
        }

        private void UpdateStatus()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string status = "??? Database: " + conn.Database + " (SQLEXPRESS)\n";
                    
                    string[] tableNames = { "Projects", "Skills", "Achievements", "Profile", "Messages" };
                    
                    foreach (string tableName in tableNames)
                    {
                        string tableCheckSQL = $"SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '{tableName}'";
                        using (var cmd = new SqlCommand(tableCheckSQL, conn))
                        {
                            int tableExists = (int)cmd.ExecuteScalar();
                            status += $"?? {tableName}: " + (tableExists > 0 ? "? Created" : "?? Missing") + "\n";
                            
                            if (tableExists > 0)
                            {
                                string countSQL = $"SELECT COUNT(*) FROM {tableName}";
                                using (var countCmd = new SqlCommand(countSQL, conn))
                                {
                                    int recordCount = (int)countCmd.ExecuteScalar();
                                    status += $"   ?? Records: {recordCount}\n";
                                }
                            }
                        }
                    }
                    
                    lblStatus.Text = "<div class='info'>" + status + "</div>";
                }
            }
            catch (Exception ex)
            {
                lblStatus.Text = "<div class='error'>? Status check failed: " + ex.Message + "</div>";
            }
        }

        // SQL Generation Methods
        private string GetProjectsTableSQL()
        {
            return @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Projects')
                BEGIN
                    CREATE TABLE Projects (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Title NVARCHAR(200) NOT NULL,
                        Description NVARCHAR(MAX) NOT NULL,
                        ImageUrl NVARCHAR(500) NULL,
                        Tags NVARCHAR(500) NULL,
                        GitHubUrl NVARCHAR(500) NULL,
                        LiveDemoUrl NVARCHAR(500) NULL,
                        IsActive BIT DEFAULT 1,
                        DisplayOrder INT DEFAULT 0,
                        DateAdded DATETIME DEFAULT GETDATE(),
                        DateModified DATETIME DEFAULT GETDATE(),
                        CreatedBy NVARCHAR(100) DEFAULT 'admin'
                    );
                    CREATE INDEX IX_Projects_IsActive_DisplayOrder ON Projects (IsActive, DisplayOrder);
                END";
        }

        private string GetSkillsTableSQL()
        {
            return @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Skills')
                BEGIN
                    CREATE TABLE Skills (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Name NVARCHAR(100) NOT NULL,
                        Description NVARCHAR(500) NULL,
                        Category NVARCHAR(50) NOT NULL,
                        ProficiencyLevel INT NOT NULL DEFAULT 50 CHECK (ProficiencyLevel >= 0 AND ProficiencyLevel <= 100),
                        YearsOfExperience DECIMAL(3,1) NULL,
                        IconClass NVARCHAR(100) NULL,
                        IconColor NVARCHAR(20) NULL,
                        IsActive BIT DEFAULT 1,
                        DisplayOrder INT DEFAULT 0,
                        DateAdded DATETIME DEFAULT GETDATE(),
                        DateModified DATETIME DEFAULT GETDATE(),
                        CreatedBy NVARCHAR(100) DEFAULT 'admin'
                    );
                    CREATE INDEX IX_Skills_Category_IsActive ON Skills (Category, IsActive);
                END";
        }

        private string GetAchievementsTableSQL()
        {
            return @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Achievements')
                BEGIN
                    CREATE TABLE Achievements (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Title NVARCHAR(200) NOT NULL,
                        Description NVARCHAR(1000) NOT NULL,
                        Category NVARCHAR(50) NOT NULL,
                        Organization NVARCHAR(200) NULL,
                        DateAchieved DATE NOT NULL,
                        CertificateUrl NVARCHAR(500) NULL,
                        BadgeUrl NVARCHAR(500) NULL,
                        IsVerified BIT DEFAULT 0,
                        IsActive BIT DEFAULT 1,
                        DisplayOrder INT DEFAULT 0,
                        DateAdded DATETIME DEFAULT GETDATE(),
                        DateModified DATETIME DEFAULT GETDATE(),
                        CreatedBy NVARCHAR(100) DEFAULT 'admin'
                    );
                    CREATE INDEX IX_Achievements_Category_IsActive ON Achievements (Category, IsActive);
                END";
        }

        private string GetProfileTableSQL()
        {
            return @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Profile')
                BEGIN
                    CREATE TABLE Profile (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        FullName NVARCHAR(100) NOT NULL,
                        Title NVARCHAR(200) NOT NULL,
                        Bio NVARCHAR(MAX) NOT NULL,
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
                        IsPublic BIT DEFAULT 1,
                        IsActive BIT DEFAULT 1,
                        DateAdded DATETIME DEFAULT GETDATE(),
                        DateModified DATETIME DEFAULT GETDATE(),
                        CreatedBy NVARCHAR(100) DEFAULT 'admin'
                    );
                END";
        }

        private string GetMessagesTableSQL()
        {
            return @"
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
                        Priority NVARCHAR(20) DEFAULT 'Normal',
                        IpAddress NVARCHAR(50) NULL,
                        UserAgent NVARCHAR(500) NULL,
                        DateReceived DATETIME DEFAULT GETDATE(),
                        DateRead DATETIME NULL,
                        DateReplied DATETIME NULL,
                        ReplyMessage NVARCHAR(MAX) NULL,
                        AdminNotes NVARCHAR(1000) NULL
                    );
                    CREATE INDEX IX_Messages_IsRead_DateReceived ON Messages (IsRead, DateReceived);
                END";
        }

        // Sample Data SQL Methods
        private string GetProjectsSampleDataSQL()
        {
            return @"
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
                 'https://dipra-code-analyzer.streamlit.app', 3)";
        }

        private string GetSkillsSampleDataSQL()
        {
            return @"
                INSERT INTO Skills (Name, Description, Category, ProficiencyLevel, YearsOfExperience, IconClass, IconColor, DisplayOrder)
                VALUES 
                ('C++', 'Advanced competitive programming and system development', 'Programming', 95, 4.0, 'fab fa-cuttlefish', '#00599C', 1),
                ('Python', 'Machine learning, data analysis, and backend development', 'Programming', 85, 3.0, 'fab fa-python', '#3776AB', 2),
                ('JavaScript', 'Frontend development and modern web applications', 'Programming', 80, 3.5, 'fab fa-js-square', '#F7DF1E', 3),
                ('React', 'Modern frontend framework for building user interfaces', 'Framework', 75, 2.5, 'fab fa-react', '#61DAFB', 4),
                ('Node.js', 'Backend development and API creation', 'Framework', 70, 2.0, 'fab fa-node-js', '#339933', 5),
                ('Algorithms', 'Data structures and algorithmic problem solving', 'Programming', 90, 4.0, 'fas fa-project-diagram', '#FF6B6B', 6),
                ('Git', 'Version control and collaborative development', 'Tool', 85, 3.0, 'fab fa-git-alt', '#F05032', 7),
                ('SQL', 'Database design and query optimization', 'Database', 75, 2.5, 'fas fa-database', '#336791', 8)";
        }

        private string GetAchievementsSampleDataSQL()
        {
            return @"
                INSERT INTO Achievements (Title, Description, Category, Organization, DateAchieved, DisplayOrder)
                VALUES 
                ('ICPC Dhaka Regional', 'Achieved 32nd rank in the prestigious ICPC Dhaka Regional contest', 'Competition', 'ICPC Foundation', '2023-11-15', 1),
                ('UIU IUPC 2025', 'Secured 7th position in UIU Inter-University Programming Contest', 'Competition', 'United International University', '2025-01-20', 2),
                ('UU IUPC 2025', 'Achieved 13th rank in UU Inter-University Programming Contest', 'Competition', 'University of Ulster', '2025-02-10', 3),
                ('BUET IUPC 2024', 'Secured 28th position in BUET Inter-University Programming Contest', 'Competition', 'Bangladesh University of Engineering and Technology', '2024-12-05', 4),
                ('CUET IUPC 2024', 'Achieved 41st rank in CUET Inter-University Programming Contest', 'Competition', 'Chittagong University of Engineering & Technology', '2024-11-25', 5),
                ('KUET IUPC 2025', 'Secured 28th position in KUET Inter-University Programming Contest', 'Competition', 'Khulna University of Engineering & Technology', '2025-01-30', 6)";
        }

        private string GetProfileSampleDataSQL()
        {
            return @"
                INSERT INTO Profile (FullName, Title, Bio, Email, Location, YearsOfExperience, CurrentCompany, CurrentPosition)
                VALUES 
                ('Your Name', 'Software Developer & Competitive Programmer', 
                 'Passionate software developer with expertise in competitive programming, algorithm optimization, and modern web development. Experienced in multiple programming contests and dedicated to continuous learning.',
                 'your.email@example.com', 'Your City, Country', 3, 'Your Company', 'Software Engineer')";
        }

        private string GetMessagesSampleDataSQL()
        {
            return @"
                INSERT INTO Messages (Name, Email, Subject, Message, Priority)
                VALUES 
                ('John Doe', 'john.doe@example.com', 'Collaboration Opportunity', 
                 'Hi, I came across your portfolio and I am impressed with your competitive programming achievements. I would like to discuss a potential collaboration opportunity.', 'Normal'),
                ('Sarah Smith', 'sarah.smith@techcorp.com', 'Job Opportunity', 
                 'We have an opening for a software engineer position that might interest you. Would you be available for a brief discussion?', 'High'),
                ('Alex Johnson', 'alex.j@university.edu', 'Algorithm Help', 
                 'I am stuck on a dynamic programming problem and saw your expertise. Could you provide some guidance?', 'Low')";
        }

        private string GetCheckDataSQL(string tableName, string checkValue)
        {
            switch (tableName)
            {
                case "Projects":
                    return $"SELECT COUNT(*) FROM Projects WHERE Title = '{checkValue}'";
                case "Skills":
                    return $"SELECT COUNT(*) FROM Skills WHERE Name = '{checkValue}'";
                case "Achievements":
                    return $"SELECT COUNT(*) FROM Achievements WHERE Title = '{checkValue}'";
                case "Profile":
                    return $"SELECT COUNT(*) FROM Profile WHERE FullName != 'Default Profile'";
                case "Messages":
                    return $"SELECT COUNT(*) FROM Messages WHERE Name = '{checkValue}'";
                default:
                    return $"SELECT COUNT(*) FROM {tableName}";
            }
        }

        protected void btnUpdateSkillsProficiency_Click(object sender, EventArgs e)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Check if we need to convert 1-5 scale to percentage
                    string checkSQL = "SELECT COUNT(*) FROM Skills WHERE ProficiencyLevel <= 5 AND IsActive = 1";
                    using (var checkCmd = new SqlCommand(checkSQL, conn))
                    {
                        int oldScaleCount = (int)checkCmd.ExecuteScalar();
                        
                        if (oldScaleCount > 0)
                        {
                            // Convert 1-5 scale to percentage
                            string updateSQL = @"
                                UPDATE Skills 
                                SET ProficiencyLevel = CASE 
                                    WHEN ProficiencyLevel = 1 THEN 20
                                    WHEN ProficiencyLevel = 2 THEN 40
                                    WHEN ProficiencyLevel = 3 THEN 60
                                    WHEN ProficiencyLevel = 4 THEN 80
                                    WHEN ProficiencyLevel = 5 THEN 100
                                    ELSE ProficiencyLevel
                                END
                                WHERE ProficiencyLevel <= 5";
                            
                            using (var cmd = new SqlCommand(updateSQL, conn))
                            {
                                int rowsUpdated = cmd.ExecuteNonQuery();
                                lblResult.Text = $"<div class='success'>? Skills proficiency updated to percentage!<br/>Updated {rowsUpdated} skills from 1-5 scale to percentage.</div>";
                            }
                        }
                        else
                        {
                            lblResult.Text = "<div class='success'>? Skills already using percentage proficiency (0-100)!</div>";
                        }
                    }
                    
                    // Add constraint if not exists
                    string constraintSQL = @"
                        IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Skills_ProficiencyLevel')
                        BEGIN
                            ALTER TABLE Skills ADD CONSTRAINT CK_Skills_ProficiencyLevel 
                                CHECK (ProficiencyLevel >= 0 AND ProficiencyLevel <= 100);
                        END";
                    
                    using (var cmd = new SqlCommand(constraintSQL, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = "<div class='error'>? Error updating skills proficiency:<br/>" + ex.Message + "</div>";
            }
            UpdateStatus();
        }
    }
}