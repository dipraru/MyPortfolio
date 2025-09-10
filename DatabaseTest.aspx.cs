using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.IO;
using System.Web;

namespace MyPortfolio
{
    public partial class DatabaseTest : Page
    {
        private string GetConnectionString()
        {
            // Get connection string from web.config
            return ConfigurationManager.ConnectionStrings["MyDBConnection"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckDatabaseConnection();
                LoadTestData();
            }
        }

        private void CheckDatabaseConnection()
        {
            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Create table if it doesn't exist - matching user's requirements
                    string createTableSql = @"
                        IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test')
                        CREATE TABLE test (
                            name nvarchar(100) PRIMARY KEY,
                            address nvarchar(500)
                        )";
                    
                    using (var command = new SqlCommand(createTableSql, connection))
                    {
                        command.ExecuteNonQuery();
                    }

                    lblConnectionStatus.Text = "✅ Database Connected Successfully";
                    lblConnectionStatus.CssClass = "badge bg-success fs-6 mb-3";
                    lblMessage.Text = "Database connection established and 'test' table is ready.";
                    lblMessage.CssClass = "text-success";
                }
            }
            catch (Exception ex)
            {
                lblConnectionStatus.Text = "❌ Database Connection Failed";
                lblConnectionStatus.CssClass = "badge bg-danger fs-6 mb-3";
                lblMessage.Text = $"Error: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                
                // Log more details for debugging
                System.Diagnostics.Debug.WriteLine($"Database connection error: {ex.ToString()}");
            }
        }

        private void LoadTestData()
        {
            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if table exists first
                    string checkTableSql = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'test'";
                    using (var checkCommand = new SqlCommand(checkTableSql, connection))
                    {
                        int tableExists = (int)checkCommand.ExecuteScalar();
                        if (tableExists == 0)
                        {
                            // Table doesn't exist yet, create it
                            CheckDatabaseConnection();
                            return;
                        }
                    }
                    
                    string selectSql = "SELECT name, address FROM test ORDER BY name";
                    using (var command = new SqlCommand(selectSql, connection))
                    {
                        using (var adapter = new SqlDataAdapter(command))
                        {
                            var dataTable = new DataTable();
                            adapter.Fill(dataTable);
                            gvTestData.DataSource = dataTable;
                            gvTestData.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error loading data: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                System.Diagnostics.Debug.WriteLine($"Load data error: {ex.ToString()}");
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblMessage.Text = "Please enter a name.";
                lblMessage.CssClass = "text-warning";
                return;
            }

            try
            {
                string connectionString = GetConnectionString();
                
                using (var connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    
                    // Check if name already exists (since it's primary key)
                    string checkSql = "SELECT COUNT(*) FROM test WHERE name = @Name";
                    using (var checkCommand = new SqlCommand(checkSql, connection))
                    {
                        checkCommand.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        int exists = (int)checkCommand.ExecuteScalar();
                        
                        if (exists > 0)
                        {
                            lblMessage.Text = "⚠️ A record with this name already exists. Names must be unique.";
                            lblMessage.CssClass = "text-warning";
                            return;
                        }
                    }
                    
                    string insertSql = "INSERT INTO test (name, address) VALUES (@Name, @Address)";
                    using (var command = new SqlCommand(insertSql, connection))
                    {
                        command.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        command.Parameters.AddWithValue("@Address", string.IsNullOrWhiteSpace(txtAddress.Text) ? (object)DBNull.Value : txtAddress.Text.Trim());
                        
                        command.ExecuteNonQuery();
                    }

                    lblMessage.Text = "✅ Data saved successfully to database!";
                    lblMessage.CssClass = "text-success";

                    // Clear form
                    txtName.Text = "";
                    txtAddress.Text = "";

                    // Refresh data
                    LoadTestData();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error saving data: {ex.Message}";
                lblMessage.CssClass = "text-danger";
                System.Diagnostics.Debug.WriteLine($"Save data error: {ex.ToString()}");
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadTestData();
            CheckDatabaseConnection();
        }
    }
}