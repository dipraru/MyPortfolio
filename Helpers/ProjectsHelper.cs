using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MyPortfolio.Helpers
{
    public class Project
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
        public string Tags { get; set; }
        public string GitHubUrl { get; set; }
        public string LiveDemoUrl { get; set; }
        public bool IsActive { get; set; }
        public int DisplayOrder { get; set; }
        public DateTime DateAdded { get; set; }
        public DateTime DateModified { get; set; }
        public string CreatedBy { get; set; }

        // Get tags as array
        public string[] GetTagsArray()
        {
            if (string.IsNullOrEmpty(Tags))
                return new string[0];
            
            return Tags.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
        }

        // Set tags from array
        public void SetTagsFromArray(string[] tags)
        {
            if (tags != null && tags.Length > 0)
            {
                Tags = string.Join(",", tags);
            }
            else
            {
                Tags = "";
            }
        }
    }

    public static class ProjectsHelper
    {
        /// <summary>
        /// Get the connection string for projects database (SQLEXPRESS)
        /// </summary>
        private static string GetConnectionString()
        {
            // Use AnotherDemoConnection (SQLEXPRESS) for projects
            var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
            if (connString != null)
            {
                return connString.ConnectionString;
            }

            // Fallback to MyDBConnection if needed
            var fallbackConnString = ConfigurationManager.ConnectionStrings["MyDBConnection"];
            if (fallbackConnString != null)
            {
                return fallbackConnString.ConnectionString;
            }

            throw new Exception("No database connection string found for projects.");
        }

        /// <summary>
        /// Get all active projects ordered by display order
        /// </summary>
        public static List<Project> GetAllProjects()
        {
            var projects = new List<Project>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Title, Description, ImageUrl, Tags, GitHubUrl, LiveDemoUrl, 
                               IsActive, DisplayOrder, DateAdded, DateModified, CreatedBy
                        FROM Projects 
                        WHERE IsActive = 1
                        ORDER BY DisplayOrder, DateAdded DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            projects.Add(new Project
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Title = reader["Title"].ToString(),
                                Description = reader["Description"].ToString(),
                                ImageUrl = reader["ImageUrl"]?.ToString(),
                                Tags = reader["Tags"]?.ToString(),
                                GitHubUrl = reader["GitHubUrl"]?.ToString(),
                                LiveDemoUrl = reader["LiveDemoUrl"]?.ToString(),
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
                System.Diagnostics.Debug.WriteLine($"Error getting projects: {ex.Message}");
                throw;
            }

            return projects;
        }

        /// <summary>
        /// Get project by ID
        /// </summary>
        public static Project GetProjectById(int id)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Title, Description, ImageUrl, Tags, GitHubUrl, LiveDemoUrl, 
                               IsActive, DisplayOrder, DateAdded, DateModified, CreatedBy
                        FROM Projects 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return new Project
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Title = reader["Title"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    ImageUrl = reader["ImageUrl"]?.ToString(),
                                    Tags = reader["Tags"]?.ToString(),
                                    GitHubUrl = reader["GitHubUrl"]?.ToString(),
                                    LiveDemoUrl = reader["LiveDemoUrl"]?.ToString(),
                                    IsActive = Convert.ToBoolean(reader["IsActive"]),
                                    DisplayOrder = Convert.ToInt32(reader["DisplayOrder"]),
                                    DateAdded = Convert.ToDateTime(reader["DateAdded"]),
                                    DateModified = Convert.ToDateTime(reader["DateModified"]),
                                    CreatedBy = reader["CreatedBy"]?.ToString()
                                };
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting project by ID: {ex.Message}");
                throw;
            }

            return null;
        }

        /// <summary>
        /// Add new project
        /// </summary>
        public static int AddProject(Project project)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        INSERT INTO Projects (Title, Description, ImageUrl, Tags, GitHubUrl, LiveDemoUrl, DisplayOrder, CreatedBy)
                        OUTPUT INSERTED.Id
                        VALUES (@Title, @Description, @ImageUrl, @Tags, @GitHubUrl, @LiveDemoUrl, @DisplayOrder, @CreatedBy)";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Title", project.Title ?? "");
                        cmd.Parameters.AddWithValue("@Description", project.Description ?? "");
                        cmd.Parameters.AddWithValue("@ImageUrl", project.ImageUrl ?? "");
                        cmd.Parameters.AddWithValue("@Tags", project.Tags ?? "");
                        cmd.Parameters.AddWithValue("@GitHubUrl", project.GitHubUrl ?? "");
                        cmd.Parameters.AddWithValue("@LiveDemoUrl", project.LiveDemoUrl ?? "");
                        cmd.Parameters.AddWithValue("@DisplayOrder", project.DisplayOrder);
                        cmd.Parameters.AddWithValue("@CreatedBy", AuthHelper.GetCurrentUsername() ?? "admin");

                        var newId = cmd.ExecuteScalar();
                        return Convert.ToInt32(newId);
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding project: {ex.Message}");
                throw;
            }
        }

        /// <summary>
        /// Update existing project
        /// </summary>
        public static bool UpdateProject(Project project)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        UPDATE Projects 
                        SET Title = @Title, 
                            Description = @Description, 
                            ImageUrl = @ImageUrl, 
                            Tags = @Tags, 
                            GitHubUrl = @GitHubUrl, 
                            LiveDemoUrl = @LiveDemoUrl, 
                            DisplayOrder = @DisplayOrder,
                            DateModified = GETDATE()
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", project.Id);
                        cmd.Parameters.AddWithValue("@Title", project.Title ?? "");
                        cmd.Parameters.AddWithValue("@Description", project.Description ?? "");
                        cmd.Parameters.AddWithValue("@ImageUrl", project.ImageUrl ?? "");
                        cmd.Parameters.AddWithValue("@Tags", project.Tags ?? "");
                        cmd.Parameters.AddWithValue("@GitHubUrl", project.GitHubUrl ?? "");
                        cmd.Parameters.AddWithValue("@LiveDemoUrl", project.LiveDemoUrl ?? "");
                        cmd.Parameters.AddWithValue("@DisplayOrder", project.DisplayOrder);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error updating project: {ex.Message}");
                throw;
            }
        }

        /// <summary>
        /// Delete project (soft delete - set IsActive to false) and optionally reorder remaining projects
        /// </summary>
        public static bool DeleteProject(int id, bool reorderAfterDelete = true)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        UPDATE Projects 
                        SET IsActive = 0, DateModified = GETDATE()
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);

                        int rowsAffected = cmd.ExecuteNonQuery();
                        
                        // Automatically reorder after deletion to prevent gaps
                        if (rowsAffected > 0 && reorderAfterDelete)
                        {
                            ReorderDisplayOrders();
                        }
                        
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error deleting project: {ex.Message}");
                throw;
            }
        }

        /// <summary>
        /// Delete project (backward compatibility overload)
        /// </summary>
        public static bool DeleteProject(int id)
        {
            return DeleteProject(id, true); // Auto-reorder by default
        }

        /// <summary>
        /// Get projects count for dashboard stats
        /// </summary>
        public static int GetProjectsCount()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Projects WHERE IsActive = 1";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting projects count: {ex.Message}");
                return 0;
            }
        }

        /// <summary>
        /// Test database connection
        /// </summary>
        public static bool TestConnection()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Check if Projects table exists
                    string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Projects'";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int tableCount = Convert.ToInt32(cmd.ExecuteScalar());
                        return tableCount > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Projects database connection test failed: {ex.Message}");
                return false;
            }
        }

        /// <summary>
        /// Get the next available display order for new projects
        /// </summary>
        public static int GetNextDisplayOrder()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Get the maximum DisplayOrder from all projects (including inactive ones)
                    string query = "SELECT ISNULL(MAX(DisplayOrder), 0) + 1 FROM Projects";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting next display order: {ex.Message}");
                // Fallback: use current time ticks to ensure uniqueness
                return (int)(DateTime.Now.Ticks % int.MaxValue);
            }
        }

        /// <summary>
        /// Reorder display orders to remove gaps (optional maintenance function)
        /// </summary>
        public static bool ReorderDisplayOrders()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Get all active projects ordered by current DisplayOrder
                    string selectQuery = @"
                        SELECT Id 
                        FROM Projects 
                        WHERE IsActive = 1 
                        ORDER BY DisplayOrder, DateAdded";
                    
                    var projectIds = new List<int>();
                    using (var cmd = new SqlCommand(selectQuery, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            projectIds.Add(Convert.ToInt32(reader["Id"]));
                        }
                    }
                    
                    // Update DisplayOrder to sequential numbers starting from 1
                    for (int i = 0; i < projectIds.Count; i++)
                    {
                        string updateQuery = "UPDATE Projects SET DisplayOrder = @DisplayOrder WHERE Id = @Id";
                        using (var cmd = new SqlCommand(updateQuery, conn))
                        {
                            cmd.Parameters.AddWithValue("@DisplayOrder", i + 1);
                            cmd.Parameters.AddWithValue("@Id", projectIds[i]);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    
                    return true;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error reordering display orders: {ex.Message}");
                return false;
            }
        }
    }
}