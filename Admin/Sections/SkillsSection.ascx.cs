using System;
using MyPortfolio.Helpers;

namespace MyPortfolio.Admin.Sections
{
    public partial class SkillsSection : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Skills will be loaded via AJAX calls to Dashboard.aspx WebMethods
            // No server-side logic needed here
        }
    }
}