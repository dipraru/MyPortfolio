using System;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class ContactSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Contact section logic - now using AJAX, no server-side form handling needed
        }

        /// <summary>
        /// Gets the location from profile database
        /// </summary>
        /// <returns>Location or default value</returns>
        protected string GetLocation()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Location ?? "Khulna, Bangladesh";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading location: {ex.Message}");
                return "Khulna, Bangladesh";
            }
        }

        /// <summary>
        /// Gets the email from profile database
        /// </summary>
        /// <returns>Email or default value</returns>
        protected string GetEmail()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Email ?? "dipra.datta@example.com";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading email: {ex.Message}");
                return "dipra.datta@example.com";
            }
        }

        /// <summary>
        /// Gets the phone from profile database
        /// </summary>
        /// <returns>Phone or default value</returns>
        protected string GetPhone()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Phone ?? "+880 1XXX-XXXXXX";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading phone: {ex.Message}");
                return "+880 1XXX-XXXXXX";
            }
        }

        /// <summary>
        /// Gets the Codeforces profile URL from profile database
        /// </summary>
        /// <returns>Codeforces URL or default value</returns>
        protected string GetCodeforcesProfile()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.CodeforcesUrl ?? "codeforces.com/profile/dipra_datta";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading Codeforces profile: {ex.Message}");
                return "codeforces.com/profile/dipra_datta";
            }
        }
    }
}