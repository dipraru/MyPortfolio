using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Text;

namespace MyPortfolio
{
    public partial class check_database : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResults.Text = "Ready to investigate your database setup...";
            }
        }

        protected void btnCheckAll_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><h3>?? Complete Database Investigation</h3></div>");

            // Check each connection string
            CheckConnectionString("DefaultConnection", results);
            CheckConnectionString("MyDBConnection", results);
            CheckConnectionString("AnotherDemoConnection", results);

            lblResults.Text = results.ToString();
        }

        protected void btnListAllDatabases_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><h3>?? All Databases on Server</h3></div>");

            try
            {
                // Try to connect to each server and list databases
                string[] connectionNames = { "DefaultConnection", "MyDBConnection", "AnotherDemoConnection" };

                foreach (string connName in connectionNames)
                {
                    var connString = ConfigurationManager.ConnectionStrings[connName];
                    if (connString != null)
                    {
                        try
                        {
                            // Connect to master database to list all databases
                            string masterConnectionString = connString.ConnectionString
                                .Replace("Initial Catalog=MyPortfolioDB", "Initial Catalog=master")
                                .Replace("Initial Catalog=demo", "Initial Catalog=master")
                                .Replace("Initial Catalog=anotherDemo", "Initial Catalog=master");

                            using (var connection = new SqlConnection(masterConnectionString))
                            {
                                connection.Open();
                                results.AppendLine($"<h4>?? Server from {connName}:</h4>");
                                results.AppendLine("<table>");
                                results.AppendLine("<tr><th>Database Name</th><th>Created Date</th><th>Status</th></tr>");

                                string query = @"SELECT name, create_date, state_desc 
                                               FROM sys.databases 
                                               WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
                                               ORDER BY name";

                                using (var command = new SqlCommand(query, connection))
                                {
                                    using (var reader = command.ExecuteReader())
                                    {
                                        bool found = false;
                                        while (reader.Read())
                                        {
                                            found = true;
                                            string dbName = reader["name"].ToString();
                                            string createDate = reader["create_date"].ToString();
                                            string status = reader["state_desc"].ToString();
                                            
                                            string rowClass = "";
                                            if (dbName.Contains("Portfolio") || dbName.Contains("Auth"))
                                                rowClass = " style='background-color: #d4edda;'";
                                            
                                            results.AppendLine($"<tr{rowClass}><td><strong>{dbName}</strong></td><td>{createDate}</td><td>{status}</td></tr>");
                                        }
                                        
                                        if (!found)
                                        {
                                            results.AppendLine("<tr><td colspan='3'>No user databases found</td></tr>");
                                        }
                                    }
                                }
                                results.AppendLine("</table><br>");
                                break; // Only need to check one working connection
                            }
                        }
                        catch (Exception ex)
                        {
                            results.AppendLine($"<div class='alert alert-warning'>?? {connName}: {ex.Message}</div>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'>? Error: {ex.Message}</div>");
            }

            lblResults.Text = results.ToString();
        }

        protected void btnCheckSpecific_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><h3>?? Checking for Portfolio/Auth Databases</h3></div>");

            // Look for specific databases that might contain our auth table
            string[] possibleDatabases = { "MyPortfolioAuth", "MyPortfolioDB", "demo", "anotherDemo" };
            string[] connectionNames = { "DefaultConnection", "MyDBConnection", "AnotherDemoConnection" };

            foreach (string connName in connectionNames)
            {
                var connString = ConfigurationManager.ConnectionStrings[connName];
                if (connString != null)
                {
                    foreach (string dbName in possibleDatabases)
                    {
                        CheckSpecificDatabase(connName, dbName, connString.ConnectionString, results);
                    }
                }
            }

            lblResults.Text = results.ToString();
        }

        protected void btnShowConnections_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><h3>?? Your Connection Strings</h3></div>");

            string[] connectionNames = { "DefaultConnection", "MyDBConnection", "AnotherDemoConnection" };

            foreach (string connName in connectionNames)
            {
                var connString = ConfigurationManager.ConnectionStrings[connName];
                if (connString != null)
                {
                    results.AppendLine($"<h4>{connName}:</h4>");
                    results.AppendLine("<pre>");
                    results.AppendLine(connString.ConnectionString);
                    results.AppendLine("</pre>");
                    
                    // Parse connection string to show key parts
                    try
                    {
                        var builder = new SqlConnectionStringBuilder(connString.ConnectionString);
                        results.AppendLine("<table>");
                        results.AppendLine($"<tr><td><strong>Server:</strong></td><td>{builder.DataSource}</td></tr>");
                        results.AppendLine($"<tr><td><strong>Database:</strong></td><td>{builder.InitialCatalog}</td></tr>");
                        results.AppendLine($"<tr><td><strong>Authentication:</strong></td><td>{(builder.IntegratedSecurity ? "Windows Auth" : "SQL Auth")}</td></tr>");
                        results.AppendLine("</table><br>");
                    }
                    catch (Exception ex)
                    {
                        results.AppendLine($"<div class='alert alert-warning'>Could not parse connection string: {ex.Message}</div>");
                    }
                }
            }

            lblResults.Text = results.ToString();
        }

        private void CheckConnectionString(string connectionName, StringBuilder results)
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

                    // Check if database exists and what tables it has
                    string currentDb = connection.Database;
                    results.AppendLine($"<p><strong>Connected to database:</strong> {currentDb}</p>");

                    // List tables in this database
                    string tablesQuery = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY TABLE_NAME";
                    using (var command = new SqlCommand(tablesQuery, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<p><strong>Tables found:</strong></p><ul>");
                            bool foundTables = false;
                            while (reader.Read())
                            {
                                foundTables = true;
                                string tableName = reader["TABLE_NAME"].ToString();
                                if (tableName == "AdminUsers")
                                {
                                    results.AppendLine($"<li><strong style='color: green;'>{tableName} ? (This is our auth table!)</strong></li>");
                                }
                                else
                                {
                                    results.AppendLine($"<li>{tableName}</li>");
                                }
                            }
                            
                            if (!foundTables)
                            {
                                results.AppendLine("<li><em>No tables found in this database</em></li>");
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

        private void CheckSpecificDatabase(string connectionName, string databaseName, string baseConnectionString, StringBuilder results)
        {
            try
            {
                // Create connection string for specific database
                string connectionString = baseConnectionString
                    .Replace("Initial Catalog=MyPortfolioDB", $"Initial Catalog={databaseName}")
                    .Replace("Initial Catalog=demo", $"Initial Catalog={databaseName}")
                    .Replace("Initial Catalog=anotherDemo", $"Initial Catalog={databaseName}");

                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check for AdminUsers table
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AdminUsers'";
                    using (var command = new SqlCommand(checkTableQuery, connection))
                    {
                        int tableCount = (int)command.ExecuteScalar();
                        if (tableCount > 0)
                        {
                            results.AppendLine($"<div class='alert alert-success'>?? Found AdminUsers table in {databaseName} (via {connectionName})!</div>");
                            
                            // Show admin users
                            string adminQuery = "SELECT Username, Email, FullName, IsActive, CreatedDate FROM AdminUsers";
                            using (var adminCommand = new SqlCommand(adminQuery, connection))
                            {
                                using (var reader = adminCommand.ExecuteReader())
                                {
                                    results.AppendLine("<table><tr><th>Username</th><th>Email</th><th>Full Name</th><th>Active</th><th>Created</th></tr>");
                                    while (reader.Read())
                                    {
                                        results.AppendLine($"<tr>");
                                        results.AppendLine($"<td><strong>{reader["Username"]}</strong></td>");
                                        results.AppendLine($"<td>{reader["Email"]}</td>");
                                        results.AppendLine($"<td>{reader["FullName"]}</td>");
                                        results.AppendLine($"<td>{reader["IsActive"]}</td>");
                                        results.AppendLine($"<td>{reader["CreatedDate"]}</td>");
                                        results.AppendLine($"</tr>");
                                    }
                                    results.AppendLine("</table>");
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                // Database doesn't exist or can't connect - that's fine, skip it
            }
        }
    }
}