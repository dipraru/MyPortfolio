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

            throw new Exception("No database connection string found for messages.");
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
    }
}