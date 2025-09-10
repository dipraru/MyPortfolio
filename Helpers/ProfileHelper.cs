using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MyPortfolio.Helpers
{
    public class Profile
    {
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Title { get; set; }
        public string Bio { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Location { get; set; }
        public string ProfileImageUrl { get; set; }
        public string ResumeUrl { get; set; }
        public string LinkedInUrl { get; set; }
        public string GitHubUrl { get; set; }
        public string TwitterUrl { get; set; }
        public string WebsiteUrl { get; set; }
        public int? YearsOfExperience { get; set; }
        public string CurrentCompany { get; set; }
        public string CurrentPosition { get; set; }
        public bool IsPublic { get; set; }
        public bool IsActive { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime DateModified { get; set; }
        public string CreatedBy { get; set; }
    }

    public static class ProfileHelper
    {
        private static string GetConnectionString()
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

            throw new Exception("No database connection string found for profile.");
        }

        public static Profile GetActiveProfile()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, FullName, Title, Bio, Email, Phone, Location, ProfileImageUrl, 
                               ResumeUrl, LinkedInUrl, GitHubUrl, TwitterUrl, WebsiteUrl, 
                               YearsOfExperience, CurrentCompany, CurrentPosition, IsPublic, 
                               IsActive, DateAdded, DateModified, CreatedBy
                        FROM Profile 
                        WHERE IsActive = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Profile
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                FullName = reader["FullName"].ToString(),
                                Title = reader["Title"].ToString(),
                                Bio = reader["Bio"].ToString(),
                                Email = reader["Email"].ToString(),
                                Phone = reader["Phone"]?.ToString(),
                                Location = reader["Location"]?.ToString(),
                                ProfileImageUrl = reader["ProfileImageUrl"]?.ToString(),
                                ResumeUrl = reader["ResumeUrl"]?.ToString(),
                                LinkedInUrl = reader["LinkedInUrl"]?.ToString(),
                                GitHubUrl = reader["GitHubUrl"]?.ToString(),
                                TwitterUrl = reader["TwitterUrl"]?.ToString(),
                                WebsiteUrl = reader["WebsiteUrl"]?.ToString(),
                                YearsOfExperience = reader["YearsOfExperience"] == DBNull.Value ? (int?)null : Convert.ToInt32(reader["YearsOfExperience"]),
                                CurrentCompany = reader["CurrentCompany"]?.ToString(),
                                CurrentPosition = reader["CurrentPosition"]?.ToString(),
                                IsPublic = Convert.ToBoolean(reader["IsPublic"]),
                                IsActive = Convert.ToBoolean(reader["IsActive"]),
                                DateAdded = Convert.ToDateTime(reader["DateAdded"]),
                                DateModified = Convert.ToDateTime(reader["DateModified"]),
                                CreatedBy = reader["CreatedBy"]?.ToString()
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting active profile: {ex.Message}");
                throw;
            }

            return null;
        }

        public static bool HasActiveProfile()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Profile WHERE IsActive = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        return count > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error checking for active profile: {ex.Message}");
                return false;
            }
        }

        public static bool TestConnection()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Profile'";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int tableCount = Convert.ToInt32(cmd.ExecuteScalar());
                        return tableCount > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Profile database connection test failed: {ex.Message}");
                return false;
            }
        }
    }
}