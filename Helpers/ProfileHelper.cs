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
        
        // Personal Information
        public string FullName { get; set; }
        public string Title { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Location { get; set; }
        public string Bio { get; set; }
        
        // Programming Profile
        public int Experience { get; set; }
        public int CodeforcesRating { get; set; }
        public string CodeforcesRank { get; set; }
        public int CodechefRating { get; set; }
        public string CodechefRank { get; set; }
        public int ProblemsSolved { get; set; }
        
        // Social Links
        public string GitHubUrl { get; set; }
        public string CodeforcesUrl { get; set; }
        public string LinkedInUrl { get; set; }
        public string TwitterUrl { get; set; }
        public string KaggleUrl { get; set; }
        
        // System Fields
        public bool IsActive { get; set; }
        public DateTime DateCreated { get; set; }
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
                        SELECT Id, FullName, Title, Email, Phone, Location, Bio,
                               Experience, CodeforcesRating, CodeforcesRank,
                               CodechefRating, CodechefRank, ProblemsSolved,
                               GitHubUrl, CodeforcesUrl, LinkedInUrl, TwitterUrl, KaggleUrl,
                               IsActive, DateCreated, DateModified, CreatedBy
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
                                Email = reader["Email"].ToString(),
                                Phone = reader["Phone"]?.ToString(),
                                Location = reader["Location"]?.ToString(),
                                Bio = reader["Bio"]?.ToString(),
                                Experience = reader["Experience"] == DBNull.Value ? 0 : Convert.ToInt32(reader["Experience"]),
                                CodeforcesRating = reader["CodeforcesRating"] == DBNull.Value ? 0 : Convert.ToInt32(reader["CodeforcesRating"]),
                                CodeforcesRank = reader["CodeforcesRank"]?.ToString(),
                                CodechefRating = reader["CodechefRating"] == DBNull.Value ? 0 : Convert.ToInt32(reader["CodechefRating"]),
                                CodechefRank = reader["CodechefRank"]?.ToString(),
                                ProblemsSolved = reader["ProblemsSolved"] == DBNull.Value ? 0 : Convert.ToInt32(reader["ProblemsSolved"]),
                                GitHubUrl = reader["GitHubUrl"]?.ToString(),
                                CodeforcesUrl = reader["CodeforcesUrl"]?.ToString(),
                                LinkedInUrl = reader["LinkedInUrl"]?.ToString(),
                                TwitterUrl = reader["TwitterUrl"]?.ToString(),
                                KaggleUrl = reader["KaggleUrl"]?.ToString(),
                                IsActive = Convert.ToBoolean(reader["IsActive"]),
                                DateCreated = Convert.ToDateTime(reader["DateCreated"]),
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

        public static bool UpdateProfile(Profile profile)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
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
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        AddProfileParameters(cmd, profile);
                        cmd.Parameters.AddWithValue("@Id", profile.Id);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error updating profile: {ex.Message}");
                return false;
            }
        }

        public static bool InsertProfile(Profile profile)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        INSERT INTO Profile (
                            FullName, Title, Email, Phone, Location, Bio,
                            Experience, CodeforcesRating, CodeforcesRank,
                            CodechefRating, CodechefRank, ProblemsSolved,
                            GitHubUrl, CodeforcesUrl, LinkedInUrl, TwitterUrl, KaggleUrl,
                            IsActive, CreatedBy
                        ) VALUES (
                            @FullName, @Title, @Email, @Phone, @Location, @Bio,
                            @Experience, @CodeforcesRating, @CodeforcesRank,
                            @CodechefRating, @CodechefRank, @ProblemsSolved,
                            @GitHubUrl, @CodeforcesUrl, @LinkedInUrl, @TwitterUrl, @KaggleUrl,
                            @IsActive, @CreatedBy
                        )";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        AddProfileParameters(cmd, profile);
                        cmd.Parameters.AddWithValue("@IsActive", profile.IsActive);
                        cmd.Parameters.AddWithValue("@CreatedBy", "admin");

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error inserting profile: {ex.Message}");
                return false;
            }
        }

        private static void AddProfileParameters(SqlCommand cmd, Profile profile)
        {
            cmd.Parameters.AddWithValue("@FullName", profile.FullName ?? "");
            cmd.Parameters.AddWithValue("@Title", profile.Title ?? "");
            cmd.Parameters.AddWithValue("@Email", profile.Email ?? "");
            cmd.Parameters.AddWithValue("@Phone", profile.Phone ?? "");
            cmd.Parameters.AddWithValue("@Location", profile.Location ?? "");
            cmd.Parameters.AddWithValue("@Bio", profile.Bio ?? "");
            cmd.Parameters.AddWithValue("@Experience", profile.Experience);
            cmd.Parameters.AddWithValue("@CodeforcesRating", profile.CodeforcesRating);
            cmd.Parameters.AddWithValue("@CodeforcesRank", profile.CodeforcesRank ?? "");
            cmd.Parameters.AddWithValue("@CodechefRating", profile.CodechefRating);
            cmd.Parameters.AddWithValue("@CodechefRank", profile.CodechefRank ?? "");
            cmd.Parameters.AddWithValue("@ProblemsSolved", profile.ProblemsSolved);
            cmd.Parameters.AddWithValue("@GitHubUrl", profile.GitHubUrl ?? "");
            cmd.Parameters.AddWithValue("@CodeforcesUrl", profile.CodeforcesUrl ?? "");
            cmd.Parameters.AddWithValue("@LinkedInUrl", profile.LinkedInUrl ?? "");
            cmd.Parameters.AddWithValue("@TwitterUrl", profile.TwitterUrl ?? "");
            cmd.Parameters.AddWithValue("@KaggleUrl", profile.KaggleUrl ?? "");
        }
    }
}