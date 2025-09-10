using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;

namespace MyPortfolio
{
    public partial class DatabaseTest2 : Page
    {
        private string GetConnectionString()
        {
            // Get connection string for anotherDemo database from web.config
            return ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString;
        }

        private string GetMasterConnectionString()
        {
            // Get connection string but point to master database for database creation
            string connectionString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"].ConnectionString;
            return connectionString.Replace("Initial Catalog=anotherDemo", "Initial Catalog=master");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckDatabaseConnection();
                LoadStudentData();
            }
        }

        private void CheckDatabaseConnection()
        {
            try
            {
                // Step 1: Test basic SQL Server connection using master database
                string masterConnectionString = GetMasterConnectionString();
                
                using (var masterConnection = new SqlConnection(masterConnectionString))
                {
                    masterConnection.Open();
                    
                    // Step 2: Check if anotherDemo database exists
                    string checkDbSql = "SELECT COUNT(*) FROM sys.databases WHERE name = 'anotherDemo'";
                    using (var checkDbCommand = new SqlCommand(checkDbSql, masterConnection))
                    {
                        int dbExists = (int)checkDbCommand.ExecuteScalar();
                        
                        if (dbExists == 0)
                        {
                            // Step 3: Create database if it doesn't exist
                            string createDbSql = "CREATE DATABASE anotherDemo";
                            using (var createDbCommand = new SqlCommand(createDbSql, masterConnection))
                            {
                                createDbCommand.ExecuteNonQuery();
                            }
                            
                            lblMessage.Text = "? Database 'anotherDemo' created successfully!";
                            lblMessage.CssClass = "text-success";
                        }
                    }
                }

                // Step 4: Now connect to the anotherDemo database
                string connectionString = GetConnectionString();
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Step 5: Create table if it doesn't exist
                    string createTableSql = @"
                        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test2')
                        BEGIN
                            CREATE TABLE test2 (
                                roll int PRIMARY KEY,
                                name nvarchar(100) NOT NULL
                            );
                            PRINT 'Table test2 created successfully';
                        END";
                    
                    using (var command = new SqlCommand(createTableSql, connection))
                    {
                        command.ExecuteNonQuery();
                    }

                    lblConnectionStatus.Text = "? Database 'anotherDemo' Connected Successfully";
                    lblConnectionStatus.CssClass = "badge bg-success fs-6 mb-3";
                    
                    if (lblMessage.Text == "")
                    {
                        lblMessage.Text = "Database connection established and 'test2' table is ready.";
                        lblMessage.CssClass = "text-success";
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                lblConnectionStatus.Text = "? Database Connection Failed";
                lblConnectionStatus.CssClass = "badge bg-danger fs-6 mb-3";
                
                // Provide more specific error messages based on SQL error
                string errorMessage = "SQL Error: ";
                switch (sqlEx.Number)
                {
                    case 2:
                        errorMessage = "Cannot connect to SQL Server. Please ensure SQL Server Express is running.";
                        break;
                    case 18456:
                        errorMessage = "Login failed. Please check your SQL Server authentication settings.";
                        break;
                    case 5:
                        errorMessage = "Access denied. Please check database permissions.";
                        break;
                    default:
                        errorMessage = $"SQL Error {sqlEx.Number}: {sqlEx.Message}";
                        break;
                }
                
                lblMessage.Text = errorMessage;
                lblMessage.CssClass = "text-danger";
                
                // Log detailed error for debugging
                System.Diagnostics.Debug.WriteLine($"SQL Error Details: {sqlEx.ToString()}");
            }
            catch (Exception ex)
            {
                lblConnectionStatus.Text = "? Database Connection Failed";
                lblConnectionStatus.CssClass = "badge bg-danger fs-6 mb-3";
                lblMessage.Text = $"Error: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                
                // Log more details for debugging
                System.Diagnostics.Debug.WriteLine($"Database connection error: {ex.ToString()}");
            }
        }

        private void LoadStudentData()
        {
            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if table exists first
                    string checkTableSql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test2'";
                    using (var checkCommand = new SqlCommand(checkTableSql, connection))
                    {
                        int tableExists = (int)checkCommand.ExecuteScalar();
                        if (tableExists == 0)
                        {
                            // Table doesn't exist yet, try to create it
                            CheckDatabaseConnection();
                            return;
                        }
                    }
                    
                    string selectSql = "SELECT roll, name FROM test2 ORDER BY roll";
                    using (var command = new SqlCommand(selectSql, connection))
                    {
                        using (var adapter = new SqlDataAdapter(command))
                        {
                            var dataTable = new DataTable();
                            adapter.Fill(dataTable);
                            gvStudentData.DataSource = dataTable;
                            gvStudentData.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Don't overwrite database connection status messages
                if (lblMessage.Text == "" || lblMessage.CssClass.Contains("success"))
                {
                    lblMessage.Text = $"Error loading student data: {ex.Message}";
                    lblMessage.CssClass = "text-danger";
                }
                System.Diagnostics.Debug.WriteLine($"Load data error: {ex.ToString()}");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtRoll.Text))
            {
                lblMessage.Text = "Please enter a roll number.";
                lblMessage.CssClass = "text-warning";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtStudentName.Text))
            {
                lblMessage.Text = "Please enter a student name.";
                lblMessage.CssClass = "text-warning";
                return;
            }

            if (!int.TryParse(txtRoll.Text.Trim(), out int rollNumber))
            {
                lblMessage.Text = "Please enter a valid roll number (integer).";
                lblMessage.CssClass = "text-warning";
                return;
            }

            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if roll number already exists (since it's primary key)
                    string checkSql = "SELECT COUNT(*) FROM test2 WHERE roll = @Roll";
                    using (var checkCommand = new SqlCommand(checkSql, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Roll", rollNumber);
                        int exists = (int)checkCommand.ExecuteScalar();
                        
                        if (exists > 0)
                        {
                            lblMessage.Text = "?? A student with this roll number already exists. Roll numbers must be unique.";
                            lblMessage.CssClass = "text-warning";
                            return;
                        }
                    }
                    
                    string insertSql = "INSERT INTO test2 (roll, name) VALUES (@Roll, @Name)";
                    using (var command = new SqlCommand(insertSql, connection))
                    {
                        command.Parameters.AddWithValue("@Roll", rollNumber);
                        command.Parameters.AddWithValue("@Name", txtStudentName.Text.Trim());
                        
                        command.ExecuteNonQuery();
                    }

                    lblMessage.Text = "? Student record added successfully to database!";
                    lblMessage.CssClass = "text-success";

                    // Clear form
                    txtRoll.Text = "";
                    txtStudentName.Text = "";

                    // Refresh data
                    LoadStudentData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error adding student: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                System.Diagnostics.Debug.WriteLine($"Add student error: {ex.ToString()}");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtDeleteRoll.Text))
            {
                lblMessage.Text = "Please enter a roll number to delete.";
                lblMessage.CssClass = "text-warning";
                return;
            }

            if (!int.TryParse(txtDeleteRoll.Text.Trim(), out int rollNumber))
            {
                lblMessage.Text = "Please enter a valid roll number (integer).";
                lblMessage.CssClass = "text-warning";
                return;
            }

            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if roll number exists before trying to delete
                    string checkSql = "SELECT COUNT(*) FROM test2 WHERE roll = @Roll";
                    using (var checkCommand = new SqlCommand(checkSql, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Roll", rollNumber);
                        int exists = (int)checkCommand.ExecuteScalar();
                        
                        if (exists == 0)
                        {
                            lblMessage.Text = "?? No student found with this roll number.";
                            lblMessage.CssClass = "text-warning";
                            return;
                        }
                    }
                    
                    string deleteSql = "DELETE FROM test2 WHERE roll = @Roll";
                    using (var command = new SqlCommand(deleteSql, connection))
                    {
                        command.Parameters.AddWithValue("@Roll", rollNumber);
                        int rowsAffected = command.ExecuteNonQuery();
                        
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = $"? Student with roll number {rollNumber} deleted successfully!";
                            lblMessage.CssClass = "text-success";
                        }
                        else
                        {
                            lblMessage.Text = "?? No student was deleted. Please try again.";
                            lblMessage.CssClass = "text-warning";
                        }
                    }

                    // Clear form
                    txtDeleteRoll.Text = "";

                    // Refresh data
                    LoadStudentData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error deleting student: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                System.Diagnostics.Debug.WriteLine($"Delete student error: {ex.ToString()}");
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadStudentData();
            CheckDatabaseConnection();
        }
    }
}