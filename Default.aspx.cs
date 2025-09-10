using System;
using System.Web.UI;

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