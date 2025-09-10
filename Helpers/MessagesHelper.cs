using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace MyPortfolio.Helpers
{
    public class Message
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Subject { get; set; }
        public string MessageText { get; set; }
        public bool IsRead { get; set; }
        public bool IsReplied { get; set; }
        public bool IsArchived { get; set; }
        public string Priority { get; set; }
        public string IpAddress { get; set; }
        public string UserAgent { get; set; }
        public DateTime DateReceived { get; set; }
        public DateTime? DateRead { get; set; }
        public DateTime? DateReplied { get; set; }
        public string ReplyMessage { get; set; }
        public string AdminNotes { get; set; }
    }

    public static class MessagesHelper
    {
        private static string GetConnectionString()
        {
            try
            {
                var connString = ConfigurationManager.ConnectionStrings["AnotherDemoConnection"];
                if (connString != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Using AnotherDemoConnection: {connString.ConnectionString}");
                    return connString.ConnectionString;
                }

                var fallbackConnString = ConfigurationManager.ConnectionStrings["MyDBConnection"];
                if (fallbackConnString != null)
                {
                    System.Diagnostics.Debug.WriteLine($"Using MyDBConnection: {fallbackConnString.ConnectionString}");
                    return fallbackConnString.ConnectionString;
                }

                System.Diagnostics.Debug.WriteLine("No connection string found!");
                throw new Exception("No database connection string found for messages.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting connection string: {ex.Message}");
                throw;
            }
        }

        public static List<Message> GetAllMessages()
        {
            var messages = new List<Message>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Email, Subject, Message, IsRead, IsReplied, IsArchived, 
                               Priority, IpAddress, UserAgent, DateReceived, DateRead, DateReplied, 
                               ReplyMessage, AdminNotes
                        FROM Messages 
                        WHERE IsArchived = 0
                        ORDER BY DateReceived DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            messages.Add(new Message
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Name = reader["Name"].ToString(),
                                Email = reader["Email"].ToString(),
                                Subject = reader["Subject"].ToString(),
                                MessageText = reader["Message"].ToString(),
                                IsRead = Convert.ToBoolean(reader["IsRead"]),
                                IsReplied = Convert.ToBoolean(reader["IsReplied"]),
                                IsArchived = Convert.ToBoolean(reader["IsArchived"]),
                                Priority = reader["Priority"]?.ToString() ?? "Normal",
                                IpAddress = reader["IpAddress"]?.ToString(),
                                UserAgent = reader["UserAgent"]?.ToString(),
                                DateReceived = Convert.ToDateTime(reader["DateReceived"]),
                                DateRead = reader["DateRead"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateRead"]),
                                DateReplied = reader["DateReplied"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateReplied"]),
                                ReplyMessage = reader["ReplyMessage"]?.ToString(),
                                AdminNotes = reader["AdminNotes"]?.ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting messages: {ex.Message}");
                throw;
            }

            return messages;
        }

        public static List<Message> GetUnreadMessages()
        {
            var messages = new List<Message>();

            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Email, Subject, Message, IsRead, IsReplied, IsArchived, 
                               Priority, IpAddress, UserAgent, DateReceived, DateRead, DateReplied, 
                               ReplyMessage, AdminNotes
                        FROM Messages 
                        WHERE IsRead = 0 AND IsArchived = 0
                        ORDER BY DateReceived DESC";

                    using (var cmd = new SqlCommand(query, conn))
                    using (var reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            messages.Add(new Message
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Name = reader["Name"].ToString(),
                                Email = reader["Email"].ToString(),
                                Subject = reader["Subject"].ToString(),
                                MessageText = reader["Message"].ToString(),
                                IsRead = Convert.ToBoolean(reader["IsRead"]),
                                IsReplied = Convert.ToBoolean(reader["IsReplied"]),
                                IsArchived = Convert.ToBoolean(reader["IsArchived"]),
                                Priority = reader["Priority"]?.ToString() ?? "Normal",
                                IpAddress = reader["IpAddress"]?.ToString(),
                                UserAgent = reader["UserAgent"]?.ToString(),
                                DateReceived = Convert.ToDateTime(reader["DateReceived"]),
                                DateRead = reader["DateRead"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateRead"]),
                                DateReplied = reader["DateReplied"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateReplied"]),
                                ReplyMessage = reader["ReplyMessage"]?.ToString(),
                                AdminNotes = reader["AdminNotes"]?.ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting unread messages: {ex.Message}");
                throw;
            }

            return messages;
        }

        public static int GetUnreadMessagesCount()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Messages WHERE IsRead = 0 AND IsArchived = 0";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting unread messages count: {ex.Message}");
                return 0;
            }
        }

        public static int GetMessagesCount()
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "SELECT COUNT(*) FROM Messages WHERE IsArchived = 0";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        return Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting messages count: {ex.Message}");
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
                    
                    string query = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Messages'";
                    using (var cmd = new SqlCommand(query, conn))
                    {
                        int tableCount = Convert.ToInt32(cmd.ExecuteScalar());
                        System.Diagnostics.Debug.WriteLine($"Messages table exists: {tableCount > 0}");
                        return tableCount > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Messages database connection test failed: {ex.Message}");
                return false;
            }
        }

        public static Message GetMessageById(int id)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        SELECT Id, Name, Email, Subject, Message, IsRead, IsReplied, IsArchived, 
                               Priority, IpAddress, UserAgent, DateReceived, DateRead, DateReplied, 
                               ReplyMessage, AdminNotes
                        FROM Messages 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        
                        using (var reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                return new Message
                                {
                                    Id = Convert.ToInt32(reader["Id"]),
                                    Name = reader["Name"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    Subject = reader["Subject"].ToString(),
                                    MessageText = reader["Message"].ToString(),
                                    IsRead = Convert.ToBoolean(reader["IsRead"]),
                                    IsReplied = Convert.ToBoolean(reader["IsReplied"]),
                                    IsArchived = Convert.ToBoolean(reader["IsArchived"]),
                                    Priority = reader["Priority"]?.ToString() ?? "Normal",
                                    IpAddress = reader["IpAddress"]?.ToString(),
                                    UserAgent = reader["UserAgent"]?.ToString(),
                                    DateReceived = Convert.ToDateTime(reader["DateReceived"]),
                                    DateRead = reader["DateRead"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateRead"]),
                                    DateReplied = reader["DateReplied"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["DateReplied"]),
                                    ReplyMessage = reader["ReplyMessage"]?.ToString(),
                                    AdminNotes = reader["AdminNotes"]?.ToString()
                                };
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting message by ID: {ex.Message}");
                throw;
            }

            return null;
        }

        public static bool MarkAsRead(int messageId)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        UPDATE Messages 
                        SET IsRead = 1, DateRead = GETDATE() 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error marking message as read: {ex.Message}");
                return false;
            }
        }

        public static bool MarkAsUnread(int messageId)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        UPDATE Messages 
                        SET IsRead = 0, DateRead = NULL 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error marking message as unread: {ex.Message}");
                return false;
            }
        }

        public static bool DeleteMessage(int messageId)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    // Soft delete by marking as archived
                    string query = @"
                        UPDATE Messages 
                        SET IsArchived = 1 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error deleting message: {ex.Message}");
                return false;
            }
        }

        public static bool PermanentlyDeleteMessage(int messageId)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = "DELETE FROM Messages WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error permanently deleting message: {ex.Message}");
                return false;
            }
        }

        public static bool ArchiveMessage(int messageId)
        {
            try
            {
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    
                    string query = @"
                        UPDATE Messages 
                        SET IsArchived = 1 
                        WHERE Id = @Id";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", messageId);
                        int rowsAffected = cmd.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error archiving message: {ex.Message}");
                return false;
            }
        }

        /// <summary>
        /// Adds a new message to the database
        /// </summary>
        /// <param name="message">Message object to add</param>
        /// <returns>True if successful, false if failed</returns>
        public static bool AddMessage(Message message)
        {
            try
            {
                System.Diagnostics.Debug.WriteLine("Starting AddMessage method");
                System.Diagnostics.Debug.WriteLine($"Message details: Name={message.Name}, Email={message.Email}, Subject={message.Subject}");
                
                using (var conn = new SqlConnection(GetConnectionString()))
                {
                    System.Diagnostics.Debug.WriteLine("Opening database connection");
                    conn.Open();
                    System.Diagnostics.Debug.WriteLine("Database connection opened successfully");
                    
                    string query = @"
                        INSERT INTO Messages (Name, Email, Subject, Message, Priority, IsRead, IsReplied, IsArchived, 
                                            IpAddress, UserAgent, DateReceived, AdminNotes)
                        VALUES (@Name, @Email, @Subject, @Message, @Priority, @IsRead, @IsReplied, @IsArchived, 
                                @IpAddress, @UserAgent, @DateReceived, @AdminNotes)";

                    using (var cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", message.Name ?? "");
                        cmd.Parameters.AddWithValue("@Email", message.Email ?? "");
                        cmd.Parameters.AddWithValue("@Subject", message.Subject ?? "");
                        cmd.Parameters.AddWithValue("@Message", message.MessageText ?? "");
                        cmd.Parameters.AddWithValue("@Priority", message.Priority ?? "Normal");
                        cmd.Parameters.AddWithValue("@IsRead", message.IsRead);
                        cmd.Parameters.AddWithValue("@IsReplied", message.IsReplied);
                        cmd.Parameters.AddWithValue("@IsArchived", message.IsArchived);
                        cmd.Parameters.AddWithValue("@IpAddress", message.IpAddress ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@UserAgent", message.UserAgent ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@DateReceived", message.DateReceived);
                        cmd.Parameters.AddWithValue("@AdminNotes", message.AdminNotes ?? (object)DBNull.Value);

                        System.Diagnostics.Debug.WriteLine("Executing SQL command");
                        int rowsAffected = cmd.ExecuteNonQuery();
                        System.Diagnostics.Debug.WriteLine($"Rows affected: {rowsAffected}");
                        
                        bool success = rowsAffected > 0;
                        System.Diagnostics.Debug.WriteLine($"AddMessage result: {success}");
                        return success;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error adding message: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                return false;
            }
        }
    }
}