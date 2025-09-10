using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MyPortfolio.Helpers
{
    public class Achievement
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public string Organization { get; set; }
        public DateTime DateAchieved { get; set; }
        public string CertificateUrl { get; set; }
        public string BadgeUrl { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }
        public int DisplayOrder { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime DateModified { get; set; }
        public string CreatedBy { get; set; }
    }

    public static class AchievementsHelper
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

            throw new Exception("No database connection string found for achievements.");
        }

        public static List<Achievement> GetAllAchievements()
        {
            var achievements = new List<Achievement>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Title, Description, Category, Organization, DateAchieved, 
                               CertificateUrl, BadgeUrl, IsVerified, IsActive, DisplayOrder, 
                               DateAdded, DateModified, CreatedBy
                        FROM Achievements 
                        WHERE IsActive = 1
                        ORDER BY DisplayOrder, DateAchieved DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            achievements.Add(new Achievement
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Title = reader["Title"].ToString(),
                                Description = reader["Description"].ToString(),
                                Category = reader["Category"].ToString(),
                                Organization = reader["Organization"]?.ToString(),
                                DateAchieved = Convert.ToDateTime(reader["DateAchieved"]),
                                CertificateUrl = reader["CertificateUrl"]?.ToString(),
                                BadgeUrl = reader["BadgeUrl"]?.ToString(),
                                IsVerified = Convert.ToBoolean(reader["IsVerified"]),
                                IsActive = Convert.ToBoolean(reader["IsActive"]),
                                DisplayOrder = Convert.ToInt32(reader["DisplayOrder"]),
                                DateAdded = Convert.ToDateTime(reader["DateAdded"]),
                                DateModified = Convert.ToDateTime(reader["DateModified"]),
                                CreatedBy = reader["CreatedBy"]?.ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting achievements: {ex.Message}");
                throw;
            }

            return achievements;
        }

        public static List<Achievement> GetAchievementsByCategory(string category)
        {
            var achievements = new List<Achievement>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Title, Description, Category, Organization, DateAchieved, 
                               CertificateUrl, BadgeUrl, IsVerified, IsActive, DisplayOrder, 
                               DateAdded, DateModified, CreatedBy
                        FROM Achievements 
                        WHERE IsActive = 1 AND Category = @Category
                        ORDER BY DisplayOrder, DateAchieved DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                        
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                achievements.Add(new Achievement
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Title = reader["Title"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    Category = reader["Category"].ToString(),
                                    Organization = reader["Organization"]?.ToString(),
                                    DateAchieved = Convert.ToDateTime(reader["DateAchieved"]),
                                    CertificateUrl = reader["CertificateUrl"]?.ToString(),
                                    BadgeUrl = reader["BadgeUrl"]?.ToString(),
                                    IsVerified = Convert.ToBoolean(reader["IsVerified"]),
                                    IsActive = Convert.ToBoolean(reader["IsActive"]),
                                    DisplayOrder = Convert.ToInt32(reader["DisplayOrder"]),
                                    DateAdded = Convert.ToDateTime(reader["DateAdded"]),
                                    DateModified = Convert.ToDateTime(reader["DateModified"]),
                                    CreatedBy = reader["CreatedBy"]?.ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting achievements by category: {ex.Message}");
                throw;
            }

            return achievements;
        }

        public static int GetAchievementsCount()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Achievements WHERE IsActive = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting achievements count: {ex.Message}");
                return 0;
            }
        }

        public static bool TestConnection()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Achievements'";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int tableCount = Convert.ToInt32(cmd.ExecuteScalar());
                        return tableCount > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Achievements database connection test failed: {ex.Message}");
                return false;
            }
        }

        public static int AddAchievement(Achievement achievement)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        INSERT INTO Achievements (Title, Description, Category, Organization, DateAchieved, CertificateUrl, BadgeUrl, DisplayOrder, CreatedBy)
                        OUTPUT INSERTED.Id
                        VALUES (@Title, @Description, @Category, @Organization, @DateAchieved, @CertificateUrl, @BadgeUrl, @DisplayOrder, @CreatedBy)";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", achievement.Title ?? "");
                        cmd.Parameters.AddWithValue("@Description", achievement.Description ?? "");
                        cmd.Parameters.AddWithValue("@Category", achievement.Category ?? "");
                        cmd.Parameters.AddWithValue("@Organization", achievement.Organization ?? "");
                        cmd.Parameters.AddWithValue("@DateAchieved", achievement.DateAchieved);
                        cmd.Parameters.AddWithValue("@CertificateUrl", achievement.CertificateUrl ?? "");
                        cmd.Parameters.AddWithValue("@BadgeUrl", achievement.BadgeUrl ?? "");
                        cmd.Parameters.AddWithValue("@DisplayOrder", achievement.DisplayOrder);
                        cmd.Parameters.AddWithValue("@CreatedBy", AuthHelper.GetCurrentUsername() ?? "admin");

                        var newId = cmd.ExecuteScalar();
                        return Convert.ToInt32(newId);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding achievement: {ex.Message}");
                throw;
            }
        }

        public static int GetNextDisplayOrder()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Achievements";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting next display order: {ex.Message}");
                return (int)(DateTime.Now.Ticks % int.MaxValue);
            }
        }
    }
}