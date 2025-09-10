using System;
using System.Web.UI;
using System.Web.Services;
using System.Web.Script.Serialization;
using MyPortfolio.Helpers;

namespace MyPortfolio
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load dynamic content from database if needed
                // The frontend remains the same, but you can enhance this later
                // to load projects, skills, and achievements from the database
                
                // For now, the page loads with static content as designed
                // Future enhancement: LoadDynamicContent();
            }
        }

        [WebMethod]
        public static string SendContactMessage(string name, string email, string subject, string message)
        {
            var response = new { success = false, message = "" };
            
            try
            {
                // Validate input
                if (string.IsNullOrWhiteSpace(name))
                {
                    response = new { success = false, message = "Name is required." };
                    return new JavaScriptSerializer().Serialize(response);
                }
                
                if (string.IsNullOrWhiteSpace(email))
                {
                    response = new { success = false, message = "Email is required." };
                    return new JavaScriptSerializer().Serialize(response);
                }
                
                if (string.IsNullOrWhiteSpace(message))
                {
                    response = new { success = false, message = "Message is required." };
                    return new JavaScriptSerializer().Serialize(response);
                }
                
                // Create message object
                var messageObj = new Message
                {
                    Name = name.Trim(),
                    Email = email.Trim(),
                    Subject = string.IsNullOrWhiteSpace(subject) ? "Contact Form Submission" : subject.Trim(),
                    MessageText = message.Trim(),
                    DateReceived = DateTime.Now,
                    IsRead = false,
                    IsReplied = false,
                    IsArchived = false,
                    Priority = "Normal",
                    IpAddress = GetClientIpAddress(),
                    UserAgent = System.Web.HttpContext.Current.Request.UserAgent ?? "Unknown"
                };
                
                // Insert message into database
                bool success = MessagesHelper.AddMessage(messageObj);
                
                if (success)
                {
                    response = new { success = true, message = "Message sent successfully!" };
                }
                else
                {
                    response = new { success = false, message = "Failed to send message. Please try again later." };
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SendContactMessage: {ex.Message}");
                response = new { success = false, message = "An error occurred while sending your message. Please try again later." };
            }
            
            return new JavaScriptSerializer().Serialize(response);
        }
        
        private static string GetClientIpAddress()
        {
            try
            {
                var context = System.Web.HttpContext.Current;
                if (context == null) return "Unknown";
                
                var request = context.Request;
                
                // Check for IP address from proxy
                string ipAddress = request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                if (string.IsNullOrEmpty(ipAddress) || ipAddress.ToLower() == "unknown")
                {
                    ipAddress = request.ServerVariables["HTTP_X_REAL_IP"];
                }

                if (string.IsNullOrEmpty(ipAddress) || ipAddress.ToLower() == "unknown")
                {
                    ipAddress = request.ServerVariables["REMOTE_ADDR"];
                }

                if (string.IsNullOrEmpty(ipAddress))
                {
                    ipAddress = request.UserHostAddress;
                }

                // Handle multiple IPs (take the first one)
                if (!string.IsNullOrEmpty(ipAddress) && ipAddress.Contains(","))
                {
                    ipAddress = ipAddress.Split(',')[0].Trim();
                }

                return ipAddress ?? "Unknown";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error getting IP address: {ex.Message}");
                return "Unknown";
            }
        }

        // Future method to load dynamic content
        // private void LoadDynamicContent()
        // {
        //     // Load projects from database
        //     // Load skills from database  
        //     // Load achievements from database
        //     // Update the frontend accordingly
        // }
    }
}