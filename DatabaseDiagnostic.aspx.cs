using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Text;

namespace MyPortfolio
{
    public partial class DatabaseDiagnostic : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Display connection strings
                lblDemoConnection.Text = ConfigurationManager.ConnectionStrings["MyDBConnection"].ConnectionString;
                lblAnotherDemoConnection.Text = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString;
            }
        }

        protected void btnTestSQLServer_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<strong>SQL Server Connection Test:</strong><br />");

            try
            {
                // Test connection to master database
                string masterConnectionString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString
                    .Replace("Initial Catalog=anotherDemo", "Initial Catalog=master");

                using (var connection = new SqlConnection(masterConnectionString))
                {
                    connection.Open();
                    
                    // Get SQL Server version
                    using (var command = new SqlCommand("SELECT @@VERSION", connection))
                    {
                        string version = command.ExecuteScalar().ToString();
                        results.AppendLine($"? SQL Server Connected Successfully<br />");
                        results.AppendLine($"Version: {version.Split('\n')[0]}<br />");
                    }

                    // List databases
                    using (var command = new SqlCommand("SELECT name FROM sys.databases ORDER BY name", connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<br /><strong>Available Databases:</strong><br />");
                            while (reader.Read())
                            {
                                results.AppendLine($"• {reader["name"]}<br />");
                            }
                        }
                    }
                }

                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                results.AppendLine($"? SQL Server Connection Failed<br />");
                results.AppendLine($"Error: {ex.Message}<br />");
                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-danger";
            }
        }

        protected void btnTestDemo_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<strong>Demo Database Test:</strong><br />");

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["MyDBConnection"].ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    results.AppendLine("? Demo Database Connected Successfully<br />");

                    // List tables
                    using (var command = new SqlCommand("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_NAME", connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<br /><strong>Tables in Demo Database:</strong><br />");
                            while (reader.Read())
                            {
                                results.AppendLine($"• {reader["TABLE_NAME"]}<br />");
                            }
                        }
                    }
                }

                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                results.AppendLine($"? Demo Database Connection Failed<br />");
                results.AppendLine($"Error: {ex.Message}<br />");
                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-danger";
            }
        }

        protected void btnTestAnotherDemo_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<strong>AnotherDemo Database Test:</strong><br />");

            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    results.AppendLine("? AnotherDemo Database Connected Successfully<br />");

                    // List tables
                    using (var command = new SqlCommand("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ORDER BY TABLE_NAME", connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<br /><strong>Tables in AnotherDemo Database:</strong><br />");
                            bool hasTables = false;
                            while (reader.Read())
                            {
                                results.AppendLine($"• {reader["TABLE_NAME"]}<br />");
                                hasTables = true;
                            }
                            if (!hasTables)
                            {
                                results.AppendLine("No tables found.<br />");
                            }
                        }
                    }
                }

                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                results.AppendLine($"? AnotherDemo Database Connection Failed<br />");
                results.AppendLine($"Error: {ex.Message}<br />");
                
                if (ex.Message.Contains("Cannot open database") || ex.Message.Contains("does not exist"))
                {
                    results.AppendLine("<br /><strong>Solution:</strong> The database doesn't exist. Click 'Force Create AnotherDemo' to create it.<br />");
                }
                
                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-danger";
            }
        }

        protected void btnCreateAnotherDemo_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<strong>Force Create AnotherDemo Database:</strong><br />");

            try
            {
                // Connect to master database
                string masterConnectionString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString
                    .Replace("Initial Catalog=anotherDemo", "Initial Catalog=master");

                using (var masterConnection = new SqlConnection(masterConnectionString))
                {
                    masterConnection.Open();
                    results.AppendLine("? Connected to master database<br />");

                    // Check if database exists
                    using (var checkCommand = new SqlCommand("SELECT COUNT(*) FROM sys.databases WHERE name = 'anotherDemo'", masterConnection))
                    {
                        int exists = (int)checkCommand.ExecuteScalar();
                        if (exists > 0)
                        {
                            results.AppendLine("?? Database 'anotherDemo' already exists<br />");
                        }
                        else
                        {
                            // Create database
                            using (var createCommand = new SqlCommand("CREATE DATABASE anotherDemo", masterConnection))
                            {
                                createCommand.ExecuteNonQuery();
                                results.AppendLine("? Database 'anotherDemo' created successfully<br />");
                            }
                        }
                    }
                }

                // Now connect to the new database and create table
                string connectionString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString;
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    results.AppendLine("? Connected to 'anotherDemo' database<br />");

                    // Create table
                    string createTableSql = @"
                        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test2')
                        BEGIN
                            CREATE TABLE test2 (
                                roll int PRIMARY KEY,
                                name nvarchar(100) NOT NULL
                            );
                        END";

                    using (var command = new SqlCommand(createTableSql, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? Table 'test2' created successfully<br />");
                    }

                    // Insert sample data
                    string insertSql = @"
                        IF NOT EXISTS (SELECT * FROM test2)
                        BEGIN
                            INSERT INTO test2 (roll, name) VALUES 
                            (101, 'John Doe'),
                            (102, 'Jane Smith'),
                            (103, 'Mike Johnson');
                        END";

                    using (var command = new SqlCommand(insertSql, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? Sample data inserted successfully<br />");
                    }
                }

                results.AppendLine("<br /><strong>? Setup Complete!</strong> You can now use Database Test 2.<br />");
                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                results.AppendLine($"? Failed to create database<br />");
                results.AppendLine($"Error: {ex.Message}<br />");
                lblResults.Text = results.ToString();
                lblResults.CssClass = "text-danger";
            }
        }
    }
}