using System;
using System.Web.UI;
using MyPortfolio.Helpers;

namespace MyPortfolio.Sections
{
    public partial class HeroSection : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Hero section loads profile data dynamically
        }

        /// <summary>
        /// Gets the full name from profile database
        /// </summary>
        /// <returns>Full name or default value</returns>
        protected string GetFullName()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.FullName ?? "Dipra Datta";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading profile name: {ex.Message}");
                return "Dipra Datta";
            }
        }

        /// <summary>
        /// Gets the title from profile database
        /// </summary>
        /// <returns>Title or default value</returns>
        protected string GetTitle()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Title ?? "Competitive Programmer";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading profile title: {ex.Message}");
                return "Competitive Programmer";
            }
        }

        /// <summary>
        /// Gets the bio from profile database
        /// </summary>
        /// <returns>Bio or default value</returns>
        protected string GetBio()
        {
            try
            {
                var profile = ProfileHelper.GetActiveProfile();
                return profile?.Bio ?? "BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error loading profile bio: {ex.Message}");
                return "BSc. in CSE at KUET | Algorithm Enthusiast | Problem Solver";
            }
        }
    }
}