using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyPortfolio
{
    public partial class ViewSwitcher : System.Web.UI.UserControl
    {
        protected string CurrentView { get; private set; }

        protected string AlternateView { get; private set; }

        protected string SwitchUrl { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Simplified view switcher without FriendlyUrls dependency
            // Determine current view based on user agent
            var userAgent = Request.UserAgent ?? "";
            var isMobile = userAgent.Contains("Mobile") || userAgent.Contains("Android") || userAgent.Contains("iPhone");
            
            CurrentView = isMobile ? "Mobile" : "Desktop";
            AlternateView = isMobile ? "Desktop" : "Mobile";
            
            // Simple switch URL (can be enhanced later if needed)
            SwitchUrl = Request.RawUrl;
        }
    }
}