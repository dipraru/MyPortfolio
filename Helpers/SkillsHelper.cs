using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MyPortfolio.Helpers
{
    public class Skill
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public int ProficiencyPercentage { get; set; } // Changed from ProficiencyLevel to ProficiencyPercentage (0-100)
        public decimal? YearsOfExperience { get; set; }
        public string IconClass { get; set; }
        public string IconColor { get; set; }
        public bool IsActive { get; set; }
        public int DisplayOrder { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime DateModified { get; set; }
        public string CreatedBy { get; set; }

        // Helper property to get proficiency as formatted string
        public string ProficiencyDisplay => $"{ProficiencyPercentage}%";
        
        // Helper property to get proficiency level name
        public string ProficiencyLevelName
        {
            get
            {
                if (ProficiencyPercentage >= 90) return "Expert";
                if (ProficiencyPercentage >= 75) return "Advanced";
                if (ProficiencyPercentage >= 60) return "Intermediate";
                if (ProficiencyPercentage >= 40) return "Basic";
                return "Beginner";
            }
        }
    }

    public static class SkillsHelper
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

            throw new Exception("No database connection string found for skills.");
        }

        public static List<Skill> GetAllSkills()
        {
            var skills = new List<Skill>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Description, Category, ProficiencyLevel, YearsOfExperience, 
                               IconClass, IconColor, IsActive, DisplayOrder, DateAdded, DateModified, CreatedBy
                        FROM Skills 
                        WHERE IsActive = 1
                        ORDER BY DisplayOrder, DateAdded DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            skills.Add(new Skill
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Name = reader["Name"].ToString(),
                                Description = reader["Description"]?.ToString(),
                                Category = reader["Category"].ToString(),
                                ProficiencyPercentage = Convert.ToInt32(reader["ProficiencyLevel"]), // Still using ProficiencyLevel column name in DB
                                YearsOfExperience = reader["YearsOfExperience"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(reader["YearsOfExperience"]),
                                IconClass = reader["IconClass"]?.ToString(),
                                IconColor = reader["IconColor"]?.ToString(),
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
                System.Diagnostics.Debug.WriteLine($"Error getting skills: {ex.Message}");
                throw;
            }

            return skills;
        }

        public static List<Skill> GetSkillsByCategory(string category)
        {
            var skills = new List<Skill>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Description, Category, ProficiencyLevel, YearsOfExperience, 
                               IconClass, IconColor, IsActive, DisplayOrder, DateAdded, DateModified, CreatedBy
                        FROM Skills 
                        WHERE IsActive = 1 AND Category = @Category
                        ORDER BY DisplayOrder, DateAdded DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Category", category);
                        
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                skills.Add(new Skill
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Name = reader["Name"].ToString(),
                                    Description = reader["Description"]?.ToString(),
                                    Category = reader["Category"].ToString(),
                                    ProficiencyPercentage = Convert.ToInt32(reader["ProficiencyLevel"]), // Still using ProficiencyLevel column name in DB
                                    YearsOfExperience = reader["YearsOfExperience"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(reader["YearsOfExperience"]),
                                    IconClass = reader["IconClass"]?.ToString(),
                                    IconColor = reader["IconColor"]?.ToString(),
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
                System.Diagnostics.Debug.WriteLine($"Error getting skills by category: {ex.Message}");
                throw;
            }

            return skills;
        }

        public static List<Skill> GetSkillsByProficiencyRange(int minPercentage, int maxPercentage)
        {
            var skills = new List<Skill>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Description, Category, ProficiencyLevel, YearsOfExperience, 
                               IconClass, IconColor, IsActive, DisplayOrder, DateAdded, DateModified, CreatedBy
                        FROM Skills 
                        WHERE IsActive = 1 AND ProficiencyLevel >= @MinPercentage AND ProficiencyLevel <= @MaxPercentage
                        ORDER BY ProficiencyLevel DESC, DisplayOrder";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@MinPercentage", minPercentage);
                        cmd.Parameters.AddWithValue("@MaxPercentage", maxPercentage);
                        
                        using (var reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                skills.Add(new Skill
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Name = reader["Name"].ToString(),
                                    Description = reader["Description"]?.ToString(),
                                    Category = reader["Category"].ToString(),
                                    ProficiencyPercentage = Convert.ToInt32(reader["ProficiencyLevel"]),
                                    YearsOfExperience = reader["YearsOfExperience"] == DBNull.Value ? (decimal?)null : Convert.ToDecimal(reader["YearsOfExperience"]),
                                    IconClass = reader["IconClass"]?.ToString(),
                                    IconColor = reader["IconColor"]?.ToString(),
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
                System.Diagnostics.Debug.WriteLine($"Error getting skills by proficiency range: {ex.Message}");
                throw;
            }

            return skills;
        }

        public static int GetSkillsCount()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Skills WHERE IsActive = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting skills count: {ex.Message}");
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
                    
                    string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Skills'";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int tableCount = Convert.ToInt32(cmd.ExecuteScalar());
                        return tableCount > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Skills database connection test failed: {ex.Message}");
                return false;
            }
        }

        public static int AddSkill(Skill skill)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        INSERT INTO Skills (Name, Description, Category, ProficiencyLevel, YearsOfExperience, IconClass, IconColor, DisplayOrder, CreatedBy)
                        OUTPUT INSERTED.Id
                        VALUES (@Name, @Description, @Category, @ProficiencyLevel, @YearsOfExperience, @IconClass, @IconColor, @DisplayOrder, @CreatedBy)";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", skill.Name ?? "");
                        cmd.Parameters.AddWithValue("@Description", skill.Description ?? "");
                        cmd.Parameters.AddWithValue("@Category", skill.Category ?? "");
                        cmd.Parameters.AddWithValue("@ProficiencyLevel", skill.ProficiencyPercentage);
                        cmd.Parameters.AddWithValue("@YearsOfExperience", skill.YearsOfExperience.HasValue ? (object)skill.YearsOfExperience.Value : DBNull.Value);
                        cmd.Parameters.AddWithValue("@IconClass", skill.IconClass ?? "");
                        cmd.Parameters.AddWithValue("@IconColor", skill.IconColor ?? "");
                        cmd.Parameters.AddWithValue("@DisplayOrder", skill.DisplayOrder);
                        cmd.Parameters.AddWithValue("@CreatedBy", AuthHelper.GetCurrentUsername() ?? "admin");

                        var newId = cmd.ExecuteScalar();
                        return Convert.ToInt32(newId);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding skill: {ex.Message}");
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
                    
                    string query = "SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Skills";

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