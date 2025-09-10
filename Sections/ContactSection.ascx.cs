using System;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class ContactSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Contact section logic if needed
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                // Hide previous messages
                pnlSuccess.Visible = false;
                pnlError.Visible = false;

                // Validate the form
                Page.Validate("ContactForm");
                if (!Page.IsValid)
                {
                    ShowError("Please fill in all required fields correctly.");
                    return;
                }

                // Additional validation
                if (string.IsNullOrWhiteSpace(txtName.Text))
                {
                    ShowError("Name is required.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    ShowError("Email is required.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtMessage.Text))
                {
                    ShowError("Message is required.");
                    return;
                }

                // Create message object
                var message = new Message
                {
                    Name = txtName.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Subject = string.IsNullOrEmpty(txtSubject.Text.Trim()) ? "Contact Form Submission" : txtSubject.Text.Trim(),
                    MessageText = txtMessage.Text.Trim(),
                    DateReceived = DateTime.Now,
                    IsRead = false,
                    IsReplied = false,
                    IsArchived = false, // Explicitly set this
                    Priority = "Normal",
                    IpAddress = GetClientIpAddress(),
                    UserAgent = Request.UserAgent ?? "Unknown"
                };

                // Debug logging
                System.Diagnostics.Debug.WriteLine($"Attempting to save message: Name={message.Name}, Email={message.Email}");

                // Insert message into database
                bool success = MessagesHelper.AddMessage(message);

                System.Diagnostics.Debug.WriteLine($"Message save result: {success}");

                if (success)
                {
                    // Success - show success message and clear form
                    pnlSuccess.Visible = true;
                    ClearForm();
                    System.Diagnostics.Debug.WriteLine("Message saved successfully and form cleared");
                }
                else
                {
                    // Database insertion failed
                    ShowError("Failed to send message. Please try again later.");
                    System.Diagnostics.Debug.WriteLine("Database insertion failed");
                }
            }
            catch (Exception ex)
            {
                // Log error and show user-friendly message
                System.Diagnostics.Debug.WriteLine($"Error in btnSubmit_Click: {ex.Message}");
                System.Diagnostics.Debug.WriteLine($"Stack trace: {ex.StackTrace}");
                ShowError($"An error occurred while sending your message: {ex.Message}");
            }
        }

        /// <summary>
        /// Clears all form fields after successful submission
        /// </summary>
        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtSubject.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }

        /// <summary>
        /// Shows error message to user
        /// </summary>
        /// <param name="errorMessage">Error message to display</param>
        private void ShowError(string errorMessage)
        {
            litError.Text = errorMessage;
            pnlError.Visible = true;
        }

        /// <summary>
        /// Gets the client's IP address, handling proxy scenarios
        /// </summary>
        /// <returns>Client IP address</returns>
        private string GetClientIpAddress()
        {
            try
            {
                // Check for IP address from proxy
                string ipAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                if (string.IsNullOrEmpty(ipAddress) || ipAddress.ToLower() == "unknown")
                {
                    ipAddress = Request.ServerVariables["HTTP_X_REAL_IP"];
                }

                if (string.IsNullOrEmpty(ipAddress) || ipAddress.ToLower() == "unknown")
                {
                    ipAddress = Request.ServerVariables["REMOTE_ADDR"];
                }

                if (string.IsNullOrEmpty(ipAddress))
                {
                    ipAddress = Request.UserHostAddress;
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
    }
}