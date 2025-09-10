using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Text;

namespace MyPortfolio
{
    public partial class setup_profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResults.Text = "Ready to setup Profile table on SQLEXPRESS...";
            }
        }

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

        protected void btnTestConnection_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Testing Database Connection...</strong></div>");

            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    results.AppendLine("? Database connection successful!<br>");

                    // Show connection details
                    using (var command = new SqlCommand("SELECT @@SERVERNAME as ServerName, DB_NAME() as DatabaseName", connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                results.AppendLine($"<strong>Server:</strong> {reader["ServerName"]}<br>");
                                results.AppendLine($"<strong>Database:</strong> {reader["DatabaseName"]}<br>");
                            }
                        }
                    }

                    // Check if Profile table exists
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Profile'";
                    using (var command = new SqlCommand(checkTableQuery, connection))
                    {
                        int tableCount = (int)command.ExecuteScalar();
                        if (tableCount > 0)
                        {
                            results.AppendLine("?? Profile table already exists<br>");
                        }
                        else
                        {
                            results.AppendLine("?? Profile table does not exist - ready to create<br>");
                        }
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>? Connection test completed!</strong></div>");
                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}<br>");
                results.AppendLine("Make sure SQL Server Express is running!</div>");
                lblResults.Text = results.ToString();
            }
        }

        protected void btnCreateTable_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Creating Profile Table...</strong></div>");

            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    results.AppendLine("? Connected to database<br>");

                    // Create Profile table with all fields from admin profile section (excluding education)
                    string createProfileTable = @"
                        IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Profile' AND xtype='U')
                        BEGIN
                            CREATE TABLE Profile (
                                Id INT IDENTITY(1,1) PRIMARY KEY,
                                
                                -- Personal Information
                                FullName NVARCHAR(100) NOT NULL,
                                Title NVARCHAR(100) NOT NULL,
                                Email NVARCHAR(100) NOT NULL,
                                Phone NVARCHAR(20),
                                Location NVARCHAR(100),
                                Bio NVARCHAR(500),
                                
                                -- Programming Profile
                                Experience INT DEFAULT 0,
                                CodeforcesRating INT DEFAULT 0,
                                CodeforcesRank NVARCHAR(20),
                                CodechefRating INT DEFAULT 0,
                                CodechefRank NVARCHAR(20),
                                ProblemsSolved INT DEFAULT 0,
                                
                                -- Social Links
                                GitHubUrl NVARCHAR(200),
                                CodeforcesUrl NVARCHAR(200),
                                LinkedInUrl NVARCHAR(200),
                                TwitterUrl NVARCHAR(200),
                                KaggleUrl NVARCHAR(200),
                                
                                -- System Fields
                                IsActive BIT DEFAULT 1,
                                DateCreated DATETIME DEFAULT GETDATE(),
                                DateModified DATETIME DEFAULT GETDATE(),
                                CreatedBy NVARCHAR(50) DEFAULT 'admin'
                            );
                        END
                        ELSE
                        BEGIN
                            PRINT 'Profile table already exists!'
                        END";

                    using (var command = new SqlCommand(createProfileTable, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? Profile table created successfully<br>");
                    }

                    // Show table structure
                    string showColumnsQuery = @"
                        SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE, COLUMN_DEFAULT
                        FROM INFORMATION_SCHEMA.COLUMNS 
                        WHERE TABLE_NAME = 'Profile' 
                        ORDER BY ORDINAL_POSITION";

                    using (var command = new SqlCommand(showColumnsQuery, connection))
                    {
                        using (var reader = command.ExecuteReader())
                        {
                            results.AppendLine("<h4>?? Profile Table Structure:</h4>");
                            results.AppendLine("<table>");
                            results.AppendLine("<tr><th>Column</th><th>Type</th><th>Length</th><th>Nullable</th><th>Default</th></tr>");
                            
                            while (reader.Read())
                            {
                                results.AppendLine("<tr>");
                                results.AppendLine($"<td><strong>{reader["COLUMN_NAME"]}</strong></td>");
                                results.AppendLine($"<td>{reader["DATA_TYPE"]}</td>");
                                results.AppendLine($"<td>{reader["CHARACTER_MAXIMUM_LENGTH"]?.ToString() ?? "N/A"}</td>");
                                results.AppendLine($"<td>{reader["IS_NULLABLE"]}</td>");
                                results.AppendLine($"<td>{reader["COLUMN_DEFAULT"]?.ToString() ?? "NULL"}</td>");
                                results.AppendLine("</tr>");
                            }
                            results.AppendLine("</table>");
                        }
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>?? Profile table setup completed!</strong><br>");
                results.AppendLine("The table includes all fields from your admin profile section (excluding education).</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}</div>");
                lblResults.Text = results.ToString();
            }
        }

        protected void btnInsertSampleData_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Inserting Sample Profile Data...</strong></div>");

            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    // Check if data already exists
                    string checkDataQuery = "SELECT COUNT(*) FROM Profile";
                    using (var command = new SqlCommand(checkDataQuery, connection))
                    {
                        int count = (int)command.ExecuteScalar();
                        if (count > 0)
                        {
                            results.AppendLine("?? Profile data already exists. Updating existing record...<br>");

                            // Update existing data
                            string updateQuery = @"
                                UPDATE Profile SET 
                                    FullName = @FullName,
                                    Title = @Title,
                                    Email = @Email,
                                    Phone = @Phone,
                                    Location = @Location,
                                    Bio = @Bio,
                                    Experience = @Experience,
                                    CodeforcesRating = @CodeforcesRating,
                                    CodeforcesRank = @CodeforcesRank,
                                    CodechefRating = @CodechefRating,
                                    CodechefRank = @CodechefRank,
                                    ProblemsSolved = @ProblemsSolved,
                                    GitHubUrl = @GitHubUrl,
                                    CodeforcesUrl = @CodeforcesUrl,
                                    LinkedInUrl = @LinkedInUrl,
                                    TwitterUrl = @TwitterUrl,
                                    KaggleUrl = @KaggleUrl,
                                    DateModified = GETDATE()
                                WHERE Id = (SELECT TOP 1 Id FROM Profile)";

                            using (var updateCommand = new SqlCommand(updateQuery, connection))
                            {
                                AddProfileParameters(updateCommand);
                                updateCommand.ExecuteNonQuery();
                                results.AppendLine("? Profile data updated successfully<br>");
                            }
                        }
                        else
                        {
                            // Insert new data
                            string insertQuery = @"
                                INSERT INTO Profile (
                                    FullName, Title, Email, Phone, Location, Bio,
                                    Experience, CodeforcesRating, CodeforcesRank, 
                                    CodechefRating, CodechefRank, ProblemsSolved,
                                    GitHubUrl, CodeforcesUrl, LinkedInUrl, TwitterUrl, KaggleUrl
                                ) VALUES (
                                    @FullName, @Title, @Email, @Phone, @Location, @Bio,
                                    @Experience, @CodeforcesRating, @CodeforcesRank,
                                    @CodechefRating, @CodechefRank, @ProblemsSolved,
                                    @GitHubUrl, @CodeforcesUrl, @LinkedInUrl, @TwitterUrl, @KaggleUrl
                                )";

                            using (var insertCommand = new SqlCommand(insertQuery, connection))
                            {
                                AddProfileParameters(insertCommand);
                                insertCommand.ExecuteNonQuery();
                                results.AppendLine("? Sample profile data inserted successfully<br>");
                            }
                        }
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>?? Sample data setup completed!</strong><br>");
                results.AppendLine("Profile data has been set up with the values from your admin dashboard.</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}</div>");
                lblResults.Text = results.ToString();
            }
        }

        private void AddProfileParameters(SqlCommand command)
        {
            // Sample data based on the admin profile section
            command.Parameters.AddWithValue("@FullName", "Dipra Datta");
            command.Parameters.AddWithValue("@Title", "Competitive Programmer");
            command.Parameters.AddWithValue("@Email", "dipra.datta@example.com");
            command.Parameters.AddWithValue("@Phone", "+880 1XXX-XXXXXX");
            command.Parameters.AddWithValue("@Location", "Khulna, Bangladesh");
            command.Parameters.AddWithValue("@Bio", "BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver");
            command.Parameters.AddWithValue("@Experience", 3);
            command.Parameters.AddWithValue("@CodeforcesRating", 1771);
            command.Parameters.AddWithValue("@CodeforcesRank", "Expert");
            command.Parameters.AddWithValue("@CodechefRating", 1913);
            command.Parameters.AddWithValue("@CodechefRank", "4-star");
            command.Parameters.AddWithValue("@ProblemsSolved", 1676);
            command.Parameters.AddWithValue("@GitHubUrl", "https://github.com/dipra-datta");
            command.Parameters.AddWithValue("@CodeforcesUrl", "https://codeforces.com/profile/dipra_datta");
            command.Parameters.AddWithValue("@LinkedInUrl", "https://linkedin.com/in/dipra-datta");
            command.Parameters.AddWithValue("@TwitterUrl", "https://twitter.com/dipra_datta");
            command.Parameters.AddWithValue("@KaggleUrl", "https://kaggle.com/dipra-datta");
        }

        protected void btnVerifySetup_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-info'><strong>?? Verifying Profile Setup...</strong></div>");

            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();
                    results.AppendLine("? Connected to database<br>");

                    // Check if table exists
                    string checkTableQuery = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Profile'";
                    using (var command = new SqlCommand(checkTableQuery, connection))
                    {
                        int tableCount = (int)command.ExecuteScalar();
                        if (tableCount > 0)
                        {
                            results.AppendLine("? Profile table exists<br>");

                            // Show data
                            string dataQuery = @"
                                SELECT Id, FullName, Title, Email, Phone, Location, Bio,
                                       Experience, CodeforcesRating, CodeforcesRank,
                                       CodechefRating, CodechefRank, ProblemsSolved,
                                       GitHubUrl, CodeforcesUrl, LinkedInUrl, TwitterUrl, KaggleUrl,
                                       IsActive, DateCreated, DateModified
                                FROM Profile 
                                ORDER BY Id";

                            using (var dataCommand = new SqlCommand(dataQuery, connection))
                            {
                                using (var reader = dataCommand.ExecuteReader())
                                {
                                    if (reader.HasRows)
                                    {
                                        results.AppendLine("<h4>?? Profile Data:</h4>");
                                        results.AppendLine("<table>");
                                        
                                        while (reader.Read())
                                        {
                                            results.AppendLine($"<tr><td><strong>ID:</strong></td><td>{reader["Id"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Full Name:</strong></td><td>{reader["FullName"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Title:</strong></td><td>{reader["Title"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Email:</strong></td><td>{reader["Email"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Phone:</strong></td><td>{reader["Phone"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Location:</strong></td><td>{reader["Location"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Bio:</strong></td><td>{reader["Bio"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Experience:</strong></td><td>{reader["Experience"]} years</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Codeforces:</strong></td><td>{reader["CodeforcesRating"]} ({reader["CodeforcesRank"]})</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Codechef:</strong></td><td>{reader["CodechefRating"]} ({reader["CodechefRank"]})</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Problems Solved:</strong></td><td>{reader["ProblemsSolved"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>GitHub:</strong></td><td>{reader["GitHubUrl"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Active:</strong></td><td>{reader["IsActive"]}</td></tr>");
                                            results.AppendLine($"<tr><td><strong>Created:</strong></td><td>{reader["DateCreated"]}</td></tr>");
                                        }
                                        results.AppendLine("</table>");
                                    }
                                    else
                                    {
                                        results.AppendLine("?? No data found in Profile table<br>");
                                    }
                                }
                            }
                        }
                        else
                        {
                            results.AppendLine("? Profile table does not exist<br>");
                        }
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>?? Verification completed!</strong><br>");
                results.AppendLine("Profile setup is ready for use in your admin dashboard.</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}</div>");
                lblResults.Text = results.ToString();
            }
        }

        protected void btnDropTable_Click(object sender, EventArgs e)
        {
            StringBuilder results = new StringBuilder();
            results.AppendLine("<div class='alert alert-warning'><strong>?? Dropping Profile Table...</strong></div>");

            try
            {
                using (var connection = new SqlConnection(GetConnectionString()))
                {
                    connection.Open();

                    string dropTableQuery = "IF EXISTS (SELECT * FROM sysobjects WHERE name='Profile' AND xtype='U') DROP TABLE Profile";
                    using (var command = new SqlCommand(dropTableQuery, connection))
                    {
                        command.ExecuteNonQuery();
                        results.AppendLine("? Profile table dropped successfully<br>");
                    }
                }

                results.AppendLine("<div class='alert alert-success'><strong>??? Table removal completed!</strong><br>");
                results.AppendLine("Profile table has been removed from the database.</div>");

                lblResults.Text = results.ToString();
            }
            catch (Exception ex)
            {
                results.AppendLine($"<div class='alert alert-danger'><strong>? Error:</strong> {ex.Message}</div>");
                lblResults.Text = results.ToString();
            }
        }
    }
}