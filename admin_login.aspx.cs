using System;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio
{
    public partial class admin_login : Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            // Ensure button event is properly wired up
            btnLogin.Click += btnLogin_Click;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle logout with a simple approach
            if (Request.QueryString["logout"] == "true")
            {
                // Just clear session and show message - no complex processing
                if (Session != null)
                {
                    Session.Clear();
                    Session.Abandon();
                }
                
                ShowSuccessMessage("You have been logged out successfully.");
                txtUsername.Focus();
                return; // Stop here completely
            }

            // Regular authentication check (only when NOT logging out)
            if (AuthHelper.IsAuthenticated())
            {
                Response.Redirect("~/Admin/Dashboard.aspx");
                return;
            }

            // Normal page load
            if (!IsPostBack)
            {
                txtUsername.Focus();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                // Always clear any existing session first for clean login
                if (Session != null)
                {
                    Session.Clear();
                }

                // Clear any previous messages
                lblMessage.Visible = false;
                
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Validate input
                if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
                {
                    ShowErrorMessage("Please enter both username and password.");
                    ClientScript.RegisterStartupScript(this.GetType(), "resetBtn", "resetLoginButton();", true);
                    return;
                }

                // Attempt fresh login
                bool loginSuccessful = AuthHelper.Login(username, password);
                
                if (loginSuccessful)
                {
                    // Set remember me functionality if checked
                    if (chkRememberMe.Checked)
                    {
                        Response.Cookies["RememberMe"].Value = "true";
                        Response.Cookies["RememberMe"].Expires = DateTime.Now.AddDays(30);
                    }

                    // Show success and redirect immediately
                    ShowSuccessMessage("Login successful! Redirecting...");
                    
                    // Force immediate redirect
                    Response.Redirect("~/Admin/Dashboard.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    ShowErrorMessage("Invalid username or password. Please check your credentials and try again.");
                    ClientScript.RegisterStartupScript(this.GetType(), "resetBtn", "resetLoginButton();", true);
                    txtPassword.Text = "";
                    txtUsername.Focus();
                }
            }
            catch (Exception ex)
            {
                ShowErrorMessage($"Login error: {ex.Message}");
                ClientScript.RegisterStartupScript(this.GetType(), "resetBtn", "resetLoginButton();", true);
            }
        }

        private void ShowErrorMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "error-message";
            lblMessage.Visible = true;
            lblMessage.Style["display"] = "block";
        }

        private void ShowSuccessMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "success-message";
            lblMessage.Visible = true;
            lblMessage.Style["display"] = "block";
        }
    }
}