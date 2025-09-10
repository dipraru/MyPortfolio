using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Text;

namespace MyPortfolio
{
    public partial class setup_database : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResults.Text = "Ready to setup authentication on SQLEXPRESS...";
            }
        }

        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Testing SQLEXPRESS Connection...</strong></div>");

            // Test AnotherDemoConnection first (your preferred SQLEXPRESS connection)
            TestSQLExpressConnection("AnotherDemoConnection", results);
            
            // Test MyDBConnection as backup
            TestSQLExpressConnection("MyDBConnection", results);

            lblResults.Text = results.ToString();
        }

        protected void btnCreateDatabase_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Setting up Authentication on SQLEXPRESS...</strong></div>");

            try
            {
                // Use AnotherDemoConnection (anotherDemo database on SQLEXPRESS)
                var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
                if (connString == null)
                {
                    lblResults.Text = "<div class='alert alert-danger'>? AnotherDemoConnection not found in Web.config</div>";
                    return;
                }

                using (var connection = new SqlConnection(connString.ConnectionString))
                {
                    connection.Open();
                    results.AppendLine("? Connected to anotherDemo database on SQLEXPRESS<br>");

                    // Create AdminUsers table in anotherDemo database
                    string createAdminUsersTable = @"
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
                        END";

                    using (var command = new SqlCommand(createAdminUsersTable, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? AdminUsers table created in anotherDemo<br>");
                    }

                    // Insert admin user with credentials stored in database
                    string insertAdminUser = @"
                        IF NOT EXISTS (SELECT * FROM AdminUsers WHERE Username = 'admin')
                        BEGIN
                            INSERT INTO AdminUsers (Username, Password, Email, FullName, IsActive) 
                            VALUES ('admin', 'admin123', 'admin@portfolio.com', 'System Administrator', 1);
                        END
                        ELSE
                        BEGIN
                            UPDATE AdminUsers 
                            SET Password = 'admin123', Email = 'admin@portfolio.com', FullName = 'System Administrator', IsActive = 1
                            WHERE Username = 'admin';
                        END";

                    using (var command = new SqlCommand(insertAdminUser, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? Admin credentials stored in database: admin/admin123<br>");
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>?? Authentication setup completed on SQLEXPRESS!</strong><br>");
                results.AppendLine("<strong>? Database:</strong> anotherDemo (SQLEXPRESS)<br>");
                results.AppendLine("<strong>? Table:</strong> AdminUsers<br>");
                results.AppendLine("<strong>? Credentials stored in database:</strong> admin/admin123<br>");
                results.AppendLine("<strong>?? Location:</strong> .\\SQLEXPRESS server ? anotherDemo database ? AdminUsers table</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}<br>");
                results.AppendLine("Make sure SQL Server Express is running!</div>");
                lblResults.Text = results.ToString();
            }
        }

        protected void btnVerifySetup_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Verifying SQLEXPRESS Authentication...</strong></div>");

            try
            {
                var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
                if (connString == null)
                {
                    lblResults.Text = "<div class='alert alert-danger'>? AnotherDemoConnection not found</div>";
                    return;
                }

                using (var connection = new SqlConnection(connString.ConnectionString))
                {
                    connection.Open();
                    results.AppendLine("? Connected to anotherDemo database<br>");

                    // Check if AdminUsers table exists
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AdminUsers'";
                    using (var command = new SqlCommand(checkTableQuery, connection))
                    {
                        int tableCount = (int)command.ExecuteScalar();
                        if (tableCount > 0)
                        {
                            results.AppendLine("? AdminUsers table exists<br>");
                            
                            // Show admin users
                            string adminQuery = "SELECT Username, Email, FullName, IsActive, CreatedDate FROM AdminUsers";
                            using (var adminCommand = new SqlCommand(adminQuery, connection))
                            {
                                using (var reader = adminCommand.ExecuteReader())
                                {
                                    results.AppendLine("<table style='width:100%; border-collapse: collapse; margin: 10px 0;'>");
                                    results.AppendLine("<tr style='background-color: #f2f2f2;'><th style='border: 1px solid #ddd; padding: 8px;'>Username</th><th style='border: 1px solid #ddd; padding: 8px;'>Email</th><th style='border: 1px solid #ddd; padding: 8px;'>Full Name</th><th style='border: 1px solid #ddd; padding: 8px;'>Active</th><th style='border: 1px solid #ddd; padding: 8px;'>Created</th></tr>");
                                    while (reader.Read())
                                    {
                                        results.AppendLine($"<tr>");
                                        results.AppendLine($"<td style='border: 1px solid #ddd; padding: 8px;'><strong>{reader["Username"]}</strong></td>");
                                        results.AppendLine($"<td style='border: 1px solid #ddd; padding: 8px;'>{reader["Email"]}</td>");
                                        results.AppendLine($"<td style='border: 1px solid #ddd; padding: 8px;'>{reader["FullName"]}</td>");
                                        results.AppendLine($"<td style='border: 1px solid #ddd; padding: 8px;'>{reader["IsActive"]}</td>");
                                        results.AppendLine($"<td style='border: 1px solid #ddd; padding: 8px;'>{reader["CreatedDate"]}</td>");
                                        results.AppendLine($"</tr>");
                                    }
                                    results.AppendLine("</table>");
                                }
                            }

                            // Test authentication
                            string testAuthQuery = "SELECT COUNT(*) FROM AdminUsers WHERE Username = 'admin' AND Password = 'admin123'";
                            using (var testCommand = new SqlCommand(testAuthQuery, connection))
                            {
                                int authCount = (int)testCommand.ExecuteScalar();
                                if (authCount > 0)
                                {
                                    results.AppendLine("? Authentication test passed - admin/admin123 works!<br>");
                                }
                                else
                                {
                                    results.AppendLine("? Authentication test failed<br>");
                                }
                            }
                        }
                        else
                        {
                            results.AppendLine("? AdminUsers table not found<br>");
                        }
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>?? Ready to test login!</strong><br>");
                results.AppendLine("Go to admin_login.aspx and use admin/admin123</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                lblResults.Text = $"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}</div>";
            }
        }

        private void TestSQLExpressConnection(string connectionName, StringBuilder results)
        {
            var connString = ConfigurationManager.ConnectionStrings[connectionName];
            if (connString == null)
            {
                results.AppendLine($"<div class='alert alert-warning'>?? {connectionName} not found in Web.config</div>");
                return;
            }

            results.AppendLine($"<h4>?? Testing {connectionName}:</h4>");

            try
            {
                using (var connection = new SqlConnection(connString.ConnectionString))
                {
                    connection.Open();
                    results.AppendLine($"<div class='alert alert-success'>? {connectionName} connected successfully!</div>");

                    // Show connection details
                    using (var command = new SqlCommand("SELECT @@SERVERNAME as ServerName, DB_NAME() as DatabaseName", connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                results.AppendLine($"<p><strong>Server:</strong> {reader["ServerName"]}<br>");
                                results.AppendLine($"<strong>Database:</strong> {reader["DatabaseName"]}</p>");
                            }
                        }
                    }

                    // List tables
                    string tablesQuery = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME";
                    using (var command = new SqlCommand(tablesQuery, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<p><strong>Existing tables:</strong></p><ul>");
                            bool foundTables = false;
                            while (reader.Read())
                            {
                                foundTables = true;
                                string tableName = reader["TABLE_NAME"].ToString();
                                if (tableName == "AdminUsers")
                                {
                                    results.AppendLine($"<li><strong style='color: green;'>{tableName} ? (Authentication table found!)</strong></li>");
                                }
                                else
                                {
                                    results.AppendLine($"<li>{tableName}</li>");
                                }
                            }
                            
                            if (!foundTables)
                            {
                                results.AppendLine("<li><em>No tables found</em></li>");
                            }
                            results.AppendLine("</ul>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'>? {connectionName} failed: {ex.Message}</div>");
            }

            results.AppendLine("<hr>");
        }
    }
}