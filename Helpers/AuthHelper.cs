using System;
using System.Data.SqlClient;
using System.Web;
using System.Configuration;

namespace MyPortfolio.Helpers
{
    public static class AuthHelper
    {
        private const string AdminSessionKey = "IsAdminAuthenticated";
        private const string AdminUsernameKey = "AdminUsername";
        private const string AdminUserIdKey = "AdminUserId";

        /// <summary>
        /// Get the connection string for authentication - Uses SQLEXPRESS only
        /// </summary>
        private static string GetAuthConnectionString()
        {
            // Use AnotherDemoConnection (SQLEXPRESS) as primary choice
            var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
            if (connString != null)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connString.ConnectionString))
                    {
                        conn.Open();
                        
                        // Test if AdminUsers table exists in anotherDemo
                        string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AdminUsers'";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            int tableCount = (int)cmd.ExecuteScalar();
                            if (tableCount > 0)
                            {
                                return connString.ConnectionString; // Found AdminUsers table
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"AnotherDemoConnection failed: {ex.Message}");
                }
            }

            // Fallback to MyDBConnection if needed
            var fallbackConnString = ConfigurationManager.ConnectionStrings["MyDBConnection"];
            if (fallbackConnString != null)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(fallbackConnString.ConnectionString))
                    {
                        conn.Open();
                        return fallbackConnString.ConnectionString;
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine($"MyDBConnection fallback failed: {ex.Message}");
                }
            }
            
            return null; // No working SQLEXPRESS connection
        }

        /// <summary>
        /// Check if the current user is authenticated
        /// </summary>
        public static bool IsAuthenticated()
        {
            try
            {
                // Check if session exists and has the authentication key
                if (HttpContext.Current?.Session?[AdminSessionKey] != null)
                {
                    // Make sure it's explicitly true (not just present)
                    return (bool)HttpContext.Current.Session[AdminSessionKey] == true;
                }
                return false;
            }
            catch
            {
                // If any error occurs, consider not authenticated
                return false;
            }
        }

        /// <summary>
        /// Attempt to log in with provided credentials from database
        /// </summary>
        public static bool Login(string username, string password)
        {
            try
            {
                string connectionString = GetAuthConnectionString();
                
                if (!string.IsNullOrEmpty(connectionString))
                {
                    // Try database authentication from SQLEXPRESS
                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        conn.Open();
                        
                        string query = @"SELECT Id, Username, Email, FullName, IsActive 
                                       FROM AdminUsers 
                                       WHERE Username = @Username 
                                       AND Password = @Password 
                                       AND IsActive = 1";
                        
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@Username", username);
                            cmd.Parameters.AddWithValue("@Password", password);
                            
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // Successful database authentication
                                    int userId = Convert.ToInt32(reader["Id"]);
                                    string userFullName = reader["FullName"]?.ToString() ?? username;
                                    
                                    // Set session variables for successful login
                                    SetAuthSession(userId, username, userFullName);
                                    
                                    // Update last login (close reader first)
                                    reader.Close();
                                    UpdateLastLogin(userId, connectionString);
                                    
                                    System.Diagnostics.Debug.WriteLine($"Database login successful for: {username}");
                                    return true;
                                }
                                else
                                {
                                    System.Diagnostics.Debug.WriteLine($"Database login failed - user not found: {username}");
                                }
                            }
                        }
                    }
                }
                else
                {
                    System.Diagnostics.Debug.WriteLine("No database connection available");
                }
                
                // Fallback authentication if database fails
                System.Diagnostics.Debug.WriteLine("Trying fallback authentication");
                return FallbackAuthentication(username, password);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
                // Fallback authentication on any error
                return FallbackAuthentication(username, password);
            }
        }

        /// <summary>
        /// Fallback authentication when database is not available
        /// </summary>
        private static bool FallbackAuthentication(string username, string password)
        {
            if (string.Equals(username, "admin", StringComparison.OrdinalIgnoreCase) && 
                password == "admin123")
            {
                SetAuthSession(1, username, "Administrator (Fallback)");
                System.Diagnostics.Debug.WriteLine("Fallback authentication successful");
                return true;
            }
            System.Diagnostics.Debug.WriteLine("Fallback authentication failed");
            return false;
        }

        /// <summary>
        /// Set authentication session variables
        /// </summary>
        private static void SetAuthSession(int userId, string username, string fullName)
        {
            HttpContext.Current.Session[AdminSessionKey] = true;
            HttpContext.Current.Session[AdminUsernameKey] = username;
            HttpContext.Current.Session[AdminUserIdKey] = userId;
            HttpContext.Current.Session["AdminFullName"] = fullName;
            HttpContext.Current.Session.Timeout = 30; // 30 minutes timeout
            
            System.Diagnostics.Debug.WriteLine($"Session set for user: {username} (ID: {userId})");
        }

        /// <summary>
        /// Update last login time in database
        /// </summary>
        private static void UpdateLastLogin(int userId, string connectionString)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    string updateQuery = "UPDATE AdminUsers SET LastLogin = @LastLogin WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@LastLogin", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Id", userId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Failed to update last login: {ex.Message}");
            }
        }

        /// <summary>
        /// Test if authentication database is available
        /// </summary>
        public static bool TestDatabaseConnection()
        {
            try
            {
                string connectionString = GetAuthConnectionString();
                return !string.IsNullOrEmpty(connectionString);
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Get status message for authentication system
        /// </summary>
        public static string GetAuthStatus()
        {
            try
            {
                string connectionString = GetAuthConnectionString();
                if (!string.IsNullOrEmpty(connectionString))
                {
                    return "Database authentication ready (SQLEXPRESS)";
                }
                else
                {
                    return "Using fallback authentication (admin/admin123)";
                }
            }
            catch (Exception ex)
            {
                return $"Authentication error: {ex.Message}";
            }
        }

        /// <summary>
        /// Log out the current user
        /// </summary>
        public static void Logout()
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("User logging out - clearing all session data");
                
                if (HttpContext.Current?.Session != null)
                {
                    // Clear specific session keys first
                    HttpContext.Current.Session[AdminSessionKey] = false; // Explicitly set to false
                    HttpContext.Current.Session[AdminUsernameKey] = null;
                    HttpContext.Current.Session[AdminUserIdKey] = null;
                    HttpContext.Current.Session["AdminFullName"] = null;
                    
                    // Clear and abandon session
                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.Abandon();
                }
                
                // Clear any authentication cookies
                if (HttpContext.Current?.Response != null)
                {
                    var rememberMeCookie = new System.Web.HttpCookie("RememberMe", "");
                    rememberMeCookie.Expires = DateTime.Now.AddDays(-1);
                    HttpContext.Current.Response.Cookies.Add(rememberMeCookie);
                }
                
                System.Diagnostics.Debug.WriteLine("Logout completed successfully");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Logout error: {ex.Message}");
            }
        }

        /// <summary>
        /// Require authentication - redirect to login if not authenticated
        /// </summary>
        public static void RequireAuthentication()
        {
            if (!IsAuthenticated())
            {
                System.Diagnostics.Debug.WriteLine("Authentication required - redirecting to login");
                HttpContext.Current.Response.Redirect("~/admin_login.aspx");
            }
        }

        /// <summary>
        /// Get the current authenticated username
        /// </summary>
        public static string GetCurrentUsername()
        {
            if (IsAuthenticated())
            {
                return HttpContext.Current.Session[AdminUsernameKey]?.ToString();
            }
            return null;
        }

        /// <summary>
        /// Get the current authenticated user ID
        /// </summary>
        public static int GetCurrentUserId()
        {
            if (IsAuthenticated() && HttpContext.Current.Session[AdminUserIdKey] != null)
            {
                return (int)HttpContext.Current.Session[AdminUserIdKey];
            }
            return 0;
        }
    }
}