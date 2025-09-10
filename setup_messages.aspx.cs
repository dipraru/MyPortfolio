using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace MyPortfolio
{
    public partial class setup_messages : Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResult.Text = "Ready to set up Messages database...";
            }
        }

        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    lblResult.Text = "<div class='success'>? Database connection successful!</div>";
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Connection failed: {ex.Message}</div>";
            }
        }

        protected void btnCreateTable_Click(object sender, EventArgs e)
        {
            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    string createTableSQL = @"
                        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Messages')
                        BEGIN
                            CREATE TABLE Messages (
                                Id int IDENTITY(1,1) PRIMARY KEY,
                                Name nvarchar(100) NOT NULL,
                                Email nvarchar(255) NOT NULL,
                                Subject nvarchar(200) NOT NULL,
                                Message nvarchar(max) NOT NULL,
                                Priority nvarchar(20) DEFAULT 'Normal' CHECK (Priority IN ('Low', 'Normal', 'High')),
                                IsRead bit DEFAULT 0,
                                CreatedAt datetime DEFAULT GETDATE(),
                                ReadAt datetime NULL
                            );
                            PRINT 'Messages table created successfully';
                        END
                        ELSE
                        BEGIN
                            PRINT 'Messages table already exists';
                        END";

                    using (var command = new SqlCommand(createTableSQL, connection))
                    {
                        command.ExecuteNonQuery();
                        lblResult.Text = "<div class='success'>? Messages table created successfully!</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error creating table: {ex.Message}</div>";
            }
        }

        protected void btnAddSampleData_Click(object sender, EventArgs e)
        {
            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    // Check if sample data already exists
                    string checkDataSQL = "SELECT COUNT(*) FROM Messages WHERE Name = 'John Doe'";
                    using (var checkCommand = new SqlCommand(checkDataSQL, connection))
                    {
                        int existingCount = (int)checkCommand.ExecuteScalar();
                        if (existingCount > 0)
                        {
                            lblResult.Text = "<div class='info'>?? Sample data already exists!</div>";
                            return;
                        }
                    }

                    string insertSampleSQL = @"
                        INSERT INTO Messages (Name, Email, Subject, Message, Priority, IsRead, CreatedAt, ReadAt)
                        VALUES 
                        ('John Doe', 'john.doe@example.com', 'Collaboration Opportunity', 
                         'Hi, I came across your portfolio and I am impressed with your competitive programming achievements. I would like to discuss a potential collaboration opportunity.', 
                         'Normal', 0, GETDATE(), NULL),
                        ('Sarah Smith', 'sarah.smith@techcorp.com', 'Job Opportunity', 
                         'We have an opening for a software engineer position that might interest you. Would you be available for a brief discussion?', 
                         'High', 1, DATEADD(day, -2, GETDATE()), DATEADD(day, -1, GETDATE())),
                        ('Alex Johnson', 'alex.j@university.edu', 'Algorithm Help', 
                         'I am stuck on a dynamic programming problem and saw your expertise. Could you provide some guidance?', 
                         'Low', 0, DATEADD(day, -5, GETDATE()), NULL),
                        ('Emily Chen', 'emily.chen@startup.io', 'Portfolio Feedback', 
                         'I love your portfolio design! Could you share some insights about the technologies you used?', 
                         'Normal', 1, DATEADD(day, -3, GETDATE()), DATEADD(day, -2, GETDATE())),
                        ('Michael Wilson', 'mike.wilson@consulting.com', 'Freelance Project', 
                         'We have a freelance project that might be a good fit for your skills. Are you available for freelance work?', 
                         'High', 0, DATEADD(hour, -6, GETDATE()), NULL)";

                    using (var command = new SqlCommand(insertSampleSQL, connection))
                    {
                        int rowsAffected = command.ExecuteNonQuery();
                        lblResult.Text = $"<div class='success'>? {rowsAffected} sample messages added successfully!</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error adding sample data: {ex.Message}</div>";
            }
        }

        protected void btnVerifySetup_Click(object sender, EventArgs e)
        {
            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    // Check if table exists
                    string checkTableSQL = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Messages'";
                    using (var checkCommand = new SqlCommand(checkTableSQL, connection))
                    {
                        int tableExists = (int)checkCommand.ExecuteScalar();
                        if (tableExists == 0)
                        {
                            lblResult.Text = "<div class='error'>? Messages table does not exist. Please create it first.</div>";
                            return;
                        }
                    }

                    // Count records
                    string countSQL = "SELECT COUNT(*) FROM Messages";
                    using (var countCommand = new SqlCommand(countSQL, connection))
                    {
                        int recordCount = (int)countCommand.ExecuteScalar();
                        
                        // Count unread messages
                        string unreadSQL = "SELECT COUNT(*) FROM Messages WHERE IsRead = 0";
                        using (var unreadCommand = new SqlCommand(unreadSQL, connection))
                        {
                            int unreadCount = (int)unreadCommand.ExecuteScalar();
                            int readCount = recordCount - unreadCount;

                            lblResult.Text = $@"
                                <div class='success'>
                                    ? Messages table setup verified!<br/>
                                    ?? Total messages: {recordCount}<br/>
                                    ?? Unread messages: {unreadCount}<br/>
                                    ?? Read messages: {readCount}<br/>
                                    ?? Everything is working correctly!
                                </div>";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error verifying setup: {ex.Message}</div>";
            }
        }

        protected void btnDropTable_Click(object sender, EventArgs e)
        {
            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    string dropTableSQL = @"
                        IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Messages')
                        BEGIN
                            DROP TABLE Messages;
                            PRINT 'Messages table dropped successfully';
                        END
                        ELSE
                        BEGIN
                            PRINT 'Messages table does not exist';
                        END";

                    using (var command = new SqlCommand(dropTableSQL, connection))
                    {
                        command.ExecuteNonQuery();
                        lblResult.Text = "<div class='info'>??? Messages table dropped successfully!</div>";
                    }
                }
            }
            catch (Exception ex)
            {
                lblResult.Text = $"<div class='error'>? Error dropping table: {ex.Message}</div>";
            }
        }
    }
}